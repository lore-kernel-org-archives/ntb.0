Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593191D318A;
	Wed,  9 Oct 2024 19:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728502895; cv=none; b=WMq1wRnLmHmw49zM84ISc1I1yGRDzZ5CwYSKsJygY1F5k2x1d3VaIB25xUVEYFjSP/NHPqKAum/JwAnDEULo+e8QTyupESy8F5t2UsLZtCL/66QobEJb+yDu5JxSyIbmBSRVKnEh4qZmbsOJFhzZmKNZ02enArliCQJMLNF9mWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728502895; c=relaxed/simple;
	bh=PDYidJaYfrjomUChvobIVbDDlDk1zVlAhYjbjjNl6kk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o+H6CCfb8S18xrvBoRqcrxuvK2RRal1DHcSnX2ZBkqtDbClthcm0cRGwortuoHHDu2cK1bhUCvdxzZRQqAXZKR40/e9WddzRxpcwGHlg4TlAXJO62R7Wswi5m0J0MtwmQqqcZd5aTdSD/EblOfl1EO6oF392m2GoH/6bKpoBKxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U8KQVsZm; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8KQVsZm"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5398d171fa2so153852e87.0;
        Wed, 09 Oct 2024 12:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728502891; x=1729107691; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Io1G2uneGwHsYKAwtaIvvynFX0xlOmokHD97rmisdy0=;
        b=U8KQVsZmxW96yNlz7qJDVSMzilyMfe8MY3hzOsr/9mo0dH1OoTB/AMGLlFixK2uj1f
         n0CgCYUU5LpnXUZNtHUTTvuSJAmF4eVyJR54ePczXLKg378awvgUNegTiwClAExjAyPJ
         /lkcr1drCLnQ+sXAPzlxJ7sIbh6n9+u+L7itLW+KHa5/gQg4kb72urDbbLx37JdyDius
         3oB5ZDuD9IKdoTlT9FbRfjWMGCpPIzY0oKvpHgZV6m6M8vsserhLfrhQ4vypr2tWOesa
         cwELPwBHKzlFwoLdzjbvvrNpEbIC1fKM50z6O27jXgoomc5laXbkpBMgo9KkUZeBy3DW
         YcDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728502891; x=1729107691;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Io1G2uneGwHsYKAwtaIvvynFX0xlOmokHD97rmisdy0=;
        b=Zxwjf0DZO3wAr0vCflYcjpl+qGGbn5qfcQ3vY6MPBqKwXLgSDt0wGERxmf+2ulH82d
         6erQCv+Fgd/MUHcX7rx1l6Vh3bCi3wkzlaYewrZ6aOtjTEfqu+PS19HwbegTF4F11BHt
         2I4lJcaT7EJateO+d5toyXkoDuWUCaC6fYeQo83Co0SUog7YQv+W2u4KdfpyTfe2Xshz
         U5Cp3VWQyg1k1OD0ISs+vHZzF0+w/ytIqowlHpd/pjxdXyaNaWqO+Ky0CDvyH63mEHVR
         17jeEQQLxya11/N02TDZVW6RVBxzl60ITR/QvhM/4lLzN1vRuMioSFJXKnjbhNqpWKwR
         lvmA==
X-Forwarded-Encrypted: i=1; AJvYcCUx7linwPosFNylA4L0R2nU7scYNG7uswdyGTLEqRN3mW32iFmXohjC/5PF8rLu/AaFX/B5@lists.linux.dev, AJvYcCWJbbnF1A5PBtoqdBd/AzI0LsLA+cJLCSXTs7O0optd2dEvXM/1sPIcLWQ34SV7ioJz/ZUyrB7Cl6J5uxcR@lists.linux.dev
X-Gm-Message-State: AOJu0YwDF7zntlcT3vgDzGIS/hojcEH5mkCCc6bsaTyALI6ZIeUqk++Z
	vv6Om90jNG1ZWfFkZ1OoDeBWUV56N4L56QVVKGBvRYDAYKTuoaYt
X-Google-Smtp-Source: AGHT+IEJ7Hh7KYSEFQ7TnvOgBW+KHHTbn0YpY2aq9eVXupaQTxUm7Wi9eOrRO7yFgrSR7VO5SquDug==
X-Received: by 2002:a05:6512:224b:b0:539:921a:44af with SMTP id 2adb3069b0e04-539c4967bbemr2532382e87.48.1728502891046;
        Wed, 09 Oct 2024 12:41:31 -0700 (PDT)
Received: from [192.168.2.105] (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf5f3adsm28720915e9.22.2024.10.09.12.41.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 12:41:30 -0700 (PDT)
Message-ID: <411f3c94-58b5-471e-bc58-e23d89d2078f@gmail.com>
Date: Wed, 9 Oct 2024 21:41:25 +0200
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 10/13] staging: rts5280: Use always-managed version of
 pci_intx()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Philipp Stanner <pstanner@redhat.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 Sergey Shtylyov <s.shtylyov@omp.ru>,
 Basavaraj Natikar <basavaraj.natikar@amd.com>, Jiri Kosina
 <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Alex Dubov <oakad@yahoo.com>,
 Sudarsana Kalluru <skalluru@marvell.com>, Manish Chopra
 <manishc@marvell.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rasesh Mody <rmody@marvell.com>,
 GR-Linux-NIC-Dev@marvell.com, Igor Mitsyanko <imitsyanko@quantenna.com>,
 Sergey Matyukevich <geomatsi@gmail.com>, Kalle Valo <kvalo@kernel.org>,
 Sanjay R Mehta <sanju.mehta@amd.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Jon Mason <jdmason@kudzu.us>,
 Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Alex Williamson <alex.williamson@redhat.com>, Juergen Gross
 <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Mario Limonciello <mario.limonciello@amd.com>, Chen Ni <nichen@iscas.ac.cn>,
 Ricky Wu <ricky_wu@realtek.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Breno Leitao <leitao@debian.org>, Kevin Tian <kevin.tian@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Mostafa Saleh <smostafa@google.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hannes Reinecke <hare@suse.de>, John Garry <john.g.garry@oracle.com>,
 Soumya Negi <soumya.negi97@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Yi Liu <yi.l.liu@intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>,
 Christian Brauner <brauner@kernel.org>, Ankit Agrawal <ankita@nvidia.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Eric Auger <eric.auger@redhat.com>, Ye Bin <yebin10@huawei.com>,
 =?UTF-8?Q?Marek_Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Rui Salvaterra <rsalvaterra@gmail.com>, Marc Zyngier <maz@kernel.org>,
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, ntb@lists.linux.dev,
 linux-pci@vger.kernel.org, linux-staging@lists.linux.dev,
 kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-sound@vger.kernel.org
References: <20241009083519.10088-1-pstanner@redhat.com>
 <20241009083519.10088-11-pstanner@redhat.com>
 <2024100936-brunette-flannels-0d82@gregkh>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <2024100936-brunette-flannels-0d82@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/9/24 11:38, Greg Kroah-Hartman wrote:
> On Wed, Oct 09, 2024 at 10:35:16AM +0200, Philipp Stanner wrote:
>> pci_intx() is a hybrid function which can sometimes be managed through
>> devres. To remove this hybrid nature from pci_intx(), it is necessary to
>> port users to either an always-managed or a never-managed version.
>>
>> rts5208 enables its PCI-Device with pcim_enable_device(). Thus, it needs the
>> always-managed version.
>>
>> Replace pci_intx() with pcim_intx().
>>
>> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
>> ---
>>   drivers/staging/rts5208/rtsx.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 

Hi Philipp,

this driver (rts5208) will be removed soon - patch is send in.

Discussion about removal:
https://lore.kernel.org/linux-staging/2024100943-shank-washed-a765@gregkh/T/#t

Thanks for your support.

Bye Philipp

