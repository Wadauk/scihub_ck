#!/usr/bin/perl

use warnings;
use strict;

open LIST, "<list";

my @domains;

while ( <LIST> ) {
	chomp;
	$domains[$.-1] = $_;
}

close LIST;

#print "@domains";

foreach my $domain ( @domains ) {
#	print $domain, "\t";
	my $site = "http://sci-hub.$domain";
	system("curl $site > web/$domain");
}
