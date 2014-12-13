#!/usr/bin/perl -w

# use module
use XML::Simple;
use Data::Dumper;
use LWP::Simple;
use URI;

# create object
my $parser      = new XML::Simple;
my $url         = URI->new( 'http://api.sl.se/api2/realtimedepartures.xml?' );
$url->query_form(
        'key'           => '9e99975c83864b6f8dab6ab4baddaba8',
        'siteid'        => '1142',
        'timewindow'    => '60',
);
my $file        = "sl.xml";

#get response
my $response    = getstore($url, $file);
my $doc         = $parser->XMLin($file);


# read XML file
#/ResponseOfDepartures/ResponseData/Buses/Bus/"buss från"..StopAreaName.."Till"..Destination.."Avgår"..DisplayTime
foreach $e (@{$doc->{ResponseData}->{Buses}->{Bus}})
{
        print "Buss från ", $e->{StopAreaName}, " mot ", $e->{Destination}, " avgår om ", $e->{DisplayTime}, ".", "\n", "\n";
}
