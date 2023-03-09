Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7176C944D
	for <ntb@lists.linux.dev>; Thu,  9 Mar 2023 12:21:21 +0000 (UTC)
Received: by mail-lf1-f44.google.com with SMTP id g17so2034662lfv.4
        for <ntb@lists.linux.dev>; Thu, 09 Mar 2023 04:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678364479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uRa0blWSEXnn6q2w1/8Gfy5sISbK2MzouOx1CE1XExw=;
        b=C4mZT8kLH9vYdO54pnlkWllauKhEAbYC7Y7YB2E12ZxhU3s8qhLvnBiFBa5buto+Db
         H2SZfNc8uVGHmHhqPl3HbNAWCZlsFK3+gyh1G3NjafoxoOUlIuoK/HjGI66YTiGe2J1G
         v7jcPV/17Uk8IMQM+vZSXguU8qK8hPx81S9i5ymTqtrHjg0FokwR9NPDNo6cuWnDaKq1
         VreCQRoinNAD117T7IBuAumDnp6RzH+gv/NcI4bBnlSRN62XZ1lXgVYuSuf6JThtRvvE
         QjFAFnOXJcRQMC0Ms8dIs59p07kDUzcb5aQh/txPGypO3Zx7YryRTFi59SajRSBmy/Gz
         AP2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678364479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRa0blWSEXnn6q2w1/8Gfy5sISbK2MzouOx1CE1XExw=;
        b=qYI2kdTQTW6IUSgrfzzJlrb1FopjCXYN4PiJuv990IXmmsLnXsPmZx0NLNp52QiZl7
         WTY4yQ46Wyj9c+WTPSKME7ph4sQbDMu9cVdSvk5Z9N2uTxT8XwdA6oXuOPLJ1HH9ctMa
         q3IRXmOZzD6tIsd6bqIFlLMLHo8exb2Dn1b672xfTwcYLqViEQ4NzuMR9lj7DTP1L5M/
         fz4yo1Ws2HZWwYVv2RJDVg4mtImFYYVIYO2OPEYpRyPSIbIn3mWYxichFw55Izitj8Q4
         wINHxOYdtFnIxb/kVf2KWI+b4XSY62BIVXRfpaMYn/922VfnXQMAe8jBtnb49FOnZfF2
         NN3w==
X-Gm-Message-State: AO0yUKUujfcYx3wuYXU7BfUTq2obUCbWZf+C8A7phYQbB9QroI5yNC+6
	6BDKOcjUyvR+2BOajpWUD+s=
X-Google-Smtp-Source: AK7set8+NsKPLt1fU8TghCw5XK0qOHLr5tG1YdYHm1wSDY5SyE8mJXCH0G01X8uzFESKbz7NT6hCrQ==
X-Received: by 2002:ac2:518c:0:b0:4dc:8297:1b18 with SMTP id u12-20020ac2518c000000b004dc82971b18mr5803873lfi.67.1678364479361;
        Thu, 09 Mar 2023 04:21:19 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id n28-20020ac2491c000000b004dd0bbc89a1sm2627017lfi.244.2023.03.09.04.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 04:21:18 -0800 (PST)
Date: Thu, 9 Mar 2023 15:21:16 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yuan Can <yuancan@huawei.com>
Cc: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
	ntb@lists.linux.dev
Subject: Re: [PATCH] ntb: idt: Fix error handling in idt_pci_driver_init()
Message-ID: <20230309122116.dd77crokt2rmmbuw@mobilestation>
References: <20221105094301.106276-1-yuancan@huawei.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221105094301.106276-1-yuancan@huawei.com>

On Sat, Nov 05, 2022 at 09:43:01AM +0000, Yuan Can wrote:
> A problem about ntb_hw_idt create debugfs failed is triggered with the
> following log given:
> 
>  [ 1236.637636] IDT PCI-E Non-Transparent Bridge Driver 2.0
>  [ 1236.639292] debugfs: Directory 'ntb_hw_idt' with parent '/' already present!
> 
> The reason is that idt_pci_driver_init() returns pci_register_driver()
> directly without checking its return value, if pci_register_driver()
> failed, it returns without destroy the newly created debugfs, resulting
> the debugfs of ntb_hw_idt can never be created later.
> 
>  idt_pci_driver_init()
>    debugfs_create_dir() # create debugfs directory
>    pci_register_driver()
>      driver_register()
>        bus_add_driver()
>          priv = kzalloc(...) # OOM happened
>    # return without destroy debugfs directory
> 
> Fix by removing debugfs when pci_register_driver() returns error.

Indeed. Thanks for the patch.
Acked-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> 
> Fixes: bf2a952d31d2 ("NTB: Add IDT 89HPESxNTx PCIe-switches support")
> Signed-off-by: Yuan Can <yuancan@huawei.com>
> ---
>  drivers/ntb/hw/idt/ntb_hw_idt.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
> index 0ed6f809ff2e..51799fccf840 100644
> --- a/drivers/ntb/hw/idt/ntb_hw_idt.c
> +++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
> @@ -2891,6 +2891,7 @@ static struct pci_driver idt_pci_driver = {
>  
>  static int __init idt_pci_driver_init(void)
>  {
> +	int ret;
>  	pr_info("%s %s\n", NTB_DESC, NTB_VER);
>  
>  	/* Create the top DebugFS directory if the FS is initialized */
> @@ -2898,7 +2899,11 @@ static int __init idt_pci_driver_init(void)
>  		dbgfs_topdir = debugfs_create_dir(KBUILD_MODNAME, NULL);
>  
>  	/* Register the NTB hardware driver to handle the PCI device */
> -	return pci_register_driver(&idt_pci_driver);
> +	ret = pci_register_driver(&idt_pci_driver);
> +	if (ret)
> +		debugfs_remove_recursive(dbgfs_topdir);
> +
> +	return ret;
>  }
>  module_init(idt_pci_driver_init);
>  
> -- 
> 2.17.1
> 
