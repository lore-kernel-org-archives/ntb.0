Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id w2si838289otg.4.2017.12.04.19.44.12
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Dec 2017 19:44:12 -0800 (PST)
References: <20171204175721.10322-1-logang@deltatee.com>
 <CAJQW-Q6DXi4ipyc_cKfa=HYAqcu1sstJXU1mJmqvWH1c1aGePA@mail.gmail.com>
 <0f0a4d34-ed0b-99cf-8f7d-d47e62235a3b@deltatee.com>
 <CAJQW-Q733PvoghsDMiRwp7w34h+oXVwxr_g45Z-_Wu4=NQCMuA@mail.gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <b02bdb42-d7fe-32dd-a591-bff7d882b97c@deltatee.com>
Date: Mon, 4 Dec 2017 20:44:09 -0700
MIME-Version: 1.0
In-Reply-To: <CAJQW-Q733PvoghsDMiRwp7w34h+oXVwxr_g45Z-_Wu4=NQCMuA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] ntb_hw_switchtec: Force down the link before
 initializing
To: ThanhTuThai <cruisethai@gmail.com>
Cc: linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

Everything you said is very vague. In the future you should try to be
more specific. Nothing beats actual dmesg output, even if the log
message you're referring to (I can only assume which one because you
didn't say) isn't there, then there might be other clues as to why that
is. Trying to debug based on vague statements and incomplete information
is very hard.

I had another thought that might explain what you are seeing, but
without actual debug information to confirm, I don't think I'm going to
bother trying it.

If you're confident in your diagnosis then I suggest you contact
Microsemi about the issue.

Should we merge v1 of the patch seeing it fixes the soft-reboot issue?

Logan



On 04/12/17 08:34 PM, ThanhTuThai wrote:
> Dear Logan,
> 
> The evidence is the "printk" in interrupt routine.
> For software-reboot, the "printk" printed out perfectly.
> For power-reset, it didn't, is it enough ?
> 
> I actually try your patch, and I even wrote the solution you suggested,
> I also implemented it myself before, but no message received from the
> crashed peer, I said that to you many times.
> 
> I didn't send you the log, b/c nothing there, it doesn't receive any
> message, so it didn't log anything.
> 
> Anyway, thanks for you support !!!
> 
> On 5 December 2017 at 11:00, Logan Gunthorpe <logang@deltatee.com
> <mailto:logang@deltatee.com>> wrote:
> 
> 
> 
>     On 04/12/17 06:47 PM, ThanhTuThai wrote:
>     > The problem is that the good host even didn't receive any message when
>     > the crashed peer come up, so your  "re-init scheduled work" will not be
>     > activated.
>     > Because the good peer didn't receive any interrupt to activate the
>     > scheduled work.
> 
>     What's your evidence here? You haven't really sent me anything to go on.
>     Did you actually try the patch or did you just assume it doesn't work?
> 
>     In any case, if your assertion is correct, then it's a firmware issue
>     and you'll have to contact Microsemi and get them to look at it.
> 
>     Logan
> 
> 
> -- 
> You received this message because you are subscribed to the Google
> Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send
> an email to linux-ntb+unsubscribe@googlegroups.com
> <mailto:linux-ntb+unsubscribe@googlegroups.com>.
> To post to this group, send email to linux-ntb@googlegroups.com
> <mailto:linux-ntb@googlegroups.com>.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/linux-ntb/CAJQW-Q733PvoghsDMiRwp7w34h%2BoXVwxr_g45Z-_Wu4%3DNQCMuA%40mail.gmail.com
> <https://groups.google.com/d/msgid/linux-ntb/CAJQW-Q733PvoghsDMiRwp7w34h%2BoXVwxr_g45Z-_Wu4%3DNQCMuA%40mail.gmail.com?utm_medium=email&utm_source=footer>.
> For more options, visit https://groups.google.com/d/optout.
