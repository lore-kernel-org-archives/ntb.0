Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36CC440F
	for <ntb@lists.linux.dev>; Thu, 18 Aug 2022 13:52:06 +0000 (UTC)
Received: by mail-qt1-f181.google.com with SMTP id h4so1108205qtj.11
        for <ntb@lists.linux.dev>; Thu, 18 Aug 2022 06:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=a7uF+75/Wt7aRoPYiTPJg2bxJUKJNIPU7dSBbvja52Q=;
        b=Jp2T7PgF+OjA7rDoP9sdAq+Y4UvHBUu+SEvm9qEUBLvmKBYelmQR4HyHPC+tI8uvSa
         5gaN9drDrn5mr7s9EQIF5+D1Inn/9cBVy5BFgQ+cBA843tVibjAxL6AfcEN6wYqNfsdr
         kst5COZwNTE9QroSfP94YA1E6soPjlDlXOhcc8+KzuHc2n3U501Lb667PnorZ2hximm2
         MNyCRive4iFTWtg1VfGarxCJrXAuDHdkzS2gsUH4sHoSchT8kjopaPd3QUPa0dfFgP3f
         7I1So/3l+68lI5JQ2+PP4tzKkhTCV7hWxKeC/G1xECgTT2XSvAJD13v42VRZhgqA+aRi
         cg8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=a7uF+75/Wt7aRoPYiTPJg2bxJUKJNIPU7dSBbvja52Q=;
        b=M6uTJE6jA1mO2Bs3ic5cpwemekgliaHjGfVAkP7wvCu/66IsqejaCwsBQTohpN0EF3
         7/tXJpjqy85Ohq11LUNqfNEiI8OA2vVEDK8O627mE0UbyldsvoukHa/biARvcLB09tj5
         l08OzpV9XILm3r6dli9XmOA0PdjCEIVtXz6HIhDZBdgrIkLY8YkuU8vbAkDSwIQZxFlZ
         R7gfwdWI6u2Qa1ZgjKczBk2NS7gkP4NKNfqu26cqwCe/Najq7OwWGYhKqUIFvrFiAWia
         P0APgeMT4X5ujO4+LEAOPUn+lYdmgOpY0HVp5Z1w+mg7XNKsB7WhTVjYuX5OrA7T9s8P
         37ew==
X-Gm-Message-State: ACgBeo3aUrpSTBnk7UNlJEFotUW6wMJYfd4ywgdGPp+hqfYnOP/uottZ
	nXN1n4Q72DfMaw8FcmZbugPZzA==
X-Google-Smtp-Source: AA6agR5dqBya97ZDwddbePvoc+pRWag8YyuXbA+dXO45tDdm7P7a5zRrAhhuzvoNCePELcz+ttXUaA==
X-Received: by 2002:ac8:5a01:0:b0:344:6aef:9a8d with SMTP id n1-20020ac85a01000000b003446aef9a8dmr2655532qta.131.1660830725566;
        Thu, 18 Aug 2022 06:52:05 -0700 (PDT)
Received: from kudzu.us ([2605:a601:a608:5600::59])
        by smtp.gmail.com with ESMTPSA id y7-20020a05620a09c700b006b93b61bc74sm1503793qky.9.2022.08.18.06.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 06:52:05 -0700 (PDT)
Date: Thu, 18 Aug 2022 09:52:03 -0400
From: Jon Mason <jdmason@kudzu.us>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: ntb@lists.linux.dev, Bjorn Helgaas <helgaas@kernel.org>,
	Frank.Li@nxp.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, kishon@ti.com
Subject: Re: [PATCH] MAINTAINERS: add PCI Endpoint NTB drivers to NTB files
Message-ID: <Yv5EA8uuhwn049jx@kudzu.us>
References: <20220812194205.388967-1-jdmason@kudzu.us>
 <20220818060230.GA12008@thinkpad>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220818060230.GA12008@thinkpad>

On Thu, Aug 18, 2022 at 11:32:30AM +0530, Manivannan Sadhasivam wrote:
> + Kishon (PCI EP Maintainer)
> 
> On Fri, Aug 12, 2022 at 03:42:05PM -0400, Jon Mason wrote:
> > The PCI Endpoint NTB drivers are under the NTB umbrella.  Add an entry
> > there to allow for notification of changes for it.
> > 
> > Signed-off-by: Jon Mason <jdmason@kudzu.us>
> 
> Hi Jason,

I assume you mean me.  Odd that you got my name wrong 2 lines below it
being properly written out.

> I know that this patch is already in Linus's tree but I think this PCI Endpoint
> VNTB driver is not going in a correct path. First, Kishon is not convinced with
> the way the PCI Endpoint VNTB function driver is written currently. He prefers
> the VirtIO approach over the current one [1].

To your point, this is already in Linus' tree.  If it is not the way
people want it, patches accepted.

Kishon (in the thread) recommended doing it one way, and Frank
responded he liked doing it another.  Kishon didn't respond to that
last email.  To me, this is an acceptable technical disagreement that
can be addressed in the future and no need to prevent working patches
from being accepted.

> But while the conversation was still going on, the series got merged via NTB
> tree without any ACKs from the PCI/PCI_EP maintainers. Also, note that there
> was a patch touching the PCI Controller driver as well and that was also not
> ACKed [2].

I put the series in my ntb-next branch, which was pulled into linux-next
for roughly 3 months, and he did not object then (though likely he did
not notice).  Multiple patches were submitted to the relevant mailing
lists to address minor issues in the series (from being in linux-next)
and most/all of those hit the PCI mailing list.  Bjorn responded to
all of them saying they needed to go through the ntb tree (because of
the dependency on Frank Li's original series).  So while not an
explicit ack, it was implicit to me in that he was aware of the
series.

Given the length of time and the public work on the series, how much
longer should I have waited for a nack?

> If this trend is going to continue in the coming days, then I'm afraid that NTB
> might end up being a backdoor for PCI/PCI_EP patches :(

Completely unfounded, per Bjorn's comment on
https://lore.kernel.org/all/20220815183920.GA1960006@bhelgaas/

Thanks,
Jon

> 
> Thanks,
> Mani
> 
> [1] https://lore.kernel.org/all/20220222162355.32369-4-Frank.Li@nxp.com
> [2] https://lore.kernel.org/all/20220222162355.32369-2-Frank.Li@nxp.com
> 
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 64379c699903..47e9f86bd712 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -14254,6 +14254,7 @@ W:	https://github.com/jonmason/ntb/wiki
> >  T:	git git://github.com/jonmason/ntb.git
> >  F:	drivers/net/ntb_netdev.c
> >  F:	drivers/ntb/
> > +F:	drivers/pci/endpoint/functions/pci-epf-*ntb.c
> >  F:	include/linux/ntb.h
> >  F:	include/linux/ntb_transport.h
> >  F:	tools/testing/selftests/ntb/
> > -- 
> > 2.30.2
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்
