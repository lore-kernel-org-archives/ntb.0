Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwdur.emc.com (mailuogwdur.emc.com. [128.221.224.79])
        by gmr-mx.google.com with ESMTPS id s141si1554818wmd.1.2016.02.23.14.26.03
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Feb 2016 14:26:04 -0800 (PST)
From: "Allen Hubbe" <Allen.Hubbe@emc.com>
References: <20160223211111.196243.73270.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <20160223211111.196243.73270.stgit@djiang5-desk3.ch.intel.com>
Subject: RE: [PATCH] ntb: stop link work when we do not have memory
Date: Tue, 23 Feb 2016 17:25:47 -0500
Message-ID: <000001d16e89$257f9c30$707ed490$@emc.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-us
To: 'Dave Jiang' <dave.jiang@intel.com>, jdmason@kudzu.us
Cc: alex@pernixdata.com, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

> From: Dave Jiang <dave.jiang@intel.com>
>=20
> Instead of keep trying to go through the init routine when we aren't
> able
> to allocate memory, we should just stop and go down.
>=20
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Tested-by: Alex Depoutovitch <alex@pernixdata.com>
> ---
>  drivers/ntb/ntb_transport.c |   10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 06d4e58..50ecbd6 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -829,7 +829,7 @@ static void ntb_transport_link_work(struct
> work_struct *work)
>  	struct pci_dev *pdev =3D ndev->pdev;
>  	resource_size_t size;
>  	u32 val;
> -	int rc, i, spad;
> +	int rc =3D 0, i, spad;
>=20
>  	/* send the local info, in the opposite order of the way we read it
> */
>  	for (i =3D 0; i < nt->mw_count; i++) {
> @@ -899,6 +899,14 @@ static void ntb_transport_link_work(struct
> work_struct *work)
>  out1:
>  	for (i =3D 0; i < nt->mw_count; i++)
>  		ntb_free_mw(nt, i);
> +
> +	/* if there's an actual failure, we should just bail */
> +	if (rc < 0) {
> +		nt->link_is_up =3D false;

Why not ntb_link_disable()?  As long as we leave the link up, the peer =
will keep spinning trying to connect.  Should we try again if the peer =
resets the link, or never again?

> +		ntb_transport_link_cleanup(nt);
> +		return;
> +	}
> +
>  out:
>  	if (ntb_link_is_up(ndev, NULL, NULL) =3D=3D 1)
>  		schedule_delayed_work(&nt->link_work,


