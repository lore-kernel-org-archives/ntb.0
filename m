Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793541435;
	b=5kxo1zcrid3B90Lm4PODIxIXtwrQEKl3FeIHik1NtOVasjujR1ZikFe/Ul6jdzjpoFZ/
	 ijmkg00d8JWG1cZ3LOlD4Kt15KLtXJI4nqh7+0/rkkusX01fLDogdGrEp408fXI3fALGu
	 sHTai6VxKLVwOECrYYeWI0CMDjdfeKWfiLScAH53cA9LeQWtdH21K+zZ3EG9NHhmcv67I
	 sBQgufS7+M1VSob+BUpIgOuwQ3VPtMf6VJz4F+9WM5PbKGdvzqgWdPdGyb5ZbZPYFnDmJ
	 r73ZD6Fx5WEJAk3ikdpjsHRMcRuzjR5TW8hEnv8SlaOZt//Md+Lz+URqGwuOE+9FsBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793541435;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Av2lRHeonZp+yqJTEDLWyK1iTAVf1prXux4FrMXUUmk=;
	b=LVMTUZTyIGdHTkC0+bl6i76OikUq/0p7uRCCZ3GmbOnkbPyTe1NajDnSi7KezWexXMxb
	 BpRaKStkkUW+ZPNrqsNMgqqOnHmqaWQ9/WmNCj1vRDWsntlmnyjStD6SM40k09/A6i3XP
	 LWU/maCDVhAQ3pRijjR3zLm/4y3GIkoxynVfDI1M0S4YKqxydgvoRDSN8s/CdTNDnm4+n
	 TiApPXeMwdMemFcq7HOwUDE4vg+4Z/OcakUcp+vGH9CBN9ss3KEh7QThynAnelD33GpRv
	 EdM8vkNYZ6ZMTbPPhdN44Ph5q9PmnCv9WLbHIF885sbxEIZI9TapNjAFLDy/Jhv8idQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B0C6ETfV;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41266606A332
	for <ntb@lists.linux.dev>; Sun,  1 Nov 2026 13:57:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41266606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B0C6ETfV
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48df8fe8513so1830179f8f.0
        for <ntb@lists.linux.dev>; Sun, 01 Nov 2026 05:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793541433; x=1794146233; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Av2lRHeonZp+yqJTEDLWyK1iTAVf1prXux4FrMXUUmk=;
        b=B0C6ETfVAeOMU87Pu9K0QtIgiUYnMirvl9Qc37+Fh6K8bNVfG4G75JSWq2pW3TZiFT
         H9BHNjkFRgwCCgBxgJrJGWmff5XvoT+hWW7T4uyT0ZQAjMRNU3RmGDTAt9lCHCvooV+z
         uBpnDzWAyYvNJZp+8RixQsmL95VZwu89DaDcurKyaEiD1hN71jpwoFQhtsA4ki01VW3Y
         W76hsHlqEjpXefHoczuBhGsDzo0JD1pCO8EFDX/g0FT2TCUm0DZrZFqjRNauhteL/Mak
         tMY2Jd6VWCXk2UXzRjKfGXJS1x7NCddPXm20tOCuUoJzUq5sV/AOeu110bxkqVBRkCqD
         9SqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793541433; x=1794146233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Av2lRHeonZp+yqJTEDLWyK1iTAVf1prXux4FrMXUUmk=;
        b=SMxrTMgvKzUt7y2zLVlvlyZqJxIpv5zSH4hOdmKCsDRTvYn8yH9yMafQoPMOVhbotc
         Ystx/Ry0l6iu6BIvmdKGz1A4Ex2bPK20vpMqfNuv/CQ4MSoFsVAkgXIhisd0M6P5BZGN
         PSUcWSbJJiO0cfqU2TI1SC8UFMaEo0/P/hsfS9Iu+fjGS5higH2pL6+tvcWqnEQwnklg
         hOpzP5RZbkO6C0RcZPEdN12t9efeO/8p+9Rd1sIigzR4bRzVKB4I277wKIiLC+caf228
         AD3amyK0CloD0v5uNKnTUPF71JXogS2bmhgXH1rPQ5GdJX9JthnPStuYDPEzYiB/AJms
         nd+w==
X-Forwarded-Encrypted: i=1; AKwUvBx+GhSvrfdMCbkWG+2eePFcBs0plBwxYouTSGrQy24+iQFltR5GaDum0qcdai7PulnEGh8=@lists.linux.dev
X-Gm-Message-State: APuU4Z90HTpVNDIaMXHi5qD0lnsxDxB+VC7vV/6Dpx12EAEVJMvvd96c
	EEUKuMYeh4YOO3cYGbXOZLdYRWGzItXYWKxqDYkm9hi8aSqPKomHBEB0
X-Gm-Gg: AYBFou3vPu/8qpEUP+0qLWPiwJAwiKZb8eTd+PbfSdcV8cmbzlgV8ne6DRpGnfAfSaL
	qNa4rMzjuxxxx4ZlBLDNmDuAwZwuBgwgnZO+z5BJMZN0LrFlCn0BQ0CJXYfo+cH2jB/yLjTOFo2
	QwuuUYr5AlSZvXZ83Ozgmo1tLJQkHuZu6V6aGG0dMx9M3YAj6WP/ki6uKn+WzJdV1NaCTUBXEev
	DoQQ/l9RAYOhtN3SePBe2xCggDQpHKKeV81CgHqhzsmk9m+qnab29ToruDqSL0nGBy8ny7MNOMf
	mftq+cQOh6Q3zQ8dBoBtMFUA7YuY6LOiu6HtwYMS+IwumzHYNUcQ5knqKCRObbrduQY3jChuKDO
	Vgq9rwAShwoXqfppm/RaI4veNtkiQ0MusXPnQ7aOhTRJlIkA2oYZGI7/wZ3my4h/v5173SM+/9h
	AGx+cQO/8IX49MiphB10UBQw64E9nV3hGoYDiNysMBhoY5Hxax0KRYfSzrG58KDIjsJoxMlOkHG
	eeM0kcMkratVBbP2ZCW8zRBeMZJPu4g9WnTFP0uo0ziHb5xK8CLEGOfiVDHuVvsPt/xtU0qSvS/
	KHXUt29z9kq+D0VgjEJbmbElpFZR8H3N4ONZ
X-Received: by 2002:a05:6000:2603:b0:48e:6852:aea0 with SMTP id ffacd0b85a97d-48e6e526830mr16658272f8f.48.1793541433562;
        Sun, 01 Nov 2026 05:57:13 -0800 (PST)
Received: from LAPTOP-AVI.lan ([2a06:c701:4773:6f00:9c55:89d4:b00d:2bbe])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b789ecsm13856454f8f.29.2026.11.01.05.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 05:57:13 -0800 (PST)
From: Avi Weiss <thnkslprpt@gmail.com>
To: Jon Mason <jdmason@kudzu.us>
Cc: Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Koichiro Den <den@valinux.co.jp>,
	Frank Li <Frank.Li@nxp.com>,
	ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Avi Weiss <thnkslprpt@gmail.com>
Subject: [PATCH v2 2/2] NTB: epf: propagate MW command errors while status is reliable
Date: Sun,  1 Nov 2026 15:57:06 +0200
Message-ID: <62334fd3b8d69fdfdeed268d71f473df45f34556.1793540847.git.thnkslprpt@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793540847.git.thnkslprpt@gmail.com>
References: <cover.1793540847.git.thnkslprpt@gmail.com>
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Post: <mailto:ntb@lists.linux.dev>
List-Help: <mailto:ntb+help@lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
List-Owner: <mailto:ntb+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ntb_epf_mw_set_trans() and ntb_epf_mw_clear_trans() discard command
errors even when the endpoint explicitly rejects a request.

A timed-out command may still complete on the endpoint. Propagating
that timeout can cause callers to free DMA buffers before the mapping
completes. A late completion may also be mistaken for the result of a
subsequent command.

Record the first command timeout and propagate MW command errors only
while completion status remains reliable. Preserve the original MW
success-return behavior after a timeout to avoid releasing buffers
based on ambiguous results.

Fixes: 812ce2f8d14e ("NTB: Add support for EPF PCI Non-Transparent Bridge")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---
 drivers/ntb/hw/epf/ntb_hw_epf.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index da7fbe1800656..455bcefc7c13e 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -102,6 +102,7 @@ struct ntb_epf_dev {
 	struct device *dev;
 	/* Mutex to protect providing commands to NTB EPF */
 	struct mutex cmd_lock;
+	bool cmd_status_unreliable;
 
 	const enum pci_barno *barno_map;
 
@@ -148,6 +149,7 @@ static int ntb_epf_send_command_locked(struct ntb_epf_dev *ndev, u32 command,
 			break;
 
 		if (WARN_ON(timedout)) {
+			ndev->cmd_status_unreliable = true;
 			ret = -ETIMEDOUT;
 			break;
 		}
@@ -156,6 +158,13 @@ static int ntb_epf_send_command_locked(struct ntb_epf_dev *ndev, u32 command,
 	}
 
 	writew(0, ndev->ctrl_reg + NTB_EPF_CMD_STATUS);
+	/*
+	 * After a timeout, a status may refer to an earlier command.
+	 * MW callers may free buffers on error, so retain old semantics.
+	 */
+	if (ndev->cmd_status_unreliable &&
+	    (command == CMD_CONFIGURE_MW || command == CMD_TEARDOWN_MW))
+		ret = 0;
 
 	return ret;
 }
@@ -485,7 +494,7 @@ static int ntb_epf_mw_set_trans(struct ntb_dev *ntb, int pidx, int idx,
 	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
 	struct device *dev = ndev->dev;
 	resource_size_t mw_size;
-	int bar;
+	int bar, ret;
 
 	if (pidx != NTB_DEF_PEER_IDX) {
 		dev_err(dev, "Unsupported Peer ID %d\n", pidx);
@@ -509,19 +518,19 @@ static int ntb_epf_mw_set_trans(struct ntb_dev *ntb, int pidx, int idx,
 	writel(upper_32_bits(addr), ndev->ctrl_reg + NTB_EPF_UPPER_ADDR);
 	writel(lower_32_bits(size), ndev->ctrl_reg + NTB_EPF_LOWER_SIZE);
 	writel(upper_32_bits(size), ndev->ctrl_reg + NTB_EPF_UPPER_SIZE);
-	ntb_epf_send_command_locked(ndev, CMD_CONFIGURE_MW, idx);
+	ret = ntb_epf_send_command_locked(ndev, CMD_CONFIGURE_MW, idx);
 	mutex_unlock(&ndev->cmd_lock);
 
-	return 0;
+	return ret;
 }
 
 static int ntb_epf_mw_clear_trans(struct ntb_dev *ntb, int pidx, int idx)
 {
 	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
 	struct device *dev = ndev->dev;
-	int ret = 0;
+	int ret;
 
-	ntb_epf_send_command(ndev, CMD_TEARDOWN_MW, idx);
+	ret = ntb_epf_send_command(ndev, CMD_TEARDOWN_MW, idx);
 	if (ret)
 		dev_err(dev, "Failed to teardown memory window\n");
 
-- 
2.43.0

