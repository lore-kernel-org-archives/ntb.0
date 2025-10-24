Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE41E26F2B0
	for <ntb@lists.linux.dev>; Fri, 24 Oct 2025 06:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761286908; cv=none; b=H6y0XaEPnvQfm9USZatJ0wmqyp6rY+LzpXiqPDc1D/XjQrWOjnJB7nXhgViUxy8Qmg5CJufadypzwmHK4tFWfxh7ye4kZsNcSjmK4yC7BVmxXfPOLq8lSjVQ+LYtni8kQuDlNkGGjZ22924p+O9qwr5YoSHbENxkiicz4RZ+Dp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761286908; c=relaxed/simple;
	bh=d4dIXu3USzcKHec+BoZXd6MFWRlimFU8tLSw5mRQ5ak=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l6MO5VvozmYH2aMcJ7Qti03rgIlyUkGfFonviGuSmRJM+dRkaNNFjOuUx9fmL1HEy2OSlaP8zGSaKDr/Y0w9HYdtitpl1mjo0yTv1Y6UeMZdN2OsCCP+E0ZFAqdvIJn8pQk3SmRYrbEzruQiugPWnjl5LOSGdw/FwL+1Mtg6Or8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from Jtjnmail201616.home.langchao.com
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id 202510241421321231;
        Fri, 24 Oct 2025 14:21:32 +0800
Received: from jtjnmailAR02.home.langchao.com (10.100.2.43) by
 Jtjnmail201616.home.langchao.com (10.100.2.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 24 Oct 2025 14:21:31 +0800
Received: from inspur.com (10.100.2.108) by jtjnmailAR02.home.langchao.com
 (10.100.2.43) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 24 Oct 2025 14:21:31 +0800
Received: from localhost.localdomain.com (unknown [10.94.15.147])
	by app4 (Coremail) with SMTP id bAJkCsDwZrXrGvto2RwPAA--.3118S4;
	Fri, 24 Oct 2025 14:21:31 +0800 (CST)
From: Chu Guangqing <chuguangqing@inspur.com>
To: <jdmason@kudzu.us>, <dave.jiang@intel.com>, <allenbh@gmail.com>
CC: <ntb@lists.linux.dev>, <linux-kernel@vger.kernel.org>, Chu Guangqing
	<chuguangqing@inspur.com>
Subject: [PATCH for-next 0/1] net: ntb: migrate to dma_map_phys instead of map_page
Date: Fri, 24 Oct 2025 14:20:41 +0800
Message-ID: <20251024062042.29971-1-chuguangqing@inspur.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: bAJkCsDwZrXrGvto2RwPAA--.3118S4
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY27AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aV
	CY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAq
	x4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6x
	CaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF
	04k20xvY0x0EwIxGrwCF54CYxVCY1x0262kKe7AKxVWUAVWUtwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 5fkxw35dqj1xlqj6x0hvsx2hhfrp/
X-CM-DELIVERINFO: =?B?0WU/MZRRTeOiUs3aOqHZ50hzsfHKF9Ds6CbXmDm38RucXu3DYXJR7Zlh9zE0nt/Iac
	D+Ka5/cslaGy953u1/jgndaEe06RDhWpbgMPDzB9Gqx5xhFrFd9ewyYrxBRY3r7zmrRHgb
	TvL5CGpG0Bhd4zY75u8=
Content-Type: text/plain
tUid: 20251024142133a5d5332ae990b13583066171d14bb59e
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

There is no functional change.

After introduction of dma_map_phys(), there is no need to convert
    from physical address to struct page in order to map page. So let's
    use it directly

Chu Guangqing (1):
  net: ntb: migrate to dma_map_phys instead of map_page

 drivers/ntb/ntb_transport.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

-- 
2.43.7

