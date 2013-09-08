class jstests::jstestdriver
(
	$jsTestDriverVersion 	= $jstests::params::jsTestDriverVersion,
)
{
	exec
	{
		'download_jstestdriver':
			command 	=> "wget https://js-test-driver.googlecode.com/files/JsTestDriver-${jsTestDriverVersion}.jar",
			cwd 		=> $jstests::params::jsTestDriverDir,
			creates 	=> "$jstests::params::jsTestDriverDir/JsTestDriver-${jsTestDriverVersion}.jar",
			require 		=> Package[$jstests::system::basicPackages],
	}

	exec
	{
		'start_jstestdriver':
			command 	=> "nohup java -jar $jstests::params::jsTestDriverDir/JsTestDriver-${jsTestDriverVersion}.jar --port 9876 > /tmp/jstd.out 2> /tmp/jstd.err < /dev/null &",
			require 		=> Exec['download_jstestdriver'],
	}
}