[![Build Status](https://travis-ci.org/hipek8/Stock-Stuff.svg?branch=master)](https://travis-ci.org/hipek8/Stock-Stuff)

NAME
====

Stock::Stuff - well it's my homework

SYNOPSIS
========

Install deps with e.g.:

    zef --depsonly install .

To use plot, need to install matplotlib for python2, e.g.:

    pip2 install matplotlib

Run script for given csv file

    perl6 -Ilib/ bin/analyze-single <csv-file>

You might want to plot values between some dates

    perl6 -Ilib/ bin/plot --start='2000-01-01' --stop='2003-01-01' <csv-file>

Check correlation coefficents between 2 companies

    perl6 -Ilib/ bin/correlate <csv-file1> <csv-file2>

AUTHOR
======

Paweł Szulc <pawel_szulc@onet.pl>

COPYRIGHT AND LICENSE
=====================

Copyright 2016 Paweł Szulc

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.
