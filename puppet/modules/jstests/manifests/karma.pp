class jstests::karma
{
	package
	{
		'karma':
			ensure 		=> present,
			provider 	=> 'npm',
	}

	exec
	{
		'start_karma':
			command 	=> "nohup karma start ${jstests::params::karmaTestFile} /dev/null &",
			require 		=> Package[ 'karma' ],
	}
}