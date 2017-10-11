Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x230.google.com (mail-lf0-x230.google.com. [2a00:1450:4010:c07::230])
        by gmr-mx.google.com with ESMTPS id j65si11041lje.3.2017.10.11.10.41.07
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Oct 2017 10:41:07 -0700 (PDT)
Received: by mail-lf0-x230.google.com with SMTP id 90so2927895lfs.13
        for <linux-ntb@googlegroups.com>; Wed, 11 Oct 2017 10:41:07 -0700 (PDT)
Return-Path: <fancer.lancer@gmail.com>
Date: Wed, 11 Oct 2017 20:41:14 +0300
From: Serge Semin <fancer.lancer@gmail.com>
Subject: Re: Is the Scratchpad Implementation Using a LUT Standard?
Message-ID: <20171011174114.GA25306@mobilestation>
References: <9aa73260-8b02-4e86-b7d4-9bc3afd745a6@googlegroups.com>
 <000001d341d2$87574f20$9605ed60$@dell.com>
 <6107eb07-3889-4f1a-ad50-264256772dae@googlegroups.com>
 <38ffd174-b66f-4077-8cdc-679e412242fc@googlegroups.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38ffd174-b66f-4077-8cdc-679e412242fc@googlegroups.com>
To: lsgunthorpe@gmail.com
Cc: linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

On Wed, Oct 11, 2017 at 09:19:20AM -0700, lsgunthorpe@gmail.com <lsgunthorpe@gmail.com> wrote:
> 
> 
> > Obviously LUTs are a precious resource, and a LUT per peer shared_mw is 
> > expensive. A LUT broken up into many shared_mw is a possibility, though 
> > there is always risk of trashing stuff.
> 
> 
> Well, as far as I know, switchtec is the only hardware with LUTs. But they 
> aren't that precious a resource. If I remember correctly, switchtec 
> supports up to 128 of them and up to 48 separate partitions so you could 
> easily have 2 LUTs per peer and still have plenty left over to do other 
> things with. And as far as we know now, there is no other use for LUT 
> windows. Thus, I would say, using one per peer is perfectly acceptable.
>  

You are mistaken. IDT PCIe switch have LUT. There are 24 of them available at
the current hardware for each NTB. All of them are available to be used over
IDT NTB driver as well as all MWs with direct address translation.
Additionally It is true to say about just one LUT entry usage per peer, only if
you got just two NTB-ports available per device. What if you got eight or even more
of them? In this case you'd need to have as many LUT entries reserved as there are
peers available to have connections to. In this case reservation doesn't seem so
inexpensive. As far as I can see from the switchtec brief documents, there can be
up to 48 NTBs per device. So in this case we'd loose 48 MWs just to have some
stupid scratchpads, which is, according to your words, a third part of all the LUT
MWs available to a port.

> On Tuesday, October 10, 2017 at 9:52:06 AM UTC-6, Doug Meyer wrote:
> >
> > Also, regarding your portability requirement. On one hand, it sounds like 
> > messages and scratchpads have distinct properties that make it advantageous 
> > to expose separately in ntb.h, and yet the portability requirement seems to 
> > want to abstract them as a single interface. Can you offer up any further 
> > thoughts on this, please?
> >
> 
> Yes, scratchpads and messages are distinct enough that you can't shoe-horn 
> messages into the scratchpad api (I tried this a long time ago). In the 
> end, drivers will really just need some interface to say "transfer this 
> information to peer X" and another interface for the peer to receive the 
> data. I agree with Allen in that we need a library to accomplish this based 
> on what the hardware provides through the NTB api. As it currently is 
> there's a lot of duplication in ntb_transport and ntb_perf for this. 
> 

Such library can be partly unpinned from my implementation of the ntb_perf driver,
which is currently at debug stage on Dave's Intel hardware (see the patchset in the
mailing list or here https://github.com/fancer/ntb).
There is a service subsystem in there, which encapsulates the ntb-messages and
ntb-scratchpads usage to setup the memory windows.
Everyone, who promised to implement such a library, can use the new ntb_perf driver
as a reference, obviously when we finally finished debugging it.
And yes, there is no good way to simulate the NTB-scartchpads using the
NTB-messaging. I tried it at my first attempt to develop the IDT NTB driver.
These interfaces are too different. And I'd say we shouldn't do it, since
they are the hardware specifics, which must be reflected by NTB API. 

> 
> > For now, I'm likely to merely create an array of shared_mw based on 
> > partition number and restrict the Switchtec configuration to use only the 
> > first four partitions. But if somebody says "I was thinking that this would 
> > actually be best done as Y, and it's probably little more work than your 
> > near-term hack" then I'm sure going to listen!
> >
> 
> This was my long term plan too: create one shared_mw per peer. Though, I 
> see no reason to restrict the implementation to 4 partitions. Creating an 
> N-way mapping shouldn't be much harder than a 4-way mapping.
> 

As I said before. It is not much harder to create switchtec N-ports hardware
driver then make it just for four ports. You'll need to have the ports descriptors
array in any case. I did the same in the IDT NTB hardware driver. You can check it
out in the code.

Regards,
-Sergey

> Thanks for your work on this,
> 
> Logan
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/38ffd174-b66f-4077-8cdc-679e412242fc%40googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.

