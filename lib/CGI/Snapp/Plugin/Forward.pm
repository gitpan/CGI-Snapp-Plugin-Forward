package CGI::Snapp::Plugin::Forward;

use strict;
use warnings;

use Carp;

use vars qw(@EXPORT @ISA);

@EXPORT = ('forward');
@ISA    = ('Exporter');

our $VERSION = '1.00';

# --------------------------------------------------

sub forward
{
	my($self, $run_mode, @args) = @_;
	$run_mode = defined $run_mode ? $run_mode : '';

	$self -> log(debug => "forward($run_mode, ...)");
	$self -> _current_run_mode($run_mode);
	$self -> call_hook('forward_prerun');

	return $self -> _generate_output(@args);

} # End of forward.

# --------------------------------------------------

CGI::Snapp -> new_hook('forward_prerun');

1;

=pod

=head1 NAME

CGI::Snapp::Plugin::Forward - A plugin for CGI::Snapp to switch cleanly to another run mode within the same app

=head1 Synopsis

	package My::App;

	use parent 'CGI::Snapp';

	use CGI::Snapp::Plugin::Forward;

	# ------------------------------------------------

	sub setup
	{
		my($self) = @_;

		$self -> run_modes([qw(start second)]);
	}

	# ------------------------------------------------

	sub start
	{
		my($self) = @_;

		my($rm) = $self -> get_current_runmode; # 'start'.

		return $self -> forward('second', 'some', 'data');
	}

	# ------------------------------------------------

	sub second
	{
		my($self, @args) = @_;

		my($rm) = $self -> get_current_runmode; # 'second'.

		return $html;
	}

	# ------------------------------------------------

	1;

=head1 Description

When you 'use' this module in your sub-class of L<CGI::Snapp> (as in the Synopsis), it automatically imports into your sub-class the L</forward($run_mode[, @args])> method, to give you
a single call to switch run modes and run a hook before entering the new run mode. See that method's details below for exactly what effect a call to forward() has.

If you want to redirect to another (external) url, then L<CGI::Snapp::Plugin::Redirect>'s redirect() method is more suitable.

=head1 Distributions

This module is available as a Unix-style distro (*.tgz).

See L<http://savage.net.au/Perl-modules/html/installing-a-module.html>
for help on unpacking and installing distros.

=head1 Installation

Install L<CGI::Snapp::Plugin::Forward> as you would for any C<Perl> module:

Run:

	cpanm CGI::Snapp::Plugin::Forward

or run:

	sudo cpan CGI::Snapp::Plugin::Forward

or unpack the distro, and then either:

	perl Build.PL
	./Build
	./Build test
	sudo ./Build install

or:

	perl Makefile.PL
	make (or dmake or nmake)
	make test
	make install

=head1 Constructor and Initialization

This module does not have, and does not need, a constructor.

=head1 Methods

=head2 forward($run_mode[, @args])

Switches from the current run mode to the given $run_mode, passing the optional @args.

Returns the output of the $run_mode method.

For this to work, you must have previously called $self -> run_modes($run_mode => 'some_method'), so the code knows which method it must call.

Just before the method associated with $run_mode is invoked, the current run mode (within L<CGI::Snapp>) is set to $run_mode, and any methods attached to the hook 'forward_prerun' are called.

Calling this hook gives you the opportunity of making any preparations you wish before the new run mode is entered. See sub setup() in t/lib/ForwardTest.pm for sample code.

Finally, $run_mode's method is called.

=head1 FAQ

=head2 Why don't you 'use Exporter;'?

It is not needed; it would be for documentation only.

For the record, Exporter V 5.567 ships with Perl 5.8.0. That's what I had in Build.PL and Makefile.PL until I tested the fact I can omit it.

=head1 See Also

L<CGI::Application>

The following are all part of this set of distros:

L<CGI::Snapp> - A almost back-compat fork of CGI::Application

L<CGI::Snapp::Plugin::Forward> - A plugin for CGI::Snapp to switch cleanly to another run mode within the same app

L<CGI::Snapp::Plugin::Redirect> - A plugin for CGI::Snapp to simplify using HTTP redirects

L<CGI::Snapp::Demo::One> - A template-free demo of CGI::Snapp using just 1 run mode

L<CGI::Snapp::Demo::Two> - A template-free demo of CGI::Snapp using N run modes

L<CGI::Snapp::Demo::Three> - A template-free demo of CGI::Snapp using CGI::Snapp::Plugin::Forward

L<CGI::Snapp::Demo::Four> - A template-free demo of CGI::Snapp using Log::Handler::Plugin::DBI

L<CGI::Snapp::Demo::Four::Wrapper> - A wrapper around CGI::Snapp::Demo::Four, to simplify using Log::Handler::Plugin::DBI

L<Config::Plugin::Tiny> - A plugin which uses Config::Tiny

L<Config::Plugin::TinyManifold> - A plugin which uses Config::Tiny with 1 of N sections

L<Data::Session> - Persistent session data management

L<Log::Handler::Plugin::DBI> - A plugin for Log::Handler using Log::Hander::Output::DBI

L<Log::Handler::Plugin::DBI::CreateTable> - A helper for Log::Hander::Output::DBI to create your 'log' table

=head1 Machine-Readable Change Log

The file CHANGES was converted into Changelog.ini by L<Module::Metadata::Changes>.

=head1 Version Numbers

Version numbers < 1.00 represent development versions. From 1.00 up, they are production versions.

=head1 Credits

Please read L<https://metacpan.org/module/CGI::Application::Plugin::Forward#AUTHOR>, since this code is basically copied from L<CGI::Application::Plugin::Forward>.

=head1 Support

Email the author, or log a bug on RT:

L<https://rt.cpan.org/Public/Dist/Display.html?Name=CGI::Snapp::Plugin::Forward>.

=head1 Author

L<CGI::Snapp::Plugin::Forward> was written by Ron Savage I<E<lt>ron@savage.net.auE<gt>> in 2012.

Home page: L<http://savage.net.au/index.html>.

=head1 Copyright

Australian copyright (c) 2012, Ron Savage.

	All Programs of mine are 'OSI Certified Open Source Software';
	you can redistribute them and/or modify them under the terms of
	The Artistic License, a copy of which is available at:
	http://www.opensource.org/licenses/index.html

=cut

