Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB0F101E1
	for <ntb@lists.linux.dev>; Wed,  6 Sep 2023 15:27:13 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1c22103bce7so23613555ad.1
        for <ntb@lists.linux.dev>; Wed, 06 Sep 2023 08:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694014033; x=1694618833; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/zC3sGldpjzeO9CMTZXERQUoaHDgQlu9tqCa3BrGgAE=;
        b=fXvSKn7qy/sLK9csrzRxqKUJdJm/wxtObedrXRIlOtOGWczZvVcDwU1L35NXsXhhvm
         7dM6ohyNt4o8UECjpiHcofSCjLMx3gv/fS5H9DuCr2sWbvsYcCwT+yG93+QQZw9HwduR
         4P47nJKC3G2nHT2Qj124ySp02o/h4LL5qFtNDXsucfJRYjOoYw4DsGLh8Bfge2k/eG/I
         m8mzX8lc22LKvzarOOKGaOsQyn9DqI13z0tclqSCxeA2iMdPajvpq1FXlGmDOw+3bgdB
         QPW76rA+egJvUlOy8fLZb8mCNWOrjnkO6P21laNpsLvYjL9Q62jAXi0X7PQDC/fhjYJs
         O8mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694014033; x=1694618833;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/zC3sGldpjzeO9CMTZXERQUoaHDgQlu9tqCa3BrGgAE=;
        b=aLxKc1V6wgQwgrjFZgDY5/vVsjSyEiaN1I6BerLwF1lAz5ePoioxtVwb6E+j4idp8D
         VAdtuiPo0Vm3cIxQusI+PWQtz4Dy2wa8dI1tS0vXKU0yQqQEIZH6Gk8bAXTMJjPfnOpR
         ACFhyzox3qn9RUrePxyigD18f0y2gPgq89d2SjtXmiS7jn6lI4ywIIflZV9c9v3/JGv7
         VZwUOSxggKAMmMosvkpBOGL1WMFfTwKxXzsYmru/W8TS6n5Fd1uTH/o5EIv+RExeQTdA
         j39XjpXLvQ8dgNpDtMpilHD94mefFpbtXVGX+ds7VwvgulBd4OgdYP/AY41zJ98ACPV+
         WTrg==
X-Gm-Message-State: AOJu0YweKzxLol7b46dqDf8HrjL4ITZCjKzBfQPW33IzpD4JaNFzDwYy
	iN/nE6tfTuBgabeD5wgMK0Cj
X-Google-Smtp-Source: AGHT+IG3+CorsfPvIhXCthxDyrsclXr1JANLccL0UeFE1jZA2vIkElTgbVbw6jVva0tUGoKzfeesBA==
X-Received: by 2002:a17:903:4296:b0:1bd:ca21:c85 with SMTP id ju22-20020a170903429600b001bdca210c85mr12134409plb.69.1694014033186;
        Wed, 06 Sep 2023 08:27:13 -0700 (PDT)
Received: from thinkpad ([120.138.12.139])
        by smtp.gmail.com with ESMTPSA id 19-20020a170902ee5300b001bb99ea5d02sm11265261plo.4.2023.09.06.08.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 08:27:12 -0700 (PDT)
Date: Wed, 6 Sep 2023 20:57:04 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.li@nxp.com>
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
Message-ID: <20230906152704.GD5930@thinkpad>
References: <20230426203436.1277307-1-Frank.Li@nxp.com>
 <20230426203436.1277307-2-Frank.Li@nxp.com>
 <20230902045214.GA2913@thinkpad>
 <20230902045328.GB2913@thinkpad>
 <ZPf/EkffMC51iLQ/@lizhi-Precision-Tower-5810>
 <20230906122605.GB5930@thinkpad>
 <ZPiNwQg3rDQMRA/6@lizhi-Precision-Tower-5810>
 <20230906145227.GC5930@thinkpad>
 <ZPiT/LJGpNbCRDZk@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZPiT/LJGpNbCRDZk@lizhi-Precision-Tower-5810>

On Wed, Sep 06, 2023 at 11:00:12AM -0400, Frank Li wrote:
> On Wed, Sep 06, 2023 at 08:22:27PM +0530, Manivannan Sadhasivam wrote:
> > > > 
> > > > Can't you assign it in the EPF driver itself? I do not want any OF reference in
> > > > the EPF core since it has no OF support.
> > > 
> > > If that, Each EPF driver need do duplicate work. 
> > > 
> > 
> > Yes, and that's how it should be. EPF core has no job in supplying the of_node.
> > It is the responsibility of the EPF drivers as they depend on OF for platform
> > support.
> 
> EPF driver still not depend on OF. such pci-epf-test, which was probed by
> configfs.
> 

Hmm, yeah. Then it should be part of the EPC driver.

Sorry for the confusion.

- Mani

> Frank 
> 
> > 
> > - Mani
> > 
> > > IMS will support per-device MSI domain, then we can implement customized
> > > MSI irq allocated. But so far, it is simplest solution, we can update it
> > > after IMS implementation at kernel. Only one place need be changed.
> > > 
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்
