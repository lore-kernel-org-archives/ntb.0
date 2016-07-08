Return-Path: <dave.jiang@intel.com>
Received: from mga01.intel.com (mga01.intel.com. [192.55.52.88])
        by gmr-mx.google.com with ESMTP id i135si497525pfe.0.2016.07.08.09.00.30
        for <linux-ntb@googlegroups.com>;
        Fri, 08 Jul 2016 09:00:30 -0700 (PDT)
From: "Jiang, Dave" <dave.jiang@intel.com>
Subject: RE: [PATCH v3 1/5] dmaengine: Adding error handling flag
Date: Fri, 8 Jul 2016 16:00:26 +0000
Message-ID: <112A412BB11A1242B37129D931BCE53472670664@fmsmsx116.amr.corp.intel.com>
References: <146715558744.208762.15608813894802261982.stgit@djiang5-desk3.ch.intel.com>
 <146715571138.208762.7964180099092112652.stgit@djiang5-desk3.ch.intel.com>
 <20160708052922.GN12591@localhost>
In-Reply-To: <20160708052922.GN12591@localhost>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Return-Path: dave.jiang@intel.com
To: "Koul, Vinod" <vinod.koul@intel.com>
Cc: "allen.hubbe@emc.com" <allen.hubbe@emc.com>, "jdmason@kudzu.us" <jdmason@kudzu.us>, "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>, "Williams, Dan J" <dan.j.williams@intel.com>
List-ID: <linux-ntb.googlegroups.com>



> -----Original Message-----
> From: Koul, Vinod
> Sent: Thursday, July 07, 2016 10:29 PM
> To: Jiang, Dave <dave.jiang@intel.com>
> Cc: allen.hubbe@emc.com; jdmason@kudzu.us; dmaengine@vger.kernel.org; lin=
ux-ntb@googlegroups.com; Williams, Dan J
> <dan.j.williams@intel.com>
> Subject: Re: [PATCH v3 1/5] dmaengine: Adding error handling flag
>=20
> On Tue, Jun 28, 2016 at 04:15:11PM -0700, Dave Jiang wrote:
> > Adding error flag for the call back descriptor to notify upper layer th=
at
> > an error has occurred with this particular DMA op.
> >
> > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> > ---
> >  0 files changed
> >
> > diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> > index 0174337..6524881 100644
> > --- a/include/linux/dmaengine.h
> > +++ b/include/linux/dmaengine.h
> > @@ -453,6 +453,20 @@ struct dmaengine_unmap_data {
> >  };
> >
> >  /**
> > + * enum err_result_flags - result of DMA operations
> > + * @ERR_DMA_NONE - no errors
> > + * @ERR_DMA_READ - DMA read error
> > + * @ERR_DMA_WRITE - DMA write error
> > + * @ERR_DMA_ABORT - Operation aborted
> > + */
> > +enum err_result_flags {
> > +	ERR_DMA_NONE =3D 0,
> > +	ERR_DMA_READ,
> > +	ERR_DMA_WRITE,
> > +	ERR_DMA_ABORT,
> > +};
> > +
> > +/**
> >   * struct dma_async_tx_descriptor - async transaction descriptor
> >   * ---dma generic offload fields---
> >   * @cookie: tracking cookie for this transaction, set to -EBUSY if
> > @@ -480,6 +494,7 @@ struct dma_async_tx_descriptor {
> >  	dma_async_tx_callback callback;
> >  	void *callback_param;
> >  	struct dmaengine_unmap_data *unmap;
> > +	enum err_result_flags result;
> >  #ifdef CONFIG_ASYNC_TX_ENABLE_CHANNEL_SWITCH
> >  	struct dma_async_tx_descriptor *next;
> >  	struct dma_async_tx_descriptor *parent;
>=20
> Okay this needs more thoughts IMHO. The only issue with this approach is
> that it violates one of the base fundamentals of dmaengine descriptor
> submission.
>=20
> Client do not touch or use a descriptor after it has been submitted. Look=
ing
> at the results inside descriptor is not right.
>=20
> Perhaps we can add a query of results in the cookie or add this in
> tx_status, am not sure.
>=20
> FWIW, we definitely need some kind of error reporting

Ok. Let me think about this some more on how to do this with what you sugge=
sted. With XOR/PQ validate, we provide a checksum_result field to check for=
 the result. We could in general have all the DMA submission calls provide =
something similar for error reporting.

>=20
> Thanks
> --
> ~Vinod
