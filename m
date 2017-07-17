Return-Path: <jdmason@kudzu.us>
Received: from mail-ua0-x241.google.com (mail-ua0-x241.google.com. [2607:f8b0:400c:c08::241])
        by gmr-mx.google.com with ESMTPS id s186si1357981vke.10.2017.07.17.08.16.52
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jul 2017 08:16:52 -0700 (PDT)
Received: by mail-ua0-x241.google.com with SMTP id 35so3624007uax.1
        for <linux-ntb@googlegroups.com>; Mon, 17 Jul 2017 08:16:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <000001d2ef5f$1ed1e750$5c75b5f0$@dell.com>
References: <20170626195041.6190-1-logang@deltatee.com> <000001d2ef5f$1ed1e750$5c75b5f0$@dell.com>
From: Jon Mason <jdmason@kudzu.us>
Date: Mon, 17 Jul 2017 11:16:51 -0400
Message-ID: <CAPoiz9wapj4qx5pSRhHpNWOiSHKgAXNu6xdVeecBNQEo72U4Xw@mail.gmail.com>
Subject: Re: [PATCH] ntb: use correct mw_count function in ntb_tool and ntb_transport
Content-Type: text/plain; charset="UTF-8"
To: Allen Hubbe <Allen.Hubbe@dell.com>
Cc: Logan Gunthorpe <logang@deltatee.com>, linux-ntb@googlegroups.com, linux-kernel <linux-kernel@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

On Tue, Jun 27, 2017 at 12:04 PM, Allen Hubbe <Allen.Hubbe@dell.com> wrote:
> From: Logan Gunthorpe
>> After converting to the new API, both ntb_tool and ntb_transport are
>> using ntb_mw_count to iterate through ntb_peer_get_addr when they
>> should be using ntb_peer_mw_count.
>>
>> This probably isn't an issue with the Intel and AMD drivers but
>> this will matter for any future driver with asymetric memory window
>> counts.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> Cc: Jon Mason <jdmason@kudzu.us>
>> Cc: Dave Jiang <dave.jiang@intel.com>
>> Cc: Allen Hubbe <Allen.Hubbe@emc.com>
>> Cc: Serge Semin <fancer.lancer@gmail.com>
>
> Acked-by: Allen Hubbe <Allen.Hubbe@dell.com>
>
>> ---
>>
>> Hi Guys,
>>
>> I caught this issue while finishing up the switchtec rebase. (Which is
>> now working again and I'll send the updated series after doing a bit more
>> testing.)
>>
>> However, seeing this is a bug in the new api patches I feel it should
>> be applied to ntb-next tree before it's merged upstream.

Per your request, this has been applied to my ntb-next branch.

Thanks,
Jon

>>
>> Thanks,
>>
>> Logan
>>
>>  drivers/ntb/ntb_transport.c | 2 +-
>>  drivers/ntb/test/ntb_tool.c | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
>> index 9a03c5871efe..b29558ddfe95 100644
>> --- a/drivers/ntb/ntb_transport.c
>> +++ b/drivers/ntb/ntb_transport.c
>> @@ -1059,7 +1059,7 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
>>       int node;
>>       int rc, i;
>>
>> -     mw_count = ntb_mw_count(ndev, PIDX);
>> +     mw_count = ntb_peer_mw_count(ndev);
>>
>>       if (!ndev->ops->mw_set_trans) {
>>               dev_err(&ndev->dev, "Inbound MW based NTB API is required\n");
>> diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
>> index f002bf48a08d..a69815c45ce6 100644
>> --- a/drivers/ntb/test/ntb_tool.c
>> +++ b/drivers/ntb/test/ntb_tool.c
>> @@ -959,7 +959,7 @@ static int tool_probe(struct ntb_client *self, struct ntb_dev *ntb)
>>       tc->ntb = ntb;
>>       init_waitqueue_head(&tc->link_wq);
>>
>> -     tc->mw_count = min(ntb_mw_count(tc->ntb, PIDX), MAX_MWS);
>> +     tc->mw_count = min(ntb_peer_mw_count(tc->ntb), MAX_MWS);
>>       for (i = 0; i < tc->mw_count; i++) {
>>               rc = tool_init_mw(tc, i);
>>               if (rc)
>> --
>> 2.11.0
>
