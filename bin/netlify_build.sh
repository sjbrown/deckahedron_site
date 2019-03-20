#! /bin/bash

echo "----"
echo "Beginning 1kFA Netlify Build Script"

echo "my pwd is $PWD"
echo "my home is $HOME"
export PATH=$PATH:$PWD/bin

mkdir -p build
cp -a assets build/assets
cp -a examples build/examples
cp -a gm_playtest build/gm_playtest
cp -a playtest_files build/playtest_files
cp -a *.html build/

mkdir -p build/testo
echo "<h1>hello</h1>" > build/testo/index.html

cd build
copy_table.sh

echo "Finished! 1kFA Netlify Build Script"
echo "----"
