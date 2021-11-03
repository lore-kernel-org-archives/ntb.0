Return-Path: <jiangliuer01@gmail.com>
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com. [2607:f8b0:4864:20::330])
        by gmr-mx.google.com with ESMTPS id u3si202966qtc.4.2021.11.02.23.40.27
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Nov 2021 23:40:27 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id o10-20020a9d718a000000b00554a0fe7ba0so2170914otj.11
        for <linux-ntb@googlegroups.com>; Tue, 02 Nov 2021 23:40:27 -0700 (PDT)
Return-Path: <jiangliuer01@gmail.com>
From: Wang Haojun <jiangliuer01@gmail.com>
Subject: [PATCH v2] IDT: Fix Build warnings on some 32bit architectures.
Date: Wed,  3 Nov 2021 14:39:43 +0800
Message-Id: <20211103063943.4098587-1-wanghaojun@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Serge Semin <fancer.lancer@gmail.com>
Cc: linux-ntb@googlegroups.com, Huacai Chen <chenhuacai@kernel.org>, Wang Haojun <wanghaojun@loongson.cn>, Li Xuefeng <lixuefeng@loongson.cn>
List-ID: <linux-ntb.googlegroups.com>

Building an allmodconfig mips kernel, the following build warning
shows up:

drivers/ntb/hw/idt/ntb_hw_idt.c: In function 'idt_scan_mws':
drivers/ntb/hw/idt/ntb_hw_idt.c:1116:1: error: the frame size of 1032 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]

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

