( function() {
	var http = require('http'),
		exec = require('child_process').exec,
		fs = require('fs'),
		colors = require('colors'),
		oColorTheme = {
			silly: 'rainbow',
			input: 'grey',
			verbose: 'cyan',
			prompt: 'grey',
			info: 'green',
			data: 'grey',
			help: 'cyan',
			warn: 'yellow',
			debug: 'blue',
			error: 'red'
		},
		TEXT_ERROR_MSG_HEADER = "(='.'=) Oh no! Something went wrong!",
		TEXT_OK_MSG_HEADER = "Nice! You are rocking the code!";

	colors.setTheme(oColorTheme);

	http.createServer( function ( req, res ) {
		if ( '/karma' == req.url ) {
			exec( "karma run /vagrant/karma_test.conf.js", function( err, stdout, stderr ) {
				var bIsErroneous = err !== null,
					sOut = removeNoiseInfo( stdout );

				outputInConsole( sOut, bIsErroneous );
				outputInBrowser( removeASCIIEscapeChars( sOut ), bIsErroneous, res );
			});
		}
		else {
			exec( "java -jar /usr/local/bin/JsTestDriver-1.3.5.jar --server http://localhost:9876 --config /vagrant/jsTestDriver.conf --tests all --verbose", function( err, stdout, stderr ) {
				var sOut = removeASCIIEscapeChars(stdout);
				res.writeHead( 200, {'Content-Type': 'text/plain'} );
				res.end( sOut );
			});
		}
	}).listen( 8080 );

	function removeNoiseInfo( sText ) {
		var aLines = sText.split("\n");
		// Remove first line which contains the loading info of the karma config
		aLines = aLines.slice(1);
		return aLines.join("\n");
	}

	function removeASCIIEscapeChars( sText ) {
		return sText.replace(/(|\0)/g, "");
	}

	function formatToHTML( sText, bIsErroneous ) {
		var sOutput;

		if (bIsErroneous) {
			sOutput = "<h1 style='color: " + oColorTheme.error + "'>" + TEXT_ERROR_MSG_HEADER + "</h1>";
		}
		else {
			sOutput = "<h1 style='color: " + oColorTheme.info + "'>" + TEXT_OK_MSG_HEADER + "</h1>";
		}

		sOutput += "<pre>" + sText + "</pre>";

		return ["<!DOCTYPE HTML>",
				"<html>",
				"<body>",
				sOutput,
				"</body>",
				"</html>"].join("\n");
	}

	function outputInConsole( sText, bIsErroneous ) {
		if ( bIsErroneous ) {
			console.log( "\n" + TEXT_ERROR_MSG_HEADER.error.inverse.bold + "\n" );
		}
		else {
			console.log( "\n" + TEXT_OK_MSG_HEADER.info.inverse.underline + "\n" );
		}
		console.log( sText );
	}

	function outputInBrowser( sText, bIsErroneous, res ) {
		res.writeHead( 200, {'Content-Type': 'text/html'} );
		res.end( formatToHTML( sText, bIsErroneous ) );
	}
} () );
