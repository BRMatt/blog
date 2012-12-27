---

title: Host personal SVN projects for free using DropBox
wordpress_id: 31
wordpress_url: http://www.sigswitch.com/?p=31
date: 2009-04-13 18:19:25.000000000 +01:00
---
If you've ever tried to find an [svn](http://en.wikipedia.org/wiki/Subversion_(software)) 
host that's willing to host personal, private projects for free, you're probably 
well aware that are practically none. One of the best ones used to be 
[Assembla](http://assembla.com), until they changed their business model so that 
only OS projects could be hosted for free. 

Other free hosts include [beanstalkapp](http://beanstalkapp.com) and 
[Spring Loops](http://springloops.com), both of whom give you at least one 
repository, 100mb of space and a few user accounts to play with. This is great 
for one project, but when you start another one / run out of disk space you have 
to create a new account with a different email address, a different url etc.

<!-- more -->

At the end of the day you're just wasting time that you could be using to make 
the next awesome application. However there is an awesome (free) solution - 
[DropBox](http://getdropbox.com). [Dropbox](http://getdropbox.com) is a cool 
program that lets you sync up to 2GB of files between computers 
(it even has a \[very\] basic revision control system that lets you download/revert 
to previous versions of a file). The awesomeness comes into play when you realise 
that it's possible to create an svn repository *inside your dropbox folder*. 
You can then check out the svn repo locally using the url 
`file:///C:/path/to/dropbox/folder/myrepo`, and commit to it adhoc. 

Some of the major benefits of this are:

-   It's free
-   You always have access to the repository, even when you're offline!
-   As soon as you come online the dropbox app swoops in and uploads the repo, 
	backing it up on the dropbox servers and distributing it to your other computers
-   You have 2GB of space to play with - if you take a look at the major svn 
	hosts you'll see that they're charging at least $9 / month for this
-   Did I mention it's free?

Of course some of the (major) downsides to this are:

-   You don't get as many features as you would in a product such as 
	[beanstalkapp](http://www.beanstalkapp.com/pricing)
-   If you commit on one computer and then commit on another before dropbox 
	has synced the files you may end up with a corrupted repository

The last point is probably a good reason why you 
**should not use this setup to collaborate with multiple people**, but for 
syncing a personal project between work, home and a laptop :) 

It's also worth noting that you can do this with just about any SCM system 
(inc. [git](http://git-scm.com/))