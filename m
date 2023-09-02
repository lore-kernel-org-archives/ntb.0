Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D37A15C1
	for <ntb@lists.linux.dev>; Sat,  2 Sep 2023 04:52:26 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1c0bae4da38so4111145ad.0
        for <ntb@lists.linux.dev>; Fri, 01 Sep 2023 21:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693630346; x=1694235146; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ijD/QXgkfcmQQpjgZVWk02lSeb5Kah86yA9TYX6zx1I=;
        b=nVQ6huGlXRYUPlgv10ukoWEQIeXlNwUjGnvdJHgxN9DuASf8LmIcCGCtGKoXrDem/i
         LiYX7Jev8sVS7mV+7HHtiQzx/cQcj3QnaqFU2Mu4ThP0xKfpe5E6NCDTiYCB/1pIjnGw
         5aPS8OziUUdBbG87G53R6y0g+aiT7EN71MNJpBf4k4VQ3tP2L8KFD7SXkV3EJiwR7HX7
         2ClL2QC4ebiEu4o+UzVgU0Y9uKzsWy347D8j/TRkxqB8kqKLaFAPy6xzCON9mLN5QuPN
         wH7OpAkiNCHP+eyEFiKcSgoCCEiaGtT6PGE2mWI6NiMJZjCI+aEmCKtu0AXt80Cb6+Cu
         Q7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693630346; x=1694235146;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ijD/QXgkfcmQQpjgZVWk02lSeb5Kah86yA9TYX6zx1I=;
        b=bZmJVkVfXvfRwwlE0qq6oIWhhs6KN5kQa5qObXnEToBOUUemWaggE3y247HerabOws
         je5Cblc3xsIbXmPS/CfTvUCHvmdumo1oQddnHdBDkhSgfTsjtLWvnuCRMdS1bmwY5rRA
         monQ+YkEMnPnOLtbT/TzDj0/SWHPzKK3DV6IGLJX2b/JzVMRbQlA2MN+LAeuIXJCNLAV
         GrHi4MLsa+btNj2kNnCW/ehMSy8AzmqVHxuBYetLfaPDbcBjwj+ZILOGOvLF2bCDTRdU
         CNeRnJ2FTiyLlFWqBp8tquId71xlsYgPsTWq9xr7nL8EVcS5Lo+1FACezl6vdbykixII
         LEuw==
X-Gm-Message-State: AOJu0YxkAZ5UvQtPRiykIQb8705M4h1oPtna26IlZGwbUcOoDIajUGSJ
	F/oqbS8nbSYQtqWu2yDZEQw3
X-Google-Smtp-Source: AGHT+IHn+lpzw9uFuVsUrK4hFksx30nUuJVmCY/9azhZGZuuOYfsE09NMsfHfbXcr11fLWIN9x+S/g==
X-Received: by 2002:a17:902:ce83:b0:1bc:2fe1:1821 with SMTP id f3-20020a170902ce8300b001bc2fe11821mr6157887plg.17.1693630345688;
        Fri, 01 Sep 2023 21:52:25 -0700 (PDT)
Received: from thinkpad ([117.217.187.8])
        by smtp.gmail.com with ESMTPSA id u10-20020a170902e80a00b001aadd0d7364sm3794308plg.83.2023.09.01.21.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 21:52:24 -0700 (PDT)
Date: Sat, 2 Sep 2023 10:22:14 +0530
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
Subject: Re: [PATCH 1/3] PCI: endpoint: Add RC-to-EP doorbell support using
 platform MSI controller
Message-ID: <20230902045214.GA2913@thinkpad>
References: <20230426203436.1277307-1-Frank.Li@nxp.com>
 <20230426203436.1277307-2-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230426203436.1277307-2-Frank.Li@nxp.com>

On Wed, Apr 26, 2023 at 04:34:34PM -0400, Frank Li wrote:
> This commit introduces a common method for sending messages from the Root Complex
> (RC) to the Endpoint (EP) by utilizing the platform MSI interrupt controller,
> such as ARM GIC, as an EP doorbell. Maps the memory assigned for the BAR region
> by the PCI host to the message address of the platform MSI interrupt controller
> in the PCI EP. As a result, when the PCI RC writes to the BAR region, it triggers
> an IRQ at the EP. This implementation serves as a common method for all endpoint
> function drivers.
> 
> However, it currently supports only one EP physical function due to limitations
> in ARM MSI/IMS readiness.
> 

I've provided generic comments below, but I will do one more thorough review
after seeing epf-test driver patch.

> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/endpoint/pci-epf-core.c | 109 ++++++++++++++++++++++++++++
>  include/linux/pci-epf.h             |  16 ++++
>  2 files changed, 125 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> index 355a6f56fcea..94ac82bf84c5 100644
> --- a/drivers/pci/endpoint/pci-epf-core.c
> +++ b/drivers/pci/endpoint/pci-epf-core.c
> @@ -6,10 +6,12 @@
>   * Author: Kishon Vijay Abraham I <kishon@ti.com>
>   */
>  
> +#include <linux/irqreturn.h>

Why is this needed?

>  #include <linux/device.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>
> +#include <linux/msi.h>
>  
>  #include <linux/pci-epc.h>
>  #include <linux/pci-epf.h>
> @@ -300,6 +302,113 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
>  }
>  EXPORT_SYMBOL_GPL(pci_epf_alloc_space);
>  
> +static enum irqreturn pci_epf_interrupt_handler(int irq, void *data)

static irqreturn_t

s/pci_epf_interrupt_handler/pci_epf_doorbell_handler

> +{
> +	struct pci_epf *epf = data;
> +
> +	if (epf->event_ops && epf->event_ops->doorbell)
> +		epf->event_ops->doorbell(epf, irq - epf->virq_base);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void pci_epf_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
> +{
> +	struct pci_epc *epc = container_of(desc->dev, struct pci_epc, dev);
> +	struct pci_epf *epf;
> +
> +	/* Todo: Need check correct epf if multi epf supported */
> +	list_for_each_entry(epf, &epc->pci_epf, list) {
> +		if (epf->msg && desc->msi_index < epf->num_msgs)
> +			epf->msg[desc->msi_index] = *msg;
> +	}
> +}
> +
> +int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_msgs)
> +{
> +	struct irq_domain *domain;
> +	struct pci_epc *epc;
> +	struct device *dev;
> +	int virq;
> +	int ret;
> +	int i;
> +
> +	epc = epf->epc;
> +	dev = &epc->dev;

"epc_dev" to make it explicit

> +
> +	/*
> +	 * Current only support 1 function.

What does this mean exactly? Even a single EPC can support multiple EPFs

> +	 * PCI IMS(interrupt message store) ARM support have not been
> +	 * ready yet.

No need to mention platform irq controller name.

> +	 */
> +	if (epc->function_num_map != 1)

Why can't you use, epf->func_no?

> +		return -EOPNOTSUPP;
> +
> +	domain = dev_get_msi_domain(dev->parent);
> +	if (!domain)
> +		return -EOPNTSUPP;

Newline

> +	dev_set_msi_domain(dev, domain);
> +
> +	/* use parent of_node to get device id information */
> +	dev->of_node = dev->parent->of_node;
> +

Why do you need of_node assignment inside EPF core?

> +	epf->msg = kcalloc(num_msgs, sizeof(struct msi_msg), GFP_KERNEL);
> +	if (!epf->msg)
> +		return -ENOMEM;
> +
> +	epf->num_msgs = num_msgs;
> +

Move this to the start of the function, after checks.

> +	ret = platform_msi_domain_alloc_irqs(dev, num_msgs, pci_epf_write_msi_msg);
> +	if (ret) {
> +		dev_err(dev, "Can't allocate MSI from system MSI controller\n");

"Failed to allocate MSI"

> +		goto err_mem;

err_free_mem

> +	}
> +
> +	for (i = 0; i < num_msgs; i++) {
> +		virq = msi_get_virq(dev, i);
> +		if (i == 0)
> +			epf->virq_base = virq;
> +
> +		ret = request_irq(virq, pci_epf_interrupt_handler, 0,
> +				  "pci-epf-doorbell", epf);

IRQ name should have an index, otherwise all of them will have the same name.

> +
> +		if (ret) {
> +			dev_err(dev, "Failure request doorbell IRQ\n");

"Failed to request doorbell"

> +			goto err_irq;

err_free_irq

> +		}
> +	}
> +
> +	epf->num_msgs = num_msgs;

Newline

> +	return ret;
> +
> +err_irq:
> +	platform_msi_domain_free_irqs(dev);
> +err_mem:
> +	kfree(epf->msg);
> +	epf->msg = NULL;
> +	epf->num_msgs = 0;
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(pci_epf_alloc_doorbell);
> +
> +void pci_epf_free_doorbell(struct pci_epf *epf)
> +{
> +	struct pci_epc *epc;
> +	int i;
> +
> +	epc = epf->epc;
> +
> +	for (i = 0; i < epf->num_msgs; i++)
> +		free_irq(epf->virq_base + i, epf);
> +
> +	platform_msi_domain_free_irqs(&epc->dev);
> +	kfree(epf->msg);
> +	epf->msg = NULL;
> +	epf->num_msgs = 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_epf_free_doorbell);
> +
>  static void pci_epf_remove_cfs(struct pci_epf_driver *driver)
>  {
>  	struct config_group *group, *tmp;
> diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> index b8441db2fa52..e187e3ee48d2 100644
> --- a/include/linux/pci-epf.h
> +++ b/include/linux/pci-epf.h
> @@ -75,6 +75,7 @@ struct pci_epf_ops {
>  struct pci_epc_event_ops {
>  	int (*core_init)(struct pci_epf *epf);
>  	int (*link_up)(struct pci_epf *epf);
> +	int (*doorbell)(struct pci_epf *epf, int index);
>  };
>  
>  /**
> @@ -173,6 +174,9 @@ struct pci_epf {
>  	unsigned long		vfunction_num_map;
>  	struct list_head	pci_vepf;
>  	const struct pci_epc_event_ops *event_ops;
> +	struct msi_msg *msg;
> +	u16 num_msgs;
> +	int virq_base;
>  };
>  
>  /**
> @@ -216,4 +220,16 @@ int pci_epf_bind(struct pci_epf *epf);
>  void pci_epf_unbind(struct pci_epf *epf);
>  int pci_epf_add_vepf(struct pci_epf *epf_pf, struct pci_epf *epf_vf);
>  void pci_epf_remove_vepf(struct pci_epf *epf_pf, struct pci_epf *epf_vf);
> +int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 nums);
> +void pci_epf_free_doorbell(struct pci_epf *epf);
> +
> +static inline struct msi_msg *epf_get_msg(struct pci_epf *epf)
> +{
> +	return epf->msg;
> +}
> +
> +static inline u16 epf_get_msg_num(struct pci_epf *epf)
> +{
> +	return epf->num_msgs;
> +}

I don't see a need for these two functions as they are doing just dereferences.

- Mani

>  #endif /* __LINUX_PCI_EPF_H */
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
