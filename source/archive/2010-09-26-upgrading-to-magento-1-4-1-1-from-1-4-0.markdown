---
title: Upgrading to Magento 1.4.1.1 from 1.4.0
wordpress_id: 179
wordpress_url: http://that-matt.com/?p=179
date: 2010-09-26 18:18:40.000000000 +01:00
comments: true
---
I recently had to upgrade an installation of magento 1.4.0 to version 1.4.1.1. 
As anybody who's ever tried to upgrade magento will tell you, the upgrade path 
is usually less than ideal (For some people the only way to upgrade from 1.3 to 
1.4 was to manually export / import their data into a new installation).

As strange as it seems, it appears the most reliable way to upgrade an installation 
is to install the new version over **a copy** of the old version's database. 
(Note, you should never attempt to install over the production database lest 
things go wrong!) Here's a quick guide on how I managed to get the installation 
in question upgraded, hopefully it'll work for you too! :)

<!-- more -->

## Get rid of any coupon codes

If you try and upgrade magento without doing this then the installer will fail 
with a "foreign key constraint fails" error. 
You should make a note of your codes so that you can re-add them to your 
upgraded store.

## Copy the database

In my experience the fastest way to get a copy of the database is to use the
`mysqldump` command on the server over ssh.

    mysqldump -u{username} -p {database_name} > production_backup.sql

Obviously you should replace {username} and {database\_name} with their 
appropriate values. You'll also be asked for the db user's password when the 
program connects to the mysql server. If you don't have shell access on your 
server then you can always use another tool such as phpmyadmin, but it's slower 
and less secure.

## Download a fresh copy of Magento 1.4.1.1

We now need to download a fresh copy of magento and put it in a separate place 
from the production site (e.g. testing.{yoursite}.com) where we can run the 
upgrade safely. See the magento wiki for more info on 
[downloading magento from a shell][magento-shell-install].

From now on I'll refer to the directory you extracted the code to as the 
"upgrade test" directory. 
You should also create a separate database to run the upgrade on.

## Modify the Magento Installer

One of the big issues with the installer supplied with magento is that they 
assume all of the tables it tries to create don't exist (which isn't the case).

To get around this we run a quick find & replace in the root of the new "upgrade test" magento installation:

    find . \
        -type f -name "*.php" \
        -exec sed -r -i  \
        "s/CREATE TABLE \`?\{([^}]+)\}\`? \(/CREATE TABLE IF NOT EXISTS \`\{\1\}\` \(/g" \
        {} \;

If you're not familiar with sed, this command basically looks in php files for 
the string 

	CREATE TABLE {table_name} (

and replaces it with 

	CREATE TABLE IF NOT EXISTS {table_name} (

You should execute it in your upgrade test directory, not in the production site dir.

## Run the installer

If you browse to your testing installation (i.e. http://testing.yoursite.com) 
you should be redirected to the magento web installer, which should allow you to 
"install" magento. 

**When it asks you for a security / encryption key make sure you give the same key that your production install is using.** 

If you can't remember what key your production install is using then have a look 
in app/etc/local.xml in your production installation. You should see something like:

	<![CDATA[fihfw9393rjW3493jwfwfj93jfww]]>

In this example the key is `fihfw9393rjW3493jwfwfj93jfww`.

## Chillax!

At this point you should hopefully have a fully functioning version of 1.4.1, 
sans custom theme / installed modules / product images. 

To migrate the product images remove the media dir and copy the one from your 
production installation over. If something broke during the upgrade then you'll 
need to find the cause of the problem and then re-attempt the upgrade afresh.

[magento-shell-install]: http://www.magentocommerce.com/wiki/groups/227/installing_magento_via_shell_ssh
