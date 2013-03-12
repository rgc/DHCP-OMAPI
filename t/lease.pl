use lib '../blib/lib/';
use lib '../blib/arch/';

use DHCP::OMAPI;

my $debug = 1;
my $quiet = 0;

my $ip = shift || die;

my $connection = new DHCP::OMAPI::Connection(	host	=> $ip,
						port	=> 50004,
						keyfile	=> 'dhcp_monitor.key' );

if($connection) {

	my $failover = DHCP::OMAPI::Object::Lease->fetch( 	$connection,
								 'ip-address' => $ip
							   );

	if($failover) {
		if($debug) {
			print "\nDEBUG:\n";
			print "---------------------\n";
			foreach my $a ($failover->attributes()) {
   				printf "%s: %s\n",$a,$failover->get($a);
			}
			print "---------------------\n\n";
		}

	}
	
} else {
	send_alert("DHCP Server $ip was unreachable for failover check. Host may be down."); 

}

exit;

sub send_alert {
	my ($alert_text) = @_;
	# we don't send alerts in debug mode
	return if($debug);
}
