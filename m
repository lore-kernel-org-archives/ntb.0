Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACF519A296
	for <ntb@lists.linux.dev>; Fri, 14 Jun 2024 12:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718369880; cv=none; b=TTdigJInpaEgwthvdMSFLv6tlwks4BFLM9nAuHDoumPEQC8KJp33lMkjdLBtmGJIgg1jUMq6Gy24OVKsM2Fq1zD+EBe3K1q3ferzQC/bJuuVK+jsudVHvtMKiDuY73oZvvmx98udrjGNS84noxFdIDgBDo28ldYSOmYCFeRS5nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718369880; c=relaxed/simple;
	bh=HCRovoAa1zGmgG0Pz8GJKQKP/C/f+F6NWJoVTm3RPws=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sV1uDqu7bjfsu6KT7VqAWCPPZHj2do4+QjmXxEOYvouVD40oRyGaLYN+f2wkVC50T399evnm/t09NtVhk1BNekfUJxuFiyGmIEKGH4ozBWjVr+abHh1DmZr1EqxzdMY1zgYiShDY4J9LW05qJqgA9gf5wqv6QWIRUpW8bumB7Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m3wNiDHn; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m3wNiDHn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718369878; x=1749905878;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=HCRovoAa1zGmgG0Pz8GJKQKP/C/f+F6NWJoVTm3RPws=;
  b=m3wNiDHnFbzkBn9QSdiwK3s4gouMFcaGrQcdl4ICjta5YAbjg1Ddx2Qr
   /METDPss+PZQ7RxlnptGBRAVM6G8VF/3VvnQi961zlHRS7sxxM2peeOLK
   E3HvJv+9+AXYYGKMP7aTIe0X3OQyKWRuiYiAUsKyp8SfuFpBVidYG91qw
   cr/OLrWyv0CjK20h7iC++biqNZYGT9oDpJv5txjHKDRqvUIzenGLtdM+7
   aIExSTvfZNm2ZawS1F/QlHcLQta4wmVBx41MS6uoBA+qLEb6jA2en4DOE
   thjcQ4ocLS/os3TioWmEkjU+ZYKHJHG2nrr4m1YZmFA9nJnCVsJDUtxg1
   Q==;
X-CSE-ConnectionGUID: v8s8ebcnTuy08vjqryYnFQ==
X-CSE-MsgGUID: x7EvMG/OTvSTamNzI4e7GA==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="26649477"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="26649477"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 05:57:57 -0700
X-CSE-ConnectionGUID: ND41G8VNRSCad+rFwIws0w==
X-CSE-MsgGUID: +4i6ZaJFStGPQ2N0NBMx5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="40456270"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.222])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 05:57:53 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 14 Jun 2024 15:57:49 +0300 (EEST)
To: Dan Carpenter <dan.carpenter@linaro.org>
cc: Frank Li <Frank.Li@nxp.com>, Jon Mason <jdmason@kudzu.us>, 
    Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, 
    Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    Kishon Vijay Abraham I <kishon@kernel.org>, 
    Bjorn Helgaas <bhelgaas@google.com>, ntb@lists.linux.dev, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: endpoint: Clean up error handling in
 vpci_scan_bus()
In-Reply-To: <68e0f6a4-fd57-45d0-945b-0876f2c8cb86@moroto.mountain>
Message-ID: <d8f510d1-db05-66a8-b379-464fdc817143@linux.intel.com>
References: <68e0f6a4-fd57-45d0-945b-0876f2c8cb86@moroto.mountain>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1335945687-1718369869=:1013"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1335945687-1718369869=:1013
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 10 Jun 2024, Dan Carpenter wrote:

> Smatch complains about inconsistent NULL checking in vpci_scan_bus():
>=20
>     drivers/pci/endpoint/functions/pci-epf-vntb.c:1024 vpci_scan_bus()
>     error: we previously assumed 'vpci_bus' could be null (see line 1021)
>=20
> Instead of printing an error message and then crashing we should return
> an error code and clean up.  Also the NULL check is reversed so it
> prints an error for success instead of failure.
>=20
> Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and =
EP")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/=
endpoint/functions/pci-epf-vntb.c
> index 8e779eecd62d..7f05a44e9a9f 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -1018,8 +1018,10 @@ static int vpci_scan_bus(void *sysdata)
>  =09struct epf_ntb *ndev =3D sysdata;
> =20
>  =09vpci_bus =3D pci_scan_bus(ndev->vbus_number, &vpci_ops, sysdata);
> -=09if (vpci_bus)
> -=09=09pr_err("create pci bus\n");
> +=09if (!vpci_bus) {
> +=09=09pr_err("create pci bus failed\n");
> +=09=09return -EINVAL;
> +=09}
> =20
>  =09pci_bus_add_devices(vpci_bus);
> =20
> @@ -1338,10 +1340,14 @@ static int epf_ntb_bind(struct pci_epf *epf)
>  =09=09goto err_bar_alloc;
>  =09}
> =20
> -=09vpci_scan_bus(ntb);
> +=09ret =3D vpci_scan_bus(ntb);
> +=09if (ret)
> +=09=09goto err_unregister;
> =20
>  =09return 0;
> =20
> +err_unregister:
> +=09pci_unregister_driver(&vntb_pci_driver);
>  err_bar_alloc:
>  =09epf_ntb_config_spad_bar_free(ntb);

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>


--=20
 i.

--8323328-1335945687-1718369869=:1013--
