#! /bin/bash


set -e

if [ `basename $(pwd)` != "deckahedron_site" ]; then
  echo "You must be in the deckahedron_site directory to run this command"
  exit 1
fi

echo "-----------------------------------------------------"
echo ""
echo " Copying ../togetherness/src/ to ./table"
echo ""
echo "-----------------------------------------------------"
echo ""

cp -a ../togetherness/src/. table/


