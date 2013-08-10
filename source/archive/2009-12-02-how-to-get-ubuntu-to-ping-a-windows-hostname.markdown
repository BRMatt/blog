---

title: How to get Ubuntu to ping a Windows hostname (and vice-versa)
wordpress_id: 47
wordpress_url: http://www.sigswitch.com/?p=47
date: 2009-12-02 21:00:28.000000000 +00:00
---
I'm currently running ubuntu server in a virtual machine on my pc, and one of the 
annoying problems I've always had with ubuntu is that it never seems to be able 
to resolve the hostnames of machines running windows. 

After a little bit of digging I found a really simple solution
[in this forum topic](http://ubuntuforums.org/showthread.php?t=88206)

> All you have to do is:
>
> `sudo nano /etc/nsswitch.conf`
> 
> change the line that says
>
> `hosts: files dns`
> 
> to this:
>
> `hosts: files wins dns`
> 
> (order does matter) finally, you need to install winbind
>
> `sudo apt-get install winbind`
>
> To enable windows to ping ubuntu you then need to install samba:
>
> `sudo apt-get install samba winbind`

Job done.
