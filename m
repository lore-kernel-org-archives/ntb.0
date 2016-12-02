Return-Path: <Allen.Hubbe@dell.com>
Received: from esa7.dell-outbound.iphmx.com (esa7.dell-outbound.iphmx.com. [68.232.153.96])
        by gmr-mx.google.com with ESMTPS id p22si492528ywe.3.2016.12.02.06.30.20
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Dec 2016 06:30:20 -0800 (PST)
From: "Allen Hubbe" <Allen.Hubbe@dell.com>
References: <77f276f0-18df-6365-1b66-dfe4b30ee7d8@amd.com> <000101d24c42$f507b040$df1710c0$@dell.com> <7e2a1e3b-607a-197e-f965-e26cd3a4af60@amd.com>
In-Reply-To: <7e2a1e3b-607a-197e-f965-e26cd3a4af60@amd.com>
Subject: RE: [PATCH 1/2] ntb_transport: Limit memory windows based on available, scratchpads
Date: Fri, 2 Dec 2016 09:30:07 -0500
Message-ID: <000001d24ca8$955380a0$bffa81e0$@dell.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
To: 'Shyam Sundar S K' <ssundark@amd.com>, 'Jon Mason' <jdmason@kudzu.us>, 'Dave Jiang' <dave.jiang@intel.com>
Cc: "'Yu, Xiangliang'" <Xiangliang.Yu@amd.com>, "'Shah, Nehal-bakulchandra'" <Nehal-bakulchandra.Shah@amd.com>, "'Agrawal, Nitesh-kumar'" <Nitesh-kumar.Agrawal@amd.com>, "'Sen, Pankaj'" <Pankaj.Sen@amd.com>, "'Su, Richard (Bin)'" <Richard1.Su@amd.com>, "'Subramaniyan, Ramkumar'" <ramkumar.ks@amd.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

From: Shyam Sundar S K
> Do you feel this part of the code is required in ntb_transport_probe() ?
> 
> 	if (ntb_spad_count(ndev) < (NUM_MWS + 1 + mw_count * 2)) {
> 		dev_err(&ndev->dev, "Not enough scratch pad registers for %s",
> 			NTB_TRANSPORT_NAME);
> 		return -EIO;
> 	}
> 
> Because in case of AMD, this condition will always fail.

You're right.  That check can be removed with the addition of your other changes.

