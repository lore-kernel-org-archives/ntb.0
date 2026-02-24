Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F2F376BC6
	for <ntb@lists.linux.dev>; Tue, 24 Feb 2026 10:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771928514; cv=none; b=Re0KYlKTFxoK9NgNldDpZZc9NT1dGGjzJzwRANRAbuRYg1ZANAtjuzKr+znqs3g0Cy0GEFCFY2KUfy4ErkfCpcrCb+XPR9ojjtN0hhGIWmhcCtiY3GWFAIMl4rNdtvIk+yM4IX6w/XTbRNgpg0QyujZxqcCZiQGpUGj5uaD0WaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771928514; c=relaxed/simple;
	bh=uEjYZ/XehFsqLbbpv0XnDNLQoZ+JPk8zSm65y7wR6G8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tkSPVMhBMVUyf9u3TI7ssY4jKsyp93V04j2QgOhfSMDETOy21HV358/FZtT2uw4Impde1lVZMehxHhWvWCi2w4VuVDWCDyufs/IKxClcYI+YBVealRTs27Q2LGVbGHsMEbYZuRN6RR517PQ0a8w5jCw0hTMuqcfrc2PjeIL2e+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IU7LbsuO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cVM/hnz2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IU7LbsuO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cVM/hnz2"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61OAFSTd2774555
	for <ntb@lists.linux.dev>; Tue, 24 Feb 2026 10:21:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vnZs9JLORsd3/5S5l0NT2vH/Yh64RNDPIyuOJI1p4h8=; b=IU7LbsuOrDD0PFAB
	Hmq6GZNfa5uFbdwXz0+W7DLjsr/PtH4fDxLfiliBo5fK9xXU9TW1IpW5u2ZsCDQV
	59hm/J4BsayGqnzAJN2c6v4Gtd+6pB1y8uFPofRfMDNccp//pIxsX8Hq86ND6mFt
	llk06gYY1kgC5oGitRxUJR08iVNU5YIKmbp8E1BrMoaswSvlk6hhuOUxvz2Zg1A+
	cA8MVAtyeJZaTbbg362rUuMt8Q1gV6ZdZCQeYMKrQtKP5BfpyT11B6GZbDe1nvK8
	SJYBgeBc9iExryVKvWLd7LsPpKn0THyWI2Kn1oEgnK8XeV6JlV4+SGE11qHXybr6
	C/hT7Q==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgr69katf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ntb@lists.linux.dev>; Tue, 24 Feb 2026 10:21:52 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-358f42fad0bso446967a91.0
        for <ntb@lists.linux.dev>; Tue, 24 Feb 2026 02:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771928512; x=1772533312; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vnZs9JLORsd3/5S5l0NT2vH/Yh64RNDPIyuOJI1p4h8=;
        b=cVM/hnz28hNgUTHYSxFdOc3XuWToMlhEd0zoF5I1gihXRyEUf97GCBJsKm2fUk87JQ
         eO9Ur/DO/tzDXEfXLvrBQDGNlHEd0jgBqkUQabxK9jkZRXBunqKzCTw9yeVGITt98LCx
         UtmoUu9DKedS1y3hwnhfTq+VlHtefSTvxDzIO0/ooQP93c8wO8mW6MRvl/WGObwUiKDW
         uvWv0MBFMpMgFUSEM8KDiW+Mb2UCIqbpq4gwPVDDE34x818bQjD9l9QC1uHN8DEnazcA
         l1GUip8DhmnONb4odn0l4xvTqD6uxo8V1RI6dM+E+/ZRi4KmydmoNIuqs16LNHMqCAuz
         wETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771928512; x=1772533312;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vnZs9JLORsd3/5S5l0NT2vH/Yh64RNDPIyuOJI1p4h8=;
        b=iypRvyOTw9/A2Ri0yqJS08aMVFcA0GFTA3sIy8SRIkzzVts2mvRVf6+ZPDDb7SWj9O
         +fRp4cG7us1588e9Kzy+5k4iMG7U9LS8gK/Pjpdhu+Umc3xSdSVASllp3YGDOmbIzNpF
         YCvFT355Q/qtVXg/pBLXKAoFeG6haqQvdgEi2HVTzKvhjyNqjKSD7nBPAMthNC9KKq67
         AmZuGmY+ih6z1p4cl8HsmjCXoZGxVRunxzbsDj3/sdfiEMi9fP3I5oa3Vclj701vTase
         K7zElDvEdjgA//ZT+JAqpVitTF79kkzD6N32G7D62qm5Vrcy4HjnCmrFm/ps182GWg/J
         NZJA==
X-Forwarded-Encrypted: i=1; AJvYcCV1tvruKq1QnkVLKW7buTcPeMC37KvV4jmPK85+Cp5xeXjmHBUEDav/VeOotVCMMfHg3Pc=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz/jhomObYiDGSqeYQlMuTNqGtwiSqdKSR7u720ps6+P+gl1Y/g
	UvfAOdpYVLE2mExKR5ONdC2so0RsvTturde8F0l3ByN0yNdcAwgxJujcH1J3uCiAXEDtXXvKpgW
	8vd8MXUjdpQ1JkTaoWlUBLNPHIkZwP3o5klMVE6AMc6IVzVcMiNnIrfw=
X-Gm-Gg: ATEYQzxO0nAH28WO/aMgROQSqg29NdCQgq95s5uQiggVWN+C2inWHb1AlOax/Pz/KnA
	Zqbq3exk0gYdDs85BAoVDV2ObkcuzbkzxbeC9evtuFtdv+R1yWfp6EHlpX1gj9qCnGscZvITIBB
	6OxCQn8L4AAyO+XFFPK1Q8kp86+3YS2f9Uc/JdpXDobfmM13+xFCDe4kdtj0ngB00x0xczN/uTb
	L/Xn1qXHHuWMHa3CFMAXyghGW1avhqiTzn+J6fCY++weXX9tv4lkPZ+yFOorTujm5uqvX99tVRH
	DF42KDhp4NTk4VKRjHIdCX02XtvUgSVHyXBmP/zIhLzzRutvgHR1hWhw/KZUBVFNqrF4ut05FjW
	nNGqJZdOs5QeqzzoMk4oaGTA=
X-Received: by 2002:a17:90b:4d11:b0:32e:a5ae:d00 with SMTP id 98e67ed59e1d1-358ae804f90mr10156753a91.13.1771928511830;
        Tue, 24 Feb 2026 02:21:51 -0800 (PST)
X-Received: by 2002:a17:90b:4d11:b0:32e:a5ae:d00 with SMTP id 98e67ed59e1d1-358ae804f90mr10156733a91.13.1771928511229;
        Tue, 24 Feb 2026 02:21:51 -0800 (PST)
Received: from [192.168.1.2] ([2401:4900:8fe5:3076:bc82:a67f:ae4a:6d25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-358af701c7bsm9605940a91.1.2026.02.24.02.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 02:21:50 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com,
        jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
        cassel@kernel.org, Frank.Li@nxp.com, Koichiro Den <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntb@lists.linux.dev
In-Reply-To: <20260217063856.3759713-1-den@valinux.co.jp>
References: <20260217063856.3759713-1-den@valinux.co.jp>
Subject: Re: [PATCH v2 0/3] PCI: endpoint: Doorbell-related fixes
Message-Id: <177192850650.7284.5708606131647741554.b4-ty@kernel.org>
Date: Tue, 24 Feb 2026 15:51:46 +0530
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=O6A0fR9W c=1 sm=1 tr=0 ts=699d7bc0 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=GccvDg418-FT051PfnEA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: dk4i9IPlawFbr2BC2HmTc8lf8IxAfRD4
X-Proofpoint-GUID: dk4i9IPlawFbr2BC2HmTc8lf8IxAfRD4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDA4NSBTYWx0ZWRfX8rh5Js5CISMo
 yTmBobYLsX+LokFugme57wiRC/VhaX9WrwBI0YeqFu/wpvv4EYEvoHOmFA681hQL8VJXWqj4noL
 vqQ3edrLsowLLzheWQlXZi115xzQDlzuzREdBY2XRqeGQA3vgloPZu4cpXDKEPlGFHyRXTd90FO
 X6NsfL1qd2KlvPLTOa03KkP6L8tqneQipsXbT5uIZMZ3rT45UGrp9CsyYNyp7hE7xT09vrj1o1g
 40cd5Thd4IsNvIfN7ANBysJ9bPqbduFvtiodFtN8bYjSZmGj4niYSnoPbEqbbzdRYSdFKHjy3E3
 dYV3R2yd6x9hl5MWBRQbjnqfy3AeDtl8X4uDhl2/QOAP0xGJdDXk4skVjxj1bvNZAT/22tEpIOm
 0oHC23ttzn3pGeSmymE8RIa3nmXQ2vI/IwhegSgIvm9i4FD2+QTZKmOgtqN4ABLzCWJWKRqC7TS
 4HgZDA4nSZ93gcCENlw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_01,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602240085


On Tue, 17 Feb 2026 15:38:53 +0900, Koichiro Den wrote:
> This is a small fix-only series related to the previous (v6)
> doorbell-related series:
> https://lore.kernel.org/linux-pci/20260209125316.2132589-1-den@valinux.co.jp/
> 
> These patches address a few independent fixes in pci-epf-vntb,
> pci-epf-test and pci-ep-msi:
> 
> [...]

Applied, thanks!

[1/3] PCI: endpoint: pci-epf-vntb: Fix MSI doorbell IRQ unwind
      commit: d61ad1bf4cd447f023eaf801dd836ce2c8d579dc
[2/3] PCI: endpoint: pci-epf-test: Don't free doorbell IRQ unless requested
      commit: 18b1650d6850040ebe7612504b9cf5e86dd48d84
[3/3] PCI: endpoint: pci-ep-msi: Fix error unwind and prevent double alloc
      commit: 53f49de2df2790db085d1ddf3a2251fd7b1d960b

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

