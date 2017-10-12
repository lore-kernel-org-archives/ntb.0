Return-Path: <dmeyer@gigaio.com>
Received: from mail-ua0-x22d.google.com (mail-ua0-x22d.google.com. [2607:f8b0:400c:c08::22d])
        by gmr-mx.google.com with ESMTPS id 5si267040qki.1.2017.10.12.11.31.06
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Oct 2017 11:31:06 -0700 (PDT)
Received: by mail-ua0-x22d.google.com with SMTP id s41so3654885uab.10
        for <linux-ntb@googlegroups.com>; Thu, 12 Oct 2017 11:31:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <ef57a986-936e-ba87-663e-b8866a6b9fcd@gmail.com>
References: <9aa73260-8b02-4e86-b7d4-9bc3afd745a6@googlegroups.com>
 <000001d341d2$87574f20$9605ed60$@dell.com> <6107eb07-3889-4f1a-ad50-264256772dae@googlegroups.com>
 <38ffd174-b66f-4077-8cdc-679e412242fc@googlegroups.com> <20171011174114.GA25306@mobilestation>
 <ef57a986-936e-ba87-663e-b8866a6b9fcd@gmail.com>
From: D Meyer <dmeyer@gigaio.com>
Date: Thu, 12 Oct 2017 11:31:05 -0700
Message-ID: <CA+GK6ekKuvkzLod=LJ4+MqVH0MTKwyQTcvOpUEzfBAjkGeYyBg@mail.gmail.com>
Subject: Re: Is the Scratchpad Implementation Using a LUT Standard?
Content-Type: text/plain; charset="UTF-8"
To: Logan Gunthorpe <lsgunthorpe@gmail.com>
Cc: Serge Semin <fancer.lancer@gmail.com>, linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

On Wed, Oct 11, 2017 at 11:03 AM, Logan Gunthorpe <lsgunthorpe@gmail.com> wrote:
> On 11/10/17 11:41 AM, Serge Semin wrote:
>
>> You are mistaken. IDT PCIe switch have LUT. There are 24 of them available
>> at
>> the current hardware for each NTB. All of them are available to be used
>> over
>> IDT NTB driver as well as all MWs with direct address translation.
>> Additionally It is true to say about just one LUT entry usage per peer,
>> only if
>> you got just two NTB-ports available per device. What if you got eight or
>> even more
>> of them? In this case you'd need to have as many LUT entries reserved as
>> there are
>> peers available to have connections to. In this case reservation doesn't
>> seem so
>> inexpensive. As far as I can see from the switchtec brief documents, there
>> can be
>> up to 48 NTBs per device. So in this case we'd loose 48 MWs just to have
>> some
>> stupid scratchpads, which is, according to your words, a third part of all
>> the LUT
>> MWs available to a port.
>
> Ah, fair, I wasn't aware the IDT had LUT support. Using up a third of the
> LUT windows
> does not seem like a problem at all considering we have no other use for
> them.
> Note: the switchtec code also used the shared_mw for link management, not
> just
> providing scratchpads. But once the upper layers are reworked to not require
> scratchpads I'd be fine with removing them from the shared_mw.

Dear Logan, everyone,

It seems like there are LOTs of uses for LUTs.

Imagine accessing PiB of storage that uses memory semantics (early
last year PCI-SIG noted a vendor selling an endpoint capable of 2 TB),
a sea of GPGPU cards, etc. in a heterogeneous cloud computing
environment, and wanting to control access to windows of that stuff
being used by multiple applications running in one or more hosts. A
small number of windows are not sufficient. LUTs provide a good method
for being able to establish long-lasting as well as ephemeral
translations and, in conjunction with IOMMU, PCIe's ACS, etc. as well
as various QoS features could provide a good start on data protection
and client performance.

This much bigger than ntb_transport  to support networks with some
NVMe drives and GPU endpoints. Fun!

LUTs aren't an afterthought. I think they're really valuable.

Blessngs,
Doug
