Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id b68si705250vke.3.2017.12.03.20.55.10
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Dec 2017 20:55:10 -0800 (PST)
References: <20171203191736.3399-1-fancer.lancer@gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <681f296e-136c-e907-c520-a2035897833a@deltatee.com>
Date: Sun, 3 Dec 2017 21:54:58 -0700
MIME-Version: 1.0
In-Reply-To: <20171203191736.3399-1-fancer.lancer@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 00/15] NTB: Add full multi-port API support to the test
 drivers
To: Serge Semin <fancer.lancer@gmail.com>, jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, Shyam-sundar.S-k@amd.com, Xiangliang.Yu@amd.com, gary.hook@amd.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>



On 03/12/17 12:17 PM, Serge Semin wrote:
> The multi-port NTB API was introduced in kernel 4.13 as well as the
> first driver for the true multi-port devices of IDT PCIe-switches
> series. But the test drivers still were left almost unchanged. Yes,
> they didn't fail being used with new NTB API, but they only worked
> with two-ports NTB devices. This patchset is intended to fix the
> issue, by amending the NTB test drivers and script so they would be
> fully compatible with multi-port NTB API.
> 
> Additionally I found a few NTB subsystem issues while developing the
> submitted patches. So they are also fixed in this patchset.


Did anything change since the last posting of these patches? I took a
very brief look and did not see anything changed.

Logan
