Return-Path: <Allen.Hubbe@dell.com>
Received: from esa2.dell-outbound.iphmx.com (esa2.dell-outbound.iphmx.com. [68.232.149.220])
        by gmr-mx.google.com with ESMTPS id u66si677499ywg.1.2016.12.06.06.23.20
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Dec 2016 06:23:20 -0800 (PST)
From: "Allen Hubbe" <Allen.Hubbe@dell.com>
References: <9fd3e0a0-8385-dc61-0671-f1e95feae0f2@amd.com> <eb37c6ff-be24-63f8-1f28-b02a7a8209eb@amd.com>
In-Reply-To: <eb37c6ff-be24-63f8-1f28-b02a7a8209eb@amd.com>
Subject: RE: [PATCH v3] ntb_transport: Limit memory windows based on available, scratchpads
Date: Tue, 6 Dec 2016 09:23:00 -0500
Message-ID: <000001d24fcc$40358e20$c0a0aa60$@dell.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
To: 'Shyam Sundar S K' <ssundark@amd.com>, 'Jon Mason' <jdmason@kudzu.us>, linux-ntb@googlegroups.com
Cc: 'Dave Jiang' <dave.jiang@intel.com>, "'Yu, Xiangliang'" <Xiangliang.Yu@amd.com>, "'Sen, Pankaj'" <Pankaj.Sen@amd.com>, "'Shah, Nehal-bakulchandra'" <Nehal-bakulchandra.Shah@amd.com>, "'Agrawal, Nitesh-kumar'" <Nitesh-kumar.Agrawal@amd.com>, "'Subramaniyan, Ramkumar'" <ramkumar.ks@amd.com>, "'Su, Richard (Bin)'" <Richard1.Su@amd.com>
List-ID: <linux-ntb.googlegroups.com>

> Any feedback on the below patch ?
> 

Except for the subject stating PATCH v3, this looks like exactly the same patch as v2.  I will repeat my comment.

From: Shyam Sundar S K
> -	for (i = 0; i < MAX_SPAD; i++)
> +	for (i = 0; i < ntb_spad_count(nt->ndev); i++)

count = ntb_spad_count(nt->ndev);
for (i = 0; i < count; i++) ...

The rest looks good.  Thanks.

> On 12/2/2016 11:16 PM, Shyam Sundar S K wrote:
> > When the underlying NTB H/W driver advertises more memory windows
> > than the number of scratchpads available to setup MW's, it is likely
> > that we may end up filling the remaining memory windows with garbage.
> > So to avoid that, lets limit the memory windows that transport driver
> > can setup based on the available scratchpads.
> >
> > Reviewed-by: Shah, Nehal-bakulchandra <Nehal-bakulchandra.Shah@amd.com>
> > Reviewed-by: Agrawal, Nitesh-kumar <Nitesh-kumar.Agrawal@amd.com>
> > Signed-off-by: S-k, Shyam-sundar <Shyam-sundar.S-k@amd.com>
> > ---
> >  drivers/ntb/ntb_transport.c | 24 +++++++++++++-----------
> >  1 file changed, 13 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> > index 4eb8adb..e02ad4e 100644
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
> > @@ -831,7 +829,7 @@ static void ntb_transport_link_cleanup(struct ntb_transport_ctx *nt)
> >  	 * goes down, blast them now to give them a sane value the next
> >  	 * time they are accessed
> >  	 */
> > -	for (i = 0; i < MAX_SPAD; i++)
> > +	for (i = 0; i < ntb_spad_count(nt->ndev); i++)
> >  		ntb_spad_write(nt->ndev, i, 0);
> >  }
> >
> > @@ -1064,17 +1062,12 @@ static int ntb_transport_probe(struct ntb_client *self, struct
> ntb_dev *ndev)
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
> > @@ -1090,8 +1083,17 @@ static int ntb_transport_probe(struct ntb_client *self, struct
> ntb_dev *ndev)
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
> >

