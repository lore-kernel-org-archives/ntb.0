Return-Path: <jdmason@kudzu.us>
Received: from mail-qt0-x22d.google.com (mail-qt0-x22d.google.com. [2607:f8b0:400d:c0d::22d])
        by gmr-mx.google.com with ESMTPS id c6si8036iob.3.2018.01.23.20.07.10
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jan 2018 20:07:10 -0800 (PST)
Received: by mail-qt0-x22d.google.com with SMTP id i1so7174983qtj.8
        for <linux-ntb@googlegroups.com>; Tue, 23 Jan 2018 20:07:10 -0800 (PST)
Return-Path: <jdmason@kudzu.us>
Date: Tue, 23 Jan 2018 23:07:08 -0500
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH -next] ntb_hw_switchtec: Make function
 switchtec_ntb_remove() static
Message-ID: <20180124040707.GB20474@kudzu.us>
References: <1516673361-170397-1-git-send-email-weiyongjun1@huawei.com>
 <14b5eb05-c152-6a30-d590-881600a8a72f@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14b5eb05-c152-6a30-d590-881600a8a72f@deltatee.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, Kurt Schwemmer <kurt.schwemmer@microsemi.com>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-pci@vger.kernel.org, linux-ntb@googlegroups.com, kernel-janitors@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

On Tue, Jan 23, 2018 at 09:35:52AM -0700, Logan Gunthorpe wrote:
> Looks good, thanks.
> 
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Applied to ntb-next

Thanks,
Jon

> 
> Logan
> 
> 
> On 22/01/18 07:09 PM, Wei Yongjun wrote:
> > Fixes the following sparse warnings:
> > 
> > drivers/ntb/hw/mscc/ntb_hw_switchtec.c:1552:6: warning:
> >   symbol 'switchtec_ntb_remove' was not declared. Should it be static?
> > 
> > Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> > ---
> >   drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> > index a1d547b6..f624ae2 100644
> > --- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> > +++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> > @@ -1549,8 +1549,8 @@ static int switchtec_ntb_add(struct device *dev,
> >   	return rc;
> >   }
> > -void switchtec_ntb_remove(struct device *dev,
> > -			  struct class_interface *class_intf)
> > +static void switchtec_ntb_remove(struct device *dev,
> > +				 struct class_interface *class_intf)
> >   {
> >   	struct switchtec_dev *stdev = to_stdev(dev);
> >   	struct switchtec_ntb *sndev = stdev->sndev;
> > 
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/14b5eb05-c152-6a30-d590-881600a8a72f%40deltatee.com.
> For more options, visit https://groups.google.com/d/optout.
