use Module::Build;

Module::Build -> new
(
 module_name    => 'CGI::Snapp::Plugin::Forward',
 license        => 'artistic',
 dist_abstract  => 'A plugin for CGI::Snapp to switch cleanly to another run mode within the same app',
 dist_author    => 'Ron Savage <ron@savage.net.au>',
 build_requires =>
 {
 	 Test::More => 0.94,
 	 Test::Pod  => 1.44,
 },
 configure_requires =>
 {
 	 Module::Build => 0.3800,
 },
 requires =>
 {
	Carp         => 1.01,
	CGI          => 3.00,
	CGI::Snapp   => 1.01,
	Exporter     => 5.567,
	Log::Handler => 0.75,
	parent       => 0,
	strict       => 1.03,
	vars         => 1.01,
	warnings     => 1.03,
 },
) -> create_build_script();
