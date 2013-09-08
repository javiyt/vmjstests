vmjstests
=========

Virtual machine to run using Vagrant with a full environment to run Javascript Tests

Based on:
* https://github.com/larrymyers/js-test-driver-phantomjs
* https://github.com/brhelwig/puppet-phantomjs
* https://github.com/puppetlabs/puppetlabs-stdlib
* https://github.com/puppetlabs/puppetlabs-apt

How to use it
-------------

Add your files to the src folder, and your tests to the test folder.

To run all the tests included in your conf file go to:
* Run your tests using JSTestDriver: [http://localhost:8080/](http://localhost:8080/)
* Run your tests using Karma: [http://localhost:8080/karma](http://localhost:8080/karma)
