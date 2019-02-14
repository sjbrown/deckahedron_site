#! /bin/bash


set -e

if [ `basename $(pwd)` != "deckahedron_site" ]; then
  echo "You must be in the deckahedron_site directory to run this command"
  exit 1
fi

source ../1kfa/resolution_cards/version.py

echo "-----------------------------------------------------"
echo ""
echo " Copying cards v$VERSION "
echo ""
echo "-----------------------------------------------------"
echo ""

cp -a "/tmp/cards_v$VERSION" assets/
find "assets/cards_v$VERSION" |grep svg |xargs rm
cd "assets/cards_v$VERSION"
find . |grep png |sort |awk '{ print "<a href=\"" $1 "\">" $1 "</a><br />" }' > index.html


