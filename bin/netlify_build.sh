#! /bin/bash

echo "----"
echo "Beginning 1kFA Netlify Build Script"

echo "my pwd is $PWD"
echo "my home is $HOME"
pwd

mkdir build
cp -a assets build/assets
cp -a examples build/examples
cp -a gm_playtest build/gm_playtest
cp -a playtest_files build/playtest_files
cp -a *.html build/

cd build
git clone https://github.com/sjbrown/togetherness.git
mv togetherness table

echo "Finished! 1kFA Netlify Build Script"
echo "----"
