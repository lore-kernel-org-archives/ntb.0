Return-Path: <Allen.Hubbe@dell.com>
Received: from esa7.dell-outbound.iphmx.com (esa7.dell-outbound.iphmx.com. [68.232.153.96])
        by gmr-mx.google.com with ESMTPS id x138si1164405ywx.6.2016.12.07.14.56.22
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Dec 2016 14:56:22 -0800 (PST)
From: "Allen Hubbe" <Allen.Hubbe@dell.com>
References: <003d01d24dc1$f5ba4d60$e12ee820$@dell.com>
In-Reply-To: <003d01d24dc1$f5ba4d60$e12ee820$@dell.com>
Subject: RE: [PATCH 02/22] NTB: Add peer indexed ports NTB API
Date: Wed, 7 Dec 2016 17:56:02 -0500
Message-ID: <003f01d250dd$16de5630$449b0290$@dell.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
To: 'Allen Hubbe' <Allen.Hubbe@dell.com>, 'Serge Semin' <fancer.lancer@gmail.com>, jdmason@kudzu.us, dave.jiang@intel.com, Xiangliang.Yu@amd.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

From: Allen Hubbe
> From: Serge Semin
> > Add new port-index NTB API. Additionally lets get rid of Primary and
> > Secondary topologies, since port-number can be effectively used instead.
> 
> Split into two patches please.
> 
> I see no harm to the TOPO changes, though I wonder if they are necessary.
> 

I am leaning more toward recommending that the topo api be left alone.

The topo changes to the ntb api complicate the Intel driver:
 - The changes add second branches where there had been just one before (need to check topo AND port now).
 - The changes also cause some complicated merge conflicts with https://github.com/davejiang/linux.git ntb.

See RE: [PATCH 10/22] NTB Intel: Add port-related NTB API callback methods

If we leave the ntb topo api as it was, then on multiport devices, if the local port is not the primary port, let it be one of potentially many secondary ports.  Or, if there is no distinction between primary/secondary on some hardware, let them all be primary.

This topo api doesn't have much value for existing drivers (that I know of), except for informative purposes.  So, my preference for changing it would be, only if necessary, and to minimize changes otherwise.

Allen

