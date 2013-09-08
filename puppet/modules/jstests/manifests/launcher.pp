class jstests::launcher
{
	exec
	{
		'start_launcher':
			command 	=> "nohup node /vagrant/launcher.js > /dev/null &",
			require 		=> [ Package[$jstests::system::basicPackages], Exec['start_jstestdriver'], Exec['start_phantomjs'] ],
	}
}