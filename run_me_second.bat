REM adjust these to your local situation

$LOCATION_PUBLIC_SITE = ..\\gsverhoeven.github.io
$LOCATION_HUGO_SOURCE = .
$GIT_REMOTE_ALIAS = origin

rem commit and push your changes to the website
cd $LOCATION_HUGO_SOURCE
git commit -m "my commit message here"
git push $GIT_REMOTE_ALIAS master

rem remove previously generated public
cd $LOCATION_PUBLIC_SITE
cd ..
rmdir /s $LOCATION_PUBLIC_SITE

rem copy newly generated public
copy $LOCATION_HUGO_SOURCE\\public\\* $LOCATION_PUBLIC_SITE

rem commit and push the new public version
cd $LOCATION_PUBLIC_SITE
git commit -m "my commit message here"
git push $GIT_REMOTE_ALIAS master