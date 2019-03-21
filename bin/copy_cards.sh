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

BUILDDIR=$PWD


if [ -e 1kfa/.git ]
then
  cd 1kfa
  git fetch origin
  git rebase origin/master
  cd $BUILDDIR
else
  rm -rf 1kfa
  git clone https://github.com/sjbrown/1kfa.git
fi

source 1kfa/resolution_cards/version.py
export KFAREPO=$BUILDDIR/1kfa

echo " Copying 1kFA v$VERSION "

cd 1kfa
python bin/build_all.py
cd $BUILDDIR

rm -rf "assets/cards_v$VERSION"
cp -a "/tmp/cards_v$VERSION" assets/
cd "assets/cards_v$VERSION"
find . |grep svg |xargs rm
find . |grep png |sort |awk '{ print "<a href=\"" $1 "\">" $1 "</a><br />" }' > index.html
cd $BUILDDIR

ls /tmp/1kfa_playtest
cp /tmp/1kfa_playtest/*.pdf playtest_files/
cp /tmp/1kfa_playtest/*.html playtest_files/
mv /tmp/1kfa_playtest.tar.gz playtest_files/1kfa_playtest.tgz

echo "Finished!"
echo "---------"


