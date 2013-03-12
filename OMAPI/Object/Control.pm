package DHCP::OMAPI::Object::Control;

@DHCP::OMAPI::Object::Control::ISA = qw(DHCP::OMAPI::Object);

use 5.006;
use strict;
use warnings;

sub type { 'control' }

sub key_types {

	my $map	= {
			'state'			=> 'integer',
		};

	return $map;
};

sub PACK {
        my ($self, $key, $value) = @_;

        my $map = {};

        if(!defined($map->{$key})) {
                return $value;
        } else {
                return &{$map->{$key}}($value);
        }
}

sub UNPACK {
        my ($self, $key, $value) = @_;

	# we can't map state yet b/c we don't have enough info...
	my $map	= {};

        if(!defined($map->{$key})) {
                return $value;
        } else {
                return &{$map->{$key}}($value);
        }
}

1;
