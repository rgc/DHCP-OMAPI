package DHCP::OMAPI::Object::Lease;

@DHCP::OMAPI::Object::Lease::ISA = qw(DHCP::OMAPI::Object);

use 5.006;
use strict;
use warnings;

sub type { 'lease' }

sub key_types {

	my $map	= {
			'ip-address'			=> 'data',
			'state'				=> 'integer',
			'dhcp-client-identifier'	=> 'data',
			'client-hostname'		=> 'string',
			'subnet'			=> 'integer',
			'pool'				=> 'integer',
			'hardware-address'		=> 'hex',
			'hardware-type'			=> 'integer',
			'ends'				=> 'ctime32',
			'starts'			=> 'ctime32',
			'tstp'				=> 'ctime32',
			'tsfp'				=> 'ctime32',
			'cltt'				=> 'ctime32',
		};

	return $map;
};

sub PACK {
        my ($self, $key, $value) = @_;

        my $map = {
                        'ip-address' => sub { return pack('C4',split(/\./,$_[0]))  },
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
			'ip-address'    => sub { return join('.',unpack('C4',$_[0])) },
			'state'		=> sub { return state_map($_[0]); },
			'hardware-type'	=> sub { return hardware_map($_[0]); },
    	          };

        if(!defined($map->{$key})) {
                return $value;
        } else {
                return &{$map->{$key}}($value);
        }
}

sub hardware_map {
	my $type = shift;

	my $map = {
       			'1' => 'ethernet',
		  };

	return $map->{$type};
}

sub state_map {
	my $state = shift;

	my $map = {
       			'1' => 'free',
			'2' => 'active',
       			'3' => 'expired',
			'4' => 'released',
			'5' => 'abandoned',
			'6' => 'reset',
       			'7' => 'backup',
       			'8' => 'reserved',
       			'9' => 'bootp',
		};

	return $map->{$state};
};

1;
