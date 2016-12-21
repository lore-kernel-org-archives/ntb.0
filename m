Return-Path: <jdmason@kudzu.us>
Received: from mail-yw0-x242.google.com (mail-yw0-x242.google.com. [2607:f8b0:4002:c05::242])
        by gmr-mx.google.com with ESMTPS id h18si773957ywc.2.2016.12.21.09.03.10
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Dec 2016 09:03:10 -0800 (PST)
Received: by mail-yw0-x242.google.com with SMTP id s68so13210362ywg.0
        for <linux-ntb@googlegroups.com>; Wed, 21 Dec 2016 09:03:10 -0800 (PST)
Return-Path: <jdmason@kudzu.us>
Date: Wed, 21 Dec 2016 12:03:03 -0500
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH] NTB: add support for hotplug feature
Message-ID: <20161221170302.GH32599@kudzu.us>
References: <00df7583-4784-d855-7ed8-442f9bfe08e2@amd.com>
 <ae6aadff-1e4f-3ad5-66c0-c6678743884f@amd.com>
 <000101d24fcc$ae2af820$0a80e860$@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000101d24fcc$ae2af820$0a80e860$@dell.com>
To: Allen Hubbe <Allen.Hubbe@dell.com>
Cc: 'Shyam Sundar S K' <ssundark@amd.com>, "'Yu, Xiangliang'" <Xiangliang.Yu@amd.com>, dave.jiang@intel.com, "'Shah, Nehal-bakulchandra'" <Nehal-bakulchandra.Shah@amd.com>, "'Subramaniyan, Ramkumar'" <ramkumar.ks@amd.com>, "'Su, Richard (Bin)'" <Richard1.Su@amd.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Tue, Dec 06, 2016 at 09:26:05AM -0500, Allen Hubbe wrote:
> From: Shyam Sundar S K
> > Hi Allen, Jon
> > 
> > Any feedback on the below changes ?
> > 
> 
> Acked-by: Allen Hubbe <Allen.Hubbe@dell.com>
> 
> > Thanks,
> > Shyam
> > 
> > On 11/18/2016 2:51 PM, Shyam Sundar S K wrote:
> > > From: Xiangliang Yu <Xiangliang.Yu@amd.com>
> > >
> > > AMD NTB support hotplug under B2B mode. NTB will trigger link
> > > up/down interrupt event when doing plug add/remove, this patch
> > > implements the two interrupt event to support B2B hotplug function.
> > >
> > > Signed-off-by: Xiangliang Yu <Xiangliang.Yu@amd.com>
> > > Signed-off-by: S-k, Shyam-sundar <Shyam-sundar.S-k@amd.com>

I have applied this to my ntb branch.  However, the signed-off-by
above does not conform to the "firstname lastname", due to the comma
and flip of the names.  I see in the maintainer patch that this is
flipped.  So, I am going to correct this by hand.  In the future,
please use
    Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>

Thanks,
Jon

> > > ---
> > >  drivers/ntb/hw/amd/ntb_hw_amd.c | 9 ++++++++-
> > >  drivers/ntb/hw/amd/ntb_hw_amd.h | 5 ++++-
> > >  2 files changed, 12 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
> > > index 9bbe3e0..2fc202c 100644
> > > --- a/drivers/ntb/hw/amd/ntb_hw_amd.c
> > > +++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
> > > @@ -194,6 +194,11 @@ static int amd_link_is_up(struct amd_ntb_dev *ndev)
> > >  	if (!ndev->peer_sta)
> > >  		return NTB_LNK_STA_ACTIVE(ndev->cntl_sta);
> > >
> > > +	if (ndev->peer_sta & AMD_LINK_UP_EVENT) {
> > > +		ndev->peer_sta = 0;
> > > +		return 1;
> > > +	}
> > > +
> > >  	/* If peer_sta is reset or D0 event, the ISR has
> > >  	 * started a timer to check link status of hardware.
> > >  	 * So here just clear status bit. And if peer_sta is
> > > @@ -202,7 +207,7 @@ static int amd_link_is_up(struct amd_ntb_dev *ndev)
> > >  	 */
> > >  	if (ndev->peer_sta & AMD_PEER_RESET_EVENT)
> > >  		ndev->peer_sta &= ~AMD_PEER_RESET_EVENT;
> > > -	else if (ndev->peer_sta & AMD_PEER_D0_EVENT)
> > > +	else if (ndev->peer_sta & (AMD_PEER_D0_EVENT | AMD_LINK_DOWN_EVENT))
> > >  		ndev->peer_sta = 0;
> > >
> > >  	return 0;
> > > @@ -480,6 +485,8 @@ static void amd_handle_event(struct amd_ntb_dev *ndev, int vec)
> > >  		break;
> > >  	case AMD_PEER_D3_EVENT:
> > >  	case AMD_PEER_PMETO_EVENT:
> > > +	case AMD_LINK_UP_EVENT:
> > > +	case AMD_LINK_DOWN_EVENT:
> > >  		amd_ack_smu(ndev, status);
> > >
> > >  		/* link down */
> > > diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.h b/drivers/ntb/hw/amd/ntb_hw_amd.h
> > > index 2eac3cd..13d73ed 100644
> > > --- a/drivers/ntb/hw/amd/ntb_hw_amd.h
> > > +++ b/drivers/ntb/hw/amd/ntb_hw_amd.h
> > > @@ -148,9 +148,12 @@ enum {
> > >  	AMD_PEER_D3_EVENT	= BIT(2),
> > >  	AMD_PEER_PMETO_EVENT	= BIT(3),
> > >  	AMD_PEER_D0_EVENT	= BIT(4),
> > > +	AMD_LINK_UP_EVENT	= BIT(5),
> > > +	AMD_LINK_DOWN_EVENT	= BIT(6),
> > >  	AMD_EVENT_INTMASK	= (AMD_PEER_FLUSH_EVENT |
> > >  				AMD_PEER_RESET_EVENT | AMD_PEER_D3_EVENT |
> > > -				AMD_PEER_PMETO_EVENT | AMD_PEER_D0_EVENT),
> > > +				AMD_PEER_PMETO_EVENT | AMD_PEER_D0_EVENT |
> > > +				AMD_LINK_UP_EVENT | AMD_LINK_DOWN_EVENT),
> > >
> > >  	AMD_PMESTAT_OFFSET	= 0x480,
> > >  	AMD_PMSGTRIG_OFFSET	= 0x490,
> > >
> 
