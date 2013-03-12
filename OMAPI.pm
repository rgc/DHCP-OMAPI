package DHCP::OMAPI;

use 5.006;
use strict;
use warnings;
require DynaLoader;

use DHCP::OMAPI::Connection;
use DHCP::OMAPI::Object;

our @ISA = qw(DynaLoader);

sub CONST {
	my ($constname, $arg) = @_;

	my $val = constant($constname, $arg ? $arg : 0);
	return $val;	
}

our $VERSION = '0.01';

bootstrap DHCP::OMAPI $VERSION;

BEGIN: { DHCP::OMAPI::Handle->initialize(); }

=head1 NAME

DHCP::OMAPI - A module for manipulating DHCP via the OMAPI interface

=head1 SYNOPSIS

 use DHCP::OMAPI;
 my $connection = new DHCP::OMAPI::Connection(  host    => $host,
                                                port    => 50004,
                                                keyfile => "dhcp_monitor.key" );

 if($connection) {

        my $failover = DHCP::OMAPI::Object::Failover->fetch(    $connection,
                                                                "name" => "dhcpd_failover"
                                                           );

        if($failover) {
                foreach my $a ($failover->attributes()) {
                	printf "%s: %s\n",$a,$failover->get($a);
                }
                
        }
 }

=head1 DESCRIPTION

Stub documentation for DHCP::OMAPI, created by h2xs. It looks like the
author of the extension was negligent enough to leave the stub
unedited.

Blah blah blah.

=head1 METHODS

=head2 new DHCP::OMAPI()

=over

Constructor.

=cut

sub new {
	my $self = shift;
    	my $class = ref $self || $self;
    	my %me = @_;
    	$self = bless \%me,$class;

    	$self->{_handle} = DHCP::OMAPI::Handle->new();
    	$self->init();
    	return $self;
}

sub error {
    	my $self = shift;
    	my $result = shift;

	DHCP::OMAPI::Handle->result_totext($result);
}

1;

__END__

=head1 SEE ALSO

L<DHCP::OMAPI::Connection>

L<DHCP::OMAPI::Object>

There is no mailing list for this module yet.

There is no website for this module yet.

=head1 AUTHOR

Operational Support Services - SUNY Buffalo

oss-unix@buffalo.edu

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2004 by OSS/CIT - SUNY Buffalo

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.3 or,
at your option, any later version of Perl 5 you may have available.

=cut
