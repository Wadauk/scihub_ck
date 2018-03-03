#!/bin/bash
# by Wadauk @ https://weibo.com/u/1657589804

cd /home/scihub-ck/Git/scihub_ck

# pull
git pull origin

mkdir web

# check all the domains
perl scihub_ck

# remove the other domains
cd web
yes \
  | rm `ls -l \
  | grep -v 26860 \
  | grep -v total \
  | sed -e "s/.* //"`

# check the speed
for domain in `ls | grep -v .txt`; \
  do \
  echo $domain >> dm.txt; \
  curl -o /dev/null -s -w '%{time_total}\n' "http://sci-hub.$domain" >> sp.txt; \
done;

# combine the result in one file
paste dm.txt sp.txt > data.txt

# sort the domains by speed
sort -k2n data.txt > data2.txt

# creat web by data
cd ..
perl data2index.pl web/data2.txt > index.html

# remove temp files
yes | rm web/*
yes | rm -r web

# upload to github
#git status 
git add index.html 
#git status 
git commit -m "this is my commit info note."
git push origin 
