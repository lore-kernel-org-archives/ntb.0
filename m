Return-Path: <jdmason@kudzu.us>
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com. [2607:f8b0:4864:20::841])
        by gmr-mx.google.com with ESMTPS id b1si322805ots.2.2020.03.13.06.19.32
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2020 06:19:32 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id h16so7384298qtr.11
        for <linux-ntb@googlegroups.com>; Fri, 13 Mar 2020 06:19:32 -0700 (PDT)
Return-Path: <jdmason@kudzu.us>
Date: Fri, 13 Mar 2020 09:19:29 -0400
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH] NTB: ntb_transport: Use scnprintf() for avoiding
 potential buffer overflow
Message-ID: <20200313131928.GC13046@kudzu.us>
References: <20200311084917.18592-1-tiwai@suse.de>
 <03f25a1e-c72f-8fd8-d23e-f0da5e8d39b4@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03f25a1e-c72f-8fd8-d23e-f0da5e8d39b4@deltatee.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Takashi Iwai <tiwai@suse.de>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Wed, Mar 11, 2020 at 11:08:11AM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2020-03-11 2:49 a.m., Takashi Iwai wrote:
> > Since snprintf() returns the would-be-output size instead of the
> > actual output size, the succeeding calls may go beyond the given
> > buffer limit.  Fix it by replacing with scnprintf().
> > 
> > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> 
> Makes sense. Looks good to me!
> 
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> 
> Thanks!


Thanks for the patch (and review).  Since this is a fix, I had to add
some "Fixes:" tags to the commit message.  Since this is touching a
lot of lines added by a number of patches, it's a bit ugly.  But, here
is what I added.

    Fixes: fce8a7bb5b4b (PCI-Express Non-Transparent Bridge Support)
    Fixes: 282a2feeb9bf (NTB: Use DMA Engine to Transmit and Receive)
    Fixes: a754a8fcaf38 (NTB: allocate number transport entries depending on size of ring size)
    Fixes: d98ef99e378b (NTB: Clean up QP stats info)
    Fixes: e74bfeedad08 (NTB: Add flow control to the ntb_netdev)
    Fixes: 569410ca756c (NTB: Use unique DMA channels for TX and RX)

I pulled it in to my ntb branch with the above change.

Thanks,
Jon

> 
> > ---
> >  drivers/ntb/ntb_transport.c | 58 ++++++++++++++++++++++-----------------------
> >  1 file changed, 29 insertions(+), 29 deletions(-)
> > 
> > diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> > index 00a5d5764993..e6d1f5b298f3 100644
> > --- a/drivers/ntb/ntb_transport.c
> > +++ b/drivers/ntb/ntb_transport.c
> > @@ -481,70 +481,70 @@ static ssize_t debugfs_read(struct file *filp, char __user *ubuf, size_t count,
> >  		return -ENOMEM;
> >  
> >  	out_offset = 0;
> > -	out_offset += snprintf(buf + out_offset, out_count - out_offset,
> > +	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> >  			       "\nNTB QP stats:\n\n");
> > -	out_offset += snprintf(buf + out_offset, out_count - out_offset,
> > +	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> >  			       "rx_bytes - \t%llu\n", qp->rx_bytes);
> > -	out_offset += snprintf(buf + out_offset, out_count - out_offset,
> > +	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> >  			       "rx_pkts - \t%llu\n", qp->rx_pkts);
> > -	out_offset += snprintf(buf + out_offset, out_count - out_offset,
> > +	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> >  			       "rx_memcpy - \t%llu\n", qp->rx_memcpy);
> > -	out_offset += snprintf(buf + out_offset, out_count - out_offset,
> > +	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> >  			       "rx_async - \t%llu\n", qp->rx_async);
> > -	out_offset += snprintf(buf + out_offset, out_count - out_offset,
> > +	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> >  			       "rx_ring_empty - %llu\n", qp->rx_ring_empty);
> > -	out_offset += snprintf(buf + out_offset, out_count - out_offset,
> > +	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> >  			       "rx_err_no_buf - %llu\n", qp->rx_err_no_buf);
> > -	out_offset += snprintf(buf + out_offset, out_count - out_offset,
> > +	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> >  			       "rx_err_oflow - \t%llu\n", qp->rx_err_oflow);
> > -	out_offset += snprintf(buf + out_offset, out_count - out_offset,
> > +	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> >  			       "rx_err_ver - \t%llu\n", qp->rx_err_ver);
> > -	out_offset += snprintf(buf + out_offset, out_count - out_offset,
> > +	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> >  			       "rx_buff - \t0x%p\n", qp->rx_buff);
> > -	out_offset += snprintf(buf + out_offset, out_count - out_offset,
> > +	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> >  			       "rx_index - \t%u\n", qp->rx_index);
> > -	out_offset += snprintf(buf + out_offset, out_count - out_offset,
> > +	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> >  			       "rx_max_entry - \t%u\n", qp->rx_max_entry);
> > -	out_offset += snprintf(buf + out_offset, out_count - out_offset,
> > +	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> >  			       "rx_alloc_entry - \t%u\n\n", qp->rx_alloc_entry);
> >  
> > -	out_offset += snprintf(buf + out_offset, out_count - out_offset,
> > +	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> >  			       "tx_bytes - \t%llu\n", qp->tx_bytes);
> > -	out_offset += snprintf(buf + out_offset, out_count - out_offset,
> > +	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> >  			       "tx_pkts - \t%llu\n", qp->tx_pkts);
> > -	out_offset += snprintf(buf + out_offset, out_count - out_offset,
> > +	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> >  			       "tx_memcpy - \t%llu\n", qp->tx_memcpy);
> > -	out_offset += snprintf(buf + out_offset, out_count - out_offset,
> > +	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> >  			       "tx_async - \t%llu\n", qp->tx_async);
> > -	out_offset += snprintf(buf + out_offset, out_count - out_offset,
> > +	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> >  			       "tx_ring_full - \t%llu\n", qp->tx_ring_full);
> > -	out_offset += snprintf(buf + out_offset, out_count - out_offset,
> > +	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> >  			       "tx_err_no_buf - %llu\n", qp->tx_err_no_buf);
> > -	out_offset += snprintf(buf + out_offset, out_count - out_offset,
> > +	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> >  			       "tx_mw - \t0x%p\n", qp->tx_mw);
> > -	out_offset += snprintf(buf + out_offset, out_count - out_offset,
> > +	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> >  			       "tx_index (H) - \t%u\n", qp->tx_index);
> > -	out_offset += snprintf(buf + out_offset, out_count - out_offset,
> > +	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> >  			       "RRI (T) - \t%u\n",
> >  			       qp->remote_rx_info->entry);
> > -	out_offset += snprintf(buf + out_offset, out_count - out_offset,
> > +	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> >  			       "tx_max_entry - \t%u\n", qp->tx_max_entry);
> > -	out_offset += snprintf(buf + out_offset, out_count - out_offset,
> > +	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> >  			       "free tx - \t%u\n",
> >  			       ntb_transport_tx_free_entry(qp));
> >  
> > -	out_offset += snprintf(buf + out_offset, out_count - out_offset,
> > +	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> >  			       "\n");
> > -	out_offset += snprintf(buf + out_offset, out_count - out_offset,
> > +	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> >  			       "Using TX DMA - \t%s\n",
> >  			       qp->tx_dma_chan ? "Yes" : "No");
> > -	out_offset += snprintf(buf + out_offset, out_count - out_offset,
> > +	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> >  			       "Using RX DMA - \t%s\n",
> >  			       qp->rx_dma_chan ? "Yes" : "No");
> > -	out_offset += snprintf(buf + out_offset, out_count - out_offset,
> > +	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> >  			       "QP Link - \t%s\n",
> >  			       qp->link_is_up ? "Up" : "Down");
> > -	out_offset += snprintf(buf + out_offset, out_count - out_offset,
> > +	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> >  			       "\n");
> >  
> >  	if (out_offset > out_count)
> > 
