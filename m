Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id h192si72773ywa.0.2019.03.25.08.49.35
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 08:49:36 -0700 (PDT)
References: <20190325091726.GD16023@kadam>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <e2bc8cf0-8e3e-9335-e21b-4a9697e9c0ef@deltatee.com>
Date: Mon, 25 Mar 2019 09:49:31 -0600
MIME-Version: 1.0
In-Reply-To: <20190325091726.GD16023@kadam>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ntb_hw_switchtec: potential shift wrapping bug in
 switchtec_ntb_init_sndev()
To: Dan Carpenter <dan.carpenter@oracle.com>, Kurt Schwemmer <kurt.schwemmer@microsemi.com>, Kelvin Cao <kelvin.cao@microsemi.com>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-pci@vger.kernel.org, linux-ntb@googlegroups.com, kernel-janitors@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

Thanks!

On 2019-03-25 3:17 a.m., Dan Carpenter wrote:
> This code triggers a Smatch warning:
> 
>     drivers/ntb/hw/mscc/ntb_hw_switchtec.c:884 switchtec_ntb_init_sndev()
>     warn: should '(1 << sndev->peer_partition)' be a 64 bit type?
> 
> The "part_map" and "tpart_vec" variables are u64 type so this seems like
> a valid warning.
> 
> Fixes: 3df54c870f52 ("ntb_hw_switchtec: Allow using Switchtec NTB in multi-partition setups")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

