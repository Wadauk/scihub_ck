#!/bin/bash
# by Wadauk @ https://weibo.com/u/1657589804

cd /home/scihub-ck/Git/scihub_ck

# pull
git pull origin

# check the speed
for domain in `cat list_fast`; \
  do \
  curl -o /dev/null -s -w '%{time_total}\n' "http://sci-hub.$domain" >> sp.txt; \
done;

# combine the result in one file
paste list_fast sp.txt > data.txt

# sort the domains by speed
sort -k2n data.txt > data2.txt

# creat web by data
perl data2index.pl data2.txt > index.html

# remove temp files
yes | rm *.txt 

# upload to github
#git status 
git add index.html 
#git status 
git commit -m "this is my commit info note."
git push origin 
