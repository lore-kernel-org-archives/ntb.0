Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB121271448
	for <ntb@lists.linux.dev>; Thu, 18 Dec 2025 07:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766041941; cv=none; b=XUDkP16BtKgCjjwDRhXgJBPM16bMVFoL+L5QXJ/5ff41pArB4djjUAHmfaEBn/6paKh3Ic3DhUbHxsjVqgkyhXAoN6VdeHB98PeCqctcHC91s1jMvp87TRAhJMJvxJ1Dk67lNCI+PXFSUZHMqgH7PvmanCnwsFiNxIREonWi0fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766041941; c=relaxed/simple;
	bh=AN95OchgL4d85AdNcxmpNW7QNWoPIQ8PBn4+l4FvOdA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mjVYalBVrWbuBL7m02Ervy+qBmb7YqkcNW3RLKxg8GThWU3wBzCCtvsGWihwP9JqzG94aFjmIRfJzA3LiuL/bjr67mzczhrKnMdhalxLTMFm5BLLyHqUWPIlEYEsPeN5ixtv/nv0xuxOaev22/82WtSSc43cMrOyQpXysdBjNFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ac5cYdg8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EIr1KzKc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ac5cYdg8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EIr1KzKc"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BI1YkhT680787
	for <ntb@lists.linux.dev>; Thu, 18 Dec 2025 07:12:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ahhQW/xS+HGo8BV5zZn10IecWFFHyhVHUWfbV0Q/7jk=; b=ac5cYdg8VM6QJXvT
	p41SJ9GrbdL6Nzdjno9pflgYeYTA8EV35BO5z2F/C6lq0d14j2I3dh87hhjixM7F
	gH4sGSS9P14qrllnI904peHfLKDYgcH/s6/cHCWL2TKdMcxpWMTJOG8bqxsKyPUV
	mxPs7xMfOH+BnkIjF5wOvFfYZJOZYMzHM6yOmC+i3DzlIdZf/Qqx5fbUvH3txJGQ
	9x2QD5/E0A4RI54+UeBnsfIyH9ifhrUFYr3RXfy0Lft4icE/19ADbzAIHkYUfwHz
	5tDGbK7FEdeyaon8YkZilpGBIxCoOyG1iL0ZZ0xFLYyHe77RWhMHWOBvUw/0adqv
	zsl+dg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b45bhh73u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ntb@lists.linux.dev>; Thu, 18 Dec 2025 07:12:18 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7b952a966d7so765354b3a.3
        for <ntb@lists.linux.dev>; Wed, 17 Dec 2025 23:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766041938; x=1766646738; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ahhQW/xS+HGo8BV5zZn10IecWFFHyhVHUWfbV0Q/7jk=;
        b=EIr1KzKcjzA057s2udtTztz4O88klhFXZLLS2auM2QvJxTfpGT+fMM8aqJOJPZngEF
         0aNS4iFx+i1e6x6/K6QtXn4t34uhAoejFiAeKjVm7VJ1gp7oBRUXaQI3AoK/waff3mt1
         Ycq/yKdG1hes3arzFJJiuWuhU8Z02g8Du9GL+zxfHKtWlJi7g1c76KheDNfq1ZOdIKyc
         39cAywCszV2+BmGN401FN/9tSDnPI5EIiy2bEi9DrUu6SA0rJWvw1LeYr8viFk+zadwB
         NvaR0oTratQtMIxKq6cxQ9sqqAn1YtPMC7TgqP2M0ttXuzEMkIVhB062nzNzYtK8Ehh1
         NW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766041938; x=1766646738;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ahhQW/xS+HGo8BV5zZn10IecWFFHyhVHUWfbV0Q/7jk=;
        b=i5BaH217DYwgO/glk/LnKcnNHaGK0qP/KQ+XUMfpIeEmu7AUrhvsKZmuri2mh1EHqr
         wxNIGMYTWgx3CAO9yGWblTu36VxG0secgjMmY1RPRhtOA5ZQOVPvSZFAAgRPVgBgIXpl
         33UaGiXzKy8aW6dF7epTCoQBo9WIsP8NeKRwVn5vSRfXPCBL3POnwqaAwRTOyNJYgp01
         oiHa2Brcs0Q77w9kPz9Tlaj1zlHr8/CpsYytRDBhr8XnmYdV8mXjpyKfDOnWS8Kx8Nn0
         prf4n7aRqch7dUh0Vf4MqqeSsAOoazDlgoOZVq436IeWA0wabGSgBMvyrsW2bhVKJDtN
         i81Q==
X-Gm-Message-State: AOJu0YwGwzzDqGyuFvJxn4/86VOoUyI4L92Z0A96gPO2DLjHChdkGXSq
	4WR65ssYLtXtb7yLub9hdh0G/F+JYS2iTvUue0nufw8d32FWjBE6dSAZKOyaODHq9lrGJkDQscL
	n7DxUHH3WjD7XZAuP01U858czHr9ctoeGaVHOxdUQNMV4U6L/wccar6U=
X-Gm-Gg: AY/fxX5N6tpDVCD0cqqJVX+wUz5ARlxc7ltQ7va7FT9rYRj00Y14mauxVsjztXtko1J
	+KtcneJCp9XkpovJOlx2P6Gs3jyHa024zxnpil59ZXEGQc0tdE9Wgg5uiOCVrzGcVUzUm84z1sC
	HScEdUC2GBxHZK4owTQiStOj45COc7Yths/QxCyhAe+OxxPOc3QH4/P9Uu1SiL/Z56liGuS5Yzv
	GJZibJSw6BMGW3eJTCmRrxcldkeYLea3M6zNt36WBe0XxDJy1LVFhR0EmoYbmLMNd7124rZztyT
	O6PZh5+lsYzQBbNi1ziP/S3jHkzdAPbOa/e0dqRSuxjgF5z2OXpmfzS7rVcxleD9/waJ/G7hDnr
	RWQAhRq+aShw=
X-Received: by 2002:a05:6a00:3696:b0:7ef:3f4e:9176 with SMTP id d2e1a72fcca58-7f66969f9e9mr18140534b3a.49.1766041937650;
        Wed, 17 Dec 2025 23:12:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG11rF+3NKr1QQWhXJyxJqKYYwR65DHW2sTsWEIJ/HZEjaTc4mNS1eB0BLsCSK/AF4hase5wA==
X-Received: by 2002:a05:6a00:3696:b0:7ef:3f4e:9176 with SMTP id d2e1a72fcca58-7f66969f9e9mr18140511b3a.49.1766041937214;
        Wed, 17 Dec 2025 23:12:17 -0800 (PST)
Received: from [192.168.1.102] ([117.193.213.102])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7fecdd3e10fsm197516b3a.5.2025.12.17.23.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 23:12:16 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
        kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com,
        Haotian Zhang <vulab@iscas.ac.cn>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20251110040446.2065-1-vulab@iscas.ac.cn>
References: <20251110040446.2065-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] pci: endpoint: Add missing NULL check for
 alloc_workqueue()
Message-Id: <176604193414.795334.4365952101287468707.b4-ty@kernel.org>
Date: Thu, 18 Dec 2025 12:42:14 +0530
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: 0RiJ7HCv6gSg2SlO6TI6Yn9-EGF27-QU
X-Proofpoint-ORIG-GUID: 0RiJ7HCv6gSg2SlO6TI6Yn9-EGF27-QU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDA1NyBTYWx0ZWRfX9TFi6kAqC7g1
 Ik3MVp6WAUF4WKPoOFSQOLUGemG8Q58vfz5jhSNQ8nPIjMnxis34aYn8iJUH17MsdM+b/HRcPSX
 79gpgCUi7EfvB9sGg02Xi/FoWv0umw61jJm2mDjqmNthE0iZOJz9Q271A24QbhkBnmzndm+otKh
 QSWUVyEPEVbYsMFpYQDW0ni3K3R9PVc3PvyH9sUVoW46De5VTbf8yRhNN4Ulsm3zbW50gyb8f+d
 uLhTEEJgrBA+Ylj9gmoW1EgTjnRPEeK+skdySeGjWUH0/HAmiGmPP3n0i8IxhfrhstkcgiZKRNT
 idV4JyI5+305sYvWRo3Wbt4htFwsYZCxm15L72iKUQdPcUb65tSY+/1ca34BvM8ra+dxwLWClt1
 SD9017KriGlxalR0JwH2jgomMi02fw==
X-Authority-Analysis: v=2.4 cv=SZr6t/Ru c=1 sm=1 tr=0 ts=6943a952 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=PLOdWElDzbaVVj/XHNhp9A==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=2AY8z-vqmeJrc45qOLYA:9
 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512180057


On Mon, 10 Nov 2025 12:04:46 +0800, Haotian Zhang wrote:
> The alloc_workqueue() function can return NULL on memory allocation
> failure. Without proper error checking, this leads to a NULL pointer
> dereference when queue_work() is later called with the NULL workqueue
> pointer in epf_ntb_epc_init().
> 
> Add a NULL check immediately after alloc_workqueue() and return -ENOMEM
> on failure to prevent the driver from loading with an invalid workqueue
> pointer.
> 
> [...]

Applied, thanks!

[1/1] pci: endpoint: Add missing NULL check for alloc_workqueue()
      commit: 0a19a6d9ed65ef7df845c32befa994e45620c12d

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

