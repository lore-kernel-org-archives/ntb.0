Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA121E528
	for <ntb@lists.linux.dev>; Thu,  3 Aug 2023 13:03:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A121C433C9;
	Thu,  3 Aug 2023 13:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691067810;
	bh=EPikV/PRmu4Q4MQ/8jF1ykyFZwdSFeXvbtsbFXlTz4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ev0hFd6+hVftG4l0sb7Rmq5mU+by/GzZA9JwgXYabccV977W7iIosgLrttBfMHZTe
	 iExkyAfso1ioOe7CpWYG1TRlWgPczVw+OAQnoFPwqoqfzG68e91XcFYZO/GfiG9+hj
	 xJoE6BySP+7xlD0zRYN8UyKtCn3MFkUHrVUiiRAJtkMHzEMK9KuF6+3/ObD05Ptz80
	 3/HYximGjGPNcJVnWr2Ujz40CLihWjUp4O4tmOgAVbLTBgmeCoy6vgKDA6QV9At6R9
	 BQPWsn2Z1LnJKSn0mPhu6gXTCvhq7t5pAnNC89GbLGrjpUXggsADsWbywdTtj5UMcM
	 s5y9nd1rphSZw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: ruanjinjie <ruanjinjie@huawei.com>,
	Jon Mason <jdmason@kudzu.us>,
	Sasha Levin <sashal@kernel.org>,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	bhelgaas@google.com,
	ntb@lists.linux.dev,
	linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 5/7] NTB: EPF: fix possible memory leak in pci_vntb_probe()
Date: Thu,  3 Aug 2023 09:03:18 -0400
Message-Id: <20230803130321.641516-5-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230803130321.641516-1-sashal@kernel.org>
References: <20230803130321.641516-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.7
Content-Transfer-Encoding: 8bit

From: ruanjinjie <ruanjinjie@huawei.com>

[ Upstream commit 956578e3d397e00d6254dc7b5194d28587f98518 ]

As ntb_register_device() don't handle error of device_register(),
if ntb_register_device() returns error in pci_vntb_probe(), name of kobject
which is allocated in dev_set_name() called in device_add() is leaked.

As comment of device_add() says, it should call put_device() to drop the
reference count that was set in device_initialize()
when it fails, so the name can be freed in kobject_cleanup().

Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>
Signed-off-by: Jon Mason <jdmason@kudzu.us>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index b7c7a8af99f4f..77306983ac456 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -1285,6 +1285,7 @@ static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return 0;
 
 err_register_dev:
+	put_device(&ndev->ntb.dev);
 	return -EINVAL;
 }
 
-- 
2.40.1

