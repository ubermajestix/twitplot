twitplot
=============================

Load a bunch of tweets based on a location

Installation
============
    % gem sources
    *** CURRENT SOURCES ***

    http://gems.rubyforge.org
    % sudo gem sources -a http://gems.github.com
    http://gems.github.com added to sources
    % sudo gem install ubermajestix-twitter

Testing
=======

There are only [acceptance tests][webrat] here, but they're kinda cool.  
You can easily run both console and selenium driven tests from the same spec.
There's also rcov coverage.

To just run the console based webrat tests run the following:

    % rake

To run the selenium tests run the following:
    % SELENIUM=true rake

Running
=======
    % script/server

[webrat]: http://github.com/brynary/webrat
