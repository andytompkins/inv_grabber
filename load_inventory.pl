#!/usr/bin/perl

if ($#ARGV < 0) {
	print "Usage: load_inventory.pl <SET NUMBER>\n";
	exit 0;
}

use DBI;

my $dbh = DBI->connect('DBI:mysql:brickable', 'brick', 'l3g0s3ts') or die "Unable to connect to database: $DBI::errstr";


open SETINV, "sets/$ARGV[0]" or die "Cannot find sets/$ARGV[0]: $!\n";
my $header = 0;
while (<SETINV>) {
	if ($header < 2) { $header++; next; }
	chomp $_;
	my (@parts) = split /\t/, $_;
	$parts[2] =~ s/'/\\'/g;
	my $query = "INSERT INTO inventories (set_number, part_type, part_number, part_name, quantity, color_id, extra, alternate, match_id, counterpart) ";
	$query .= "VALUES ('$ARGV[0]', '$parts[0]', '$parts[1]', '$parts[2]', $parts[3], $parts[4], '$parts[5]', '$parts[6]', $parts[7], '$parts[8]')";
	my $sth = $dbh->prepare($query);
	$sth->execute();
}
close SETINV;
$dbh->disconnect();
