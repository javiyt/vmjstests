class jstests::system
{
	$basicPackages = [ 'wget', 'python', 'g++', 'make' ]
	$vmPackages = [ 'openjdk-7-jre-headless', 'nodejs' ]

	# Ugly hack so can install python-software-properties
	exec
	{
		'apt_sources_update':
			command 	=> 'apt-get update',
	}

	class
	{
		'apt':
			always_apt_update 	=> true,
	}

	apt::ppa
	{
		'ppa:chris-lea/node.js':
			require 	=> Exec['apt_sources_update']
	}

	package
	{
		$basicPackages:
			ensure 	=> latest,
			require 	=> Class['apt'],
	}

	package
	{
		$vmPackages:
			ensure 	=> latest,
			require 	=> Apt::Ppa['ppa:chris-lea/node.js'],
	}

	package
	{
		'colors':
			ensure 	=> present,
			require => Package[$vmPackages],
			provider=> "npm"
	}

	Exec['apt_sources_update'] -> Package <| |>
}