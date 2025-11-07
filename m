Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55ED329366
	for <ntb@lists.linux.dev>; Fri,  7 Nov 2025 14:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762525535; cv=none; b=StkeJBuFehX9AJq00iBEVxjz31fZbl4zDKjFrZGDlKOazYydO1WV0B7HfZyp5CFdAW/J4ACR6NpkBwqj5JQOvLnFI7RFeG8jFM/zcmNHCmOCx2cQ4j684SEXYXN1PS0kJYq6hbYoQO2mYhYSfq1tDUHhQInEbGBrNXJz6ZygvZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762525535; c=relaxed/simple;
	bh=HaeGIdJqZ3psFf94Qv9C1pxEkuWWM5yYs+Xoo/xY/PY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V4t/aNgZ7MGV0W8EbBopK9Vz1L8OdujSJxr+Ak0T7zwu7j7UUuqkBBoTIV1GK2bYG6+ZpWSIxqTpn7HqgelUxnzBoPK39WsT4MhlcHcfndFXgLkHyomBS7jthEWjeaan5GsKI0sDYLybiKyY43hGKCX5B+fYKv9wDVJpeki4H5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Yoo23IxA; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Yoo23IxA"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-471191ac79dso9074285e9.3
        for <ntb@lists.linux.dev>; Fri, 07 Nov 2025 06:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762525532; x=1763130332; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LRZZPRDUZ7lRY76avfLnVO53M//uu4xgze6C2tCsP8I=;
        b=Yoo23IxAer05JVkHwK6SiCMmfptsf2eQb6BBhFbPNYn96xG0/X6bXnAdEG/K0+L5Aq
         sgT56TNNG+76G39048U5sGksxpGvZ7c/zbXbDAnk3kyYHHZ0MW2xaOSyiIyoZY6vGl6c
         abaa7JOOWHsKSNQl300jt4cs+gqNx9D/YeZuKON5vuYVgOV9pVoBK6pIYP76k/l4OAAy
         Lfg2UawixTiOiHw1ETLB0RhyaQdckxcwvRiH9GyGNwn7xBiE3hA9iFZuAIiRQ+B/yuf6
         nJI/H5SR9GS/MywvgVRSjxRwZfpu45MVktfY25iV35eoFY6+7CjBeQiEiIazdEadz9Wq
         ygsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762525532; x=1763130332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LRZZPRDUZ7lRY76avfLnVO53M//uu4xgze6C2tCsP8I=;
        b=Sb/1KGIPM0lRUvD7PEKyYedyXcat4ewBl9Dn9i+YvE6xRJpRBJGU2ADX+fPmlipfF3
         geXDVT9IDz5s4qYrSq122L/3KFqsGaTprXGVfk5osJTIUo9h8Jus//sFbuTlggjh/Hs3
         ztJuAf7Wc/gQtS6f1MrBV+ihID40kmAW4ul9J1XAXtOAhOr0tU/hoVJGAfmB8BALwMmo
         ntU3TcaD1EaTsfNg8C8hCa1bQVK/2ZWCPPegLIUxbxWik4q6B8aKwNef/LxH+eb0vcqW
         6phDqtcgqZKCNRbMvcAq90SmxmD5eKu6nuzxjcHJkrCBanc+cExCrr3jTR4skEOwDEqH
         hM4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWYzIcZKNBOPk1TjpEwbhjHrm8qBBrq44j48r8y7S7uSD3yAd/RTlbJeDuroFQc3zkXvY0=@lists.linux.dev
X-Gm-Message-State: AOJu0YzM2P/85CrQud/hBTCgH9WaxDAwq2ACBw5Ng8aWyhEXnOSRr6Re
	fM+InlJZOnct1tKHtBKRCYO3H6D3OVJLQ3ZuoYw1jKDDGDTyr71fMvHCDUpzQx7LlMU=
X-Gm-Gg: ASbGncsOiT2HqgQXuyBmei+lhItdZeL4ieyx0UzDyGp0bsXH3yH3GPKwXZK9QY0L/b+
	Nm3lY6Q+2fJaldg4fqq6SSCuA0mqgDS5Qj1VEmGVpGglXMkLY2LdTCV0z+8QBwLXwFOb7m0gNmn
	RaqMIjxLVizfUZPY9ZHESHc5PiuXSwNIF6GQMiBQmoHUIPurkQKHqkWCQmCAFRFULXL99VXCBk2
	saWetDXvSsgOLvjivvniiigjRvtAOt5Z948TuYwn7hNjMhbp1VpfJq+7gdHtsHzN/O0WIIvGFOt
	GQDe79bCJ/uTPYg+zUkxV6q0Tg0+0ICLkQK4VWcofPdRvoWA10cOGQD5HADa7DGLT5tDWuSS1Mr
	sUKvAkXr+gDP4AJvaLtLfiO08INNOaU85iBu1Yq/yytCuO5rdQxck+phzkUJELv8Gt4WiSUhSx1
	kjTh8owKLw+rTpCNUYT5zDUIi5
X-Google-Smtp-Source: AGHT+IE/swO0ECBwSKu80fX22MXr+gJKhInlEKy4hccqPn7CHjNPtGTEl1myfo6pa29cT5DzIn1ZtA==
X-Received: by 2002:a05:600c:4508:b0:46e:394b:49b7 with SMTP id 5b1f17b1804b1-4776bccec42mr29103625e9.37.1762525532165;
        Fri, 07 Nov 2025 06:25:32 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4776bcd51dfsm50624375e9.5.2025.11.07.06.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 06:25:31 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	ntb@lists.linux.dev
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof Wilczynski <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI: endpoint: add WQ_PERCPU to alloc_workqueue users
Date: Fri,  7 Nov 2025 15:25:26 +0100
Message-ID: <20251107142526.234685-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently if a user enqueues a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.
This lack of consistency cannot be addressed without refactoring the API.

alloc_workqueue() treats all queues as per-CPU by default, while unbound
workqueues must opt-in via WQ_UNBOUND.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This continues the effort to refactor workqueue APIs, which began with
the introduction of new workqueues and a new alloc_workqueue flag in:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

This change adds a new WQ_PERCPU flag to explicitly request
alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/pci/endpoint/functions/pci-epf-ntb.c  | 5 +++--
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-ntb.c b/drivers/pci/endpoint/functions/pci-epf-ntb.c
index e01a98e74d21..5e4ae7ef6f05 100644
--- a/drivers/pci/endpoint/functions/pci-epf-ntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-ntb.c
@@ -2124,8 +2124,9 @@ static int __init epf_ntb_init(void)
 {
 	int ret;
 
-	kpcintb_workqueue = alloc_workqueue("kpcintb", WQ_MEM_RECLAIM |
-					    WQ_HIGHPRI, 0);
+	kpcintb_workqueue = alloc_workqueue("kpcintb",
+					    WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_PERCPU,
+					    0);
 	ret = pci_epf_register_driver(&epf_ntb_driver);
 	if (ret) {
 		destroy_workqueue(kpcintb_workqueue);
diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 83e9ab10f9c4..162380ca38fb 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -1532,8 +1532,9 @@ static int __init epf_ntb_init(void)
 {
 	int ret;
 
-	kpcintb_workqueue = alloc_workqueue("kpcintb", WQ_MEM_RECLAIM |
-					    WQ_HIGHPRI, 0);
+	kpcintb_workqueue = alloc_workqueue("kpcintb",
+					    WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_PERCPU,
+					    0);
 	ret = pci_epf_register_driver(&epf_ntb_driver);
 	if (ret) {
 		destroy_workqueue(kpcintb_workqueue);
-- 
2.51.1

