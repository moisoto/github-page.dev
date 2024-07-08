---
title: "Setting up your BlueSky Custom Domain Handle"
#description: <descriptive text here>
date: 2024-06-27T10:00:00-04:00
draft: false 
toc: false
#image: "/images/opengraph_tn.png"
images:
  - /images/bluesky_banner_med.jpg
tags: [Bluesky, Tutorial, Tips, How-To]
categories: []
---

![BlueSky-Logo](/images/bluesky_logo_small.png#floatleft)

If you love how Twitter felt at the start and are looking for a nice alternative, you probably already tried [BlueSky](https://bsky.app). If you haven't, this is the best time to do it. You don't need invites anymore and everyone can join.

This article will show you how to use one of the cooler features of this new platform: *Using your own domain as your user handle*. This is very useful, specially if you have a brand account with a website and you want users to have confidence they are actually interacting with you.

<!--more-->

To start using your domain open [BlueSky](https://bsky.app) and Go to Settings -> Advanced -> Change Handle:

![BlueSky-ChangeHandle](/images/bluesky_ch.jpeg#floatcenter)

{{< linebreak >}}

On the next screen click the link that says **I have my own domain** and the following will appear:

![BlueSky-ATprotoDNS](/images/bluesky_dns.png#floatcenter)

If you have access to your DNS Panel on the domain provider you can use the provided parameters to create a DNS entry:

* Select TXT Record as the record type
* On the field **Host** type **\_atproto**
* On the field **Value** or **IP Address** type the code that begins with **did=did:** 
* Save your DNS record and click the button that says **Verify DNS Record**

If you don't have access to your DNS panel, but can upload files to your website, then click No DNS Panel and the following information will appear:

![BlueSky-WellKnown](/images/bluesky_wk.png#floatcenter)

Notice that you will need to create a folder named **.well-known** at the root of your website, there you will put a file named **atproto-did** which must contain the provided code that begins with **did:**

Finally, click the button that says **Verify Text File** 

**Important:** Do not remove the DNS record or atproto-did file since BlueSky will periodically verify them to make sure the handle is still valid.
