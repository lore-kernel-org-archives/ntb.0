Return-Path: <Steve_Wahl@dell.com>
Received: from aussmtpmrkps320.us.dell.com (aussmtpmrkps320.us.dell.com. [143.166.224.254])
        by gmr-mx.google.com with ESMTPS id 126si1734100itj.3.2016.12.08.09.03.15
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Dec 2016 09:03:15 -0800 (PST)
From: Steven Wahl <Steve_Wahl@Dell.com>
Subject: [PATCH] ntb_transport: Remove unnecessary call to
 ntb_peer_spad_read.
Date: Thu, 8 Dec 2016 17:03:13 +0000
Message-ID: <89e7f17cb62a4a62a02673b10bf4a967@mspexmb1.Beer.Town>
References: <297aec6b47924ce9889abe4d6c51c173@mspexmb1.Beer.Town>
In-Reply-To: <297aec6b47924ce9889abe4d6c51c173@mspexmb1.Beer.Town>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Return-Path: Steve_Wahl@Dell.com
To: "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

The results were previously ignored, anyway.=0A=
=0A=
Signed-off-by: Steve Wahl <Steve.Wahl@dell.com>=0A=
---=0A=
 drivers/ntb/ntb_transport.c | 1 -=0A=
 1 file changed, 1 deletion(-)=0A=
=0A=
diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c=0A=
index 4eb8adb..cd9a392 100644=0A=
--- a/drivers/ntb/ntb_transport.c=0A=
+++ b/drivers/ntb/ntb_transport.c=0A=
@@ -960,7 +960,6 @@ static void ntb_qp_link_work(struct work_struct *work)=
=0A=
        ntb_peer_spad_write(nt->ndev, QP_LINKS, val | BIT(qp->qp_num));=0A=
=0A=
        /* query remote spad for qp ready bits */=0A=
-       ntb_peer_spad_read(nt->ndev, QP_LINKS);=0A=
        dev_dbg_ratelimited(&pdev->dev, "Remote QP link status =3D %x\n", v=
al);=0A=
=0A=
        /* See if the remote side is up */=0A=
--=0A=
2.7.4=0A=
=0A=
