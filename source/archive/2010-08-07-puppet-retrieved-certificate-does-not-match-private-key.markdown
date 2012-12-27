---

title: ! 'Puppet: Retrieved certificate does not match private key'
wordpress_id: 163
wordpress_url: http://that-matt.com/?p=163
date: 2010-08-07 23:08:52.000000000 +01:00
comments: true
---
I've been playing around with puppet recently and while trying to start up a 
client and get it to talk to the server I ran into this error:

> err: Could not request certificate: Retrieved certificate does not match private key; please remove certificate from server and regenerate it with the current key

Apparently the root cause of this error is that the client's ssl certificates 
have been messed up. 

To fix it you have to remove all of the client's ssl stuff, 
cd into the directory containing all the ssl info (/etc/puppet/ssl for me on a 
manual install of puppet 2.6) and remove all files, in all sub-directories, apart 
from `ca/serial`, which should contain 0000. 

Then on the server revoke the client's ssl certificate using:

    sudo pupetca --clean {client hostname}

Then restart the client, resign it on the server and you're good to go!