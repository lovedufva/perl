#!/usr/bin/perl

#Load modules
#Edit
use Socket;
use Net::DNS;
use Getopt::Std;

#Assign variables

my $site = @ARGV[1];
$resolver = new Net::DNS::Resolver(
        nameservers => [ '8.8.8.8', '8.8.4.4' ],
        recurse => 0,
        debug => 1
);
$packet = $resolver->search( 'dufva.xyz', 'MX' );
print $packet;

if (@ARGV[2])
{
        my $invarg = @ARGV[2];
        do_help();
        print "\n", "One or more options too many. Try again..", "\n";
        exit 1;
}

my %options=();
getopts("a:m:c:h", \%options);

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
elsif ($options{c})
{
        do_c();
}
else
{
        do_help();
}

sub do_help {
        print "Usage: ", "checkdns -flag [host]", "\n", "\n", "Flags:", "\n";
        print "-a       Show A records.", "\n";
        print "-m       Show MX records.", "\n";
        print "-c       Show CNAME records.", "\n";
        print "-h       Show this help section.", "\n";
}
sub do_a {
        print "Showing A records.", "\n";
        print "Site: " . $site, "\n";

}
sub do_m {
        print "Showing MX records.", "\n";
        print "Site: " . $site, "\n";
        print $reply;
}
sub do_c {
        print "showing CNAME records.";
}

#@addresses = gethostbyname($name)      or die "Can't resolve $name: $!\n";
#@addresses = map { inet_ntoa($_) } @addresses[4 .. $#addresses];
# @addresses is a list of IP addresses ("208.201.239.48", "208.201.239.49")
