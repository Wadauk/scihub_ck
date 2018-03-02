#!/bin/bash
# by Wadauk @ https://weibo.com/u/1657589804

# pull
print "scihub_ck v1.0.3\n(C) Copyright 2018-01 Wadauk, all rights reserved.\nhttps://weibo.com/u/1657589804\nGithub:\tWadauk\n\n";
print "\rGit pull:\tPULLING";
print "\r         \t       ";
git pull origin
print "\rGit pull:\tDONE\n"; 

# check all the domains
perl scihub_ck

# remove the other domains
print "\rFilte domains:\tFilting";
print "\r              \t       ";
cd web
yes \
  | rm `ls -l \
  | grep -v 26860 \
  | grep -v total \
  | sed -e "s/.* //"`
print "\rFilte domains:\tDONE\n";

# check the speed
print "\rCheck speed:\tChecking";
print "\r            \t        ";
for domain in `ls | grep -v .txt`; \
  do \
  echo $domain >> dm.txt; \
  curl -o /dev/null -s -w '%{time_total}\n' "http://sci-hub.$domain" >> sp.txt; \
done;
print "\rCheck speed:\tDONE\n";

print "\rCreat web:\tCreating";
print "\r          \t        ";
# combine the result in one file
paste dm.txt sp.txt > data.txt

# sort the domains by speed
sort -k2n data.txt > data2.txt

# creat web by data
cd ..
perl /home/pi/data2index.pl web/data2.txt > index.html

print "\rCreat web:\tDONE\n";

# remove temp files
print "\rClean temporary files:\tCleaning";
print "\r                      \t        ";
yes | rm web/*
print "\rClean temporary files:\tDONE\n";

# upload to github
#git status 
print "\rGit add web file:\tAdding";
print "\r                 \t      ";
git add index.html 
print "\rGit add web file:\tDONE\n";

#git status 
print "\rGit add comment:\tAdding";
print "\r                \t      ";
git commit -m "this is my commit info note."
print "\rGit add comment:\tDONE";
print "\rGit push update:\tPushing";
print "\r                \t       ";
git push origin 
print "\rGit push update:\tDONE\n";
