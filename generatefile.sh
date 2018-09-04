#!/bin/bash

target='/home/angg/code/mca209lab'

cd $target

find . -maxdepth 1 -type f -name '*.cpp' | while read CPPFILE
do
    TITLE=$(basename $CPPFILE .cpp)
    g++ $TITLE.cpp 
    enscript $CPPFILE --color=1 -C -Ecpp -B -t $TITLE -o - | ps2pdf - $TITLE.pdf
    ./a.out > $TITLE.txt && enscript -B $TITLE.txt -o - | ps2pdf - $TITLE.output.pdf
    pdftk $TITLE.pdf $TITLE.output.pdf cat output $TITLE.final.pdf
    rm $TITLE.output.pdf
    rm $TITLE.pdf
done

today=`date +%j-%H-%M`
mkdir $today

pdftk *.pdf cat output $today.pdf

mv *.pdf ./file
mv *.cpp ./$today

rm *.txt 

cd './file'
rm *.final.pdf
