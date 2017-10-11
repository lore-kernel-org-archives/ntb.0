Return-Path: <lsgunthorpe@gmail.com>
Received: from mail-it0-x244.google.com (mail-it0-x244.google.com. [2607:f8b0:4001:c0b::244])
        by gmr-mx.google.com with ESMTPS id y128si698900ywa.6.2017.10.11.11.03.07
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Oct 2017 11:03:07 -0700 (PDT)
Received: by mail-it0-x244.google.com with SMTP id y15so4084953ita.4
        for <linux-ntb@googlegroups.com>; Wed, 11 Oct 2017 11:03:07 -0700 (PDT)
Return-Path: <lsgunthorpe@gmail.com>
Subject: Re: Is the Scratchpad Implementation Using a LUT Standard?
References: <9aa73260-8b02-4e86-b7d4-9bc3afd745a6@googlegroups.com>
 <000001d341d2$87574f20$9605ed60$@dell.com>
 <6107eb07-3889-4f1a-ad50-264256772dae@googlegroups.com>
 <38ffd174-b66f-4077-8cdc-679e412242fc@googlegroups.com>
 <20171011174114.GA25306@mobilestation>
From: Logan Gunthorpe <lsgunthorpe@gmail.com>
Message-ID: <ef57a986-936e-ba87-663e-b8866a6b9fcd@gmail.com>
Date: Wed, 11 Oct 2017 12:03:04 -0600
MIME-Version: 1.0
In-Reply-To: <20171011174114.GA25306@mobilestation>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
To: Serge Semin <fancer.lancer@gmail.com>
Cc: linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

On 11/10/17 11:41 AM, Serge Semin wrote:

> You are mistaken. IDT PCIe switch have LUT. There are 24 of them available at
> the current hardware for each NTB. All of them are available to be used over
> IDT NTB driver as well as all MWs with direct address translation.
> Additionally It is true to say about just one LUT entry usage per peer, only if
> you got just two NTB-ports available per device. What if you got eight or even more
> of them? In this case you'd need to have as many LUT entries reserved as there are
> peers available to have connections to. In this case reservation doesn't seem so
> inexpensive. As far as I can see from the switchtec brief documents, there can be
> up to 48 NTBs per device. So in this case we'd loose 48 MWs just to have some
> stupid scratchpads, which is, according to your words, a third part of all the LUT
> MWs available to a port.
Ah, fair, I wasn't aware the IDT had LUT support. Using up a third of 
the LUT windows
does not seem like a problem at all considering we have no other use for 
them.
Note: the switchtec code also used the shared_mw for link management, 
not just
providing scratchpads. But once the upper layers are reworked to not 
require
scratchpads I'd be fine with removing them from the shared_mw.

Logan
