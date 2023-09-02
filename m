Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBC5185D
	for <ntb@lists.linux.dev>; Sat,  2 Sep 2023 05:12:08 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5694a117254so1990264a12.0
        for <ntb@lists.linux.dev>; Fri, 01 Sep 2023 22:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693631527; x=1694236327; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=r8vaSTPW9tq/2PvzUS7UQE38t7wNIDxl1GYzejiN7sk=;
        b=K6hlywpFHi+vAffh7SRj7rAQxxhUj+R7qqKBIvqSBkESFfXsccxiLk4GN2al3CopF/
         qaKIsZBgCWzMGZYha6/Ogk4ntfxWCZeIB4S5oCGwHkwOKI5ME+fsvoshSLS1GkRd0NN9
         5PLvWAP+7e58e5QTc21Jr1l1mbqJ9iwoPTeGbGrKn2xDWfe7lh/CzOxkwOgLmbbCdE8H
         gS6WK1ZOdnk+MadVBARQLf0mHokm0SI6yh/JgcEZNLplfzWTuLswcmb2sAJi9WWqquBo
         8K4/bK1ZvqkvW6gK/Cj0pcHP5dDHRLwwllh+YE1RRxCl7sltS8hSQQGspshOwOeUJ6Qx
         /pCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693631527; x=1694236327;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r8vaSTPW9tq/2PvzUS7UQE38t7wNIDxl1GYzejiN7sk=;
        b=JHzg1/OvOYoRQpvfkIJ3aj/PSgjiE9y7XKw6qKbGK0A8/sM7OgG7F8/C0Fpc20ifd+
         JsSKbM3yliQ+b8CSqzgg0GodchrCKHy5aU6ZLzj1jCkNFXUOkvbfL6cJpXCnDAN8/hPP
         DXlfipRkPFy5wYQ3cjojjYpasFFblk1m7NOy7fNrllMqpeKuGJRU/STKRScBiL4Y7xBX
         81ziQhq7LfhPo/hNotzrRVG8KJk8Y5Uo7WmM3zbUaeRPqghB948ZGetD4AFQQlNJQYoB
         NfsYDCHKzJZ+J/75eJBTADZ085l5z8eIHoYxMWphn661T/ZJ8z/b5x+RlXUFoNdRxXhQ
         eung==
X-Gm-Message-State: AOJu0Yw870OpjpTFCnRAwjYqtqlKrkqsCJHbnfNhsmhejogOhJevrVfy
	Qz3K2YlfExiTmd76aw4xQ4tb
X-Google-Smtp-Source: AGHT+IHgsXpqTNSkB6YwoRAaMwF4G43/AdpXBzgcVLTWHC96ohQGa3KhTjGgDtkfaxi1IoC3pHwD6A==
X-Received: by 2002:a05:6a20:938d:b0:138:64d4:b055 with SMTP id x13-20020a056a20938d00b0013864d4b055mr5948002pzh.55.1693631527333;
        Fri, 01 Sep 2023 22:12:07 -0700 (PDT)
Received: from thinkpad ([117.217.187.8])
        by smtp.gmail.com with ESMTPSA id k188-20020a636fc5000000b0055bf13811f5sm3658873pgc.15.2023.09.01.22.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 22:12:06 -0700 (PDT)
Date: Sat, 2 Sep 2023 10:41:55 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: tglx@linutronix.de, aisheng.dong@nxp.com, bhelgaas@google.com,
	devicetree@vger.kernel.org, festevam@gmail.com, imx@lists.linux.dev,
	jdmason@kudzu.us, kernel@pengutronix.de, kishon@ti.com,
	krzysztof.kozlowski+dt@linaro.org, kw@linux.com,
	linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lorenzo.pieralisi@arm.com, lpieralisi@kernel.org, maz@kernel.org,
	ntb@lists.linux.dev, peng.fan@nxp.com, robh+dt@kernel.org,
	s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: Re: [PATCH 2/3] misc: pci_endpoint_test: Add doorbell test case
Message-ID: <20230902051155.GC2913@thinkpad>
References: <20230426203436.1277307-1-Frank.Li@nxp.com>
 <20230426203436.1277307-3-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230426203436.1277307-3-Frank.Li@nxp.com>

On Wed, Apr 26, 2023 at 04:34:35PM -0400, Frank Li wrote:
> Reused flags as capability register in pci_endpoint_test struct to
> support older driver versions. Save capability flags to 'cap' field
> of struct pci_endpoint_test to prevent reading non-existent address.
> 

This won't work, please see below.

> Add three registers: PCIE_ENDPOINT_TEST_DB_BAR, PCIE_ENDPOINT_TEST_DB_ADDR,
> PCIE_ENDPOINT_TEST_DB_DATA.
> 
> Write data from PCI_ENDPOINT_TEST_DB_DATA to address from
> PCI_ENDPOINT_TEST_DB_ADDR to trigger doorbell and wait for remote
> endpoint feedback.

"wait for endpoint response"

> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/misc/pci_endpoint_test.c | 41 ++++++++++++++++++++++++++++++++
>  include/uapi/linux/pcitest.h     |  1 +
>  2 files changed, 42 insertions(+)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index ed4d0ef5e5c3..3320a3334594 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -52,6 +52,7 @@
>  #define STATUS_IRQ_RAISED			BIT(6)
>  #define STATUS_SRC_ADDR_INVALID			BIT(7)
>  #define STATUS_DST_ADDR_INVALID			BIT(8)
> +#define STATUS_DOORBELL_SUCCESS			BIT(9)
>  
>  #define PCI_ENDPOINT_TEST_LOWER_SRC_ADDR	0x0c
>  #define PCI_ENDPOINT_TEST_UPPER_SRC_ADDR	0x10
> @@ -66,7 +67,12 @@
>  #define PCI_ENDPOINT_TEST_IRQ_NUMBER		0x28
>  
>  #define PCI_ENDPOINT_TEST_FLAGS			0x2c
> +#define PCI_ENDPOINT_TEST_DB_BAR		0x30
> +#define PCI_ENDPOINT_TEST_DB_ADDR		0x34
> +#define PCI_ENDPOINT_TEST_DB_DATA		0x38
> +
>  #define FLAG_USE_DMA				BIT(0)
> +#define FLAG_SUPPORT_DOORBELL			BIT(1)
>  
>  #define PCI_DEVICE_ID_TI_AM654			0xb00c
>  #define PCI_DEVICE_ID_TI_J7200			0xb00f
> @@ -102,6 +108,7 @@ enum pci_barno {
>  	BAR_3,
>  	BAR_4,
>  	BAR_5,
> +	NO_BAR = -1,
>  };
>  
>  struct pci_endpoint_test {
> @@ -118,6 +125,7 @@ struct pci_endpoint_test {
>  	enum pci_barno test_reg_bar;
>  	size_t alignment;
>  	const char *name;
> +	u32 cap;
>  };
>  
>  struct pci_endpoint_test_data {
> @@ -713,6 +721,35 @@ static bool pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
>  	return false;
>  }
>  
> +static bool pci_endpoint_test_doorbell(struct pci_endpoint_test *test)
> +{
> +	enum pci_barno bar;
> +	u32 data;
> +	u32 addr;
> +
> +	if (!(test->cap & FLAG_SUPPORT_DOORBELL))
> +		return false;
> +
> +	bar = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_BAR);
> +	if (bar == NO_BAR)
> +		return false;

Is this possible?

> +
> +	data = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_DATA);
> +	addr = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_ADDR);
> +	bar = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_BAR);
> +
> +	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_STATUS, 0);
> +	pci_endpoint_test_bar_writel(test, bar, addr, data);

From patch 1, I understood that EP supports multiple doorbell. But you are not
making use of it here?

> +
> +	wait_for_completion(&test->irq_raised);
> +

No timeout?

> +	data = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
> +	if (data & STATUS_DOORBELL_SUCCESS)

Please use a separate variable.

> +		return true;
> +
> +	return false;
> +}
> +
>  static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
>  				    unsigned long arg)
>  {
> @@ -760,6 +797,9 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
>  	case PCITEST_CLEAR_IRQ:
>  		ret = pci_endpoint_test_clear_irq(test);
>  		break;
> +	case PCITEST_DOORBELL:
> +		ret = pci_endpoint_test_doorbell(test);
> +		break;
>  	}
>  
>  ret:
> @@ -887,6 +927,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
>  	misc_device->parent = &pdev->dev;
>  	misc_device->fops = &pci_endpoint_test_fops;
>  
> +	test->cap = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_FLAGS);

This register will be overwritten by this driver during (copy,read,write) tests.
So this logic will not work.

- Mani

>  	err = misc_register(misc_device);
>  	if (err) {
>  		dev_err(dev, "Failed to register device\n");
> diff --git a/include/uapi/linux/pcitest.h b/include/uapi/linux/pcitest.h
> index f9c1af8d141b..479ca1aa3ae0 100644
> --- a/include/uapi/linux/pcitest.h
> +++ b/include/uapi/linux/pcitest.h
> @@ -20,6 +20,7 @@
>  #define PCITEST_SET_IRQTYPE	_IOW('P', 0x8, int)
>  #define PCITEST_GET_IRQTYPE	_IO('P', 0x9)
>  #define PCITEST_CLEAR_IRQ	_IO('P', 0x10)
> +#define PCITEST_DOORBELL	_IO('P', 0x11)
>  
>  #define PCITEST_FLAGS_USE_DMA	0x00000001
>  
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
