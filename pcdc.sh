#!/bin/bash
# PCDC v1.02
# Made by M1ndFl4y
# Use this script ethically
#
# Set delay, minimum recommended value of 2.  Anything below 1.5 will cause type 1 errors!!  Take jitter into account when selecting delay.
delay="2"
# Time stamp for logging
timestamp() {
date +"%Y-%m-%d_%H-%M-%S"
}
# Who doesn't like pretty colors...
r="\e[31m"
g="\e[32m"
c="\e[36m"
w="\e[0m"
s=" "
# Prep array, file, and log variable
logarray=()
file=./targets.txt
log="$1"
# For those who know... and those who will try to find out
echo -e $g$s"_____ _____"$w
echo -e $g$s"___________"$w
echo -e $g$s"___________"$w
echo -e $g$s"___________"$w
echo -e $g$s"_____ _____"$w
echo -e $g$s"_____ _____"$w
echo ""
echo -e  $c"Starting Pwned Company Directory Checker"$w
# Check for the targets.txt file and kill script if it's not there
if [ ! -f "$file" ]; then
	echo -e $r"targets.txt file was not found..."$w
	exit
else
# Set up counter for total number of targets
	count=$(wc -l targets.txt |cut -d " " -f 1);
fi 
# Check for the -l input and act accordingly
if [[ $log == '-l' ]]; then
	echo -e $c"Logging enabled"$w
else
	echo -e $c"Logging disabled... To enable logging use ./pcdc.sh -l"$w
fi
# Pull latest dataclasses from the site.  These will be used to flag what data is exposed
echo -e $c"\nUpdating dataclasses"$w
dataclasses=$(curl --silent -A "Pwned-Company-Directory-Checker-v1.02" https://haveibeenpwned.com/api/v2/dataclasses);
IFS=',' read -r -a d <<< "$dataclasses"
# Check the dataclesses pulled and use this to validate access to HIBP APIv2
        if [ -z "$dataclasses" ]; then
		echo -e $r"Dataclasses not pupulated... check your internet connection."$w
        	exit
	else
		# Uncomment the line below to echo the dataclasses pulled
		#echo -e $w${d[*]}$w
		echo -e $c"Dataclasses updated"$w
	fi
# Check targets.txt file, coantaining emails, line by line aganst HIBP
echo -e $c"\nChecking accounts"$w
for target in $(cat targets.txt);do
# Target counter
	i=$((i+1))
	sleep $delay
	breach=$(curl --silent -A "Pwned-Company-Directory-Checker-v1.02" https://haveibeenpwned.com/api/v2/breachedaccount/$target);
# If no breach is detected echo the target checked as green
# If logging is enabled enter the clean check into the log
	if [ -z "$breach" ]; then
		echo -e $g$target$w"\t"$i" / "$count
		if [[ $log == '-l' ]]; then
			logarray+=($target)
			logarray+=($(timestamp))
			logarray+=("Not Breached")
			printf '%s,' "${logarray[@]}" >>log.csv
			echo " " >>log.csv
			logarray=()
		fi
# If a breach is found echo the target in red
# Clean the data and echo important breach information into the CLI
# If logging is enabled log all into a CSV output
	else
		# Breached target counter
		bcount=$((bcount+1))
		echo -e $r$target$w"\t"$i" / "$count
		read -a arr <<< $breach
		IFS=',' read -r -a a <<< "$breach"
		for e in "${a[@]}"; do
			if [[ $e == *'{"Name"'* ]]; then
				cleanname=${e[@]//"{"/}; cleanname=${cleanname//"\""/ }; cleanname=${cleanname// /}; cleanname=${cleanname//[/}
				echo -e "	"$c$cleanname$w
			fi
			if [[ $e == *'"BreachDate":'* ]]; then
				cleandate=${e[@]//\"/ }; cleandate=${cleandate// /}
				echo -e "	"$c$cleandate$w
				echo -e "	"$c"Data exposed for this account"$w
				if [[ $log == '-l' ]]; then
					logarray+=($target)
					logarray+=($(timestamp))
					logarray+=($cleanname)
					logarray+=($cleandate)
				fi
			fi
			for dc in "${d[@]}"; do
				if [[ $e = *$dc* ]]; then
					dc=${dc[@]//"["/};dc=${dc[@]//"]"/};dc=${dc[@]//"\""/};
					echo -e "		"$r$dc$w
					dc=${dc[@]//" "/_};
					if [[ $log == '-l' ]]; then
						logarray+=($dc)
					fi
				fi
			done
			if [[ $log == '-l' ]]; then
				if [[ $e == '{"Name":'* ]]; then
					printf '%s,' "${logarray[@]}" >>log.csv
					echo " " >>log.csv
					logarray=()
				fi
				if [[ $e == *'}]'* ]]; then
					printf '%s,' "${logarray[@]}" >>log.csv
					echo " " >>log.csv
					logarray=()
				fi
			fi
		done
	fi
done
# end with a summary containing the number of breached accounts in the targets list
echo -e $c"Summary\nBreached accounts: "$r$bcount$w" / "$count
