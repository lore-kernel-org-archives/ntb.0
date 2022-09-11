Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459E17F
	for <ntb@lists.linux.dev>; Sun, 11 Sep 2022 17:55:25 +0000 (UTC)
Received: by mail-lf1-f54.google.com with SMTP id i26so11303867lfp.11
        for <ntb@lists.linux.dev>; Sun, 11 Sep 2022 10:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=VEJy1x5TZGP5URPmn4SDTLghBYL9AVkOVQRYf4QIsnU=;
        b=BjbhZYwTgWHvHFOJ7wKd1iax7YUI1rtKS4EV0EAWz2kNKadMyYiPFaqNSNtQ5Fjj0W
         /T3DzC6O6OvvELskGg9ralpJD0n1rvqkGIJZ2OXmCxVE/e7ubFlNwdRLtZASLpXKzprE
         VOvEJX49Cwnfjvh+WRGycoCatsDxJjsSoLk39MblEvphPO3GC0KnZeoxa7w6HbgCHpdK
         nsXuHw1lEF++BCCHDV9l2nZe6aARx4+MzkF2tkEFtf+tXOCfHOnNMYB9PBuNpBeuNBk3
         qdmgui9Uqrdhjd2fJbDO0Rpt4dLRU80PnDkTmHuWxMxbAP7g6N6zT2lRGBAZLm3Pfu10
         cmEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=VEJy1x5TZGP5URPmn4SDTLghBYL9AVkOVQRYf4QIsnU=;
        b=UDzwLu6MEH+xnOYRUmiqvZwmzTFucAVkvpL5LtTiRr1sMMYmiA22wch/xNfomNCTtr
         HWM6iOIVTa20WpXLFwMFLJLVRPByrjBz7TVfPlAMFE7RbUgCUqOk4WSvB1jtvFHqtDiG
         N5j1tpszXmElaUX/Nfj/aIT0JEbyCbu+8enL9RSEYRG5OPdMqcOUZNwq0+19zAgVLg8V
         XHRI4OsWjvaBAyscBjWgZgdQs1AEx3IvNAhBT28LHvenqGoO4JSheQm6MIBFTnekHy+r
         C8GuMaLgp+Cqel8trIDlRR5Y1X+xnAtyXiVdKjN8FVtmWdfF4yY9ogX/6BFRI1ve/noY
         yG6Q==
X-Gm-Message-State: ACgBeo2Zf3IySFKU3G/wbYh66DTV7DLJxbAUyolksQkv9NsCUZ+0yrLU
	XmdeDXgTzqewuMgHsj50FHk=
X-Google-Smtp-Source: AA6agR7vuWaSLfU4cGtKeTkEJwxHslQfihZnLuK2XJOREX5Uh/fX5sdxIqwnZ9I8qNrwllbk9gA4GA==
X-Received: by 2002:ac2:4e6a:0:b0:492:f027:218e with SMTP id y10-20020ac24e6a000000b00492f027218emr7949839lfs.676.1662918923136;
        Sun, 11 Sep 2022 10:55:23 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id 17-20020a2e0311000000b002648152512asm718564ljd.90.2022.09.11.10.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 10:55:22 -0700 (PDT)
Date: Sun, 11 Sep 2022 20:55:20 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Zhuo Chen <chenzhuo.1@bytedance.com>
Cc: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
	bhelgaas@google.com, ruscur@russell.cc, oohall@gmail.com,
	james.smart@broadcom.com, dick.kennedy@broadcom.com,
	jejb@linux.ibm.com, martin.petersen@oracle.com, ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-scsi@vger.kernel.org
Subject: Re: [External] Re: [PATCH 1/3] PCI/AER: Use
 pci_aer_clear_uncorrect_error_status() to clear uncorrectable error status
Message-ID: <20220911175520.375znik2pc4rggpz@mobilestation>
References: <20220901181634.99591-1-chenzhuo.1@bytedance.com>
 <20220901181634.99591-2-chenzhuo.1@bytedance.com>
 <20220911162206.5f2uctuotuddqpre@mobilestation>
 <69f2df4e-b2c6-0f19-bf8d-92b7d6c4e033@bytedance.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <69f2df4e-b2c6-0f19-bf8d-92b7d6c4e033@bytedance.com>

On Mon, Sep 12, 2022 at 01:09:05AM +0800, Zhuo Chen wrote:
> 
> 
> On 9/12/22 12:22 AM, Serge Semin wrote:
> > Hi Zhuo
> > 
> > On Fri, Sep 02, 2022 at 02:16:32AM +0800, Zhuo Chen wrote:
> > > Status bits for ERR_NONFATAL errors only are cleared in
> > > pci_aer_clear_nonfatal_status(), but we want clear uncorrectable
> > > error status in ntb_hw_idt.c and lpfc_attr.c. So we add
> > > pci_aer_clear_uncorrect_error_status() and change to use it.
> > 
> > What about the next drivers
> > 
> > drivers/scsi/lpfc/lpfc_attr.c
> > drivers/crypto/hisilicon/qm.c
> > drivers/net/ethernet/intel/ice/ice_main.c
> > 
> > which call the pci_aer_clear_nonfatal_status() method too?
> 
> ‘pci_aer_clear_nonfatal_status()’ in
> drivers/net/ethernet/intel/ice/ice_main.c has already been removed and
> merged in kernel in: https://github.com/torvalds/linux/commit/ca415ea1f03abf34fc8e4cc5fc30a00189b4e776
> 
> ‘pci_aer_clear_nonfatal_status()’ in drivers/crypto/hisilicon/qm.c will be
> removed in the next kernel:
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/crypto/hisilicon/qm.c?id=00278564a60e11df8bcca0ececd8b2f55434e406
> 
> Uncorrectable error status register was intended to be cleared in
> drivers/scsi/lpfc/lpfc_attr.c. But originally function was changed in https://github.com/torvalds/linux/commit/e7b0b847de6db161e3917732276e425bc92a2feb
> and
> https://github.com/torvalds/linux/commit/894020fdd88c1e9a74c60b67c0f19f1c7696ba2f

Got it. Thanks for clarification.

-Sergey

> > 
> > > 
> > > Use pci_aer_clear_nonfatal_status() in dpc_process_error(), which has
> > > no functional changes.
> > > 
> > > Since pci_aer_clear_nonfatal_status() is used only internally, move
> > > its declaration to the PCI internal header file. Also, no one cares
> > > about return value of pci_aer_clear_nonfatal_status(), so make it void.
> > > 
> > > Signed-off-by: Zhuo Chen <chenzhuo.1@bytedance.com>
> > > ---
> > >   drivers/ntb/hw/idt/ntb_hw_idt.c |  4 ++--
> > >   drivers/pci/pci.h               |  2 ++
> > >   drivers/pci/pcie/aer.c          | 23 ++++++++++++++++++-----
> > >   drivers/pci/pcie/dpc.c          |  3 +--
> > >   drivers/scsi/lpfc/lpfc_attr.c   |  4 ++--
> > >   include/linux/aer.h             |  4 ++--
> > >   6 files changed, 27 insertions(+), 13 deletions(-)
> > > 
> > > diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
> > > index 733557231ed0..de1dbbc5b9de 100644
> > > --- a/drivers/ntb/hw/idt/ntb_hw_idt.c
> > > +++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
> > > @@ -2657,8 +2657,8 @@ static int idt_init_pci(struct idt_ntb_dev *ndev)
> > >   	ret = pci_enable_pcie_error_reporting(pdev);
> > >   	if (ret != 0)
> > >   		dev_warn(&pdev->dev, "PCIe AER capability disabled\n");
> > 
> > > -	else /* Cleanup nonfatal error status before getting to init */
> > > -		pci_aer_clear_nonfatal_status(pdev);
> > > +	else /* Cleanup uncorrectable error status before getting to init */
> > > +		pci_aer_clear_uncorrect_error_status(pdev);
> > 
> >  From the IDT NTB PCIe initialization procedure point of view both of
> > these methods are equivalent. So for the IDT NTB part:
> > 
> IDT NTB part is the same as drivers/scsi/lpfc/lpfc_attr.c. The original
> function is clear uncorrectable error status register including fatal and
> non-fatal error status bits.
> 
> > Acked-by: Serge Semin <fancer.lancer@gmail.com>
> > 
> > -Sergey
> > 
> > >   	/* First enable the PCI device */
> > >   	ret = pcim_enable_device(pdev);
> > > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > > index e10cdec6c56e..574176f43025 100644
> > > --- a/drivers/pci/pci.h
> > > +++ b/drivers/pci/pci.h
> > > @@ -686,6 +686,7 @@ void pci_aer_init(struct pci_dev *dev);
> > >   void pci_aer_exit(struct pci_dev *dev);
> > >   extern const struct attribute_group aer_stats_attr_group;
> > >   void pci_aer_clear_fatal_status(struct pci_dev *dev);
> > > +void pci_aer_clear_nonfatal_status(struct pci_dev *dev);
> > >   int pci_aer_clear_status(struct pci_dev *dev);
> > >   int pci_aer_raw_clear_status(struct pci_dev *dev);
> > >   #else
> > > @@ -693,6 +694,7 @@ static inline void pci_no_aer(void) { }
> > >   static inline void pci_aer_init(struct pci_dev *d) { }
> > >   static inline void pci_aer_exit(struct pci_dev *d) { }
> > >   static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
> > > +static inline void pci_aer_clear_nonfatal_status(struct pci_dev *dev) { }
> > >   static inline int pci_aer_clear_status(struct pci_dev *dev) { return -EINVAL; }
> > >   static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL; }
> > >   #endif
> > > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > > index 7952e5efd6cf..d2996afa80f6 100644
> > > --- a/drivers/pci/pcie/aer.c
> > > +++ b/drivers/pci/pcie/aer.c
> > > @@ -251,13 +251,13 @@ int pci_disable_pcie_error_reporting(struct pci_dev *dev)
> > >   }
> > >   EXPORT_SYMBOL_GPL(pci_disable_pcie_error_reporting);
> > > -int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
> > > +void pci_aer_clear_nonfatal_status(struct pci_dev *dev)
> > >   {
> > >   	int aer = dev->aer_cap;
> > >   	u32 status, sev;
> > >   	if (!pcie_aer_is_native(dev))
> > > -		return -EIO;
> > > +		return;
> > >   	/* Clear status bits for ERR_NONFATAL errors only */
> > >   	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, &status);
> > > @@ -265,10 +265,7 @@ int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
> > >   	status &= ~sev;
> > >   	if (status)
> > >   		pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, status);
> > > -
> > > -	return 0;
> > >   }
> > > -EXPORT_SYMBOL_GPL(pci_aer_clear_nonfatal_status);
> > >   void pci_aer_clear_fatal_status(struct pci_dev *dev)
> > >   {
> > > @@ -286,6 +283,22 @@ void pci_aer_clear_fatal_status(struct pci_dev *dev)
> > >   		pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, status);
> > >   }
> > > +int pci_aer_clear_uncorrect_error_status(struct pci_dev *dev)
> > > +{
> > > +	int aer = dev->aer_cap;
> > > +	u32 status;
> > > +
> > > +	if (!pcie_aer_is_native(dev))
> > > +		return -EIO;
> > > +
> > > +	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, &status);
> > > +	if (status)
> > > +		pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, status);
> > > +
> > > +	return 0;
> > > +}
> > > +EXPORT_SYMBOL_GPL(pci_aer_clear_uncorrect_error_status);
> > > +
> > >   /**
> > >    * pci_aer_raw_clear_status - Clear AER error registers.
> > >    * @dev: the PCI device
> > > diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> > > index 3e9afee02e8d..7942073fbb34 100644
> > > --- a/drivers/pci/pcie/dpc.c
> > > +++ b/drivers/pci/pcie/dpc.c
> > > @@ -288,8 +288,7 @@ void dpc_process_error(struct pci_dev *pdev)
> > >   		 dpc_get_aer_uncorrect_severity(pdev, &info) &&
> > >   		 aer_get_device_error_info(pdev, &info)) {
> > >   		aer_print_error(pdev, &info);
> > > -		pci_aer_clear_nonfatal_status(pdev);
> > > -		pci_aer_clear_fatal_status(pdev);
> > > +		pci_aer_clear_uncorrect_error_status(pdev);
> > >   	}
> > >   }
> > > diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
> > > index 3caaa7c4af48..1ed8d1640325 100644
> > > --- a/drivers/scsi/lpfc/lpfc_attr.c
> > > +++ b/drivers/scsi/lpfc/lpfc_attr.c
> > > @@ -4712,7 +4712,7 @@ static DEVICE_ATTR_RW(lpfc_aer_support);
> > >    * Description:
> > >    * If the @buf contains 1 and the device currently has the AER support
> > >    * enabled, then invokes the kernel AER helper routine
> > > - * pci_aer_clear_nonfatal_status() to clean up the uncorrectable
> > > + * pci_aer_clear_uncorrect_error_status() to clean up the uncorrectable
> > >    * error status register.
> > >    *
> > >    * Notes:
> > > @@ -4738,7 +4738,7 @@ lpfc_aer_cleanup_state(struct device *dev, struct device_attribute *attr,
> > >   		return -EINVAL;
> > >   	if (phba->hba_flag & HBA_AER_ENABLED)
> > > -		rc = pci_aer_clear_nonfatal_status(phba->pcidev);
> > > +		rc = pci_aer_clear_uncorrect_error_status(phba->pcidev);
> > >   	if (rc == 0)
> > >   		return strlen(buf);
> > > diff --git a/include/linux/aer.h b/include/linux/aer.h
> > > index 97f64ba1b34a..f638ad955deb 100644
> > > --- a/include/linux/aer.h
> > > +++ b/include/linux/aer.h
> > > @@ -44,7 +44,7 @@ struct aer_capability_regs {
> > >   /* PCIe port driver needs this function to enable AER */
> > >   int pci_enable_pcie_error_reporting(struct pci_dev *dev);
> > >   int pci_disable_pcie_error_reporting(struct pci_dev *dev);
> > > -int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
> > > +int pci_aer_clear_uncorrect_error_status(struct pci_dev *dev);
> > >   void pci_save_aer_state(struct pci_dev *dev);
> > >   void pci_restore_aer_state(struct pci_dev *dev);
> > >   #else
> > > @@ -56,7 +56,7 @@ static inline int pci_disable_pcie_error_reporting(struct pci_dev *dev)
> > >   {
> > >   	return -EINVAL;
> > >   }
> > > -static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
> > > +static inline int pci_aer_clear_uncorrect_error_status(struct pci_dev *dev)
> > >   {
> > >   	return -EINVAL;
> > >   }
> > > -- 
> > > 2.30.1 (Apple Git-130)
> > > 
> 
> -- 
> Thanks,
> Zhuo Chen
