Return-Path: <Joey.Zhang@microchip.com>
Received: from esa3.microchip.iphmx.com (esa3.microchip.iphmx.com. [68.232.153.233])
        by gmr-mx.google.com with ESMTPS id h203si3941958vkh.0.2019.01.06.19.19.36
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Jan 2019 19:19:36 -0800 (PST)
From: Joey Zhang <joey.zhang@microchip.com>
Subject: [PATCH] NTB: ntb_transport: Free MWs in ntb_transport_link_cleanup()
Date: Mon, 7 Jan 2019 11:12:56 +0800
Message-ID: <1546830776-3138-1-git-send-email-joey.zhang@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: joey.zhang@microchip.com
To: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
Cc: Joey Zhang <joey.zhang@microchip.com>
List-ID: <linux-ntb.googlegroups.com>

If NTB peer host crashes or reboots, the NTB transport link will be
down and the MWs of NTB transport will be invalid. But the
ntb_transport_link_cleanup() does not free these invalid MWs. When
the NTB peer host is recovered later, NTB transport link will be
up and the ntb_set_mw() will not reset up MWs. Because the MWs of
NTB transport are invalid, the NTB transport will not work.

We can fix it by freeing MWs when NTB transport link is down, then
the ntb_set_mw() will reset up MWs when NTB transport link is up.

Signed-off-by: Joey Zhang <joey.zhang@microchip.com>
---
 drivers/ntb/ntb_transport.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 3bfdb45..6e8902d 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -862,6 +862,9 @@ static void ntb_transport_link_cleanup(struct ntb_transport_ctx *nt)
 	if (!nt->link_is_up)
 		cancel_delayed_work_sync(&nt->link_work);
 
+	for (i = 0; i < nt->mw_count; i++)
+		ntb_free_mw(nt, i);
+
 	/* The scratchpad registers keep the values if the remote side
 	 * goes down, blast them now to give them a sane value the next
 	 * time they are accessed
-- 
2.7.4

