Return-Path: <dave.jiang@intel.com>
Received: from mga07.intel.com (mga07.intel.com. [134.134.136.100])
        by gmr-mx.google.com with ESMTPS id o85si1364361pfj.2.2017.01.11.08.42.34
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jan 2017 08:42:34 -0800 (PST)
Subject: Re: Problem with ntb_transport + ntb_netdev
References: <360341483979222@web10o.yandex.ru>
 <CAPoiz9zYa19b1fHVJFvmM-qrNigXkxDTvV3Hrjc81H0tfaMPKA@mail.gmail.com>
 <7784bee8-663d-bd89-2d2b-ef47081153d1@intel.com>
 <c18c3dc2-d242-4352-946e-931ff13e1d28@googlegroups.com>
From: Dave Jiang <dave.jiang@intel.com>
Message-ID: <6664bf72-a4bb-4081-0fb9-13c66adbec4e@intel.com>
Date: Wed, 11 Jan 2017 09:42:33 -0700
MIME-Version: 1.0
In-Reply-To: <c18c3dc2-d242-4352-946e-931ff13e1d28@googlegroups.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: shlemisto@gmail.com, linux-ntb <linux-ntb@googlegroups.com>
Cc: jdmason@kudzu.us, perplexus@ya.ru
List-ID: <linux-ntb.googlegroups.com>



On 01/11/2017 03:08 AM, shlemisto@gmail.com wrote:
>> Do pings in the other direction work? 
> Similarly
>>How are the NTBs connected?
> B2B
>>And which distro are you running?
> Ubuntu 16.10 with kernel 4.10.0-rc1 from git
>>  Sometimes 
> Network Manager will yank the IP for no reason if you don't configure it 
> correctly and thus your interface can't route.
> I stop network-manager service before load the modules and set IP manually.
> 
>> Also can you dump the stats in debugfs?
> ntb_hw_intel_info_1 <http://pastebin.com/eyMZzSik> - one side
> ntb_hw_intel_info_2 <http://pastebin.com/vF94zLBk> - second side
> ntb_transport_info_1 <http://pastebin.com/Ktq1yAqa> - one side
> ntb_transport_info_2 <http://pastebin.com/w8r08ezB> - second side

Your secondary BAR2 size is not the same as your primary. They both need
to be 22. Also all the upstream memory miss is concerning. You should
have none. You may have signal integrity issues. But fix the bar size
first and see if that helps.

> 
> среда, 11 января 2017 г., 1:24:17 UTC+3 пользователь dave.jiang написал:
> 
>     On 01/10/2017 03:03 PM, Jon Mason wrote:
>     > Adding the NTB mailing list
>     >
>     > On Mon, Jan 9, 2017 at 11:27 AM, perplexus <perp...@ya.ru
>     <javascript:>> wrote:
>     >> Hello.
>     >>
>     >> I'm working with NTB (kernel version 4.10) on Xeon D-1527 CPU and
>     have a problem with couple ntb_transport + ntb_netdev.
>     >>
>     >> On the local side I run:
>     >> sudo /etc/init.d/irqbalance stop
>     >> sudo modprobe ntb_transport dyndbg=+p
>     >> sudo modprobe ntb_netdev dyndbg=+p
>     >> sudo ifconfig eth0 192.168.1.1 up
>     >>
>     >> On the remote side I run:
>     >> sudo /etc/init.d/irqbalance stop
>     >> sudo modprobe ntb_transport dyndbg=+p
>     >> sudo modprobe ntb_netdev dyndbg=+p
>     >> sudo ifconfig eth0 192.168.1.2 up
>     >>
>     >> Along with these steps I run ping 192.168.1.2 and get about 2-3
>     successfull transmitted/received packets then get 'Destination host
>     unreacheble'.
>     >>
>     >
>     > Do pings in the other direction work?
>     >
>     How are the NTBs connected? Where did the get the hardware? Also can
>     you
>     dump the stats in debugfs? And which distro are you running? Sometimes
>     Network Manager will yank the IP for no reason if you don't
>     configure it
>     correctly and thus your interface can't route.
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
> https://groups.google.com/d/msgid/linux-ntb/c18c3dc2-d242-4352-946e-931ff13e1d28%40googlegroups.com
> <https://groups.google.com/d/msgid/linux-ntb/c18c3dc2-d242-4352-946e-931ff13e1d28%40googlegroups.com?utm_medium=email&utm_source=footer>.
> For more options, visit https://groups.google.com/d/optout.
