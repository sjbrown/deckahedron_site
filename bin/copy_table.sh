#! /bin/bash


set -e

if [ `basename $(pwd)` != "build" ]; then
  echo "You must be in the build directory to run this command"
  exit 1
fi

DESTDIR=table_beta
echo "-----------------------------------------------------"
echo ""
echo " Copying togetherness to ./$DESTDIR"
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

rm -rf $DESTDIR
mv togetherness/src $DESTDIR

sed -i '/<\/head>/i<!-- Global site tag (gtag.js) - Google Analytics -->' $DESTDIR/index.html
sed -i '/<\/head>/i  <script async src="https:\/\/www.googletagmanager.com\/gtag\/js?id=UA-122680475-1"><\/script>' $DESTDIR/index.html
sed -i '/<\/head>/i  <script>' $DESTDIR/index.html
sed -i '/<\/head>/i  window.dataLayer = window.dataLayer || [];' $DESTDIR/index.html
sed -i '/<\/head>/i  function gtag(){dataLayer.push(arguments)}' $DESTDIR/index.html
sed -i '/<\/head>/i  gtag("js", new Date());' $DESTDIR/index.html
sed -i '/<\/head>/i  gtag("config", "UA-122680475-1");' $DESTDIR/index.html
sed -i '/<\/head>/i  <\/script>' $DESTDIR/index.html
sed -i '/<\/head>/i<!-- End Google Analytics -->' $DESTDIR/index.html
sed -i '/<\/head>/i<!-- Plausible -->' $DESTDIR/index.html
sed -i '/<\/head>/i<script async defer data-domain="1kfa.com" src="https:\/\/plausible.io\/js\/plausible.js"><\/script>' $DESTDIR/index.html
sed -i '/<\/head>/i<!-- End Plausible -->' $DESTDIR/index.html



echo "Finished!"
echo "---------"


