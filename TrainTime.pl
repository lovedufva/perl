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
        'siteid'        => '9221',
        'timewindow'    => '60',
);
my $file        = "sl.xml";

#get response
my $response    = getstore($url, $file);
my $doc         = $parser->XMLin($file);

#print Dumper($doc);
#die;

# read XML file
#/ResponseOfDepartures/ResponseData/Buses/Bus/"buss från"..StopAreaName.."Till"..Destination.."Avgår"..DisplayTime
foreach $e (@{$doc->{ResponseData}->{Metros}->{Metro}})
{
        if (($e->{Destination} eq 'Norsborg') or ($e->{Destination} eq "S\x{e4}tra")) {
                print "Tåg från ", "Gärdet", " mot ";

                if ($e->{Destination} eq "S\x{e4}tra") {
                        print "Sätra"
                }

                else {
                        print $e->{Destination};
                }

                print " avgår ";

                if ($e->{DisplayTime} eq 'Nu') {
                        print "nu";
                }

                elsif ($e->{DisplayTime} =~ 'min') {
                        print "om ", $e->{DisplayTime};
                }

                elsif ($e->{DisplayTime} =~ ':') {
                        print $e->{DisplayTime};
                }

                print ".", "\n", "\n";

        }

}
