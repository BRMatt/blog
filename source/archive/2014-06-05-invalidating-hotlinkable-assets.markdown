---
title: Tips for invalidating hotlinkable assets
date: 2014-06-05 00:00:00.000000000 00:00
meta:
  description: Tips on invalidating assets that need to be hotlinked from Heroku on other domains.
  tags: ruby, cloudfront, rails, ror, sinatra, asset pipeline, coffeescript, javascript, ruby on rails, cloudfront, memberful, cdn, cache, cache invalidation, heroku
---

One of [Memberful](https://memberful.com)'s features is that all links to a customer's
Memberful checkout/member account panel [can be shown in an overlay](https://memberful.com/help/general/memberful-overlay/)
on the customer's [normal site](https://thethemefoundry.com/wordpress-themes/oxford/).

[![An example of the Memberful overlay](2014-06-05-memberful-overlay.png)](https://thethemefoundry.com/wordpress-themes/oxford/)

The JS that loads the overlay on the customer's site is served via the cloudfront CDN to minimise
requests against our Heroku dynos.

The filename for this asset has to be identical across deploys so that our customers'
sites don't need to change every time we deploy. The side effect of this is that we can't benefit from
automatic cache invalidation from
[asset fingerprinting](http://guides.rubyonrails.org/asset_pipeline.html#what-is-fingerprinting-and-why-should-i-care-questionmark),
so by default Cloudfront caches our assets until they expire, regardless of when we last deployed.

To get around this we wrote [a small sinatra app](https://github.com/memberful/cloudfront-invalidator)
that listens for pings from a webhook, and issues an invalidation request for the asset to cloudfront.
(On a side note, Heroku only allow you to have one deployment webhook. We were already using ours to [log deploys
to Librato](https://github.com/librato/librato-annotate), so we setup a [papertrail](https://papertrail.com)
webhook to ping the app whenever Heroku logged a deployment event.)

Usually cloudfront invalidations take around 30 minutes to complete. This isn't terribly fast, but it's a darn
sight faster than waiting for the asset to expire!

## Debugging invalidations

Unfortunately problems happen, and sometimes invalidations can't be issued.
For example, during the recent heartbleed scare we rolled all our credentials for 3rd party services, but forgot
to update the credentials the sinatra app uses to invalidate assets on cloudfront. Unfortunately this wasn't
immediately obvious, and resulted in us serving stale versions of the asset for a few days.

One useful tip we discovered while trying to debug this is to add a debug statement in the javascript file
that logs the date the asset was compiled. This means you don't need to dive into the network
inspector every time you need to check how fresh an asset is.

In a Rails application this is as simple as adding an `.erb` extension to your JS file (e.g. `app.js.erb`)
and inserting the following line somewhere in the file (preferably towards the top):

```js
if (typeof console != "undefined") {
  console.log("app.js built on <%= Time.now.utc %> in <%= ::Rails.env %>");
}
```

Simple, but incredibly helpful.
