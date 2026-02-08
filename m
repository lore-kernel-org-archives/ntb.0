Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEAE946A
	for <ntb@lists.linux.dev>; Sun,  8 Feb 2026 16:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770569359; cv=none; b=hxM4rjfdlqU7ORxektQpalv5XIoN9acKECfQ8FxuAuWvOOZckMARIJ26CHuIQyNpRBbXilU8aZnmr8FKwZ7z3fKYkrbQdgH3Ov8nOS0JjPNALlXyrlbSAdzLl+X4QeYgCTzbZ50aQw1W27aL8oFTss8//fsWeMaKwD6ht62b28A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770569359; c=relaxed/simple;
	bh=8XHzIx0yTGMkri5WdILEXTbmjdUJdrdKd99C60B/nKo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nw4QhSEufeJnSaAD4jAlo0UNX6c1iZnaVhNLbKGbgebhgvK2K5CSnvxrHrj7umuTfd55FJRRzl7dIEifTyFlU6ObNb5cKEXgcXa2bQZRDyGnJ1EYR1eDy2PpuMhL26xibC6GrWloedhHp+NFq4W61pJ/aJQLEhj+wY15hGJR84I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=a0PeRVnM; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a0PeRVnM"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 618G3HXx3882595;
	Sun, 8 Feb 2026 16:49:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=NngNLLJ1u18eerIX1P84PYwVb1BKd
	/WZrpGI6g56zLM=; b=a0PeRVnMO8fn8F6mtNzVwKkz4S1KyxEIlT2lTAiqy/z/U
	8CDLg9EqfqRUOYEt+XwRYXVoUMxU5y2GVc6L3jBDPxf48DNpzMdKTzDnuYY4kePo
	4whef55ebBC8iFHemtRCb7TyoKHjVpCRyqpOMvjFN1W6cWADkTzBNcSpimNrAznE
	gs8Y6ou+mH5+l5qCL2bKZgGg1VqxrBZv1nXgXZ6QDtUJRjO9b51DSxzkYulXcv8y
	NJn1RKcshnRnZ10ouPTUKWjMSDflFr+8vnY0qS9LDIcqf5fsE+mDrI9hQ9NWUyXL
	+XN3qb9kwDT7k8L/fDPPS/uXyIjmGolADI7cTt/4A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c5xk4ryq6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 08 Feb 2026 16:49:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 618FcZBX031880;
	Sun, 8 Feb 2026 16:49:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c5uu887cu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 08 Feb 2026 16:49:06 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 618Gn5BD012605;
	Sun, 8 Feb 2026 16:49:05 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4c5uu887cc-1;
	Sun, 08 Feb 2026 16:49:05 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com, jdmason@kudzu.us,
        dave.jiang@intel.com, allenbh@gmail.com, ntb@lists.linux.dev
Cc: alok.a.tiwarilinux@gmail.com, alok.a.tiwari@oracle.com
Subject: [PATCH] ntb_hw_amd: Fix incorrect debug message in link disable path
Date: Sun,  8 Feb 2026 08:49:00 -0800
Message-ID: <20260208164902.349805-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_04,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602080145
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA4MDE0NSBTYWx0ZWRfX8XtugPhCM/xy
 6GeFxOWUXj8eiXqqtmGVqHaWA59cPaIwu9dj4GzvKC3iNxJXRkdqXFzJUZWqWM7NY2ncM/zddX2
 7kqjUPspvky86y7KQlFqUsS2iVov/2SSqMJlglCmxBj+HqV7mAR+U3lP8I/4U3ymLieNWhZ1HDO
 liXk5rjITvxYXF22g2blPUBSWjI33a/+RFL1YaWwgxxYiCnuzriakqiuTRdrx9VpN91cmJKKQDJ
 zc5U+WtnC7ZEh3YPZ99k4ovyjFiWB9psDSuLXt7qjhCP6Ru77fewTXy3yCOTKoJisot6cXUH8Y4
 TZwxm8k4Av/GeLLn8DnYYTcjQpWS7vAQV3BEmEUw8RcULqLGJxZg00bwB6ActCMS6e4Tyuz6SOC
 FOhb+FI+z6vEyddwJajFTQn7IT0jZkntRhNK6V6H9RiWr3kgLHu+FKSpijvoLRriYNmnoGC5pe7
 +dXrPaYEC2lE1RnRCQQ==
X-Proofpoint-GUID: 2nJe5YFTdHSKp1KhAKWWvXL8I4vCFhXR
X-Authority-Analysis: v=2.4 cv=ccnfb3DM c=1 sm=1 tr=0 ts=6988be83 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8 a=yhp_3V0rEs855MI0f4oA:9
X-Proofpoint-ORIG-GUID: 2nJe5YFTdHSKp1KhAKWWvXL8I4vCFhXR

amd_ntb_link_disable() prints "Enabling Link" which is misleading.
Update the message to reflect that the link is being disabled.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/ntb/hw/amd/ntb_hw_amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index 1a163596ddf5..df9150669ad3 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -376,7 +376,7 @@ static int amd_ntb_link_disable(struct ntb_dev *ntb)
 
 	if (ndev->ntb.topo == NTB_TOPO_SEC)
 		return -EINVAL;
-	dev_dbg(&ntb->pdev->dev, "Enabling Link.\n");
+	dev_dbg(&ntb->pdev->dev, "Disabling Link.\n");
 
 	return 0;
 }
-- 
2.50.1

