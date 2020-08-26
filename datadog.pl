use strict;
use warnings;
use v5.30;

eval "use Net::Dogstatsd";    ## no critic
my $datadog = ! $@;

my %data = (
    elapsed_time => rand(),
);

log_to_datadog(\%data);
exit();


sub log_to_datadog {
	my ($data) = @_;

	return if not $datadog;
    say 'sending';

	my $dogstatsd = Net::Dogstatsd->new();
	my $socket    = $dogstatsd->get_socket();
	$dogstatsd->increment( name => 'web.page_views', );
	$dogstatsd->gauge(
		name  => 'web.elapsed_time',
		value => $data->{elapsed_time},
	);
	$dogstatsd->histogram(
		name  => 'web.elapsed_time_histogram',
		value => $data->{elapsed_time},
	);
}


