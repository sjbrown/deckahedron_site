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

bin/install_deps.sh

docker run -it --rm ubuntu "echo hello"

cd build
export DEBUG=0
copy_table.sh
copy_cards.sh

echo "Finished! 1kFA Netlify Build Script"
echo "----"
