#!/usr/bin/perl

#Load modules
use Socket;
use Net::DNS;
use Getopt::Std;

#Assign variables

my $site = @ARGV[1];

$res = new Net::DNS::Resolver;
$que = $res->query($site, "NS");
foreach $nameserver ($que->answer) 
{
        push @addresses, $nameserver->nsdname;
}

$resolver = new Net::DNS::Resolver(
        nameservers => [ @addresses ],
        recurse => 0,
        debug => 0
);

#Lazy way to make getopts work as intended.

if (@ARGV[2])
{
        my $invarg = @ARGV[2];
        do_help();
        print "\n", "One or more options too many. Try again..", "\n";
        exit 1;
}

#Getopts!

my %options=();
getopts("a:m:t:h", \%options);

if ($options{h})
{
        do_help();
}
elsif ($options{a})
{
        do_a();
}
elsif ($options{m})
{
        do_m();
}
elsif ($options{t})
{
        do_t();
}
else
{
        do_help();
}

#Here we make some subs!

sub do_help {
        print "Usage: ", "checkdns -flag [host]", "\n", "\n", "Flags:", "\n";
        print "-a       Show A records.", "\n";
        print "-h       Show this help section.", "\n";
        print "-m       Show MX records.", "\n";
        print "-t       Show TXT records.", "\n";
        
}

sub do_a {
        print "Showing A records.", "\n";
        print "Site: ", $site, "\n";
        $packet = $resolver->search( $site, 'A' );
        my @answer = $packet->print;
}

sub do_m {
        print "Showing MX records.", "\n";
        print "Site: ", $site, "\n";
        $packet = $resolver->search( $site, 'MX' );
        my @answer = $packet->print;
}

sub do_t {
        print "Showing TXT records.", "\n";
        print "Site: ", $site, "\n";
        $packet = $resolver->search( $site, 'TXT');
        my @answer = $packet->print;
}

#Gonna clear out the answers a bit when I have time.