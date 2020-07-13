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

if [ -e togetherness/.git ]
then
  cd togetherness
  git status
  git fetch origin master
  git rebase origin/master
  cd ..
else
  rm -rf togetherness
  git clone https://github.com/sjbrown/togetherness.git
fi

rm -rf table
mv togetherness/src table

sed -i '/<\/head>/i<!-- Global site tag (gtag.js) - Google Analytics -->' table/index.html
sed -i '/<\/head>/i  <script async src="https:\/\/www.googletagmanager.com\/gtag\/js?id=UA-122680475-1"><\/script>' table/index.html
sed -i '/<\/head>/i  <script>' table/index.html
sed -i '/<\/head>/i  window.dataLayer = window.dataLayer || [];' table/index.html
sed -i '/<\/head>/i  function gtag(){dataLayer.push(arguments)}' table/index.html
sed -i '/<\/head>/i  gtag("js", new Date());' table/index.html
sed -i '/<\/head>/i  gtag("config", "UA-122680475-1");' table/index.html
sed -i '/<\/head>/i  <\/script>' table/index.html
sed -i '/<\/head>/i<!-- End Google Analytics -->' table/index.html
sed -i '/<\/head>/i<!-- Plausible -->' table/index.html
sed -i '/<\/head>/i<script async defer data-domain="1kfa.com" src="https:\/\/plausible.io\/js\/plausible.js"><\/script>' table/index.html
sed -i '/<\/head>/i<!-- End Plausible -->' table/index.html



echo "Finished!"
echo "---------"


