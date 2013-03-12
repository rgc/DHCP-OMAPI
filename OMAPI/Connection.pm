package DHCP::OMAPI::Connection;

@DHCP::OMAPI::Connection::ISA = qw(DHCP::OMAPI);

use 5.006;
use strict;
use warnings;
use MIME::Base64;

=head1 NAME

DHCP::OMAPI::Connection - Provides a connection to the OMAPI interface of a DHCP server

=head1 SYNOPSIS

 use DHCP::OMAPI;
 my $connection = new DHCP::OMAPI::Connection(  host    => $host,
                                                port    => 50004,
                                                keyfile => "dhcp_monitor.key" );

 if($connection) {
	# ...
 } else {
	die "connection failed!";
 }

=head1 DESCRIPTION

Stub documentation for DHCP::OMAPI::Connection, created by h2xs. It looks like the
author of the extension was negligent enough to leave the stub
unedited.

Blah blah blah.

=head1 METHODS

=head2 new DHCP::OMAPI::Connection()

=over

Constructor.

=over

=item Parameters

        host    = dhcp server ip
        port    = port configured for OMAPI in dhcpd.conf
        keyfile = name of a file containing the OMAPI keyname and key

=back

=back

=cut

sub read_keyfile {
	my $self = shift;

    	if($self->{keyfile} && -f $self->{keyfile}) {

    		open(KF, $self->{keyfile});

   		while (<KF>) {
			chomp;
			next unless /^([^:]+):\s*(.+)$/;
			my $v = $2;
			$self->{lc($1)} = $v if $v;
      		}
    		close KF;
	} else {
		die "couldn't read keyfile!";
    	}
}

sub init {
    	my $self = shift;

    	$self->read_keyfile() || die "problems reading keyfile!";

    	my $port = $self->{port} || 7911;
    	if($self->{_handle}->connect(	$self->{host},
				      	$port,
				      	$self->{keyname},
				      	$self->{algorithm} || 'hmac-md5',
			      		decode_base64($self->{key}))
      		== DHCP::OMAPI::CONST('ISC_R_SUCCESS')) {
		$self->{_connected}++;
	}
}

sub connected {
    	my $self = shift;
	return $self->{_connected};
}

1;

__END__

=head1 SEE ALSO

L<DHCP::OMAPI>

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


