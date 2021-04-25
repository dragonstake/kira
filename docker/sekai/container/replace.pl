#!/usr/bin/perl

use strict;

if (@ARGV < 3)
{
	print "Usage: $0 <reg> <repl> <file>\n";
	exit 1;
}

my ($reg, $repl, $file ) = @ARGV;

if ( ! -f $file)
{
	print "The file '$file' was not found\n";
	exit 1;
}

my $out = "$file.out";

open my $fh, '<', $file;
open my $fhw, '>', $out;
foreach my $l (<$fh>)
{
	if ($l =~ s|$reg|$repl|)
	{
		print "Modified: $l\n";
	}

	print $fhw $l;
}

close $fhw;
close $fh;

system ("$out $file");
