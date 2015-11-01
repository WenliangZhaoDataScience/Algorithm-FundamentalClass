#! /usr/bin/env bash

cd src
gnatmake progmain.adb
mv progmain ../bin/
cd ..

### run on test dataset 1
echo '\n'
echo Now running test dataset 1
./bin/progmain test_data/test.txt
echo '\n'

### run on test dataset 2
echo Now running test dataset 2
./bin/progmain test_data/test1.txt

### clean repository
rm -f bin/*
rm -f src/*.o
rm -f src/*.ali



