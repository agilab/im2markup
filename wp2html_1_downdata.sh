#!/bin/bash

wget -P data/ http://lstm.seas.harvard.edu/latex/html/data/html_64_64_100k.tgz
cd data; 
tar zxf html_64_64_100k.tgz; 
cd ..
