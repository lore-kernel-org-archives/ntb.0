Return-Path: <jdmason@kudzu.us>
Received: from mail-vk0-x242.google.com (mail-vk0-x242.google.com. [2607:f8b0:400c:c05::242])
        by gmr-mx.google.com with ESMTPS id t74si458005vkb.0.2016.06.04.08.25.18
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Jun 2016 08:25:18 -0700 (PDT)
Received: by mail-vk0-x242.google.com with SMTP id t7so2833215vkf.2
        for <linux-ntb@googlegroups.com>; Sat, 04 Jun 2016 08:25:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1464987814.16234.148.camel@intel.com>
References: <cover.1464986161.git.logang@deltatee.com> <9e9ca38bef468fc1dd3d135f5f3d3cfb6b61246d.1464986161.git.logang@deltatee.com>
 <1464987814.16234.148.camel@intel.com>
From: Jon Mason <jdmason@kudzu.us>
Date: Sat, 4 Jun 2016 11:25:17 -0400
Message-ID: <CAPoiz9yx8irYGsEdu8952-buX8iR6FEH1=XPrib93WFyEkvtKQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] ntb_perf: Allow limiting the size of the memory windows
Content-Type: text/plain; charset=UTF-8
To: "Jiang, Dave" <dave.jiang@intel.com>
Cc: "Allen.Hubbe@emc.com" <Allen.Hubbe@emc.com>, "logang@deltatee.com" <logang@deltatee.com>, "sudipm.mukherjee@gmail.com" <sudipm.mukherjee@gmail.com>, "arnd@arndb.de" <arnd@arndb.de>, "john.kading@gd-ms.com" <john.kading@gd-ms.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

On Fri, Jun 3, 2016 at 5:03 PM, Jiang, Dave <dave.jiang@intel.com> wrote:
> On Fri, 2016-06-03 at 14:50 -0600, Logan Gunthorpe wrote:
>> On my system, dma_alloc_coherent won't produce memory anywhere
>> near the size of the BAR. So I needed a way to limit this.
>>
>> It's pretty much copied straight from ntb_transport.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Acked-by: Dave Jiang <dave.jiang@intel.com>

Applied to my ntb-next branch

Thanks,
Jon

>> ---
>>  drivers/ntb/test/ntb_perf.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/ntb/test/ntb_perf.c
>> b/drivers/ntb/test/ntb_perf.c
>> index 8dfce9c..30635c8 100644
>> --- a/drivers/ntb/test/ntb_perf.c
>> +++ b/drivers/ntb/test/ntb_perf.c
>> @@ -83,6 +83,10 @@ MODULE_DESCRIPTION(DRIVER_DESCRIPTION);
>>
>>  static struct dentry *perf_debugfs_dir;
>>
>> +static unsigned long max_mw_size;
>> +module_param(max_mw_size, ulong, 0644);
>> +MODULE_PARM_DESC(max_mw_size, "Limit size of large memory windows");
>> +
>>  static unsigned int seg_order = 19; /* 512K */
>>  module_param(seg_order, uint, 0644);
>>  MODULE_PARM_DESC(seg_order, "size order [n^2] of buffer segment for
>> testing");
>> @@ -472,6 +476,10 @@ static void perf_link_work(struct work_struct
>> *work)
>>       dev_dbg(&perf->ntb->pdev->dev, "%s called\n", __func__);
>>
>>       size = perf->mw.phys_size;
>> +
>> +     if (max_mw_size && size > max_mw_size)
>> +             size = max_mw_size;
>> +
>>       ntb_peer_spad_write(ndev, MW_SZ_HIGH, upper_32_bits(size));
>>       ntb_peer_spad_write(ndev, MW_SZ_LOW, lower_32_bits(size));
>>       ntb_peer_spad_write(ndev, VERSION, PERF_VERSION);
>> --
>> 2.1.4
>>
