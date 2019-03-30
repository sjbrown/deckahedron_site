#! /bin/bash

echo "----"
echo "Beginning 1kFA Netlify Build Script"

echo "my pwd is $PWD"
echo "my home is $HOME"
export PATH=$PATH:$PWD/bin

if [ $FORCE_REBUILD -eq 1 ]
then
  rm -rf build
fi
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

# Scrape git to populate the LATEST_UPDATE section on the home page
cd 1kfa
UPDATE=`git log |grep '\[UPDATE\]' | awk '{$1=""; print $0}'`
cd ..
sed -i "s/LATEST_UPDATE/$UPDATE/g" index.html


echo "Finished! 1kFA Netlify Build Script"
echo "----"
