#!/usr/bin/env perl

# Fetch Pull Requests from Atlassian Stash / Bitbucket

use JSON;

$ENV{PERL_LWP_SSL_VERIFY_HOSTNAME} = 0;

my $url_template = 'https://stash.example.com/rest/api/1.0/projects/%s/repos/%s/pull-requests';

my $json = JSON->new;

my $name = 'Your Username';
my $user = 'f.last';
my $pass = $ENV{PW} or die "no encoded password found"; $pass =~ y/A-Za-z/N-ZA-Mn-za-m/;

my $found = 0;
foreach my $item (
    [ qw/PROJECT_HERE repo_name_here / ],
) {
    my ($proj, $repo) = ( $item->[0], $item->[1] );

    my $url = sprintf($url_template, $proj, $repo);
    my $content = get_json_from_url( $json, $url );

    if ($content->{errors}) {
        use Data::Dumper;
        die Dumper($content);
    }

    foreach my $value (@{ $content->{values} }) {
        next if ! grep { $_->{user}{displayName} eq $name } @{ $value->{reviewers} };

        print (("-") x 80); print "\n";
        print "Repo: $url\n";
        print "Summary: ".$value->{title} . "\n";
        print "Author: ".$value->{author}{user}{displayName} . "\n";
        print "Reviewers:\n";
        foreach my $reviewer (sort { $a->{user}{displayName} cmp $b->{user}{displayName} } @{ $value->{reviewers} }) {
            $reviewer->{user}{displayName} =~ s/ - External//;
            printf("%-20s %5s\n", $reviewer->{user}{displayName}, ($reviewer->{approved} ? 'Yes' : '...'));
        }
        $found++;
    }
}

# Display none
print "No pull requests found\n" unless $found;

sub get_json_from_url {
    my ($json, $url) = @_;
    my $file = '/tmp/foo';
    system("curl --insecure --silent --user $user:$pass $url | python -m json.tool > $file");
    open(my $fh,'<',$file) or die "can't open $file: $!";
    my @lines = <$fh>;
    chomp(@lines);
    close($fh);
    my $content = join('', @lines);
    # JSON
    return $json->decode($content);
}
