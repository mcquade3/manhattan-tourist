#!/usr/local/bin/perl
# Mike McQuade
# Manhattan-tourist.pl
# Finds the length of the longest path in the
# Manhattan Tourist Problem.

# Define the packages to use
use strict;
use warnings;
use List::Util qw(max);

# Initialize variables
my (@bounds,@grid,@down,@right);

# Open the file to read
open(my $fh,"<ba5b.txt") or die $!;

# Read in the bounds from the file
@bounds = split(/\D/,<$fh>);

# Read in the down matrix from the file
while (my $line = <$fh>) {
	if ($line ne "-\n") { # When the '-' symbol appears, the loop stops
		push @down,[split / /,$line];
	} else {last}
}

# Read in the right matrix fron the file
while (my $line = <$fh>) {
	push @right,[split / /,$line];
}

# Calculate the first row of the grid using
# the values in the right array.
my @tempArr = (0);
for (my $i = 0; $i < $bounds[1]; $i++) {
	push @tempArr,$tempArr[$i] + $right[0][$i];
}
push @grid,[@tempArr];

# Calculate the first column of the grid using
# the values in the down array.
for (my $i = 0; $i < $bounds[0]; $i++) {
	push @grid,[$grid[$i][0] + $down[$i][0]];
}

# Calculate the remaining squares in the grid
for (my $i = 1; $i <= $bounds[0]; $i++) {
	for (my $j = 1; $j <= $bounds[1]; $j++) {
		# Insert the greater of the two paths, down or right, into the grid
		push $grid[$i], max($grid[$i-1][$j] + $down[$i-1][$j], $grid[$i][$j-1] + $right[$i][$j-1]);
	}
}

# Print out the longest path
print $grid[$bounds[0]][$bounds[1]]."\n";

# Close the file
close($fh) || die "Couldn't close file properly";