# PCDC (Pwned Company Directory Checker)

This bash script was designed to check a list of company emails aganst the https://haveibeenpwned.com/API/v2.  It provides a readable CLI output and, if needed, a CSV output.

## Install

Clone the repository.
```

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


or with logging
```
./pcdc.sh -l
```
The -l option generates a CSV file.


## Acknowledgments

* Troy Hunt
    -This script is junk without his amazing work and the HIBP site.  https://haveibeenpwned.com/About
