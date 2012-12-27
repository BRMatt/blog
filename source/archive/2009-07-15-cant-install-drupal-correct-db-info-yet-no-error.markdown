---

title: Can't Install Drupal? Correct DB info yet no error?
wordpress_id: 90
wordpress_url: http://sigswitch.com/2009/07/cant-install-drupal-correct-db-info-yet-no-error/
date: 2009-07-15 22:33:20.000000000 +01:00
---

The solution is to make sure that: 

- You have a copy of `default.settings.php` in the sites directory to which you 
  are installing drupal
- Make sure the default directory still exists with its own copy of 
  `default.settings.php` / `settings.php` 

It's a very weird bug