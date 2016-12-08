Return-Path: <Steve_Wahl@dell.com>
Received: from aussmtpmrkps320.us.dell.com (aussmtpmrkps320.us.dell.com. [143.166.224.254])
        by gmr-mx.google.com with ESMTPS id 13si1814111itg.2.2016.12.08.09.02.30
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Dec 2016 09:02:30 -0800 (PST)
From: Steven Wahl <Steve_Wahl@Dell.com>
Subject: [PATCH] NTB: correct ntb_peer_spad_read for case when callback is
 not supplied.
Date: Thu, 8 Dec 2016 17:02:28 +0000
Message-ID: <b40a94020de44fb6974bfcc978d1ce52@mspexmb1.Beer.Town>
References: <2a1282ae9ad64a34b4795541a2c290b5@mspexmb1.Beer.Town>
In-Reply-To: <2a1282ae9ad64a34b4795541a2c290b5@mspexmb1.Beer.Town>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Return-Path: Steve_Wahl@Dell.com
To: "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

=0A=
Signed-off-by: Steve Wahl <Steve.Wahl@dell.com>=0A=
---=0A=
 include/linux/ntb.h | 3 +++=0A=
 1 file changed, 3 insertions(+)=0A=
=0A=
diff --git a/include/linux/ntb.h b/include/linux/ntb.h=0A=
index 6f47562..816bd98 100644=0A=
--- a/include/linux/ntb.h=0A=
+++ b/include/linux/ntb.h=0A=
@@ -968,6 +968,9 @@ static inline int ntb_peer_spad_addr(struct ntb_dev *nt=
b, int idx,=0A=
  */=0A=
 static inline u32 ntb_peer_spad_read(struct ntb_dev *ntb, int idx)=0A=
 {=0A=
+       if (!ntb->ops->peer_spad_read)=0A=
+               return 0;=0A=
+=0A=
        return ntb->ops->peer_spad_read(ntb, idx);=0A=
 }=0A=
=0A=
--=0A=
2.7.4=0A=
=0A=
