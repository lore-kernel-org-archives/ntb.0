Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54643B810D
	for <ntb@lists.linux.dev>; Wed, 27 May 2026 08:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779869213; cv=none; b=fFrUWgzo1gjIEDazwXnW3Kd7iclTrNtdrROJahCWxinzuUXjXBkUGwjBncUuh5ABXv9/Lgn/ZPrVRNbLWkwg1WQUlZ27Y74OMszSAlQjza96cm1Kwiu5x0Clp6bFvx/S81Bcp6AmnS2Cx/j1tlVhyyYVHUDJ8MWqZlULbX5Rq+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779869213; c=relaxed/simple;
	bh=qlZojhjpk4o3H70EdsfOXLi4yzZQXwCsReyiG94Zplk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hTWulOHJVTtRgW+7ef6Gc9wc/EWdPsx64jAlnTRHOSkYO4ZN2UDRZcSfsvvwsWoElY/bOo3a8Rn2x1HaUaK4GeiB+8QAZYjNqbMBsyMeq2YOQqcaYi0h5nXP/NUdqCHQqqM/+zhhlOnZys/aKprictF/h54hsiEDYkHT5RuCsTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z1ZUxDmj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=E9hffXq3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z1ZUxDmj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E9hffXq3"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64R2WmEP127126
	for <ntb@lists.linux.dev>; Wed, 27 May 2026 08:06:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	A74bJSFlbnxmQ8tZ2b6AjykhKr3Z9Kluf6ssdkEtzc8=; b=Z1ZUxDmjlP2rNwrC
	0IpNqUdlnxaOAjX5bqsLckUXsCKtXQv+hSmdOZFV1Rh/kC/OZ4vZTQjwdMvqYg1Z
	eggMHOWvkxR75TIDbc3SuadxmMLNWdPeknHj+tUKEcx7uNlBbSfgmak6Pg0RrEdL
	4Aw+5coomKdD2bu5UCfqNf7zj7NqsNgbiQSAVqAz2Lxny3VDZpaUcGmZIap6TEnY
	pGSqojSabdJUH+b9G8JR+mfgzQTvCIetpkkzalcSb5IeBFKtmHhHQg4hMGrDn+Dg
	+slsA6nYNITJZhTl/L5flhdGLMyTfv//GnUu0XgKdzSMa+w7LyHz8doDljrcxLwC
	G97bqg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4edeff35aj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ntb@lists.linux.dev>; Wed, 27 May 2026 08:06:51 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-516d1a8a6c8so54909721cf.2
        for <ntb@lists.linux.dev>; Wed, 27 May 2026 01:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779869211; x=1780474011; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A74bJSFlbnxmQ8tZ2b6AjykhKr3Z9Kluf6ssdkEtzc8=;
        b=E9hffXq3Kcl6aXdMDeuQzR1uIW8qyQNjdsNpWwr6YxsHPE8c8yVKhuBo/vyR2p4TB7
         C9tCldUSkaBbzMk+Ii4H9w0ybnfL/GXs6Uf0domus3WpfIwr4eQs8ZCkvbBP9ovIodnY
         WdnQKDumrT87G9eICxKxY2JW4iQF9Edk6gJ6dk1W0Rp3pqfqL2iieeEX/oA2c3/NuMFz
         5tzBg8uXW+sCV9Q9P7xXz7MaosLVb/vdqqTWZ8HfB5ADGmccxcZlSseliG1kajj3AJHO
         wnXp2n8oNqRSMKGGZsYsLUIsCnCoaRxBfV0Jnxt+rLbmCasbooSbBGRwb48d/adlOHCZ
         R2PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779869211; x=1780474011;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A74bJSFlbnxmQ8tZ2b6AjykhKr3Z9Kluf6ssdkEtzc8=;
        b=VMiqK322scJDvQrNIutXJTZ9avmpBgiexGk1eWd2qsPTAnzHhwDGw/sU+kXIy/I+Yh
         Gg7qdi8fmOs5Ewq46jKUagmL+EnW1kUkDXs7pUEhqnqDySgyo3nLdxQp8Elda6LOaYpU
         g3yB261LbwnU2h8AIm1f0jlUk+vt5/7ngMjlRyX/ta9O39SvFdDPKPwdgWV/HAuQ9Iho
         pGmM/V5yIwql4yW7abOqs3Ty27OhtKcO2SYtbiacCQgT98ODyRwxMzhYBlZisX02bofu
         WBRHcsxpMNAdJaR8kbD6F+zc2aauKnS/FN6Hn+PJGXorTL4Zeq8n39ynn2GMNHzpRkLL
         ALxw==
X-Gm-Message-State: AOJu0Yxx88JeOX1ZHhBkkMVi2cwpTuD3gpOwK8b6Azu3GtML9JwYDdaT
	4fJeiAGAAlViff+2iVgeqO41Bn+hLQ6AX4Y3ykB+F9aHRGSI4gOHP9ZkishZaw2+xLNSt9ngirB
	fL8fXnX9T8URLju4IrqzdUCSuRrEcmLIXjbdBI167t3UC8NN1B1SLtzQ=
X-Gm-Gg: Acq92OEqdBL6PpUMpw+B5KYm5aLHsB1tt/3W0NGqJt8gKKkhiOByBXzdD2QZLndqSA+
	4d2ceSqxxvLKZOjBlzAQdpm3hrV7yciBCGZ9LfDHnCiOWTlJrQDWfFE4NkDPXnFC0Dh4hXKTVHg
	jzf6qocSmxcFiVA1REKmx/p88tXZP27LbVbE4Ys3a7pedRo35u7Zya41f9zSonLw+yyuVF5a+bp
	SgxUGRFgDix7pMqpaT0U6cgNuyKifTXG5XF5U20pSuUiJWvtfDMVAUAsPEciCMSMbSwzXWuNYcL
	hz3dchfFOOE72RLDQIdEuLQYvcG7h/ODBaQS5fSEQXCQGHGRPKSUdS0yNYZ7nzJyHD/JzESf6aI
	c0Twe7vu6ZJNAJNuJrdgrHexxYnKhn0nX+OihFYl/PYMlbbXyyCv7hBrU
X-Received: by 2002:a05:622a:1b04:b0:50d:9c60:fe2a with SMTP id d75a77b69052e-516d43dc0ffmr304884731cf.1.1779869210791;
        Wed, 27 May 2026 01:06:50 -0700 (PDT)
X-Received: by 2002:a05:622a:1b04:b0:50d:9c60:fe2a with SMTP id d75a77b69052e-516d43dc0ffmr304884441cf.1.1779869210249;
        Wed, 27 May 2026 01:06:50 -0700 (PDT)
Received: from work.wifi.ville-nice.fr (62-193-63-110.as16211.net. [62.193.63.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490809cf24csm14721355e9.6.2026.05.27.01.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 01:06:49 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, Jerome Brunet <jbrunet@baylibre.com>,
        Frank Li <Frank.Li@nxp.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Koichiro Den <den@valinux.co.jp>
Cc: ntb@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260304083028.1391068-1-den@valinux.co.jp>
References: <20260304083028.1391068-1-den@valinux.co.jp>
Subject: Re: [PATCH 0/2] NTB: epf: Fix ntb_hw_epf ISR issues
Message-Id: <177986920811.9478.5259181719424630932.b4-ty@b4>
Date: Wed, 27 May 2026 10:06:48 +0200
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Authority-Analysis: v=2.4 cv=ONEXGyaB c=1 sm=1 tr=0 ts=6a16a61b cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xizqlaZpAqmNt8UN1ov9oQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=wFfcJ4P8_Ijr8QCjj2AA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=zZCYzV9kfG8A:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: wuC_IF-3arCeF-PdfO13ggV7W08ZBQOZ
X-Proofpoint-GUID: wuC_IF-3arCeF-PdfO13ggV7W08ZBQOZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDA3NyBTYWx0ZWRfX2amLfKp4w/61
 5FJ3mYyFXQdpJcDqWYqHYRA/AO7mvvv6w6J1OkT/bkuByTJD3drl3Ii7Z6L4QRNYtt49Y5vrM9f
 hPngb722o2HI4gtz/eGPlKTVL4XguQC1alJpYS4lZA3YjId+LIEw6DLvu3W+Wx3T5coXvMcvZnI
 lhwA4a2xN/BCPUHKzyRFWsNb6ANaRqxpM5pbH7MzHsGIrIu206QxVo93D4YE2wSNdlhyZXswle1
 BSnHiwfQY2srgde02akagzbCo8NWHJrDzFNh6t9kQZlSIPRdL+vRhoe61ccDw3IjrAi+y/GgydZ
 u+9ayANc1ccx9wFqWoPwLo49bHMvu66RNoj316DxakxKy9d8JOeUnavjr6mV+HVSW+mMrfe3f1+
 +6RmSudjd96qABazAy5Ke9TrH8AmomvXBtFIVpa0ZUj+Zto2szOO+CsMAsE3pjEwUSYg32vDAXV
 /0L0pXARO7cbfOBy43Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_05,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605270077


On Wed, 04 Mar 2026 17:30:26 +0900, Koichiro Den wrote:
> ntb_hw_epf handles doorbell interrupts using multiple MSI/MSI-X vectors.
> This small patch series is to address two issues in the interrupt
> setup/handler path:
> 
>  1) ntb_epf_init_isr() does not unwind already requested IRQs when
>     request_irq() fails part-way through the vector loop.
> 
> [...]

Applied, thanks!

[1/2] NTB: epf: Fix request_irq() unwind in ntb_epf_init_isr()
      commit: 9f67debe71a1ac6430ef8bdd8e1b8ab39942e63c
[2/2] NTB: epf: Avoid pci_irq_vector() from hardirq context
      commit: 9985e6ea0c227de2027210dc45dfc33139203f72

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

