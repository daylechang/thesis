#!/usr/bin/env python

with open('library.bib', 'r') as readFile:
	readArray = readFile.readlines()

writeArray = []
for line in readArray:
	#print line

	if 'month' in line:
		#print 
		#preline = line.split('=')
		month = line.split('=')[-1].strip().split(',')[0].split('}')[0].split('{')[-1]
		#print 'month = '+month+','
		writeArray.append('month = '+month+',\n')

	elif 'abstract' in line:
		continue
	else:
		writeArray.append(line)

with open('references.bib', 'w') as writeFile:
	for line in writeArray:
		writeFile.write(line)
	#print line.strip()

