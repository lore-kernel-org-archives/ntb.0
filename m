Return-Path: <gunthorp@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id 15-v6si741635oiq.3.2018.06.08.17.08.28
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Jun 2018 17:08:29 -0700 (PDT)
From: Logan Gunthorpe <logang@deltatee.com>
Date: Fri,  8 Jun 2018 18:08:13 -0600
Message-Id: <20180609000819.13883-4-logang@deltatee.com>
In-Reply-To: <20180609000819.13883-1-logang@deltatee.com>
References: <20180609000819.13883-1-logang@deltatee.com>
Subject: [PATCH 3/8] NTB: Fix the default port and peer numbers for legacy drivers
To: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Serge Semin <fancer.lancer@gmail.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Shuah Khan <shuah@kernel.org>, Logan Gunthorpe <logang@deltatee.com>
List-ID: <linux-ntb.googlegroups.com>

When the commit adding ntb_default_port_number() and
ntb_default_peer_port_number()  entered the kernel there was no
users of it so it was impossible to tell what the API needed.

When a user finally landed a year later (ntb_pingpong) there were
more NTB topologies were created and no consideration was considered
to how other drivers had changed.

Now that there is a user it can be fixed to provide a sensible default
for the legacy drivers that do not implement ntb_{peer_}port_number().
Seeing ntb_pingpong doesn't check error codes returning EINVAL was also
not sensible.

Patches for ntb_pingpong and ntb_perf follow (which are broken
otherwise) to support hardware that doesn't have port numbers. This is
important not only to not break support with existing drivers but for
the cross link topology which, due to its perfect symmetry, cannot
assign unique port numbers to each side.

Fixes: 1e5301196a88 ("NTB: Add indexed ports NTB API")
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/ntb/ntb.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/ntb/ntb.c b/drivers/ntb/ntb.c
index 93f24440d11d..d955a92a095a 100644
--- a/drivers/ntb/ntb.c
+++ b/drivers/ntb/ntb.c
@@ -225,10 +225,8 @@ int ntb_default_port_number(struct ntb_dev *ntb)
 	case NTB_TOPO_B2B_DSD:
 		return NTB_PORT_SEC_DSD;
 	default:
-		break;
+		return 0;
 	}
-
-	return -EINVAL;
 }
 EXPORT_SYMBOL(ntb_default_port_number);
 
@@ -251,10 +249,8 @@ int ntb_default_peer_port_number(struct ntb_dev *ntb, int pidx)
 	case NTB_TOPO_B2B_DSD:
 		return NTB_PORT_PRI_USD;
 	default:
-		break;
+		return 0;
 	}
-
-	return -EINVAL;
 }
 EXPORT_SYMBOL(ntb_default_peer_port_number);
 
@@ -326,4 +322,3 @@ static void __exit ntb_driver_exit(void)
 	bus_unregister(&ntb_bus);
 }
 module_exit(ntb_driver_exit);
-
-- 
2.11.0

