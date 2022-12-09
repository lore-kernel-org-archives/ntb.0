Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D30363
	for <ntb@lists.linux.dev>; Fri,  9 Dec 2022 00:07:10 +0000 (UTC)
Received: by mail-oi1-f174.google.com with SMTP id e205so3028209oif.11
        for <ntb@lists.linux.dev>; Thu, 08 Dec 2022 16:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gigaio-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ebmoDY8nCZPCqTmmr9ClRUpQd5hVuv8r0dFmTWEzCxc=;
        b=u9zVCFxcgsUCpwrv+MLDq5+mQ7r+nViJlJlPn2dukx4J2QiwppP6npxYmm0WhwKFxl
         JuvQ4mCE6fxDQ61i70imniq2X1wyg/nsEGQS0aTPJPDSAYu/70zoh8q0PHt8f1D3aKgV
         HGBvU8BqblrsPrz8Dn/oW7FriIqgEKtEc6BpECtEamvoYGkPSCdxIN8GAgqkeyGz972h
         y57yCoHrKTjwpTFIwJVT1yoHGf9tNwLZkvvY3fHWMcK4E7yOIbVXwar5gmP1MEd7bwCQ
         zcWIKRTPVhSle91MLadp1mYRAkFS8qy7neCY6iqXFqbBGFeV4we7hIo8w9aodl6ygAov
         nZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ebmoDY8nCZPCqTmmr9ClRUpQd5hVuv8r0dFmTWEzCxc=;
        b=4wC1OF5uzsw9VeYcqN6uCv25l563/gfW1++cRE9cbxu0mjS3kWbFVEAc4HF3ynUh8d
         nWmQXpYgYsMBfehp2OZ6wngAr/SM6Hf+rjuqyQFhRnr/fa3QnL4xgWza1UDo2jFiOT6j
         rdnOcwEK8Kwxd09QEKoivrtKg8BEM9gDsIDC733Jr9KmAA+nx6qjRCbjej0DUGxwaJM8
         eXPNDuqJxemsjwRx0kSStWq9NfPpPRD8tIbzSBQM0/wSYKw6SOhsaqYne3R2cfi/6omF
         WvnI/CCyEnhfEdDKOawVJloiZxopFZdDZTokSc0QS5MRvZACh4jfdAmAlvRYKdCB5Dc7
         7xPw==
X-Gm-Message-State: ANoB5pkI2dUrnfO636J76Z7erGcnUquLuGmIn3cyPnQBzWF8Cy1T47B6
	JDnushCg5RAQodAM9KF8lXPQvg==
X-Google-Smtp-Source: AA0mqf4qOwsnBziL9Aclkzc/HxDGyT7+1LyCWP87maLZEVNpww70bSwq1ULNLvHFa0zUGz8aLTkg7A==
X-Received: by 2002:aca:1b0e:0:b0:35b:6d5:21ca with SMTP id b14-20020aca1b0e000000b0035b06d521camr1809324oib.51.1670544429683;
        Thu, 08 Dec 2022 16:07:09 -0800 (PST)
Received: from bigtwin1b.gigaio.com ([12.22.252.226])
        by smtp.gmail.com with ESMTPSA id bk9-20020a0568081a0900b003509cc4ad4esm2294oib.39.2022.12.08.16.07.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Dec 2022 16:07:09 -0800 (PST)
From: epilmore@gigaio.com
To: epilmore@gigaio.com,
	netdev@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev,
	allenbh@gmail.com,
	dave.jiang@intel.com,
	jdmason@kudzu.us
Subject: [PATCH v2] ntb_netdev: Use dev_kfree_skb_any() in interrupt context
Date: Thu,  8 Dec 2022 16:06:59 -0800
Message-Id: <20221209000659.8318-1-epilmore@gigaio.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Pilmore <epilmore@gigaio.com>

TX/RX callback handlers (ntb_netdev_tx_handler(),
ntb_netdev_rx_handler()) can be called in interrupt
context via the DMA framework when the respective
DMA operations have completed. As such, any calls
by these routines to free skb's, should use the
interrupt context safe dev_kfree_skb_any() function.

Previously, these callback handlers would call the
interrupt unsafe version of dev_kfree_skb(). This has
not presented an issue on Intel IOAT DMA engines as
that driver utilizes tasklets rather than a hard
interrupt handler, like the AMD PTDMA DMA driver.
On AMD systems, a kernel WARNING message is
encountered, which is being issued from
skb_release_head_state() due to in_hardirq()
being true.

Besides the user visible WARNING from the kernel,
the other symptom of this bug was that TCP/IP performance
across the ntb_netdev interface was very poor, i.e.
approximately an order of magnitude below what was
expected. With the repair to use dev_kfree_skb_any(),
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
index 80bdc07f2cd3..59250b7accfb 100644
--- a/drivers/net/ntb_netdev.c
+++ b/drivers/net/ntb_netdev.c
@@ -137,7 +137,7 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
 enqueue_again:
 	rc = ntb_transport_rx_enqueue(qp, skb, skb->data, ndev->mtu + ETH_HLEN);
 	if (rc) {
-		dev_kfree_skb(skb);
+		dev_kfree_skb_any(skb);
 		ndev->stats.rx_errors++;
 		ndev->stats.rx_fifo_errors++;
 	}
@@ -192,7 +192,7 @@ static void ntb_netdev_tx_handler(struct ntb_transport_qp *qp, void *qp_data,
 		ndev->stats.tx_aborted_errors++;
 	}
 
-	dev_kfree_skb(skb);
+	dev_kfree_skb_any(skb);
 
 	if (ntb_transport_tx_free_entry(dev->qp) >= tx_start) {
 		/* Make sure anybody stopping the queue after this sees the new
-- 
2.38.1

