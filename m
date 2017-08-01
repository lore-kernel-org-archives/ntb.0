Return-Path: <jdmason@kudzu.us>
Received: from mail-qt0-x242.google.com (mail-qt0-x242.google.com. [2607:f8b0:400d:c0d::242])
        by gmr-mx.google.com with ESMTPS id b187si1554743ywd.1.2017.08.01.11.11.39
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Aug 2017 11:11:39 -0700 (PDT)
Received: by mail-qt0-x242.google.com with SMTP id u19so2373138qtc.0
        for <linux-ntb@googlegroups.com>; Tue, 01 Aug 2017 11:11:39 -0700 (PDT)
Return-Path: <jdmason@kudzu.us>
Date: Tue, 1 Aug 2017 14:11:36 -0400
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH v3 07/16] ntb: add check and comment for link up to
 mw_count() and mw_get_align()
Message-ID: <20170801181136.GD4186@kudzu.us>
References: <20170725205753.4735-1-logang@deltatee.com>
 <20170725205753.4735-8-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170725205753.4735-8-logang@deltatee.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-ntb@googlegroups.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>, Bjorn Helgaas <bhelgaas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kurt Schwemmer <kurt.schwemmer@microsemi.com>, Stephen Bates <sbates@raithlin.com>, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

On Tue, Jul 25, 2017 at 02:57:44PM -0600, Logan Gunthorpe wrote:
> Adds a comment and a check to ntb_mw_get_align() so that it always fails
> if the function is called before the link is up.
> 
> Also adds a comment to ntb_mw_count() to note that it may return 0 if
> it is called before the link is up.
> 
> This is to prevent accidental mis-use in clients that are testing
> on hardware that this doesn't matter for.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Similar to the last one, I think this is also a bug fix.  I'll pull it
out, etc.  :)

Thanks,
Jon

> ---
>  include/linux/ntb.h | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/ntb.h b/include/linux/ntb.h
> index 609e232c00da..47f2966cfd7f 100644
> --- a/include/linux/ntb.h
> +++ b/include/linux/ntb.h
> @@ -730,7 +730,8 @@ static inline int ntb_link_disable(struct ntb_dev *ntb)
>   * Hardware and topology may support a different number of memory windows.
>   * Moreover different peer devices can support different number of memory
>   * windows. Simply speaking this method returns the number of possible inbound
> - * memory windows to share with specified peer device.
> + * memory windows to share with specified peer device. Note: this may return
> + * zero if the link is not up yet.
>   *
>   * Return: the number of memory windows.
>   */
> @@ -751,7 +752,7 @@ static inline int ntb_mw_count(struct ntb_dev *ntb, int pidx)
>   * Get the alignments of an inbound memory window with specified index.
>   * NULL may be given for any output parameter if the value is not needed.
>   * The alignment and size parameters may be used for allocation of proper
> - * shared memory.
> + * shared memory. Note: this must only be called when the link is up.
>   *
>   * Return: Zero on success, otherwise a negative error number.
>   */
> @@ -760,6 +761,9 @@ static inline int ntb_mw_get_align(struct ntb_dev *ntb, int pidx, int widx,
>  				   resource_size_t *size_align,
>  				   resource_size_t *size_max)
>  {
> +	if (!(ntb_link_is_up(ntb, NULL, NULL) & (1 << pidx)))
> +		return -ENOTCONN;
> +
>  	return ntb->ops->mw_get_align(ntb, pidx, widx, addr_align, size_align,
>  				      size_max);
>  }
> -- 
> 2.11.0
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/20170725205753.4735-8-logang%40deltatee.com.
> For more options, visit https://groups.google.com/d/optout.
