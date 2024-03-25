Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E7A6CDBA
	for <ntb@lists.linux.dev>; Mon, 25 Mar 2024 21:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711401586; cv=none; b=Fuiq+nLZP5f+cFS+xKeHhxAJ8TXhjv9cWPFaRxGctKECiLipNEamtUVHfHVQthpczCDcXbENNDPL0gHGj4tsJsVTikjda58FOy53lAyCUEusrxC2XSSrycmOXIgLw10g6QwOaMOGytMbym2Cj0/9nDK85oYU1J9HzXWQ9etZpUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711401586; c=relaxed/simple;
	bh=pyKqoCTD+lIbBbjlyXz91NzejdbHvMMjyPPz9MEw2q4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=feBdyTl3fSpAQ5ZPZMYeZN45mGea+8sPutm8hslrlMelrfRbIGf8K3KiGICOdvaR+jMYbkpvllWNa1+AKFvQMnDQZXxn5rZZtWgtFJA6P3SlmIbLp0fnJNAYkmLICkzKoBaRvgaa1TcsYIw1x1xw5CAu7wKBLK7T8bFNzr6LwLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cnJMoTZ+; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnJMoTZ+"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56bf8093dddso723152a12.0
        for <ntb@lists.linux.dev>; Mon, 25 Mar 2024 14:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711401583; x=1712006383; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PoSfbikonTDSBOuLxdHwiEiP9ZejpGDsNbVllGW8OsA=;
        b=cnJMoTZ+dfLp2NStt9g8RXi2KATtP6JMKV8aGOUyJ+yelO5CJiKkTNA4RmSBo2TThS
         S1Fj2D6JkaeJrntx0TNYN/A4s/Hw9iODJohze2NRMbUnPBeJ11pexNWDuSou/d/Weemt
         cuSgSaSeGOmUA5zqz1EWZ8HRNRbnh1WIS3VeUNgKQuDXUo+Ie+WjPupye7mPNHetIQ9n
         1mte7npwKMF1fcAQCgqGMI2QxYvAW8uA0rMZe/RYlAlcGumgn86Szis+xBlMAl+I66Lc
         RVwW2suOM1TAfjzhTwLqcjH3MXLs6cotzVQSmL/5intauy3Fvof77z5eR6CJFgqkWF++
         lTKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711401583; x=1712006383;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PoSfbikonTDSBOuLxdHwiEiP9ZejpGDsNbVllGW8OsA=;
        b=hmrg2Sd/mvx569/FiFPZnS5MN1grTpwBqWsJ0Zaqtx9Eghj6N/nqT/lKNfKUpYW+Q0
         +WUyXo8BZIkgEFg+3OFjoFfPj5jVOQe1KfEm3EVqK0RNYULh1sUL0ivf7I60lhYomn2m
         COKxMdOnRM5tmJmX/0vdpXWRtxOAWHEWOVdIhVWYHfL6dofXMy8q73B8HMWQJYV4eNQw
         mfW/sJIikB1QOke/7KmSqEPS35q9HQe5EMnRwH78BfZ5o5zvDsEUK4tOYuLMasAth+9U
         pUhonm2aBkqv0F992PoWpdv88QjGPN4ZCm9R4Nog7B5So/VUW3Dktj/orfaHZk+TwRII
         rNvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWa6DOR9W68ati8QCNOIHYRGeuwnfSic/PW9rB521ES3dmqdA/LAOwxw2oUPelGvR8/nvrQduu92/aU47LkVymoSWfL
X-Gm-Message-State: AOJu0Yz2XmJQpzLNboqige7JXFRItRN66PZZdPH87MS0/gqK5+EY9X+T
	FsLc8ApF7yVlWxPq4AQL+qHlSmyVh51xFbqVBSBekgAV9m9k+LH4
X-Google-Smtp-Source: AGHT+IHJM612MMOX224WqDpitSB3ppYid8xqsHidMYKffDXHZGIA2IVK0z2qzCKVX3AunTfuBNsM1Q==
X-Received: by 2002:a50:8d14:0:b0:568:a752:5fb3 with SMTP id s20-20020a508d14000000b00568a7525fb3mr7779537eds.15.1711401583242;
        Mon, 25 Mar 2024 14:19:43 -0700 (PDT)
Received: from ?IPV6:2a01:c22:7a49:5100:f87e:9160:36e9:a3bd? (dynamic-2a01-0c22-7a49-5100-f87e-9160-36e9-a3bd.c22.pool.telefonica.de. [2a01:c22:7a49:5100:f87e:9160:36e9:a3bd])
        by smtp.googlemail.com with ESMTPSA id ck5-20020a0564021c0500b0056c1bf78a3asm736491edb.28.2024.03.25.14.19.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 14:19:42 -0700 (PDT)
Message-ID: <3376d9e8-7841-43b6-846a-45c75975fbb1@gmail.com>
Date: Mon, 25 Mar 2024 22:19:41 +0100
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/28] net: realtek: r8169: Use PCI_IRQ_INTX
To: Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>,
 Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
 linux-scsi@vger.kernel.org, "Martin K . Petersen"
 <martin.petersen@oracle.com>, Jaroslav Kysela <perex@perex.cz>,
 linux-sound@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-serial@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
 platform-driver-x86@vger.kernel.org, ntb@lists.linux.dev,
 Lee Jones <lee@kernel.org>, David Airlie <airlied@gmail.com>,
 amd-gfx@lists.freedesktop.org, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-rdma@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240325070944.3600338-1-dlemoal@kernel.org>
 <20240325070944.3600338-18-dlemoal@kernel.org>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20240325070944.3600338-18-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25.03.2024 08:09, Damien Le Moal wrote:
> Use the macro PCI_IRQ_INTX instead of the deprecated PCI_IRQ_LEGACY
> macro.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 5c879a5c86d7..7288afcc8c94 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -5076,7 +5076,7 @@ static int rtl_alloc_irq(struct rtl8169_private *tp)
>  		rtl_lock_config_regs(tp);
>  		fallthrough;
>  	case RTL_GIGA_MAC_VER_07 ... RTL_GIGA_MAC_VER_17:
> -		flags = PCI_IRQ_LEGACY;
> +		flags = PCI_IRQ_INTX;
>  		break;
>  	default:
>  		flags = PCI_IRQ_ALL_TYPES;

Acked-by: Heiner Kallweit <hkallweit1@gmail.com>

