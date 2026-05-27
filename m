Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E99396573
	for <ntb@lists.linux.dev>; Wed, 27 May 2026 09:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779872950; cv=none; b=QhgGvSWPYLrzNsFmBtp0ZdErenjv+KenRurzvVshz02HPPLROV7uzQMeOn4EoGhawCEVRNZAe0bfttAo9NADA9ye8SHWHLgcPxQ88qKmg2yrjQdDxHOxo3TABeNcBCQIGgMpZaWsOxdMES+jMNTYILXpFWIv4NZiY5MjCYrqY90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779872950; c=relaxed/simple;
	bh=uk+Y9McimyRzOsd0YhEs83MD/E5PV+dINoRYf5IqMR8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QByKGQ/dWjjocP4pahmKuc6Ectd2EyS6HjSKeHBeS1w66qA0MYDYbMYedN/rAzusnf+9foncUVboqsL9FUZBWbwSoz0klMDxpM3DNt//9v99yareuMdpNXUHH4/LKwJ7XI0Qq0TITAUYWzCRzBLyDjB4e43erwxeq70XYSxQaeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JK9OuhMD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QcQbaGTN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JK9OuhMD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QcQbaGTN"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64R8mS7G973111
	for <ntb@lists.linux.dev>; Wed, 27 May 2026 09:09:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pqmIsOoLyRuRIFaNUnIrGpypfnkG8bRGf2nm6VpOocU=; b=JK9OuhMDf1owPTVW
	rjFYWFnUlb0QxBTrdBd0pqcAwMBJYT+PDjkBVUp9H4Ua3bDzFCBvyzNW1NzXR4YU
	6i9PZ2XSNIDo3SpHtd1RC2qitRp1Mkt6Y5W1y93gpY4aYKujjZSHA060wt9FrcqI
	qHbrP+gtasUGC6gNPyd8DQdZZy371Mo0nLobYww0mEyQS8j3KlZJpDQA1tnQWy96
	692odr1gNiTTBNoH7NJEBFLg8TlmJthdh73cZ/HUFnAo+qSevQXNn1iFIBtBGDHX
	Pv97r6fIIAEnswhVQadGuu9SmIN8vwAeZVK7GGDAkozUkKF7cQp5fUbyEc0U2X0w
	w3J4zw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4edeff3cvu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ntb@lists.linux.dev>; Wed, 27 May 2026 09:09:08 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5104b861649so23724561cf.1
        for <ntb@lists.linux.dev>; Wed, 27 May 2026 02:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779872948; x=1780477748; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pqmIsOoLyRuRIFaNUnIrGpypfnkG8bRGf2nm6VpOocU=;
        b=QcQbaGTN7+V1EvunnQU9T8UCGh7MrpvxHAnZhDwTRc/zoIZBIivltxKI4M+e+FEJr9
         w80SL3EzMyfNld8wnkGTEpXQ9ltMQkBssn6fmKIhtVR3x6V6RrlnvVpaQh1EmuEzeisl
         qQ5DLbIjGJ/Qnz3th5qqZkNUSkzs2wzGFyWocUZrFWhb7kQmLtFj65JGrGQe1WiQFjps
         zOwTXU4on0yf3JQ4nmMAUNhrYDsScVtmlyCybpDQN4+dXxrmrlQhyDL6z9kOSQk38Aqw
         C7xeRNO2QLam57OWwa1HgNJzcxECPCh786c0Wnpm8zkmVaYwc5fkd18DBIIzBnsVJwug
         qIVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779872948; x=1780477748;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pqmIsOoLyRuRIFaNUnIrGpypfnkG8bRGf2nm6VpOocU=;
        b=EyPUqFHIkNoztMCLOUqwufVKMQVKYPWxpU2CcTPAMzbmRlYfhTP4Ow1x1ynCp9qRTe
         QJ1YvSxhdL41mKJYDo3AEP/ZMNg3oIYVrcGDfXTiyRm/yiPtP/U8PGEFqZiksRAE5SW6
         j/1v9WuXcR1GalGnhDma9Xtmz2fZxxbqR0ixQS3druxXTcvhemO8sc2cfR0g/Awh3bn1
         mQwSj8s0tPJhEOA35beWmrOYh0k4TPrnUoS+Iu9AOGq4Gmdf3Jn2r4HilhVs6XYT2OEt
         IFEksZ7VCeW2WLvMfUYpg7C4dg/nRGc5WKdZNTVy5Jk1a06pkzdyk8lWagFPw2qStPoP
         Zw0g==
X-Forwarded-Encrypted: i=1; AFNElJ/DXmUBRTZlQU2CG8w/TXKqlkWHbAXPP9HOgxCqHF+pNgxjijsRzUl7ehnBRzGLV7nTEww=@lists.linux.dev
X-Gm-Message-State: AOJu0YyvH5wUBWF5f1V97Yi+6TG+TCDYq29EVpcf+bZWdaIVrZh6GuPJ
	wOSSvvKnbMbZLiByTcOpI4I1e48o197je7OeZ+1MmBG7/ZTp2Iekl0AhQxiihhZCZV0AF353tr6
	rqcx9wLxoBNZlCN4DCEge9V26AhTG53UrWIjARhte4E0ZDi8GWlBBdu0=
X-Gm-Gg: Acq92OHmweJbNVom23y7EAYGx3VeDMCad54DpSdC6Mug+rYm2JqNMJmy1ksGwh8+tVS
	FlUmBgiLgz+nOtJD+5K5c4F77zOXuiMz8uBZuJdzf/f9TcPYLA82KMpKa4Ikjq6hNjw0PUShUGP
	rQK5bLysTegxDcGg5jMJSEK+OTNyo7hamlQwFAEJr+57vyUwpjXjQl3D94b/0ZorsEqZZ+fssoc
	QWrCVQH77GCPywj6xVnqv3KTVHWrvO7EzOs1f09FOFzgXca/hPG36oRf3wgkpnlYaBc5Iw/Nqci
	NHhDior9V6ooJ8HoksXEofgHhwpCK7GNEPuDqdGlpLUTAGP+WyGMPVaJGnqFzUjAus8rhdnKDD1
	PMXEMPKrWsOe6ayCob1MTb7brfdihqA9TDQQ7FM5UeNiWPT+58cSiIUxF
X-Received: by 2002:a05:622a:2445:b0:516:dfc9:8449 with SMTP id d75a77b69052e-516dfc99abamr269163021cf.59.1779872947753;
        Wed, 27 May 2026 02:09:07 -0700 (PDT)
X-Received: by 2002:a05:622a:2445:b0:516:dfc9:8449 with SMTP id d75a77b69052e-516dfc99abamr269162621cf.59.1779872947099;
        Wed, 27 May 2026 02:09:07 -0700 (PDT)
Received: from work.wifi.ville-nice.fr (62-193-63-110.as16211.net. [62.193.63.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb5a2908sm4525082f8f.18.2026.05.27.02.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 02:09:06 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Niklas Cassel <cassel@kernel.org>, Koichiro Den <den@valinux.co.jp>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        ntb@lists.linux.dev
In-Reply-To: <20260513024923.451765-1-den@valinux.co.jp>
References: <20260513024923.451765-1-den@valinux.co.jp>
Subject: Re: [PATCH v4 00/12] PCI: endpoint: pci-epf-vntb / NTB: epf:
 Enable per-doorbell bit handling
Message-Id: <177987294527.16042.10832046004394503042.b4-ty@b4>
Date: Wed, 27 May 2026 11:09:05 +0200
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Authority-Analysis: v=2.4 cv=ONEXGyaB c=1 sm=1 tr=0 ts=6a16b4b4 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xizqlaZpAqmNt8UN1ov9oQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=F3aNAmEVrqB_ix-ASpUA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: ffxL6w6lLH9LnMni1ffMWVmuQWPdEvYr
X-Proofpoint-GUID: ffxL6w6lLH9LnMni1ffMWVmuQWPdEvYr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDA4NyBTYWx0ZWRfX0JqIArQF0VpV
 8IsNUR9icQZKpBDz65mO470OTadORxWTD3RHVWnBpY0q9wxYdLdZxEFlQd4hUAbFZhMCTiFDJ4B
 0GHAY3odPnZa9hMUw2xtTEFzwQdlplsQse4DJ/uQLjzT3gy8e5ohWY8mYzPoQOCTwAjyIiK/N9I
 xM0g34tS5Js3elePM7VHJu+M7jootkuqtkiIZzCCUmE3HGk6azuMJYK1SGVg6byZ4zZ8K6K39i7
 4dPdGT0axNnlSw9ldNhnrTKcBBFxmA5pzwMxuTM+sU+6fu1YOcpIDDfJOLQMi1janUxNFkQ0i80
 YCq9UJvRsg4Fz/0Uu1lECdur7XSmSn5568WwDlNzp2kAbk1YxQY7mqsJeYvx9rs0Bmi20Mv0mIc
 onL+wyALYIueBAXjXfH3P7TfUfc6OQqFVpxu/6fpt/BM6ISeR5PqGfa1ukYQ3USav97k9QgdWkx
 w0va00yjS0EeWosYAzg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_01,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605270087


On Wed, 13 May 2026 11:49:11 +0900, Koichiro Den wrote:
> This series fixes doorbell bit/vector handling for the EPF-based NTB
> pair (ntb_hw_epf <-> pci-epf-*ntb). Its primary goal is to enable safe
> per-db-vector handling in the NTB core and clients (e.g. ntb_transport),
> without changing the on-the-wire doorbell mapping.
> 
> 
> Background / problem
> ====================
> 
> [...]

Applied, thanks!

[01/12] PCI: endpoint: pci-epf-vntb: Document legacy MSI doorbell offset
        commit: 683f8a747ab35886cc9bef96025712011309eae5
[02/12] PCI: endpoint: pci-epf-vntb: Defer pci_epc_raise_irq() out of atomic context
        commit: 84dd5950df2f540e52bd6cbcb5682cb4dff5f2a5
[03/12] PCI: endpoint: pci-epf-vntb: Report 0-based doorbell vector via ntb_db_event()
        commit: 7c54a7152588e8892a7f7f2c69117f00c1bf24f4
[04/12] PCI: endpoint: pci-epf-vntb: Reject unusable doorbell counts
        commit: 86b48f07a5a398ce1cd88e2f06ddab52c2181df0
[05/12] PCI: endpoint: pci-epf-vntb: Guard configfs writes after EPC attach
        commit: 9da8fecbe9173cc1d48667b2b821e4d1f383edbb
[06/12] PCI: endpoint: pci-epf-vntb: Exclude reserved slots from db_valid_mask
        commit: 12f666206720cb462ac4eaeb61a03e492737e1ef
[07/12] PCI: endpoint: pci-epf-vntb: Implement db_vector_count/mask for doorbells
        commit: d7eacad42e2d812872fc7da83466657b7759dde1
[08/12] NTB: epf: Document legacy doorbell slot offset in ntb_epf_peer_db_set()
        commit: d3de5eb64ecd836160afad84aa3ff639acb489cb
[09/12] NTB: epf: Make db_valid_mask cover only real doorbell bits
        commit: 615dc10082a96423743d3a7b8b90eed80580916d
[10/12] NTB: epf: Report 0-based doorbell vector via ntb_db_event()
        commit: c8220ccb30e8c092db9b6fa7dcb06dfd5340457d
[11/12] NTB: epf: Fix doorbell bitmask and IRQ vector handling
        commit: 1c981bf355e8ab78c45717fbd322bd67fafa8082
[12/12] NTB: epf: Implement db_vector_count/mask for doorbells
        commit: e6ff30150738af5c7aa20fad08b74cbf9b86d3a2

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

