---
title: Apache can't connect to remote MySQL server, but scripts can
date: 2010-07-07 22:00:50.000000000 +01:00
---
Today at work we were migrating some sites to a new server infrastructure with 
the different services (i.e. php, mysql, mail) spread over different servers. 
One problem we ran into whilst setting this up was that php scripts running through 
apache were having trouble connecting to the mysql server. 

<!-- more -->

What was even stranger though, was the fact that this problem only appeared when 
the php script(s) were run through apache - running them through the command 
line / shell worked absolutely fine. After a couple of hours of debugging, 
head bashing and confusion we found the solution at the bottom of one of those 
very very long [experts exchange](http://www.experts-exchange.com/Database/MySQL/Q_22606034.html) threads. 

It turns out that some linux distros has a neat little access control system 
called SELinux which was blocking communication by apache to remote database servers. 
The aforementioned exchange thread suggests disabling SELinux entirely by executing

    sudo setenforce 0

but this isn't a permanent solution and won't persist through a reboot 
[without changing a config file](http://googolflex.com/?p=482).

> This can be accomplished by changing a line in /etc/selinux/config. 
>
> Change the line that says: `SELINUX=enforcing` to `SELINUX=disabled`

However, if you're willing to do a bit of digging there are 
[SEL options](http://www.beginlinux.com/server_training/web-server/976-apache-and-selinux) 
you can change to [grant apache access to remote database servers](http://www.redhat.com/docs/en-US/Red_Hat_Enterprise_Linux/6-Beta/html/Security-Enhanced_Linux/sect-Security-Enhanced_Linux-Booleans-Configuring_Booleans.html), and if you have a few hours to kill, there's also [the fedora documentation](http://docs.fedoraproject.org/en-US/Fedora/13/html/SELinux_FAQ/index.html). Hopefully this'll save someone else the headache we had!
