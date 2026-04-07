Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448AF3AA1BC
	for <ntb@lists.linux.dev>; Tue,  7 Apr 2026 12:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775565882; cv=none; b=DjrN44dISGEOphjP46xT225vJmEJkIlEfxAOWt27qB7xOQamToJ+AV3RIVOAdh8x60RlVmk1HDMbuLoxM5XoA1d5C3EmTMrI8p/GS+R5AV1bDc6LbtsQB0MGJjdTzG5GITxAQDwoQxH85CDwcslrMiHXmn22qo1Hmz/4bz1QQYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775565882; c=relaxed/simple;
	bh=3B81r1M14XQ+V5E+RnqWoEbPxyxw5JHTMY7/853xVX8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=umd/6v+WcuY7Q4VaYu/sJj2abxy59OU/KvhOH16G7KengbGqd7WEFH4jB/6T8q13SgZmM5L6S4k6Kg6FvROXiMWmg3CIq3DohC+LNHjqYVwxCmzpuCQrmbBmVqHmSCd/JFSeScLibKieilVeYEd/vFJlYCYef90qXpNPuifwTOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n6mVp4Lt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PK7Pziw/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n6mVp4Lt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PK7Pziw/"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637CTGrM2580245
	for <ntb@lists.linux.dev>; Tue, 7 Apr 2026 12:44:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=5V1zC2+FvV/denccPne23gyNwCVf6IbVkgd
	zSRYJRIg=; b=n6mVp4Lt6F1mJVa5szK/N0sT9M2HvlBsC/4xkfrUZxRSeIUDa8E
	4ac6BFgLhSsoYLogUcvC2+uZmVd0hY9Gwz4HO6agY2c0gcH75gm1AMzN8UbgrDYv
	PIiQWBswVbKBlsb76DLM5Vka9jFswQrO4ecd+9z9sRqFlb6yX5F5oClf6/79YTFJ
	UMd1fEG/MqpRmoX9UqeZQqvmgqapdA4eyxTOU+CrZlomhRrVneYg5WHxutp0PHx1
	5fIa8j9WJZ3Wld+SPXWPm1LoQRqWReFzXeL5VUSkBRc9tXQa6blNAUZgVvYmOqPh
	J4bnwbjwD+QNEC1laHowhs+7OfDoBxvT0tw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmsf2rj7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ntb@lists.linux.dev>; Tue, 07 Apr 2026 12:44:40 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c76fdf996a1so467632a12.3
        for <ntb@lists.linux.dev>; Tue, 07 Apr 2026 05:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775565879; x=1776170679; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5V1zC2+FvV/denccPne23gyNwCVf6IbVkgdzSRYJRIg=;
        b=PK7Pziw/XJ6e2YoJRWzEHXDrt2z23AIuyyicYgcwjCICyRF1KmB5xBQ1s27vyDXxsi
         Bf7q0TeAZ5mokyt39Y1Zut/jGJTLA9bxY47+8fC5RDmgnqMmIJCtw6ZYITtapUIQzvsN
         uA+fHa2nU0A26nFNuK4FteL95zbVuae2lSk8/QBNM1G+DERJoqb8JvExXPFjaTNinjA7
         uhN4B1vwRT43hOXDOnCTGyNzQL4XpJ5Cz9tEACjS4PuwedhbuEUTpUdT6AU2TCMFgmEN
         UvREIqo6Sr7TqsQ2aS/VDq0het76vIPEDgyRxSdRPVDTZu+zIo3ofvKywXTiteKl/q+t
         OtGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775565879; x=1776170679;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5V1zC2+FvV/denccPne23gyNwCVf6IbVkgdzSRYJRIg=;
        b=hv+oefUFNpj2MtWJMzeQr5jWrL5QYMVlXvtAw0KNETgytTv11LQ/gAD3Fi+GFh1cju
         WmykY2mVNVW9606Z6gMAttlwm4+WzvRYWwfPy7xttZ9f1qP6+EV/vQSc63fpZokoAH+/
         Zxr8Y6VrtgqpIbI+yBxS+E1r4klRrBpZ7K+zK6vsoS10A7QFHWSOSLAaW09VKrQHW9LI
         cF8KbJrvZ4d3ifg+GM3SOA2Oq7G/T+EQn/BPhSSSjI3jSGxcaCec5cZH4wYetSj8G+KY
         0N2/5F7eTlo7TFvBzQpdfzdNMmRiAHERL137pmSMq4iyccHrYraNrWDKJdaJrhjo8MF2
         /pcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgnQEFq1YhIZGSXMzy4kM80RJMi4aIeCOo/XILT4GORpnp1k4c8BEvfMfy/intyUexcF8=@lists.linux.dev
X-Gm-Message-State: AOJu0Ywcj30bxsFJtHhj5AllMMsPhxNUTqrrbNs1lV2r4Rf4WO0G75zs
	KQyrNEtqxqLBZ34UV15RrFLY7x5MpufygFYdZZZF7n/TAiFX1QcGphkOx6DIVZvT7ECCQ5B8m5A
	EpEG24MA3Vzg2FR+FH5u6+oNaJZUOoLxk9iuX7bCLVDvp3kHeAZvw86g=
X-Gm-Gg: AeBDiesIktFup7vPCtjH8t7vTioa3P+7MinJgG6cd9ePqUTrEsqpEYv0PkaVd8aZU14
	IixYVJ295MShEYkI2bHi/oLw5bKHhIALUul7VjUvgOP8umj+0gGGVRDvD3gptbwOpoSqQxn3hxK
	HZktYRfn2qQToholHdgWJtWAsu7h4lxCJqmah2ZPG28TjeLGNQMMVaT/1G/57eumhfkkAXXbKLc
	XVoTT9DP1CeZXqY26RMQjnd7GK7M7zkhPlK2NC7xnyLvVT1S0lpOtTANNiBMOSsZ0Sqa1pLqmiP
	MK9d6R54at12+BXYtBcyVIyaVSkndz9gYxdz9P9G6qobgbRi0bm17oxIPlw7tH5D+EQVaxJ3R/A
	e5kYLJg==
X-Received: by 2002:a05:6a00:3d13:b0:82c:e670:7691 with SMTP id d2e1a72fcca58-82d0dbbfe39mr17185864b3a.48.1775565879189;
        Tue, 07 Apr 2026 05:44:39 -0700 (PDT)
X-Received: by 2002:a05:6a00:3d13:b0:82c:e670:7691 with SMTP id d2e1a72fcca58-82d0dbbfe39mr17185821b3a.48.1775565878588;
        Tue, 07 Apr 2026 05:44:38 -0700 (PDT)
Received: from work ([120.60.133.76])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c3ce13sm18262551b3a.38.2026.04.07.05.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 05:44:37 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org,
        bhelgaas@google.com
Cc: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
        ntb@lists.linux.dev, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, den@valinux.co.jp, Frank.li@nxp.com
Subject: [PATCH 0/2] PCI: endpoint: pci-epf-{v}ntb: A couple of fixes
Date: Tue,  7 Apr 2026 18:14:19 +0530
Message-ID: <20260407124421.282766-1-mani@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDExOSBTYWx0ZWRfX8rzDk82jn5aH
 gehjO9JFaWeCElFtP3rfGVXsmGSqC3cas2P64U68ZGkwCk/W7pJFdIx1Iqcyxk/sCt+WP/sk9ey
 HUP45b2IvPQfLMmLXpoPhQhk4ww9KBW7ocTqW7hrLMdCjA5u6+ALLx3WuUu8ST9mVYI09wtS/hG
 0xJKkQq8xHFHoIQaFG39+/19+Qz6ULEGiH6X+cuVUfDbweyDYEMPTS+fuhGi7RA3Q/mAceTCnXK
 6L2ruVubCUxA+LgrmA67kwyrcqUDBIWqt3+HXHCALcxVjOF6ipNPprQBCc15QXyjuOQ7gg1RdQ0
 Nrk7pR8ed7Dyt/Ek6Bt0BTbfrUGatWYc2cNStHMGeNzrgVE2VHWSZy0XuwD8rDI+wLoCf4yXbNd
 R9XhQIiDiTvWcEAsEeiv97L320J7Hv8krYZ/t/SJRFJdJiGneSkaTNJ8078JkG+IdDLxiyC9/I2
 FXYDyQAzQd51hMiN9Nw==
X-Proofpoint-ORIG-GUID: 6HKuD7K4rMG4-4tPdxoO4V41fGfHOlgD
X-Proofpoint-GUID: 6HKuD7K4rMG4-4tPdxoO4V41fGfHOlgD
X-Authority-Analysis: v=2.4 cv=DcInbPtW c=1 sm=1 tr=0 ts=69d4fc38 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=yDxY/ZQAnAaCL67VaoekCQ==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=c92rfblmAAAA:8
 a=_0vWFD2-Lp1ycs6A3ncA:9 a=3WC7DwWrALyhR5TkjVHa:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 spamscore=0 phishscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604070119

Hi,

These two fixes are flagged by Sashiko during the review of doorbell series:
https://sashiko.dev/#/patchset/20260406155717.880246-1-den%40valinux.co.jp

Manivannan Sadhasivam (2):
  PCI: endpoint: pci-epf-vntb: Add check to detect 'db_count' value of 0
  PCI: endpoint: pci-epf-ntb: Add check to detect 'db_count' value of 0

 drivers/pci/endpoint/functions/pci-epf-ntb.c  | 15 +++++++++------
 drivers/pci/endpoint/functions/pci-epf-vntb.c |  9 +++------
 2 files changed, 12 insertions(+), 12 deletions(-)

-- 
2.51.0

