Return-Path: <dave.jiang@intel.com>
Received: from mga04.intel.com (mga04.intel.com. [192.55.52.120])
        by gmr-mx.google.com with ESMTPS id d62si107372pgc.5.2019.03.20.08.20.45
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 08:20:45 -0700 (PDT)
From: "Jiang, Dave" <dave.jiang@intel.com>
Subject: RE: [PATCH -next] ntb: intel: Make intel_ntb3_peer_db_addr static
Date: Wed, 20 Mar 2019 15:20:43 +0000
Message-ID: <112A412BB11A1242B37129D931BCE5348445D71E@fmsmsx117.amr.corp.intel.com>
References: <20190320140812.5952-1-yuehaibing@huawei.com>
In-Reply-To: <20190320140812.5952-1-yuehaibing@huawei.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Return-Path: dave.jiang@intel.com
To: Yue Haibing <yuehaibing@huawei.com>, "jdmason@kudzu.us" <jdmason@kudzu.us>, "allenbh@gmail.com" <allenbh@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>



> -----Original Message-----
> From: Yue Haibing [mailto:yuehaibing@huawei.com]
> Sent: Wednesday, March 20, 2019 7:08 AM
> To: Jiang, Dave <dave.jiang@intel.com>; jdmason@kudzu.us;
> allenbh@gmail.com
> Cc: linux-kernel@vger.kernel.org; linux-ntb@googlegroups.com; YueHaibing
> <yuehaibing@huawei.com>
> Subject: [PATCH -next] ntb: intel: Make intel_ntb3_peer_db_addr static
>=20
> From: YueHaibing <yuehaibing@huawei.com>
>=20
> Fix sparse warning:
>=20
> drivers/ntb/hw/intel/ntb_hw_gen3.c:535:5: warning:
>  symbol 'intel_ntb3_peer_db_addr' was not declared. Should it be static?

For now yes. Thanks!

Acked-by: Dave Jiang <dave.jiang@intel.com>

>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/ntb/hw/intel/ntb_hw_gen3.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/ntb/hw/intel/ntb_hw_gen3.c
> b/drivers/ntb/hw/intel/ntb_hw_gen3.c
> index f475b56..c339716 100644
> --- a/drivers/ntb/hw/intel/ntb_hw_gen3.c
> +++ b/drivers/ntb/hw/intel/ntb_hw_gen3.c
> @@ -532,9 +532,9 @@ static int intel_ntb3_mw_set_trans(struct ntb_dev
> *ntb, int pidx, int idx,
>  	return 0;
>  }
>=20
> -int intel_ntb3_peer_db_addr(struct ntb_dev *ntb, phys_addr_t *db_addr,
> -				resource_size_t *db_size,
> -				u64 *db_data, int db_bit)
> +static int intel_ntb3_peer_db_addr(struct ntb_dev *ntb, phys_addr_t
> *db_addr,
> +				   resource_size_t *db_size,
> +				   u64 *db_data, int db_bit)
>  {
>  	phys_addr_t db_addr_base;
>  	struct intel_ntb_dev *ndev =3D ntb_ndev(ntb);
> --
> 2.7.0
>=20

