Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992E915A7
	for <ntb@lists.linux.dev>; Thu, 18 Aug 2022 14:51:21 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id t2-20020a17090a4e4200b001f21572f3a4so2100317pjl.0
        for <ntb@lists.linux.dev>; Thu, 18 Aug 2022 07:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=H3yJk4PjKkBxO8MRF86o/UlGTS85Oaz5bi8fjVWZxdE=;
        b=Q1DNKTUtywOuoRfaMNyy6UGWNldEb34WlkUV8aAKz1xdXCnyjlt5Tenc5AtIH6UKMX
         GocNvWqde2bD6Jbm6lIypLmG3eLP1NxoatsEbFg/6Pf4+H7Cg7iqmm2OaEJAvovArann
         EfxSRCVnJgumR/P5gsdTGPUEX8D2sihbIh7JW5GnhZ7ZatPSjFuXGnKiHTLkjXiikRvM
         oJ9u2Y2qyag6oUJSJ9RyWtg5zK3UllxyapNF7Xz9W5CILu8ySdDlD9bMSLjL+UcG5Rz0
         VKlKIPhRutN3mKIRkLaKXLWgQvQ2Hl19Xe7tU2iiWxtNWvOjo33Rp9bNXbPi4PxL3M0b
         4PRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=H3yJk4PjKkBxO8MRF86o/UlGTS85Oaz5bi8fjVWZxdE=;
        b=FFo+KKlX8M6g/3PIbHdW+YP6LdflCZc03xTDmbW3Ami054st6GIEdlT31wsgZqDKdQ
         1x3D9rjImEaYq10r9ZVpmiflCuKeC3nmnvp0s8eZmHoBQ1JlGkSioK8GWOngThXVpzZ4
         NeZ3A3O8FJvRwVoZRyAYLb6KTKxvHUGIobybzjhiUBSUaiijtG9sdzlU0dhgh3dbJjk1
         j/nkk35NfgcOjkB45yYCIRPJ87jvDcm9JcDuMqBBdu9Qsxa1VYJs6nxr+z621yFfQXFC
         5JKV/Rga2nCgDARakozKHoLX15NCms1EVP0OvKN0qXlqP3c20FYf+HrDB7YURK2HhS44
         /UMw==
X-Gm-Message-State: ACgBeo0jp2pRGaQkBI+Wz6RMQRtcMgwun4XDU4/q3qryoOUoPWjjUOWK
	CEZ0vzgovfVzQIBcp8vlHLsw
X-Google-Smtp-Source: AA6agR742S8qUdw4UOT5bgN9ccpaznpYVuKYyj7Y8U9VluswWT+M4wSobtQ/yZnh5qE1vEiqMCJfcg==
X-Received: by 2002:a17:902:7c01:b0:16f:9649:be73 with SMTP id x1-20020a1709027c0100b0016f9649be73mr2899152pll.70.1660834280859;
        Thu, 18 Aug 2022 07:51:20 -0700 (PDT)
Received: from thinkpad ([117.193.212.74])
        by smtp.gmail.com with ESMTPSA id i6-20020a17090a3d8600b001f262f6f717sm3697123pjc.3.2022.08.18.07.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 07:51:20 -0700 (PDT)
Date: Thu, 18 Aug 2022 20:21:15 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Jon Mason <jdmason@kudzu.us>
Cc: ntb@lists.linux.dev, Bjorn Helgaas <helgaas@kernel.org>,
	Frank.Li@nxp.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, kishon@ti.com
Subject: Re: [PATCH] MAINTAINERS: add PCI Endpoint NTB drivers to NTB files
Message-ID: <20220818145115.GA111116@thinkpad>
References: <20220812194205.388967-1-jdmason@kudzu.us>
 <20220818060230.GA12008@thinkpad>
 <Yv5EA8uuhwn049jx@kudzu.us>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yv5EA8uuhwn049jx@kudzu.us>

On Thu, Aug 18, 2022 at 09:52:03AM -0400, Jon Mason wrote:
> On Thu, Aug 18, 2022 at 11:32:30AM +0530, Manivannan Sadhasivam wrote:
> > + Kishon (PCI EP Maintainer)
> > 
> > On Fri, Aug 12, 2022 at 03:42:05PM -0400, Jon Mason wrote:
> > > The PCI Endpoint NTB drivers are under the NTB umbrella.  Add an entry
> > > there to allow for notification of changes for it.
> > > 
> > > Signed-off-by: Jon Mason <jdmason@kudzu.us>
> > 
> > Hi Jason,
> 
> I assume you mean me.  Odd that you got my name wrong 2 lines below it
> being properly written out.
> 

Terribly sorry about that! I was reading another thread just before this
and misspelled your name.

> > I know that this patch is already in Linus's tree but I think this PCI Endpoint
> > VNTB driver is not going in a correct path. First, Kishon is not convinced with
> > the way the PCI Endpoint VNTB function driver is written currently. He prefers
> > the VirtIO approach over the current one [1].
> 
> To your point, this is already in Linus' tree.  If it is not the way
> people want it, patches accepted.
> 
> Kishon (in the thread) recommended doing it one way, and Frank
> responded he liked doing it another.  Kishon didn't respond to that
> last email.  To me, this is an acceptable technical disagreement that
> can be addressed in the future and no need to prevent working patches
> from being accepted.
> 

Kishon being the maintainer proposed an entirely different way of representing
the driver. I agree that the patch is working but maintainer's view matters and
if you don't hear from the maintainer for some time, you'll ping them (Frank
did ping but there is something called RESEND).

I'm not sure that merging the patches without an ACK from the relevant subsystem
maintainer is the right thing to do.

> > But while the conversation was still going on, the series got merged via NTB
> > tree without any ACKs from the PCI/PCI_EP maintainers. Also, note that there
> > was a patch touching the PCI Controller driver as well and that was also not
> > ACKed [2].
> 
> I put the series in my ntb-next branch, which was pulled into linux-next
> for roughly 3 months, and he did not object then (though likely he did
> not notice).  Multiple patches were submitted to the relevant mailing
> lists to address minor issues in the series (from being in linux-next)
> and most/all of those hit the PCI mailing list.  Bjorn responded to
> all of them saying they needed to go through the ntb tree (because of
> the dependency on Frank Li's original series).  So while not an
> explicit ack, it was implicit to me in that he was aware of the
> series.
> 
> Given the length of time and the public work on the series, how much
> longer should I have waited for a nack?
> 

I'd argue that you should've waited for the ACK first. I've seen and
experienced patch series hanging there for multiple releases. I'm not in favour
of not responding to the patches, maintainers do have their own work to do but
merging the patches touching the different subsystem without an ACK doesn't
sound good to me.

I don't know why he didn't object when the series got merged in this manner :/

> > If this trend is going to continue in the coming days, then I'm afraid that NTB
> > might end up being a backdoor for PCI/PCI_EP patches :(
> 
> Completely unfounded, per Bjorn's comment on
> https://lore.kernel.org/all/20220815183920.GA1960006@bhelgaas/
> 

It's now fine that NTB related PCI patches can be merged through NTB tree but
please wait for an ACK for patches touching the non-NTB drivers. If you ask me
how long you should wait, then I don't have an answer, but atleast give a
notice before doing so that it can catch the proper eyes.

Thanks,
Mani

> Thanks,
> Jon
> 
> > 
> > Thanks,
> > Mani
> > 
> > [1] https://lore.kernel.org/all/20220222162355.32369-4-Frank.Li@nxp.com
> > [2] https://lore.kernel.org/all/20220222162355.32369-2-Frank.Li@nxp.com
> > 
> > > ---
> > >  MAINTAINERS | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 64379c699903..47e9f86bd712 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -14254,6 +14254,7 @@ W:	https://github.com/jonmason/ntb/wiki
> > >  T:	git git://github.com/jonmason/ntb.git
> > >  F:	drivers/net/ntb_netdev.c
> > >  F:	drivers/ntb/
> > > +F:	drivers/pci/endpoint/functions/pci-epf-*ntb.c
> > >  F:	include/linux/ntb.h
> > >  F:	include/linux/ntb_transport.h
> > >  F:	tools/testing/selftests/ntb/
> > > -- 
> > > 2.30.2
> > > 
> > 
> > -- 
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்
