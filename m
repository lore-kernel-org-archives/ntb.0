Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E08344029
	for <ntb@lists.linux.dev>; Thu, 30 Apr 2026 16:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777566001; cv=none; b=B9u++qXG2JM0NmFxqi/7Y4DEB6dDdOaEUElwZ9Jcbq+NOHtcTTiS9l2Jssbl5JvAmF36K14MH/+5LC6TtbohTaNPkbOSwYZd9sxMlkZZcfIOSpfVx6I39fqoV/mHZOg6o4tsZj6uwUgxs1VPxdB0v14HZb5FopKBwMu1Dn6AI58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777566001; c=relaxed/simple;
	bh=sYVEglhh1iNm/BMu0UD0diZ0ucnq+TS0soaXV9m6kys=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WptOb7bNMO9GS1kYirppr6XoW6TjhQ81VFthvHCTdIA2FMQWP//Y5YqV45mUE2rf9UywcGmDvyi742mrUdwXmITIP3l3zR1tQrcfXbGtADf78AOz9EIfxuAlqGHdthlOT0dupGxHSszd8fRVYhwV2u1ToZe6jf+wjOLD7UORyWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FJRkdYRO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WxFSwPr8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FJRkdYRO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WxFSwPr8"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63UGIf9E2121878
	for <ntb@lists.linux.dev>; Thu, 30 Apr 2026 16:19:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YadfwvcJLiyVkEHkRErYP1Ha9ZLse3Zysh7HV7GA6cE=; b=FJRkdYROQK43/dZ4
	ZdKz50DvoKZi98DqINCmYbGARyUo4QNDkhq68QMQcrvwKH9G6y9lWezq9+T7KIYG
	/kyzJNp386OZUpQnxVxlHTqhn2ftUQ+D/+ILBy2JCCBamNRq2K54T2Zd+etBnekw
	YJzL+0tTH6UjpNTg6utS9QRl89DANtMh7JmV9ycWvECVxcGB+djRSauYIkg2kOH7
	ttKCWO9xaxv6QqRN0bqeTS8PqCMGnUrYd7JyevlIfwWvICpXam72hjfTOz/FGuQY
	5oved+wqltXguoD6QQe88COzTD7kT31mN6Xvhvd/YbrzGb6IGdYN7IjNilpATLH7
	x5YP6A==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dvag4r075-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ntb@lists.linux.dev>; Thu, 30 Apr 2026 16:19:59 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b249541063so11092415ad.3
        for <ntb@lists.linux.dev>; Thu, 30 Apr 2026 09:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777565999; x=1778170799; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YadfwvcJLiyVkEHkRErYP1Ha9ZLse3Zysh7HV7GA6cE=;
        b=WxFSwPr8LVU6qyA4uKf0fo4kxzTXxV9hmx74oXxP+7NlS6dy1g9/i1ytPcyb9fGMvS
         9N93Enzz9JtUgbWskoARlbxU7j1Ega6Gp3tDYq/5831st9g4oWO+dsPDjVRE4SmyVbxZ
         rTQmU/r7o+kXMH+fHPPpG2G19ckOF/BMKRqgzGg9H9h950EqqXICskgVNfmeONoyRjGD
         mgiHfzutdrbmDgTvo/cv97+zS+EKzg2y1cOYY6pLAAEoKKPIf0QRf9Fz6sqmZgyddsMP
         Fo0sidZQstfoJZ+j43fe6nk/ONI3eWifNVjq+OV0J+DKyHP+jAFD0j6IInTYhXujGZrZ
         YRbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777565999; x=1778170799;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YadfwvcJLiyVkEHkRErYP1Ha9ZLse3Zysh7HV7GA6cE=;
        b=KV+8XYa4RFnhV5b3Ii2oG4xiBVjP6tSXdNWNaYHyAaLN6glSCZFWkt+giRhJgUHJlL
         nfEpn/s/tXIdOrM5DDJ6ZatBmlhLn7R8w81lQi6Qyl/cwec/Qh1dvb/0WcnCG0p53Ge2
         x1nKN/nHl8f9/cDQyErGuexh811pbcWMFVzGJ40mLFf0pE4SKeQ/0jTtf+FpUVLIbyr6
         kn3uGWRmUM+hOHbZaYTCzmLgHrISbgpV9uBBgwSvbUcM/GiRsBOzMuAjeDKBli2s1zVZ
         h0hC9l3/44pfIVBxdX7jQOuqZbHWyMcYDm7Jk3QmoMPPVtGX5NNYhb9Z4PB4YPFbS4p3
         l3Kw==
X-Forwarded-Encrypted: i=1; AFNElJ/TKxNYvEbw2MpllHNurF+t6LQmWRusYLA6j3k8rdv1SSgxu1fRt+wu1dIxuSoX9/SmsIE=@lists.linux.dev
X-Gm-Message-State: AOJu0YxgrNUk9pr/yI0OPS3ayq7egEVeXJ+utrVatz6I0D439u04Oein
	pabN0pYSBS3ysFOH9TCDCOm3h9W1IRhHMN4KKYRRYrqeuhxfxjCpoo27CsmSAUfyQLsqmu78vnZ
	g2Mp8+LeXj+M/pKM6LM6GVHiczPE6KxpDjEFwax7bweCBb+4zEx6LlSA=
X-Gm-Gg: AeBDievBUcLY3vGImIDwY22DRurVOpjKqvHk0cS/BJOYLdhUgcmf76+AQXW7PhDzKkj
	L5qAGGHzNiVjtpImuL6fycWZu9MtXy56ADSgJhHsbwSA68b5FXLO+JW3kzYKX5q0znrkq5GZWcm
	/qVMpvOponN4zHMeecvxi8Fe9UgKScro+5rFAootKY2LmADN51CqI3wSVHGRp/Nz3z7ayWHjlyh
	w9xUuGiKaCv2WFNOvwfv+jBIqBlupUHGPSsu7J7sz7cNw3c/jmnAuv88HA6gny7TEGkz5Ji+/3v
	qhr0NJEizLc5cJ81SJeuLL9Tca1nw6AKdkU33P1KtACUTrzLCfEGEArJcbmprqZZ8S8SKypb4uT
	Ce0ScRcaxFP/NKIOyHF2OQhvvt2UCG1Q=
X-Received: by 2002:a17:903:32c3:b0:2b7:af0e:5942 with SMTP id d9443c01a7336-2b9a24c3051mr39358745ad.26.1777565998840;
        Thu, 30 Apr 2026 09:19:58 -0700 (PDT)
X-Received: by 2002:a17:903:32c3:b0:2b7:af0e:5942 with SMTP id d9443c01a7336-2b9a24c3051mr39358365ad.26.1777565998155;
        Thu, 30 Apr 2026 09:19:58 -0700 (PDT)
Received: from [192.168.1.102] ([120.60.79.134])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9caaae66fsm1010505ad.21.2026.04.30.09.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 09:19:57 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, Niklas Cassel <cassel@kernel.org>,
        Frank Li <Frank.Li@nxp.com>,
        Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>,
        Marco Crivellari <marco.crivellari@suse.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        Koichiro Den <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntb@lists.linux.dev
In-Reply-To: <20260414141514.1341429-1-den@valinux.co.jp>
References: <20260414141514.1341429-1-den@valinux.co.jp>
Subject: Re: [PATCH v14 0/7] PCI: endpoint: pci-ep-msi: Add embedded
 doorbell fallback
Message-Id: <177756599206.13537.12194903673950530578.b4-ty@b4>
Date: Thu, 30 Apr 2026 21:49:52 +0530
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Proofpoint-GUID: Jl1yud9_-qcj9ERX6SvWyslY2jfku1MD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDE2OSBTYWx0ZWRfX2sRQXh+L1A65
 l53YbBbvSHt1VWSDSzEJlXtW+0I9HHzwj3gPQOTrweBn1ZvshfqcxJmBrnvOI4NxfBzumaVP3Ze
 SH4srKRt88d45eNP4dPcx46Ylyc+XuLAk6bftPT07Ygo7/oNtfnG0vaEfa1T8o+HWZzGzQiutAK
 47rWkRcpa1Ydt86KQEhs0Yh4g7f5lmtgX09wYrM+PY7Qatc2Ze1MfBsEEwcaY7vQBHfKrWcEJ9T
 QqDgZ22cNkIUjv1OM3k44chk5Nddt25czRmaxu0AI/XNPg080x0hYU6iUVsR88gvW/cu86ZkNes
 2BAuR0AsDErNbLK1lcDf7GWn+EyavqRPH5lO4JKefW2uFq3SVkUy422ipETR/UoVpCJPiI09RL1
 YHc/5ek1aDuMOU7qiGfvM/m6igYPYcFH/W3UzncM9a61ijZPnsTDCosN2sIoFEBqjiDqgmQ8w5y
 91ef3DH9yS0RALtqsqA==
X-Authority-Analysis: v=2.4 cv=UcxhjqSN c=1 sm=1 tr=0 ts=69f3812f cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=o+EpXNgM47EhA9by2x1l3w==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=nuIBDirHvEWTY3k0occA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: Jl1yud9_-qcj9ERX6SvWyslY2jfku1MD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 impostorscore=0 adultscore=0 spamscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300169


On Tue, 14 Apr 2026 23:15:07 +0900, Koichiro Den wrote:
> Some endpoint platforms cannot use a GIC ITS-backed MSI domain for
> EP-side doorbells. In those cases, endpoint function (EPF) drivers
> cannot provide a doorbell to the root complex (RC), and features such as
> vNTB may fall back to polling with significantly higher latency.
> 
> This series adds an alternate doorbell backend based on the PCIe
> endpoint controller (EPC)'s integrated eDMA interrupt-emulation feature.
> The RC rings the doorbell by doing a single 32-bit MMIO write to an eDMA
> doorbell location exposed in a BAR window. The EP side receives a Linux
> IRQ that EPF drivers can use as a doorbell interrupt, without relying on
> MSI message writes reaching the ITS.
> 
> [...]

Applied, thanks!

[1/7] PCI: endpoint: Add auxiliary resource query API
      commit: cc07b903a646bf6592182b27c63457d92f128125
[2/7] PCI: dwc: Record integrated eDMA register window
      commit: bfb9502651f689c338ba3e8aeb07d31c46e0cdf6
[3/7] PCI: dwc: ep: Expose integrated eDMA resources via EPC aux-resource API
      commit: ec2075cfc629eed09d8865621be76ff2197781d6
[4/7] PCI: endpoint: pci-ep-msi: Refactor doorbell allocation for new backends
      commit: a3a079e5c5b7748f206c4baeb92593f9eca3184a
[5/7] PCI: endpoint: pci-epf-vntb: Reuse pre-exposed doorbells and IRQ flags
      commit: a70c53234f593bfa6d137b50dd49efe0cb49db87
[6/7] PCI: endpoint: pci-epf-test: Reuse pre-exposed doorbell targets
      commit: 5fd41dbd2ddc3607988fabc4836af1c9a2abe344
[7/7] PCI: endpoint: pci-ep-msi: Add embedded doorbell fallback
      commit: 2071d513cc9b68633138c9b8deab35e32e4c0fd3

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

