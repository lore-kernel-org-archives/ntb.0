Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C5F33CF
	for <ntb@lists.linux.dev>; Mon, 26 Sep 2022 14:02:04 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id e129so561529pgc.9
        for <ntb@lists.linux.dev>; Mon, 26 Sep 2022 07:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=1yGPnS7+tabIF9f3YGZrIJUzZlCgUowefj3Ak6tgbc8=;
        b=Cml+idqKmgZLlpiIB8rfPG/ng2lFM3Uc9sHJGoyFG7EKF7hZNke7PI/XfWak9pHRFi
         efod9Ah4zEqgORi+dMraA2Sbgo/pbkOsElfL2aD04OOna/C7XRrRxw0DfgIIfFkuQBtl
         cmmg93A0HBEzFfB1+OSXJZfXPeyzl0IgyhatrNNxgm2ohJf5RdnnNFXZNdgo7YaW0/yv
         LuuQM2kgG/3u1LhXdaEb1jXfGr5iRHnQ+eWfqiHMVUElxVxahOJVNf9IRTzA3BIZLfv3
         zqpVrMthiVdLVBUkfIC5c7/0nUDogIn6jR/lCahdK1UXLrg6UQyGo+qF4+waB/51xAs+
         2x6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=1yGPnS7+tabIF9f3YGZrIJUzZlCgUowefj3Ak6tgbc8=;
        b=z25b4oVBZb6r8WXNrnIc75HgQTN0boStExgo8Wm/apetdmNv+xrB7559AO4TudxPSP
         D55cZtqMJf1DvD9FAJcWgsPaB5IVekN+NN1GCzkZhlRVvD2Tm4PpSKSUXjZhd00GdZJt
         bsXn2ZyUV4BBIi2lm0bu0ABejV22Y2w2eFnFuxi7Rt+APCeX0N1WQlyzsbLFIwDYkO7m
         WKRPSuVbYJWQzmgxSZd8aIpgZkSxMM42fYTHopIFy8coOWpMyFWCTn22nb2zWGv9Mq6g
         MeMWgEtSfzSb4jeS7mlhNbOD6wEVbPs2qkhrQe8/iGVWUDH1/l1+HJMEhNw+y7NiA/ja
         DU+w==
X-Gm-Message-State: ACrzQf2dJcyR5F9jhi8hfHSK7520uKYrfqu0gKPHBiDrOaImfHKoEfxC
	qCsVfbyJCUJwWdlM/cPkvxyP9Q==
X-Google-Smtp-Source: AMsMyM56mNVNCK934eTJEzhPKz0Kgne9owdo04+/JMJy5BNbxI/i4itBQ3mjMLHU+WUWOj1bBuUPqA==
X-Received: by 2002:aa7:9f0c:0:b0:546:c556:ac86 with SMTP id g12-20020aa79f0c000000b00546c556ac86mr23732346pfr.55.1664200924322;
        Mon, 26 Sep 2022 07:02:04 -0700 (PDT)
Received: from [10.2.223.68] ([61.120.150.77])
        by smtp.gmail.com with ESMTPSA id b15-20020a63d30f000000b004393cb720afsm10769098pgg.38.2022.09.26.07.01.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 07:02:03 -0700 (PDT)
Message-ID: <1de80c28-33ec-b1bd-a557-91e4166d2da7@bytedance.com>
Date: Mon, 26 Sep 2022 22:01:55 +0800
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.0
Subject: Re: [PATCH 2/3] PCI/ERR: Clear fatal status in pcie_do_recovery()
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: fancer.lancer@gmail.com, jdmason@kudzu.us, dave.jiang@intel.com,
 allenbh@gmail.com, bhelgaas@google.com, ruscur@russell.cc, oohall@gmail.com,
 james.smart@broadcom.com, dick.kennedy@broadcom.com, jejb@linux.ibm.com,
 martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 ntb@lists.linux.dev, linuxppc-dev@lists.ozlabs.org
References: <20220922210853.GA1335665@bhelgaas>
From: Zhuo Chen <chenzhuo.1@bytedance.com>
In-Reply-To: <20220922210853.GA1335665@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/23/22 5:08 AM, Bjorn Helgaas wrote:
> On Fri, Sep 02, 2022 at 02:16:33AM +0800, Zhuo Chen wrote:
>> When state is pci_channel_io_frozen in pcie_do_recovery(),
>> the severity is fatal and fatal status should be cleared.
>> So we add pci_aer_clear_fatal_status().
> 
> Seems sensible to me.  Did you find this by code inspection or by
> debugging a problem?  If the latter, it would be nice to mention the
> symptoms of the problem in the commit log.

I found this by code inspection so I may not enumerate what kind of 
problems this code will cause.
> 
>> Since pcie_aer_is_native() in pci_aer_clear_fatal_status()
>> and pci_aer_clear_nonfatal_status() contains the function of
>> 'if (host->native_aer || pcie_ports_native)', so we move them
>> out of it.
> 
> Wrap commit log to fill 75 columns.
> 
>> Signed-off-by: Zhuo Chen <chenzhuo.1@bytedance.com>
>> ---
>>   drivers/pci/pcie/err.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
>> index 0c5a143025af..e0a8ade4c3fe 100644
>> --- a/drivers/pci/pcie/err.c
>> +++ b/drivers/pci/pcie/err.c
>> @@ -243,10 +243,14 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>>   	 * it is responsible for clearing this status.  In that case, the
>>   	 * signaling device may not even be visible to the OS.
>>   	 */
>> -	if (host->native_aer || pcie_ports_native) {
>> +	if (host->native_aer || pcie_ports_native)
>>   		pcie_clear_device_status(dev);
> 
> pcie_clear_device_status() doesn't check for pcie_aer_is_native()
> internally, but after 068c29a248b6 ("PCI/ERR: Clear PCIe Device Status
> errors only if OS owns AER") and aa344bc8b727 ("PCI/ERR: Clear AER
> status only when we control AER"), both callers check before calling
> it.
> 
> I think we should move the check inside pcie_clear_device_status().
> That could be a separate preliminary patch.
> 
> There are a couple other places (aer_root_reset() and
> get_port_device_capability()) that do the same check and could be
> changed to use pcie_aer_is_native() instead.  That could be another
> preliminary patch.
> 
Good suggestion. But I have only one doubt. In aer_root_reset(), if we 
use "if (pcie_aer_is_native(dev) && aer)", when dev->aer_cap
is NULL and root->aer_cap is not NULL, pcie_aer_is_native() will return 
false. It's different from just using "(host->native_aer ||
pcie_ports_native)".
Or if we can use "if (pcie_aer_is_native(root))", at this time a NULL 
pointer check should be added in pcie_aer_is_native() because root may 
be NULL.

> 
>> +	if (state == pci_channel_io_frozen)
>> +		pci_aer_clear_fatal_status(dev);
>> +	else
>>   		pci_aer_clear_nonfatal_status(dev);
>> -	}
>> +
>>   	pci_info(bridge, "device recovery successful\n");
>>   	return status;
>>   
>> -- 
>> 2.30.1 (Apple Git-130)
>>

-- 
Thanks,
Zhuo Chen
