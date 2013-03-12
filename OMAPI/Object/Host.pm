package DHCP::OMAPI::Object::Host;

@DHCP::OMAPI::Object::Host::ISA = qw(DHCP::OMAPI::Object);

use 5.006;
use strict;
use warnings;

sub type { 'host' }

sub key_types {

	my $map	= {
			'ip-address'			=> 'data',
			'hardware-address'		=> 'hex',
			'hardware-type'			=> 'integer',
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

1;
