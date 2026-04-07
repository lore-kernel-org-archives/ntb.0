Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CC33B3C18
	for <ntb@lists.linux.dev>; Tue,  7 Apr 2026 12:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775565893; cv=none; b=UHoJL/MMnznrF3Je0dng0J5vKP4+2yCLkls4442h77Gl5R0SGrg2KhjILw5Jw3CrI8yQJ0ebW791jQ/yJFDKMac6w0pb7yvxpAaksvrk9VZOSroT9t0qv9PFmuK6I553B1nz+xDPXQ5gxBpzM5m3oDnnsu0kzq+UwWhyKjHVfjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775565893; c=relaxed/simple;
	bh=6vOJo8cFxGIBGsgdZ72PCKdeMVx3dnSGChMlP1LRF/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OffDwrq0feeuyvq/xrOdledbnbaAHOl3+lq94LfLesfLp1aCPftpQdsBFkKMdhR5ZVSg/ZXVaxtNZbHg0ZHz0megVitNqyM3g69OBe3fdxujEwCIYplOp8x73U5YZH81nisxspKm/D8ruNMntbGwsevi4uv0UprrKEJgXgrDq8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CBBMQ8Yx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hdrwt+Ew; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CBBMQ8Yx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hdrwt+Ew"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6376ifjj2580486
	for <ntb@lists.linux.dev>; Tue, 7 Apr 2026 12:44:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=+McTs62jXEi
	G+U6yhLRFrie/mtKMh+Q9ylHrEG5OPXc=; b=CBBMQ8YxfOv+T/jzRRSo2B18sd1
	m9Wb5pVeCQi6kxLETjsFqcZHFe/DR6BbDk+nLiHhG9LlQ3wPL5w/4nGNGgpo9gWz
	hv1UeTtbJaoLSZlDCnyQRYSmBRejyqumEgPjHYVHXNOETM+/UdBLsWCg3EonNT1Y
	0Imt7UuvQC6MNkcgnoBHxWpr7ybgPCgPYFuIax4tNUqJBcPMXyvqeZcTR9EEaUA5
	3HJZ/wMbYetGZ1lUNvs67RVr8Vm9cOXWs0syyhsJCuYUBzxsfjMpX8jNWZD4LfPP
	yEE1EGrkJZazM35Hw9omJJHdLPPoebNt5SPPmGaniBvGL7q5WmZ4/Z7jVkA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmsf2rjt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ntb@lists.linux.dev>; Tue, 07 Apr 2026 12:44:51 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b6097ca315bso8026653a12.3
        for <ntb@lists.linux.dev>; Tue, 07 Apr 2026 05:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775565890; x=1776170690; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+McTs62jXEiG+U6yhLRFrie/mtKMh+Q9ylHrEG5OPXc=;
        b=hdrwt+EwgzhqYqCUukaXSWz99bkWyBo8OslNzJuPN9u2F0+n54PyxUROYa9wAl8geV
         1O8ND4Qr+fmF+I0wEgCkIXeYbQVXGHgmxYiKJF0CI8zlDYmIAsIF7qTv99jkC9/XAgWu
         M3RHb4vXyB1aBCt57Parw3oWhHoqg1gJl3+8QOkGNU3shuYfo5jLS8TW0cl6/JuRo+gj
         NAi2mylVOrDgZXpjKYm1isJgeC5U/bh1Q7iNLDLUYc/ELeRAHFhunKJOfXsd4m3PpTDw
         29+d3enXtodvCBYx1Kl4r4nq7cDUoepnDveaoKCwUGGFMQFoiC+eGSemMGNPH6Wvf/WV
         qJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775565890; x=1776170690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+McTs62jXEiG+U6yhLRFrie/mtKMh+Q9ylHrEG5OPXc=;
        b=J69vX1lARNyJMT/k49a17C1Pe1U56jny70tsMZXwZFaECFPxU/8oArLsepYAa43hMq
         gcJkLImDT1gn3VcX7sX63ArLXMXgVFAD10lj7Z/Baqqzo64qMoGOckBrkUJ58ynfnlTD
         kOPQ99bKDyBv1lLtqRXb55rOKHHwrkrYA/tg/acLIZDYMcRj/FYo2UG8rdKputoiUJI9
         ajjAGsGIQcwsG4C28bSTNEE59oQM1ZwNSY4xfOOqIzJ8/kIAg+vUtALBHsFJsKpdp7ji
         BzoM12mc+XVzQoeuWE2/u/1EiRzE5fUo90jhYmaBgSDJqOICO9y4HoZwdIOYORToxYza
         nHRA==
X-Forwarded-Encrypted: i=1; AJvYcCVU3xeUBlzSOqKa/VGfs0yKdZ3mzpygngCulRpceFMCmdJoGtHI5C5uI/xAmdxMwjp+KeI=@lists.linux.dev
X-Gm-Message-State: AOJu0YwSsNfEQC98SJROu4yY9KJpOdJZn1K32yoD2lAw+aKggkUwZsia
	tZiTIlLXVf//Y095AwWiJMYKDwi9BxwcnFgFPIRDPwEQR8d+6Bvk4ZE9qRP39RiWGYwpt5NA7aH
	Zti+hzX4pErcJ1YuZOQu7NcnqhnOXp33HaXB8gwZw05HlCJHzuWfGjdU=
X-Gm-Gg: AeBDievnXKsnfkHx45iLhQ3EuU/WkotkFrg3zUME2b3rEwxN5Rm+785kej3/3+Wg/69
	oEUZp+Hkln80ESeBdvxQxNyNIr5X5u/JFvx8avwJg/cZN8MlS70bBmJnEK05jTJNNKfKZ4WR5Cj
	w5IXKu19yStlyNNyKeKakJ4DnafFsRX73jNpndKTYEOu9Wi6Z9QxS3FwmKx34FyHxH81t1Rp/9P
	06haNOl7KAdlpQeRQhHNnYO5k36CejfRPx1a2sCdPApwgnVwqG2+9Ec4yGO8yuNnQuEPEMOCYJZ
	6D2YoViVgUFfQyKeOoCKqrg+hdrK1zkBr2LGzEw8SKp9dlyRs3t2OnhW4/FKrcC85XEtQp8Nu80
	TUe5n8Q==
X-Received: by 2002:a05:6a00:451b:b0:829:9c5d:4342 with SMTP id d2e1a72fcca58-82d0dbdeb04mr16110999b3a.54.1775565890141;
        Tue, 07 Apr 2026 05:44:50 -0700 (PDT)
X-Received: by 2002:a05:6a00:451b:b0:829:9c5d:4342 with SMTP id d2e1a72fcca58-82d0dbdeb04mr16110973b3a.54.1775565889440;
        Tue, 07 Apr 2026 05:44:49 -0700 (PDT)
Received: from work ([120.60.133.76])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c3ce13sm18262551b3a.38.2026.04.07.05.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 05:44:48 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org,
        bhelgaas@google.com
Cc: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
        ntb@lists.linux.dev, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, den@valinux.co.jp, Frank.li@nxp.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: [PATCH 2/2] PCI: endpoint: pci-epf-ntb: Add check to detect 'db_count' value of 0
Date: Tue,  7 Apr 2026 18:14:21 +0530
Message-ID: <20260407124421.282766-3-mani@kernel.org>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDExOSBTYWx0ZWRfX3eMKxqEOZnzG
 /9uSXvLyV/AzWqpjgsDY945FjtISMSRvfk7yyUm9ul5UerQpGU7qv1FUBvaM5BUVgaMuYgSLv4J
 fFZjD9L0iVG56r7IINc0ndd1tJVGeeoOH9PRtHFy2qjJG60Ji/qx3RGoTwNd5Z73kZPRlox1Wy1
 hXwLgO1M/M0D+j+65PpYkQfS1vR7BaLZujCYHa3ghZHHBhJxlWWwFQ7Xgd2w4IYk744PQJp3qLR
 leuwbjOw/UH/cmd2Zcqy/QII6UsO4HJHeMlnfVAnV2A+RPPvKQzK9nsFyoI6cmccJztaonikUm6
 6xsdfyXAwq11ksEcJDAnvUchk96UKGKHfugZCuhx9JOK9LNzHpVJj/tf0QvhMftCGUkJIjT+X9+
 6wk5hxYO54e7w2wqqxJv2J57uZVs6s3Q3ntFYEBpfRkJ3PVrMkpDNA2CsQMekdL3/CUy48UYaQo
 f0PUJ6ZNE87mzvo4Tig==
X-Proofpoint-ORIG-GUID: DN4rL3WxtjoisindtzMGa0AMB2xzquzu
X-Proofpoint-GUID: DN4rL3WxtjoisindtzMGa0AMB2xzquzu
X-Authority-Analysis: v=2.4 cv=DcInbPtW c=1 sm=1 tr=0 ts=69d4fc43 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=yDxY/ZQAnAaCL67VaoekCQ==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=PxpW6Q19wR3HJFGb5M4A:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 spamscore=0 phishscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604070119

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

epf_ntb::db_count value should be within 1 to MAX_DB_COUNT. Current code
only checks for the upper bound, while the lower bound is unchecked. This
can cause a lot of issues in the driver if the user passes 'db_count' as 0.

So add a check for 0 also. While at it, remove the redundant 'db_count'
assignment.

Fixes: 8b821cf76150 ("PCI: endpoint: Add EP function driver to provide NTB functionality")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/endpoint/functions/pci-epf-ntb.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-ntb.c b/drivers/pci/endpoint/functions/pci-epf-ntb.c
index 2bdcc35b652c..7edd177f861f 100644
--- a/drivers/pci/endpoint/functions/pci-epf-ntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-ntb.c
@@ -559,12 +559,15 @@ static int epf_ntb_configure_db(struct epf_ntb *ntb,
 	struct pci_epc *epc;
 	int ret;
 
-	if (db_count > MAX_DB_COUNT)
-		return -EINVAL;
-
 	ntb_epc = ntb->epc[type];
 	epc = ntb_epc->epc;
 
+	if (!db_count || db_count > MAX_DB_COUNT) {
+		dev_err(&epc->dev, "DB count %d out of range (1 - %d)\n",
+			db_count, MAX_DB_COUNT);
+		return -EINVAL;
+	}
+
 	if (msix)
 		ret = epf_ntb_configure_msix(ntb, type, db_count);
 	else
@@ -1297,12 +1300,12 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb,
 	vfunc_no = ntb_epc->vfunc_no;
 
 	db_count = ntb->db_count;
-	if (db_count > MAX_DB_COUNT) {
-		dev_err(dev, "DB count cannot be more than %d\n", MAX_DB_COUNT);
+	if (!db_count || db_count > MAX_DB_COUNT) {
+		dev_err(dev, "DB count %d out of range (1 - %d)\n",
+			db_count, MAX_DB_COUNT);
 		return -EINVAL;
 	}
 
-	ntb->db_count = db_count;
 	epc = ntb_epc->epc;
 
 	if (msi_capable) {
-- 
2.51.0

