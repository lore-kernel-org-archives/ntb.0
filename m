Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7FA3BB40
	for <ntb@lists.linux.dev>; Thu, 18 Dec 2025 07:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766041668; cv=none; b=cHoI1FXfgd5pLtBK1LJRjm9kKzyvA+sslkOWOyCGdMk+6bbKmar4y5jAZhWikYKDSlKPxDrt58QGrL44XWRH1+U0DmRTezoDmcVZ8IjeUq9Z0epQ3LIKfLZR8qOVRO3zRnoePUQpHZd9+a0OcLdueQmNHipBf+plA1ePUYFg1FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766041668; c=relaxed/simple;
	bh=zhIWfIAbeRifEEK08wUVDmcfjUSY5wqTdVr2XzFL9uQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rHChyXKCsUOfHrumMwYSGyp7Su3bS2iw+EUbXzH3UI+IvZ+pQcY7g4GWGPI8VqKimnaMIDwDtS8twUQGqMRlULOQ4T4OoM9/SLSfHPcjHpIYZNG96BYfr+USn6QlSBFT4yr80QoaoaX0dLicIEFvHx5cGmTZUGwfIRJrC2G4tNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dltcYNCp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VB33MLUu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dltcYNCp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VB33MLUu"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BI1YVhU4057299
	for <ntb@lists.linux.dev>; Thu, 18 Dec 2025 07:07:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hh2VG3YFSe+FK0FMXraIExmjgFSAV/hqrMaw0XzNRPg=; b=dltcYNCp/PU8uew2
	7QjACqjs/kgLAhW472Y8MDYOyYoHFUmOefcrMjc4ISATDgFH+gAtePSKBFwVTKE4
	faCjmCGYNSoRwhBB4aYF5ZuPFjCJgfkEvLXjkel14Ro+NnGD0A+gR7HA5PkMTj8u
	8hWl8lTDK3ZltRfLD8O2z66i92bwTZjuMbMk3vjB1/IjQgT3Pm5+lVz7fnNfPCoi
	UB2nlV29AZ3S3Su5PJfjYBDeHjfa8yceZfF9rVDEMBN/idLZIP28wr0tThTm/dwb
	coGuc5Rr2HmtULJ4MMQ9QV9r6W3eQ8gXt4CKpU30WJEi/i+j/TiXbrYJhJB8Xa0L
	toeR/g==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b3xr5agvf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ntb@lists.linux.dev>; Thu, 18 Dec 2025 07:07:45 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7f21951c317so365659b3a.2
        for <ntb@lists.linux.dev>; Wed, 17 Dec 2025 23:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766041665; x=1766646465; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hh2VG3YFSe+FK0FMXraIExmjgFSAV/hqrMaw0XzNRPg=;
        b=VB33MLUuSYNUxIEwWqZ13yIOiy1SJrHl4W7Lm7iJZrvtMFprcEV2/ltHy4RWdD4gUW
         J/qDHqtx+J7VA6pz+Q/0i9qgQlJRMR7c+L+iiO2Kfv8QvseJCpfI7kJ641K795CMRE3Q
         dlhgAfB26jDyp3wKLGtntfJHc42NNBCXCb1nd6hTMEQxLXyv8R0NZ/wpcKFUWe4VSEqn
         +jw0DeLr5QYf0I8eCWRhjXuLgk9vcyqOhPly7h+HR+jScqOkpRzyJ9mRvoXjlTGJZmT0
         YeW7vaQdb06leky/dsyB5uYlbVwFc8wRLE5DkVW2EQTdtGZrZrl6XpLLWywAbiREQ50M
         Ibdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766041665; x=1766646465;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hh2VG3YFSe+FK0FMXraIExmjgFSAV/hqrMaw0XzNRPg=;
        b=Tntn04eZe7dKl+RfVepRmUGZRWKIwGHzav5ua4BATWhgtZ5x6MuS4R/vcgx1UlwAeB
         u4vlpzfDgP8yz1vCPbr4sVZH1uq/fA1C31jkwbusv8rtqiNQ6fBj2MFx7KfqLkuEf0Jf
         NzFgeMLEh38ZFJRpFHFAsrF0sS65xWrSI34xGhXComSrXZFsZv5lpAAcyLR+oCjwmFR+
         5kG07yAv2AyRoLZUT7lPVXAGo6OKU3vyjvTzQeIow/AXjGWQ/uGyUVkpNtSlilsVUubc
         DvWtivwozppQIfVcZfOXTusB/LqoiIUtpjqcWZvxa455kMbeQL2URUZuFjjJJJOgbcNQ
         qkYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWS6311TjA/e8p9HqkLg9qmb+j/lnVnNYyKKWkUewj1ZQ9pgBGiVhCWmO0QTc/cRO5N4Fw=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx2KVoVEnULGoItfbVyzXcZ/kvptwi3mf3oKqdtHvM1phXyUVYa
	6+yEpSivIIPmhpmKIN9OhTjjf8C/kMNxOqqzUM3XTvLzOPZwXAD6TDoLqVht0ZjBXnADF1mj6db
	2OzxBhYWlhaigHwwad1zxk6bIg6gNX2wQr5TEqIriwwof+g4Fqq6XVdM=
X-Gm-Gg: AY/fxX7Uq7iTvewxcawU1AWX3VgevuKJDUIgjLHR0mVTqp8AHxWLN474pYqb86hJZ7z
	SjhwwvP28szE/6w2+c3wPiZ7gQoIT36nQMOEtzePVMgpWmA6ccdROL1G28d/7vaiGUiUVD8y4IR
	i7ZSgE9GYpf2IEM9zPApw+IBN37UYcGs/VM5HWCzRS/fMmH234mJSi37POojShnpyZFWI8uLXW4
	wuksIR9VtNnDPoI1MNEQB3JT1hSqBarrM5NNKn4IUNJzBRekamEKkJG5Wxi+ngLE9fsAW9fG+HM
	NbF8Oeo7hf0ymgf8lXZjOMHb3m4lFFDq6VXQRuTs9tsjgA6EsK5vnwJ2xZoKcFh+FN0WE71anrL
	qSqDHgtATSCQ=
X-Received: by 2002:a05:6a00:bb84:b0:7e8:4471:8e4 with SMTP id d2e1a72fcca58-7f66a470cd1mr19278071b3a.69.1766041664692;
        Wed, 17 Dec 2025 23:07:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFe3idJUw0yYXcoiRiACrwrk0j6tYdjgrteRDIaFEJ8ebk4f1vPq+K+YB7SnXBa2btwDjYWQ==
X-Received: by 2002:a05:6a00:bb84:b0:7e8:4471:8e4 with SMTP id d2e1a72fcca58-7f66a470cd1mr19278038b3a.69.1766041664194;
        Wed, 17 Dec 2025 23:07:44 -0800 (PST)
Received: from [192.168.1.102] ([117.193.213.102])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7fe1185704fsm1558626b3a.13.2025.12.17.23.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 23:07:43 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        ntb@lists.linux.dev, Marco Crivellari <marco.crivellari@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Michal Hocko <mhocko@suse.com>, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
        Krzysztof Wilczynski <kwilczynski@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
In-Reply-To: <20251107142526.234685-1-marco.crivellari@suse.com>
References: <20251107142526.234685-1-marco.crivellari@suse.com>
Subject: Re: [PATCH] PCI: endpoint: add WQ_PERCPU to alloc_workqueue users
Message-Id: <176604166015.697128.10969426809262148398.b4-ty@kernel.org>
Date: Thu, 18 Dec 2025 12:37:40 +0530
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: BBs3laFiceaHqdevhJogZqxg2UdMr08a
X-Authority-Analysis: v=2.4 cv=DsBbOW/+ c=1 sm=1 tr=0 ts=6943a841 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=PLOdWElDzbaVVj/XHNhp9A==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=_suGTTe_43wmAZudwJ8A:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDA1NiBTYWx0ZWRfXxJ09EuMqHQ24
 zcqQCaAVNbS2Rya3QTqyjQJPncRXzYadWPT0erwhM9tOIHSsS88WIWmkJJrDwA30ukzrse4uF3Q
 ZxUmedvfwt26FlYETeR+ILvI73F9kilMSntZlJGksQV/6Z8/0FW33MKK6HMAzGGwPO1/VGQbpmR
 +RRtQBs49KnzNFjPoRRDgGGG8aMmFtfhWzrtj6ye9x7enwyjLRYUBwYOzKvFCv59a6lveuCFKis
 80UkTjeax8pyVYwBw4RZIXEl6/gj18TxcNWEDoqwlyDBrLTwOQGBUxxr1Twqsx8prOLKhJbmmjp
 8h6/u4lZ2RqgqfJLh4Xcw3tFqRMY827uhVFIVj/moC5M50wsIa5DygH+NGexxf33FEZ78R92/N0
 ELdZv4KeJghBBKw504en45TfmC5xqQ==
X-Proofpoint-ORIG-GUID: BBs3laFiceaHqdevhJogZqxg2UdMr08a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0 adultscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512180056


On Fri, 07 Nov 2025 15:25:26 +0100, Marco Crivellari wrote:
> Currently if a user enqueues a work item using schedule_delayed_work() the
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
> This lack of consistency cannot be addressed without refactoring the API.
> 
> [...]

Applied, thanks!

[1/1] PCI: endpoint: add WQ_PERCPU to alloc_workqueue users
      commit: 8b2ff37c6b50cbe722ebd780aac40f92c4f8efd3

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

