#! /bin/bash


set -e

if [ `basename $(pwd)` != "build" ]; then
  echo "You must be in the build directory to run this command"
  exit 1
fi

DESTDIR=table
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
  git fetch origin beta
  git rebase origin/master
  cd ..
else
  rm -rf togetherness
  git clone https://github.com/sjbrown/togetherness.git
fi

rm -rf $DESTDIR
cp -a togetherness/src $DESTDIR

sed -i '/<\/head>/i<!-- Global site tag (gtag.js) - Google Analytics -->' $DESTDIR/index.html
sed -i '/<\/head>/i  <script async src="https:\/\/www.googletagmanager.com\/gtag\/js?id=UA-122680475-1"><\/script>' $DESTDIR/index.html
sed -i '/<\/head>/i  <script>' $DESTDIR/index.html
sed -i '/<\/head>/i  window.dataLayer = window.dataLayer || [];' $DESTDIR/index.html
sed -i '/<\/head>/i  function gtag(){dataLayer.push(arguments)}' $DESTDIR/index.html
sed -i '/<\/head>/i  gtag("js", new Date());' $DESTDIR/index.html
sed -i '/<\/head>/i  gtag("config", "UA-122680475-1");' $DESTDIR/index.html
sed -i '/<\/head>/i  <\/script>' $DESTDIR/index.html
sed -i '/<\/head>/i<!-- End Google Analytics -->' $DESTDIR/index.html
sed -i '/<\/head>/i<!-- Cloudflare -->' $DESTDIR/index.html
sed -i '/<\/head>/i  <script defer' $DESTDIR/index.html
sed -i '/<\/head>/i  src="https://static.cloudflareinsights.com/beacon.min.js"' $DESTDIR/index.html
sed -i '/<\/head>/i  data-cf-beacon=\'{"token": "ad4bc0439a524824ac7ccf972f3a286b"}\'' $DESTDIR/index.html
sed -i '/<\/head>/i  ></script>' $DESTDIR/index.html
sed -i '/<\/head>/i<!-- End Cloudflare -->' $DESTDIR/index.html


cd togetherness
git checkout beta
cd ..

DESTDIR=table_beta
rm -rf $DESTDIR
cp -a togetherness/src $DESTDIR


echo "Finished!"
echo "---------"


