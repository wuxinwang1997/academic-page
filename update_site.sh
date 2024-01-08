git add .
git commit -m "Initial commit"
git push -u origin main --force

hugo
cd public
git add .
git commit -m "Build website"
git push origin master --force
cd ..