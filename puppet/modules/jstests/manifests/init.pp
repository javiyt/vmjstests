class jstests
(
 	$jsTestDriverVersion 	= $jstests::params::jsTestDriverVersion,
 	$phantomJSVersion		= $jstests::params::phantomJSVersion,
 )
inherits jstests::params
{
	include jstests::system

	class
	{
		'jstests::jstestdriver':
			jsTestDriverVersion 	=> $jsTestDriverVersion,
			require 				=> Class['jstests::system'],
	}

	class
	{
		'jstests::phantom':
			phantomJSVersion	=> $jstests::params::phantomJSVersion,
			require 				=> Class['jstests::system'],
	}

	include jstests::launcher

	class
	{
		'jstests::karma':
			require 		=> Class['jstests::system'],
	}
}