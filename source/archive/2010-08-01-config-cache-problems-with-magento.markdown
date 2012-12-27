---
layout: post
title: Config cache problems with Magento
wordpress_id: 158
wordpress_url: http://that-matt.com/?p=158
date: 2010-08-01 20:18:00.000000000 +01:00
---
After having numerous problems upgrading a Magento site 1.4.1.1 on a test server 
I decided to try and get it working locally before applying the fix(es) to the 
live server. 

This is a fairly simple process and there's [lots][magento-base-url] of 
[information][magento-info] on how to do it. 
The key steps in the process are emptying magento's cache directory and 
updating the base urls in the `core_config_data` table so that magento 
will generate correct urls. 

<!-- more -->

When I setup my copy of the site locally I changed `local.xml` & deleted the 
cache before modifying the db, just to make sure that magento was connecting ok. 

Once that was done I went off to delete the new cache files from `siteroot/var/cache`.

Only, there weren't any cache files. I took no note of it figuring magento had 
just decided not to cache the files and so proceeded to load the site, only for 
it to redirect me to the live site. 

I spent the next few hours trying in vain to work out where magento was getting 
the idea that it should redirect to the main site. After wiping the db/files and 
re-extracting them several times I noticed that it was still redirecting even if
the database was empty and the cache dir (var/cache) didn't exist. 

Obviously this is one helluva wtf, especially as there weren't any references to
the live site's address in the files. The opinion on IRC was that somehow my 
local site was talking to the production site's db and was using it's database
instead of my local one, however this couldn't be the case as magento started
complaining if I dropped the local database entirely.

In a last ditch attempt I tried grepping for the site's address across the
entire filesystem (using `grep -R "sitedomain.com" / `) and came across a 
load of files in `/tmp/magento`. After deleting the directory magento started 
working perfectly again, though it continued to store cache files in 
`/tmp/magento` rather than `var/cache/` for some reason.cache files in 
`/tmp/magento` rather than `var/cache/` for some reason.

[magento-base-url]: http://blog.chandanweb.com/magento/how-to-change-base-url-in-magento
[magento-info]: http://www.magentocommerce.com/wiki/groups/227/moving_magento_to_another_server