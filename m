Return-Path: <Kelvin.Cao@microchip.com>
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com. [68.232.154.123])
        by gmr-mx.google.com with ESMTPS id q2si170721ljc.0.2021.12.23.17.25.09
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Dec 2021 17:25:09 -0800 (PST)
From: Kelvin Cao <kelvin.cao@microchip.com>
Subject: [PATCH 5/6] ntb_hw_switchtec: Remove code for disabling ID protection
Date: Thu, 23 Dec 2021 17:23:33 -0800
Message-ID: <20211224012334.89173-6-kelvin.cao@microchip.com>
In-Reply-To: <20211224012334.89173-1-kelvin.cao@microchip.com>
References: <20211224012334.89173-1-kelvin.cao@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: kelvin.cao@microchip.com
Content-Type: text/plain
To: Kurt Schwemmer <kurt.schwemmer@microsemi.com>, Logan Gunthorpe <logang@deltatee.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-pci@vger.kernel.org, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
Cc: Kelvin Cao <kelvin.cao@microchip.com>, kelvincao@outlook.com, Jeremy
 Pallotta <jmpallotta@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

ID protection is a firmware setting for NT window access control. With
it enabled, only the posted requests with requester IDs in the requester
ID table will be allowed to access the NT windows. Otherwise all posted
requests are allowed. Normally user will configure it statically via the
Switchtec config file, and it will take effect when the firmware boots
up. The driver can also toggle the ID protection setting dynamically,
which will overwrite the static setting in the Switchtec config file as
a side effect.

Currently, the driver disables the ID protection. However, it's not
necessary to disable the ID protection at the driver level as the driver
has already configured the proper requester IDs in the requester ID
table to allow the corresponding posted requests to hit the NT windows.
Remove the code that disables the ID protection to make the static
setting prevail.

Note: ID protection is not applicable to non-posted requests.

Signed-off-by: Kelvin Cao <kelvin.cao@microchip.com>
---
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 3 ---
 include/linux/switchtec.h              | 2 --
 2 files changed, 5 deletions(-)

diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
index 03839346233d..0e33eef64ec6 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -967,9 +967,6 @@ static int config_req_id_table(struct switchtec_ntb *sndev,
 	if (rc)
 		return rc;
 
-	iowrite32(NTB_PART_CTRL_ID_PROT_DIS,
-		  &mmio_ctrl->partition_ctrl);
-
 	for (i = 0; i < count; i++) {
 		iowrite32(req_ids[i] << 16 | NTB_CTRL_REQ_ID_EN,
 			  &mmio_ctrl->req_id_table[i]);
diff --git a/include/linux/switchtec.h b/include/linux/switchtec.h
index be24056ac00f..48fabe36509e 100644
--- a/include/linux/switchtec.h
+++ b/include/linux/switchtec.h
@@ -337,8 +337,6 @@ enum {
 	NTB_CTRL_REQ_ID_EN = 1 << 0,
 
 	NTB_CTRL_LUT_EN = 1 << 0,
-
-	NTB_PART_CTRL_ID_PROT_DIS = 1 << 0,
 };
 
 struct ntb_ctrl_regs {
-- 
2.25.1

