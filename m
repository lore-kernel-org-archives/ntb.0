Return-Path: <allen.cryptic@gmail.com>
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com. [2607:f8b0:4864:20::642])
        by gmr-mx.google.com with ESMTPS id b21si895902qtq.1.2020.08.17.02.19.45
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2020 02:19:45 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id f10so7191152plj.8
        for <linux-ntb@googlegroups.com>; Mon, 17 Aug 2020 02:19:45 -0700 (PDT)
Return-Path: <allen.cryptic@gmail.com>
From: Allen Pais <allen.cryptic@gmail.com>
Subject: [PATCH 1/2] memstick: jmb38x: convert tasklets to use new tasklet_setup() API
Date: Mon, 17 Aug 2020 14:46:09 +0530
Message-Id: <20200817091617.28119-15-allen.cryptic@gmail.com>
In-Reply-To: <20200817091617.28119-1-allen.cryptic@gmail.com>
References: <20200817091617.28119-1-allen.cryptic@gmail.com>
To: jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, 3chas3@gmail.com, axboe@kernel.dk, stefanr@s5r6.in-berlin.de, airlied@linux.ie, daniel@ffwll.ch, sre@kernel.org, James.Bottomley@HansenPartnership.com, kys@microsoft.com, deller@gmx.de, dmitry.torokhov@gmail.com, jassisinghbrar@gmail.com, shawnguo@kernel.org, s.hauer@pengutronix.de, maximlevitsky@gmail.com, oakad@yahoo.com, ulf.hansson@linaro.org, mporter@kernel.crashing.org, alex.bou9@gmail.com, broonie@kernel.org, martyn@welchs.me.uk, manohar.vanga@gmail.com, mitch@sfgoth.com, davem@davemloft.net, kuba@kernel.org
Cc: keescook@chromium.org, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org, linux-block@vger.kernel.org, linux-arm-kernel@lists.infradead.org, openipmi-developer@lists.sourceforge.net, linux1394-devel@lists.sourceforge.net, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org, linux-parisc@vger.kernel.org, linux-input@vger.kernel.org, linux-mmc@vger.kernel.org, linux-ntb@googlegroups.com, linux-s390@vger.kernel.org, linux-spi@vger.kernel.org, devel@driverdev.osuosl.org, Allen Pais <allen.lkml@gmail.com>, Romain Perier <romain.perier@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

From: Allen Pais <allen.lkml@gmail.com>

In preparation for unconditionally passing the
struct tasklet_struct pointer to all tasklet
callbacks, switch to using the new tasklet_setup()
and from_tasklet() to pass the tasklet pointer explicitly.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/memstick/host/jmb38x_ms.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/memstick/host/jmb38x_ms.c b/drivers/memstick/host/jmb38x_ms.c
index 4a6b866b0291..2bcf5ce113bd 100644
--- a/drivers/memstick/host/jmb38x_ms.c
+++ b/drivers/memstick/host/jmb38x_ms.c
@@ -603,10 +603,10 @@ static void jmb38x_ms_abort(struct timer_list *t)
 	spin_unlock_irqrestore(&host->lock, flags);
 }
 
-static void jmb38x_ms_req_tasklet(unsigned long data)
+static void jmb38x_ms_req_tasklet(struct tasklet_struct *t)
 {
-	struct memstick_host *msh = (struct memstick_host *)data;
-	struct jmb38x_ms_host *host = memstick_priv(msh);
+	struct jmb38x_ms_host *host = from_tasklet(host, t, notify);
+	struct memstick_host *msh = host->msh;
 	unsigned long flags;
 	int rc;
 
@@ -868,7 +868,7 @@ static struct memstick_host *jmb38x_ms_alloc_host(struct jmb38x_ms *jm, int cnt)
 	host->irq = jm->pdev->irq;
 	host->timeout_jiffies = msecs_to_jiffies(1000);
 
-	tasklet_init(&host->notify, jmb38x_ms_req_tasklet, (unsigned long)msh);
+	tasklet_setup(&host->notify, jmb38x_ms_req_tasklet);
 	msh->request = jmb38x_ms_submit_req;
 	msh->set_param = jmb38x_ms_set_param;
 
-- 
2.17.1

