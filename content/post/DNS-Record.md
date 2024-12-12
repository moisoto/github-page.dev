---
title: "Verifying a DNS Record"
#description: <descriptive text here>
date: 2024-12-12T11:00:00-04:00
draft: false 
toc: false
#image: "/images/opengraph_tn.png"
images:
  - /images/DNS-logo-small.tiff
tags: [Bluesky, Tutorial, Tips, How-To]
categories: []
---

![DNS-Logo](/images/DNS-logo-small.tiff#floatleft)

I was recently asked why sometimes when settings TXT records on your domain DNS configuration it
took a while for the change for it to be seen by other servers. The reasons are various, mainly
DNS propagation delays. Here I'll show you how to verify the change has been applied.

<!--more-->

There are several tools that can be used for DNS Lookup. Here will cover three of them:

* **host**: Simple format. Concise output.
* **dig**: More options. Complex format.
* **nslookup**: Simple format. Query option is MacOS only. 

### Getting a TXT Record

Let's say you need a TXT record for `_acme-challenge.example.com`:

```shell
# Using host command:
host -t txt _acme-challenge.example.com

# Using dig command:
dig +noall +answer TXT _acme-challenge.example.com # Detailed
dig +short TXT _acme-challenge.example.com # Just show record

# Using nslooup (macOS only):
nslookup -query=TXT _acme-challenge.example.com | grep text
```

If you only have nslookup on your non-MacOS system or need to use it for some reason, 
you can write a script in the form of:

```shell
if [[ -z "$1" ]]; then
  echo "Must specify a domain name."
  exit
fi
nslookup << EOF
set type=TXT
$1
EOF
```

### Flushing the DNS Cache

If you want to make sure you get the most recent record you will probably need to flush the DNS cache manually.

On MacOS use the following commands:

```shell
sudo dscacheutil -flushcache
sudo killall -HUP mDNSResponder
```

### Getting the record from an external DNS Server

You can also get the most recent record by using an external DNS server.

For example to use the DNS Server at IP 8.8.8.8

```shell
dig +noall +answer TXT _acme-challenge.example.com @8.8.8.8
```

**Note:** Once you make a query to an external DNS server the entry will remain
cached up for some time. You will need to use another public DNS server if you make
further changes to your DNS record and want to verify the change has been applied.
