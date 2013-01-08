#!/usr/bin/perl

if ($#ARGV < 0) {
	print "Usage: download_set.pl <SET NUMBER>\n";
	exit 0;
}
open SETFILE,">sets/$ARGV[0]" or die "Error opening sets/$ARGV[0]: $!\n";

use WWW::Mechanize;

my $mech = WWW::Mechanize->new();
$mech->get('http://www.bricklink.com/catalogDownload.asp');
$mech->submit_form(
	form_number => 2,
	fields      => {
		viewType	=> '4',
		itemNo		=> $ARGV[0],
		downloadType	=> 'T', 
	}
);

print SETFILE $mech->content;
close SETFILE;
