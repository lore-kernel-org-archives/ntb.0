Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9FF32E152
	for <ntb@lists.linux.dev>; Thu, 18 Dec 2025 06:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766037622; cv=none; b=eLAuaZ+ZcCjwnd++W9JrroLQTj0pD6Shphcd8FlrYBjhJxsN82BekXliyGN8Rx29uMfPhm42Sg0yDckQpXTc831SG8CgGpywHJuzGtgJf6U3bmrHwnd0u5OWTXyrpMrK8CjofxjYAuyNRu3iKTFhO0GTtEwogIWHvTUBUNY8RVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766037622; c=relaxed/simple;
	bh=cdVj/hRu+voRQi3RJENW2nc0ztKos515StfT43y/03Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fFSWxvFbIhFkkuydqZ6wMAKRa+rbP47n0D3oAYyYZodJQ06y+HMEFguGjcjF7pILwg9tV8pNwtB9WQm/RQ8QDxQv99+ETbvEydjguoCnE/pR7MAuO7ZpZ7LGC3wlKNCOlbMOWiFAPQrG1jeWfM5XcRSG7HntX4MOIeepiRw8TFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=llT36KeQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GrBfkcby; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="llT36KeQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GrBfkcby"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BI1YZsq4147984
	for <ntb@lists.linux.dev>; Thu, 18 Dec 2025 06:00:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	r70sXYxDSL8gIqv+vmmF54NbZNT1R75arkAwnxmmKFk=; b=llT36KeQIBT2EvFX
	GShfngyUKyAkfB3q6bqxPAWJ52lwd6qKK74JxDF3O+bX3RcnEBv2EWEbQX/n6uvb
	OiUx/8q4H21cuxd7/lq/RRq7HiFam+Nz9amRGwkxXKYJg/gZAj5b0+9L80+2pMUP
	8Ds+aavaieZVkDnePP8vfKWks9s9H489ry7ivLeGM9dJ4UJQEGM613BV298MiMzL
	NQ2+3nGBVTje7K1A4E35+4+lZxScWEZjaZRdxd8onYVaXzlp6k4ppNoWtxGE05gR
	Y3fwl40HjV2xYCVV9ekjx40PXLk8BvA/Wd7osghpactfKNCXCu7qdOmyuev5Nxxq
	dFRtwQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b40u79vcx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ntb@lists.linux.dev>; Thu, 18 Dec 2025 06:00:20 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-29f27176aa7so5547955ad.2
        for <ntb@lists.linux.dev>; Wed, 17 Dec 2025 22:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766037620; x=1766642420; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r70sXYxDSL8gIqv+vmmF54NbZNT1R75arkAwnxmmKFk=;
        b=GrBfkcbysxNOCh7Mpi+hx5ieqGGV6cJGO94E0/R0itpSlD+5Hnbrs+jJ+IEPDAv+hT
         MPJapanujmU5sw0iShcgeJm6G6dvAvTC+/FDH1X6cBD7QqXgeyfu+t6OGUmr2VuVYv5Z
         vwbAOQt/P33gEhfl6HrUSqR/rLfP4nWVqcRBbZSCkmhG2EIu4ZxMQoDeoFDQfzLWA7dR
         kztDrEqUD2VqYz6FCTe9k9fCZcfBK380CfooKpUqJER1EFctw3qAV29+mALskNDDv8ih
         GLZ2lrPfpjJ5QE1XOmbg3FsGqlPm30kCdCaTQmXaibLAXLFuCJfbeCkZPrOZ4iQRlLAl
         gPxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766037620; x=1766642420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r70sXYxDSL8gIqv+vmmF54NbZNT1R75arkAwnxmmKFk=;
        b=FruHFX8Q5GaO6Fdo31O5rStr/EGVPyKQpvHPCT7fsrOH/4pNIlRWF4jOSrHZV37glW
         F/D6KHce8VJy0gMWiy29gBlfvTfoxSi3aG4mWXlSgvY/piebZ7q9JjUhDT4Vc431eg9R
         09MJ2Hz06e9C+pkeNnv307NKu25/0t0Cdzonu73Wa28tl5aI72vPYAGYnhmixFJaiuja
         ULQ+KWk43tHUggygcbFz86wftiDWPTdqSuDKk/vf6406dGM3r3TCn9nq7FLqhJcPHvGs
         C2+rsK7rr1b05lN4NRN7/HzAHI3N98QiSjM/khgfdcUMOwGg/qUrjxVLk21hZyGXqLZp
         3ahA==
X-Forwarded-Encrypted: i=1; AJvYcCX7xWI+UNCL9nj1DTaDYzxHaUqCR8/mYyDbWwDq/6JkgJcW7JzoH+yykjasgYpToQ1kDK8=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz4wttr450aXcu+HC1M4SpklJ3HeQhP05/lOTMyJdpQkhdn0WMA
	2y1QPHEhp61OHGvpCvkon+0EkMvzLMLiUw9TaWWh5WUqYdfdWT5sVXPxVPNz07c8I88W5ba7LnG
	jUrRh4GF2Du0ujCQCEo9lWmunmxJqaxPXyHKqmAYbXZ2x9niBl4sIJk0=
X-Gm-Gg: AY/fxX6F6idfajMp4RzFXUms9rOy5GR+adBTdAf9OemfAcBS1CWAwTwU4B0NaxYWKPF
	Dqrf/WhJVxNKP5YYYL56itUYSNgHlywhHFi/7VdHGOVheb9nxLareV1B4sy1yjNWjq3cimleSpp
	BbDBEdhA1tb5xeos2EVZ8IzNfWgQwmqsK9p0L7+diSgdVbx1vF8Oxuh+/2Wsw5kuONHfxc43nae
	3Ybfup9ZfuBcTpKB3lRON3v1Q+rGB4yKORH8je6Ucx5ob2lUmISW9XzkL5pocQ1IVgbEF6MQCi6
	em6K96DGo7Lm+WVtqfppiizKJX4k5OJHhGs/+2g/I7EVp3UzcfMTohTHKm8fVRrawSW0CUt5P3A
	=
X-Received: by 2002:a17:902:ecc4:b0:24c:da3b:7376 with SMTP id d9443c01a7336-29f23b6ac14mr191649775ad.26.1766037619615;
        Wed, 17 Dec 2025 22:00:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHcGCY4FbXNgDyk5ejGuwfZbq1WfYH/d3pVJ7pfDiUTTgntkEUJHYiGtFJUG0VcAGS9DkHs5A==
X-Received: by 2002:a17:902:ecc4:b0:24c:da3b:7376 with SMTP id d9443c01a7336-29f23b6ac14mr191649495ad.26.1766037619155;
        Wed, 17 Dec 2025 22:00:19 -0800 (PST)
Received: from work.. ([117.193.213.102])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2d193cfaesm11811745ad.89.2025.12.17.22.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 22:00:18 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Baruch Siach <baruch@tkos.co.il>
Cc: Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org,
        ntb@lists.linux.dev, Frank Li <Frank.Li@nxp.com>,
        Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>
Subject: Re: [PATCH 1/2] Documentation: PCI: endpoint: fix vNTB bind command
Date: Thu, 18 Dec 2025 11:30:09 +0530
Message-ID: <176603753982.14831.5759032053215324311.b4-ty@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <b51c2a69ffdbfa2c359f5cf33f3ad2acc3db87e4.1762154911.git.baruch@tkos.co.il>
References: <b51c2a69ffdbfa2c359f5cf33f3ad2acc3db87e4.1762154911.git.baruch@tkos.co.il>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: KPm2NLsKuIYbHiO2b7-Ka6Zr90cGIYrS
X-Authority-Analysis: v=2.4 cv=Z8Th3XRA c=1 sm=1 tr=0 ts=69439874 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=PLOdWElDzbaVVj/XHNhp9A==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=A_WhBnD8GSCFf1a9GOYA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: KPm2NLsKuIYbHiO2b7-Ka6Zr90cGIYrS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDA0NiBTYWx0ZWRfX9DgU9t9hbXEn
 axPTyBp8KxlI1K4Y51ZxU1cBcwjMVdy0G39IetbK9SqNvi51ZqDhcAf2dhwwBe9sBMxIe99FXFA
 FWlEtJOWIMZa39nKIOsSVlYtA+ClJlIDTc+cppN2D9qPLL3kZq1vnFJnlS4kwFzePeKS6XXTucT
 ufwxhnV9vVlEusVB48O6iOg3cv91DP0IrbhzYJWMzBzsLg0hqryOznQEQMzUnGc9WTrSPGQuFD5
 VWCSzNj3xAQFHmmd8YSYejzZXSzCDIHSYjIS0oReJW437au7DlaIyjAgJlDLylWg/yZAOC8p9Ka
 JRv3q8+5fHAH8s1FfU37hYfKbhzW9Qfm1POOiIO5shDvilcyCKAUrQzN7w5ESJZfQvsdN4kagWR
 PHaSBIKBby4bKSLUIN1wa5EDf3yTwQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1011 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512180046


On Mon, 03 Nov 2025 09:28:30 +0200, Baruch Siach wrote:
> EP function directory is named pci_epf_vntb as mentioned throughout this
> document.
> 
> 

Squashed the patches together, fixed some more errors and applied, thanks!

[1/2] Documentation: PCI: endpoint: fix vNTB bind command
      commit: 33f4eb34c8cea6246325f2a4b2ef93c207945ef6
[2/2] Documentation: PCI: endpoint: fix section cross reference name
      (no commit info)

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>
