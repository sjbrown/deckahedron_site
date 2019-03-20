#! /bin/bash

echo "Beginning 1kFA Netlify Build Script"

echo "my pwd is $PWD"
echo "my home is $HOME"
pwd
git clone https://github.com/sjbrown/togetherness.git
mv togetherness table

echo "Finished! 1kFA Netlify Build Script"
