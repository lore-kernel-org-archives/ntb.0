Return-Path: <jdmason@kudzu.us>
Received: from mail-yw0-x242.google.com (mail-yw0-x242.google.com. [2607:f8b0:4002:c05::242])
        by gmr-mx.google.com with ESMTPS id u66si2073443ywg.1.2016.12.21.08.56.09
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Dec 2016 08:56:09 -0800 (PST)
Received: by mail-yw0-x242.google.com with SMTP id s68so13198604ywg.0
        for <linux-ntb@googlegroups.com>; Wed, 21 Dec 2016 08:56:09 -0800 (PST)
Return-Path: <jdmason@kudzu.us>
Date: Wed, 21 Dec 2016 11:56:06 -0500
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH v5] ntb_transport: Limit memory windows based on
 available, scratchpads
Message-ID: <20161221165606.GF32599@kudzu.us>
References: <fb25c1dd-7532-8f09-45d6-d25c155f3a5d@amd.com>
 <000201d250af$a961bf20$fc253d60$@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000201d250af$a961bf20$fc253d60$@dell.com>
To: Allen Hubbe <Allen.Hubbe@dell.com>
Cc: 'Shyam Sundar S K' <ssundark@amd.com>, 'Dave Jiang' <dave.jiang@intel.com>, linux-ntb@googlegroups.com, "'Shah, Nehal-bakulchandra'" <Nehal-bakulchandra.Shah@amd.com>, "'Sen, Pankaj'" <Pankaj.Sen@amd.com>, "'Agrawal, Nitesh-kumar'" <Nitesh-kumar.Agrawal@amd.com>, "'Subramaniyan, Ramkumar'" <ramkumar.ks@amd.com>, "'Su, Richard (Bin)'" <Richard1.Su@amd.com>
List-ID: <linux-ntb.googlegroups.com>

On Wed, Dec 07, 2016 at 12:30:52PM -0500, Allen Hubbe wrote:
> From: Shyam Sundar S K
> > When the underlying NTB H/W driver advertises more memory windows
> > than the number of scratchpads available to setup MW's, it is likely
> > that we may end up filling the remaining memory windows with garbage.
> > So to avoid that, lets limit the memory windows that transport driver
> > can setup based on the available scratchpads.
> > 
> > Reviewed-by: Shah, Nehal-bakulchandra <Nehal-bakulchandra.Shah@amd.com>
> > Reviewed-by: Agrawal, Nitesh-kumar <Nitesh-kumar.Agrawal@amd.com>
> > Signed-off-by: S-k, Shyam-sundar <Shyam-sundar.S-k@amd.com>
> 
> Acked-by: Allen Hubbe <Allen.Hubbe@dell.com>

Applied to my ntb branch

Thanks,
Jon

> 
> > ---
> >  drivers/ntb/ntb_transport.c | 27 +++++++++++++++------------
> >  1 file changed, 15 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> > index 4eb8adb..6adbfa3 100644
> > --- a/drivers/ntb/ntb_transport.c
> > +++ b/drivers/ntb/ntb_transport.c
> > @@ -66,6 +66,7 @@
> >  #define NTB_TRANSPORT_VER	"4"
> >  #define NTB_TRANSPORT_NAME	"ntb_transport"
> >  #define NTB_TRANSPORT_DESC	"Software Queue-Pair Transport over NTB"
> > +#define NTB_TRANSPORT_MIN_SPADS (MW0_SZ_HIGH + 2)
> > 
> >  MODULE_DESCRIPTION(NTB_TRANSPORT_DESC);
> >  MODULE_VERSION(NTB_TRANSPORT_VER);
> > @@ -242,9 +243,6 @@ enum {
> >  	NUM_MWS,
> >  	MW0_SZ_HIGH,
> >  	MW0_SZ_LOW,
> > -	MW1_SZ_HIGH,
> > -	MW1_SZ_LOW,
> > -	MAX_SPAD,
> >  };
> > 
> >  #define dev_client_dev(__dev) \
> > @@ -811,7 +809,7 @@ static void ntb_transport_link_cleanup(struct ntb_transport_ctx *nt)
> >  {
> >  	struct ntb_transport_qp *qp;
> >  	u64 qp_bitmap_alloc;
> > -	int i;
> > +	unsigned int i, count;
> > 
> >  	qp_bitmap_alloc = nt->qp_bitmap & ~nt->qp_bitmap_free;
> > 
> > @@ -831,7 +829,8 @@ static void ntb_transport_link_cleanup(struct ntb_transport_ctx *nt)
> >  	 * goes down, blast them now to give them a sane value the next
> >  	 * time they are accessed
> >  	 */
> > -	for (i = 0; i < MAX_SPAD; i++)
> > +	count = ntb_spad_count(nt->ndev);
> > +	for (i = 0; i < count; i++)
> >  		ntb_spad_write(nt->ndev, i, 0);
> >  }
> > 
> > @@ -1064,17 +1063,12 @@ static int ntb_transport_probe(struct ntb_client *self, struct
> > ntb_dev *ndev)
> >  {
> >  	struct ntb_transport_ctx *nt;
> >  	struct ntb_transport_mw *mw;
> > -	unsigned int mw_count, qp_count;
> > +	unsigned int mw_count, qp_count, spad_count, max_mw_count_for_spads;
> >  	u64 qp_bitmap;
> >  	int node;
> >  	int rc, i;
> > 
> >  	mw_count = ntb_mw_count(ndev);
> > -	if (ntb_spad_count(ndev) < (NUM_MWS + 1 + mw_count * 2)) {
> > -		dev_err(&ndev->dev, "Not enough scratch pad registers for %s",
> > -			NTB_TRANSPORT_NAME);
> > -		return -EIO;
> > -	}
> > 
> >  	if (ntb_db_is_unsafe(ndev))
> >  		dev_dbg(&ndev->dev,
> > @@ -1090,8 +1084,17 @@ static int ntb_transport_probe(struct ntb_client *self, struct
> > ntb_dev *ndev)
> >  		return -ENOMEM;
> > 
> >  	nt->ndev = ndev;
> > +	spad_count = ntb_spad_count(ndev);
> > +
> > +	/* Limit the MW's based on the availability of scratchpads */
> > +
> > +	if (spad_count < NTB_TRANSPORT_MIN_SPADS) {
> > +		nt->mw_count = 0;
> > +		goto err;
> > +	}
> > 
> > -	nt->mw_count = mw_count;
> > +	max_mw_count_for_spads = (spad_count - MW0_SZ_HIGH) / 2;
> > +	nt->mw_count = min(mw_count, max_mw_count_for_spads);
> > 
> >  	nt->mw_vec = kzalloc_node(mw_count * sizeof(*nt->mw_vec),
> >  				  GFP_KERNEL, node);
> > --
> > 2.7.4
> 
