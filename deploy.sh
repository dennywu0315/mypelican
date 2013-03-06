cd ~/dev/myblog

pelican -s pelicanconf.py content -o myblog 

cd myblog

git add .
git commit -m 'new Article posted by script'
git push

