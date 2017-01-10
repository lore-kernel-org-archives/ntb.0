Return-Path: <jdmason@kudzu.us>
Received: from mail-oi0-x231.google.com (mail-oi0-x231.google.com. [2607:f8b0:4003:c06::231])
        by gmr-mx.google.com with ESMTPS id c195si304453itb.0.2017.01.10.14.13.26
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jan 2017 14:13:26 -0800 (PST)
Received: by mail-oi0-x231.google.com with SMTP id w204so66598389oiw.0
        for <linux-ntb@googlegroups.com>; Tue, 10 Jan 2017 14:13:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <360341483979222@web10o.yandex.ru>
References: <360341483979222@web10o.yandex.ru>
From: Jon Mason <jdmason@kudzu.us>
Date: Tue, 10 Jan 2017 17:03:37 -0500
Message-ID: <CAPoiz9zYa19b1fHVJFvmM-qrNigXkxDTvV3Hrjc81H0tfaMPKA@mail.gmail.com>
Subject: Re: Problem with ntb_transport + ntb_netdev
Content-Type: text/plain; charset=UTF-8
To: perplexus <perplexus@ya.ru>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Adding the NTB mailing list

On Mon, Jan 9, 2017 at 11:27 AM, perplexus <perplexus@ya.ru> wrote:
> Hello.
>
> I'm working with NTB (kernel version 4.10) on Xeon D-1527 CPU and have a problem with couple ntb_transport + ntb_netdev.
>
> On the local side I run:
> sudo /etc/init.d/irqbalance stop
> sudo modprobe ntb_transport dyndbg=+p
> sudo modprobe ntb_netdev dyndbg=+p
> sudo ifconfig eth0 192.168.1.1 up
>
> On the remote side I run:
> sudo /etc/init.d/irqbalance stop
> sudo modprobe ntb_transport dyndbg=+p
> sudo modprobe ntb_netdev dyndbg=+p
> sudo ifconfig eth0 192.168.1.2 up
>
> Along with these steps I run ping 192.168.1.2 and get about 2-3 successfull transmitted/received packets then get 'Destination host unreacheble'.
>

Do pings in the other direction work?
