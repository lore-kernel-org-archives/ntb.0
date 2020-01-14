Return-Path: <deller@gmx.de>
Received: from mout.gmx.net (mout.gmx.net. [212.227.17.22])
        by gmr-mx.google.com with ESMTPS id z16si593399ljk.0.2020.01.14.11.22.52
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jan 2020 11:22:52 -0800 (PST)
Date: Tue, 14 Jan 2020 20:22:47 +0100
From: Helge Deller <deller@gmx.de>
Subject: [PATCH] ntb_tool: Fix printk format
Message-ID: <20200114192247.GA30840@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, Serge Semin <fancer.lancer@gmail.com>
Cc: linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

The correct printk format is %pa or %pap, but not %pa[p].

Signed-off-by: Helge Deller <deller@gmx.de>
Fixes: 7f46c8b3a5523 ("NTB: ntb_tool: Add full multi-port NTB API support"=
)

diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
index d592c0ffbd19..69da758fe64c 100644
=2D-- a/drivers/ntb/test/ntb_tool.c
+++ b/drivers/ntb/test/ntb_tool.c
@@ -678,19 +678,19 @@ static ssize_t tool_mw_trans_read(struct file *filep=
, char __user *ubuf,
 			 &inmw->dma_base);

 	off +=3D scnprintf(buf + off, buf_size - off,
-			 "Window Size    \t%pa[p]\n",
+			 "Window Size    \t%pap\n",
 			 &inmw->size);

 	off +=3D scnprintf(buf + off, buf_size - off,
-			 "Alignment      \t%pa[p]\n",
+			 "Alignment      \t%pap\n",
 			 &addr_align);

 	off +=3D scnprintf(buf + off, buf_size - off,
-			 "Size Alignment \t%pa[p]\n",
+			 "Size Alignment \t%pap\n",
 			 &size_align);

 	off +=3D scnprintf(buf + off, buf_size - off,
-			 "Size Max       \t%pa[p]\n",
+			 "Size Max       \t%pap\n",
 			 &size_max);

 	ret =3D simple_read_from_buffer(ubuf, size, offp, buf, off);
@@ -907,16 +907,16 @@ static ssize_t tool_peer_mw_trans_read(struct file *=
filep, char __user *ubuf,
 			 "Virtual address     \t0x%pK\n", outmw->io_base);

 	off +=3D scnprintf(buf + off, buf_size - off,
-			 "Phys Address        \t%pa[p]\n", &map_base);
+			 "Phys Address        \t%pap\n", &map_base);

 	off +=3D scnprintf(buf + off, buf_size - off,
-			 "Mapping Size        \t%pa[p]\n", &map_size);
+			 "Mapping Size        \t%pap\n", &map_size);

 	off +=3D scnprintf(buf + off, buf_size - off,
 			 "Translation Address \t0x%016llx\n", outmw->tr_base);

 	off +=3D scnprintf(buf + off, buf_size - off,
-			 "Window Size         \t%pa[p]\n", &outmw->size);
+			 "Window Size         \t%pap\n", &outmw->size);

 	ret =3D simple_read_from_buffer(ubuf, size, offp, buf, off);
 	kfree(buf);
