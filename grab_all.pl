#!/usr/bin/perl

$| = 1;

use DBI;

my $dbh = DBI->connect('DBI:mysql:brickable', 'brick', 'l3g0s3ts') or die "Unable to connect to database: $DBI::errstr";

my $query = "select distinct set_number from sets"; 
my $sth = $dbh->prepare($query);
$sth->execute();
while (my @res = $sth->fetchrow_array()) {
	print "Grabbing $res[0] ... ";
	`./download_set.pl $res[0]`;
	print "done.\n";
	print "Loading $res[0] ... ";
	`./load_inventory.pl $res[0]`;
	print "done.\n";
}

$dbh->disconnect();
