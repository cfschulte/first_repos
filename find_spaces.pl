#!/usr/bin/perl
# find_spaces.pl:  Mon Mar 24 10:05:10 CDT 2014
# Finds files and directories with leading or trailing whitespace on Mac OSX.
# This takes a start path (usually the user's home directory) and descends
# hierarchically.

use strict;

my $dir;
if ( $#ARGV < 0 ) {  # use the directory that the script is located in
	$dir = `pwd`;
} else { # use the directory given on the command line
	$dir = $ARGV[0];
}

chomp $dir;
if( -d $dir ) {
print "   Starting directory = $dir \n";
check_ws($dir);
} else {
	print "No such directory: $dir\n Be sure to use an absolute path and that the spelling is correct";
}

exit;



sub check_ws {
 	my $subdir = shift;
 	if( ! -d $subdir ) {
#  		print "$subdir not a directory\n";
 		return;
 	} # else {
#  		print "   -- testing $subdir\n";
#  	}
 	
	my @files = split /\n/, `ls "$subdir"`;

	foreach my $file (@files) {
		next if $file =~ m/^\./ || $file eq '.' || $file =~ /\$/ || $file eq "Library" ;
# 		next if $file =~ m/^\./ || $file eq '.' || $file =~ /\$/ || $file eq "Library" || $file =~ /VMWare/ || $file =~ /Microsoft/;  - I used this in the /Users/Share directory 
		
# 		print "$file \n";
		if( $file =~ m/\s+$/ ){
			print "trailing whitespace****: $subdir/$file\n";
		}
	
		if( $file =~ m/^\s+/ ){
			print "****leading whitespace: $file\n";
		}
		
		if( -d $subdir . '/' . $file ) {
			my $nxtdir = $subdir . '/' . $file;
# 			print "next directory = $nxtdir\n";
			check_ws($nxtdir);
		}
	}
	`cd ..`;
}
