package DHCP::OMAPI::Object::Failover;

@DHCP::OMAPI::Object::Failover::ISA = qw(DHCP::OMAPI::Object);

use 5.006;
use strict;
use warnings;

sub type { 'failover-state' }

sub key_types {

	my $map	= {
			'name' 				=> 'string',
			'local-address'			=> 'integer',
			'partner-address'		=> 'integer',
			'partner-state' 		=> 'integer',
			'local-state' 			=> 'integer',
			'partner-port' 			=> 'integer',
			'local-port' 			=> 'integer',
			'partner-stos' 			=> 'ctime',
			'local-stos' 			=> 'ctime',
			'hierarchy' 			=> 'integer',
			'mclt' 				=> 'integer',
			'max-outstanding-updates' 	=> 'integer',
			'load-balance-max-secs' 	=> 'integer',
			'last-packet-sent' 		=> 'integer',
			'last-timestamp-received' 	=> 'integer',
			'skew'				=> 'integer',
			'max-response-delay' 		=> 'integer',
			'cur-unacked-updates' 		=> 'integer',
		};

	return $map;
};

sub PACK {
        my ($self, $key, $value) = @_;

        my $map = {
#                        'ip-address' => sub { return pack('C4',split(/\./,$_[0]))  },
                  };

        if(!defined($map->{$key})) {
                return $value;
        } else {
                return &{$map->{$key}}($value);
        }
}

sub UNPACK {
        my ($self, $key, $value) = @_;

	my $map	= {
     			'local-state' 	=> sub { return state_map($_[0]); },
     			'partner-state'	=> sub { return state_map($_[0]); },
     			'hierarchy'	=> sub { return hierarchy_map($_[0]); },
    	          };

        if(!defined($map->{$key})) {
                return $value;
        } else {
                return &{$map->{$key}}($value);
        }
}

sub state_map {
		my $state = shift;

		my $map = {
       			'1' => 'partner down',
			'2' => 'normal',
       			'3' => 'communications interrupted',
			'4' => 'resolution interrupted',
			'5' => 'potential conflict',
			'6' => 'recover',
       			'7' => 'recover done',
       			'8' => 'shutdown',
       			'9' => 'paused',
       		       '10' => 'startup',
       		       '11' => 'recover wait',
			};

		return $map->{$state};
};

sub hierarchy_map {
		my $hierarchy = shift;

		my $map = {
       			'0' => 'primary',
			'1' => 'secondary',
			};

		return $map->{$hierarchy};
};

1;
