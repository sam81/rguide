#! /usr/bin/env python
# -*- coding: utf-8 -*-

import getopt, datetime, os, subprocess, sys
#os.chdir('../')

def main(argv):
    try:
        opts, args = getopt.getopt(argv, "m:", ["message="])
    except getopt.GetoptError:
        sys.exit(2)
    for opt, arg in opts:
        if opt in ("-m", "--message"):
            message = arg
    major_v = 0
    minor_v = 4

    #read minor minor release number
    f = open('minor_minor_number.txt', 'r')
    ln = f.readlines()
    f.close()
    minor_minor_v = int(ln[0].strip()) + 1
    #write incremented minor minor release number
    f = open('minor_minor_number.txt', 'w')
    f.write(str(minor_minor_v))
    f.close()
    builddate = datetime.datetime.now().strftime("%d-%b-%Y %H:%M")
    #set git tag
    gittag = str(major_v) + '.' + str(minor_v) + '.' + str(minor_minor_v)
    
    f = open('00_preface.Rmd', 'r')
    ln = f.readlines()
    f.close()
    for i in range(len(ln)):
        if ln[i].strip().split(':')[0].strip() == "subtitle":
            ln[i] = 'subtitle: "' + gittag +'"\n'

    f = open('00_preface.Rmd', 'w')
    f.writelines(ln)
    f.close()
 
    subprocess.call('git commit -a -m"' + message+'"', shell=True)
    #tag the commit so that it can be easily retrieved
    subprocess.call('git tag -a "' + gittag +'"' + ' -m "' + gittag +'"', shell=True)
    
if __name__ == "__main__":
    main(sys.argv[1:])
