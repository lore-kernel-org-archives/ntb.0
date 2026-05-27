Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7648934E761
	for <ntb@lists.linux.dev>; Wed, 27 May 2026 08:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779869904; cv=none; b=mIpvTRipjwo4xMAdR/XYyhyZ6d/sewCV8NlDyWM5ABarK+0BWrLxCtjy007lvx06OtBj5r5GSV5lQVtQZJCvwKQwxPRH7SbmNryRnJ5FqohpslbAQBnKikwDAM0jIGPGT8u8LFmf63hTb0SgskgYw7CAiNwbZO+H0MCLW8UU5r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779869904; c=relaxed/simple;
	bh=k0eYI/tcoPetwLHY3ErdffSYDhxyUrEIeQsBj7DcntY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lWSqke7dCpECQGu7XuCQhU0IaotxczmXno9WSseW6x2Bv/iuIsyk4NZQlbvLOWB7374k6kQ0EMh4xwZX3px09yR/LoUlkQn8hEjt0UHEFi6SC4DlNnCg1CGgFR0OmDAp2Pd7uJjk1JAhGSCw+MdQm4m8P+ElgJbpHK46XUwnfGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KM1/7Czx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NqQG+OWS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KM1/7Czx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NqQG+OWS"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64R8E4Rc326869
	for <ntb@lists.linux.dev>; Wed, 27 May 2026 08:18:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rOANBoJGkhQTTtDkuoGE3NtKeQCxPUUpR+rdobnCBi8=; b=KM1/7CzxFiiGQQ0M
	MH6U23dOsfeKlHhc+t7VfbCHxjmpTUsEbFWTQadTUiPEO9BxiFLcCryd7sA4WRvX
	AInnGBcqyljcilciU2UJ5JYYaF1D+HZBkAN+9qfBjobwyPSqM6gt+lSsDPeW23vr
	V8XEFEonKZwWLdqdWGXhbzyk5722RoJkYuds3JrSfAjUPv9mLt17FO2KDQuGeBZn
	rsQtXyrjFDR2xVcTa0+XEGFjx9omJQgwX1sMBc8Xb8EGDyob6u8ET91s20AblJu4
	5n63g4qz16ycslD84192y3NvgZhHltRuDJPeXqd/+zYrxG0hodgGLqwCPIioCQVy
	QlRyHw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4edndnhj21-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ntb@lists.linux.dev>; Wed, 27 May 2026 08:18:20 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50fb3403e99so62911021cf.2
        for <ntb@lists.linux.dev>; Wed, 27 May 2026 01:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779869900; x=1780474700; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rOANBoJGkhQTTtDkuoGE3NtKeQCxPUUpR+rdobnCBi8=;
        b=NqQG+OWSC179LHLzhqbrZOErS2+ABQsNvbzUoMiU+LDRenyuipDkJOyNQnyd7jRZV2
         DBq6pfV5zz8Pbg/8AOeYPemA5B0f5MnNwWQbYJDN5fnSizOH4hJVjCHreWGW1DhBgYBU
         BhMmyxr+BYVBpnYH1ZD8M+SptZQEGrigHJnUX52Pt6+WOl6jcoicZUOFlImQX8L27TLK
         /zSIY1m7VHruKTYrQc+U5hteRFUYEfSUOpYOaOuR2mYMjnFxj0zOZjEb8cOC79PXM+I+
         NXUQn7/9uBibslmBl6SSUQQ2nM6UpZl9NVol7Nj89xGaH3rekZHbsRlvzg8siVhKaOOO
         PG8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779869900; x=1780474700;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rOANBoJGkhQTTtDkuoGE3NtKeQCxPUUpR+rdobnCBi8=;
        b=H9AaXmNwmsfWHgFzuuQNWhB9a/LQaVWktAJ4QPZJaswzegyVID5ms4GvlPcH1t4hQL
         r/75gnDJVVUSTsJ8smIZKokIFbL1TkWyREol6ICoRjL+Kbzx0mIeLsnPYP0ZgpXN0tJC
         YMMNRi0gV1Os25t/SnGIfzVULIK+sBeh0a0afYhJSHNIsYip8tupSBDXvqtU4boV2DZu
         t/WqGvyrGOPD6K4VUXq9swoSTcxnlQ8oRO6iKgbnQdUQot7UdcvpI3uXzcR9rcRfOIXt
         e+4BI2YLGCzYh3RBmSOWxUI9TbgULxtBOwHd5fWrBq8cO8HZkgu7qjUgDzuAexpcX5ZI
         /STQ==
X-Forwarded-Encrypted: i=1; AFNElJ/NHCKnZ3zxfQe6fljcXpbZsymjHMBPU8quTXPg5fJBDYPK8nK0+RA1+E8GjzS/aG6KkiQ=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx3qThSE4B5Yzs2QobE5qczoCrOfdTVPNPUfCC/uAcKWzLcq5YU
	6cV9ImHZcDb9+yU7x0NPReH0nxDUdWm8RF8DX9UQrfq6RFSlzVikNGPJR+D9fOojQooUw0ABaK3
	rG4SBoG892MoxiEgnHFDvJzTFaYG3YBNpVDMakxUzKEMWfeaEyVlFQ7o=
X-Gm-Gg: Acq92OH8Cy77w6D0DEeo8Jgn8LPSaDddOJEhPjPKlrQBmtvaMbsLkJvyqnMZg3yo1N5
	xh/MRIaT5lge7rdN6SBDHJpKMXYyg6Vpp4yNFWYi/XIjR9fmOP+6zE73PStTfgTHPi5oagqaiwj
	7skCQ1yZ78gr2akLE0LpIt2tqFYBkovX7umgsiUqZGPeAYcSfZcsSViO7FyypqnVBhbY6GJEavC
	8Z8oWz0+MShQMB90wFaEG7noDhlDZvsxj9Fbn+sk4IXi96yJvb9JJbfe+eta9WKpUVaXh623gbT
	I39k73zg4mVS6MfKfSU9E9IctDltXkZP3nGvv+cd0d0VEqToTqsgPy3IizyCe5VfA+I6zAh1SUz
	9wnmqHiUipArnSmzTmf9hG5lxXLjD/CCpU24/KM4CsavCBO7lUotGGf4gl7qIa/SCU60=
X-Received: by 2002:a05:622a:6119:b0:509:965f:888f with SMTP id d75a77b69052e-516d431d5efmr284072541cf.0.1779869899952;
        Wed, 27 May 2026 01:18:19 -0700 (PDT)
X-Received: by 2002:a05:622a:6119:b0:509:965f:888f with SMTP id d75a77b69052e-516d431d5efmr284072081cf.0.1779869899245;
        Wed, 27 May 2026 01:18:19 -0700 (PDT)
Received: from work.wifi.ville-nice.fr (62-193-63-110.as16211.net. [62.193.63.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb5b1a28sm4329959f8f.26.2026.05.27.01.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 01:18:17 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
        ntb@lists.linux.dev, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, den@valinux.co.jp, Frank.li@nxp.com
In-Reply-To: <20260407124421.282766-1-mani@kernel.org>
References: <20260407124421.282766-1-mani@kernel.org>
Subject: Re: [PATCH 0/2] PCI: endpoint: pci-epf-{v}ntb: A couple of fixes
Message-Id: <177986989704.12139.6324839457205446816.b4-ty@b4>
Date: Wed, 27 May 2026 10:18:17 +0200
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Authority-Analysis: v=2.4 cv=PpSjqQM3 c=1 sm=1 tr=0 ts=6a16a8cc cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xizqlaZpAqmNt8UN1ov9oQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=nDlXaIEONj1azYL8NVcA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: xs3Vj327WD1pXjhBr9rhw-W4l2djubHq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDA3OSBTYWx0ZWRfX469fo2jV/Mqo
 Am05vYuCRGFXNGl/bCSniyQjUnP8172W57CvS1opb5VUYnib0hVfd29PO1Hyj2QVEhQVMTTNVQ9
 zIchG2Bq0pJyeBIuGaLbKkOVqYqUtrTgZhNXwnVhVXPGO1z4xZleicrn4CLNaFNciKS0YVj8cT5
 18Mp+niKLq4+40AQhBrao8X9cDB3r6ynJhJ5Wpj/VlQ1VgFzOwnZl8uDQKlNWiCjonP9oId2GA/
 ku0SSTLoiE1bqU3wGAeiJTvs1dILK8YxLd8o2d3kdrCf45264ksfHBxzvCeEKL7+DV8cXXnfHBz
 T3PJpEMvhrdybZCuUPeSMEGd7WYic5Z9L+N6V2oAAs47QATQS+SSTk9cMbpKYnD2leIg1P7OW8C
 c7CMX9wNuZdvnD3jtsNkTT2p8CFYill6If8HPfWUclrKHSZUFE9NKBJOrSlNmgSqxwfExE1xIoo
 1bOXd/KW5xXKBAFz+tg==
X-Proofpoint-GUID: xs3Vj327WD1pXjhBr9rhw-W4l2djubHq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_05,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1015
 adultscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605270079


On Tue, 07 Apr 2026 18:14:19 +0530, Manivannan Sadhasivam wrote:
> These two fixes are flagged by Sashiko during the review of doorbell series:
> https://sashiko.dev/#/patchset/20260406155717.880246-1-den%40valinux.co.jp
> 
> Manivannan Sadhasivam (2):
>   PCI: endpoint: pci-epf-vntb: Add check to detect 'db_count' value of 0
>   PCI: endpoint: pci-epf-ntb: Add check to detect 'db_count' value of 0
> 
> [...]

Applied, thanks!

[1/2] PCI: endpoint: pci-epf-vntb: Add check to detect 'db_count' value of 0
      commit: dfd986796037ce31af73d8be416d98944ec84551
[2/2] PCI: endpoint: pci-epf-ntb: Add check to detect 'db_count' value of 0
      commit: d2942f5fc787c5e327ede76e0aea2cf41949e500

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

