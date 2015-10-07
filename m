Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de. [212.227.17.24])
        by gmr-mx.google.com with ESMTPS id j7si65280igu.1.2015.10.07.01.00.07
        for <linux-ntb@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Oct 2015 01:00:07 -0700 (PDT)
From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] NTB: fix 32-bit compiler warning
Date: Wed, 07 Oct 2015 09:59:34 +0200
Message-ID: <10263287.Brd9HPYQJD@wuerfel>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-ID: <linux-ntb.googlegroups.com>

resource_size_t may be 32-bit wide on some architectures, which causes
this warning when building the NTB code:

drivers/ntb/ntb_transport.c: In function 'ntb_transport_link_work':
drivers/ntb/ntb_transport.c:828:46: warning: right shift count >= width of type [-Wshift-count-overflow]

The warning is harmless but can be avoided by using the upper_32_bits()
macro.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: e26a5843f7f5 ("NTB: Split ntb_hw_intel and ntb_transport drivers")
---
Found while building ARM allmodconfig

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 6e3ee907d186..700f3ae833c2 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -825,10 +825,10 @@ static void ntb_transport_link_work(struct work_struct *work)
 			size = max_mw_size;
 
 		spad = MW0_SZ_HIGH + (i * 2);
-		ntb_peer_spad_write(ndev, spad, (u32)(size >> 32));
+		ntb_peer_spad_write(ndev, spad, upper_32_bits(size));
 
 		spad = MW0_SZ_LOW + (i * 2);
-		ntb_peer_spad_write(ndev, spad, (u32)size);
+		ntb_peer_spad_write(ndev, spad, lower_32_bits(size));
 	}
 
 	ntb_peer_spad_write(ndev, NUM_MWS, nt->mw_count);

