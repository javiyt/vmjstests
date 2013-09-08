var http = require('http'),
	exec = require('child_process').exec;

http.createServer( function ( req, res )
{
	exec( "java -jar /usr/local/bin/JsTestDriver-1.3.5.jar --server http://localhost:9876 --config /vagrant/jsTestDriver.conf --tests all --verbose", function( err, stdout, stderr )
	{
		res.writeHead( 200, {'Content-Type': 'text/plain'} );
		res.end( stdout );
	});
}).listen( 8080 );
