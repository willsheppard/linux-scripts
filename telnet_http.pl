#!/usr/bin/perl

# Test that a port is being used to serve content over HTTP

use strict;
use warnings;

my $usage = "usage: $0 host port\n";

my $host = $ARGV[0] or die $usage;
my $port = $ARGV[1] or die $usage;

use Net::Telnet ();
my $t = new Net::Telnet (
	Port	=> $port,
	Timeout => 5,
);
$t->open($host);

my $print_success = $t->print("GET / HTTP/1.0\n");
print "sent command: $print_success\n";

my @lines = $t->getlines(Timeout => 2);

print @lines;
