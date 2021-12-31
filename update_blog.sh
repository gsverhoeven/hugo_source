#!/bin/bash

# NOTE TO SELF: ARGUMENT $1 DOES NOT WORK CHECK COMMITS ON GITHUB

# first step walk through build_site.R to preview and refine post

# final contents ready in /public? then proceed

echo 'cleanup: remove rds files'
rm --force public/post/bart_vs_grf/*.rds
rm -R --force public/post/fumbbl_blogpost_src
rm -Rf ../gsverhoeven.github.io2

echo 'create new site locally'
cp -r public ../new_site_version

echo 'copy git folder'
cp -r ../gsverhoeven.github.io/.git/ ../new_site_version/.git/

echo 'remove old site locally'
#rm -R --force ../gsverhoeven.github.io

echo 'rename new site dir'
mv ../new_site_version ../gsverhoeven.github.io2

if [ $# -eq 1 ]
  then
    	echo 'commit changes to remote github repo'
	cd ../gsverhoeven.github.io2
	git add .
	git commit -am '$1'
	git push
fi

#Username for 'https://github.com': gsverhoeven
#Password for 'https://gsverhoeven@github.com': PLAK hier het PAT uit Keepass

