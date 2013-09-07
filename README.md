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

SSH the virtual machine:

	vagrant ssh

And run your tests:

	java -jar /usr/local/bin/JsTestDriver-1.3.5.jar --server http://localhost:9876 --config /vagrant/jsTestDriver.conf --tests all --verbose
