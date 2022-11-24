Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5B02569
	for <ntb@lists.linux.dev>; Thu, 24 Nov 2022 11:55:48 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id w23so1271457ply.12
        for <ntb@lists.linux.dev>; Thu, 24 Nov 2022 03:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5tFoaZJ9Zngdk5YXFm9CRQu0l0Dt7f+Q0OVbqus0B9g=;
        b=Szq1aC9Wra2IsZFqObHsGmeRI22JZDC77KB/fn/y5FDl1j/mH9t1bt2oRO2s/VsJg7
         7++YyfrZAapEEDfLW0AwNAOxQj2JqhfS2eyYXsf83BRjBsaGqzALFQUn9U/JszeJRktf
         4HqbJk+4e6lzOTNxBu3E14KsUMxicRA6V93jEnLg9JNNLXUcDSEIbwXmlHdBRVR0b9IJ
         89QLi93nA9G6E7Cy9sfDxGpbYmsM/TtKM6qMLLLbwwcP7FdsCcg8PzWXqNKRVlzBaN7s
         zesRFiiIFCpF7es4an9DB8E4QRu/X6DYVBbH4mUAbiePl2Xh9xTnkMT+Js/iC/OTZk0z
         LILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5tFoaZJ9Zngdk5YXFm9CRQu0l0Dt7f+Q0OVbqus0B9g=;
        b=QI4vLz6l16ikKY3p7K4qBQTK5YFpCx9MRkBe9eYrpm6w/hSzp/GeV47bRk/4YyFgOT
         1lKIINkam+fzzKDnK9PYY6yFWDJ1GVQiBPWfrZR1bu9mW87DB54ibPF1dR5FDIhYvnet
         EgSQP+uMvg+jcNHZcB0wTJ+Q7jCmdIIrrMt7507BukPTvomJaLHVmk1JR3ybyE4VfbuD
         95Hvfjyr7AFMoclG1KizRQbHWByQWPj4/sAhWmoOchfbZRb1NxnH32Yo/wG/wU3TsVZL
         /C5wz5nsUNr1STLEF6VLd5cr5mOgxY5OJH5x+wAHuy/H+EMQ7nc3AA+CTMpE2VoH/0tg
         30sg==
X-Gm-Message-State: ANoB5pne8ifmpVID6wef0BzzY2v3crSlqkmnTecdbzW7IBpuwzOKpklS
	xptyqIWEaevzDTUb8vT2w7bHdg==
X-Google-Smtp-Source: AA0mqf5ErK/yTLbHh6wS925owcGQFojLs0Qt5kfkDM8yW/n5AlgaTkNUM7UboZPZKsKTOdXfrMbQOA==
X-Received: by 2002:a17:902:e294:b0:17c:620f:13ac with SMTP id o20-20020a170902e29400b0017c620f13acmr16312497plc.9.1669290948065;
        Thu, 24 Nov 2022 03:55:48 -0800 (PST)
Received: from [10.255.190.159] ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id ij13-20020a170902ab4d00b0018685257c0dsm1139212plb.58.2022.11.24.03.55.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 03:55:47 -0800 (PST)
Message-ID: <af5c0fb7-0de7-7ca4-4dab-16f41e1d8ec6@bytedance.com>
Date: Thu, 24 Nov 2022 19:55:39 +0800
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH v3 0/9] PCI/AER: Fix and optimize usage of status clearing
 api
Content-Language: en-US
From: Zhuo Chen <chenzhuo.1@bytedance.com>
To: Bjorn Helgaas <helgaas@kernel.org>,
 Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: ruscur@russell.cc, oohall@gmail.com, fancer.lancer@gmail.com,
 jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
 james.smart@broadcom.com, dick.kennedy@broadcom.com, jejb@linux.ibm.com,
 martin.petersen@oracle.com, bhelgaas@google.com,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, ntb@lists.linux.dev, linux-scsi@vger.kernel.org
References: <20220928105946.12469-1-chenzhuo.1@bytedance.com>
 <17b88750-53c2-0653-045a-dde921e37e0c@bytedance.com>
In-Reply-To: <17b88750-53c2-0653-045a-dde921e37e0c@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Ping. Gentle reminder


On 11/5/22 1:20 AM, Zhuo Chen wrote:
> Hi Bjorn, a gentle reminder.
> 
> Thanks and regards.
> 
> On 9/28/22 6:59 PM, Zhuo Chen wrote:
>> Hello.
>>
>> Here comes patch v3, which contains some fixes and optimizations of
>> aer api usage. The v1 and v2 can be found on the mailing list.
>>
>> v3:
>> - Modifications to comments proposed by Sathyanarayanan. Remove
>>    pci_aer_clear_nonfatal_status() call in NTB and improve commit log.
>>
>> v2:
>> - Modifications to comments proposed by Bjorn. Split patch into more
>>    obvious parts.
>>
>> Zhuo Chen (9):
>>    PCI/AER: Add pci_aer_clear_uncorrect_error_status() to PCI core
>>    PCI/DPC: Use pci_aer_clear_uncorrect_error_status() to clear
>>      uncorrectable error status
>>    NTB: Remove pci_aer_clear_nonfatal_status() call
>>    scsi: lpfc: Change to use pci_aer_clear_uncorrect_error_status()
>>    PCI/AER: Unexport pci_aer_clear_nonfatal_status()
>>    PCI/AER: Move check inside pcie_clear_device_status().
>>    PCI/AER: Use pcie_aer_is_native() to judge whether OS owns AER
>>    PCI/ERR: Clear fatal error status when pci_channel_io_frozen
>>    PCI/AER: Refine status clearing process with api
>>
>>   drivers/ntb/hw/idt/ntb_hw_idt.c |  2 --
>>   drivers/pci/pci.c               |  7 +++--
>>   drivers/pci/pci.h               |  2 ++
>>   drivers/pci/pcie/aer.c          | 45 +++++++++++++++++++--------------
>>   drivers/pci/pcie/dpc.c          |  3 +--
>>   drivers/pci/pcie/err.c          | 15 ++++-------
>>   drivers/pci/pcie/portdrv_core.c |  3 +--
>>   drivers/scsi/lpfc/lpfc_attr.c   |  4 +--
>>   include/linux/aer.h             |  4 +--
>>   9 files changed, 44 insertions(+), 41 deletions(-)
>>
> 

-- 
Zhuo Chen
