---

title: Virtualbox - 1 differencing child hard disks
wordpress_id: 99
wordpress_url: http://sigswitch.com/2009/11/virtualbox-1-differencing-child-hard-disks/
date: 2009-11-07 01:00:06.000000000 +00:00
---

If you're getting an error along the lines of 

> {hard disk} cannot be directly attached to the virtual machine because it has 1 differencing child hard disks

Then the solution is to delete the virtual machine (but not the hard disk!) 
and recreate the machine using the hard disk.