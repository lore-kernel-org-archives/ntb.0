Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CD67B
	for <ntb@lists.linux.dev>; Wed,  9 Mar 2022 14:35:41 +0000 (UTC)
Received: by mail-yb1-f171.google.com with SMTP id l2so4741886ybe.8
        for <ntb@lists.linux.dev>; Wed, 09 Mar 2022 06:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PI8jzGFtaafjNUrCfYs9Kl/SicW10Mhg+mySlxxyBOI=;
        b=Ce/rWLh53KgAhxA4j2LF/S9RjiY3QzA15QGnbclqvP35wdvFqar8AIHJkQJKud5310
         +gsOvapZFgWUqiA9F8YkntnA+FJ4hHJVV5mSt+rQQffe6ekpGg3xlEewBbF3/SKV45T9
         LzG6/M4r6C8E1vQA2OSUz/O5Ripg7jxfYqBjurZNBHTKZkqwBzS8rjsrSovix3NxQYaD
         r4B0K3WTq83kjjA6PL6JL3eZ+4dgyeBQBeqpj60OSM8w5mL5u1ka1l5ed/6Lxv82V6HL
         5/rxgOD7zMNsm3jplgfEEW5iUOo6q1bgx82vvDu1d4vDKKW35M6E7J1eoj+8X2/6/SBz
         WhVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PI8jzGFtaafjNUrCfYs9Kl/SicW10Mhg+mySlxxyBOI=;
        b=skDOsCB8NswR6qbX+Wog/H9nd3ILHCkJLS4onQjSPUZZkrdL/J+b0hnNK7+RNL47cF
         2F9vuO7Qi62sG6/pwNdNCrKwFyVXHVuwoOqYRMJdCOr/vQR4Ue74TlwKvrrQaZZz01AN
         kkyXtq7ai62rR+cd4QYyQmKUPCyH4Q3ZaKj5EpC0JYcERwU3MqdAhmwuCTDp0L0S9/7x
         tKCv/kme5qWxRcQ5M76w1Xy/HyUMGIJQsP2jpQmZbEhY5Wml3jRm3Fg4fw9IfLKZSLvv
         slZsCW497rH9nAYcla1VqdtzFoL9mul5RVgL2F3oyVcaf9/8IYhwztrTxszrI7QJAQx7
         O9PQ==
X-Gm-Message-State: AOAM532Jb6zDmdcIBGCzWJSoLotB7O3YWqx4zNA1oK78keZhWc41W88M
	2mjsSvZEpO4vm4r5Tnhm0KHiyma3C4bIMsd2PM4=
X-Google-Smtp-Source: ABdhPJyX1Hfsgr1JIUWzgZpv9Tt4Gi0+X/HLgIybwLyetSEXFeF/SABQELhXiESUFhaiKJD3N97vK434vhc7z/yui2w=
X-Received: by 2002:a25:e012:0:b0:629:1b18:4741 with SMTP id
 x18-20020a25e012000000b006291b184741mr15997061ybg.307.1646836540176; Wed, 09
 Mar 2022 06:35:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAH6h+hfwRFMW47ONT+zC8Z1Y-30gb4dPEwTOtatN86EMeUajpA@mail.gmail.com>
 <1d53b232-dc0a-c7d3-69a1-8cb17ff83601@deltatee.com> <CAH6h+hdbOEjpU5tn+MwDm-h=47b4kzMHDZhSc51hA0VOZLp_8g@mail.gmail.com>
 <48234e72-3458-f90b-234d-f1ffccef996f@deltatee.com>
In-Reply-To: <48234e72-3458-f90b-234d-f1ffccef996f@deltatee.com>
From: Marc Smith <msmith626@gmail.com>
Date: Wed, 9 Mar 2022 09:35:29 -0500
Message-ID: <CAH6h+hd7o7fWFVmPSn86SrgnHC5X_jfdRtn1=dAF=8w8knJK1g@mail.gmail.com>
Subject: Re: ntb_netdev Communication Failure Issue
To: Logan Gunthorpe <logang@deltatee.com>
Cc: ntb@lists.linux.dev, Kelvin Cao <kelvin.cao@microchip.com>, kelvincao@outlook.com
Content-Type: text/plain; charset="UTF-8"

On Thu, Feb 17, 2022 at 11:50 AM Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
>
>
> On 2022-02-17 8:22 a.m., Marc Smith wrote:
> > On Wed, Feb 16, 2022 at 12:14 PM Logan Gunthorpe <logang@deltatee.com> wrote:
> >>
> >> Hi Marc,
> >>
> >>
> >> On 2022-02-16 9:16 a.m., Marc Smith wrote:
> >>> Hi,
> >>>
> >>> I'm using vanilla Linux 5.4.145 with a Celestica "cluster-in-a-box"
> >>> system (two servers in a single chassis connected internally via PCIe
> >>> switches). The PCIe switches are Microsemi Switchtec ('lspci' says
> >>> "PMC-Sierra Inc. PM8546 B-FEIP PSX 96xG3 PCIe Storage Switch
> >>> [11f8:8546]" but I believe this is not the current product/model name
> >>> from Microsemi).
> >>>
> >>> I use the 'ntb_netdev' driver for the virtual Ethernet functionality
> >>> across the NTB for IP communication between the two controllers. I've
> >>> had a long standing issue where sometimes when we reboot a controller,
> >>> we're never able to establish communication between the two
> >>> controllers again -- usually requires rebooting both and/or power
> >>> cycling the entire chassis.
> >>>
> >>> I've also noticed sometimes when they boot, the virtual Ethernet
> >>> device fails to pass traffic right away.
> >>>
> >>> And finally, when simply doing an "ifconfig NTB_IF down" followed by
> >>> an "ifconfig NTB_IF up" on one controller, they sometimes get into the
> >>> state where they no longer pass traffic.
> >>>
> >>> All three conditions seem to be related, and the symptom is the same
> >>> (they have the UP RUNNING flags with IP's configured but I'm unable to
> >>> ping between the two controllers). Usually when this happens, one side
> >>> will show the drop/error counts for the NTB virtual Ethernet interface
> >>> increasing (never ending).
> >>>
> >>> In the example below, both controllers booted up, and I unloaded the
> >>> modules then reloaded with 'dyndbg=+p' but immediately was not able to
> >>> pass any traffic on those interfaces.
> >>
> >>
> >> I've copied Kelvin who does most of the work on the switchtec driver. I
> >> suspect this is a bug in that driver.
> >>
> >> I also know that there have been some fixes in this area in the OOT
> >> version of that module (which will probably make it upstream in due course).
> >>
> >> See this PR:
> >>
> >> https://github.com/Microsemi/switchtec-kernel/pull/107
> >>
> >> I wouldn't be surprised if this is the same issue you are seeing. The
> >> patches there should apply pretty easily to the upstream kernel if you
> >> prefer.
> >
> > Thanks Logan. I used the driver source from
> > "https://github.com/Microsemi/switchtec-kernel/tree/master" and the
> > problem still persists. On one side tx_ring_full continues to climb
> > and the errors/dropped counts continue to rise for the virtual
> > Ethernet interface:
> >
> > # cat /sys/kernel/debug/ntb_transport/0000\:3b\:00.1/qp0/stats
> >
> > NTB QP stats:
> >
> > rx_bytes - 0
> > rx_pkts - 0
> > rx_memcpy - 0
> > rx_async - 0
> > rx_ring_empty - 8
> > rx_err_no_buf - 0
> > rx_err_oflow - 0
> > rx_err_ver - 0
> > rx_buff - 0x00000000e7a16187
> > rx_index - 0
> > rx_max_entry - 31
> > rx_alloc_entry - 100
> >
> > tx_bytes - 0
> > tx_pkts - 0
> > tx_memcpy - 0
> > tx_async - 0
> > tx_ring_full - 23809328
> > tx_err_no_buf - 0
> > tx_mw - 0x0000000029c0837d
> > tx_index (H) - 0
> > RRI (T) - 0
> > tx_max_entry - 31
> > free tx - 31
> >
> > Using TX DMA - Yes
> > Using RX DMA - Yes
> > QP Link - Up
> >
> > # ifconfig priv0
> > priv0     Link encap:Ethernet  HWaddr 32:15:21:03:C0:31
> >           inet addr:10.17.21.197  Bcast:10.17.21.199  Mask:255.255.255.252
> >           inet6 addr: fe80::3015:21ff:fe03:c031/64 Scope:Link
> >           UP BROADCAST RUNNING MULTICAST  MTU:65510  Metric:1
> >           RX packets:18 errors:0 dropped:0 overruns:0 frame:0
> >           TX packets:1 errors:321933488 dropped:321933488 overruns:0 carrier:0
> >           collisions:0 txqueuelen:1000
> >           RX bytes:1188 (1.1 KiB)  TX bytes:90 (90.0 B)
> >
> > Is it possible there are some special NTB/BIOS settings needed for
> > this hardware?

[root@localhost ~]# lspci -vvv -s 0000:3b:00.1
3b:00.1 Bridge: PMC-Sierra Inc. PM8546 B-FEIP PSX 96xG3 PCIe Storage Switch
...
Region 2: Memory at 1affc8000000 (64-bit, prefetchable) [size=64M]
Region 4: Memory at 1affc4000000 (64-bit, prefetchable) [size=64M]
...

[root@localhost ~]# lspci -vvv -s 0000:3b:00.1
3b:00.1 Bridge: PMC-Sierra Inc. PM8546 B-FEIP PSX 96xG3 PCIe Storage Switch
...
Region 2: Memory at 1affc8000000 (64-bit, prefetchable) [size=64M]
Region 4: Memory at 1affc4000000 (64-bit, prefetchable) [size=64M]
...

No DMAR errors in kernel log buffer on either side.


>
> No, I don't think there's any BIOS settings needed. It could be a
> problem with the switch configuration, but I'm not entirely sure what it
> would be. Crosslink configurations are also super tricky.
>
> The fact that it comes up some of the time suggest there's a race
> condition or something along those lines while the driver sets up the
> switch. So this may take some effort to debug.
>
> It's hard to say, but I suspect the doorbells on the receive side are
> not getting through. Can you confirm that when it is broken you don't
> get any debug messages like "ntb_transport_rxc_db: doorbell 0 received".

I *do* see these messages occasionally even when it's not "broken"
(still passes traffic):
...
[ 1445.383417] switchtec 0000:3b:00.1: ntb_transport_rxc_db: doorbell 0 received
[ 1445.383437] switchtec 0000:3b:00.1: qp 0: RX ver 42 len 98 flags 1
[ 1445.383449] switchtec 0000:3b:00.1: RX OK index 11 ver 42 size 98
into buf size 65524
[ 1445.383463] ntb_netdev ntb_netdev0 priv0: ntb_netdev_rx_handler: 98
byte payload received
[ 1445.383567] switchtec 0000:3b:00.1: qp 0: RX ver 12 len 42 flags 0
[ 1445.383569] switchtec 0000:3b:00.1: done flag not set
[ 1445.383655] switchtec 0000:3b:00.1: ntb_transport_rxc_db: doorbell 0 received
[ 1445.383658] switchtec 0000:3b:00.1: qp 0: RX ver 12 len 42 flags 0
[ 1445.383660] switchtec 0000:3b:00.1: done flag not set
...

And then finally when it's in the broken state (not passing traffic,
and interface error/drop constantly increasing on one side), I see
these final entries...

Node "1":
[24911.478753] switchtec 0000:3b:00.1: Remote QP link status = 1
[24911.478758] switchtec 0000:3b:00.1: qp 0: Link Up
[24911.478762] ntb_netdev ntb_netdev0 priv0: Event 1, Link 1
[24911.478776] switchtec 0000:3b:00.1: ntb_transport_rxc_db: doorbell 0 received
[24911.478780] switchtec 0000:3b:00.1: qp 0: RX ver 22909 len 98 flags 0
[24911.478782] switchtec 0000:3b:00.1: done flag not set

Node "2":
[73817.158844] switchtec 0000:3b:00.1: ntb_transport_rxc_db: doorbell 0 received
[73817.158847] switchtec 0000:3b:00.1: qp 0: RX ver 48 len 42 flags 1
[73817.158850] switchtec 0000:3b:00.1: RX OK index 17 ver 48 size 42
into buf size 65524
[73817.158854] ntb_netdev ntb_netdev0 priv0: ntb_netdev_rx_handler: 42
byte payload received
[73817.158882] switchtec 0000:3b:00.1: qp 0: RX ver 18 len 70 flags 0
[73817.158884] switchtec 0000:3b:00.1: done flag not set
[73817.158943] switchtec 0000:3b:00.1: ntb_transport_rxc_db: doorbell 0 received
[73817.158946] switchtec 0000:3b:00.1: qp 0: RX ver 18 len 70 flags 0
[73817.158948] switchtec 0000:3b:00.1: done flag not set

On node "2" is where the drop/error count for the interface increases
in this case, and if I run a "ping" between the two in another
terminal, the following excerpts repeat continually:
...
[73881.175207] switchtec 0000:3b:00.1: ntb_transport_rxc_db: doorbell 0 received
[73881.175211] switchtec 0000:3b:00.1: qp 0: RX ver 96 len 42 flags 1
[73881.175214] switchtec 0000:3b:00.1: RX OK index 3 ver 96 size 42
into buf size 65524
[73881.175218] ntb_netdev ntb_netdev0 priv0: ntb_netdev_rx_handler: 42
byte payload received
[73881.175245] switchtec 0000:3b:00.1: qp 0: RX ver 66 len 42 flags 0
[73881.175247] switchtec 0000:3b:00.1: done flag not set
[73881.175304] switchtec 0000:3b:00.1: ntb_transport_rxc_db: doorbell 0 received
[73881.175307] switchtec 0000:3b:00.1: qp 0: RX ver 66 len 42 flags 0
[73881.175309] switchtec 0000:3b:00.1: done flag not set
...


>
> Another thing that you could try is to dump the registers for both
> switches when it's working and broken. You can use the switchtec user
> tool for this. 'switchtec gas dump' will dump the entire register space
> in hex. The NTB registers to take a look at start at 0x10000. If we can
> notice a difference between broken and working we can narrow down what
> is not being setup correctly.

How many bytes to compare starting at 0x10000? The beginning looks like this:

Working:
0010000 0003 0000 0005 0000 0000 0000 3a00 0000
0010010 0000 0000 0000 0000 0000 0000 0000 0000
0010020 0001 0000 0004 0000 0000 0000 0000 0000
0010030 0000 0000 0000 0000 0000 0000 0000 0000
0010040 0001 0000 0001 0000 0000 0000 0000 0000
0010050 0000 0000 0000 0000 0000 0000 0000 0000
*

Broken:
0010000 0003 0000 0005 0000 0000 0000 3a00 0000
0010010 0000 0000 0000 0000 0000 0000 0000 0000
0010020 0001 0000 0004 0000 0000 0000 0000 0000
0010030 0000 0000 0000 0000 0000 0000 0000 0000
0010040 0001 0000 0001 0000 0000 0000 0000 0000
0010050 0000 0000 0000 0000 0000 0000 0000 0000
*

No difference between the two above, and actually, comparing the
entire 4 MiB of GAS dump taken while working/functional versus broken
state shows no differences:
# cmp switchtec0_gas_dump_after_ifup_working.1 switchtec0_gas_dump_broken.1
# echo $?
0


--Marc


>
> Logan
