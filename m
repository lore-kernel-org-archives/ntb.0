Return-Path: <Shyam-sundar.S-k@amd.com>
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (mail-cys01nam02on0078.outbound.protection.outlook.com. [104.47.37.78])
        by gmr-mx.google.com with ESMTPS id g192si1695866pfb.1.2016.12.02.04.33.09
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 02 Dec 2016 04:33:09 -0800 (PST)
Subject: Re: [PATCH 1/2] ntb_transport: Limit memory windows based on
 available, scratchpads
References: <77f276f0-18df-6365-1b66-dfe4b30ee7d8@amd.com>
 <000101d24c42$f507b040$df1710c0$@dell.com>
From: Shyam Sundar S K <ssundark@amd.com>
Message-ID: <7e2a1e3b-607a-197e-f965-e26cd3a4af60@amd.com>
Date: Fri, 2 Dec 2016 18:02:42 +0530
MIME-Version: 1.0
In-Reply-To: <000101d24c42$f507b040$df1710c0$@dell.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-Path: ssundark@amd.com
To: Allen Hubbe <Allen.Hubbe@dell.com>, 'Jon Mason' <jdmason@kudzu.us>, 'Dave Jiang' <dave.jiang@intel.com>
Cc: "'Yu, Xiangliang'" <Xiangliang.Yu@amd.com>, "'Shah, Nehal-bakulchandra'" <Nehal-bakulchandra.Shah@amd.com>, "'Agrawal, Nitesh-kumar'" <Nitesh-kumar.Agrawal@amd.com>, "'Sen, Pankaj'" <Pankaj.Sen@amd.com>, "'Su,
 Richard (Bin)'" <Richard1.Su@amd.com>, "'Subramaniyan, Ramkumar'" <ramkumar.ks@amd.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>



On 12/2/2016 7:52 AM, Allen Hubbe wrote:
> From: Shyam Sundar S K
>> When the underlying NTB H/W driver advertises more memory windows
>> than the number of scratchpads available to setup MW's, it is likely
>> that we may end up filling the remaining memory windows with garbage.
>> So to avoid that, lets limit the memory windows that transport driver
>> can setup based on the available scratchpads.
> 
> This change should also touch:
> 
> static void ntb_transport_link_cleanup(struct ntb_transport_ctx *nt)
> {
> ...
> 	/* The scratchpad registers keep the values if the remote side
> 	 * goes down, blast them now to give them a sane value the next
> 	 * time they are accessed
> 	 */
> 	for (i = 0; i < MAX_SPAD; i++)
> 		ntb_spad_write(nt->ndev, i, 0);
> 
> The MAX_SPAD value is incorrect with three MWs and I think we should drop it.  Instead, this section should ntb_spad_write(ndev, i, 0) for i in 0..ntb_spad_count(ndev).
> 
> Not having exactly two memory windows, these may be dropped as well: MW1_SZ_HIGH, MW1_SZ_LOW.  They seem to be unused in the code, anyway.
> 
> It is still useful to keep MW0_SZ_HIGH and MW0_SZ_LOW for indexing.
> 
>>
>> Reviewed-by: Shah, Nehal-bakulchandra <Nehal-bakulchandra.Shah@amd.com>
>> Reviewed-by: Agrawal, Nitesh-kumar <Nitesh-kumar.Agrawal@amd.com>
>> Signed-off-by: S-k, Shyam-sundar <Shyam-sundar.S-k@amd.com>
>> ---
>>  drivers/ntb/ntb_transport.c | 12 ++++++++++--
>>  1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
>> index 4eb8adb..50d6b06 100644
>> --- a/drivers/ntb/ntb_transport.c
>> +++ b/drivers/ntb/ntb_transport.c
>> @@ -1064,7 +1064,7 @@ static int ntb_transport_probe(struct ntb_client *self, struct
>> ntb_dev *ndev)
>>  {
>>  	struct ntb_transport_ctx *nt;
>>  	struct ntb_transport_mw *mw;
>> -	unsigned int mw_count, qp_count;
>> +	unsigned int mw_count, qp_count, spad_count, max_mw_count_for_spads;
>>  	u64 qp_bitmap;
>>  	int node;
>>  	int rc, i;
>> @@ -1090,8 +1090,16 @@ static int ntb_transport_probe(struct ntb_client *self, struct
>> ntb_dev *ndev)
>>  		return -ENOMEM;
>>
>>  	nt->ndev = ndev;
>> +	spad_count = ntb_spad_count(ndev);
>>
>> -	nt->mw_count = mw_count;
>> +    /* Limit the MW's based on the availability of scratchpads */
>> +	if (spad_count > NUM_MWS + 2) {
>> +		max_mw_count_for_spads = (spad_count - (NUM_MWS + 1)) >> 1;
>> +		nt->mw_count = min(mw_count, max_mw_count_for_spads);
>> +	} else {
>> +		nt->mw_count = 0;
>> +		goto err;
>> +	}
> 
> It is somewhat confusing to have a NUM_MWS + 2 and also NUM_MWS + 1.  We could #define the minimum number of spads needed by ntb_transport.
> 
> #define NTB_TRANSPORT_MIN_SPADS (MW0_SZ_HIGH + 2)
> 
> I think it would be more clearly written as:
> 
> if (spad_count < NTB_TRANSPORT_MIN_SPADS) {
> 	nt->mw_count = 0;
> 	goto err;
> }
> 

Allen, I will submit the patch which will accommodate all the suggestions you have made. Do you feel this part of the code is required in ntb_transport_probe() ?

	if (ntb_spad_count(ndev) < (NUM_MWS + 1 + mw_count * 2)) {
		dev_err(&ndev->dev, "Not enough scratch pad registers for %s",
			NTB_TRANSPORT_NAME);
		return -EIO;
	}

Because in case of AMD, this condition will always fail.

> max_mw_count_for_spads = (spad_count - MW0_SZ_HIGH) / 2;
> nt->mw_count = min(mw_count, max_mw_count_for_spads);
> 
>>
>>  	nt->mw_vec = kzalloc_node(mw_count * sizeof(*nt->mw_vec),
>>  				  GFP_KERNEL, node);
>> --
>> 2.7.4
> 
