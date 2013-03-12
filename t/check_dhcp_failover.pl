use strict;
use DHCP::OMAPI;
use Mail::Sendmail;
use Getopt::Std;

# command line options
use vars qw ( $opt_h $opt_d $opt_m);
getopts ('hd');

if($opt_h) {
	usage();
	exit 0;
}

my $debug      = $opt_d;
my $alert_to   = 'someone@somewhere';
my $alert_from = 'you@yourserver';

# check multiple hosts

my @hosts = ('xxx.xxx.xxx.xxx', 'xxx.xxx.xxx.xxx');

foreach my $host(@hosts) {

	my $connection = new DHCP::OMAPI::Connection(	host	=> $host,
							port	=> 50004,
							keyfile	=> 'dhcp_monitor.key' );

	if($connection->connected) {

		my $failover = DHCP::OMAPI::Object::Failover->fetch( 	$connection,
									'name' => 'dhcpd_failover'
								   );

		if($failover) {
			my $state 	= $failover->get('local-state');

			if($state ne 'normal') {
				send_alert("DHCP Server $host has a failover state of $state.\nThis is not 'normal', please check the DHCP Server.\n"); 
			} else {
				send_alert("DHCP Server $host has a failover state of $state.\n") if($debug); 
			}

		} else {
			send_alert("DHCP Server $host did not respond. Host may be down."); 
		}
	
	} else {
		send_alert("DHCP Server $host was unreachable for failover check. Host may be down."); 

	}

} # end foreach

exit;

sub send_alert {
	my ($alert_text) = @_;

	if($debug) {
		print "$alert_text\n";
	} else {
		
		my %mail = (
				To      => $alert_to,
                   		From    => $alert_from,
				Subject => 'DHCP Server Failover Problem',
                   		Message => $alert_text
                );

         	sendmail(%mail) or die $Mail::Sendmail::error;

	}
}

sub usage {

  print "\nUsage: $0 [-h] || [-d]\n";
  print "where:\n";
  print "\t-h => help\n";
  print "\t-d => print current failover state, rather than mailing it\n\n";

}

