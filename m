Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC081215776
	for <ntb@lists.linux.dev>; Thu, 12 Dec 2024 14:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734015403; cv=none; b=TciGkiAetVcMiJ/T8e+LNR6S649yw3pQ+JNQCjDIXaLwW6JmVR/9PeeQj0a2cxt+k0Mopp4Bt6GRtV84ROxlctAxbfQLiJoL+/nDQowSbF4/W3U/xfH7iY1/yZdHwwbAg/SY8O1UYR3ZmbwlcESKrVFxl2j6efz3iynffFXTLuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734015403; c=relaxed/simple;
	bh=AjQOAHstwlMlrDDeDDeSx0eAGZcKzvIvjK1+noRizkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XQ1OCFVmsI6dShKtV5CrdmaXOCiMSf5rjrqXRl9XaIZGt7ODM2uHME/FffUP+MomT/mOsdHzXtYXMElOqpr3gPwQ/+LfCdgftLOJQvfzCmdTbaGcNMbO6uBSPyWYMI9d8NhTM2bavoV1qbuFb4vuS3+WCusENGQg64mjOU5bOKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z5bV0yti; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z5bV0yti"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734015401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oL7oDzf/iu+owBEyFgADY3KtJbecvvlrXRMt6TBS380=;
	b=Z5bV0ytichPHk06ELQCrR2XhdM+TwpeohnTCakaa86PB4gBs5CCN+SaAct7jNHbTkf6HsL
	I6S5c0h/PGmPk2Z7WNPvwU5ruPfZ+xVcF8UZT7xr9pN+YXdHjKaNIfxyitKLMGu6GKaK4j
	JP5lw6nEZRkmTktWYllxv2cEdVEbefo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85--TNU_eKeMNmcv11OGG4fKg-1; Thu, 12 Dec 2024 09:56:38 -0500
X-MC-Unique: -TNU_eKeMNmcv11OGG4fKg-1
X-Mimecast-MFC-AGG-ID: -TNU_eKeMNmcv11OGG4fKg
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43621907030so7205495e9.1
        for <ntb@lists.linux.dev>; Thu, 12 Dec 2024 06:56:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734015397; x=1734620197;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oL7oDzf/iu+owBEyFgADY3KtJbecvvlrXRMt6TBS380=;
        b=wdltZtGc4iYufLkW1CcLo7tRDXxPkVMYc5FdXfH9GYnio4gLlnfMX9TX/pL3s6OlN1
         VJed8bY5db/em4usYw4m3gTeX8I0WGutJzkTxEfVoJ/bAV6LrHSQFa970hA6j6JhEWL2
         84xOtW2Ofia+P5vZu8PVxO/4K20hcaH+7bXL9If1Rl4lEVNxdVNfBUyh+D76XJ1OctDE
         QlV2ONwCxxkYEAmY3/+AVAF1EuKmByKfvwtqiBq18CMYYGftC6z3ndfoAbBysKzFEbfh
         Qtk5M9YqHXvWs14mRIukIDfcbHYH5XOgykJMQFqVTTQOQLiJVateeY/26hCvM0nzO56s
         /cmg==
X-Forwarded-Encrypted: i=1; AJvYcCX1NMA3JrvOzhlABfvoVPw4+lLru45QlN/9SDstWVHv638Ko55aDm5uetj0G2CXQK4z3g8=@lists.linux.dev
X-Gm-Message-State: AOJu0YyPWW1/Q6BD4Xja8eDMJJZ3zG9UDa9Qe0v9P7C0WaGwhOcSA0MC
	OUUtwG2SO40BRIJa6rkQg8sn0CCrku1cPgW1S30L1uYJRdZm0yQcJ0YXm/Dq6ItH0hUKoX8rIQT
	Py2GghA/84lRe5ZEDCIgOOHMBEd2gFfannX8HTwttjT2ESp7ahQ==
X-Gm-Gg: ASbGnctQQg9nKwyv9pcgjsR0uwfVhqRn/UgZRxm5YFpJCUXiTPBPyVXdKRxd9Uuh3na
	/AnvNf5ip0xGWvw1dRYwYtyZ2vCrHGv7DOc/poOTFdbpODQMtpwfonjl2onind73P7Xb2IS3J5K
	icPbrBUaGz5wN9vVBVwES+r/LiaXPt03LWX0l8XV7CPcyJJI9HjYTUzzCwxq4R0QlLNJpBzg6on
	NJkkSqZ1YF4C28WgCJeT9GxbY9rNZ9skE+c4s3QAMTJhp18zRonh9RtvdlC8gR00Jp1gnRU7nUc
	z1ruBOs=
X-Received: by 2002:a05:600c:34cc:b0:434:fbe2:4f with SMTP id 5b1f17b1804b1-4361c430b5cmr63303125e9.23.1734015397058;
        Thu, 12 Dec 2024 06:56:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6jT4MvcNP0dxPJ6BKwDHdX4PrfqhYHXR4TAbgRNM6khL6oXpHiVnh7UfEpSYX/vLofOsSxA==
X-Received: by 2002:a05:600c:34cc:b0:434:fbe2:4f with SMTP id 5b1f17b1804b1-4361c430b5cmr63302405e9.23.1734015396688;
        Thu, 12 Dec 2024 06:56:36 -0800 (PST)
Received: from [192.168.88.24] (146-241-48-67.dyn.eolo.it. [146.241.48.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4362557c457sm19247805e9.15.2024.12.12.06.56.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 06:56:36 -0800 (PST)
Message-ID: <8ee0cf91-c215-4015-90fc-32be6f22b7db@redhat.com>
Date: Thu, 12 Dec 2024 15:56:32 +0100
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/11] net/ethernet: Use never-managed version of
 pci_intx()
To: Philipp Stanner <pstanner@redhat.com>, amien Le Moal
 <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 Basavaraj Natikar <basavaraj.natikar@amd.com>, Jiri Kosina
 <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alex Dubov
 <oakad@yahoo.com>, Sudarsana Kalluru <skalluru@marvell.com>,
 Manish Chopra <manishc@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Rasesh Mody <rmody@marvell.com>,
 GR-Linux-NIC-Dev@marvell.com, Igor Mitsyanko <imitsyanko@quantenna.com>,
 Sergey Matyukevich <geomatsi@gmail.com>, Kalle Valo <kvalo@kernel.org>,
 Sanjay R Mehta <sanju.mehta@amd.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Jon Mason <jdmason@kudzu.us>,
 Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Alex Williamson <alex.williamson@redhat.com>, Juergen Gross
 <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Mario Limonciello <mario.limonciello@amd.com>, Chen Ni <nichen@iscas.ac.cn>,
 Ricky Wu <ricky_wu@realtek.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Breno Leitao <leitao@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
 Kevin Tian <kevin.tian@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mostafa Saleh <smostafa@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Yi Liu <yi.l.liu@intel.com>, Kunwu Chan <chentao@kylinos.cn>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 "Dr. David Alan Gilbert" <linux@treblig.org>,
 Ankit Agrawal <ankita@nvidia.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Eric Auger <eric.auger@redhat.com>, Ye Bin <yebin10@huawei.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, ntb@lists.linux.dev,
 linux-pci@vger.kernel.org, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org
References: <20241209130632.132074-2-pstanner@redhat.com>
 <20241209130632.132074-5-pstanner@redhat.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241209130632.132074-5-pstanner@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dF2b-krBx9P4DmvNHR1POoROyyCXtQvN5vmquPt3VXM_1734015397
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/9/24 14:06, Philipp Stanner wrote:
> pci_intx() is a hybrid function which can sometimes be managed through
> devres. To remove this hybrid nature from pci_intx(), it is necessary to
> port users to either an always-managed or a never-managed version.
> 
> broadcom/bnx2x and brocade/bna enable their PCI-Device with
> pci_enable_device(). Thus, they need the never-managed version.
> 
> Replace pci_intx() with pci_intx_unmanaged().
> 
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>

Acked-by: Paolo Abeni <pabeni@redhat.com>

