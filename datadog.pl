use strict;
use warnings;
use v5.30;

my ($debug) = @ARGV;

use DataDog::DogStatsd;
my $start = time;

#eval "use Net::Dogstatsd";    ## no critic
#my $datadog = ! $@;


my @planets = ('Mercury', 'Venus', 'Earth', 'Mars', 'Jupiter', 'Saturn');

while (1) {
    my $sleep = rand()/2;
    sleep($sleep);
    if ($debug) {
        say "send $sleep";
    }
    my $elapsed_time = rand();
    my $request  = $planets[int(rand() * scalar @planets)];

    my $statsd = DataDog::DogStatsd->new;
    $statsd->increment("demo_perl.$request");
    $statsd->increment("demo_perl.requests");
    $statsd->gauge('demo_perl.elapsed_time', $elapsed_time);


    #my $dogstatsd = Net::Dogstatsd->new();
    #my $socket    = $dogstatsd->get_socket();
    #$dogstatsd->increment( name => 'web.page_views', );
    #$dogstatsd->gauge(
    #	name  => 'web.elapsed_time',
    #	value => $data->{elapsed_time},
    #);
    #$dogstatsd->histogram(
    #	name  => 'web.elapsed_time_histogram',
    #	value => $data->{elapsed_time},
    #);
    #
    #
    last if (time - $start) >= 60;
}

