#!/usr/local/bin/python

import sys
import webbrowser
import re

def openUrlFromLine(line):
    url_pattern = re.compile('file:\/{2}[^ ]+', re.IGNORECASE)
    m = url_pattern.search(line)
    if m:
        url = m.group()
        print "Opening File: " + url
        webbrowser.open(url)

while True:
    line = raw_input().strip()
    openUrlFromLine(line)
    sys.stdout.flush()

