Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4279B8480
	for <ntb@lists.linux.dev>; Fri,  4 Nov 2022 17:20:59 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id d13-20020a17090a3b0d00b00213519dfe4aso5112256pjc.2
        for <ntb@lists.linux.dev>; Fri, 04 Nov 2022 10:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OczEUwDaDCJagzs0QtMr8aHYN/ko8ymZX7lVummJVOs=;
        b=uAw80S9vBEJp3aHojoMEpA/68sS1rwm2/DWeE+ULXnA6VihFLM1tIcWa71PfRN9kBY
         0Dv2ncNI3cIHP1goXyeXZom0/uBfoDaO30ASdZEL4aGfHRhvJUIMCG8nrQlvfooqmoJO
         hUAuGLtFkFgLnDesYbOIb/h2RG1W4Vfgffao9TGfEveZhdIZofkxgjiB9PJaysiRvxez
         qh27EMHRn8B9dhv5bFV0Gj3bOcrEvWTaLB9Ua8Lz3QnnrjBVMODvXVdUSprTVXviQ9hj
         D+qpWlXKArSY4d+JaCwNiIRypZgFLSZR3fDUcNuaeyz///hny0BZ0cHpkYlDAwWb4Z7k
         HJqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OczEUwDaDCJagzs0QtMr8aHYN/ko8ymZX7lVummJVOs=;
        b=h/W2nxjJlYVZ/yxuCArHlt5RhtkUTTivqTOJEa84ULg5+b4HqMBri6Q9hB0wG5Ma6M
         cxn0BRYD8VKW9Az+K5uDMDnk4m6P139Rtlk6nZowzDawB3Xhk5303KI0C9AfEjYBO6Qw
         J8/sYJZuOlHaQ4as/WZkti7WPTwqjG23Y3HGXILFWmXw+BWvQMS7zsYB0DFLxnLXh4YI
         PAN2aShFO5QkLa94C0fBpnGOZbYpythw3LBTgdqM0srdLG5MfvvfnYGIham7f5wCk/il
         5f7XMda5VzO2I9WQ7bwxcZrajde6L3WcKyxhdD7iyL01gWoWwC+LLD5AtUi6/DrQWqp3
         e2Mg==
X-Gm-Message-State: ACrzQf0tIXFmBPDzkHYTmE0Ctjrj+mam1UOHulp4K/Zc+30FUkw1Ho2C
	oscUB256tu6ngPzCsD/J/zOTMg==
X-Google-Smtp-Source: AMsMyM7qXmb1tKLbXoG2RN7MYH+OBDKZmahcKO3ZgUlIGFzbY77VBHGSlWccWa4sVOHz9dNTYKbNgg==
X-Received: by 2002:a17:90a:6045:b0:212:fe9a:5792 with SMTP id h5-20020a17090a604500b00212fe9a5792mr53370678pjm.178.1667582458816;
        Fri, 04 Nov 2022 10:20:58 -0700 (PDT)
Received: from [10.255.167.72] ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id x16-20020aa79a50000000b0056e0ff577edsm2990000pfj.43.2022.11.04.10.20.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 10:20:58 -0700 (PDT)
Message-ID: <17b88750-53c2-0653-045a-dde921e37e0c@bytedance.com>
Date: Sat, 5 Nov 2022 01:20:50 +0800
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
To: Bjorn Helgaas <helgaas@kernel.org>,
 Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: ruscur@russell.cc, oohall@gmail.com, fancer.lancer@gmail.com,
 jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
 james.smart@broadcom.com, dick.kennedy@broadcom.com, jejb@linux.ibm.com,
 martin.petersen@oracle.com, bhelgaas@google.com,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, ntb@lists.linux.dev, linux-scsi@vger.kernel.org
References: <20220928105946.12469-1-chenzhuo.1@bytedance.com>
Content-Language: en-US
From: Zhuo Chen <chenzhuo.1@bytedance.com>
In-Reply-To: <20220928105946.12469-1-chenzhuo.1@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Bjorn, a gentle reminder.

Thanks and regards.

On 9/28/22 6:59 PM, Zhuo Chen wrote:
> Hello.
> 
> Here comes patch v3, which contains some fixes and optimizations of
> aer api usage. The v1 and v2 can be found on the mailing list.
> 
> v3:
> - Modifications to comments proposed by Sathyanarayanan. Remove
>    pci_aer_clear_nonfatal_status() call in NTB and improve commit log.
> 
> v2:
> - Modifications to comments proposed by Bjorn. Split patch into more
>    obvious parts.
> 
> Zhuo Chen (9):
>    PCI/AER: Add pci_aer_clear_uncorrect_error_status() to PCI core
>    PCI/DPC: Use pci_aer_clear_uncorrect_error_status() to clear
>      uncorrectable error status
>    NTB: Remove pci_aer_clear_nonfatal_status() call
>    scsi: lpfc: Change to use pci_aer_clear_uncorrect_error_status()
>    PCI/AER: Unexport pci_aer_clear_nonfatal_status()
>    PCI/AER: Move check inside pcie_clear_device_status().
>    PCI/AER: Use pcie_aer_is_native() to judge whether OS owns AER
>    PCI/ERR: Clear fatal error status when pci_channel_io_frozen
>    PCI/AER: Refine status clearing process with api
> 
>   drivers/ntb/hw/idt/ntb_hw_idt.c |  2 --
>   drivers/pci/pci.c               |  7 +++--
>   drivers/pci/pci.h               |  2 ++
>   drivers/pci/pcie/aer.c          | 45 +++++++++++++++++++--------------
>   drivers/pci/pcie/dpc.c          |  3 +--
>   drivers/pci/pcie/err.c          | 15 ++++-------
>   drivers/pci/pcie/portdrv_core.c |  3 +--
>   drivers/scsi/lpfc/lpfc_attr.c   |  4 +--
>   include/linux/aer.h             |  4 +--
>   9 files changed, 44 insertions(+), 41 deletions(-)
> 

-- 
Zhuo Chen
