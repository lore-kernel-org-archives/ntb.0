Received: from stryx7.localdomain (unknown [12.22.252.226])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E76621
	for <ntb@lists.linux.dev>; Thu,  8 Dec 2022 02:22:52 +0000 (UTC)
Received: by stryx7.localdomain (Postfix, from userid 1007)
	id 5F4EC61241A8; Wed,  7 Dec 2022 18:14:17 -0800 (PST)
Date: Wed, 07 Dec 2022 18:14:17 -0800
From: epilmore@gigaio.com
To: epilmore@gigaio.com, netdev@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 ntb@lists.linux.dev, allenbh@gmail.com, dave.jiang@intel.com,
 jdmason@kudzu.us
Subject: [PATCH] ntb_netdev: Use dev_kfree_skb_irq() in interrupt context
Message-ID: <63914879.CJDc0NszG7y0lmQT%epilmore@gigaio.com>
User-Agent: Heirloom mailx 12.5 7/5/10
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

From: Eric Pilmore <epilmore@gigaio.com>

TX/RX callback handlers (ntb_netdev_tx_handler(),
ntb_netdev_rx_handler()) can be called in interrupt
context via the DMA framework when the respective
DMA operations have completed. As such, any calls
by these routines to free skb's, should use the
interrupt context safe dev_kfree_skb_irq() function.

Previously, these callback handlers would call the
interrupt unsafe version of dev_kfree_skb(). Although
this does not seem to present an issue when the
underlying DMA engine being utilized is Intel IOAT,
a kernel WARNING message was being encountered when
PTDMA DMA engine was utilized on AMD platforms. The
WARNING was being issued from skb_release_head_state()
due to in_hardirq() being true.

Besides the user visible WARNING from the kernel,
the other symptom of this bug was that TCP/IP performance
across the ntb_netdev interface was very poor, i.e.
approximately an order of magnitude below what was
expected. With the repair to use dev_kfree_skb_irq(),
kernel WARNINGs from skb_release_head_state() ceased
and TCP/IP performance, as measured by iperf, was on
par with expected results, approximately 20 Gb/s on
AMD Milan based server. Note that this performance
is comparable with Intel based servers.

Fixes: 765ccc7bc3d91 ("ntb_netdev: correct skb leak")
Fixes: 548c237c0a997 ("net: Add support for NTB virtual ethernet device")
Signed-off-by: Eric Pilmore <epilmore@gigaio.com>
---
 drivers/net/ntb_netdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index 80bdc07..283e23c 100644
--- a/drivers/net/ntb_netdev.c
+++ b/drivers/net/ntb_netdev.c
@@ -137,7 +137,7 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
 enqueue_again:
 	rc = ntb_transport_rx_enqueue(qp, skb, skb->data, ndev->mtu + ETH_HLEN);
 	if (rc) {
-		dev_kfree_skb(skb);
+		dev_kfree_skb_irq(skb);
 		ndev->stats.rx_errors++;
 		ndev->stats.rx_fifo_errors++;
 	}
@@ -192,7 +192,7 @@ static void ntb_netdev_tx_handler(struct ntb_transport_qp *qp, void *qp_data,
 		ndev->stats.tx_aborted_errors++;
 	}
 
-	dev_kfree_skb(skb);
+	dev_kfree_skb_irq(skb);
 
 	if (ntb_transport_tx_free_entry(dev->qp) >= tx_start) {
 		/* Make sure anybody stopping the queue after this sees the new
-- 
1.8.3.1

