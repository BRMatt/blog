---
layout: post
title: Testing Kohana3 with PHPUnit
wordpress_id: 113
wordpress_url: http://sigswitch.com/?p=113
date: 2009-12-02 22:39:51.000000000 +00:00
---

[Unit testing][unit-testing] is great, period. 
It allows you to test different parts of your application independently of the 
rest of the system. Any changes that will cause problems elsewhere can be 
identified almost instantly (if you're doing it right!). 

<!-- more -->

Up until recently [Kohana3][kohana] was using a home-grown 
module for unit testing - It was ok, but lacked some of the more advanced 
features of independent testing suites - however now the project has now adopted 
PHPUnit as its [official test framework]()! 

PHPUnit is one of the more popular testing suites for PHP, it has full support 
for [Fixtures][phpunit-fixtures], 
[Mock Objects][phpunit-mocks], 
[Code Coverage][phpunit-cc] 
and a lot of other [cool stuff](http://seleniumhq.org/). 

The module only requires a few changes to the bootstrap in order to integrate 
Kohana with PHPUnit, and afterwards you can run tests from the cli, IDE or our 
custom web runner. All available tests are loaded from Kohana's cascading 
filesystem and can be filtered using PHPUnit's --group switch. 

Go and [git it](http://github.com/kohana/unittest) while it's hot!

[unit-testing]: http://en.wikipedia.org/wiki/Unit_testing "Unit testing"
[kohana]: http://github.com/kohana/kohana "Kohana"
[kohana-unittest]: http://github.com/kohana/unittest "Kohana unittest"
[phpunit-fixtures]: http://www.phpunit.de/manual/3.1/en/fixtures.html 
[phpunit-mocks]: http://www.phpunit.de/manual/3.1/en/mock-objects.html
[phpunit-cc]: http://www.phpunit.de/manual/3.1/en/code-coverage-analysis.html