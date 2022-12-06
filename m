Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4611568A
	for <ntb@lists.linux.dev>; Tue,  6 Dec 2022 21:41:08 +0000 (UTC)
Received: by mail-lj1-f171.google.com with SMTP id f20so5584533lja.4
        for <ntb@lists.linux.dev>; Tue, 06 Dec 2022 13:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ETysj4Bx8/q3Mbby4ydbR9t3cYQklYxkUNimuU0Mtik=;
        b=kBew9e0ZjRuvMB6VMb6kJBucF/HeULbCyoA3DL9XiESyqyRis4mPc4mvYcnZkEZFZU
         03oVFUEBQ+QQKKXg7zgfoxKrMva+9sSg/TpIShFlImKlenLRqVW+r6S5TSSJAbfzwIGB
         odE1wyD0V6XOo/JBdWREdcoYE9MlkuEZiwCQCKomLsB+mCsnWcLMig2jBGWYlSyTEJZx
         mpJXKTpYVFEhW7f8/TzOFmKUG4vlf3TRRFGOtYlIJYG8gggFPtVuh0IjaUQ7JPILI7SW
         /drTqQkoEs6yCtVPz2EVqJAru5ZRDcsIkQORJrNFzVP+/p2ewwZ+INGS78sQVFJfS2hH
         +pTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ETysj4Bx8/q3Mbby4ydbR9t3cYQklYxkUNimuU0Mtik=;
        b=WeKbybIZLhxM0XqRqbVfQQmB5W4t8EPsdL4W716m5dhW+zji7NKiQZlCUgiuA1EUHJ
         /DImmX3rU6fg/Kj+KyUk8nLxe21F5ju0zlelmvW1CZqX1IrPgSML2f7BWR84Hvhd84Cf
         IooMoJ6mBkACoLKPRFP1jlGlf1pQSFGJWoxoLbybQmtn5FAgq/3BI40ndEmd3bInFZ4I
         KK9ZNFipKdZ18NS0QkH/ZXaYoe5Wh5+YHIQkJUcphiwjUFJycrYbgvGkOwVq8cgkNFVV
         pl2G2hwj7FfoOTQrG2NcunsbgAXGHCRek7ZBpnAVTZtfQWaupLQvTNyMIhU/1WCFuc+0
         Gd8g==
X-Gm-Message-State: ANoB5pmGQNHa0KXaI7vvPeQPSUxctY7hiAswEbaBo18IiT7NJ7TfmjhY
	Xdt+bt6EprP18aytEqn66Rc=
X-Google-Smtp-Source: AA0mqf5lMZpEEacm4jO7QvN9SHNS5JS0rsnvTbY0LagzI/PlE2+ZIKHl43uMxZisCfadNoKGaNMuBA==
X-Received: by 2002:a2e:9941:0:b0:26d:fe34:6dc0 with SMTP id r1-20020a2e9941000000b0026dfe346dc0mr24018640ljj.477.1670362866932;
        Tue, 06 Dec 2022 13:41:06 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id a2-20020a19ca02000000b004946a1e045fsm2594803lfg.197.2022.12.06.13.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 13:41:06 -0800 (PST)
Date: Wed, 7 Dec 2022 00:41:03 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Zhuo Chen <chenzhuo.1@bytedance.com>,
	sathyanarayanan.kuppuswamy@linux.intel.com, bhelgaas@google.com,
	ruscur@russell.cc, oohall@gmail.com, jdmason@kudzu.us,
	dave.jiang@intel.com, allenbh@gmail.com, james.smart@broadcom.com,
	dick.kennedy@broadcom.com, jejb@linux.ibm.com,
	martin.petersen@oracle.com, linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev, linux-scsi@vger.kernel.org
Subject: Re: [PATCH v3 3/9] NTB: Remove pci_aer_clear_nonfatal_status() call
Message-ID: <20221206214103.77duscgqjifsktxo@mobilestation>
References: <20220928110355.emf2nucmdmpb3vbu@mobilestation>
 <20221206180956.GA1361309@bhelgaas>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206180956.GA1361309@bhelgaas>

Hi Bjorn

On Tue, Dec 06, 2022 at 12:09:56PM -0600, Bjorn Helgaas wrote:
> On Wed, Sep 28, 2022 at 02:03:55PM +0300, Serge Semin wrote:
> > On Wed, Sep 28, 2022 at 06:59:40PM +0800, Zhuo Chen wrote:
> > > There is no need to clear error status during init code, so remove it.
> > 
> > Why do you think there isn't? Justify in more details.
> 
> Thanks for taking a look, Sergey!  I agree we should leave it or add
> the rationale here.
> 
> > > Signed-off-by: Zhuo Chen <chenzhuo.1@bytedance.com>
> > > ---
> > >  drivers/ntb/hw/idt/ntb_hw_idt.c | 2 --
> > >  1 file changed, 2 deletions(-)
> > > 
> > > diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
> > > index 0ed6f809ff2e..fed03217289d 100644
> > > --- a/drivers/ntb/hw/idt/ntb_hw_idt.c
> > > +++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
> > > @@ -2657,8 +2657,6 @@ static int idt_init_pci(struct idt_ntb_dev *ndev)
> > >  	ret = pci_enable_pcie_error_reporting(pdev);
> > >  	if (ret != 0)
> > >  		dev_warn(&pdev->dev, "PCIe AER capability disabled\n");
> > > -	else /* Cleanup nonfatal error status before getting to init */
> > > -		pci_aer_clear_nonfatal_status(pdev);
> 
> I do think drivers should not need to clear errors; I think the PCI
> core should be responsible for that.
> 
> And I think the core *does* do that in this path:
> 
>   pci_init_capabilities
>     pci_aer_init
>       pci_aer_clear_status
>         pci_aer_raw_clear_status
>           pci_write_config_dword(pdev, aer + PCI_ERR_COR_STATUS)
>           pci_write_config_dword(pdev, aer + PCI_ERR_UNCOR_STATUS)
> 
> pci_aer_clear_nonfatal_status() clears only non-fatal uncorrectable
> errors, while pci_aer_init() clears all correctable and all
> uncorrectable errors, so the PCI core is already doing more than
> idt_init_pci() does.
> 
> So I think this change is good because it removes some work from the
> driver, but let me know if you think otherwise.

It's hard to remember now all the details but IIRC back when this
driver was developed the "Unsupported Request" flag was left uncleared
on our platform even after the probe completion. Most likely an
erroneous TLP was generated by some action performed on the device
probe stage. The forced cleanup of the AER status solved that problem.
On the other hand the problem of having the UnsupReq+ flag set was
solved some time after the driver was merged in into the kernel (it
was caused by a vendor-specific behavior of the IDT PCIe switch placed
on the path between a RP and PCIe NTB). So since the original reason
of having the pci_aer_clear_nonfatal_status() method called here was
platform specific and fixed now anyway, and the AER flags cleanup is
done by the core, then I have no reason to be against the patch. It
would be good to add your clarification to the commit message though.

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> 
> > >  
> > >  	/* First enable the PCI device */
> > >  	ret = pcim_enable_device(pdev);
> > > -- 
> > > 2.30.1 (Apple Git-130)
> > > 
