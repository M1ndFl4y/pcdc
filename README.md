# This project is being updated.

As per the new API restrictions it's no longer possible to do this for free. https://www.troyhunt.com/authentication-and-the-have-i-been-pwned-api/ The PCDC tool is being reworked for those who want to use this code and pay for their own AIP key.

# PCDC (Pwned Company Directory Checker)

Originally a bash script, PCDC has been updated into a python script and configured to work with the https://haveibeenpwned.com/API/v3. It provides a readable CLI output. 

## Install

Clone the repository.
```
git clone https://github.com/M1ndFl4y/pcdc.git
```
Change the premissions of pcdc.py to run for you.

```
chmod +x pcdc.py
```

## How to use

Replace the list of targets in the sample targets.txt file with the group of emails you want to check.
Then run the script.

```
./pcdc.py targets.txt
```
![run sample](https://user-images.githubusercontent.com/33877442/67160070-7afef180-f312-11e9-8550-27ff23d2641f.jpg)

## Credits
- [vimk1ng](https://twitter.com/vimk1ng)
- [M1ndFl4y](https://twitter.com/M1ndFl4y)

## Acknowledgments

* Troy Hunt
    -This script is junk without his amazing work and the HIBP site.  https://haveibeenpwned.com/About
