Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCC2A51
	for <ntb@lists.linux.dev>; Wed, 28 Sep 2022 08:32:27 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id gp22so2201132pjb.4
        for <ntb@lists.linux.dev>; Wed, 28 Sep 2022 01:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=AnfHroM50E8P0Ii+iSU31sgRh6u2MaB02I2cVNNuq8I=;
        b=CfEdIZt8l1WQDjOyQeWDMyKnvk4S7PxcJFyRFVhbdYdCj4+oumy2rfrw2svHEvFosM
         0YwVNJfK/5UCtOQO7rhnbQWs0BxHkcRGp+07m8J1nbKZ2R1p1HX3KE3Ac25PmhufYIWS
         bm0o324L/Xfg7OcOyc1cUkiz43Lsz2SKgSsN7e39qw1HBrYi6ZEcORTNwdY18gyBXdPy
         hkSX+wFNH5YVKZ0+1jKMoU3YlJdrvo6snbz6SD9PoDA7ik6QHgrqMOgebo10BuEbSuj9
         s0nrkc6fwAe6/lLOcMj5RzzPCqEsCIuINiTsZwiAU6wbnfn5DfzefbFPVlWRWNMFskH2
         f7Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=AnfHroM50E8P0Ii+iSU31sgRh6u2MaB02I2cVNNuq8I=;
        b=o+mtJ85xJgEH8gbyr4w/p0scrto1ccquJUe7noS17ll24tfWK/SozAvw2NV3e3WKix
         auNW/OyCS5rSkFwW1OqyQEWYjgI0OpkuiNXBvwph7iYsWG4vWQwA57I/gnvJbwxf91D3
         fNGxV4ohz2UrvizDN5Xve0mQjPgI4md6hdpRT+9i5OLi8UB1oREOxwnIDtzdZkahnmiJ
         fRBMplnQzZJPbKRxElIfmHkaTBwD/ajo1BPIpRguKL1v/jramksBMunmDLg6i1kCqeKw
         ylcQ0hzw4IrV77TJpxuu/Bi7GkOdtkcOpgg+Z1n2hJl6PTO6Rwf3gOnGXZ0T2tp6Y6vZ
         H3OQ==
X-Gm-Message-State: ACrzQf121wvFqGNB6Qz62/COqX6lfv/ME38x69xEYBxlwDnRJZB647W3
	eN2z78q98VIC/KHXPQkRJKo1UA==
X-Google-Smtp-Source: AMsMyM5LGu2rD0qQqLi/ZxdXqiVouuXIGTsKuwQkqeI9oSkcI/4nd83sN8JuM2eiL086bz1TLAJQCQ==
X-Received: by 2002:a17:903:40cc:b0:177:e44f:1fff with SMTP id t12-20020a17090340cc00b00177e44f1fffmr32460026pld.133.1664353946549;
        Wed, 28 Sep 2022 01:32:26 -0700 (PDT)
Received: from [10.2.223.68] ([61.120.150.77])
        by smtp.gmail.com with ESMTPSA id n9-20020aa79849000000b0055abc22a1absm647459pfq.209.2022.09.28.01.32.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 01:32:26 -0700 (PDT)
Message-ID: <e0a1b90d-8e60-bf04-1335-ec194049da31@bytedance.com>
Date: Wed, 28 Sep 2022 16:32:18 +0800
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.0
Subject: Re: [PATCH v2 1/9] PCI/AER: Add
 pci_aer_clear_uncorrect_error_status() to PCI core
Content-Language: en-US
To: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: bhelgaas@google.com, ruscur@russell.cc, oohall@gmail.com,
 fancer.lancer@gmail.com, jdmason@kudzu.us, dave.jiang@intel.com,
 allenbh@gmail.com, james.smart@broadcom.com, dick.kennedy@broadcom.com,
 jejb@linux.ibm.com, martin.petersen@oracle.com,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, ntb@lists.linux.dev, linux-scsi@vger.kernel.org
References: <20220927153524.49172-1-chenzhuo.1@bytedance.com>
 <20220927153524.49172-2-chenzhuo.1@bytedance.com>
 <564e778a-4ed8-3907-1cb3-34af109d0ce0@linux.intel.com>
From: Zhuo Chen <chenzhuo.1@bytedance.com>
In-Reply-To: <564e778a-4ed8-3907-1cb3-34af109d0ce0@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/28/22 3:31 AM, Sathyanarayanan Kuppuswamy wrote:
> Hi,
> 
> On 9/27/22 8:35 AM, Zhuo Chen wrote:
>> Sometimes we need to clear aer uncorrectable error status, so we add
> 
> Adding n actual use case will help.
> 
>> pci_aer_clear_uncorrect_error_status() to PCI core.
> 
> If possible, try to avoid "we" usage in commit log. Just say "so add
> pci_aer_clear_uncorrect_error_status() function"
> 
>>
>> Signed-off-by: Zhuo Chen <chenzhuo.1@bytedance.com>
>> ---
>>   drivers/pci/pcie/aer.c | 16 ++++++++++++++++
>>   include/linux/aer.h    |  5 +++++
>>   2 files changed, 21 insertions(+)
>>
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index e2d8a74f83c3..4e637121be23 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -286,6 +286,22 @@ void pci_aer_clear_fatal_status(struct pci_dev *dev)
>>   		pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, status);
>>   }
>>   
>> +int pci_aer_clear_uncorrect_error_status(struct pci_dev *dev)
>> +{
>> +	int aer = dev->aer_cap;
>> +	u32 status;
>> +
>> +	if (!pcie_aer_is_native(dev))
>> +		return -EIO;
>> +
>> +	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, &status);
>> +	if (status)
>> +		pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, status);
> 
> Why not just write all '1' and clear it? Why read and write?

Hi Sathyanarayanan,

The current implementation and the previous implementation are all first 
read and then write to clear the status. Currently just be consistent 
with them:
  - aer_enable_rootport()
  - pci_aer_raw_clear_status()
  - pcibios_plat_dev_init() in arch/mips/pci/pci-octeon.c
  - commit fd3362cb73de ("PCI/AER: Squash aerdrv_core.c into aerdrv.c")
    pci_cleanup_aer_uncorrect_error_status
> 
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(pci_aer_clear_uncorrect_error_status);
> 
> Add details about why you want to export in commit log.

Thanks,

I will add details and improve commit log in next version.
> 
>> +
>>   /**
>>    * pci_aer_raw_clear_status - Clear AER error registers.
>>    * @dev: the PCI device
>> diff --git a/include/linux/aer.h b/include/linux/aer.h
>> index 97f64ba1b34a..154690c278cb 100644
>> --- a/include/linux/aer.h
>> +++ b/include/linux/aer.h
>> @@ -45,6 +45,7 @@ struct aer_capability_regs {
>>   int pci_enable_pcie_error_reporting(struct pci_dev *dev);
>>   int pci_disable_pcie_error_reporting(struct pci_dev *dev);
>>   int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
>> +int pci_aer_clear_uncorrect_error_status(struct pci_dev *dev);
>>   void pci_save_aer_state(struct pci_dev *dev);
>>   void pci_restore_aer_state(struct pci_dev *dev);
>>   #else
>> @@ -60,6 +61,10 @@ static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>>   {
>>   	return -EINVAL;
>>   }
>> +static inline int pci_aer_clear_uncorrect_error_status(struct pci_dev *dev)
>> +{
>> +	return -EINVAL;
>> +}
>>   static inline void pci_save_aer_state(struct pci_dev *dev) {}
>>   static inline void pci_restore_aer_state(struct pci_dev *dev) {}
>>   #endif
> 

-- 
Thanks,
Zhuo Chen
