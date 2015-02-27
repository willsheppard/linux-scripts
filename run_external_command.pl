#!/usr/bin/perl -l

# Perl routine to run an external command,
# capturing both the exit code and all output

print "args = ".join(', ', @ARGV);

run_external_command(@ARGV);

sub run_external_command {
    my (@commands) = @_;
    my $command = join(' ', @commands);
    print("Running command: $command");

    my $output = '';
    $command .= ' 2>&1 | '; # capture all output
    open(my $capture, $command);
    {
        local $/ = undef;
        $output = <$capture>;
    }
    close($capture);
    chomp($output);

    my $exit_value = ${^CHILD_ERROR_NATIVE} >> 8;
    print("Exit value of command: '$exit_value'");
    print("Output of command: '".($output || '[no output]')."'");

    return ($exit_value, $output);
}
