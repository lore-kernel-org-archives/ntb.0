Return-Path: <gunthorp@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id z9si2448704pjp.0.2019.07.26.11.31.36
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Jul 2019 11:31:36 -0700 (PDT)
From: Logan Gunthorpe <logang@deltatee.com>
Date: Fri, 26 Jul 2019 12:31:30 -0600
Message-Id: <20190726183130.9424-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [PATCH] NTB/msi: remove incorrect MODULE defines
To: LKML <linux-kernel@vger.kernel.org>, linux-ntb@googlegroups.com, Jon Mason <jdmason@kudzu.us>
Cc: lkp@01.org, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Logan Gunthorpe <logang@deltatee.com>, kernel test robot <lkp@intel.com>
List-ID: <linux-ntb.googlegroups.com>

msi.c is not a module on its own right and should not have the
MODULE_[LICENSE|VERSION|AUTHOR|DESCRIPTION] definitions.

This caused a regression noticed by lkp with the following back
trace:

   WARNING: CPU: 0 PID: 1 at kernel/params.c:861 param_sysfs_init+0xb1/0x20a
   Modules linked in:
   CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.2.0-rc1-00018-g26b3a37b928457 #2
   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
   RIP: 0010:param_sysfs_init+0xb1/0x20a
   Code: 24 38 e8 ec 17 2e fd 49 8b 7c 24 38 e8 76 fe ff ff 48 85 c0 48 89 c5 74 25 31 d2 4c 89 e6 48 89 c7 e8 6d 6f 3c fd 85 c0 74 02 <0f> 0b 48 89 ef 31 f6 e8 5d 70 a7 fe 48 89 ef e8 95 52 a7 fe 48 83
   RSP: 0000:ffff88806b0ffe30 EFLAGS: 00010282
   RAX: 00000000ffffffef RBX: ffffffff83774220 RCX: ffff88806a85e880
   RDX: 00000000ffffffef RSI: ffff88806b000400 RDI: ffff88806a8608c0
   RBP: ffff88806b392000 R08: ffffed100d61ff59 R09: ffffed100d61ff59
   R10: 0000000000000001 R11: ffffed100d61ff58 R12: ffffffff83974bc0
   R13: 0000000000000004 R14: 0000000000000028 R15: 00000000000003b9
   FS:  0000000000000000(0000) GS:ffff88806b800000(0000) knlGS:0000000000000000
   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
   CR2: 0000000000000000 CR3: 000000000380e000 CR4: 00000000000406b0
   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
   Call Trace:
    ? file_caps_disable+0x10/0x10
    ? locate_module_kobject+0xf2/0xf2
    do_one_initcall+0x47/0x1f0
    kernel_init_freeable+0x1b1/0x243
    ? rest_init+0xd0/0xd0
    kernel_init+0xa/0x130
    ? calculate_sigpending+0x63/0x80
    ? rest_init+0xd0/0xd0
    ret_from_fork+0x1f/0x30
   ---[ end trace 78201497ae74cc91 ]---

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 26b3a37b9284 ("NTB: Introduce MSI library")
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/ntb/msi.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/ntb/msi.c b/drivers/ntb/msi.c
index 9dddf133658f..0a5e884a920c 100644
--- a/drivers/ntb/msi.c
+++ b/drivers/ntb/msi.c
@@ -6,11 +6,6 @@
 #include <linux/msi.h>
 #include <linux/pci.h>
 
-MODULE_LICENSE("Dual BSD/GPL");
-MODULE_VERSION("0.1");
-MODULE_AUTHOR("Logan Gunthorpe <logang@deltatee.com>");
-MODULE_DESCRIPTION("NTB MSI Interrupt Library");
-
 struct ntb_msi {
 	u64 base_addr;
 	u64 end_addr;
-- 
2.20.1

