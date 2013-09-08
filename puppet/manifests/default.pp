$jsTestDriverDir = '/usr/local/bin'
$jsTestDriverVersion = '1.3.5'
$jsPhantomJstdDir = '/vagrant'
$jsPhantomJstdFile = 'phantomjs-jstd.js'
$phantomJSVersion = '1.9.1'

Exec
{
	path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ]
}

group
{
	'puppet':
		ensure => present,
}

exec
{
	'apt_update':
		command 	=> 'apt-get update'
}

$basicPackages = [ 'wget', 'openjdk-7-jre-headless', 'nodejs' ]
package
{
	$basicPackages:
		ensure 	=> latest,
		require 	=> Exec['apt_update'],
}

exec
{
	'download_jstestdriver':
		command 	=> "wget https://js-test-driver.googlecode.com/files/JsTestDriver-${jsTestDriverVersion}.jar",
		cwd 		=> $jsTestDriverDir,
		creates 	=> "$jsTestDriverDir/JsTestDriver-${jsTestDriverVersion}.jar",
		require 		=> Package[$basicPackages],
}

exec
{
	'start_jstestdriver':
		command 	=> "nohup java -jar $jsTestDriverDir/JsTestDriver-${jsTestDriverVersion}.jar --port 9876 > /tmp/jstd.out 2> /tmp/jstd.err < /dev/null &",
		require 		=> Exec['download_jstestdriver'],
}

exec
{
	'start_phantomjs':
		command 	=> "nohup phantomjs  ${jsPhantomJstdDir}/${jsPhantomJstdFile} > /tmp/phantomjs.out 2> /tmp/phantomjs.err < /dev/null &",
		require 		=> [ Class['phantomjs'], Exec['start_jstestdriver'], Exec['download_jstd_phantom'] ],
}

exec
{
 	'download_jstd_phantom':
		command 	=> "wget https://raw.github.com/larrymyers/js-test-driver-phantomjs/master/${jsPhantomJstdFile}",
		cwd 		=> $jsPhantomJstdDir,
		creates 	=> "${jsPhantomJstdDir}/${jsPhantomJstdFile}",
}

class
{
	'phantomjs':
		version 	=> $phantomJSVersion,
}

exec
{
	'start_launcher':
		command 	=> "nohup node /vagrant/launcher.js > /dev/null &",
		require 		=> [ Package[$basicPackages], Exec['start_jstestdriver'], Exec['start_phantomjs'] ],
}