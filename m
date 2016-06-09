Return-Path: <jdmason@kudzu.us>
Received: from mail-vk0-x244.google.com (mail-vk0-x244.google.com. [2607:f8b0:400c:c05::244])
        by gmr-mx.google.com with ESMTPS id r140si86721vkf.0.2016.06.09.07.51.24
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jun 2016 07:51:24 -0700 (PDT)
Received: by mail-vk0-x244.google.com with SMTP id z65so6699727vka.0
        for <linux-ntb@googlegroups.com>; Thu, 09 Jun 2016 07:51:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1465320253.16234.176.camel@intel.com>
References: <5757013F.2090401@deltatee.com> <1465320022-4385-1-git-send-email-logang@deltatee.com>
 <1465320253.16234.176.camel@intel.com>
From: Jon Mason <jdmason@kudzu.us>
Date: Thu, 9 Jun 2016 10:51:23 -0400
Message-ID: <CAPoiz9z9yRYZofn1yua_kHfdxzeOu7MPOZamBiPj2CQ2w0g1jA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] ntb_transport: Check the number of spads the
 hardware supports
Content-Type: text/plain; charset=UTF-8
To: "Jiang, Dave" <dave.jiang@intel.com>
Cc: "logang@deltatee.com" <logang@deltatee.com>, "Allen.Hubbe@emc.com" <Allen.Hubbe@emc.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "sudipm.mukherjee@gmail.com" <sudipm.mukherjee@gmail.com>, "arnd@arndb.de" <arnd@arndb.de>, "john.kading@gd-ms.com" <john.kading@gd-ms.com>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

On Tue, Jun 7, 2016 at 1:24 PM, Jiang, Dave <dave.jiang@intel.com> wrote:
> On Tue, 2016-06-07 at 11:20 -0600, Logan Gunthorpe wrote:
>> I'm working on hardware that currently has a limited number of
>> scratchpad registers and ntb_ndev fails with no clue as to why. I
>> feel it is better to fail early and provide a reasonable error
>> message
>> then to fail later on.
>>
>> The same is done to ntb_perf, but it doesn't currently require enough
>> spads to actually fail. I've also removed the unused SPAD_MSG and
>> SPAD_ACK enums so that MAX_SPAD accurately reflects the number of
>> spads used.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>
> Acked-by: Dave Jiang <dave.jiang@intel.com>

Added to the ntb-next branch.

thanks,
Jon

>> ---
>>  drivers/ntb/ntb_transport.c | 9 +++++++--
>>  drivers/ntb/test/ntb_perf.c | 8 ++++++--
>>  2 files changed, 13 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/ntb/ntb_transport.c
>> b/drivers/ntb/ntb_transport.c
>> index 2ef9d913..6d9940a 100644
>> --- a/drivers/ntb/ntb_transport.c
>> +++ b/drivers/ntb/ntb_transport.c
>> @@ -1037,6 +1037,13 @@ static int ntb_transport_probe(struct
>> ntb_client *self, struct ntb_dev *ndev)
>>       int node;
>>       int rc, i;
>>
>> +     mw_count = ntb_mw_count(ndev);
>> +     if (ntb_spad_count(ndev) < (NUM_MWS + 1 + mw_count * 2)) {
>> +             dev_err(&ndev->dev, "Not enough scratch pad
>> registers for %s",
>> +                     NTB_TRANSPORT_NAME);
>> +             return -EIO;
>> +     }
>> +
>>       if (ntb_db_is_unsafe(ndev))
>>               dev_dbg(&ndev->dev,
>>                       "doorbell is unsafe, proceed anyway...\n");
>> @@ -1052,8 +1059,6 @@ static int ntb_transport_probe(struct
>> ntb_client *self, struct ntb_dev *ndev)
>>
>>       nt->ndev = ndev;
>>
>> -     mw_count = ntb_mw_count(ndev);
>> -
>>       nt->mw_count = mw_count;
>>
>>       nt->mw_vec = kzalloc_node(mw_count * sizeof(*nt->mw_vec),
>> diff --git a/drivers/ntb/test/ntb_perf.c
>> b/drivers/ntb/test/ntb_perf.c
>> index 30635c8..4368519 100644
>> --- a/drivers/ntb/test/ntb_perf.c
>> +++ b/drivers/ntb/test/ntb_perf.c
>> @@ -143,8 +143,6 @@ enum {
>>       VERSION = 0,
>>       MW_SZ_HIGH,
>>       MW_SZ_LOW,
>> -     SPAD_MSG,
>> -     SPAD_ACK,
>>       MAX_SPAD
>>  };
>>
>> @@ -696,6 +694,12 @@ static int perf_probe(struct ntb_client *client,
>> struct ntb_dev *ntb)
>>       int node;
>>       int rc = 0;
>>
>> +     if (ntb_spad_count(ntb) < MAX_SPAD) {
>> +             dev_err(&ntb->dev, "Not enough scratch pad registers
>> for %s",
>> +                     DRIVER_NAME);
>> +             return -EIO;
>> +     }
>> +
>>       node = dev_to_node(&pdev->dev);
>>
>>       perf = kzalloc_node(sizeof(*perf), GFP_KERNEL, node);
>> --
>> 2.1.4
>>
>
> --
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/1465320253.16234.176.camel%40intel.com.
> For more options, visit https://groups.google.com/d/optout.
