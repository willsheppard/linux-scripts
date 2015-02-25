#!perl
# demonstrates how to use localtime

print "list context:\n";
print "$query executed successfully at ", localtime, "\n"; # list context
print "$query executed successfully at ",(localtime),"\n"; # list context

print "scalar context:\n";
print "$query executed successfully at ". localtime, "\n"; # scalar context
print "$query executed successfully at ".(localtime),"\n"; # scalar context

print "$query executed successfully at ", scalar  localtime, "\n"; # scalar context
print "$query executed successfully at ", scalar (localtime),"\n"; # scalar context
