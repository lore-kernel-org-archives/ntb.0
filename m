Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5002BD5B4
	for <ntb@lists.linux.dev>; Tue, 24 Feb 2026 10:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771929522; cv=none; b=AMgVZueCdMwRs+bwi8YN63xGgdf1I9lolX2rLLjgkFgW8zl8UMyiCXcW4AADyJY+8puHFYvXyYoGg0yaaW4NQd3dmgVRaBJyvJGEZi46xESZ9PyAtGPFWDTMLYR68HCou69kcBs99jdDaV+wO8hKbwxsnRYboGxQ2hPn/MTNQH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771929522; c=relaxed/simple;
	bh=wqltIsdFaOf9X0eJjSHnBAk8HWpHNil9D7cznVbEyzw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XI0yFw/B2CT2X6iR5FelsgL5hIuHoZC2DJzmtAW6qiAIp7beRY1E6mzPQxDfSZIoBHg3oDerZCFC4I6j70T7yLpSha+NBRAcA4f2BuTciPJI9UqXPlZLVeU3pQkHYR4/Cfqylw0zUv+Da8zgUNU3of2zQAEEMRXT7D+NK+XlDaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VpH0uGgQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QIJSKY0i; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VpH0uGgQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QIJSKY0i"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61OAFQp3057209
	for <ntb@lists.linux.dev>; Tue, 24 Feb 2026 10:38:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	snB1w1LAlVgB1WIb9fQKmtsSaq8thsIrgJaEmX+fg8o=; b=VpH0uGgQG8VDvrqI
	+lPx4y9ZiZLYk22XFR0CQ3LvrFeKjbrBRlX13Oy8aNtOWG5tOXziYYMlCqIydMqg
	tTTxNM7t/RnjuN7Xrrk/6R8FB3esxqzQ4RCTNStRyJA4Kq6NJQLw3gUOvXaYzAbn
	sbzZ3drZLnETaP0IM4duv9F23aaScWWKyJgYYcE9/G8HEQquUrBXxhi5hN8sghG7
	lEewZHBwqoVY7be0IX8cDIPS7DAiA/nBR2nqmQpB4b+zf+RaY5Cl36bv8Xy7ZMVI
	hqlaSFBk/mx7tZ91uwD/wX8sKyVOAZdDv/HZDCeBXsFFXQrnjHL6zJ+4rQyTXbUS
	Xa/TxQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ch9sa841n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ntb@lists.linux.dev>; Tue, 24 Feb 2026 10:38:40 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-824bf5fe8cbso2336553b3a.1
        for <ntb@lists.linux.dev>; Tue, 24 Feb 2026 02:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771929520; x=1772534320; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=snB1w1LAlVgB1WIb9fQKmtsSaq8thsIrgJaEmX+fg8o=;
        b=QIJSKY0i+Bn5jcmnywAjfDOjqf2Nd/GcpuJ9Ik/LFbBYKEaBbbbQbXAg9K3QQ3wpe8
         dOL14pKMfwj/lKgCUS4evnnW7I19tF7HLFUW5i0d0XzslPaDHglYgn+/1Faq8oK9CWBn
         4Lad1cafkxEUPyAEVIjS4lkKe73k5wXVLVwMiEXoZZNvqLBkEXpD/u0FElpY99+58pyg
         7lbDJwFqlhWgfD0MOvtTpZLL8PKCQKEx98oOn3DM1r9z9NXMuoYZYsmDNylkZSiL98Oa
         l/dDe8DEaTOOikHiNotTrF/MNx/hZ8yaKi+TgzXQVnxuGzcoja2vGsc4lG/AZe2iX/PZ
         uLNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771929520; x=1772534320;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=snB1w1LAlVgB1WIb9fQKmtsSaq8thsIrgJaEmX+fg8o=;
        b=gwXiSGZ/QaJnwfUazzqD8Yen3rKJbDl+1R7EAY3nkrzSTEvKFoEnV1f/xQrokoX90V
         uWJQDEcljXEv1pp8Nbj5eCEDCQZ36Kelt+ZPs18C5rLNG470X8sgOVifKYMP/KuGYL1h
         +GHSIlYN5STXlj5QutiuLtyQdY/YZWyP8oCACXBgjY/yMd4qmOKd3g26VF2oHxcrBjl3
         an6w+zVMARbxZbGFFNeabwNMHjpJ1T425v2qFlH/45sSUo8DxXFUtObCSsXE3n08X2ka
         ethRnMrto7P7s/A/+TqJOdrV9ksxHSH7v2AlNTDKcbOPR719H7iBUG621EOpGc5MJvQG
         4VBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgsYxjPVJgYgrd8nB/K8ZTC2CG1KmoDGegRohiLycr/prghiuNR/aThCOedzVDZMv1Snw=@lists.linux.dev
X-Gm-Message-State: AOJu0YxxEfmyHak1XLY93uAq+YAcRf0jAB2qUNF0w2fatxdm5d6oOzhG
	mirkg6wbmiYWHHqMyRMBZ5JJr0P2tedixDv8NVe1qcxJUtpqokyc6kFQGjMKiYm1tmte4o4kbVy
	pvzw3xY9ASiiGpN2UWwZNtn8bSsrTtyO03EfAH5U9qmzReFIGRfoilNQ=
X-Gm-Gg: ATEYQzySOjprppwIW7paaKS4sEBUGmoVQkO4TKYu/H8ZOsnWgBrXkGnqONBxv4OZCRR
	Z7GEW2eqfLPSYaNOI7iIZm1NnN9gjvtaFAXxsySAN38wHPvcStzKvJt8BC8ssM1tCvROoueC8RY
	jnkqFbgQN67uZ/7xzRaqJ/JR/B5MscQyCn+54Ha9/CS+pXv2DDDXRUKswxMz6ODl5W6zHFpLPif
	RvMILXpDZdM3M4dbuZY5ZC/iw5xtcbvypo+IwPP9yQmRP7+5/uPF8D3tZpaxbF6co9reP8i3mUD
	BfJMCG3T9UIY68MknntPXNjQEQa3SKNVDOTIjBGIMopNI1Xu2M1GOphg+myRGpKkOH6UXRAvIlP
	n4YsJwq2SfZm04F0/qK0BRKA=
X-Received: by 2002:a05:6a00:2d21:b0:81e:5a6e:340 with SMTP id d2e1a72fcca58-826da903848mr8964241b3a.26.1771929519600;
        Tue, 24 Feb 2026 02:38:39 -0800 (PST)
X-Received: by 2002:a05:6a00:2d21:b0:81e:5a6e:340 with SMTP id d2e1a72fcca58-826da903848mr8964212b3a.26.1771929519031;
        Tue, 24 Feb 2026 02:38:39 -0800 (PST)
Received: from [192.168.1.2] ([2401:4900:8fe5:3076:bc82:a67f:ae4a:6d25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd8ce4dasm10401746b3a.58.2026.02.24.02.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 02:38:38 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com,
        jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
        linux-pci@vger.kernel.org, ntb@lists.linux.dev,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260219145633.4191325-1-den@valinux.co.jp>
References: <20260219145633.4191325-1-den@valinux.co.jp>
Subject: Re: [PATCH] PCI: endpoint: pci-epf-vntb: Return -ERANGE for
 out-of-range MW index
Message-Id: <177192951496.13238.2336315326171774130.b4-ty@kernel.org>
Date: Tue, 24 Feb 2026 16:08:34 +0530
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDA4NyBTYWx0ZWRfX21DAUycW0UvO
 fhaJfr6r3+nvS10lGvHMf/x8P0aOTYeCB5m3+iyZmsiBH7sLFnMSlBDwNzkQ622PkNiycePb7Io
 Uevu3eE8nJuXfuCSyrmaZ85AcB4AJG9eU6L+ofjZJR0qd89TcniotabxUOkpEGpxmHQJLfjhGMy
 yImukH7gHWk77wb/yPJSKmlUZL5ImUeMQMH/oAqhMXDcnK+f3PZet0rGfWkHqC9+0OEv1N3KO7Y
 lOxY7mZ9y2DzzPxE7fShvyj7w3bcrzFLMWSqyJsWENiuhcQwbup0IC+xcPnmlpvLyNoQPjA7act
 3D0QW2jTUnw7c7JsIvgWLYJO4plVGJqu6wr0DYUTuLCq8Q4T9zYYu1xGrJETHn4HS973ABebaF+
 lxx6pWSiyQ5yELUL/+xrlyEDed7V8YBLS3A+7iE0TfNBQSylSHmy+nosgU20JTBtGZpdxz5x4ue
 qupkYypLRJstXc8djlQ==
X-Proofpoint-ORIG-GUID: ihC-nRBtT5bu1CrdI9HMx1HMxogC9UZr
X-Authority-Analysis: v=2.4 cv=e7ELiKp/ c=1 sm=1 tr=0 ts=699d7fb0 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=Ow_fN1IBQddsNOZG27QA:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: ihC-nRBtT5bu1CrdI9HMx1HMxogC9UZr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_01,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602240087


On Thu, 19 Feb 2026 23:56:33 +0900, Koichiro Den wrote:
> The mw1..mw4 configfs attributes are only valid when the MW index is
> within the configured num_mws range. Return -ERANGE instead of -EINVAL
> when a configfs MW size attribute is accessed with an out-of-range MW
> index.
> 
> 

Applied, thanks!

[1/1] PCI: endpoint: pci-epf-vntb: Return -ERANGE for out-of-range MW index
      commit: 8eaff52fc101c1f6b3215db93bba02c815155806

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

