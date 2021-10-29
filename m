Return-Path: <jiangliuer01@gmail.com>
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com. [2607:f8b0:4864:20::532])
        by gmr-mx.google.com with ESMTPS id b125si731128qkf.0.2021.10.29.05.05.42
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Oct 2021 05:05:42 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id t7so9685923pgl.9
        for <linux-ntb@googlegroups.com>; Fri, 29 Oct 2021 05:05:42 -0700 (PDT)
Return-Path: <jiangliuer01@gmail.com>
From: Wang Haojun <jiangliuer01@gmail.com>
Subject: [PATCH] IDT: Fix Build warnings on some 32bit architectures.
Date: Fri, 29 Oct 2021 20:05:12 +0800
Message-Id: <20211029120512.3456871-1-wanghaojun@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Serge Semin <fancer.lancer@gmail.com>
Cc: linux-ntb@googlegroups.com, Huacai Chen <chenhuacai@kernel.org>, Wang Haojun <wanghaojun@loongson.cn>, Li Xuefeng <lixuefeng@loongson.cn>
List-ID: <linux-ntb.googlegroups.com>

The frame size of 1032 bytes is larger than 1024 bytes on 32bit with
unaligned memory accesses architectures.

Signed-off-by: Wang Haojun <wanghaojun@loongson.cn>
---
 drivers/ntb/hw/idt/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ntb/hw/idt/Makefile b/drivers/ntb/hw/idt/Makefile
index f75e9d65c8a2..4e52d83ae75c 100644
--- a/drivers/ntb/hw/idt/Makefile
+++ b/drivers/ntb/hw/idt/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_NTB_IDT) += ntb_hw_idt.o
+CFLAGS_ntb_hw_idt.o += -Wframe-larger-than=1280
-- 
2.27.0

