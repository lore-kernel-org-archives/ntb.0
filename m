Return-Path: <allenbh@gmail.com>
Received: from mail-wm0-x22d.google.com (mail-wm0-x22d.google.com. [2a00:1450:400c:c09::22d])
        by gmr-mx.google.com with ESMTPS id b8-v6si778240wrn.2.2018.06.04.08.31.13
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Jun 2018 08:31:13 -0700 (PDT)
Received: by mail-wm0-x22d.google.com with SMTP id p126-v6so6464274wmb.2
        for <linux-ntb@googlegroups.com>; Mon, 04 Jun 2018 08:31:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1ed5452b-678e-4881-a82c-182413c12954@googlegroups.com>
References: <e46a0926-7118-4009-886f-c1252cb93d62@googlegroups.com>
 <CAJ80sasPx7HFT2wgD7tMpmEVKPraHg+oQJ-zoUkNyRpnB8to+Q@mail.gmail.com>
 <62e8a338-e07b-4174-927c-f4f70a54949b@googlegroups.com> <CAJ80sauCYYOUak+1sQ=3kx_mK10pvL3pLCs_hEq-MPUaNgSD-g@mail.gmail.com>
 <32bfb787-223c-41c1-9df6-3cf57045f918@googlegroups.com> <1ed5452b-678e-4881-a82c-182413c12954@googlegroups.com>
From: Allen Hubbe <allenbh@gmail.com>
Date: Mon, 4 Jun 2018 11:31:12 -0400
Message-ID: <CAJ80sav0RepYOu+C5-hzVdsKYpzrZuHP0M_Q=h+2P-L1LeUDbA@mail.gmail.com>
Subject: Re: Problem with the connection status (Link-status) after loading
 the driver ntb_hw_intel
Content-Type: text/plain; charset="UTF-8"
To: vk en <yato.iacs@gmail.com>
Cc: linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

On Mon, Jun 4, 2018 at 10:50 AM, vk en <yato.iacs@gmail.com> wrote:
> He wrote that he did not find dma.
> It turns out I should already have a dma, or should he create a virtual dma
> himself?
> Or do I lack some module for dma?

modprobe ioatdma

https://github.com/ntrdma/ntrdma/wiki#module-loading-1

And also check that there is at least one channel not in use:
cat /sys/class/dma/*/in_use

>
>
>
> On Monday, 4 June 2018 17:43:01 UTC+3, vk en wrote:
>>
>>
>>
>> On Monday, 4 June 2018 17:00:46 UTC+3, Allen Hubbe wrote:
>>>
>>> On Mon, Jun 4, 2018 at 9:23 AM, Ka Vi <yato...@gmail.com> wrote:
>>> > Hi, Allen! Thanks for answering!
>>> >
>>> > 1. Was the ntb_transport driver unloaded before loading ntc_ntb_msi?
>>> > No, I want to create a bridge using NTRDMA over PCIe NTB, bypassing the
>>> > TCP
>>> > / IP protocol
>>> >
>>> > I watched the wiki, and I did everything as indicated. And there is no
>>> > usage
>>> > of the ntb_transport module.
>>> >
>>> > After editing the configuration file
>>> > (https://github.com/ntrdma/ntrdma/wiki#module-loading-1), I load the
>>> > module
>>> > and get an error: [ 1273.099294] ntb_hw_intel: unknown parameter
>>> > 'no_msix'
>>> > ignored
>>> > All the necessary output in dmesg:
>>> > [ 1252.681245] ioatdma: Intel(R) QuickData Technology Driver 4.00
>>> > [ 1273.099294] ntb_hw_intel: unknown parameter 'no_msix' ignored
>>> > [ 1273.099420] Intel(R) PCI-E Non-Transparent Bridge Driver kkk  3.0
>>> > [ 1273.099624] ntb_hw_intel 0000:00:03.0: enabling bus mastering
>>> > [ 1273.100007] ntb_hw_intel 0000:00:03.0: NTB device registered.
>>> > [ 1325.970171] ntc: NTC Driver Framework 0.2
>>> > [ 1325.974509] ntc_ntb: NTC Non Transparent Bridge 0.3
>>>
>>> Please load ntc_ntb_msi with module parameter dyndbg=+p
>>
>>
>> [  190.999503] ioatdma: Intel(R) QuickData Technology Driver 4.00
>> [  239.385371] ntc: NTC Driver Framework 0.2
>> [  239.390995] ntc_ntb: NTC Non Transparent Bridge 0.3
>> [  239.391018] probe ntb 0000:00:03.0
>> [  239.391020] no dma for new device 0000:00:03.0
>>
>>>
>>> Can you also please provide the output of:
>>> ls -ld /sys/bus/ntb/*/driver
>>>
>>   root@ENGINE-1:~# ls -ld /sys/bus/ntb/*
>> drwxr-xr-x 2 root root    0 Jun  4 10:28 /sys/bus/ntb/devices
>> drwxr-xr-x 3 root root    0 Jun  4 10:16 /sys/bus/ntb/drivers
>> -rw-r--r-- 1 root root 4096 Jun  4 10:28 /sys/bus/ntb/drivers_autoprobe
>> --w------- 1 root root 4096 Jun  4 10:28 /sys/bus/ntb/drivers_probe
>> --w------- 1 root root 4096 Jun  4 10:28 /sys/bus/ntb/uevent
>>
>>>
>>> If it was loaded with dyndbg, and that is the last thing in dmesg,
>>> then it looks like the probe function was never called.
>>>
