Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7A81D88D7
	for <ntb@lists.linux.dev>; Wed,  8 Apr 2026 05:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775627444; cv=none; b=SJ+w2EyYCX3E7pzDnZTgDeAu6pMDBIPqgtGDoVjKgd6En5iRFXaQwt/emGqVePrA6NGima69WYl9MZ1X2jWgNPEKsIeiOMR10wpjS9bnbHcnMFcopxi/HUO3VMR4CE2mHU8RNaV9N+0+RMHoOSXKRQgePQAVhBKR4lAq7l8NAzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775627444; c=relaxed/simple;
	bh=f9I5ocfP4gD2KPvfsebsA5McD+9QvTsVlnarXtdssR4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VLlJMMoYo7nCnKtsinUHMks3zQ3HlXm9WnVqUphdhd4EVRpr0B4UqQgyAtiYZwxuVx++yVfHfEZttQ8q666/yJdcQcsyZ4iVtCedsCwx5G4nS7+BpFRRuV/Mj41s5FFcXrOBmdUmhQFWxxqyWM76z/k1RgjbJORWQvXmi3ZRpio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ceeSW+27; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ceeSW+27"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637ILVB1172591;
	Wed, 8 Apr 2026 05:50:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=x7jb3Jao7AlMEaGr47AvSuhomhqsS
	M3P/lVzsjeL90Q=; b=ceeSW+27r4PZ7fTlKwdTYOI/Ww+8hsOcWK+tY7ixcW6BT
	kXzN06bPoW+EziHZxcoH5S2h3qKVpB+SGq1HOt0jDsPJLrUgR3mdJOsZ2DvCXsWt
	xz+k3a8LvdBmeEQTAi7zXh/xYvkiSHBRGbN2X2xttGJjs/XpCLJUvuWnPD37tZEN
	y1KaKpQTr4401YbzDGWgAR1JjfkTGiIQ+LVQw9eh3uUxgcnRrYBaMHssy7oB86eQ
	FMgRCyX83isYEfwvwWli8bysm2lm+oCTi/YVAEWJqyX8/rgmoWa9Sn18REGihg/f
	OA6SGaGnH7fKl5JAfDtYdNrLmmj0bo8eRP988Ml2Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dcmqattse-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Apr 2026 05:50:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 63841iwe011634;
	Wed, 8 Apr 2026 05:50:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4dcmnr2x8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Apr 2026 05:50:34 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 6385oYTF038755;
	Wed, 8 Apr 2026 05:50:34 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4dcmnr2x80-1;
	Wed, 08 Apr 2026 05:50:34 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: ntb@lists.linux.dev, lpieralisi@kernel.org, jdmason@kudzu.us,
        dave.jiang@intel.com, allenbh@gmail.com, bhelgaas@google.com
Cc: alok.a.tiwarilinux@gmail.com, alok.a.tiwari@oracle.com
Subject: [PATCH] NTB: epf: log teardown command failures with error code
Date: Tue,  7 Apr 2026 22:49:55 -0700
Message-ID: <20260408055002.436349-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2604010000
 definitions=main-2604080050
X-Proofpoint-ORIG-GUID: 974vri_2yAgCb7Up3gE4dPzqZS2IdFRg
X-Proofpoint-GUID: 974vri_2yAgCb7Up3gE4dPzqZS2IdFRg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDA0OSBTYWx0ZWRfX3ouCV5d930Ay
 zjez+FCWaPaOGYRIvGh5HphL13MBxfXHZEgitCKIAJ2YhZfaAdibjtV1OmTr6hkGFdVBg5zgUf2
 8kdi2UeBLBifP0iL5sQ53N7XL9gStoHWGnQmuomJGS/BKAXd1Z9BatXd7pUV6rWnNxxMrFsKyzk
 jzrUv5XOsKeMiCPBzTlk1gVTsolgR2ADlDjRukIWa+1ZZpeSZsTFlt6w5yO63KgPzYwLazzD0Tg
 F9AVFRQTva+F2Dneoat10MGnAwTaJ9MvDKqxOsMaC7Lk/tmkzyrLloumPvfcI6FK4ddUzVhowTA
 9ruHV1dPfX+HBo5Jh43qRYmCODLdZZYP5AUWQVglczwrTCiwvR47ELNNW9dzL2XimjF0rJqY6kI
 TqQbwzlVIdLX7PkSPqpBAu3iqI1fkhJS/flsq268LN5ZY39tUsf/ZuYFeaGqqLG1Ivefjx/BnU2
 y8gRHX4jYXSkYcERPyg==
X-Authority-Analysis: v=2.4 cv=NZXWEWD4 c=1 sm=1 tr=0 ts=69d5ecab cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=yPCof4ZbAAAA:8 a=Kx9IIuJfwCQkWdoxITIA:9

ntb_epf_mw_clear_trans() initializes ret to 0 and never updates it, so it
ignores failures from ntb_epf_send_command() and always returns 0.
Capture the command status, return it to the caller, and log the MW index
and error code on failure.

Fixes: 812ce2f8d14e ("NTB: Add support for EPF PCI Non-Transparent Bridge")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/ntb/hw/epf/ntb_hw_epf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index d3ecf25a5162..0c8fc459eb7a 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -438,11 +438,11 @@ static int ntb_epf_mw_clear_trans(struct ntb_dev *ntb, int pidx, int idx)
 {
 	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
 	struct device *dev = ndev->dev;
-	int ret = 0;
+	int ret;
 
-	ntb_epf_send_command(ndev, CMD_TEARDOWN_MW, idx);
+	ret = ntb_epf_send_command(ndev, CMD_TEARDOWN_MW, idx);
 	if (ret)
-		dev_err(dev, "Failed to teardown memory window\n");
+		dev_err(dev, "Failed to teardown memory window %d err %d\n", idx, ret);
 
 	return ret;
 }
-- 
2.50.1

