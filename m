Return-Path: <jdmason@kudzu.us>
Received: from mail-vk0-x22b.google.com (mail-vk0-x22b.google.com. [2607:f8b0:400c:c05::22b])
        by gmr-mx.google.com with ESMTPS id q15si284120ioh.5.2017.11.27.08.39.15
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Nov 2017 08:39:15 -0800 (PST)
Received: by mail-vk0-x22b.google.com with SMTP id l189so8959822vkl.6
        for <linux-ntb@googlegroups.com>; Mon, 27 Nov 2017 08:39:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAJQW-Q4_hJ+23T0qhK9BRMbcfqdF7rnJkWWPmGKfN5WzyD-eJg@mail.gmail.com>
References: <CAJQW-Q4_hJ+23T0qhK9BRMbcfqdF7rnJkWWPmGKfN5WzyD-eJg@mail.gmail.com>
From: Jon Mason <jdmason@kudzu.us>
Date: Mon, 27 Nov 2017 11:39:13 -0500
Message-ID: <CAPoiz9zzL6jZeCa4o+AQN2j8J-5nMxQkojWdVEAb96==+v+awg@mail.gmail.com>
Subject: Re: Ntb Transport Driver Problem After Power-up
Content-Type: text/plain; charset="UTF-8"
To: ThanhTuThai <cruisethai@gmail.com>
Cc: linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

(Ccing NTB mailing list)

On Sun, Nov 19, 2017 at 9:36 PM, ThanhTuThai <cruisethai@gmail.com> wrote:
> Dear Jon,
>
> We are using Ntb_transport driver from Linux with Microsemi's ntb hardware.
> We get a problem when one peer suddenly power off without removing the
> drivers, after it powers up again, the good peer cannot reconnect with it
> again, the good peer need to reload the drivers in order to reconnect to it.
> I guess the good peer need to re-init some thing in order to catch up with
> another one, but I don't what it is.
>
> I knew that, when one peer starts, the driver will send out a message
> through doorbell, when another peer catch that message, I can announce the
> ntb_transport link-down ( ntb_link_event(&sndev->ntb); ).
>
> But in this case, when one peer power down and up the good peer don't
> receive any message from it in the interrupt (switchtec_ntb_message_isr),
> although I have check that, it already sent out the message.
>
> Do you have any idea about it ?

It sounds like the link down/up isn't working properly.  Is the
Microsemi NTB not able to detect a link down?

Thanks,
Jon

>
> Thank you very much !
