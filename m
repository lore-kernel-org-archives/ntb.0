Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19765C96;
	Thu,  6 Jun 2024 08:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717661734; cv=none; b=mBZBdHOyEP/v4JlUYBZciD2Pcc/v7bKw4LYgFVmsxX7i/BdrPF1hYWeaJIfPQN3+OfVsC4ADCdkYxcFlIG04o8LkMbje1nsMRHGKQMt35uotXhXu1C2LqS2Q7BAfQSG8DA02o2+PwErofajwqR17qVYbPhbRfu3p9v93QiawH20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717661734; c=relaxed/simple;
	bh=qqQC4N4qM8SKjgtTHvaS/WXpl4ugfRenh7/dnBWZlIk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BqSS4zcnaz1HQzI4zwdAuyCjyFwxRWJvuxIb0K6Tw27mkxwCBT9Xz6c/7xKdD8wHiERzP0ojWN/Kc/OGWIUvBusPq5caN4o7mG8Ip2lSZGAbem1Tyuj5SNY6cL/3W/I9npQKiwlkIVzgcdcJnCgMvpZFCdJpqZgjgdXY2Bv528A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q70jBlpJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q70jBlpJ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73914C4AF0C;
	Thu,  6 Jun 2024 08:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717661733;
	bh=qqQC4N4qM8SKjgtTHvaS/WXpl4ugfRenh7/dnBWZlIk=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=q70jBlpJMTgvIkjQdk1GFBLrKer1dglrqH9+8vDT9bfhTmSc3ggNXgD5doySKpYJ3
	 tEwWRyrpb24i0uMClBJeig7DiI6EP5J2lm1oDE6HegJl+ICCPmSs+hMICjy7kep6Xs
	 ZWvcyjdKCfuafPAnw8Z3TNZQ1LDejA2PW3XROyMHJgvWuzvsQkZEOUPZwMmzM+pX8f
	 iC3d4fiX0kToJ0OMcjbJTQqzglTkbZuRIhTxEbxLwB6SWWui/XHfy3ErnlJb7nKhDC
	 rri1YMWdZNABHZJB/N27NbYwRcfn93nzGmq573TmqUmocdY1hGUk3a2V7BPozIeTsD
	 Q75ZGkCD6gtoA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591EAC25B75;
	Thu,  6 Jun 2024 08:15:33 +0000 (UTC)
From: Nikita Shubin via B4 Relay <devnull+n.shubin.yadro.com@kernel.org>
Date: Thu, 06 Jun 2024 11:15:19 +0300
Subject: [PATCH] ntb: intel: Fix using link status DB's
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-ntb_intel_db_fix-v1-1-ba9033aea289@yadro.com>
X-B4-Tracking: v=1; b=H4sIABZwYWYC/x2MWwqAIBAAryL7nWAWUl0lQnystRAWKhFEd0/6n
 IGZBzImwgwTeyDhRZmOWKFtGLjNxBU5+cogheyFEorHYjXFgrv2Vge6ueiUHMdgrOsHqNmZsOp
 /OS/v+wE9gs7NYgAAAA==
To: Dave Jiang <dave.jiang@intel.com>, Jon Mason <jdmason@kudzu.us>, 
 Allen Hubbe <allenbh@gmail.com>
Cc: Nikita Shubin <nikita.shubin@maquefel.me>, ntb@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux@yadro.com, 
 Nikita Shubin <n.shubin@yadro.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717661730; l=1211;
 i=n.shubin@yadro.com; s=20230718; h=from:subject:message-id;
 bh=m6Ej8L6+xmXOl3RZbV82ktzzdYahkk4scP8S6bypgnI=;
 b=+HlydAPVVu4+ZMywh4SWhA+S6XYV8sVahCZZ6LzcQ8yNPDKz7VT9FpR+U826CFRkkiBi9zeM3ILx
 tuiY46THD8IhJfZQ3NGDixQ4ib+QBUIj5WD61znSyHouI32j9RiA
X-Developer-Key: i=n.shubin@yadro.com; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for n.shubin@yadro.com/20230718 with
 auth_id=161
X-Original-From: Nikita Shubin <n.shubin@yadro.com>
Reply-To: n.shubin@yadro.com

From: Nikita Shubin <n.shubin@yadro.com>

Make sure we are not using DB's which were remapped for link status.

Fixes: f6e51c354b60 ("ntb: intel: split out the gen3 code")
Signed-off-by: Nikita Shubin <n.shubin@yadro.com>
---
Hello Dave, sending a patch as planned.

Thank you for looking into this!

Link: https://lore.kernel.org/all/686c55cc658564e8f37147e0d6d5ab62bb8372af.camel@maquefel.me/
---
 drivers/ntb/hw/intel/ntb_hw_gen3.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ntb/hw/intel/ntb_hw_gen3.c b/drivers/ntb/hw/intel/ntb_hw_gen3.c
index ffcfc3e02c35..a5aa96a31f4a 100644
--- a/drivers/ntb/hw/intel/ntb_hw_gen3.c
+++ b/drivers/ntb/hw/intel/ntb_hw_gen3.c
@@ -215,6 +215,9 @@ static int gen3_init_ntb(struct intel_ntb_dev *ndev)
 	}
 
 	ndev->db_valid_mask = BIT_ULL(ndev->db_count) - 1;
+	/* Make sure we are not using DB's used for link status */
+	if (ndev->hwerr_flags & NTB_HWERR_MSIX_VECTOR32_BAD)
+		ndev->db_valid_mask &= ~ndev->db_link_mask;
 
 	ndev->reg->db_iowrite(ndev->db_valid_mask,
 			      ndev->self_mmio +

---
base-commit: 2df0193e62cf887f373995fb8a91068562784adc
change-id: 20240606-ntb_intel_db_fix-036299fabc48

Best regards,
-- 
Nikita Shubin <n.shubin@yadro.com>


