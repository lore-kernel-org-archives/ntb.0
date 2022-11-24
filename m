Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDD72F24
	for <ntb@lists.linux.dev>; Thu, 24 Nov 2022 18:51:27 +0000 (UTC)
Received: by mail-pg1-f174.google.com with SMTP id 136so2181923pga.1
        for <ntb@lists.linux.dev>; Thu, 24 Nov 2022 10:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=49vt8EOGEXyKlWmjHihd7x+0GUdoUKIBLN5kNZgkz9U=;
        b=MbMi6hWIIWqSrAk3qQ8LSanE4ykJAz414UwmVajhU8nBrQBl2OPkQplVShDqJQ9QaT
         5vrQvCmOimLDatwKMApPC+ovCvE/DkAjVuczMYuRfCdxLNPnA9RCDg+qlnFQjlkj15BE
         Y6VTKBDTMVjDnWT4kBoRp9DdzYXkGEtJZvLrGVpNcKg4ZmGjQLM47OoUuTa3tZ919kYa
         oyURkh6QpYY2aBmA87D1V+/2ns64G40tt5OXXfCAMi5M/i+ClfJKimpyXXkZPrw95IKn
         TAqUFXpuDx74IPzpzP2pH2DiigUBB2lgsN2BEGnCwFyIi0ddPE1pDT8o6eHY9BpEVYx6
         9lqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=49vt8EOGEXyKlWmjHihd7x+0GUdoUKIBLN5kNZgkz9U=;
        b=ZQloJdC7qsQDWZYUve4ytgBXUnppQiT+cQIb1gtOAxcStowdDAEPcr4nBKCJjRCwyz
         2lohotK40weGbvs0VSxnleVJBhKj7H69NUenUUg2B+2cYZ4f1CKYWEv169ip10XZfhvz
         Z7aM2qeH/22bE34QKnFZMSCtkLl+/qrXiPbOU6oz5kvqqAhIO4pkzY2lqEmZcZ11EwCo
         t4jWk/pkAo82nPsxpp2VFxSyGqbipXuF1Mnoqi0Yhoow4YhrE7wixe9ieIEMLOSN06Ar
         oGMY80Hq7BM7zxMelCxy75ILEh9vz4OwfMJ5FlbSsu4uD3rDgKbHVrbuzQXbayZaoKQC
         x0Hw==
X-Gm-Message-State: ANoB5pmoX0pgKeFxkXCxfQsxUUIDGaI70JV1Vmh+wgQobVbZZzNLR8ow
	Qwj1uMaJ4X6Njbp8Zn42fj8P
X-Google-Smtp-Source: AA0mqf4messfpfYWh8G5GYTBO1vIksvYAOsoSXbQAjjrDxPWSheB+CIa3aacmlr3ZBQYzlMoVw4mpw==
X-Received: by 2002:a63:117:0:b0:476:f43d:913e with SMTP id 23-20020a630117000000b00476f43d913emr13525641pgb.386.1669315886787;
        Thu, 24 Nov 2022 10:51:26 -0800 (PST)
Received: from thinkpad ([117.202.190.212])
        by smtp.gmail.com with ESMTPSA id e4-20020a170902784400b00186a6b6350esm1610852pln.268.2022.11.24.10.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 10:51:25 -0800 (PST)
Date: Fri, 25 Nov 2022 00:21:16 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <frank.li@nxp.com>
Cc: "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	Aisheng Dong <aisheng.dong@nxp.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"jdmason@kudzu.us" <jdmason@kudzu.us>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"kw@linux.com" <kw@linux.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	dl-linux-imx <linux-imx@nxp.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
	"lznuaa@gmail.com" <lznuaa@gmail.com>,
	"maz@kernel.org" <maz@kernel.org>,
	"ntb@lists.linux.dev" <ntb@lists.linux.dev>,
	Peng Fan <peng.fan@nxp.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, kishon@kernel.org
Subject: Re: [EXT] Re: [PATCH v13 1/2] PCI: endpoint: pci-epf-vntb: change
 doorbell register offset calc mathod
Message-ID: <20221124185116.GG5119@thinkpad>
References: <20221124055036.1630573-1-Frank.Li@nxp.com>
 <20221124055036.1630573-2-Frank.Li@nxp.com>
 <20221124091921.GD5119@thinkpad>
 <HE1PR0401MB233169E8D223BC8809BB3DB8880F9@HE1PR0401MB2331.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <HE1PR0401MB233169E8D223BC8809BB3DB8880F9@HE1PR0401MB2331.eurprd04.prod.outlook.com>

On Thu, Nov 24, 2022 at 05:49:32PM +0000, Frank Li wrote:
> 
> 
> > -----Original Message-----
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Sent: Thursday, November 24, 2022 3:19 AM
> > To: Frank Li <frank.li@nxp.com>
> > Cc: lpieralisi@kernel.org; Aisheng Dong <aisheng.dong@nxp.com>;
> > bhelgaas@google.com; devicetree@vger.kernel.org; festevam@gmail.com;
> > imx@lists.linux.dev; jdmason@kudzu.us; kernel@pengutronix.de;
> > kishon@ti.com; krzysztof.kozlowski+dt@linaro.org; kw@linux.com; linux-
> > arm-kernel@lists.infradead.org; dl-linux-imx <linux-imx@nxp.com>; linux-
> > kernel@vger.kernel.org; linux-pci@vger.kernel.org;
> > lorenzo.pieralisi@arm.com; lznuaa@gmail.com; maz@kernel.org;
> > ntb@lists.linux.dev; Peng Fan <peng.fan@nxp.com>; robh+dt@kernel.org;
> > s.hauer@pengutronix.de; shawnguo@kernel.org; tglx@linutronix.de
> > Subject: [EXT] Re: [PATCH v13 1/2] PCI: endpoint: pci-epf-vntb: change
> > doorbell register offset calc mathod
> > 
> > Caution: EXT Email
> > 
> > On Thu, Nov 24, 2022 at 12:50:35AM -0500, Frank Li wrote:
> > > In drivers/ntb/hw/epf/ntb_hw_epf.c
> > > ntb_epf_peer_db_set()
> > > {
> > >    ...
> > >    db_offset = readl(ndev->ctrl_reg + NTB_EPF_DB_OFFSET(interrupt_num));
> > >    writel(db_data, ndev->db_reg + (db_entry_size * interrupt_num) +
> > >                db_offset);
> > >    ...
> > > }
> > >
> > > The door register offset's formular is
> > >       offset = db_entry_size * interrupt_num + db_offset[interrupt_number]
> > 
> > You did not mention the DB BAR here. Without that, this calculation doesn't
> > make sense.
> 
> Doorbell register offset should means Base on DB BAR. 
> How about "The formula of  door register offset refer to DB BAR"?

"Doobell register offset in DB BAR is calculated using:"

> 
> > 
> > >
> > > Previous db_entry_size is 4, all db_offset is 0.
> > 
> > s/Previous/Previously
> > 
> > >       irq | offset
> > >        --------------
> > >          0     0
> > >          1     4
> > >          2     8
> > >         ...
> > >
> > > Change to db_entry_size is 0 and db_offset is 0, 4, 8, ...
> > > So we can get the same map value between irq and offset. This will be
> > > convenience for hardware doorbell register memory map.
> > >
> > 
> > In your irq-imx-mu-msi.c driver, the msi_address is calculated as:
> > 
> > ```
> > u64 addr = msi_data->msiir_addr + 4 * data->hwirq;
> > ```
> > 
> > So the MSI addresses itself are of 4 bytes width. So the offsets will be
> > separated by 8 bytes like, 0, 8, 16,... and this won't match the MSI addresses
> > as they are 4 bytes apart.
> 
> Addr is absolute physical IO address, which increased by 4. But it doesn't matter.
> It should be okay if range is between 2^32.
> 
> > 
> > So you want to change the offset to 0, 4, 8,... by zeroing db_entry_size,
> > right?
> 
> I want to directly using db_offset[irq] value as offset. It will be simple. 
> 
> I am not sure why ntb_hw_epf.c use below formular.   
>  "Db_offset[irq] + irq * db_entry_size"
> 
> Db_entry_size = 0 will be simple,  all offset will be controlled by db_offset[]
> 
> You can save db_offset[] as 0, 4, 8... or 0, 8, 16 as needs.
> 
> > 
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > index 04698e7995a5..0d744975f815 100644
> > > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > @@ -461,11 +461,11 @@ static int epf_ntb_config_spad_bar_alloc(struct
> > epf_ntb *ntb)
> > >       ctrl->num_mws = ntb->num_mws;
> > >       ntb->spad_size = spad_size;
> > >
> > > -     ctrl->db_entry_size = sizeof(u32);
> > > +     ctrl->db_entry_size = 0;
> > >
> > >       for (i = 0; i < ntb->db_count; i++) {
> > >               ntb->reg->db_data[i] = 1 + i;
> > > -             ntb->reg->db_offset[i] = 0;
> > > +             ntb->reg->db_offset[i] = sizeof(u32) * i;
> > 
> > If my above understanding is correct, then you could just reassign
> > "db_entry_size" in epf_ntb_epc_msi_init().
> 
> Yes, that's one method.
> I want to use one method to calc db offset for both software polling
> and MSI.  So overall logic should be simple. 
> 

I think it is better to leave db_entry_size for polling as it is and modify it
for MSI alone.

Thanks,
Mani

> Frank Li
> 
> > 
> > Thanks,
> > Mani
> > 
> > >       }
> > >
> > >       return 0;
> > > --
> > > 2.34.1
> > >
> > 
> > --
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்
