#!/usr/bin/perl -w

# use module
use XML::Simple;
use Data::Dumper;
use LWP::Simple;
use URI;

#ASK QUESTIONS
#Vad vill du söka efter?
print "Vänligen skriv in namnet på stationen du vill åka ifrån.", "\n";
$searchstring = <STDIN>;
chomp $searchstring;
print "Du vill åka från: ", $searchstring, "\n", "\n";

#Hur många resultat som högst? (2-50)
print "Hur många resultat vill du ha? Du kan välja från 2-50.", "\n";
$maxresults = <STDIN>;
chomp $maxresults;
#Verifiera värde mellan 2-50.
if( $maxresults >= 2 && $maxresults <= 50 ) {
        print "Du vill se upp till ", $maxresults, " resultat.", "\n", "\n";
}
else {
        print "Fel siffra. Försöker igen.", "\n";
        print "Hur många resultat vill du ha? Du kan välja från 2-50.", "\n";
        $maxresults = <STDIN>;
        chomp $maxresults;
        if( $maxresults >= 2 && $maxresults <= 50 ) {
                print "Du vill se upp till ", $maxresults, " resultat.", "\n", "\n";
        }
        else {
                print "Skärp dig.", "\n", "\n";
                die;
        }
}


# create object
$stations = "True";
my $parser      = new XML::Simple;
my $url         = URI->new( 'http://api.sl.se/api2/typeahead.xml?' );
$url->query_form(
        'key'           => '8c9bf84d3f3746eab8568891dafe74f8',
        'searchstring'  => $searchstring,
        'stationsonly'  => $stations,
        'maxresults'    => $maxresults,
);
my $file        = "sl.xml";

#get response
my $response    = getstore($url, $file);
my $doc         = $parser->XMLin($file);

# read XML file
#/ResponseOfDepartures/ResponseData/Buses/Bus/"buss från"..StopAreaName.."Till"..Destination.."Avgår"..DisplayTime
foreach $e (@{$doc->{ResponseData}->{Site}})
{
                print "Station ", $e->{Name}, " har SiteId: ", $e->{SiteId};

                print ".", "\n", "\n";
}
