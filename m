Return-Path: <Allen.Hubbe@dell.com>
Received: from esa2.dell-outbound.iphmx.com (esa2.dell-outbound.iphmx.com. [68.232.149.220])
        by gmr-mx.google.com with ESMTPS id z131si437089ywz.4.2016.12.02.08.58.26
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Dec 2016 08:58:26 -0800 (PST)
From: "Allen Hubbe" <Allen.Hubbe@dell.com>
References: <77f276f0-18df-6365-1b66-dfe4b30ee7d8@amd.com> <000101d24c42$f507b040$df1710c0$@dell.com> <7e2a1e3b-607a-197e-f965-e26cd3a4af60@amd.com> <000001d24ca8$955380a0$bffa81e0$@dell.com> <8648997a-6e7d-fadb-be24-dc8ecf71d27e@amd.com>
In-Reply-To: <8648997a-6e7d-fadb-be24-dc8ecf71d27e@amd.com>
Subject: RE: [PATCH 1/2] ntb_transport: Limit memory windows based on available, scratchpads
Date: Fri, 2 Dec 2016 11:57:43 -0500
Message-ID: <003601d24cbd$33648000$9a2d8000$@dell.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
To: 'Shyam Sundar S K' <ssundark@amd.com>, 'Jon Mason' <jdmason@kudzu.us>, 'Dave Jiang' <dave.jiang@intel.com>
Cc: "'Yu, Xiangliang'" <Xiangliang.Yu@amd.com>, "'Shah, Nehal-bakulchandra'" <Nehal-bakulchandra.Shah@amd.com>, "'Agrawal, Nitesh-kumar'" <Nitesh-kumar.Agrawal@amd.com>, "'Sen, Pankaj'" <Pankaj.Sen@amd.com>, "'Su, Richard (Bin)'" <Richard1.Su@amd.com>, "'Subramaniyan, Ramkumar'" <ramkumar.ks@amd.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

This should be subject: [PATCH v2 ...]
Next should be PATCH v3.

git format-patch -v3

From: Shyam Sundar S K
> -	for (i = 0; i < MAX_SPAD; i++)
> +	for (i = 0; i < ntb_spad_count(nt->ndev); i++)

count = ntb_spad_count(nt->ndev);
for (i = 0; i < count; i++) ...

The rest looks good.  Thanks.

