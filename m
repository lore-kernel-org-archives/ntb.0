Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34834435F
	for <ntb@lists.linux.dev>; Thu, 17 Feb 2022 16:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:content-disposition;
	bh=Bu57AHs8VBuV4kvzRRqXSY82XrvXmS/9prVoqDkiy3w=; b=KLh0LNlRSxmEW/JSvEsr+IVHLX
	l1jeLWqJvJGRMwozTuRKLH2dgtysBtFOYLyx+SJu55jedV2ohqbWlfi9k0itmDYtgzQ/vXNGtihrI
	ibMtN9l7wtPIGJmHpalJUnBIguHLYB2pD9L4chEqLFaDJlrMbSlnLeg6ooWLmtzv/5CR56T9U94np
	p3eW/Zu65gYapizivVeVNQVns3V/TK8b6jwr4k3Y9bZy6JUxuCboF8hnUuX2GLzkJBqxX8amJ8lmE
	Sd0E3QtAMJY13O5NxmR9RhGvFRA/E1c6v5FY5W1vv+pxF9xooE4DcjyLVxLgTk6tlKqcAFE5uiill
	/+a68Fmw==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <logang@deltatee.com>)
	id 1nKjyb-002R4I-KA; Thu, 17 Feb 2022 09:49:55 -0700
To: Marc Smith <msmith626@gmail.com>
Cc: ntb@lists.linux.dev, Kelvin Cao <kelvin.cao@microchip.com>,
 kelvincao@outlook.com
References: <CAH6h+hfwRFMW47ONT+zC8Z1Y-30gb4dPEwTOtatN86EMeUajpA@mail.gmail.com>
 <1d53b232-dc0a-c7d3-69a1-8cb17ff83601@deltatee.com>
 <CAH6h+hdbOEjpU5tn+MwDm-h=47b4kzMHDZhSc51hA0VOZLp_8g@mail.gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <48234e72-3458-f90b-234d-f1ffccef996f@deltatee.com>
Date: Thu, 17 Feb 2022 09:49:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAH6h+hdbOEjpU5tn+MwDm-h=47b4kzMHDZhSc51hA0VOZLp_8g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: kelvincao@outlook.com, kelvin.cao@microchip.com, ntb@lists.linux.dev, msmith626@gmail.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
	LR_URI_NUMERIC_ENDING,MYRULES_FREE,NICE_REPLY_A,T_SCC_BODY_TEXT_LINE
	autolearn=no autolearn_force=no version=3.4.6
Subject: Re: ntb_netdev Communication Failure Issue
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)




On 2022-02-17 8:22 a.m., Marc Smith wrote:
> On Wed, Feb 16, 2022 at 12:14 PM Logan Gunthorpe <logang@deltatee.com> wrote:
>>
>> Hi Marc,
>>
>>
>> On 2022-02-16 9:16 a.m., Marc Smith wrote:
>>> Hi,
>>>
>>> I'm using vanilla Linux 5.4.145 with a Celestica "cluster-in-a-box"
>>> system (two servers in a single chassis connected internally via PCIe
>>> switches). The PCIe switches are Microsemi Switchtec ('lspci' says
>>> "PMC-Sierra Inc. PM8546 B-FEIP PSX 96xG3 PCIe Storage Switch
>>> [11f8:8546]" but I believe this is not the current product/model name
>>> from Microsemi).
>>>
>>> I use the 'ntb_netdev' driver for the virtual Ethernet functionality
>>> across the NTB for IP communication between the two controllers. I've
>>> had a long standing issue where sometimes when we reboot a controller,
>>> we're never able to establish communication between the two
>>> controllers again -- usually requires rebooting both and/or power
>>> cycling the entire chassis.
>>>
>>> I've also noticed sometimes when they boot, the virtual Ethernet
>>> device fails to pass traffic right away.
>>>
>>> And finally, when simply doing an "ifconfig NTB_IF down" followed by
>>> an "ifconfig NTB_IF up" on one controller, they sometimes get into the
>>> state where they no longer pass traffic.
>>>
>>> All three conditions seem to be related, and the symptom is the same
>>> (they have the UP RUNNING flags with IP's configured but I'm unable to
>>> ping between the two controllers). Usually when this happens, one side
>>> will show the drop/error counts for the NTB virtual Ethernet interface
>>> increasing (never ending).
>>>
>>> In the example below, both controllers booted up, and I unloaded the
>>> modules then reloaded with 'dyndbg=+p' but immediately was not able to
>>> pass any traffic on those interfaces.
>>
>>
>> I've copied Kelvin who does most of the work on the switchtec driver. I
>> suspect this is a bug in that driver.
>>
>> I also know that there have been some fixes in this area in the OOT
>> version of that module (which will probably make it upstream in due course).
>>
>> See this PR:
>>
>> https://github.com/Microsemi/switchtec-kernel/pull/107
>>
>> I wouldn't be surprised if this is the same issue you are seeing. The
>> patches there should apply pretty easily to the upstream kernel if you
>> prefer.
> 
> Thanks Logan. I used the driver source from
> "https://github.com/Microsemi/switchtec-kernel/tree/master" and the
> problem still persists. On one side tx_ring_full continues to climb
> and the errors/dropped counts continue to rise for the virtual
> Ethernet interface:
> 
> # cat /sys/kernel/debug/ntb_transport/0000\:3b\:00.1/qp0/stats
> 
> NTB QP stats:
> 
> rx_bytes - 0
> rx_pkts - 0
> rx_memcpy - 0
> rx_async - 0
> rx_ring_empty - 8
> rx_err_no_buf - 0
> rx_err_oflow - 0
> rx_err_ver - 0
> rx_buff - 0x00000000e7a16187
> rx_index - 0
> rx_max_entry - 31
> rx_alloc_entry - 100
> 
> tx_bytes - 0
> tx_pkts - 0
> tx_memcpy - 0
> tx_async - 0
> tx_ring_full - 23809328
> tx_err_no_buf - 0
> tx_mw - 0x0000000029c0837d
> tx_index (H) - 0
> RRI (T) - 0
> tx_max_entry - 31
> free tx - 31
> 
> Using TX DMA - Yes
> Using RX DMA - Yes
> QP Link - Up
> 
> # ifconfig priv0
> priv0     Link encap:Ethernet  HWaddr 32:15:21:03:C0:31
>           inet addr:10.17.21.197  Bcast:10.17.21.199  Mask:255.255.255.252
>           inet6 addr: fe80::3015:21ff:fe03:c031/64 Scope:Link
>           UP BROADCAST RUNNING MULTICAST  MTU:65510  Metric:1
>           RX packets:18 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:1 errors:321933488 dropped:321933488 overruns:0 carrier:0
>           collisions:0 txqueuelen:1000
>           RX bytes:1188 (1.1 KiB)  TX bytes:90 (90.0 B)
> 
> Is it possible there are some special NTB/BIOS settings needed for
> this hardware?

No, I don't think there's any BIOS settings needed. It could be a
problem with the switch configuration, but I'm not entirely sure what it
would be. Crosslink configurations are also super tricky.

The fact that it comes up some of the time suggest there's a race
condition or something along those lines while the driver sets up the
switch. So this may take some effort to debug.

It's hard to say, but I suspect the doorbells on the receive side are
not getting through. Can you confirm that when it is broken you don't
get any debug messages like "ntb_transport_rxc_db: doorbell 0 received".

Another thing that you could try is to dump the registers for both
switches when it's working and broken. You can use the switchtec user
tool for this. 'switchtec gas dump' will dump the entire register space
in hex. The NTB registers to take a look at start at 0x10000. If we can
notice a difference between broken and working we can narrow down what
is not being setup correctly.

Logan
