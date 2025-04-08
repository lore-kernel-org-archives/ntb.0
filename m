Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0B4157A72
	for <ntb@lists.linux.dev>; Tue,  8 Apr 2025 20:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744143760; cv=none; b=f12Z+8PI9kSLQtmAWrMR1HBKLVgA8V8Q+B+yB0+5awnxWw1RCB2ieyj9k7pW4+12hMPnt1hiWhyyP42bU8wN5cTL1FStkO+PITZwtDZdqDI1T1peyrqzsSiWlHW7srnRt6mWgYFUa65YwZupjsVaUa1tRLNjiGoJ5/bUfo4y+ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744143760; c=relaxed/simple;
	bh=8XyuXKtTL6e+f4N6ue5PUIlJOF4lFS/2wcpnxprhIXk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=sKUi1V7sbFZ5TgsDeFNk0Hyt0gm2xKx0aP2z3f9bocpSVyvAMwCaPfT4uP8zbNB4W2aBM1g26hp9Vz+yWUYWELl+tF154WqV+5XzB1oOD2NAiugGZIPmVer7e8+FpX4GYbXUBg5aEFbdccZ999LKrkXQ3+OTsY0JXZ9iBO11OXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cfZq0Zlg; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cfZq0Zlg"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-549963b5551so7462761e87.2
        for <ntb@lists.linux.dev>; Tue, 08 Apr 2025 13:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744143757; x=1744748557; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YIezlD6Bly08fXTPTVgGJejItaXAl+hctJG/vGdTjvA=;
        b=cfZq0Zlg38PJOGlZqaV5UtCSArj42ir/EJgNeLqCPT2f3DToOkG7TT/IzYiYa2D66k
         hOzZE+KC4x3XJTOa2PLCYhB8jSBWm7bJ2eXDUTGe/M03IMyTF/+RU8lEaMkGdiSDdL0b
         I/+eJfhZ15jgc1eT3iBTQGN74PAtrnUFvxj1gFokzbfOt0GRSLSQrPEIPDxZ7A3fcZY5
         pylqqqOAMHxm9tXYZ0JMQZRCrWIrS2/7ThyNyNz9QkZDb9U+CVoIIf/58IzbTynNMOR3
         GS8baxpzLVINqj2Sl1p7rNZmHtBHeMPrHhKvKELbixDuXcQT/gMSQ6bc4GU4ztJyQuZX
         8CzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744143757; x=1744748557;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YIezlD6Bly08fXTPTVgGJejItaXAl+hctJG/vGdTjvA=;
        b=FDTxIQk0rfnblCQjdiIy9stpC9o8C0cQh01OYJPLEbB4BCUnh0dd14A1KxY1gDuoXh
         2pvtMzs0/GtRDFZMzsw+Jll7bxlVm68CkxRyE+Hoa1Ev+qIJdug1od2HWPj11rvJZBju
         csHou/T6X1akv4purxRHnFqICqhy0EDgyzN5GP4Zf3HNt9SsHNNVOzMQjYm97/YWEOQy
         k8ecPc+xHvxMJkF4MTBCBOD0qAmPKDMoJaMzdGtZN8InoA2rWZ2mNFEpc2Pc5AbVL860
         b3GvVOoy43W2NO3Nnufxhgs7w3ZjZPrffE1j6fVpk8IU3IiC1yLi7TchB47PROztv4+n
         6esA==
X-Forwarded-Encrypted: i=1; AJvYcCVBWdysSDI8b0beLdoqFnkqy5jZy7Dqyam8tRhzoiGQGl8mQQtgWqo3sBl+z2cnOLuCpTo=@lists.linux.dev
X-Gm-Message-State: AOJu0YyXpwSeTPDsLbw3X27UUSGibtF11Gts4PulNAa17wbPw+IVzdbG
	24cvMCizgyZQfmOf8S0DeActNZrd6/Q0bYENzJQpNWs9DE1CQ+8J
X-Gm-Gg: ASbGncvX1MOlnil3/CK56k00uNFywslDn5qrLr11W1HXo27hgerbqFUpMJXeYhRgpNg
	yAGkw7B5u+dRg+M5gw492sxPtanZBF+mJjnQ8NLOcFvhfmajW3tlROtRmJs5mLqgtTROZNUQIJr
	LXlkFZeAGw3x6WO43Z+H3q7VTYaBkERH33wx8IS+3PO+TDsuDjNVFIwVLuL3LIIHToWPjiwtf8w
	BrCG6JihVapbxUZAndeDZPpvzxk3lHXPMtW9YKhesBuUvfp0bho6V10nui3poaVl+YjatvOUilQ
	d2uB8RQuARrhu2khVrqYwAj8eyptmWKWQZ4eBTmMkHFXtkgjRWi2/6jOZrBNo3WI7NZO9b1uAOq
	d3R22nfEgh0pns6gZTnxGLqPmoX7d/Q==
X-Google-Smtp-Source: AGHT+IHuOB8gUCAj1gNimuKP3q1rxTb6SSeldgO0iZOm51nl8thKhMqs2ptuSNY/uXaP2AiCZuPn5w==
X-Received: by 2002:a05:6512:3b9f:b0:54b:117b:952f with SMTP id 2adb3069b0e04-54c437de1femr77204e87.56.1744143756421;
        Tue, 08 Apr 2025 13:22:36 -0700 (PDT)
Received: from ?IPV6:2001:678:a5c:1202:4fb5:f16a:579c:6dcb? (soda.int.kasm.eu. [2001:678:a5c:1202:4fb5:f16a:579c:6dcb])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54c1e672218sm1587431e87.238.2025.04.08.13.22.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 13:22:36 -0700 (PDT)
Message-ID: <3fb1b40e-a768-4a44-8c43-e522282cd417@gmail.com>
Date: Tue, 8 Apr 2025 22:22:34 +0200
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Klara Modin <klarasmodin@gmail.com>
Subject: Re: commit 7b025f3f85ed causes NULL pointer dereference
To: Bert Karwatzki <spasswolf@web.de>, Thomas Gleixner <tglx@linutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
 James.Bottomley@HansenPartnership.com, Jonathan.Cameron@huawei.com,
 allenbh@gmail.com, d-gole@ti.com, dave.jiang@intel.com,
 haiyangz@microsoft.com, jdmason@kudzu.us, kristo@kernel.org,
 linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-scsi@vger.kernel.org, logang@deltatee.com,
 manivannan.sadhasivam@linaro.org, martin.petersen@oracle.com,
 maz@kernel.org, mhklinux@outlook.com, nm@ti.com, ntb@lists.linux.dev,
 peterz@infradead.org, ssantosh@kernel.org, wei.huang2@amd.com,
 wei.liu@kernel.org
References: <20250408120446.3128-1-spasswolf@web.de> <87iknevgfb.ffs@tglx>
 <87friivfht.ffs@tglx> <f303b266172050f2ec0dc5168b23e0cea9138b01.camel@web.de>
Content-Language: en-US, sv-SE
In-Reply-To: <f303b266172050f2ec0dc5168b23e0cea9138b01.camel@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,


On 2025-04-08 18:20, Bert Karwatzki wrote:
> Am Dienstag, dem 08.04.2025 um 17:29 +0200 schrieb Thomas Gleixner:
>> On Tue, Apr 08 2025 at 17:09, Thomas Gleixner wrote:
>>> On Tue, Apr 08 2025 at 14:04, Bert Karwatzki wrote:
>>>> Since linux-next-20250408 I get a NULL pointer dereference when booting:
>>>>
>>>> [  T669] BUG: kernel NULL pointer dereference, address: 0000000000000330
>>>> [  T669] #PF: supervisor read access in kernel mode
>>>> [  T669] #PF: error_code(0x0000) - not-present page
>>>> [  T669] PGD 0 P4D 0
>>>> [  T669] Oops: Oops: 0000 [#1] SMP NOPTI
>>>> [  T669] CPU: 2 UID: 0 PID: 669 Comm: (udev-worker) Not tainted 6.15.0-rc1-next-20250408-master #788 PREEMPT_{RT,(lazy)}
>>>> [  T669] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/MS-158L, BIOS E158LAMS.107 11/10/2021
>>>> [  T669] RIP: 0010:msi_domain_first_desc+0x4/0x30
>>>> [  T669] Code: e9 21 ff ff ff 0f 0b 31 c0 e9 f3 8c da ff 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa <48> 8b bf 68 02 00 00 48 85 ff 74 13 85 f6 75 0f 48 c7 47 60 00 00
>>>> [  T669] RSP: 0018:ffffcec6c25cfa78 EFLAGS: 00010246
>>>> [  T669] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000008
>>>> [  T669] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000000c8
>>>> [  T669] RBP: ffff8d26cb419aec R08: 0000000000000228 R09: 0000000000000000
>>>> [  T669] R10: ffff8d26c516fdc0 R11: ffff8d26ca5a4aa0 R12: ffff8d26c1aed0c8
>>>> [  T669] R13: 0000000000000002 R14: ffffcec6c25cfa90 R15: ffff8d26c1aed000
>>>> [  T669] FS:  00007f690f71a980(0000) GS:ffff8d35e83fa000(0000) knlGS:0000000000000000
>>>> [  T669] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> [  T669] CR2: 0000000000000330 CR3: 0000000121b64000 CR4: 0000000000750ef0
>>>> [  T669] PKRU: 55555554
>>>> [  T669] Call Trace:
>>>> [  T669]  <TASK>
>>>> [  T669]  msix_setup_interrupts+0x23b/0x280
>>>
>>> Can you please decode the lines please via:
>>>
>>>      scripts/faddr2line vmlinux msi_domain_first_desc+0x4/0x30
>>>      scripts/faddr2line vmlinux msix_setup_interrupts+0x23b/0x280
>>
> 
> I had to recompile with CONFIG_DEBUG_INFO=Y, and reran the test, the calltrace
> is identical.
> 
> $ scripts/faddr2line vmlinux msi_domain_first_desc+0x4/0x30
> msi_domain_first_desc+0x4/0x30:
> msi_domain_first_desc at kernel/irq/msi.c:400
> 
> So it seems msi_domain_first_desc() is called with dev = NULL.
> 
> $ scripts/faddr2line vmlinux msix_setup_interrupts+0x23b/0x280
> msix_setup_interrupts+0x23b/0x280:
> msix_update_entries at drivers/pci/msi/msi.c:647 (discriminator 1)
> (inlined by) __msix_setup_interrupts at drivers/pci/msi/msi.c:684 (discriminator
> 1)
> (inlined by) msix_setup_interrupts at drivers/pci/msi/msi.c:695 (discriminator
> 1)
> 

I was also hit by this issue. If I understand it correctly, retain_ptr 
inhibits the free to be inserted when the scope ends, but it also NULLs 
dev in the process. If I switch the order of retain_ptr and 
msix_update_entries in __msix_setup_interrupts I don't get the oops 
anymore, though I don't know if this is the correct fix.

> 
>> Can you please also provide kernel configuration and compiler version?
>>
>> Thanks,
>>
>>          tglx
> 
> Bert Karwatzki
> 

Regards,
Klara Modin.
