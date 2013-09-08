vmjstests
=========

Virtual machine to run using Vagrant with a full environment to run Javascript Tests

Based on:
https://github.com/larrymyers/js-test-driver-phantomjs
https://github.com/brhelwig/puppet-phantomjs

How to use it
-------------

Create your jsTestDriver.conf file with the following content:

	load:
	  - src/*.js

	test:
	  - test/*.js

Add your files to the src folder, and your tests to the test folder.

To run all the tests included in your conf file go to:
http://localhost:8080/

You will see everything the output of JSTestDriver
