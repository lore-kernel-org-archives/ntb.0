Return-Path: <Allen.Hubbe@dell.com>
Received: from esa4.dell-outbound.iphmx.com (esa4.dell-outbound.iphmx.com. [68.232.149.214])
        by gmr-mx.google.com with ESMTPS id x138si1975245ywx.6.2016.11.16.13.35.20
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Nov 2016 13:35:21 -0800 (PST)
From: "Allen Hubbe" <Allen.Hubbe@dell.com>
References: <147933021880.124938.13946656717891227718.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <147933021880.124938.13946656717891227718.stgit@djiang5-desk3.ch.intel.com>
Subject: RE: [PATCH v3] ntb: Adding Skylake Xeon NTB support
Date: Wed, 16 Nov 2016 16:34:38 -0500
Message-ID: <000101d24051$3c287a20$b4796e60$@emc.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
To: 'Dave Jiang' <dave.jiang@intel.com>, jdmason@kudzu.us
Cc: linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

From: Dave Jiang
> Sent: Wednesday, November 16, 2016 4:04 PM
> To: Hubbe, Allen; jdmason@kudzu.us
> Cc: linux-ntb@googlegroups.com
> Subject: [PATCH v3] ntb: Adding Skylake Xeon NTB support
> 
> The Skylake Xeon NTB hardware has made some changes to the register name,
> offset, and the way doorbells work. Adding driver support for the new
> hardware.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Acked-by: Allen Hubbe <Allen.Hubbe@dell.com>

> ---
>  drivers/ntb/hw/intel/ntb_hw_intel.c |  660 +++++++++++++++++++++++++++++++++++
>  drivers/ntb/hw/intel/ntb_hw_intel.h |   48 +++
>  2 files changed, 703 insertions(+), 5 deletions(-)
> 

