Return-Path: <gunthorp@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id q68si307596ywg.0.2019.01.31.10.57.20
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 10:57:20 -0800 (PST)
From: Logan Gunthorpe <logang@deltatee.com>
Date: Thu, 31 Jan 2019 11:56:51 -0700
Message-Id: <20190131185656.17972-5-logang@deltatee.com>
In-Reply-To: <20190131185656.17972-1-logang@deltatee.com>
References: <20190131185656.17972-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [PATCH 4/9] NTB: Introduce functions to calculate multi-port resource index
To: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Bjorn Helgaas <bhelgaas@google.com>, Joerg Roedel <joro@8bytes.org>
Cc: Allen Hubbe <allenbh@gmail.com>, Dave Jiang <dave.jiang@intel.com>, Serge Semin <fancer.lancer@gmail.com>, Eric Pilmore <epilmore@gigaio.com>, Logan Gunthorpe <logang@deltatee.com>
List-ID: <linux-ntb.googlegroups.com>

When using multi-ports each port uses resources (dbs, msgs, mws, etc)
on every other port. Creating a mapping for these resources such that
each port has a corresponding resource on every other port is a bit
tricky.

Introduce the ntb_peer_resource_idx() function for this purpose.
It returns the peer resource number that will correspond with the
local peer index on the remote peer.

Also, introduce ntb_peer_highest_mw_idx() which will use
ntb_peer_resource_idx() but return the MW index starting with the
highest index and working down.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Jon Mason <jdmason@kudzu.us>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Allen Hubbe <allenbh@gmail.com>
---
 include/linux/ntb.h | 70 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/include/linux/ntb.h b/include/linux/ntb.h
index 181d16601dd9..f5c69d853489 100644
--- a/include/linux/ntb.h
+++ b/include/linux/ntb.h
@@ -1502,4 +1502,74 @@ static inline int ntb_peer_msg_write(struct ntb_dev *ntb, int pidx, int midx,
 	return ntb->ops->peer_msg_write(ntb, pidx, midx, msg);
 }
 
+/**
+ * ntb_peer_resource_idx() - get a resource index for a given peer idx
+ * @ntb:	NTB device context.
+ * @pidx:	Peer port index.
+ *
+ * When constructing a graph of peers, each remote peer must use a different
+ * resource index (mw, doorbell, etc) to communicate with each other
+ * peer.
+ *
+ * In a two peer system, this function should always return 0 such that
+ * resource 0 points to the remote peer on both ports.
+ *
+ * In a 5 peer system, this function will return the following matrix
+ *
+ * pidx \ port    0    1    2    3    4
+ * 0              0    0    1    2    3
+ * 1              0    1    2    3    4
+ * 2              0    1    2    3    4
+ * 3              0    1    2    3    4
+ *
+ * For example, if this function is used to program peer's memory
+ * windows, port 0 will program MW 0 on all it's peers to point to itself.
+ * port 1 will program MW 0 in port 0 to point to itself and MW 1 on all
+ * other ports. etc.
+ *
+ * For the legacy two host case, ntb_port_number() and ntb_peer_port_number()
+ * both return zero and therefore this function will always return zero.
+ * So MW 0 on each host would be programmed to point to the other host.
+ *
+ * Return: the resource index to use for that peer.
+ */
+static inline int ntb_peer_resource_idx(struct ntb_dev *ntb, int pidx)
+{
+	int local_port, peer_port;
+
+	if (pidx >= ntb_peer_port_count(ntb))
+		return -EINVAL;
+
+	local_port = ntb_port_number(ntb);
+	peer_port = ntb_peer_port_number(ntb, pidx);
+
+	if (peer_port < local_port)
+		return local_port - 1;
+	else
+		return local_port;
+}
+
+/**
+ * ntb_peer_highest_mw_idx() - get a memory window index for a given peer idx
+ *	using the highest index memory windows first
+ *
+ * @ntb:	NTB device context.
+ * @pidx:	Peer port index.
+ *
+ * Like ntb_peer_resource_idx(), except it returns indexes starting with
+ * last memory window index.
+ *
+ * Return: the resource index to use for that peer.
+ */
+static inline int ntb_peer_highest_mw_idx(struct ntb_dev *ntb, int pidx)
+{
+	int ret;
+
+	ret = ntb_peer_resource_idx(ntb, pidx);
+	if (ret < 0)
+		return ret;
+
+	return ntb_mw_count(ntb, pidx) - ret - 1;
+}
+
 #endif
-- 
2.19.0

