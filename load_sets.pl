#!/usr/bin/perl

use DBI;

my $dbh = DBI->connect('DBI:mysql:brickable', 'brick', 'l3g0s3ts') or die "Unable to connect to database: $DBI::errstr";

open SETS, "Sets.txt" or die "Cannot find Sets.txt: $!\n";
while (<SETS>) {
	if ($_ !~ /^\d+/) { next; }
	chomp $_;
	my (@parts) = split /\t/, $_;
	#my ($set_id, undef) = split /-/, $parts[2];
	$parts[3] =~ s/'/\\'/g;
	$parts[1] =~ s/'/\\'/g;
	my $query = "INSERT INTO sets (set_number, set_name, set_year, set_weight, set_dimensions, category_id, category_name) ";
	$query .= "VALUES ('$parts[2]', '$parts[3]', '$parts[4]', $parts[5], '$parts[6]', $parts[0], '$parts[1]')";
	my $sth = $dbh->prepare($query);
	$sth->execute();
}
close SETS;
$dbh->disconnect();
