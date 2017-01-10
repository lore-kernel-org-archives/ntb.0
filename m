Return-Path: <dave.jiang@intel.com>
Received: from mga04.intel.com (mga04.intel.com. [192.55.52.120])
        by gmr-mx.google.com with ESMTPS id o85si770705pfj.2.2017.01.10.14.24.16
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jan 2017 14:24:16 -0800 (PST)
Subject: Re: Problem with ntb_transport + ntb_netdev
References: <360341483979222@web10o.yandex.ru>
 <CAPoiz9zYa19b1fHVJFvmM-qrNigXkxDTvV3Hrjc81H0tfaMPKA@mail.gmail.com>
From: Dave Jiang <dave.jiang@intel.com>
Message-ID: <7784bee8-663d-bd89-2d2b-ef47081153d1@intel.com>
Date: Tue, 10 Jan 2017 15:24:15 -0700
MIME-Version: 1.0
In-Reply-To: <CAPoiz9zYa19b1fHVJFvmM-qrNigXkxDTvV3Hrjc81H0tfaMPKA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Jon Mason <jdmason@kudzu.us>, perplexus <perplexus@ya.ru>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On 01/10/2017 03:03 PM, Jon Mason wrote:
> Adding the NTB mailing list
> 
> On Mon, Jan 9, 2017 at 11:27 AM, perplexus <perplexus@ya.ru> wrote:
>> Hello.
>>
>> I'm working with NTB (kernel version 4.10) on Xeon D-1527 CPU and have a problem with couple ntb_transport + ntb_netdev.
>>
>> On the local side I run:
>> sudo /etc/init.d/irqbalance stop
>> sudo modprobe ntb_transport dyndbg=+p
>> sudo modprobe ntb_netdev dyndbg=+p
>> sudo ifconfig eth0 192.168.1.1 up
>>
>> On the remote side I run:
>> sudo /etc/init.d/irqbalance stop
>> sudo modprobe ntb_transport dyndbg=+p
>> sudo modprobe ntb_netdev dyndbg=+p
>> sudo ifconfig eth0 192.168.1.2 up
>>
>> Along with these steps I run ping 192.168.1.2 and get about 2-3 successfull transmitted/received packets then get 'Destination host unreacheble'.
>>
> 
> Do pings in the other direction work?
> 
How are the NTBs connected? Where did the get the hardware? Also can you
dump the stats in debugfs? And which distro are you running? Sometimes
Network Manager will yank the IP for no reason if you don't configure it
correctly and thus your interface can't route.
