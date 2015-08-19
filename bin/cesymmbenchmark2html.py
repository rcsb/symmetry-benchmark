#!/usr/bin/python
# -*- coding: utf-8 -*-
"""
Convert the CE-Symm benchmark into html format

@author Spencer Bliven <sbliven@ucsd.edu>
"""

import sys
import os
import optparse
reload(sys)
sys.setdefaultencoding('utf-8')

def genhtml(lines):
    html = u"""<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
    <head>
        <title>CE-Symm Benchmark</title>
        <meta charset="UTF-8"> 
        <style type="text/css">
body {line-height:1.5;font-size:75%;color:#222;background:#eee;font-family:"Helvetica Neue", Arial, Helvetica, sans-serif;}
#maindiv {background:white; width: 720px; padding: 10px; margin: auto;}
h1, h2, h3, h4, h5, h6 {font-weight:normal;color:#111;}
h1 {font-size:3em;line-height:1;margin-bottom:0.5em;}
h2 {font-size:2em;margin-bottom:0.75em;}
h3 {font-size:1.5em;line-height:1;margin-bottom:1em;}
h4 {font-size:1.2em;line-height:1.25;margin-bottom:1.25em;}
h5 {font-size:1em;font-weight:bold;margin-bottom:1.5em;}
h6 {font-size:1em;font-weight:bold;}

table {border-collapse:separate;border-spacing:0; width:100%}
caption, th, td {text-align:left;font-weight:normal;}
table, td, th {vertical-align:middle;}
thead th { background: none repeat scroll 0% 0% #C3D9FF; }
        </style>
    </head>
    <body>
    <div id="maindiv">
        <h1>CE-Symm Benchmark</h1>
        <p>Derived from Supplemental Data File 2 of</p>
<blockquote>
Douglas Myers-Turnbull, Spencer E. Bliven, Peter W. Rose, Zaid K. Aziz, Philippe Youkharibache, Philip E. Bourne, Andreas Prlić, <a href="http://www.sciencedirect.com/science/article/pii/S0022283614001557">Systematic Detection of Internal Symmetry in Proteins Using CE-Symm</a>, <em>Journal of Molecular Biology</em>, Available online 26 March 2014, ISSN 0022-2836, doi:<a href="http://dx.doi.org/10.1016/j.jmb.2014.03.010">10.1016/j.jmb.2014.03.010</a>.
</blockquote>
        <table>
            <thead>
"""
    html += gentablehead(lines[0])
    html +=  """            </thead>
            <tbody>
"""
    for line in lines[1:]:
        html += gentablerow(line)

    html +=  """            </tbody>
        </table>
    </div>
    </body>
</html>
"""
    return html

def gentablehead(line):
    th = line.strip(" \n\r;").split('\t')
    html = "            <tr>"
    html += "".join(["<th>%s</th>"% h for h in th])
    html += "</tr>"
    return html

def gentablerow(line):
    td = line.strip(" \n\r").split('\t')
    td[0] = "<a href=\"http://source.rcsb.org/jfatcatserver/showSymmetry.jsp?name1=%s&matrix=sdm&seqWeight=0.0\">%s</a>" % (td[0],td[0])
    html = "                <tr>"
    html += "".join(["<td>%s</td>"%d for d in td])
    html += "</tr>\n"
    return html

if __name__ == "__main__":

    parser = optparse.OptionParser( usage="usage: python %prog [inputfile]" )
    (options, args) = parser.parse_args()

    if len(args) > 1:
        parser.print_usage()
        parser.exit("Error: Expected 1 arguments, but found %d"%len(args) )

    if len(args) >= 1:
        filename = args[0]
    else:
        # use default benchmark
        path = os.path.dirname(os.path.realpath(__file__))
        filename = os.path.join(path,os.path.pardir,"domain_symm_benchmark.tsv")
        if not os.path.exists(filename):
            parser.exit("Error: no inputfile found")

    with open(filename, 'r') as file:
        lines = file.readlines()

        print(genhtml(lines))
