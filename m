Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1DC34C9AF
	for <ntb@lists.linux.dev>; Thu, 26 Mar 2026 17:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774545559; cv=none; b=byClTvE2baTvovHAKj7WmzC5VqTlQi52nFBOAklheSaNXY6c4GRyWTS/eLbYkYcyccRcB6YWXwIPtQwUDmsIZxzcOGoJ/akzoE6DP050iTFccGK1UCR4lJmjQKipwN1N1VzgWj7Hwodx8gV7rjX4gBR71WzldxU59oeX5kzxXeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774545559; c=relaxed/simple;
	bh=euLHU9LJSjnuVv3KVwXZVLQKkTH5tfAXTjDgcT3R8+U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=V/xX8dRXmW9PMop8N9YxkrSlGbEJYbeuab8yBH+05LdZ8K2ierYTou7li4mGZSkP/CCreE74aiCutUdagHvA35WscrI/mWbq/cNfBKC/KihE0LPY+xDpQooLTVJRZMeNtVCRgOFtMv7byiNDa0i1FWCk6ByHjV//fN7oAsLFLmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h6Vu8yoq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZQrxaou8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h6Vu8yoq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZQrxaou8"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62QF9h1q2451443
	for <ntb@lists.linux.dev>; Thu, 26 Mar 2026 17:19:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ww9RyXfzw3HcfsJFywuqNamT6krJul8stvWokNyJt1U=; b=h6Vu8yoqbBzY3uPy
	50M/5YiGSx1F4dSdXrMRCDR77IF5jUuhNVp6CE+C4dT3LghVZDN663ByPszboVm9
	nnXDbFt7wRXl1XNFsOO5h+xPdQ+k/oZloLDpJ1qxvxZu/oILt8GSYMPnBvUDbbpS
	AKuaFHVHypfIEjxCvnufAKuCtoq/z/bQc+iCKOsSkbLZg03hmJBq/DQp426HP6A4
	F7fWtb+3OXSKaGeD+Y2hvB3gEnU1qHObnamSkkqTSkCxK0mJ8tWQuczZX0Q0ADWF
	qqgXI6PkH6S3mfXXbx78yusMFPJbVa5PGrtfXynn4wE8vjBet38Y9rwZMOcu78A5
	6bVzoQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d4q1t3tyb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ntb@lists.linux.dev>; Thu, 26 Mar 2026 17:19:17 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c6e7f45e2ddso2418947a12.1
        for <ntb@lists.linux.dev>; Thu, 26 Mar 2026 10:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774545556; x=1775150356; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ww9RyXfzw3HcfsJFywuqNamT6krJul8stvWokNyJt1U=;
        b=ZQrxaou8EM1nAX9PaeAfpVpKug2qY/CRReNhCoJjI+XqD9bsvnM6IDKxtgYTC5vRKA
         KV2Qd2AsbM0Dfgm1+mJ5Rj+0poGJR3vADyOVwI9HDWE9az/fHQDmMM7L6YV1FlUROvDR
         d3QvDYAC2HfP/GoOdJXhKPMGeaXJwCYwllBrvVPbFuJYkY2V+E5eHhFvwAbeo+ZFmBfn
         kUTirspzTXgCC9xYUWAZsLJwkyGQYnIgj0UAad+emSVS4ux41FdZEgRqjt8WpxDL+WV2
         XjtMqu0ao9vtYX2ArquZopWGDhJ0aoLNuLBbi5cXh4L3PQwBTHM1jEgVtwsmB44kO/cS
         FDXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774545556; x=1775150356;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ww9RyXfzw3HcfsJFywuqNamT6krJul8stvWokNyJt1U=;
        b=Mc075K1ncEsVffpYOREuWlXAbzOsEkHTc8aAgElsv+JHEiZbqydN1vuJr8u3I/Kq3t
         kqHBzOkmb5Gi+vPLOx6xPB4XQpF6STD3uMQMrtSHg7QrPy8faGRTBdbUOmL22pyBvKBe
         orlttOsBZz6AzDS8EqeTCLc/IM7uOmIag8HOo9ZyGCGwtp8qVIoOKNBS28/BFEZyqmZO
         4rHUbPbuRT+kXyJb49ysrsDgVdumV43pKlzUnj7DE2fppW5aLqrD/Aholqkq0AzOxec6
         GEXNIajBp4cqTsPejFdndwL1p91ZicIzegcayPX4pvf189o++tJ6zQEkW/ZGkZRWZDnX
         EdSw==
X-Gm-Message-State: AOJu0YxkhPj/sRrA1o+qcrekLE8HCo1E7gUXPb2rF0by1miFRkq8rWr/
	5iiR6EU5+9KXyUeXqFqhwVuWlDFeO1IRCRrEHER8t8DTk4wWIiZIsibR4JcvE4J8+tMUk9pCi3W
	FdVUIgD++HHhjvYg5qpuEsOpHeY6bEuTZ212tv9n6xcGvz8K8q8bl+9w=
X-Gm-Gg: ATEYQzxc9Hma54+vwdF3RoAUIebIzgV9MKJQYDUGtSlwt+mRRd6ILO3l7T/NZI2bewO
	lxP07Em0Pg0PXW75pF4KwjhxaWuJFCLBkFaGg74ezUwn8gkzuSsi1yCv/GACbI544Vt9fYaeHed
	R6T5cXAgbWwuRceX5qeIe3+sdezIuAczq08DF/kDvvIq3JAnwOK/20GVrg0/8NDCd4kJixEf8q8
	vHlv+w4ebTWgCMccooXfvr49pIJ07YQjLrVe+PKWekLgMiKUzEoHEMHWshHo3JYf929EpeFJeTN
	Ut9QGOnI6qvxKqi160kNlfFnI5+SV9EC6xRFGgPJ3C4nMzPH08VzqiIdTGh/kPi26HuABfHo5uw
	I7JBvE6zgzAqtqRAmEwxg7+c=
X-Received: by 2002:a05:6a20:2e82:b0:39b:da83:91ab with SMTP id adf61e73a8af0-39c4ae2ea72mr6809517637.63.1774545556300;
        Thu, 26 Mar 2026 10:19:16 -0700 (PDT)
X-Received: by 2002:a05:6a20:2e82:b0:39b:da83:91ab with SMTP id adf61e73a8af0-39c4ae2ea72mr6809488637.63.1774545555717;
        Thu, 26 Mar 2026 10:19:15 -0700 (PDT)
Received: from [192.168.1.102] ([117.213.101.231])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76739334e6sm2661617a12.18.2026.03.26.10.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 10:19:15 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
        Niklas Cassel <cassel@kernel.org>, Koichiro Den <den@valinux.co.jp>
Cc: ntb@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
In-Reply-To: <20260306031443.1911860-1-den@valinux.co.jp>
References: <20260306031443.1911860-1-den@valinux.co.jp>
Subject: Re: [PATCH v2 0/3] NTB: Allow drivers to provide DMA mapping
 device
Message-Id: <177454555116.460009.16357964565477922352.b4-ty@b4>
Date: Thu, 26 Mar 2026 22:49:11 +0530
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Authority-Analysis: v=2.4 cv=e7cLiKp/ c=1 sm=1 tr=0 ts=69c56a95 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=pjPfvbXasfe8cMZvnaMi6g==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=l7Ugaa1-BWrJxlqRz38A:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: -dQgPj3YfkFawxI4oDAR635M5o2W-IJU
X-Proofpoint-ORIG-GUID: -dQgPj3YfkFawxI4oDAR635M5o2W-IJU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDEyMyBTYWx0ZWRfX4+xyhd8jKyEi
 EkRwmU1zXZAmVON1DF/jqE+Pzs8C/TZHeQefufwuHta+Ob15IKPoPUaOTLm1nO6Tqf4MforupEa
 6XSIbbCiqFfa5t64U3z3qw5mf3KH/TdyoAX7tx+HiIEgxgjSFC5Gd4lg7MJlOCV7FNOKn/eTIBh
 oh/sC6vXDfpVxQrVFdwN+z1lizP7osUPEsilaEWPebivn4Ntg1PZLj5HIkKOG0CcldPOctR/PeO
 H/CDqDQ7O7eeQM/I5I9dvvPysQzdBrf4iiQbCYAFk17dsLMmxBmOJ5KVQV8aTC682x8HA54eij1
 d0K4S/s+K82xSbbPZhtVhZUT8F7P4T1Q/yJpPu8/CZIV9ERz49lhaXwqokaoijJXa6SJ/+xaKa2
 dhfVM/N5EdDFFnwkh9cN0oINcP1beSQ0VaHz8G3XbT0cuQQQpQL0OYhbt1v3bK4/blvHo5DlNf7
 JuSYSMKwrR8/fMR5yEw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260123


On Fri, 06 Mar 2026 12:14:40 +0900, Koichiro Den wrote:
> Some NTB implementations are backed by a "virtual" PCI device, while the
> actual DMA mapping context (IOMMU domain) belongs to a different device.
> 
> One example is vNTB, where the NTB device is represented as a virtual
> PCI endpoint function, but DMA operations must be performed against the
> EPC parent device, which owns the IOMMU context.
> 
> [...]

Applied, thanks!

[1/3] NTB: core: Add .get_dma_dev() callback to ntb_dev_ops
      commit: af43a3a0c0ad524a69a7921efd0a04d50c03090b
[2/3] NTB: ntb_transport: Use ntb_get_dma_dev() for DMA buffers
      commit: c2fbbb8b341c58d24c7b114fae4cadd55a4660f1
[3/3] PCI: endpoint: pci-epf-vntb: Implement .get_dma_dev()
      commit: 185596ad93f545bcab2fea0dad6420c0c3cb386f

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

