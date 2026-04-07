Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382123B3C1D
	for <ntb@lists.linux.dev>; Tue,  7 Apr 2026 12:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775565888; cv=none; b=uacx1/WxKwULXI1tNQ/pHPUTmr8gb64xK70UH4pCK9qDOMD3woA0KPJXcEGkke64NjDR0xrJipFsvRd3glypS/iifEadNso4AYndin5ocC12gIqt5Wox4AW+MWtVhdmTrSvM8/O1nmiuYalwz11MbFtvLLn6+GuMzbYrPRAvzjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775565888; c=relaxed/simple;
	bh=D0TB0jvRuzPNWEFrFeMfVdBNym4lEMVlSbrtCDCSGSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aP4IC0N0V9fgG8dvvu/iEyTUJ+iFvO2bhnmzxxf1kIOIkmk7cT5sBuqwlmGgV53M25dRkfoHDPaIGNUymqnJSLQyLBxIYm2HgsSVZM8IaCUdV9g8pjw+sC2oRA79+KT/TmUnITDwz3PAU+CZ9Y+FvimHUL3gpGgYNPvSEaHd2Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K9TzzWs7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BOGthgRY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K9TzzWs7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BOGthgRY"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6376Wj9U3402384
	for <ntb@lists.linux.dev>; Tue, 7 Apr 2026 12:44:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=KcSF6GhUxpn
	hWCwDbVDLTRbgA+EkufOMYvemBFzcsX4=; b=K9TzzWs7MGakwir+T4NmySrzIWT
	uwZ9V6LGYz9nbTgLNtfK9EZk/2KFDlacwc8hngf63x9a2eZhxbpG95W+2ngwLdmB
	sM0sSkXuw3C7tHEq3J2aCv0b7IZuPNepdD8w2eCBZ8UOZJ0RY0bcXDO1ULJNFYwy
	ZpR+fuEqMFkQm2kM0qPqH6QxU7zZsnIT+bQdKd57PElvx5xlov+46AzAzhsPtZ/I
	MIByhIxtk39OB1fA3TAgNeT3lijgakYMs7Sv27DaqUCb74GwgrZXQsIfjt1sfq2N
	oSUzmzhNVyrFkDdd9wV6qPvsMNN0rxXt7tepc68T7K4dz8uo4pEjTpp9Bkw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmrhtqaw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ntb@lists.linux.dev>; Tue, 07 Apr 2026 12:44:46 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c76b06f37a7so1873132a12.0
        for <ntb@lists.linux.dev>; Tue, 07 Apr 2026 05:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775565885; x=1776170685; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KcSF6GhUxpnhWCwDbVDLTRbgA+EkufOMYvemBFzcsX4=;
        b=BOGthgRYHx3KydicKpyh7AUyOrN1BD+kkIpnALUWvZw1ARSKLzWLq87+FDSZeqGs0Q
         CEeELcKsHQ9W+5SQaSFMh6yNm+3EXtno9xca4JarV16l3uNcJA/w7yn7LtYmzlvasQOF
         X+iEbRlUiai31/YCmeNPl5zK/20GUnKMuz6YZNyG90jv0N2a1aRPe4kaanajQcZx4xso
         8hX/nidmBhTn4M0DnCLrnmv2RTeCSyfnNFYyJLKwvA1uANdrUhWSaw69TZL7uMPB0o9U
         PjqxGwjni+tSkm9XAZQMmRQ8OpiKYr7JZF4zBqzQonhErT/ygkqOEOCV5eo1OIEnA8av
         PHzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775565885; x=1776170685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KcSF6GhUxpnhWCwDbVDLTRbgA+EkufOMYvemBFzcsX4=;
        b=V85xhz+/7X0iNvjIvVtfkWZCnD2e4YT5nsgRWs3vLQd30kfq7X/Q97xDi9x6W9hWiW
         lgygn45otd8XkdW0dBfCuVjbkSu8Rx9ANj9suh1lGpP4i+sBFMHOYoYaih1nUbkEd00Y
         E0z6uDCSLSUjMc6N9ntyjuwYA6zLUChCikWvJ/daQa2XCuxgYgn5ASiZmsOPMSBGbUoW
         oKOMyqJ6fBTLKoRJ1pOby/AvY7xWuCgUySG/UQ5HyNiLRm4wAXDUx207XNVh9a3N5IyB
         TGvER2RhaBkCHSmMB/8oMVtZmLP3uEtUqxTpxkRgCMmpqMv9btN1yNL2xie12uFojxj2
         cYGw==
X-Forwarded-Encrypted: i=1; AJvYcCWhZtLGx9ruBitx70bQr+7kBAXxDlChVShu3M3okgXNJljGJ7ZD4nxjFfz2O1aPX+VASts=@lists.linux.dev
X-Gm-Message-State: AOJu0YyoDm+6YC8OB0Zxe9NCWPIv9IN4n5VsLju7rVu94r5UBHXDFobI
	cpWZv70HT8ciNNHemGpFFSdSma8reS/TJ1T2ZNusSSwYkDb6M9dfIudlzN0/99DZRk/OkbNgyc4
	mijGpJjqEdwCdTIXcR9S7WUCgD5s0nz7gatCPSUcWRtMFYB3fMrI7C+s=
X-Gm-Gg: AeBDiesVbFrDAcaG6YYkUmNuh8DNUn34mEUQmtTEknF1dBVoVZ0ZKHYdCNvF2Je9/15
	kuBYhxdOPNQslMfZPVorAXZzAfkSZyn1PKgwJUdiUJdPDrOV3JgSWYTp7VtklqhWtk/2Hrx1CZc
	r41v2F3kN+tK0I43R/Ln/PY/3fZI3UpgE1tUSx+M7SMxuIpvpS2Qbpt9y9cUYU0tMs7YSl6HT/7
	f0Wdu9AV3vsKPdtD2wQv0p6mwq0tgjctUX8OBn9eCPD3v/+ZUz40ijzF+Xl2SxbY9RzITBh8ioQ
	InBRuUQBGIPZw4E/A9TZprJMg67EKeLuhB6dZ2i+BLflawO3NAUl0tB29rbtyfltI4HQ8Xlkjtu
	rFrwhYA==
X-Received: by 2002:a05:6a00:a0f:b0:829:8a84:b9fc with SMTP id d2e1a72fcca58-82d0da33e8fmr15483559b3a.8.1775565885125;
        Tue, 07 Apr 2026 05:44:45 -0700 (PDT)
X-Received: by 2002:a05:6a00:a0f:b0:829:8a84:b9fc with SMTP id d2e1a72fcca58-82d0da33e8fmr15483524b3a.8.1775565884435;
        Tue, 07 Apr 2026 05:44:44 -0700 (PDT)
Received: from work ([120.60.133.76])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c3ce13sm18262551b3a.38.2026.04.07.05.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 05:44:43 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org,
        bhelgaas@google.com
Cc: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
        ntb@lists.linux.dev, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, den@valinux.co.jp, Frank.li@nxp.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: [PATCH 1/2] PCI: endpoint: pci-epf-vntb: Add check to detect 'db_count' value of 0
Date: Tue,  7 Apr 2026 18:14:20 +0530
Message-ID: <20260407124421.282766-2-mani@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260407124421.282766-1-mani@kernel.org>
References: <20260407124421.282766-1-mani@kernel.org>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDExOSBTYWx0ZWRfX6dmsBenQ1wl5
 EuTzXRvDdB7Ya7b4qgutPuve2gEwv7XvY+Jiyse3c0nJk2sQpOrqHtsmHmb3HPhG9swK2GRtAx5
 oU4mPNxYzRgMlGM8f0nVmL32p4OYjqc+m0/QzTxMPhRcvF4Rqvk0k8ZG8GTYF2TRZR/ING27eqw
 kY3a+jiZQx3owNfNPgJH/wagu5l3NldNijooSUpttEWbnQ2NhJ9TlvKQNC3xLeLEbB70AyQhbMk
 yq2mTaj3f0N4sOogXcDO9crD9dilGZWeVCXOYm951Uv6m2lXkqQguMKu3UHwsUXusDN3g8h3+Uj
 UMFesoshjUhSGOr+05mXAcJjPBDvSp1PfdJzJHM4V1j+r0ameTazP6Ctwq9RLrPFUW7PPlLcbz5
 UwWD1GA0tz8kQDI/Ciyhx0Khc7q8NfKMRGxWp+0Cloeya6OA5ijjD36Q44z5L7XLFjhkQ5iJzuE
 3J3BDoMIWZfMNM4ia3A==
X-Proofpoint-GUID: zWxEx2dadflQQf14j6u1Dtk9fPUBYZcs
X-Authority-Analysis: v=2.4 cv=XPUAjwhE c=1 sm=1 tr=0 ts=69d4fc3e cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=yDxY/ZQAnAaCL67VaoekCQ==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=PxpW6Q19wR3HJFGb5M4A:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: zWxEx2dadflQQf14j6u1Dtk9fPUBYZcs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604070119

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

epf_ntb::db_count value should be within 1 to MAX_DB_COUNT. Current code
only checks for the upper bound, while the lower bound is unchecked. This
can cause a lot of issues in the driver if the user passes 'db_count' as 0.

So add a check for 0 also. While at it, remove the redundant 'db_count'
assignment.

Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 2256c3062b1a..3d30aa4dbb84 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -483,7 +483,6 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
 {
 	const struct pci_epc_features *epc_features;
 	struct device *dev;
-	u32 db_count;
 	int ret;
 
 	dev = &ntb->epf->dev;
@@ -495,14 +494,12 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
 		return -EINVAL;
 	}
 
-	db_count = ntb->db_count;
-	if (db_count > MAX_DB_COUNT) {
-		dev_err(dev, "DB count cannot be more than %d\n", MAX_DB_COUNT);
+	if (!ntb->db_count || ntb->db_count > MAX_DB_COUNT) {
+		dev_err(dev, "DB count %d out of range (1 - %d)\n",
+			ntb->db_count, MAX_DB_COUNT);
 		return -EINVAL;
 	}
 
-	ntb->db_count = db_count;
-
 	if (epc_features->msi_capable) {
 		ret = pci_epc_set_msi(ntb->epf->epc,
 				      ntb->epf->func_no,
-- 
2.51.0

