#!/usr/bin/env python
########
#
#  Pwned Company Directory Checker
#  
#  Authors: @vimk1ng
#           @m1ndfl4y
#
#http status codes 
# 401 Unauthorised;
# 403 Forbidden; 
# 404 Not found; Email not found in breach database
# 429 Too many requests; 
# 503 Service unavailable
#
#A config file containing your API key needs to be held in the same folder as pcdc.py
#config.py
# apikey = "YOUR_API_KEY"
#
########
import requests
import sys
from time import sleep
from os import path
from config import apikey

#Colors
cRedB = "\033[1;31m"
cRedD = "\033[0;31m"
cYellowB = "\033[1;33m"
cYellowD = "\033[0;33m"
cGreenB = "\033[1;32m"
cGreenD = "\033[0;32m"
cWhite = "\033[1;37m"
cCyan = "\033[1;36m"
cReset = "\033[0m"

if len(sys.argv) != 2:
    print "Invalid argument count"
    exit()

filepath = sys.argv[1]

if not path.exists(filepath):
    print "Specified file does not exist"
    exit()

#create headers for request to HIBP APIv3 initial requests. A user-agent is required.
headers = {
    'user-agent': 'PCDC',
}
#pull all breach data as a json and put in into an array
breachdata = requests.get('https://haveibeenpwned.com/api/v3/breaches', headers=headers)

#create headers for request to HIBP APIv3
headers = {
    'user-agent': 'PCDC',
    'hibp-api-key': apikey,
}

with open(filepath) as fp:
    for cnt, line in enumerate(fp):
        sleep(1.6)
        url = 'https://haveibeenpwned.com/api/v3/breachedaccount/' + line.rstrip()
        response = requests.get(url, headers=headers)
        if response.status_code == 200:
            print cRedB + line.rstrip() + cReset
            for breach in response.json():
                data = [bdata for bdata in breachdata.json() if bdata["Name"] == breach["Name"]][0]
                print ("\t" + cCyan + "{} " + cWhite + "- {}" + cReset).format(data["Name"], data["BreachDate"])
                for dataclass in data["DataClasses"]:
                    if "assword" in dataclass:
                        dcColor = cRedD
                    else:
                        dcColor = cYellowD
                    print dcColor + "\t\t{}".format(dataclass) + cReset
        #elif response.status_code == 404:
        else:
            print cGreenD + line.rstrip() + " - " + cWhite + str(response.status_code) + cReset

#email
#    name - breachdate
#        dataclasses
#    breach name - date
#        dataclasses