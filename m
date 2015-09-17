Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwdur.emc.com (mailuogwdur.emc.com. [128.221.224.79])
        by gmr-mx.google.com with ESMTPS id uv4si726592pac.0.2015.09.17.13.58.32
        for <linux-ntb@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Sep 2015 13:58:33 -0700 (PDT)
From: "Allen Hubbe" <Allen.Hubbe@emc.com>
References: <20150917202704.72985.32052.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <20150917202704.72985.32052.stgit@djiang5-desk3.ch.intel.com>
Subject: RE: [PATCH v2] NTB: Fix issue where we may be accessing NULL ptr
Date: Thu, 17 Sep 2015 16:58:09 -0400
Message-ID: <007b01d0f18b$901dbac0$b0593040$@emc.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
To: 'Dave Jiang' <dave.jiang@intel.com>, jdmason@kudzu.us
Cc: linux-ntb@googlegroups.com, dan.carpenter@oracle.com
List-ID: <linux-ntb.googlegroups.com>

From: Dave Jiang [mailto:dave.jiang@intel.com]
> smatch detected an issue in the function ntb_transport_max_size() where
> we could be dereferencing a dma channel pointer when it is NULL.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Looks good!

