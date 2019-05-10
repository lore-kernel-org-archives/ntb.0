Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id d197si563863iof.2.2019.05.09.19.02.57
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 19:02:57 -0700 (PDT)
References: <dfedc9af-85cd-4b78-9249-3ce794fbe3b5@googlegroups.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <b4d7e6a6-8637-bf15-0ec9-e1024ead9933@deltatee.com>
Date: Thu, 9 May 2019 20:02:54 -0600
MIME-Version: 1.0
In-Reply-To: <dfedc9af-85cd-4b78-9249-3ce794fbe3b5@googlegroups.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: NTB connectivity issue under heavy load
To: trifundroid94@gmail.com, linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>



On 2019-05-06 8:43 a.m., trifundroid94@gmail.com wrote:
> Hello everyone,
> 
> I am not sure if this is the right place to ask but I am going to anyway
> since this problem has been bothering us for quite some time now.
> 
> A PC running kernel 4.16.7 and TI's ARM based SoC running kernel 4.14
> are connected via NTB.
> The ntb_netdev drivers are correctly loaded on both sides and the hosts
> are able to ping each other indefinitely. However, when under some
> heavier load, the connection breaks. At first we thought that it only
> happens when running TCP but it also happened for UDP as a transport
> protocol.
> The Wireshark logs show that the hosts simply forget where the other
> side is regarding ARP protocol. In other words, they know the IP of the
> peer but not its MAC address. We have not found a way to somehow
> hardcode this, especially knowing that the MAC address of the virtual
> eth made by ntb_netdev driver is randomized. The only solution is to
> restart the whole system and start again which is unacceptable.
> 
> Has this behavior been observed before? Is there any fix for this?

I've never seen this and I'm not sure I can be much help but you should
maybe try checking the debugfs entries for ntb transport to see if
packets are still getting through. Just to narrow down the issue. Are
packets no longer getting through and thus arp requests are failing? Or
is this a problem on a higher layer with addressing?

Logan
