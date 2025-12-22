Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC10C30BBBF
	for <ntb@lists.linux.dev>; Mon, 22 Dec 2025 08:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766391256; cv=none; b=g8bKW3PhWH+BzBQwLFztZuwWUEN7NoQeBrmprQAl3NSqt3wpGuNOS0CD0kncth1JRSXHMfwCcA5cP9NZp6tls/5oofE2qh1JpNX4+PA5Jx2viM7x0862lAfIaF7rfee8J/jnuT3ANU4eJ4zKQTf3jUgAAzz2Qp7UY3Ya+4F4l7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766391256; c=relaxed/simple;
	bh=ug4yylwNcO90NJvpE3SC7VOMbFwgEshDUXvRfWQd9TY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MB2KZ20B6/yzCKVexYzeMY0dAPpZTtFgCAYvykwBxmfEZLHuik5aKEDfiJQpKdMfaheAF4OntOIxvkNlkwSMkbebTgjbuQfb9yqHXKwQXS+upk5QnVZKiLEOQQZc7cwPDT3F7bqLE4DDDn4gcm9ZvfG7LHRtLsXp1dTwtk09qgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gLS+j2GK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JPFzXxhS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gLS+j2GK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JPFzXxhS"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BLMrKvi3799601
	for <ntb@lists.linux.dev>; Mon, 22 Dec 2025 08:14:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cbxoIvggTHwJGPAyfPp+mE9GnjxpExWzAQ+NnFf0Hcc=; b=gLS+j2GKE+o26XxJ
	09rshfZSMea52CyGG6s8CXRBs45zFtBLYGt1nTkJS/UukmbwGBe1rbkueX5WQWKh
	XINKSK5P6lmg1kvpW7ip+Sp0Y6JdPZK0VD0nG+7Gel9VQ7rhGHYOKfDgzm7CQw2u
	o5DtXyFS+XmYg3dba8o9BnTQ4AiYBjLKZ7Pf3qLqeOFMMggmpt0UcOfxIlgXKXhx
	KCpWN3BZcNomRwybcxiOJAM1z1q1YVH8LGixmpCnBo95tKys/ed6BiLmKR2Vbjm3
	eYpdOFaOLlnj9tYkLc4h3cpYKEkz6nAKk4UA9F61HJvMbvSdCEgQ2qUmWjSrpTK/
	3zvKiA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b5mry46xf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ntb@lists.linux.dev>; Mon, 22 Dec 2025 08:14:13 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34ea5074935so2054176a91.0
        for <ntb@lists.linux.dev>; Mon, 22 Dec 2025 00:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766391252; x=1766996052; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cbxoIvggTHwJGPAyfPp+mE9GnjxpExWzAQ+NnFf0Hcc=;
        b=JPFzXxhSFA1P5bk2YnAv0rYWErZp4gTxqyM0rbPGRCwxTs/IpCNdfFUICu4wi+mTVr
         DC42tyasO79AO9snhRtcptkLbrYPR/btPKUs7rmTS/oYiQ3AwABkIMo9XPz9dG4pgyxZ
         vdYklGSQQT7NG8cNdNnuFTCXEQNyNkDQHgvazii4s1zKvLvZQ1VMRwDO1ZpFGd5GidLE
         VXiaWEPGj1OvEu2/DfUcqMmP1eWX6HUP/wX60PiJ392ByuP5Jp3wTw0yTFUGOzqQPr1U
         5TihCJ5Qsj67fFIxyE2yLm6q+X1V9rsuYp6VvKhWfiwwRIPgzXMVVO/saIW1Gbgh1Mk3
         vzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766391252; x=1766996052;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cbxoIvggTHwJGPAyfPp+mE9GnjxpExWzAQ+NnFf0Hcc=;
        b=GqtARB4JoxHLkg8NAfh1vJ3X+M8ZtgOam9g5fyq6BJCzwhE7ergjxQRGrjRI0C+Mwd
         bJynv/rOxNlGg8U1tfw20lsMuEflhX4HfcFoTVZ7r/nKKOclJqcRU6j7gre5Ly2M28Zz
         BlFYFp5vVbHYkncucrkd/jaFPsjzHwDG2BMTn3YT1fOunQGAmMn+aq82RO+poGIJBmhi
         0jBkhkG/1gnLH8oGOZiGwhLrQfTu6dh7zfEluPqnNGXnzlzIf+nPHAIN6ljsTGIhJ0qD
         s//OePMXsHhdhTiBJ1uKYm1BDvuPdqiE0WrVpem10WEPjSfqu0JywWW4wimHiRRcRwhG
         mO7g==
X-Forwarded-Encrypted: i=1; AJvYcCWeL/FXHGxE6TvyqLVv9Tnqk3MfZwysipB6w4pKtPbUugJ2pGtzn/qTXwbFi5CRE0YHpLg=@lists.linux.dev
X-Gm-Message-State: AOJu0YwpmyKyqBC3QmcBmb6ARTslUeTU0/mPS4rnt3xwo7wx5r+v0gna
	jI4KJ/q7+je6sdDoyow5vDNW0FCrxudVldsFREeT1qeWZKZGWaQnySgoPe8dBmAeum4KKmEAlEj
	DIN1cul+Jx96MuJj0hA1X0ptQ6ZhNX0ZGNMW31vY5DbgiwNjP1FjX6Lo=
X-Gm-Gg: AY/fxX4tiqfvfUdUgk8NMKAdclL++bjG3cbR7H3nWnSgOmxYDV90Er8umr6SRAKB1iW
	4CZcZoVdEX0KHuCJ6k4lPmJbSzaLK3dmwQZQ9mW3xuojomY7WWtbNBjnro5KvaI8126eqBfYESF
	8qAhgSi8WYmKpLk7N4zF+0L/PNuRvNnEPiIiwOx6PJ3rWSJ65RPFMhXGqT5bn+YDFlR9KECSZ08
	ue6DegJT8Ncevazxo30OqKJ70zMVis/DPVIrRrQkFgT5kdWbm2/z/Srox5Q2FeD/UyivUtQ8F2V
	KbQ217hNGMlAyqZRPr8zfb7z/amNIAzZoyGE8Ehx/d57nkulmRW45Or7hEclBgjgK1WaNPxf9g+
	WaFEdfv9oTA8tnGNOK2tQZj8QOI4QMc48nZy2E3FDXQ==
X-Received: by 2002:a17:90b:1d83:b0:32a:34d8:33d3 with SMTP id 98e67ed59e1d1-34e91f749d8mr8077464a91.0.1766391252413;
        Mon, 22 Dec 2025 00:14:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1Go09mxe6FptC6uL4OomBUKer2vZ4FaNIffkFWpnND+g9IVqxiqRcg2zZV/2/WJ8KZ0XTqQ==
X-Received: by 2002:a17:90b:1d83:b0:32a:34d8:33d3 with SMTP id 98e67ed59e1d1-34e91f749d8mr8077421a91.0.1766391251826;
        Mon, 22 Dec 2025 00:14:11 -0800 (PST)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70dbd618sm12166827a91.12.2025.12.22.00.14.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 00:14:11 -0800 (PST)
Message-ID: <a7b94f8f-8773-43b0-b481-29828aba9abd@oss.qualcomm.com>
Date: Mon, 22 Dec 2025 13:44:02 +0530
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 19/27] PCI: dwc: ep: Cache MSI outbound iATU
 mapping
To: Niklas Cassel <cassel@kernel.org>
Cc: Koichiro Den <den@valinux.co.jp>, ntb@lists.linux.dev,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Frank.Li@nxp.com, mani@kernel.org,
        kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com,
        corbet@lwn.net, vkoul@kernel.org, jdmason@kudzu.us,
        dave.jiang@intel.com, allenbh@gmail.com, Basavaraj.Natikar@amd.com,
        Shyam-sundar.S-k@amd.com, kurt.schwemmer@microsemi.com,
        logang@deltatee.com, jingoohan1@gmail.com, lpieralisi@kernel.org,
        robh@kernel.org, jbrunet@baylibre.com, fancer.lancer@gmail.com,
        arnd@arndb.de, pstanner@redhat.com, elfring@users.sourceforge.net
References: <20251129160405.2568284-1-den@valinux.co.jp>
 <20251129160405.2568284-20-den@valinux.co.jp> <aTaE3yB7tQ-Homju@ryzen>
 <4909f70a-2f65-4cac-96ac-5cd4371bc867@oss.qualcomm.com>
 <aUj4M3z87MwFSUFW@ryzen>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <aUj4M3z87MwFSUFW@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=cbbfb3DM c=1 sm=1 tr=0 ts=6948fdd5 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=9AdMxfjQAAAA:20 a=VwQbUJbxAAAA:8 a=P-IC7800AAAA:8
 a=XlojDObrNaimPXCU0dcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=d3PnA9EDa4IxuAV0gXij:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDA3MyBTYWx0ZWRfXwIHk9/w5Z7AW
 4bGocmgJTNfg+9ZQYSH8h3jPo3f6t2q7PVw2BvgYBjU7esFakKi7/fddtvBTIwI8Zys/k93hZuh
 z9Kr6s/3osWUDWhZTnjOjGEbibzn+sTMEbuEiaTCplvUy3Ff9aqNlrcYe+OBwyjA1CvIj+ruxG+
 c7nPVoF8xUagBh2ECZInxiC8YWEjEkesQlXHGXSbwJyvuTdZlWOv68JvFXY8DbOgLt5luMMWg1B
 /m2038RBHzoIGHk/kzwIYd2GbH21Bk+jSPfFg934UP0jzRQGzzeglSKMm5Q8Qp3vnMAx57MMTIV
 yPmFHLf28+b9GezYUhaiZm0IN3DyYGgJSt1674ewZJuRcAtyDBHjPsm0uaQ/eUgHx1YSXpvFPMJ
 QfNylfXEvuEsCN8UyHzxpQGKc7BZgPWaD9VbEnLrOaz5501xv1HqbAKYE6hKfB/U+GKuuwIFaN6
 JZffUPhFi2A1meZBvSg==
X-Proofpoint-GUID: bkpWvSybATekISvospETtpGbZIFiMxb7
X-Proofpoint-ORIG-GUID: bkpWvSybATekISvospETtpGbZIFiMxb7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_05,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 phishscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512220073



On 12/22/2025 1:20 PM, Niklas Cassel wrote:
> On Mon, Dec 22, 2025 at 10:40:12AM +0530, Krishna Chaitanya Chundru wrote:
>> On 12/8/2025 1:27 PM, Niklas Cassel wrote:
>>> On Sun, Nov 30, 2025 at 01:03:57AM +0900, Koichiro Den wrote:
>>>
>>> I guess the problem is that some EPF drivers, even if only
>>> one capability can be enabled (MSI/MSI-X), call both
>>> pci_epc_set_msi() and pci_epc_set_msix(), e.g.:
>>> https://github.com/torvalds/linux/blob/v6.18/drivers/pci/endpoint/functions/pci-epf-test.c#L969-L987
>>>
>>> To fill in the number of MSI/MSI-X irqs.
>>>
>>> While other EPF drivers only call either pci_epc_set_msi() or
>>> pci_epc_set_msix(), depending on the IRQ type that will actually
>>> be used:
>>> https://github.com/torvalds/linux/blob/v6.18/drivers/nvme/target/pci-epf.c#L2247-L2262
>>>
>>> I think both versions is okay, just because the number of IRQs
>>> is filled in for both MSI/MSI-X, AFAICT, only one of them will
>>> get enabled.
>>>
>>>
>>> I guess it might be hard for an EPC driver to know which capability
>>> that is currently enabled, as to enable a capability is only a config
>>> space write by the host side.
>> As the host is the one which enables MSI/MSIX, it should be better the
>> controller
>> driver takes this decision and the EPF driver just sends only raise_irq.
>> Because technically, host can disable MSI and enable MSIX at runtime also.
>>
>> In the controller driver,  it can check which is enabled and chose b/w
>> MSIX/MSI/Legacy.
> I'm not sure if I'm following, but if by "the controller driver", you
> mean the EPC driver, and not the host side driver, how can the EPC
> driver know how many interrupts a specific EPF driver wants to use?
I meant the dwc drivers here.
Set msi & set msix still need to called from the EPF driver only to tell 
how many
interrupts they want to configure etc.
>
>  From the kdoc to pci_epc_set_msi(), the nr_irqs parameter is defined as:
> @nr_irqs: number of MSI interrupts required by the EPF
> https://github.com/torvalds/linux/blob/v6.19-rc2/drivers/pci/endpoint/pci-epc-core.c#L305
>
>
> Anyway, I posted Koichiro's patch here:
> https://lore.kernel.org/linux-pci/20251210071358.2267494-2-cassel@kernel.org/
I will comment on that patch.
>
> See my comment:
>    pci-epf-test does change between MSI and MSI-X without calling
>    dw_pcie_ep_stop(), however, the msg_addr address written by the host
>    will be the same address, at least when using a Linux host using a DWC
>    based controller. If another host ends up using different msg_addr for
>    MSI and MSI-X, then I think that we will need to modify pci-epf-test to
>    call a function when changing IRQ type, such that pcie-designware-ep.c
>    can tear down the MSI/MSI-X mapping.
Maybe for arm based systems we are getting same address but for x86 
based systems
it is not guarantee that you will get same address.
> So if we want to improve things, I think we need to modify the EPF drivers
> to call a function when changing the IRQ type. The EPF driver should know
> which IRQ type that is currently in use (see e.g. nvme_epf->irq_type in
> drivers/nvme/target/pci-epf.c).
My suggestion is let EPF driver call raise_irq with the vector number 
then the dwc driver
can raise IRQ based on which IRQ host enables it.
> Additionally, I don't think that the host side should be allowed to change
> the IRQ type (using e.g. setpci) when the EPF driver is in a "running state".
In the host driver itelf they can choose to change it by using 
pci_alloc_irq_vectors 
<https://elixir.bootlin.com/linux/v6.18.2/C/ident/pci_alloc_irq_vectors>, 
Currently it is not present but in future someone can change it, as spec 
didn't say you
can't update it.
> I think things will break badly if you e.g. try to do this on an PCIe
> connected network card while the network card is in use.
I agree on this.

I just want to highlight there is possibility of this in future, if 
someone comes up with a
clean logic.

- Krishna Chaitanya.
>
>
> Kind regards,
> Niklas

