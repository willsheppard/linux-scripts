# Combine all standard (STDOUT) and error (STDERR) streams into one output stream
#   so that all output can be piped into a single file
# Required for applications like 'time'

$@ 2>&1
