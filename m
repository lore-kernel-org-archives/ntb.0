Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E38539E186
	for <ntb@lists.linux.dev>; Tue, 24 Feb 2026 13:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771939885; cv=none; b=e3WnUa3YdHA94k9IOssVY3dbw3FUyLDutMOA2HC09WcLbudNDFl0okGLs+e0cAUFHgIPZejSINA50gcOIGjOoVOBMmPXaCzqovAfgwpLZq9rWv3fPUQrBzw0mNBkrimeqh5bNIQbPD6Jxjj2wmuuVEDWoDbXf2U1zMsiW1mpWlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771939885; c=relaxed/simple;
	bh=N67muGVMMaNUvFqHpwUJ9JsdLG0+JM3wXLk6t4iaMbs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JTV2wr4Yts9f+67rhLGaYhnuLDU4MW7r7zxAf/z+LosYGMiiNkUDFSlxQfXCteb1tO1MIrTPgGm1u/MMU5SwfxGAQu4md+CdSZsQ+3AUvdZ5KMlTdl/f/k/p8Yz7lgWSeFAV1FsQpCnu/PSir5hhWLGfH7WYMjBCswcGtvwVxW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gDr0hCO7; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gDr0hCO7"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NMvDHT3045656;
	Tue, 24 Feb 2026 13:31:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=eHpecezAaayEL7nPJ6sUKPgxxZIft
	H4YXT/wwzCN5qA=; b=gDr0hCO7p8ZxjPodQZjDSjJGAQaOxBGhfHQt18ypwOUp9
	t8uNkPt5/43qWcldeUIUnOjoqonZ6vQhUrTklA6GMrCh98Od/K3kWgjzJ3G9U9mQ
	46mnSIUsk9gvvBHGkFOtK0cloyK5oF3Wx19hCmEx8UIX+rVnYz4/u+Q9xpSpNN9R
	GxaurwZYZ6BSIXoOjuHN+t3aTyd4Xn/yNkFDjL5XLnEsuZLBiVrORVDLVjS6DXJP
	zsEplYguqtblTvepuTS8HjoMdu6ytNqTta6ZgbwvyD+GYOSsfhkt1KKymN7Gic5g
	hh09WR4H1ibn4TLao4rK5pfD3GhuKfFKnJedJIIJQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf4arc7c5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Feb 2026 13:31:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61ODKYsk027938;
	Tue, 24 Feb 2026 13:31:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35eqfu6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Feb 2026 13:31:16 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 61ODVFb4039292;
	Tue, 24 Feb 2026 13:31:15 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4cf35eqfte-1;
	Tue, 24 Feb 2026 13:31:15 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: den@valinux.co.jp, cassel@kernel.org, jdmason@kudzu.us,
        dave.jiang@intel.com, allenbh@gmail.com, mani@kernel.org,
        kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com,
        ntb@lists.linux.dev, linux-pci@vger.kernel.org
Cc: alok.a.tiwarilinux@gmail.com, alok.a.tiwari@oracle.com
Subject: [PATCH] PCI: endpoint: pci-epf-vntb: Check pci_epc_get_features() return value
Date: Tue, 24 Feb 2026 05:31:03 -0800
Message-ID: <20260224133112.1356612-1-alok.a.tiwari@oracle.com>
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
 definitions=2026-02-24_02,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602240110
X-Authority-Analysis: v=2.4 cv=La0xKzfi c=1 sm=1 tr=0 ts=699da825 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8 a=hFsYNecxb_C1xynCrzEA:9 cc=ntf
 awl=host:12262
X-Proofpoint-ORIG-GUID: mDqv-jb2l4P3tTo2DNatJoxUgGy6AQUQ
X-Proofpoint-GUID: mDqv-jb2l4P3tTo2DNatJoxUgGy6AQUQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDExMCBTYWx0ZWRfX7QFs0X3EPBbB
 +HDlf/ODQ3BTQhdr1mtpPc5yRlMGhvJevSelGFYYRcOlGytFFSnCvIeQE6vhVycXBVN3drO9LfR
 l0Zlc5/C7tTVUoPNfxDZ3mCa0h6nmzX4wr3oMPfRGgl3Jr3OWyuCm7aLig3vH3XrOQyxXNj3ZR2
 Evbv5pSRAA687fAghLpiRqnxYidwBUpFWmfynD7ghLpf2iJxxTDFWgtOCnjdQdnFla4DdKYWMBC
 wfJfGTAfyokOxUqpMHkZQBKlMilXtc8zb/piJP3q0q/DYJKJmAvnavCsK5pKI6BwVanx8ZOs17P
 NgzWYfDfwkLAsouzBpLJfBLnmZQ0Cc99fnyY99wif8JjygzJeK8dKLWZPft7g2BwiKcIKnKMasT
 DlMWX1HvZ4wDlR5b6haM2JJasrdzR1xpDcIQt7hoKm+NqgrNU8m3axOPKVtAplP6AZQ2q5plq6v
 C+BrrdIYMMAUAY64YwpjMAMiXr7c2W2RjalCQG+E=

pci_epc_get_features() may return NULL for invalid function numbers or
if the EPC driver does not provide feature information. Other EPF drivers
such as pci-epf-ntb.c and pci-epf-test.c already handle this case.

Add a defensive NULL check to avoid a potential NULL pointer dereference.

No functional change intended.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 20a400e83439..93943e4497a6 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -438,6 +438,8 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 	const struct pci_epc_features *epc_features = pci_epc_get_features(epf->epc,
 								epf->func_no,
 								epf->vfunc_no);
+	if (!epc_features)
+		return -EINVAL;
 	barno = ntb->epf_ntb_bar[BAR_CONFIG];
 	spad_count = ntb->spad_count;
 
@@ -489,6 +491,8 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
 	dev = &ntb->epf->dev;
 
 	epc_features = pci_epc_get_features(ntb->epf->epc, ntb->epf->func_no, ntb->epf->vfunc_no);
+	if (!epc_features)
+		return -EINVAL;
 
 	if (!(epc_features->msix_capable || epc_features->msi_capable)) {
 		dev_err(dev, "MSI or MSI-X is required for doorbell\n");
@@ -624,6 +628,8 @@ static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
 	epc_features = pci_epc_get_features(ntb->epf->epc,
 					    ntb->epf->func_no,
 					    ntb->epf->vfunc_no);
+	if (!epc_features)
+		return -EINVAL;
 	barno = ntb->epf_ntb_bar[BAR_DB];
 	epf_bar = &ntb->epf->bar[barno];
 
@@ -852,6 +858,8 @@ static int epf_ntb_init_epc_bar(struct epf_ntb *ntb)
 	num_mws = ntb->num_mws;
 	dev = &ntb->epf->dev;
 	epc_features = pci_epc_get_features(ntb->epf->epc, ntb->epf->func_no, ntb->epf->vfunc_no);
+	if (!epc_features)
+		return -EINVAL;
 
 	/* These are required BARs which are mandatory for NTB functionality */
 	for (bar = BAR_CONFIG; bar <= BAR_MW1; bar++) {
-- 
2.50.1

