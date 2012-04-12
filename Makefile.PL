use ExtUtils::MakeMaker;

# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.

WriteMakefile
(
 ($] ge '5.005') ?
 (
  AUTHOR   => 'Ron Savage (ron@savage.net.au)',
  ABSTRACT => 'A plugin for CGI::Snapp to switch cleanly to another run mode within the same app',
    ) : (),
 clean =>
 {
	 FILES => 'blib/* Makefile MANIFEST CGI-Snapp-Plugin-Forward-*'
 },
 dist =>
 {
	 COMPRESS => 'gzip',
	 SUFFIX   => 'gz'
 },
 DISTNAME  => 'CGI-Snapp-Plugin-Forward',
 NAME      => 'CGI::Snapp::Plugin::Forward',
 PL_FILES  => {},
 PREREQ_PM =>
 {
	Carp         => 1.01,
	CGI          => 3.00,
	CGI::Snapp   => 1.01,
	Exporter     => 5.567,
	Log::Handler => 0.75,
	parent       => 0,
	strict       => 1.03,
 	Test::More   => 0.94,
 	Test::Pod    => 1.44,
	vars         => 1.01,
	warnings     => 1.03,
 },
 VERSION_FROM => 'lib/CGI/Snapp/Plugin/Forward.pm',
);
