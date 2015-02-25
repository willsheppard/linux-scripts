#!/usr/bin/perl

# Create a graphviz spec file from a set of status tables and transitions.
#
# Run graphviz on the output of this script, to produce a graph:
#   dot -Tjpg -odiagram.jpg spec.dot

use lib 'lib';

use Your::Own::DBIC::Foo;
use DBI;

my $dsn = "dbi:Pg:dbname=lalala";
my $dbh = DBI->connect($dsn, 'postgres', '');

my $fi = Your::Own::DBIC::Foo->new;

# read statuses and transitions from database
my $statuses = $dbh->selectall_hashref("SELECT id, status, name FROM fulfilment_item_status", "id");
my $transes = $dbh->selectall_hashref("SELECT id, transition, name FROM fulfilment_item_transition", "id");

# DEBUG
#warn "statuses = ".p($statuses);
#die "trans = ".p($transes);

print <<EOM;
digraph G {
    // graph properties
//    graph [rankdir="LR"]

    // title
    labelloc="t"
    label="Fulfilment Item Status Transitions"

    // nodes, edges, subgraphs
EOM

foreach my $status_id (keys %{$fi->state_transition}) {
    my $status_name = $statuses->{$status_id}{status};
    my $status_label = $statuses->{$status_id}{name};

    # state:
    print "    $status_name [label=\"$status_label\"]\n";

    print "\n";

    foreach my $trans_id (keys %{$fi->state_transition->{$status_id}}) {
        my $trans_name = $transes->{$trans_id}{transition};
        my $trans_label = $transes->{$trans_id}{name};

        my $end_status_id = $fi->state_transition->{$status_id}{$trans_id};
        my $end_status_name = $statuses->{$end_status_id}{status};
        my $end_status_label  = $statuses->{$end_status_id}{name};

        # transition:
        print "    $status_name -> $end_status_name [label=\"$trans_label\"]\n";
    }
}

print "}";

