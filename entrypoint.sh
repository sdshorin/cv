#!/bin/bash



echo "-----"
ls working_dir
echo "-----"
echo "Endpoint here!"

# echo "test CV" > working_dir/CV.pdf

apt-get install texlive

pdflatex --output-directory=./working_dir CV.tex



echo "-----"
ls working_dir
echo "-----"

