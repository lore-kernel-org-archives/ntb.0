Return-Path: <jdmason@kudzu.us>
Received: from mail-yk0-x236.google.com (mail-yk0-x236.google.com. [2607:f8b0:4002:c07::236])
        by gmr-mx.google.com with ESMTPS id g66si414818ywf.4.2016.01.21.16.55.01
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jan 2016 16:55:01 -0800 (PST)
Received: by mail-yk0-x236.google.com with SMTP id a85so69539761ykb.1
        for <linux-ntb@googlegroups.com>; Thu, 21 Jan 2016 16:55:01 -0800 (PST)
Return-Path: <jdmason@kudzu.us>
Date: Thu, 21 Jan 2016 19:53:44 -0500
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH] NTB: Fix macro parameter conflict with field name
Message-ID: <20160122005343.GB18163@kudzu.us>
References: <92f2c0f9f753ddb55242f01dd3d351191d2128c8.1453398752.git.Allen.Hubbe@emc.com>
 <1453417083.3824.28.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1453417083.3824.28.camel@intel.com>
To: "Jiang, Dave" <dave.jiang@intel.com>
Cc: "Allen.Hubbe@emc.com" <Allen.Hubbe@emc.com>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

On Thu, Jan 21, 2016 at 10:58:07PM +0000, Jiang, Dave wrote:
> On Thu, 2016-01-21 at 12:53 -0500, Allen Hubbe wrote:
> > If the parameter given to the macro is replaced throughout the macro
> > as
> > it is evaluated.=EF=BF=BD=EF=BF=BDThe intent is that the macro paramete=
r should
> > replace
> > the only the first parameter to container_of().=EF=BF=BD=EF=BF=BDHoweve=
r, the way the
> > macro was written, it would also inadvertantly replace a structure
> > field
> > name.=EF=BF=BD=EF=BF=BDIf a parameter of any other name is given to the=
 macro, it
> > will
> > fail to compile, if the structure does not contain a field of the
> > same
> > name.=EF=BF=BD=EF=BF=BDAt worst, it will compile, and hide improper acc=
ess of an
> > unintended field in the structure.
> >=20
> > Change the macro parameter name, so it does not conflict with the
> > structure field name.
> >=20
> > Signed-off-by: Allen Hubbe <Allen.Hubbe@emc.com>
> Acked-by: Dave Jiang <dave.jiang@intel.com>

Included in the NTB git tree.

Thanks,
Jon

>=20
> > ---
> > =EF=BF=BDdrivers/ntb/hw/intel/ntb_hw_intel.h | 5 +++--
> > =EF=BF=BD1 file changed, 3 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.h
> > b/drivers/ntb/hw/intel/ntb_hw_intel.h
> > index 2eb4addd10d0..43b3fe0d4aed 100644
> > --- a/drivers/ntb/hw/intel/ntb_hw_intel.h
> > +++ b/drivers/ntb/hw/intel/ntb_hw_intel.h
> > @@ -334,7 +334,8 @@ struct intel_ntb_dev {
> > =EF=BF=BD#define ndev_pdev(ndev) ((ndev)->ntb.pdev)
> > =EF=BF=BD#define ndev_name(ndev) pci_name(ndev_pdev(ndev))
> > =EF=BF=BD#define ndev_dev(ndev) (&ndev_pdev(ndev)->dev)
> > -#define ntb_ndev(ntb) container_of(ntb, struct intel_ntb_dev, ntb)
> > -#define hb_ndev(work) container_of(work, struct intel_ntb_dev,
> > hb_timer.work)
> > +#define ntb_ndev(__ntb) container_of(__ntb, struct intel_ntb_dev,
> > ntb)
> > +#define hb_ndev(__work) container_of(__work, struct intel_ntb_dev, \
> > +				=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDhb_timer.work)
> > =EF=BF=BD
> > =EF=BF=BD#endif
> > --=EF=BF=BD
> > 2.7.0
> >=20
