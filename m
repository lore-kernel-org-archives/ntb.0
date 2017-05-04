Return-Path: <Gary.Hook@amd.com>
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (mail-sn1nam01on0070.outbound.protection.outlook.com. [104.47.32.70])
        by gmr-mx.google.com with ESMTPS id p67si135358pfk.2.2017.05.04.13.52.28
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 May 2017 13:52:28 -0700 (PDT)
Subject: Re: [PATCH V2 1/3] ntb: Add a module option to control affinity of
 DMA channels
References: <20170504201544.10113.13551.stgit@taos.amd.com>
 <20170504202114.10113.67981.stgit@taos.amd.com>
 <059845af-9724-271e-37b5-d518b5ca567a@intel.com>
From: Gary R Hook <ghook@amd.com>
Message-ID: <87fd5f80-cf39-6928-fa82-2acf94a22259@amd.com>
Date: Thu, 4 May 2017 15:52:22 -0500
MIME-Version: 1.0
In-Reply-To: <059845af-9724-271e-37b5-d518b5ca567a@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: ghook@amd.com
To: Dave Jiang <dave.jiang@intel.com>, Gary R Hook <gary.hook@amd.com>, linux-ntb@googlegroups.com
Cc: Allen.Hubbe@emc.com, jdmason@kudzu.us
List-ID: <linux-ntb.googlegroups.com>

On 05/04/2017 03:28 PM, Dave Jiang wrote:
>
>
> On 05/04/2017 01:21 PM, Gary R Hook wrote:
>> The DMA channel(s)/memory used to transfer data to an NTB device
>> may not be required to be on the same node as the device. Add a
>> module parameter that allows any candidate channel (aside from
>> node assocation) and allocated memory to be used.
>>
>> Signed-off-by: Gary R Hook <gary.hook@amd.com>
>> ---
>>  drivers/ntb/test/ntb_perf.c |   16 ++++++++++++++--
>>  1 file changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
>> index 42756a98a728..bfceae0e6477 100644
>> --- a/drivers/ntb/test/ntb_perf.c
>> +++ b/drivers/ntb/test/ntb_perf.c
>> @@ -101,6 +101,10 @@
>>  module_param(use_dma, bool, 0644);
>>  MODULE_PARM_DESC(use_dma, "Using DMA engine to measure performance");
>>
>> +static bool on_node = true; /* default to 1 */
>> +module_param(on_node, bool, 0644);
>> +MODULE_PARM_DESC(on_node, "Run threads only on NTB device node (default: true)");
>> +
>>  struct perf_mw {
>>  	phys_addr_t	phys_addr;
>>  	resource_size_t	phys_size;
>> @@ -345,6 +349,10 @@ static int perf_move_data(struct pthr_ctx *pctx, char __iomem *dst, char *src,
>>
>>  static bool perf_dma_filter_fn(struct dma_chan *chan, void *node)
>>  {
>> +	/* Is the channel required to be on the same node as the device? */
>> +	if (!on_node)
>> +		return true;
>> +
>>  	return dev_to_node(&chan->dev->device) == (int)(unsigned long)node;
>>  }
>>
>> @@ -682,7 +690,8 @@ static ssize_t debugfs_run_write(struct file *filp, const char __user *ubuf,
>>  		pr_info("Fix run_order to %u\n", run_order);
>>  	}
>>
>> -	node = dev_to_node(&perf->ntb->pdev->dev);
>> +	node = on_node ? dev_to_node(&perf->ntb->pdev->dev)
>> +		       : NUMA_NO_NODE;
>>  	atomic_set(&perf->tdone, 0);
>>
>>  	/* launch kernel thread */
>> @@ -781,7 +790,10 @@ static int perf_probe(struct ntb_client *client, struct ntb_dev *ntb)
>>
>>  	node = dev_to_node(&pdev->dev);
>>
>> -	perf = kzalloc_node(sizeof(*perf), GFP_KERNEL, node);
>> +	if (on_node)
>> +		perf = kzalloc_node(sizeof(*perf), GFP_KERNEL, node);
>> +	else
>> +		perf = kzalloc(sizeof(*perf), GFP_KERNEL);
>
> Is this necessary when NUMA_NO_NODE is passed in?

Excellent question. I traced kzalloc_node down to slab_alloc_node(), and 
it does
indeed check (parameter) nodeid against NUMA_NO_NODE. So that would be 
an option
for the node variable above.

However, since the code above, as written, doesn't allow for 
NUMA_NO_NODE, some
additional work will be required to properly handle the option. Look for 
a V3 of
this series.

-- 
This is my day job. Follow me at:
IG/Twitter/Facebook: @grhookphoto
IG/Twitter/Facebook: @grhphotographer
