class jstests::phantom
(
	$phantomJSVersion		= $jstests::params::phantomJSVersion,
)
{
	exec
	{
		'start_phantomjs':
			command 	=> "nohup phantomjs  ${jstests::params::jsPhantomJstdDir}/${jstests::params::jsPhantomJstdFile} > /tmp/phantomjs.out 2> /tmp/phantomjs.err < /dev/null &",
			require 		=> [ Class['phantomjs'], Exec['start_jstestdriver'], Exec['download_jstd_phantom'] ],
	}

	exec
	{
	 	'download_jstd_phantom':
			command 	=> "wget https://raw.github.com/larrymyers/js-test-driver-phantomjs/master/${jstests::params::jsPhantomJstdFile}",
			cwd 		=> $jstests::params::jsPhantomJstdDir,
			creates 	=> "${jstests::params::jsPhantomJstdDir}/${jstests::params::jsPhantomJstdFile}",
	}

	class
	{
		'phantomjs':
			version 	=> $phantomJSVersion,
	}
}