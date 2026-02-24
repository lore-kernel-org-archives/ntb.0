Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206EA18DB26
	for <ntb@lists.linux.dev>; Tue, 24 Feb 2026 10:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771929314; cv=none; b=lUjpRO4JIwGVbChcS9cv6WAcOSM88T9PblykJGAqd8Xmr6Q+2njg1ozIP6ZVuaxSoWiqncyx7dysC4Qtc29DgtruZhzn/RPPdmXkh5NYT/r8Tm/+S1mrz9v1wemLcPgeGd0OgkSCvQwS+1/REpI8Q/APX6p8WOepAALkA3Uv8N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771929314; c=relaxed/simple;
	bh=Hmrd+OfmBtJB17+5qKn46EzdFcAU3+al6tJtRf/o1QY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gFsXiMlnm2W16dYWfcmgwKxzE0j2UaBpURZ3AKQcxpS/4J3m7gNdX6WvWL1fVnuWeliVHyqHtWVpw+VXmrS+Rr96hZQiSH8haLmGMalJfZsZF6Cqw9C4sk+ItpgIz4CDKe47yU8jPkBJBUuQ/7MDsl2wsHvxP5MfJP+cioVuMEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Uc/4G2OA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=in79PlEr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Uc/4G2OA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="in79PlEr"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61OAFVGm3324766
	for <ntb@lists.linux.dev>; Tue, 24 Feb 2026 10:35:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	404yW9mmLcSV0ahGgG9KVm2+iwQOa/bAZLN3bfCXUyk=; b=Uc/4G2OAkIdd6eIL
	GkvpSxtmLqmr8VQA8vRb16NlrRo+G8ESS3ynPwe4y+oTxiVJN0JmRpOWbfdANqI7
	vf7VNESV+b+xa5LB4RSCSZUD7J8BgA6Xug/KuLZMoDLIyKR9ZW69eO7bsxIb02H1
	KXZfsz4pc5cmfQzc3hJIP7v2tdnbLwiIXCE3ZL/oG+3yOSm2zPJl+hemgMsuXRiK
	Du64Cv2eWDxeQ0Aeu4DCD56WElsoUJmn1Isb7O3wZS+eG6/C+D0Q4uVZ7i1I+l01
	c2ydDgu19rpyEvR1Rc1bpbEq3vRpykRjQvf9xn8Am29bJhYRpyi7/YK5kgefOQBi
	ZzspTg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgn8y3vrh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ntb@lists.linux.dev>; Tue, 24 Feb 2026 10:35:10 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-35449510446so5382153a91.0
        for <ntb@lists.linux.dev>; Tue, 24 Feb 2026 02:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771929310; x=1772534110; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=404yW9mmLcSV0ahGgG9KVm2+iwQOa/bAZLN3bfCXUyk=;
        b=in79PlErrJ629onUiV/0xY7npSFejBz/uE3biBJObYSD/pmG0JZDwazhXs03I5efN3
         i8jXATXmuQKxy0F9CpODooflN5ch8x05Rol8AbdbglcosJnzfbjJrvY4w+TmJvQTPTa7
         ddJjqlIRfMQabT5Nmq+xpJzRPhj4pJtZH3+buOluaHJIB+J8YkMe7yr9Gi2eVXDbGopA
         Hyr4fvMIawztGBNzI7XaoL6afCedXegP1b5nCBajtTiAq+u5eYjPsQKHXn2Q0++qd4WA
         j/IYSILe0eF3uaeFKYlKdAkto+iZrL83scxZdEhg+0jKss6/KPLEzMY41dopsE3QsdCv
         bUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771929310; x=1772534110;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=404yW9mmLcSV0ahGgG9KVm2+iwQOa/bAZLN3bfCXUyk=;
        b=bpep8nV/pf9DhQci9M0e3wKx+cXzw8xXIoLUTzj5jWm+sC5G63MUtPeV6dLzna5xLy
         xSHhihgme5SGNzJP5HOiqLMtSTxnvwYh0eeknAHt8r5jh7vtUEqVVo0A8kmXGVFEX92q
         4a9JwWm3aH2fs4fqHB679DcnPOljLyTNU8BQ/6dplCoUdNe1/kkV8b/lOkUcLbtH7jfA
         W+X/mA96PPD+2At0aTA7nI/vwbBqnCNZS10cajoSO0dh676eRe/IGD2dFsZcgJFuWEwI
         Hn3q/xREncvR5u3eHSicdz4Wf+u+AKb6rxrq86fXSlZ3pu4bbuLSApj5gCAIqnuHCoc1
         MBfA==
X-Gm-Message-State: AOJu0YxZepxBFlrGcYQD9fzEMq2NnQxRgpBfoZXDus1XIhLpqp0yTIFO
	+asZw2LFuxbrzFwkaGMIxOHDa2wBASvTUfLsImRTtH3mCd7EXKsn2WTpLRBMO8zEhLNS7kDh1iY
	kh0kEGZ2Jq0F7oxtiJPeMe0/UDgiM5UtOmiMSSMU/rZWA770y/OMoaX4=
X-Gm-Gg: ATEYQzyjfKaR2eyHbsZ6Y/FxT65C42AM9mgYlKTW0eFEsDpdqmLZj58flvexLNJOCop
	zHbIameaYDQRRlfcJChIBh2nlSVj6sZA9uL2BHDZENYDq/FARxQZemHwD/nr1/q0Kue7j5+1KVo
	X2dkRb0LJpodP0YHIk2AwgDrZ1sGauZaFdZCiV5n1fn8t2iR8QlgZUd9cDf8iR5F+1OAOjzK7aY
	0nj6GdJcUB5Wqm58h3Ergzd6hRkDWB6DlMHChOfzj/nLUTzbuCIWVW/6oVO8theGFPbCTXMMe2u
	bjeHQAspdsrPur/+rJSP+xGGEPoJl9799zNSQUM6njyQuTSwi0Zrp1TrdvoT9TcPNwwSvEKuwnL
	TkIkrUue1VmILzX1i5ktFAIo=
X-Received: by 2002:a17:90a:d407:b0:34c:7182:cf9d with SMTP id 98e67ed59e1d1-358ae8c6ac1mr9261756a91.25.1771929309919;
        Tue, 24 Feb 2026 02:35:09 -0800 (PST)
X-Received: by 2002:a17:90a:d407:b0:34c:7182:cf9d with SMTP id 98e67ed59e1d1-358ae8c6ac1mr9261736a91.25.1771929309381;
        Tue, 24 Feb 2026 02:35:09 -0800 (PST)
Received: from [192.168.1.2] ([2401:4900:8fe5:3076:bc82:a67f:ae4a:6d25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-358d78a9dfesm1374205a91.0.2026.02.24.02.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 02:35:08 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
        kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com,
        Koichiro Den <den@valinux.co.jp>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260105075606.1253697-1-den@valinux.co.jp>
References: <20260105075606.1253697-1-den@valinux.co.jp>
Subject: Re: [PATCH] PCI: endpoint: pci-epf-vntb: Use array_index_nospec()
 on mws_size[] access
Message-Id: <177192930530.12333.15482985768888162269.b4-ty@kernel.org>
Date: Tue, 24 Feb 2026 16:05:05 +0530
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDA4NyBTYWx0ZWRfXwf+qpdYYdzw1
 EV0+V8MsZyw9Q8DQJT5i0+XKPx3kpZwMUbZGNJQh8IjVNwxiKhf5f6iIHcsP85liDcCN1CZiYym
 bq9lATLkTCRvCuZ7HyJ2BpXW3fgwICK9q3rBW/XkcnrtYZ3wgmxwdoXWRhu3Oqp6RqbTrvBJUIo
 +jf2jULCfMmlk+bmYwEQSxe343e45z4Ja2qdjFu6SdzR3SDu5xcDxERRxxBzEDgjdVM3cW111XV
 tb/YcGRS75vXHQhUTIDqpqZNg8mvLK/MB6pxQ9aIuENgDS7zaIa3aarO24wB0sLoZHCFGbxEvoS
 8pHm2gEBNQshRTZ93aDmIQkZQtFtdEhWryshmmQRS2u2Va9NkVgR8+uttE3vxPTdFS8YpbaMhrP
 O93pXH2AI4A3bjEouniUauuO6CvaK2QFcahZ2zN4zvxnqr7m1j9ERaahKkDF8/aRV4MPlb0z2NN
 Dul0ulu2aErPNAneD8g==
X-Authority-Analysis: v=2.4 cv=edYwvrEH c=1 sm=1 tr=0 ts=699d7ede cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=VKWO6qudhil8k8BZnYMA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: R2T2lchrdW4tBk869jk25fJ2EIRO7ce_
X-Proofpoint-ORIG-GUID: R2T2lchrdW4tBk869jk25fJ2EIRO7ce_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_01,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602240087


On Mon, 05 Jan 2026 16:56:06 +0900, Koichiro Den wrote:
> Follow common kernel idioms for indices derived from configfs attributes
> and suppress Smatch warnings:
> 
>   epf_ntb_mw1_show() warn: potential spectre issue 'ntb->mws_size' [r]
>   epf_ntb_mw1_store() warn: potential spectre issue 'ntb->mws_size' [w]
> 
> Also fix the error message for out-of-range MW indices and %lld format
> for unsigned values.
> 
> [...]

Applied, thanks!

[1/1] PCI: endpoint: pci-epf-vntb: Use array_index_nospec() on mws_size[] access
      commit: 26cd5ca272a44031c4ff381928aa1b816829d18d

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

