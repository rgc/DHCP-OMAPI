use ExtUtils::MakeMaker;

# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.

WriteMakefile(
    	'NAME'		=> 'DHCP::OMAPI',
    	'VERSION_FROM'	=> 'OMAPI.pm',
    	'PREREQ_PM'	=> {
				'MIME::Base64' => 0 
			   },
       	'LIBS'		=> ['-L/usr/lib -ldhcpctl -lomapi -ldst'],
       	'DEFINE'	=> '',
       	'INC'		=> '',

    	($] >= 5.005 ?    ## Add these new keywords supported since 5.005
      	(
		ABSTRACT_FROM 	=> 'OMAPI.pm',
       		AUTHOR     	=> 'Rob Colantuoni <rgc@buffalo.edu>'
	) : ())

);
