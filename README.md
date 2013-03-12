DHCP-OMAPI
==========

DHCP::OMAPI - A perl module for manipulating DHCP via the OMAPI interface

Initially written in 2004, converted to a library in 2007

INSTALLATION

To install this module type the following:

   perl Makefile.PL
   make
   make test
   make install

USAGE

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


COPYRIGHT AND LICENCE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.5 or,
at your option, any later version of Perl 5 you may have available.

STRUCTURE

DHCP::OMAPI       - contains omapi functionality
DHCP::OMAPI::...  - all the rest below...


