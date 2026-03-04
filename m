Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09F3352F87
	for <ntb@lists.linux.dev>; Wed,  4 Mar 2026 06:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772606480; cv=none; b=S+YN4/Sja64Y2xbHawV5n/1i6Z57vohBG+7gqel00cNslM4w0iVJcC/tzO5PqSepgFcw21mDnGHX7Y44wHXGrENFL8bMMCsNbocAFtlidmo84hgcOMGnE1t/qg+p8+a43Nch3ucgH3LXN1hWsEy8rPsb8X3N8qxSyCbwnWBsQSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772606480; c=relaxed/simple;
	bh=vV5++YtOiEucCma9pwOIeu36F7oCkPpW2c2/tIuvAFw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Km7Ip+EOOQOIdHqWM15Bdc7QHXN0doThNJFYSsdTwWOj9gObloEe0CFnSwl5WnYNKRP00+U4XCdZ4l8WQhuZtY3WtqjAk4DN/LVW3BceReXg6b3pY/cnPZTkq+/glnoc1mTvYX2sHENqXTvwp+GEJw5TnglhwNKnCZrNkFZ7EUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e9fHjpGB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V1KhskEi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e9fHjpGB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V1KhskEi"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6245Si4Z1072686
	for <ntb@lists.linux.dev>; Wed, 4 Mar 2026 06:41:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	psb9vaJtJh0tbmEvnCDxeFrNsEYkXYNHoHg/EsRt2nQ=; b=e9fHjpGBcCQl816g
	MSy3YlYY+TjSZ1TdiNGLSvk0TKF8iRQVoCW1Fl9k+1q5yx48TSn3y4ItfD5uqFlh
	uaF5kITlOcjMirh2rAD8htHhmva8kkZHVjrR+LxEDbj/8SU5b1Bl3KZvgnyIHXE3
	ncDOVdSXuAStDIebdSwGzDG9la9oyAF0NBNj0e4PpQR0glsRv4wL6Em/Qr1gRUrj
	mdSkgUdti21fhAs9+XiRPgV3MrjSN48l353IXoADRNVfKAXP+yLAXT1XejO7ise7
	4BF/7mj8A5NvMPmb0MhnTan7ZTV9Jj2gmOPPrGhY1yhNvSVW2wBEEE10853boVzi
	+b0ugg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cpcxfgghk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ntb@lists.linux.dev>; Wed, 04 Mar 2026 06:41:19 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-354c0234c1fso5391628a91.2
        for <ntb@lists.linux.dev>; Tue, 03 Mar 2026 22:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772606478; x=1773211278; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=psb9vaJtJh0tbmEvnCDxeFrNsEYkXYNHoHg/EsRt2nQ=;
        b=V1KhskEi7YQnpAsZhecvyMxFjvDy7zqt89LcHPThAhobYXqntLqAzmwLTLSRxlEU2+
         IhEKqvxCAx68tQW+cDHFjaoodeaVKJFzj/LklcL6zJVGigGqykftTD8szDT6WU/QWwEW
         0Fyw9CLA4CI+Ko3uajP9ZkWD6Bu6tKQWcSYwTk+96MEbvBATTzE81SSohNSdvRyIDlPt
         VcF7g2A04iOIVd2BGbcedJFKKX7RBZpab253UoaSYbIVBcWYYLAV47/+XaVPxHMSTdJZ
         DNo8YDrvB6k0ezb4LQId4BYOq+KA8nuiMaHnJuQgkgms3A6HnI3kB+PyQ7dyW7p9OQA/
         WHgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772606478; x=1773211278;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=psb9vaJtJh0tbmEvnCDxeFrNsEYkXYNHoHg/EsRt2nQ=;
        b=agOUDp2m/jwKjtQLH+HzlJD9wDsVRHqgWl1O+yN25IK91nE0IzhpYunlzZo5JnthPG
         REZ3aX4dMCrJx0SV1HlJ0WYY2y3T/R7BrX4Hl/Esd4Y4AkChJpyfW6YOUlL2dP9cPTto
         j3MSV9L4J6zJPv6gLh6uJANwRVMRuXSrA5IJB852PVUWgRzyq4vR9u9kOlqHnhbtQmdz
         Wx41tVeB+Ko+B4mlZxhtINrhzSzTc1FnfcH4fTwuj71caKjCTs4Mkfjs1sRY8bS3XUXw
         AOCNBmdr0x7mov4DUXsXIhNOjx/9Pmg/s9sLIhFEZGEYym8uFctTkELNH2s8jocoU3lF
         qDxg==
X-Forwarded-Encrypted: i=1; AJvYcCXz/9zpofCmRjiTZarRDYhcgSw/+zU8B20GW9ecGviI0pUOh11Lxa8xi7uAlwc7SZxBEHY=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz+ImZQiVfGYOIkrR72/8f7t00jF/7kZ1bo18GKLsGZn0X4qBdA
	1jA86goc91KUCud8GOlj1zqvkjG5WzpL18te4tu3uZxKcX/pHaKPe0dUoPlD1jS8n/c/UvE17fJ
	ivXVvHT2+j8/gzxo8PL1KW/0D5Zwz2Ak/NOTZFPyYsGtelN4pSbPe0ns=
X-Gm-Gg: ATEYQzxqxOHrn9OqBUhygmL0Er7FqlCD6MdZe3bm+12isP4OGp9TcM8OXBfF8KscY3o
	w4FQexVI2zIJ0m+0QrQxl48/6TpQw0XibtR6sXUEOlXZ10lVGx+VvBbdCvU0CIj2bXE993ydMdb
	gQPHYaC5SJDSX17jCdW28NMkj43QHZ+gnpXslgSxwv29CbEteZqeI0fABHeNmtDwyFWgj/4vKXS
	U1rNB2xZbTEUxTqt27p4yWzKzf1w96cD6JvK5DmICHAmuzpsQR8mh1NAzEWO4afWqQXI6GLxTrt
	kYlHTM4EaG9fWHomzZbMNSuOJfNB/GcPQaq2yp0HDlKEcEokRwWAiwHZu6Vc+kmNAjOXRUURGI7
	HxjQmICjEGxRlXsCeeIHTOg==
X-Received: by 2002:a17:90b:2691:b0:34c:6124:3616 with SMTP id 98e67ed59e1d1-359a6a4cb03mr934474a91.27.1772606478307;
        Tue, 03 Mar 2026 22:41:18 -0800 (PST)
X-Received: by 2002:a17:90b:2691:b0:34c:6124:3616 with SMTP id 98e67ed59e1d1-359a6a4cb03mr934459a91.27.1772606477783;
        Tue, 03 Mar 2026 22:41:17 -0800 (PST)
Received: from [192.168.1.2] ([2401:4900:88da:227d:6548:57ab:a3a:47f6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359aa2c02casm43011a91.8.2026.03.03.22.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 22:41:16 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Frank Li <Frank.Li@nxp.com>, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
        kwilczynski@kernel.org, Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ye Bin <yebin10@huawei.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Koichiro Den <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org, ntb@lists.linux.dev,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260226084142.2226875-1-den@valinux.co.jp>
References: <20260226084142.2226875-1-den@valinux.co.jp>
Subject: Re: (subset) [PATCH v5 0/5] PCI: endpoint: pci-epf-*ntb: Harden
 vNTB resource management
Message-Id: <177260647178.9422.9047695520369841203.b4-ty@kernel.org>
Date: Wed, 04 Mar 2026 12:11:11 +0530
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: 06OnecexvRcvFynW_jEd5L_Im9wPNKjJ
X-Authority-Analysis: v=2.4 cv=R4gO2NRX c=1 sm=1 tr=0 ts=69a7d40f cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=W7F15ZMq668PpAAtMmUA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDA1MiBTYWx0ZWRfXxLAlDLIRqjWb
 B17lmSMWDooKGShbVWatFcf4373hd1jpYUj2+i1ZvGSH4X911vvM6EeUeYZkCiyUeCkIPF2CBGh
 lAe/8aBAd9Q5j5uREWbQUx0EFpawiAjpIkJCSSiychKRCeiqkol/Jmd/uYDwxG0FZ8ZIFffXB+O
 +WnuLUZOZvZn/12J0WSRPoOEvv5LOdo/jctbWdnOMjJq/dma4i7nBbjxXNaHRDcVD893/aHC9Q7
 3g5DqEQ/SU8Tk72A4CfHUa674yQMCooDsmAj5KeAgrkGWvO/gIIv7AZkhHLLqsbZhTudrnii0dY
 +16bzxK7hC3tLduS13d8MRtL+k8TdcRaOQjYX/wQJvPB5eXjglpLRYys0XPgKKjHiftOJouX0R7
 UU18Pc8PV8u8GvHiA+XjS4XzLLXTM2EGsijkwvSrJyQz05JkTSC6FANhLk4WkfTa1v1PC5unZLb
 6JfDMahlqBU93SloOng==
X-Proofpoint-GUID: 06OnecexvRcvFynW_jEd5L_Im9wPNKjJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_02,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 clxscore=1015 phishscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040052


On Thu, 26 Feb 2026 17:41:37 +0900, Koichiro Den wrote:
> The vNTB endpoint function (pci-epf-vntb) can be configured and
> reconfigured through configfs (link/unlink functions, start/stop the
> controller, update parameters). In practice, several pitfalls present:
> duplicate EPC teardown that leads to oopses, a work item running after
> resources were torn down, and inability to re-link/restart fundamentally
> because ntb_dev was embedded and the vPCI bus teardown was incomplete.
> 
> [...]

Applied, thanks!

[1/5] PCI: endpoint: pci-epf-vntb: Remove duplicate resource teardown
      commit: 0da63230d3ec1ec5fcc443a2314233e95bfece54
[2/5] PCI: endpoint: pci-epf-ntb: Remove duplicate resource teardown
      commit: 3446beddba450c8d6f9aca2f028712ac527fead3
[3/5] PCI: endpoint: pci-epf-vntb: Stop cmd_handler work in epf_ntb_epc_cleanup
      commit: d799984233a50abd2667a7d17a9a710a3f10ebe2

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

