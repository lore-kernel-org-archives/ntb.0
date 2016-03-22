Return-Path: <Xiangliang.Yu@amd.com>
Received: from na01-by2-obe.outbound.protection.outlook.com (mail-by2on0070.outbound.protection.outlook.com. [207.46.100.70])
        by gmr-mx.google.com with ESMTPS id 138si289797pfa.1.2016.03.21.23.30.38
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Mar 2016 23:30:38 -0700 (PDT)
From: "Yu, Xiangliang" <Xiangliang.Yu@amd.com>
Subject: RE: [PATCH 2/2] NTB: Remove _addr functions from ntb_hw_amd
Date: Tue, 22 Mar 2016 06:30:36 +0000
Message-ID: <BLUPR12MB04207A01BAAA208E33D1E745EB800@BLUPR12MB0420.namprd12.prod.outlook.com>
References: <17b414e0af3e8caf31b3b3aa5dddb842ef397c1a.1458550127.git.Allen.Hubbe@emc.com>
 <6a2984f3c623f41aae210f08f23813b680a19d56.1458550127.git.Allen.Hubbe@emc.com>
In-Reply-To: <6a2984f3c623f41aae210f08f23813b680a19d56.1458550127.git.Allen.Hubbe@emc.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
To: Allen Hubbe <Allen.Hubbe@emc.com>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>
List-ID: <linux-ntb.googlegroups.com>

> -----Original Message-----
> From: Allen Hubbe [mailto:Allen.Hubbe@emc.com]
> Sent: Monday, March 21, 2016 4:53 PM
> To: linux-ntb@googlegroups.com
> Cc: Jon Mason; Dave Jiang; Allen Hubbe; Yu, Xiangliang
> Subject: [PATCH 2/2] NTB: Remove _addr functions from ntb_hw_amd
>=20
> Kernel zero day testing warned about address space confusion.  A virtual
> iomem address was used where a physical address is expected.  The
> offending functions implement an optional part of the api, so they are
> removed.  They can be added later, after testing.

Ntb_dev_ops_is_valid will check the related implement and AMD ntb driver ca=
n't
Register ntb device if you remove the two functions.=20
I think this addr should be is iomem address not physical address as addres=
s space
Is IO space.  Do you map IO space again after getting the physical address?
Please help clarify the usage scenarios.


> Fixes: a1b3695820aa490e58915d720a1438069813008b
>=20
> Signed-off-by: Allen Hubbe <Allen.Hubbe@emc.com>
>=20
> Cc: Xiangliang Yu <Xiangliang.Yu@amd.com>
> ---
>  drivers/ntb/hw/amd/ntb_hw_amd.c | 30 ------------------------------
>  1 file changed, 30 deletions(-)
>=20
> diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c
> b/drivers/ntb/hw/amd/ntb_hw_amd.c index 588803ad6847..6ccba0d862df
> 100644
> --- a/drivers/ntb/hw/amd/ntb_hw_amd.c
> +++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
> @@ -357,20 +357,6 @@ static int amd_ntb_db_clear_mask(struct ntb_dev
> *ntb, u64 db_bits)
>  	return 0;
>  }
>=20
> -static int amd_ntb_peer_db_addr(struct ntb_dev *ntb,
> -				phys_addr_t *db_addr,
> -				resource_size_t *db_size)
> -{
> -	struct amd_ntb_dev *ndev =3D ntb_ndev(ntb);
> -
> -	if (db_addr)
> -		*db_addr =3D (phys_addr_t)(ndev->peer_mmio +
> AMD_DBREQ_OFFSET);
> -	if (db_size)
> -		*db_size =3D sizeof(u32);
> -
> -	return 0;
> -}
> -
>  static int amd_ntb_peer_db_set(struct ntb_dev *ntb, u64 db_bits)  {
>  	struct amd_ntb_dev *ndev =3D ntb_ndev(ntb); @@ -415,20 +401,6
> @@ static int amd_ntb_spad_write(struct ntb_dev *ntb,
>  	return 0;
>  }
>=20
> -static int amd_ntb_peer_spad_addr(struct ntb_dev *ntb, int idx,
> -				  phys_addr_t *spad_addr)
> -{
> -	struct amd_ntb_dev *ndev =3D ntb_ndev(ntb);
> -
> -	if (idx < 0 || idx >=3D ndev->spad_count)
> -		return -EINVAL;
> -
> -	if (spad_addr)
> -		*spad_addr =3D (phys_addr_t)(ndev->self_mmio +
> AMD_SPAD_OFFSET +
> -					   ndev->peer_spad + (idx << 2));
> -	return 0;
> -}
> -
>  static u32 amd_ntb_peer_spad_read(struct ntb_dev *ntb, int idx)  {
>  	struct amd_ntb_dev *ndev =3D ntb_ndev(ntb); @@ -472,12 +444,10
> @@ static const struct ntb_dev_ops amd_ntb_ops =3D {
>  	.db_clear		=3D amd_ntb_db_clear,
>  	.db_set_mask		=3D amd_ntb_db_set_mask,
>  	.db_clear_mask		=3D amd_ntb_db_clear_mask,
> -	.peer_db_addr		=3D amd_ntb_peer_db_addr,
>  	.peer_db_set		=3D amd_ntb_peer_db_set,
>  	.spad_count		=3D amd_ntb_spad_count,
>  	.spad_read		=3D amd_ntb_spad_read,
>  	.spad_write		=3D amd_ntb_spad_write,
> -	.peer_spad_addr		=3D amd_ntb_peer_spad_addr,
>  	.peer_spad_read		=3D amd_ntb_peer_spad_read,
>  	.peer_spad_write	=3D amd_ntb_peer_spad_write,
>  };
> --
> 2.7.0

