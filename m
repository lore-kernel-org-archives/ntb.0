Return-Path: <lsgunthorpe@gmail.com>
Received: from mail-io0-x22a.google.com (mail-io0-x22a.google.com. [2607:f8b0:4001:c06::22a])
        by gmr-mx.google.com with ESMTPS id a17si2630530itd.1.2017.03.06.19.27.51
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Mar 2017 19:27:51 -0800 (PST)
Received: by mail-io0-x22a.google.com with SMTP id f84so126382465ioj.0
        for <linux-ntb@googlegroups.com>; Mon, 06 Mar 2017 19:27:51 -0800 (PST)
Return-Path: <lsgunthorpe@gmail.com>
From: Logan Gunthorpe <lsgunthorpe@gmail.com>
Subject: Re: [PATCH v4] NTB: Add IDT 89HPESxNTx PCIe-switches support
References: <1487933348-32403-1-git-send-email-fancer.lancer@gmail.com>
 <1488187351-12624-1-git-send-email-fancer.lancer@gmail.com>
 <c293fffa-d714-49d3-b0a5-4a1183b5229a@googlegroups.com>
 <20170307015755.GA14511@mobilestation.tp-local.ru>
Message-ID: <26e320d1-392c-ee60-440c-e293d7dc86bc@gmail.com>
Date: Mon, 6 Mar 2017 20:27:49 -0700
MIME-Version: 1.0
In-Reply-To: <20170307015755.GA14511@mobilestation.tp-local.ru>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Serge Semin <fancer.lancer@gmail.com>
Cc: linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>



On 06/03/17 06:57 PM, Serge Semin wrote:
> Agreed. Replaced with traditional dev_*() methods.

You should also be printing using the ntb's device and not the parent
device. ie use:

ndev->ntb.dev

instead of

ndev->ntb.pdev->dev


> It's obvious, to prevent a race condition of access to the Mapping table, which
> is implemented by Address and Data registers set.
> For the same reason the driver have spin lock to protect an access to the
> Global Switch registers using GASA-ADDR and GASA-DATA.

Ah, I see. Perhaps these should be in their own function in the same way
as the gasa functions? It would probably be a bit clearer.

> Kind of funny. You've sent some comments about devres methods usage, but
> suspected a memory leak at the moment where it's actually used. So take a look
> at the place of "ndev" structure allocation, and you'll find an answer.

Ah sorry, I missed that. Usually I expect to see the structure free'd by
the release function on the device. But NTB is a little odd in that regard.

Also, per section 8 of the Linux style guide[1], IMO this code is pretty
over commented.

Logan


[1] https://static.lwn.net/kerneldoc/process/coding-style.html#commenting
