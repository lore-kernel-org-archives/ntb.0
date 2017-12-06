Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de. [212.227.126.133])
        by gmr-mx.google.com with ESMTPS id j2si373106wrh.0.2017.12.06.06.19.37
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Dec 2017 06:19:37 -0800 (PST)
From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ntb_hw_switchtec: fix logic error
Date: Wed,  6 Dec 2017 15:19:03 +0100
Message-Id: <20171206141923.817850-1-arnd@arndb.de>
To: Kurt Schwemmer <kurt.schwemmer@microsemi.com>, Logan Gunthorpe <logang@deltatee.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Stephen Bates <sbates@raithlin.com>, Colin Ian King <colin.king@canonical.com>, Doug Meyer <dmeyer@gigaio.com>, Kelvin Cao <kelvin.cao@microsemi.com>, linux-pci@vger.kernel.org, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

Newer gcc (version 7 and 8 presumably) warn about a statement mixing
the << operator with logical and:

drivers/ntb/hw/mscc/ntb_hw_switchtec.c: In function 'switchtec_ntb_init_sndev':
drivers/ntb/hw/mscc/ntb_hw_switchtec.c:888:24: error: '<<' in boolean context, did you mean '<' ? [-Werror=int-in-bool-context]

My interpretation here is that the author must have intended a bitmask
rather than a comparison, so I'm changing the '&&' to '&', which makes
a lot more sense in the context.

Fixes: 1b249475275d ("ntb_hw_switchtec: Allow using Switchtec NTB in multi-partition setups")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
index bcd5b6fb3800..76acb8bba3f2 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -885,7 +885,7 @@ static int switchtec_ntb_init_sndev(struct switchtec_ntb *sndev)
 		}
 
 		sndev->peer_partition = ffs(tpart_vec) - 1;
-		if (!(part_map && (1 << sndev->peer_partition))) {
+		if (!(part_map & (1 << sndev->peer_partition))) {
 			dev_err(&sndev->stdev->dev,
 				"ntb target partition is not NT partition\n");
 			return -ENODEV;
-- 
2.9.0

