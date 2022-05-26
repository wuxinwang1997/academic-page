git add .
git commit -m "Initial commit"
git push -u origin main

hugo
cd public
git add .
git commit -m "Build website"
git push -f origin master
cd ..