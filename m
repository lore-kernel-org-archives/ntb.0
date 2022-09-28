Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517F87B
	for <ntb@lists.linux.dev>; Wed, 28 Sep 2022 11:12:00 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id 13so26390227ejn.3
        for <ntb@lists.linux.dev>; Wed, 28 Sep 2022 04:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=CLhAIIvy9Y2ruJAf9+yREPotjEO2NIAIDlqLdK6fCj8=;
        b=S4MsPIJVPO+68AA+mS05lXRQC4HVgjwJ18Vc/QUIEVxLoxPcUeof2CnaBJzMoDIYk8
         M+0qyGNpb9Ao1b8c/uPDjbouH/PWRh0M7CyODt4MMq+D6p1t9Bib4bOlYt75fthcpF9H
         PQptnubFI1DM8bmWsNON6U6pvQZHrzaZp54LJ8FxuXuOH0GuNjIfHruOlbixT0kcXJrx
         xUjTxARLE521qTa/R7nKswBdwb+OIFaEB6tEUKOzcGHf/wmA1RsUacAM0+lX1Ha7QATb
         IIF3HH+/f7NPdtnTcowx7IEbxm55j5n29Ohz485aiWwO/zm5RPs8Cv5m6EJBPxpbi2L8
         H7hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=CLhAIIvy9Y2ruJAf9+yREPotjEO2NIAIDlqLdK6fCj8=;
        b=fkQoxkXupg9vkzidh1ehjtams4cbs23Quzmu7v2ue9fb460MVcSIbDlaU2drl3XSww
         meZaZboI9mN/1iBDRrLQ2OO/WtT7xdpeuGv4zXRmEQYjaVwfQPKQIaNItHPRJkfSBa2t
         K0b9cd8Z3VIHGISH9wyB4eIwe28IO896MiG+cgX29i9VKcQeuRQuRgfqff8++YjHfHF0
         ck4vYbdmPRnqbaFNIWyvw8CMXhVs0bOdNlShnAVwgm0Aayoc+ACbkQiVjMSXqUs/mnvO
         DX7tHlYV0DBEX70M3dcICpMTZZy55JpoGVZITSEwCbl+Jal7c0vStv5f/eQy1bosPmhJ
         whUg==
X-Gm-Message-State: ACrzQf22oGWXKmvAOR2670j9+tJplQXmxydBbJmc2VejVahys9pKIFiF
	07p0VAkTaI338SDlPZqtaKzCKec7nw7p0A==
X-Google-Smtp-Source: AMsMyM468iUduFFvtvCoOKe8j5rLxxlMzuyn20KnDLob97Sp2PgkxoG9AeKGHuYJJU8EdjFEAHHOOg==
X-Received: by 2002:ac2:4e09:0:b0:499:1e3a:54ab with SMTP id e9-20020ac24e09000000b004991e3a54abmr12665761lfr.170.1664363038738;
        Wed, 28 Sep 2022 04:03:58 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id v6-20020a197406000000b00499d70c0310sm446966lfe.3.2022.09.28.04.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 04:03:58 -0700 (PDT)
Date: Wed, 28 Sep 2022 14:03:55 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Zhuo Chen <chenzhuo.1@bytedance.com>
Cc: sathyanarayanan.kuppuswamy@linux.intel.com, bhelgaas@google.com,
	ruscur@russell.cc, oohall@gmail.com, jdmason@kudzu.us,
	dave.jiang@intel.com, allenbh@gmail.com, james.smart@broadcom.com,
	dick.kennedy@broadcom.com, jejb@linux.ibm.com,
	martin.petersen@oracle.com, linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev, linux-scsi@vger.kernel.org
Subject: Re: [PATCH v3 3/9] NTB: Remove pci_aer_clear_nonfatal_status() call
Message-ID: <20220928110355.emf2nucmdmpb3vbu@mobilestation>
References: <20220928105946.12469-1-chenzhuo.1@bytedance.com>
 <20220928105946.12469-4-chenzhuo.1@bytedance.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928105946.12469-4-chenzhuo.1@bytedance.com>

On Wed, Sep 28, 2022 at 06:59:40PM +0800, Zhuo Chen wrote:
> There is no need to clear error status during init code, so remove it.

Why do you think there isn't? Justify in more details.

-Sergey

> 
> Signed-off-by: Zhuo Chen <chenzhuo.1@bytedance.com>
> ---
>  drivers/ntb/hw/idt/ntb_hw_idt.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
> index 0ed6f809ff2e..fed03217289d 100644
> --- a/drivers/ntb/hw/idt/ntb_hw_idt.c
> +++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
> @@ -2657,8 +2657,6 @@ static int idt_init_pci(struct idt_ntb_dev *ndev)
>  	ret = pci_enable_pcie_error_reporting(pdev);
>  	if (ret != 0)
>  		dev_warn(&pdev->dev, "PCIe AER capability disabled\n");
> -	else /* Cleanup nonfatal error status before getting to init */
> -		pci_aer_clear_nonfatal_status(pdev);
>  
>  	/* First enable the PCI device */
>  	ret = pcim_enable_device(pdev);
> -- 
> 2.30.1 (Apple Git-130)
> 
