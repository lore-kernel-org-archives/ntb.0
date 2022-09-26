Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57DD33CF
	for <ntb@lists.linux.dev>; Mon, 26 Sep 2022 14:16:32 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id v1so6351122plo.9
        for <ntb@lists.linux.dev>; Mon, 26 Sep 2022 07:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=f9x4Js9aJ8GGYBn29EvIVTQooQM7+4F6Gd+zw2Mc6M8=;
        b=zbi+yH6owkuseZsPd8cID/9/WJR+WXOO72huZu1wJYjkboy+f0MsZabCpreRAfu0Sf
         3BZmYRBcwpD7wi8A/IOpfuJVOl1A8rCJFaIcGSG0jKTrF8oCvuPQ+RBCTLvziQZNwC1g
         Jd9oklGK6EvDETceCFaUoZePQcW8L05Zcov7bvOd0XZhHHpbvz9QNXl7DZPgxMgKI0QQ
         vLCHPHYSGblBh6eb+LQZr1TrgBNIz+T+/FWuQZnJCYJQz7wXYaPUaM7LuExyVVf5TwXJ
         ct7K8VAqw2t9I2n0tte3U2h0Rk0Ver57AT66B18Yzk80ZWyfj9mzyHlAE/JXkq2hSxLS
         3r+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=f9x4Js9aJ8GGYBn29EvIVTQooQM7+4F6Gd+zw2Mc6M8=;
        b=VnBu7PR8j/7nV+1CtVUzioiYQ+3xjameQU8TcMiALtUxVlvBz3UQj55OpE7vB2kxum
         pN8CCxvbtIoeQ0krnYXPM7xcRLPlgbmyRs74SIzbGniFtmzFbEPehD3zkubbFUM1mPFv
         ZjFH/h9gJTtn7JHUnMkP9arrGVzwTDZahRaXh4cirCDM7u5Q6h4kgBQsFjwqUFPKeNWI
         m1dXRTxtBxEgL1/2foXXUGtVovdtpgr7aEo50TqF48uLav8up8AAMw52Gn+AvPDWa5t0
         0bjeaBJw+PTM2rgeydU3DefrPw3HybCZivXsW1P906KFhRBr7OK1IkD5+lOyMnPTRrrn
         58Yw==
X-Gm-Message-State: ACrzQf0YFefrBPX4/VHwdZX/fWOm2irzrNeOJLjYp6dgSnwBufg0wnUX
	nXk4tWdAbEu8TRz7RizY9yDXUg==
X-Google-Smtp-Source: AMsMyM5TPoPvq12bpXj85IzcoD1FO5FB0fyyNhOKXktO0s3dtYc0w3EMmyW5x+a7mrmCCw2DD9kjgw==
X-Received: by 2002:a17:902:6b0a:b0:178:9a17:5b89 with SMTP id o10-20020a1709026b0a00b001789a175b89mr21933535plk.113.1664201791912;
        Mon, 26 Sep 2022 07:16:31 -0700 (PDT)
Received: from [10.2.223.68] ([61.120.150.77])
        by smtp.gmail.com with ESMTPSA id b11-20020a170903228b00b001781cad59e3sm11362897plh.108.2022.09.26.07.16.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 07:16:31 -0700 (PDT)
Message-ID: <3e025745-06af-c5c6-aa70-6ff1f9ad0962@bytedance.com>
Date: Mon, 26 Sep 2022 22:16:23 +0800
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.0
Subject: Re: [PATCH 3/3] PCI/AER: Use pci_aer_raw_clear_status() to clear root
 port's AER error status
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: fancer.lancer@gmail.com, jdmason@kudzu.us, dave.jiang@intel.com,
 allenbh@gmail.com, bhelgaas@google.com, ruscur@russell.cc, oohall@gmail.com,
 james.smart@broadcom.com, dick.kennedy@broadcom.com, jejb@linux.ibm.com,
 martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 ntb@lists.linux.dev, linuxppc-dev@lists.ozlabs.org
References: <20220922215030.GA1341314@bhelgaas>
From: Zhuo Chen <chenzhuo.1@bytedance.com>
In-Reply-To: <20220922215030.GA1341314@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/23/22 5:50 AM, Bjorn Helgaas wrote:
> On Fri, Sep 02, 2022 at 02:16:34AM +0800, Zhuo Chen wrote:
>> Statements clearing AER error status in aer_enable_rootport() has the
>> same function as pci_aer_raw_clear_status(). So we replace them, which
>> has no functional changes.
>>
>> Signed-off-by: Zhuo Chen <chenzhuo.1@bytedance.com>
>> ---
>>   drivers/pci/pcie/aer.c | 7 +------
>>   1 file changed, 1 insertion(+), 6 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index d2996afa80f6..eb0193f279f2 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -1287,12 +1287,7 @@ static void aer_enable_rootport(struct aer_rpc *rpc)
>>   				   SYSTEM_ERROR_INTR_ON_MESG_MASK);
>>   
>>   	/* Clear error status */
>> -	pci_read_config_dword(pdev, aer + PCI_ERR_ROOT_STATUS, &reg32);
>> -	pci_write_config_dword(pdev, aer + PCI_ERR_ROOT_STATUS, reg32);
>> -	pci_read_config_dword(pdev, aer + PCI_ERR_COR_STATUS, &reg32);
>> -	pci_write_config_dword(pdev, aer + PCI_ERR_COR_STATUS, reg32);
>> -	pci_read_config_dword(pdev, aer + PCI_ERR_UNCOR_STATUS, &reg32);
>> -	pci_write_config_dword(pdev, aer + PCI_ERR_UNCOR_STATUS, reg32);
>> +	pci_aer_raw_clear_status(pdev);
> 
> It's true that this is functionally equivalent.
> 
> But 20e15e673b05 ("PCI/AER: Add pci_aer_raw_clear_status() to
> unconditionally clear Error Status") says pci_aer_raw_clear_status()
> is only for use in the EDR path (this should have been included in the
> function comment), so I think we should preserve that property and use
> pci_aer_clear_status() here.
> 
> pci_aer_raw_clear_status() is the same as pci_aer_clear_status()
> except it doesn't check pcie_aer_is_native().  And I'm pretty sure we
> can't get to aer_enable_rootport() *unless* pcie_aer_is_native(),
> because get_port_device_capability() checks the same thing, so they
> should be equivalent here.
> 
> Bjorn
Thanks Bjorn, this very detailed correction is helpful. By the way, 
'only for use in the EDR path' obviously written in the function 
comments may be better. So far only commit log has included these.

I will change to use pci_aer_clear_status() in next patch.

-- 
Thanks,
Zhuo Chen
