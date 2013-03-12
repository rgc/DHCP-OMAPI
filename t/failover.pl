use lib '../blib/lib/';
use lib '../blib/arch/';

use strict;
use DHCP::OMAPI;

my $debug = 1;
my $quiet = 0;

my $host = shift || die;

my $connection = new DHCP::OMAPI::Connection(	host	=> $host,
						port	=> 50004,
						keyfile	=> 'dhcp_monitor.key' );

if($connection) {

	my $failover = DHCP::OMAPI::Object::Failover->fetch( 	$connection,
								'name' => 'dhcpd_failover'
							   );

	if($failover) {
		my $state 	= $failover->get('local-state');

		print "Server is in $state mode\n" if(!$quiet);

		if($debug) {
			print "\nDEBUG:\n";
			print "---------------------\n";
			foreach my $a ($failover->attributes()) {
   				printf "%s: %s\n",$a,$failover->get($a);
			}
			print "---------------------\n\n";
		}

		if($state ne 'normal') {
			send_alert("DHCP Server $host has a failover state of $state"); 
		}

	} else {
		send_alert("DHCP Server $host did not respond. Host may be down."); 
	}
	
} else {
	send_alert("DHCP Server $host was unreachable for failover check. Host may be down."); 

}

exit;

sub send_alert {
	my ($alert_text) = @_;
	# we don't send alerts in debug mode
	if($debug) {
		print "$alert_text\n";
	} else {

	}
}
