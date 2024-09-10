Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4602E187555
	for <ntb@lists.linux.dev>; Tue, 10 Sep 2024 13:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725974933; cv=none; b=iN5Uwz4GV7ffOGktHj+y0OX/dYBtf49qr5e0/1Dko9Y9cy9//lfl28HP+PBxsIRsUpZfnU3zUFuBzlmppJCWPMpRvjdzrrzk3kzNjZaAa+DN0d8kDDJY5wwNBMkKNzTgsEHeSU8PeFf0kYvW0UWAdd3fkzojLhGh4f/E4b3GXQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725974933; c=relaxed/simple;
	bh=Dr4EUNJkHyQEpzywJYm9Fe/wzizPhgHVcIRJz0ZB/KE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZazmyaJ6CguV2+iwO0Amou+CZcVj4WxCbBVnPk/QCxDMCiMB2FzsNIQTWuazi4n85TSDzEt7ODPKoeSISmkyTXKqjjVxhf3I/kccjPgBN4CyVIbACJLsdUFuguHuio3FoUHiCNcwG58CQZP6GDA1PRMjlZiMwW3HfOIOsoQ9kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kjbezq6b; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kjbezq6b"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53654dbde59so4470687e87.1
        for <ntb@lists.linux.dev>; Tue, 10 Sep 2024 06:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725974929; x=1726579729; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g6j4PxsFn3wNc1hm7H5+PRuctZ/budhyVJWzybcQoy4=;
        b=Kjbezq6bSWLqJU43hEDxmsNmNJ2S4GiwwqlhDr8Ds6/nMnHUhPVYkyG5Cy5jcaB1N0
         rlEbZjjihzmY9ajApwBf4pXQ0cvSuSlbsy86BxXKg5HHzWHbr8K6mXzUDC+IupTKNZbB
         B4RmVyuYY+GnueHmuPg8M5ZHbInkx/gmhhFndUILCloEP1X1/J3zjBvWqVV7QfYGNve0
         CXpQYQtkKfHsON5vOCijSPS9zmxRdpKRsZ6cYwFOrFQkoxyIYHtMC8h8xRqKJCxcv39x
         UtUatuNWdGc0Q1sCkzs6XcQB5wPj+hqDsV2NgcoHC58j4SEPOl9VJV3CTvUI9FDFsGof
         /N4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725974929; x=1726579729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g6j4PxsFn3wNc1hm7H5+PRuctZ/budhyVJWzybcQoy4=;
        b=d/BURfWbd17NtyTNbAgGmu8BIdCCHLyM2kejZyIq56Tj0+duRzb3A5tdOQ7GYNaqCv
         jyWqYOQ7Y0xC1h4DUdl7yyGzQSIZP8QSbzjxXq2OiyMO1I1LCH4j3Apw6CHytN7LzRka
         byUryyq1HyXGQMVP5y1DtxzvcZmSTWY0YWB8XUDwxYqmgyQUC5xLd9+BtxSm+LLmxUqq
         a7OhNVdAxFpcBRVm4u2fnqyDEQbMbHN2KubDyUZkMYDAjqF5t9tQXOHSXyuz5rytgpU3
         A4Kx+q9lDgqAgpbWKcOTMmdlpIY+cQ0ZCGoV/W8JT2Kj4nT2WMFQvDJr6yf8yjfgUhob
         7k/A==
X-Forwarded-Encrypted: i=1; AJvYcCXhFSmzoDSyeM6Il92+U5TwF3RxnNfUTn9NIdCw60Ldw2s48VQi5rF3fFww/q4GkY3sR0I=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz84V7RWJCb1EO5EXDm0JkMurt5exsPq5lvkwCz0prObxYqNL7g
	ZhpOsIGIL/eZuZkYh5lMQ5waZ93KR9g4Rwb39Zj+dHQLJvpMwCGv
X-Google-Smtp-Source: AGHT+IGpyoHP7m1wzkv5bQx4wg14My3xs9L8028bsj4qTQYPgqfdW7XHRU49/9Fqempu4AyVrD4Xag==
X-Received: by 2002:a05:6512:1114:b0:533:4517:5363 with SMTP id 2adb3069b0e04-5366bb3d49amr1073479e87.21.1725974928821;
        Tue, 10 Sep 2024 06:28:48 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5365f868c41sm1169977e87.21.2024.09.10.06.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 06:28:48 -0700 (PDT)
Date: Tue, 10 Sep 2024 16:28:45 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
Cc: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, 
	ntb@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ntb: idt: Fix the cacography in ntb_hw_idt.c
Message-ID: <43c2y2dpl5lk7ii3w4s5o25hkmt3uv774j2jukvhvebw3fjfte@2mrvimbgyh2s>
References: <20240904065442.102889-1-zhangjiao2@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904065442.102889-1-zhangjiao2@cmss.chinamobile.com>

On Wed, Sep 04, 2024 at 02:54:42PM +0800, zhangjiao2 wrote:
> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> 
> The word 'swtich' is wrong, so fix it.
> 
> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>

Acked-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> ---
>  drivers/ntb/hw/idt/ntb_hw_idt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
> index 48dfb1a69a77..6fc9dfe82474 100644
> --- a/drivers/ntb/hw/idt/ntb_hw_idt.c
> +++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
> @@ -2547,7 +2547,7 @@ static void idt_deinit_dbgfs(struct idt_ntb_dev *ndev)
>   */
>  
>  /*
> - * idt_check_setup() - Check whether the IDT PCIe-swtich is properly
> + * idt_check_setup() - Check whether the IDT PCIe-switch is properly
>   *		       pre-initialized
>   * @pdev:	Pointer to the PCI device descriptor
>   *
> -- 
> 2.33.0
> 
> 
> 
