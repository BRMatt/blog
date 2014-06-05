---
title: I know what we did last Friday
date: 2014-4-11 15:45:25.000000000 +01:00
---

If there's one tool I couldn't live without in our production app, it's logging.

The database tells us what the state of our application *currently* is.
Our logs tell us how we got into this state.

When developing a rails app chances are your first encounter of logs will be something like
this:

```
=> Booting WEBrick
=> Rails 3.2.17 application starting in development on http://0.0.0.0:3000
=> Call with -d to detach
=> Ctrl-C to shutdown server
[2014-04-11 02:19:46] INFO  WEBrick 1.3.1
[2014-04-11 02:19:46] INFO  ruby 2.0.0 (2013-11-22) [x86_64-linux]
[2014-04-11 02:19:46] INFO  WEBrick::HTTPServer#start: pid=6662 port=3000

Started GET "/" for 127.0.0.1 at 2014-04-11 02:19:52 +0100
[deprecated] I18n.enforce_available_locales will default to true in the future. If you really want to skip validation of your locale you can set I18n.enforce_available_locales = false to avoid this message.
Processing by HomeController#index as HTML
  User Load (0.5ms)  SELECT "users".* FROM "users" WHERE "users"."id" = 1 AND LIMIT 1
  Rendered homepage.html.erb (0.3ms)
  Rendered layouts/site.html.erb (28.4ms)
Completed 200 OK in 37.5ms (Views: 30.7ms | ActiveRecord: 1ms)
```

This set of logs describe what your implementation is doing. While this is fine during development
when trying to produce an implementation, in production a lot of the details are unecessary and add to the noise.

Consider this line for the SQL query:

```
  User Load (0.5ms)  SELECT "users".* FROM "users" WHERE "users"."id" = 1 AND LIMIT 1
```

This line will likely be 99% the same for every user that hits the page, the only thing that will change is the 
`1` in the query's conditions. We're also unaware of what this query was for. Is it loading the currently
signed in user, displaying a random user, or fetching a specific user the application's been asked for?

We don't know.
