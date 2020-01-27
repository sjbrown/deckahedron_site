#! /bin/bash


set -e

if [ `basename $(pwd)` != "build" ]; then
  echo "You must be in the build directory to run this command"
  exit 1
fi

echo "-----------------------------------------------------"
echo ""
echo " Copying 1kfa repo"
echo ""
echo "-----------------------------------------------------"
echo ""

set -x

#sudo apt-get install libreoffice-java-common

REPODIR=$1
grep -q Adventure $REPODIR/README.md
IS_ADVENTURE=$?
if [ $IS_ADVENTURE -eq 0 ]
then
  echo "Repository dir is $REPODIR"
else
  echo "Could not recognize repository dir $REPODIR"
fi

BUILDDIR=$PWD

if [ -e 1kfa/.git ]
then
  cd 1kfa
  git status
  git fetch origin
  git rebase origin/master
  cd $BUILDDIR
else
  rm -rf 1kfa
  git clone https://github.com/sjbrown/1kfa.git
fi

source 1kfa/resolution_cards/version.py # Get the VERSION variable
export KFAREPO=$BUILDDIR/1kfa

echo " Copying 1kFA version $VERSION"

cp $REPODIR/dist/$VERSION/1kfa_playtest.tar.gz ./
tar -xvzf 1kfa_playtest.tar.gz
cp 1kfa_playtest/1kfa_guide_*.* playtest_files/
cp 1kfa_playtest.tar.gz playtest_files/1kfa_playtest.tgz

rm -rf "assets/cards_v$VERSION"
cp $REPODIR/dist/$VERSION/cards_v$VERSION.tar.gz ./
tar -xvzf cards_v$VERSION.tar.gz
cp -a cards_v$VERSION ./assets/cards_v$VERSION
cd "assets/cards_v$VERSION"

echo '<html><head><style>' > index.html
echo '</style></head><body>' >> index.html
echo '<h1><a href="booklet">Booklet pages</a></h1>' >> index.html
echo '<h1><a href="moves">Move cards</a></h1>' >> index.html
echo '<h1><a href="items">Item cards</a></h1>' >> index.html


mkdir -p booklet
echo '<html><head><style>' > booklet/index.html
echo 'a { margin: 20px; display: inline-block; max-width: 128px; overflow-wrap: break-word; }' >> booklet/index.html
echo 'img { max-width: 128px; }' >> booklet/index.html
echo '</style></head><body>' >> booklet/index.html
find . |grep booklet |grep png |sort |awk '{ print "<a href=\"../" $1 "\"><img src=\"" $1 "\"> " $1 "</a>" }' >> booklet/index.html

mkdir -p items
echo '<html><head><style>' > items/index.html
echo 'a { margin: 20px; display: inline-block; max-width: 128px; overflow-wrap: break-word; }' >> items/index.html
echo 'img { max-width: 128px; }' >> items/index.html
echo '</style></head><body>' >> items/index.html
find . |grep mundane_deck |grep png |sort |awk '{ print "<a href=\"../" $1 "\"><img src=\"" $1 "\"> " $1 "</a>" }' >> items/index.html
find . |grep magic_deck |grep png |sort |awk '{ print "<a href=\"../" $1 "\"><img src=\"" $1 "\"> " $1 "</a>" }' >> items/index.html

mkdir -p moves
echo '<html><head><style>' > moves/index.html
echo 'a { margin: 20px; display: inline-block; max-width: 128px; overflow-wrap: break-word; }' >> moves/index.html
echo 'img { max-width: 128px; }' >> moves/index.html
echo '</style></head><body>' >> moves/index.html
find . |grep starter |grep png |sort |awk '{ print "<a href=\"../" $1 "\"><img src=\"" $1 "\"> " $1 "</a>" }' >> moves/index.html
find . |grep move_deck |grep png |sort |awk '{ print "<a href=\"../" $1 "\"><img src=\"" $1 "\"> " $1 "</a>" }' >> moves/index.html

cd $BUILDDIR


echo "Finished!"
echo "---------"


