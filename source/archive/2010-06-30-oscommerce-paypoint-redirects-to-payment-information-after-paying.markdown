---

title: OSCommerce / Paypoint redirects to payment information after paying
wordpress_id: 140
wordpress_url: http://sigswitch.com/?p=140
date: 2010-06-30 20:52:05.000000000 +01:00
---
I was asked to do some work on an oscommerce site which was accepting payments 
from [paypoint](http://paypoint.net) (formally secpay) yet instead of redirecting 
the user to the "Thank you for your order" page it was sending them to the payment 
information page, and wasn't classing the order as being paid for. 

<!-- more -->

After a bit of debugging it turns out the problem stems from the paypoint-secpay 
merger and the fact that OSCommerce is a poorly supported hunk of junk. 
During a typical transaction paypoint will ask the user for their card details, 
and if the details check out it sends a request back to OSCommerce telling it 
that the transaction was a success. It will then display to the user whatever 
your server outputs. Thus your customers should see the "Thank you for your order" 
page appear under a url of "https://www.secpay.com/java-bin/ValCard". 

When oscommerce receives the "the transaction succeeded" message from secpay it 
looks at the ip address the message came from, and tries to resolve it to a hostname 
to see if it came from secpay.com. Since the merger the ip address that paypoint are 
using ﻿(in this case it was 81.93.226.30) doesn't resolve to secpay.com, in fact 
[it doesn't resolve to anything](http://whois.domaintools.com/reverse-ip/?hostname=81.93.226.30). 

If php can't resolve an ip address to a hostname then it gives up and returns 
the ip, thus oscommerce was trying to check that 'secpay.com' was the same as 
'81.93.226.30', which it isn't. To fix this I changed the before\_process() 
ethod in the secpay payment module to look like so:

```php
<?php
function before_process() {
    if ($_POST['valid'] == 'true') {
          if ($remote_addr = $_SERVER['REMOTE_ADDR']) {
          // Check that the request came from one of the secpay / paypoint servers
              if (strpos($remote_addr, '81.93.226') !== 0) {
                tep_redirect(tep_href_link(FILENAME_CHECKOUT_PAYMENT, tep_session_name() . '=' . $HTTP_POST_VARS[tep_session_name()] . '&payment_error=' . $this->code, 'SSL', false, false));
          }
        } else {
          tep_redirect(tep_href_link(FILENAME_CHECKOUT_PAYMENT, tep_session_name() . '=' . $HTTP_POST_VARS[tep_session_name()] . '&payment_error=' . $this->code, 'SSL', false, false));
        }
      }
    }
```

Ignoring for a second the horrible use of php3/php4 conventions, the method 
now checks to see if the sender's ip address begins with 81.93.226, as 
[paypoint seem to own](http://whois.domaintools.com/81.93.226.30) that range. 

Hopefully this will save someone else the headache
