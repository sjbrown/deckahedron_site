#! /bin/bash


set -e

if [ `basename $(pwd)` != "build" ]; then
  echo "You must be in the build directory to run this command"
  exit 1
fi

echo "-----------------------------------------------------"
echo ""
echo " Copying togetherness to ./table"
echo ""
echo "-----------------------------------------------------"
echo ""


rm -rf togetherness
git clone https://github.com/sjbrown/togetherness.git
rm -rf table
mv togetherness/src table

echo "Finished!"
echo "---------"


