#!/usr/bin/perl

use warnings;
use strict;

my $num_domain = `wc -l $ARGV[0]`;
$num_domain=~s/(\d+).*$/$1/;
#print $num_domain;
print '
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name=""viewport" content="width=device-width, initial-scale=1.0">
<title>Scihub_ck</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/semantic-ui/2.2.4/semantic.min.css">
<link rel="stylesheet" href="./static/css/me.css">
</head>
<body>

<nav class="ui inverted attached segment m-padded-tb-mini">
<div class="ui container">
<div class="ui inverted secondary stackable menu">
<h2 class="ui teal header item">Scihub_ck</h2>
</div>
</div>
</nav>
<br>
<br>
<div class="m-container m-padded-tb-big">
<div class="ui container">
<div class="ui stackable grid">
<div class="fifteen wide column">
<div class="ui top attached segment">
<div class="ui middle aligned two column grid">
<div class="column">
<h3 class="ui teal header">Working Domains</h3>
</div>
<div class="right aligned column">
<h2 class="ui orange header m-inline-block m-text-thin"> ';
print $num_domain;
print '	</h2>
</div>
</div>
</div>

<div class="ui attached segment">
';
my $domain;
my $total_time;
open DATA, "<$ARGV[0]";
#open INDEX, ">$ARGV[1]";

while ( <DATA> ) {
chomp;
( $domain, $total_time ) = /^(.*?)\t(.*)$/;
#	print $domain, $total_time;
print '<div class="ui padded vertical segment m-padded-tb-big">
<div class="ui mobile grid">
<div class="eleven wide column">
<h3 class="ui header">';
print $domain;
print '</h3>
<a href="http://www.sci-hub.';
print $domain;
print '" target="_blank">
<p class="m-text">sci-hub.';
print $domain;
print '</p>
</a>
</div>

<div class="five wide column">
<p class="m-text">';
print $total_time;
print ' s</p>
</div>
</div>
</div>';

}

#close INDEX;
close DATA;

print '</div>
</div>
</div>
</div>
</div>

<br>
<br>

<footer class="ui inverted vertical segment m-padded-tb-massive">
<div class="ui center aligned container">
<p class="m-text-thin m-text-spaced m-opacity-tiny">';
print `date`;
print '<br>Copyright c 2017 - 2018 Scihub_ck Designed by Wadauk</p>
</div>
</footer>

</body>
</html>';
