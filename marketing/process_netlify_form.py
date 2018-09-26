#! /usr/bin/python


import sys
import csv


r = csv.DictReader(file(sys.argv[1]))

rows = [x for x in r]

for row in rows:
    print ''
    for attr in r.fieldnames:
    #if '\\r\\n' in r:
        field = row[attr].replace('\\r\\n', '\n')
        print field
    print ''

