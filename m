Return-Path: <Allen.Hubbe@dell.com>
Received: from esa5.dell-outbound.iphmx.com (esa5.dell-outbound.iphmx.com. [68.232.153.95])
        by gmr-mx.google.com with ESMTPS id q185si1977349ywh.4.2016.11.14.06.35.47
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Nov 2016 06:35:48 -0800 (PST)
From: "Allen Hubbe" <Allen.Hubbe@dell.com>
References: <c44465a3-780b-3dbd-22dc-4be241009e3c@amd.com>
In-Reply-To: <c44465a3-780b-3dbd-22dc-4be241009e3c@amd.com>
Subject: RE: [PATCH] NTB: Register and offset values fix for memory window
Date: Mon, 14 Nov 2016 09:35:25 -0500
Message-ID: <000001d23e84$5720d3a0$05627ae0$@emc.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
To: 'Shyam Sundar S K' <ssundark@amd.com>, "'Yu, Xiangliang'" <Xiangliang.Yu@amd.com>, jdmason@kudzu.us
Cc: dave.jiang@intel.com, linux-ntb@googlegroups.com, "'Sen, Pankaj'" <Pankaj.Sen@amd.com>, "'Shah, Nehal-bakulchandra'" <Nehal-bakulchandra.Shah@amd.com>, "'Agrawal, Nitesh-kumar'" <Nitesh-kumar.Agrawal@amd.com>, "'Subramaniyan, Ramkumar'" <ramkumar.ks@amd.com>, Richard1.Su@amd.com
List-ID: <linux-ntb.googlegroups.com>

From: Shyam Sundar S K
> Due to incorrect limit and translation register values, NTB link was
> going down when the memory window translation was setup. Made appropriate
> changes as per spec.
> 
> Also, fixed the limit register values for BAR1, which was overlapping
> with the BAR23 address.
> 
> Reviewed-by: Sen, Pankaj <Pankaj.Sen@amd.com>
> Reviewed-by: Shah, Nehal-bakulchandra <Nehal-bakulchandra.Shah@amd.com>
> Acked-by: Xiangliang Yu <Xiangliang.Yu@amd.com>
> Signed-off-by: S-k, Shyam-sundar <Shyam-sundar.S-k@amd.com>
> ---

> @@ -376,13 +371,11 @@ static u32 amd_ntb_spad_read(struct ntb_dev *ntb, int idx)
>  {
>  	struct amd_ntb_dev *ndev = ntb_ndev(ntb);
>  	void __iomem *mmio = ndev->self_mmio;
> -	u32 offset;
> 
> -	if (idx < 0 || idx >= ndev->spad_count)
> +	if (idx < 0 || idx >= (ndev->spad_count + 4))

Why does this change add four to the upper end of the range check?  Does spad_count have the wrong number of spads?

>  		return 0;
> 
> -	offset = ndev->self_spad + (idx << 2);
> -	return readl(mmio + AMD_SPAD_OFFSET + offset);
> +	return readl(mmio + AMD_SPAD_OFFSET + (idx << 2));

The self_spad is used for sharing the spads of a single ntb.  It is the offset of the first or second half of the spads, and the peer self_spad is the other half.  From this change, can we assume that a single-ntb topology will not be supported?

