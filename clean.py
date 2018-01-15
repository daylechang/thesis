#!/usr/bin/env python

import time, os

#print os.getcwd()
if os.path.exists('main.synctex.gz'):
	#print 'hi'
	os.remove('main.synctex.gz')

if os.path.exists('main.aux'):
	#print 'hi'
	os.remove('main.aux')
