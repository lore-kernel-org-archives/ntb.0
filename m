Return-Path: <gunthorp@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id e125si145685qkd.5.2018.03.27.16.08.53
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Mar 2018 16:08:54 -0700 (PDT)
From: Logan Gunthorpe <logang@deltatee.com>
Date: Tue, 27 Mar 2018 17:08:29 -0600
Message-Id: <20180327230834.5931-5-logang@deltatee.com>
In-Reply-To: <20180327230834.5931-1-logang@deltatee.com>
References: <20180327230834.5931-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [PATCH v15 4/9] powerpc: iomap.c: introduce io{read|write}64_{lo_hi|hi_lo}
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-ntb@googlegroups.com, linux-crypto@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Andy Shevchenko <andy.shevchenko@gmail.com>, =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>, Logan Gunthorpe <logang@deltatee.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
List-ID: <linux-ntb.googlegroups.com>

These functions will be introduced into the generic iomap.c so
they can deal with PIO accesses in hi-lo/lo-hi variants. Thus,
the powerpc version of iomap.c will need to provide the same
functions even though, in this arch, they are identical to the
regular io{read|write}64 functions.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Tested-by: Horia Geantă <horia.geanta@nxp.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/iomap.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/powerpc/kernel/iomap.c b/arch/powerpc/kernel/iomap.c
index aab456ed2a00..5ac84efc6ede 100644
--- a/arch/powerpc/kernel/iomap.c
+++ b/arch/powerpc/kernel/iomap.c
@@ -45,12 +45,32 @@ u64 ioread64(void __iomem *addr)
 {
 	return readq(addr);
 }
+u64 ioread64_lo_hi(void __iomem *addr)
+{
+	return readq(addr);
+}
+u64 ioread64_hi_lo(void __iomem *addr)
+{
+	return readq(addr);
+}
 u64 ioread64be(void __iomem *addr)
 {
 	return readq_be(addr);
 }
+u64 ioread64be_lo_hi(void __iomem *addr)
+{
+	return readq_be(addr);
+}
+u64 ioread64be_hi_lo(void __iomem *addr)
+{
+	return readq_be(addr);
+}
 EXPORT_SYMBOL(ioread64);
+EXPORT_SYMBOL(ioread64_lo_hi);
+EXPORT_SYMBOL(ioread64_hi_lo);
 EXPORT_SYMBOL(ioread64be);
+EXPORT_SYMBOL(ioread64be_lo_hi);
+EXPORT_SYMBOL(ioread64be_hi_lo);
 #endif /* __powerpc64__ */
 
 void iowrite8(u8 val, void __iomem *addr)
@@ -83,12 +103,32 @@ void iowrite64(u64 val, void __iomem *addr)
 {
 	writeq(val, addr);
 }
+void iowrite64_lo_hi(u64 val, void __iomem *addr)
+{
+	writeq(val, addr);
+}
+void iowrite64_hi_lo(u64 val, void __iomem *addr)
+{
+	writeq(val, addr);
+}
 void iowrite64be(u64 val, void __iomem *addr)
 {
 	writeq_be(val, addr);
 }
+void iowrite64be_lo_hi(u64 val, void __iomem *addr)
+{
+	writeq_be(val, addr);
+}
+void iowrite64be_hi_lo(u64 val, void __iomem *addr)
+{
+	writeq_be(val, addr);
+}
 EXPORT_SYMBOL(iowrite64);
+EXPORT_SYMBOL(iowrite64_lo_hi);
+EXPORT_SYMBOL(iowrite64_hi_lo);
 EXPORT_SYMBOL(iowrite64be);
+EXPORT_SYMBOL(iowrite64be_lo_hi);
+EXPORT_SYMBOL(iowrite64be_hi_lo);
 #endif /* __powerpc64__ */
 
 /*
-- 
2.11.0

