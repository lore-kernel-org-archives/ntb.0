Return-Path: <lsgunthorpe@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com. [2607:f8b0:400e:c05::243])
        by gmr-mx.google.com with ESMTPS id s64si114686pfk.0.2017.03.07.09.00.57
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Mar 2017 09:00:57 -0800 (PST)
Received: by mail-pg0-x243.google.com with SMTP id 25so639721pgy.3
        for <linux-ntb@googlegroups.com>; Tue, 07 Mar 2017 09:00:57 -0800 (PST)
Return-Path: <lsgunthorpe@gmail.com>
Subject: Re: [PATCH v4] NTB: Add IDT 89HPESxNTx PCIe-switches support
References: <1487933348-32403-1-git-send-email-fancer.lancer@gmail.com>
 <1488187351-12624-1-git-send-email-fancer.lancer@gmail.com>
 <c293fffa-d714-49d3-b0a5-4a1183b5229a@googlegroups.com>
 <20170307015755.GA14511@mobilestation.tp-local.ru>
 <26e320d1-392c-ee60-440c-e293d7dc86bc@gmail.com>
 <20170307150926.GA7149@mobilestation>
From: Logan Gunthorpe <lsgunthorpe@gmail.com>
Message-ID: <3563419d-0936-c486-6cb4-54a9c3b2cb28@gmail.com>
Date: Tue, 7 Mar 2017 10:00:53 -0700
MIME-Version: 1.0
In-Reply-To: <20170307150926.GA7149@mobilestation>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Serge Semin <fancer.lancer@gmail.com>
Cc: linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

On 07/03/17 08:09 AM, Serge Semin wrote:
> No I shouldn't. The thing is, that NTB API has two levels of drivers: client
> and hardware drivers. IDT NTB driver you are reviewing is hardware driver, it
> refers to the actual PCIe-device and is responsible for communications with it.
> The client drivers use NTB API abstraction and common facilities it exposes to
> implement some user-available functionality. They communicate with NTB devices
> registered by the hardware drivers. So to speak the client drivers work with
> ndev->ntb.dev, but the hardware drivers - with ndev->ntb.pdev->dev. That's why
> it is necessary to separate the logs of these two levels.

Huh? Besides the weirdness in the NTB tree, show me one driver that
prints to its
pci device. You created ntb.dev and it's a member of idt_ntb_dev, the
pdev is a pointer
somewhere else which should be a huge hint.  Also, see [1] for someone's
opinion with a little more clout than mine. The other drivers in the NTB
tree are meant to be changing in this regard too, if they haven't already.

>>> It's obvious, to prevent a race condition of access to the Mapping table, which
>>> is implemented by Address and Data registers set.
>>> For the same reason the driver have spin lock to protect an access to the
>>> Global Switch registers using GASA-ADDR and GASA-DATA.
>> Ah, I see. Perhaps these should be in their own function in the same way
>> as the gasa functions? It would probably be a bit clearer.
>>
> I would rather leave it as is. It's just two lines of code, which are present
> just at one place of the driver. 
By my count, there are two writes and two reads but that's hardly the
point. Even if there is only one, a function is a good way to add
documentation and make the calling function look a little cleaner.

> It's not NTB, but in general devres isn't that wide spread in the kernel drivers,
> since the technology is pretty new. Most of drivers developers are just used to
> do allocations/enables and deallocations/disables/releases manually in the code.
> Although it's really handy to get being familiar with devres methods.

Most drivers that use a struct device typically will use the reference
counting on the device with it's release function -- not devm_kzalloc.
This makes reference counting work correctly as a device often has to
persist after it's parent device goes away. See [2][3][4] which are all
fairly modern examples (and I could give you more). I'm not asking you
to change it though as this is because of how NTB decided to do things.

Logan

[1] https://lkml.org/lkml/2017/1/11/26
[2] drivers/char/tpm/tpm-chip.c:150
[3] drivers/input/mousedev.c:854
[4] drivers/rapidio/devices/rio_mport_cdev.c:2438


