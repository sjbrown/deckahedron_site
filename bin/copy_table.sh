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

cat <<EOF > /tmp/analytics.txt
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-122680475-1"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments)}
  gtag("js", new Date());
  gtag("config", "UA-122680475-1");
</script>
<!-- End Google Analytics -->
<!-- Cloudflare -->
  <script defer
  src="https://static.cloudflareinsights.com/beacon.min.js"
  data-cf-beacon='{"token": "ad4bc0439a524824ac7ccf972f3a286b"}'
  ></script>
<!-- End Cloudflare -->
EOF

# Insert the analytics code into the index.html file right before </head>
sed -i -e '/<\/head>/r /tmp/analytics.txt' -e 'x;$G' $DESTDIR/index.html


cd togetherness
git checkout beta
cd ..

DESTDIR=table_beta
rm -rf $DESTDIR
cp -a togetherness/src $DESTDIR


echo "Finished!"
echo "---------"


