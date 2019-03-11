# PCDC (Pwned Company Directory Checker)

This bash script was designed to check a list of company emails aganst the https://haveibeenpwned.com/API/v2.  It provides a readable CLI output and, if needed, a CSV output.

## Install

Clone the repository.
```
git clone https://github.com/M1ndFl4y/pcdc.git
```
Change the premissions of pcdc.sh to run for you.

```
chmod +x pcdc.sh
```

## How to use

Replace the list of targets in the sample targets.txt file with the group of emails you want to check.
Then run the script.

```
./pcdc.sh
```
![run sample](https://user-images.githubusercontent.com/33877442/54125356-c6dbd680-43d2-11e9-9164-ddcfd8da2aa6.JPG)

or with logging
```
./pcdc.sh -l
```
The -l option generates a CSV file.
![sample log](https://user-images.githubusercontent.com/33877442/54125514-3651c600-43d3-11e9-987d-df658be10647.JPG)

## Acknowledgments

* Troy Hunt
    -This script is junk without his amazing work and the HIBP site.  https://haveibeenpwned.com/About
