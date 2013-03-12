package DHCP::OMAPI::Object;

@DHCP::OMAPI::Object::ISA = qw(DHCP::OMAPI);

use 5.006;
use strict;
use warnings;
use POSIX;
use DHCP::OMAPI::Object::Control;
use DHCP::OMAPI::Object::Failover;
use DHCP::OMAPI::Object::Group;
use DHCP::OMAPI::Object::Host;
use DHCP::OMAPI::Object::Lease;


sub type {
	die "Use of base DHCP::OMAPI::Object class prohibited"
}

sub key_types {
        return {};
};

sub PACK {
	my ($self, $key, $value) = @_;
	return $value;
}

sub UNPACK {
	my ($self, $key, $value) = @_;
	return $value;
}

#########

sub key_type {
	my($self, $key) = @_;
	
	if(!defined($self->key_types->{$key})) {
		return 'unknown';
	} else {
		return $self->key_types->{$key};
	}
}

sub _bytes2hex {
	return join(':',map { sprintf "%02X",$_ } unpack('C*',$_[0]));
}

sub _hex2bytes {
	return pack('C*',map { hex $_ } split(/:/,$_[0]));
}

sub set_value {
	my ($self, $key, $value) = @_;
	return $self->{_handle}->set_value($value,$key);
}

sub set {
	my ($self, $key, $value) = @_;
    	$value = $self->_pack($key,$value);
	return $self->set_value($key,$value);
}

sub get_value {
	my ($self, $key) = @_;
	return $self->{_handle}->get_value($key);
}

sub get {
	my ($self, $key) = @_;
	my $value = $self->_unpack($key,$self->get_value($key));
	return $value;
}

sub _pack {
	my ($self, $key, $value) = @_;

	if ($self->key_type($key) eq 'integer') {
		$value = pack('N',$value);
    	}

    	return $self->PACK($key, $value);
}

sub _unpack {
	my ($self, $key, $value) = @_;
	if ($self->key_type($key) eq 'integer') {
		$value = unpack('N',$value);
	} elsif ($self->key_type($key) eq 'ctime') {
		$value = unpack('N',$value);
        	$ENV{'TZ'} = 'GMT';
        	$value = ctime($value);
        	chomp($value);
	} elsif ($self->key_type($key) eq 'ctime32') {
		$value = unpack('I',$value);
        	$ENV{'TZ'} = 'GMT';
        	$value = ctime($value);
        	chomp($value);
    	} elsif($self->key_type($key) eq 'hex') {
		$value = _bytes2hex($value);
    	} elsif($self->key_type($key) eq 'string') {
		# do nothing
    	} elsif($self->key_type($key) eq 'unknown') {
		# do nothing
	}

    	return $self->UNPACK($key, $value);
}

sub attributes {
	return $_[0]->{_handle}->attributes();
}

sub get_object {
	my ($self, $connection, $flags, $av) = @_;

	my %args = @{$av};
	my $object = $self->new(_connection=>$connection);

	foreach my $key (keys %args) {
		next if $key =~ /^_/;
		$object->set($key=>$args{$key});
    	}

    	my $res = $object->{_handle}->open_object($connection->{_handle},$flags);
    	$res != DHCP::OMAPI::CONST('ISC_R_SUCCESS') && $res != DHCP::OMAPI::CONST('ISC_R_NOTFOUND')
      	and die "Unable to open object: ".$self->error($res)."\n";

    	return ($res == DHCP::OMAPI::CONST('ISC_R_NOTFOUND') ? undef : $object);
}

sub fetch {
  	my $self = shift;
    	my $connection = shift;

	$self->get_object($connection,0,\@_);
}

sub update {
	my ($self, $connection) = @_;
	$self->{_handle}->object_update($connection);
}

sub create {
    my $self = shift;
    my $connection = shift;

    $self->get_object($connection,1,\@_);
}

sub init {
	my ($self) = @_;

	die "Not connected" unless $self->{_connection}->{_connected};
    	$self->{_handle}->new_object($self->{_connection}->{_handle},$self->type);
}

1;
