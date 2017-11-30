Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x230.google.com (mail-lf0-x230.google.com. [2a00:1450:4010:c07::230])
        by gmr-mx.google.com with ESMTPS id h45si243237eda.2.2017.11.30.14.14.31
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Nov 2017 14:14:31 -0800 (PST)
Received: by mail-lf0-x230.google.com with SMTP id f20so9629274lfe.3
        for <linux-ntb@googlegroups.com>; Thu, 30 Nov 2017 14:14:31 -0800 (PST)
Return-Path: <fancer.lancer@gmail.com>
Date: Fri, 1 Dec 2017 01:14:31 +0300
From: Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH] NTB: ntb_hw_idt: Set NTB_TOPO_SWITCH topology
Message-ID: <20171130221431.GB20562@mobilestation>
References: <20171130214107.21194-1-fancer.lancer@gmail.com>
 <05386287-e0c2-5dd3-4e9b-6f64c61f8405@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05386287-e0c2-5dd3-4e9b-6f64c61f8405@deltatee.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, Shyam-sundar.S-k@amd.com, Xiangliang.Yu@amd.com, Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

On Thu, Nov 30, 2017 at 03:06:15PM -0700, Logan Gunthorpe <logang@deltatee.com> wrote:
> 
> 
> On 30/11/17 02:41 PM, Serge Semin wrote:
> >Since Switchtec patch there has been a new topology added to
> >the NTB API. It's called NTB_TOPO_SWITCH and dedicated for
> >PCIe switch chips. Even though topo field isn't used within the
> >IDT driver much, lets set it for the sake of unification.
> >
> >Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> >Acked-by: Serge Semin <fancer.lancer@gmail.com>
> 
> You don't need to Ack your own patches ;)
> 

It goes to the subsystem maintained by me. I tested the change, so am responsible
for the results.

> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/05386287-e0c2-5dd3-4e9b-6f64c61f8405%40deltatee.com.
> For more options, visit https://groups.google.com/d/optout.
