Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x230.google.com (mail-lf0-x230.google.com. [2a00:1450:4010:c07::230])
        by gmr-mx.google.com with ESMTPS id e80si249463wmi.2.2017.12.03.22.12.11
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Dec 2017 22:12:11 -0800 (PST)
Received: by mail-lf0-x230.google.com with SMTP id i2so17768312lfe.9
        for <linux-ntb@googlegroups.com>; Sun, 03 Dec 2017 22:12:11 -0800 (PST)
Return-Path: <fancer.lancer@gmail.com>
Date: Mon, 4 Dec 2017 09:12:15 +0300
From: Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH v2 00/15] NTB: Add full multi-port API support to the
 test drivers
Message-ID: <20171204061215.GA30883@mobilestation>
References: <20171203191736.3399-1-fancer.lancer@gmail.com>
 <681f296e-136c-e907-c520-a2035897833a@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <681f296e-136c-e907-c520-a2035897833a@deltatee.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, Shyam-sundar.S-k@amd.com, Xiangliang.Yu@amd.com, gary.hook@amd.com, Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

On Sun, Dec 03, 2017 at 09:54:58PM -0700, Logan Gunthorpe <logang@deltatee.com> wrote:
> 
> 
> On 03/12/17 12:17 PM, Serge Semin wrote:
> > The multi-port NTB API was introduced in kernel 4.13 as well as the
> > first driver for the true multi-port devices of IDT PCIe-switches
> > series. But the test drivers still were left almost unchanged. Yes,
> > they didn't fail being used with new NTB API, but they only worked
> > with two-ports NTB devices. This patchset is intended to fix the
> > issue, by amending the NTB test drivers and script so they would be
> > fully compatible with multi-port NTB API.
> > 
> > Additionally I found a few NTB subsystem issues while developing the
> > submitted patches. So they are also fixed in this patchset.
> 
> 
> Did anything change since the last posting of these patches? I took a
> very brief look and did not see anything changed.
> 

Nothing has changed.

> Logan
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/681f296e-136c-e907-c520-a2035897833a%40deltatee.com.
> For more options, visit https://groups.google.com/d/optout.
