#! /bin/bash

if [ $DEBUG ]; then
  set -x
fi

echo "----"
echo "Beginning 1kFA Netlify Build Script"

echo "my pwd is $PWD"
echo "my home is $HOME"
export PATH=$PATH:$PWD/bin

REPODIR=$PWD
BUILDDIR=$PWD/build

if [ $FORCE_REBUILD -eq 1 ]; then
  rm -rf $BUILDDIR
fi
mkdir -p $BUILDDIR
cp -a assets $BUILDDIR/assets
cp -a examples $BUILDDIR/examples
cp -a gm_playtest $BUILDDIR/gm_playtest
cp -a playtest_files $BUILDDIR/playtest_files
cp -a *.html $BUILDDIR/

cd $BUILDDIR
copy_cards.sh $REPODIR
copy_table.sh

source $BUILDDIR/1kfa/resolution_cards/version.py #Get the VERSION variable
cp $REPODIR/dist/$VERSION/*tar.gz $BUILDDIR/playtest_files/

# Scrape git to populate the LATEST_UPDATE section on the home page
cd $BUILDDIR/1kfa
UPDATE=`git log |grep '\[UPDATE\]' | awk '{$1=""; print $0}'`
UPDATE_SPACE_TRIMMED="$(sed -e 's/[[:space:]]*$//' <<<${UPDATE})"
echo "Last update: $UPDATE_SPACE_TRIMMED"
cd $BUILDDIR
sed -i "s/LATEST_UPDATE/$UPDATE_SPACE_TRIMMED/g" index.html


echo "Finished! 1kFA Netlify Build Script"
echo "----"
