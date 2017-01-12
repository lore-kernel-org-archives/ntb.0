Return-Path: <dave.jiang@intel.com>
Received: from mga05.intel.com (mga05.intel.com. [192.55.52.43])
        by gmr-mx.google.com with ESMTPS id z73si732768pfa.2.2017.01.12.08.37.42
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jan 2017 08:37:42 -0800 (PST)
Subject: Re: Problem with ntb_transport + ntb_netdev
References: <360341483979222@web10o.yandex.ru>
 <CAPoiz9zYa19b1fHVJFvmM-qrNigXkxDTvV3Hrjc81H0tfaMPKA@mail.gmail.com>
 <7784bee8-663d-bd89-2d2b-ef47081153d1@intel.com>
 <c18c3dc2-d242-4352-946e-931ff13e1d28@googlegroups.com>
 <6664bf72-a4bb-4081-0fb9-13c66adbec4e@intel.com>
 <422f314a-de5e-06a0-33cd-a6d894db1d61@intel.com>
 <1d63eddd-e9b2-4023-8e0c-6bc658633b9a@googlegroups.com>
From: Dave Jiang <dave.jiang@intel.com>
Message-ID: <23bd7340-66a1-db48-5406-0f9477c66541@intel.com>
Date: Thu, 12 Jan 2017 09:37:41 -0700
MIME-Version: 1.0
In-Reply-To: <1d63eddd-e9b2-4023-8e0c-6bc658633b9a@googlegroups.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: shlemisto@gmail.com, linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

Need to see your dmesg with dyndbg for the ntb_hw_intel.ko but your
SBAR23SZ is still wrong. You are not configuring the secondary BAR2/3
size correctly in BIOS. Can you provide all your NTB BIOS config options?

On 01/12/2017 08:29 AM, shlemisto@gmail.com wrote:
> I built this kernel.
> Unfortunately link doesn't train.
> 
> ntb_hw_intel_1 <http://pastebin.com/ZvCK9yu5> - 1'st side
> ntb_hw_intel_2 <http://pastebin.com/p8BJ83pv> - 2'nd side
> 
> среда, 11 января 2017 г., 19:45:05 UTC+3 пользователь dave.jiang написал:
> 
> 
> 
>     On 01/11/2017 09:42 AM, Dave Jiang wrote:
>     >
>     >
>     > On 01/11/2017 03:08 AM, shle...@gmail.com <javascript:> wrote:
>     >>> Do pings in the other direction work?
>     >> Similarly
>     >>> How are the NTBs connected?
>     >> B2B
>     >>> And which distro are you running?
>     >> Ubuntu 16.10 with kernel 4.10.0-rc1 from git
>     >>>  Sometimes
>     >> Network Manager will yank the IP for no reason if you don't
>     configure it
>     >> correctly and thus your interface can't route.
>     >> I stop network-manager service before load the modules and set IP
>     manually.
>     >>
>     >>> Also can you dump the stats in debugfs?
>     >> ntb_hw_intel_info_1 <http://pastebin.com/eyMZzSik> - one side
>     >> ntb_hw_intel_info_2 <http://pastebin.com/vF94zLBk> - second side
>     >> ntb_transport_info_1 <http://pastebin.com/Ktq1yAqa> - one side
>     >> ntb_transport_info_2 <http://pastebin.com/w8r08ezB> - second side
>     >
>     > Your secondary BAR2 size is not the same as your primary. They
>     both need
>     > to be 22. Also all the upstream memory miss is concerning. You should
>     > have none. You may have signal integrity issues. But fix the bar size
>     > first and see if that helps.
> 
>     Also, if you are using Broadwell Xeon D, you should use the kernel from
>     here and not upstream.
>     https://github.com/davejiang/linux <https://github.com/davejiang/linux>
>     branch: davejiang/ntb
> 
> 
> 
>     >
>     >>
>     >> среда, 11 января 2017 г., 1:24:17 UTC+3 пользователь dave.jiang
>     написал:
>     >>
>     >>     On 01/10/2017 03:03 PM, Jon Mason wrote:
>     >>     > Adding the NTB mailing list
>     >>     >
>     >>     > On Mon, Jan 9, 2017 at 11:27 AM, perplexus <perp...@ya.ru
>     >>     <javascript:>> wrote:
>     >>     >> Hello.
>     >>     >>
>     >>     >> I'm working with NTB (kernel version 4.10) on Xeon D-1527
>     CPU and
>     >>     have a problem with couple ntb_transport + ntb_netdev.
>     >>     >>
>     >>     >> On the local side I run:
>     >>     >> sudo /etc/init.d/irqbalance stop
>     >>     >> sudo modprobe ntb_transport dyndbg=+p
>     >>     >> sudo modprobe ntb_netdev dyndbg=+p
>     >>     >> sudo ifconfig eth0 192.168.1.1 up
>     >>     >>
>     >>     >> On the remote side I run:
>     >>     >> sudo /etc/init.d/irqbalance stop
>     >>     >> sudo modprobe ntb_transport dyndbg=+p
>     >>     >> sudo modprobe ntb_netdev dyndbg=+p
>     >>     >> sudo ifconfig eth0 192.168.1.2 up
>     >>     >>
>     >>     >> Along with these steps I run ping 192.168.1.2 and get
>     about 2-3
>     >>     successfull transmitted/received packets then get
>     'Destination host
>     >>     unreacheble'.
>     >>     >>
>     >>     >
>     >>     > Do pings in the other direction work?
>     >>     >
>     >>     How are the NTBs connected? Where did the get the hardware?
>     Also can
>     >>     you
>     >>     dump the stats in debugfs? And which distro are you running?
>     Sometimes
>     >>     Network Manager will yank the IP for no reason if you don't
>     >>     configure it
>     >>     correctly and thus your interface can't route.
>     >>
>     >> --
>     >> You received this message because you are subscribed to the Google
>     >> Groups "linux-ntb" group.
>     >> To unsubscribe from this group and stop receiving emails from it,
>     send
>     >> an email to linux-ntb+...@googlegroups.com <javascript:>
>     >> <mailto:linux-ntb+...@googlegroups.com <javascript:>>.
>     >> To post to this group, send email to linu...@googlegroups.com
>     <javascript:>
>     >> <mailto:linu...@googlegroups.com <javascript:>>.
>     >> To view this discussion on the web visit
>     >>
>     https://groups.google.com/d/msgid/linux-ntb/c18c3dc2-d242-4352-946e-931ff13e1d28%40googlegroups.com
>     <https://groups.google.com/d/msgid/linux-ntb/c18c3dc2-d242-4352-946e-931ff13e1d28%40googlegroups.com>
> 
>     >>
>     <https://groups.google.com/d/msgid/linux-ntb/c18c3dc2-d242-4352-946e-931ff13e1d28%40googlegroups.com?utm_medium=email&utm_source=footer
>     <https://groups.google.com/d/msgid/linux-ntb/c18c3dc2-d242-4352-946e-931ff13e1d28%40googlegroups.com?utm_medium=email&utm_source=footer>>.
> 
>     >> For more options, visit https://groups.google.com/d/optout
>     <https://groups.google.com/d/optout>.
>     >
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
> https://groups.google.com/d/msgid/linux-ntb/1d63eddd-e9b2-4023-8e0c-6bc658633b9a%40googlegroups.com
> <https://groups.google.com/d/msgid/linux-ntb/1d63eddd-e9b2-4023-8e0c-6bc658633b9a%40googlegroups.com?utm_medium=email&utm_source=footer>.
> For more options, visit https://groups.google.com/d/optout.
