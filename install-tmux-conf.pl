#!/usr/bin/env perl

use strict;
use warnings;
use autodie;

# XXX grab it from an ENV var in case we're not "building"
#     for the local machine?
sub tmux_version {
    my $version = qx(tmux -V);
    chomp $version;

    if($version =~ /tmux\s+(\d+[.]\d+)/) {
        return $1;
    } else {
        die "$version does not match our version-checking regex\n";
    }
}

sub extract_version_reqs {
    my ( $line ) = @_;

    if($line =~ /#\s*v(\d+[.]\d+)/) {
        return $1;
    } else {
        return;
    }
}

die "usage: $0 [source] [destination]\n" unless @ARGV > 1;
my ( $source, $destination ) = @ARGV;

unless(-e $source) {
    die "'$source' does not exist\n";
}

my $current_version = tmux_version();

my $in_fh;
my $out_fh;

open $in_fh, '<', $source;
open $out_fh, '>', $destination;

while(<$in_fh>) {
    my $required_version = extract_version_reqs($_);
    if(!defined($required_version) || $required_version <= $current_version) {
        print {$out_fh} $_;
    }
}

close $in_fh;
close $out_fh;
