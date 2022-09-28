Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA6D4406
	for <ntb@lists.linux.dev>; Wed, 28 Sep 2022 15:54:12 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id 78so12557854pgb.13
        for <ntb@lists.linux.dev>; Wed, 28 Sep 2022 08:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=QSAEb2hPZjK1ev/lBZ3te+y9kjBYl6H9pPRLwr+M8HM=;
        b=zVPtZAzw49EHbsqZqHSTXnYA4fCJVgV0ehiFbcHyaUHvs7WCLafoa7uK8ML2BgDos4
         U3FTz1fzfHSRaG2aOZCd8/5mNO7Axa7rX0KW2D5mLDTSbLVEtkUQOx6vb/WyEcOgh4Uz
         G3MWAF5BUbXqgxQMBe6juX25LkAKPlRyvo63Wzt+Yv3rhBiZNaVmN2vC4IinqkH8thMI
         fcW+q5fTcp+dYGYs/mLBTunIT/PtRbJH+KvZjES40kJqik7SN1sR/JSsLEQ/r4w+dY53
         yZdvlKWU6xrLQVlPNbzhwy4LOQyi9Q3bXls/2CE0MyPKoxajKOawzKhM6WGhLzi7H/dw
         P2bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=QSAEb2hPZjK1ev/lBZ3te+y9kjBYl6H9pPRLwr+M8HM=;
        b=eF5G6YYYR313Q/ASU4SDkjwSLbZ9YjEPgtcfr6pJQJ7XQWoS7TeWNrZfZ36NmWg871
         TeOsVhW1YWh07edSds+b7/hm/yAFFqRyDX9sIy9B7xJ4X1q/GisT/MpwmLRVKT4ZOGeC
         wI8uVzbfKkF9DXgcw+JlJZsr/fAnueaGWKdXZsF1P+pqJSwmhKdYlLAs0Bo5ulu4Uv3x
         FE4XZO2elVkTUcJCEcHnmWU9BjZKp2ciUMK2GbiFj4tZkPDPO6F9bta09HTFzqIcieft
         NbGdWWL52DWmtfHJXdknNccaM/mEuad3bv0kxClgXQpCVk+q+TekKjwQhj0Hjdvuw6kx
         vTog==
X-Gm-Message-State: ACrzQf0Z5jmZTKR19fQxOkWwxpJXlWZyYn44y8OWVvOgBaRoYdLwc66q
	KEiWJi2h3wOHaHf4X2Nnpv2yEA==
X-Google-Smtp-Source: AMsMyM7wU01xLNnTTslW5qPcH9U0d3210mJJyOX0dSh6iYjiDoTkBczR8AGldIXcdzIutrYwjwxMXw==
X-Received: by 2002:a63:5c07:0:b0:43f:6af:7590 with SMTP id q7-20020a635c07000000b0043f06af7590mr7563656pgb.272.1664380451650;
        Wed, 28 Sep 2022 08:54:11 -0700 (PDT)
Received: from [10.2.223.68] ([61.120.150.77])
        by smtp.gmail.com with ESMTPSA id i28-20020a056a00005c00b0053e72ed5252sm4231499pfk.42.2022.09.28.08.54.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 08:54:11 -0700 (PDT)
Message-ID: <eade28ce-97eb-ff96-e8cb-7e1c2127f77b@bytedance.com>
Date: Wed, 28 Sep 2022 23:54:02 +0800
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.0
Subject: Re: [External] Re: [PATCH v3 0/9] PCI/AER: Fix and optimize usage of
 status clearing api
Content-Language: en-US
To: Serge Semin <fancer.lancer@gmail.com>, bhelgaas@google.com,
 Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: ruscur@russell.cc, oohall@gmail.com, jdmason@kudzu.us,
 dave.jiang@intel.com, allenbh@gmail.com, james.smart@broadcom.com,
 dick.kennedy@broadcom.com, jejb@linux.ibm.com, martin.petersen@oracle.com,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, ntb@lists.linux.dev, linux-scsi@vger.kernel.org
References: <20220928105946.12469-1-chenzhuo.1@bytedance.com>
 <20220928110623.b3vocoubasrshyzk@mobilestation>
From: Zhuo Chen <chenzhuo.1@bytedance.com>
In-Reply-To: <20220928110623.b3vocoubasrshyzk@mobilestation>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/28/22 7:06 PM, Serge Semin wrote:
> On Wed, Sep 28, 2022 at 06:59:37PM +0800, Zhuo Chen wrote:
>> Hello.
>>
>> Here comes patch v3, which contains some fixes and optimizations of
>> aer api usage. The v1 and v2 can be found on the mailing list.
>>
>> v3:
>> - Modifications to comments proposed by Sathyanarayanan.
> 
>> Remove
>>    pci_aer_clear_nonfatal_status() call in NTB and improve commit log.
> 
> Failed to see who has requested that...
> 
> -Sergey
> 
Hi, Sergey

Currently other vendor drivers do not clear error status in their own 
init code, I don't exactly know what is special reason for clearing 
error status during init code in ntb driver.

An evidence is in pci_aer_init(), PCI core driver has do 
pci_aer_clear_status() and pci_enable_pcie_error_reporting() in common 
process. So vendor drivers don't need to do again.

But I don't know the reason why many vendor drivers reserve 
pci_enable_pcie_error_reporting() after commit f26e58bf6f54 ("PCI/AER: 
Enable error reporting when AER is native"). Do they need to be removed?
Could Bjorn and Sathyanarayanan help look into it, thanks a lot.

Thanks.
>>
>> v2:
>> - Modifications to comments proposed by Bjorn. Split patch into more
>>    obvious parts.
>>
>> Zhuo Chen (9):
>>    PCI/AER: Add pci_aer_clear_uncorrect_error_status() to PCI core
>>    PCI/DPC: Use pci_aer_clear_uncorrect_error_status() to clear
>>      uncorrectable error status
>>    NTB: Remove pci_aer_clear_nonfatal_status() call
>>    scsi: lpfc: Change to use pci_aer_clear_uncorrect_error_status()
>>    PCI/AER: Unexport pci_aer_clear_nonfatal_status()
>>    PCI/AER: Move check inside pcie_clear_device_status().
>>    PCI/AER: Use pcie_aer_is_native() to judge whether OS owns AER
>>    PCI/ERR: Clear fatal error status when pci_channel_io_frozen
>>    PCI/AER: Refine status clearing process with api
>>
>>   drivers/ntb/hw/idt/ntb_hw_idt.c |  2 --
>>   drivers/pci/pci.c               |  7 +++--
>>   drivers/pci/pci.h               |  2 ++
>>   drivers/pci/pcie/aer.c          | 45 +++++++++++++++++++--------------
>>   drivers/pci/pcie/dpc.c          |  3 +--
>>   drivers/pci/pcie/err.c          | 15 ++++-------
>>   drivers/pci/pcie/portdrv_core.c |  3 +--
>>   drivers/scsi/lpfc/lpfc_attr.c   |  4 +--
>>   include/linux/aer.h             |  4 +--
>>   9 files changed, 44 insertions(+), 41 deletions(-)
>>
>> -- 
>> 2.30.1 (Apple Git-130)
>>

-- 
Zhuo Chen
