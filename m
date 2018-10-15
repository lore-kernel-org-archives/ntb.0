Return-Path: <allenbh@gmail.com>
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com. [2a00:1450:4864:20::229])
        by gmr-mx.google.com with ESMTPS id o9-v6si327912wmh.2.2018.10.15.07.59.40
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 07:59:40 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 63-v6so17794381ljs.4
        for <linux-ntb@googlegroups.com>; Mon, 15 Oct 2018 07:59:40 -0700 (PDT)
MIME-Version: 1.0
References: <1539375618-6782-1-git-send-email-asierra@xes-inc.com>
In-Reply-To: <1539375618-6782-1-git-send-email-asierra@xes-inc.com>
From: Allen Hubbe <allenbh@gmail.com>
Date: Mon, 15 Oct 2018 10:59:28 -0400
Message-ID: <CAJ80savCdO_VM_0As28+H5KB6ejapbFV2OVoRpPnU9bLyijqRw@mail.gmail.com>
Subject: Re: [PATCH 0/2] NTB: Stash private data in transport client device
Content-Type: text/plain; charset="UTF-8"
To: asierra@xes-inc.com
Cc: linux-ntb@googlegroups.com, Jon Mason <jdmason@kudzu.us>, dave.jiang@intel.com, davem@davemloft.net
List-ID: <linux-ntb.googlegroups.com>

On Fri, Oct 12, 2018 at 4:20 PM Aaron Sierra <asierra@xes-inc.com> wrote:
>
> Support NTB transport client device drivers stashing a reference to
> their private device representation within the transport client device
> for trivial lookup.

Can dev_get/set_drvdata() be used instead?

> Use the new stashing mechanism to simplify ntb_netdev device probe
> and remove. This optimization will also benefit any out-of-tree
> drivers that care to use it.

Simplify ntb_netdev_remove() looks good.  Please also set(NULL) on remove.

>
> Aaron Sierra (2):
>   NTB: transport: Support client device private data
>   ntb_netdev: Simplify remove with client private data
>
>  drivers/net/ntb_netdev.c      | 28 +++-------------------------
>  drivers/ntb/ntb_transport.c   | 19 +++++++++++++++++++
>  include/linux/ntb_transport.h |  2 ++
>  3 files changed, 24 insertions(+), 25 deletions(-)
>
> --
> 2.7.4
>
