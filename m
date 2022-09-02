Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0337E
	for <ntb@lists.linux.dev>; Fri,  2 Sep 2022 16:35:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C6EC43142
	for <ntb@lists.linux.dev>; Fri,  2 Sep 2022 16:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1662136539;
	bh=CyXZslGC6xMHuFvaJ2y8P9mcnKdxUher6ZDcEysyZM4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=inHkQYqQd1Ylei3Vn2o0zDzCCdpJmBllYZqgx68F0KRYC5ul6UDxGh8YL0SPmdepT
	 4G+uxFTXEf2tk85OGXqEdFHSoDi7t4Mmb/pj3TQGwBtt3TkObWNZ5dhFRFnrSe0bt0
	 KMhVBrb59aMHbzGTfrU598mUFdLmIg7/ld97347efEMtMmumS2bqdQYYZ5sAa/aXvz
	 nFt2pFp2zeQE73RiGGfSujrRIVBebk9xUcQieOaFsTeI1OyrfSXEAe46DZ8g+B/afW
	 AY1adak0OO0Fuwu8WDVvdV7PxfXhgWUav/bF7VwngeIt3unuWmwOu1I57933qRH0tO
	 8MxOseUWXJ9vg==
Received: by mail-vk1-f177.google.com with SMTP id i129so1232742vke.3
        for <ntb@lists.linux.dev>; Fri, 02 Sep 2022 09:35:39 -0700 (PDT)
X-Gm-Message-State: ACgBeo1oYu/7j7nAN1U6Eu4vBFialr4x7JV3nrCFsppxNP/zj1PSUd+T
	aQ+7dH5MyS3wc1JlKge/AsSTU570yzHaMLpiBg==
X-Google-Smtp-Source: AA6agR7dwq63N6NQLKD/7IAKcnFBWx79Ln0WNBprwZv5blc/HPzGPu7Vyie82utDNhAe8IsODz3wLIsUaG4BPhD83bI=
X-Received: by 2002:a1f:d241:0:b0:398:3e25:d2dd with SMTP id
 j62-20020a1fd241000000b003983e25d2ddmr1223vkg.15.1662136538025; Fri, 02 Sep
 2022 09:35:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220822155130.2491006-1-Frank.Li@nxp.com> <20220822155130.2491006-4-Frank.Li@nxp.com>
 <20220825212130.GA1705214-robh@kernel.org> <PAXPR04MB9186201A03037BA7DC74D52B88729@PAXPR04MB9186.eurprd04.prod.outlook.com>
 <871qt2x38f.wl-maz@kernel.org> <PAXPR04MB918607281F6389092924EE6488759@PAXPR04MB9186.eurprd04.prod.outlook.com>
 <87zgfqvfvv.wl-maz@kernel.org>
In-Reply-To: <87zgfqvfvv.wl-maz@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Fri, 2 Sep 2022 11:35:26 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+3hSni_b4mCMrAVHiV2d5u=0zithZFK1mKT4d3GAag_A@mail.gmail.com>
Message-ID: <CAL_Jsq+3hSni_b4mCMrAVHiV2d5u=0zithZFK1mKT4d3GAag_A@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v7 3/4] dt-bindings: irqchip: imx mu work as msi controller
To: Marc Zyngier <maz@kernel.org>
Cc: Frank Li <frank.li@nxp.com>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>, 
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, 
	"kw@linux.com" <kw@linux.com>, "bhelgaas@google.com" <bhelgaas@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Peng Fan <peng.fan@nxp.com>, 
	Aisheng Dong <aisheng.dong@nxp.com>, "jdmason@kudzu.us" <jdmason@kudzu.us>, 
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, 
	dl-linux-imx <linux-imx@nxp.com>, "kishon@ti.com" <kishon@ti.com>, 
	"lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>, "ntb@lists.linux.dev" <ntb@lists.linux.dev>, 
	"lznuaa@gmail.com" <lznuaa@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, Aug 26, 2022 at 4:44 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Fri, 26 Aug 2022 19:59:44 +0100,
> Frank Li <frank.li@nxp.com> wrote:
> >
> > > And I stand by my initial request. "a" doesn't convey any sort of
> > > useful information. Why not "I" and "II", while we're at it? Or
> > > something even funkier?
> >
> > MU spec use term "a" and "b",  user have to map "I" an "II" to
> > "a" and "b" when read MU spec and code. it is not straightforward.
> >
> > I quote a part of spec.
> > " The MU is connected as a peripheral under the Peripheral bus on both sides-on
> > the Processor A-side, the Processor A Peripheral Bus, and on the Processor B side,
> > the Processor B Peripheral Bus."
> >
> > Rob Herring and Marc Zynginer:
> > I can change to any name, which you agree both.
> >
> > Some options:
> > 1. "a", "b"
> > 2. "a-side", "b-side"
> > 3. "a-facing", "b-facing"
> > 4. "I", "II"
>
> Use the wording indicated in the spec: "processor-a-side", and
> "processor-b-side". This is what I asked the first place.

I would pick 2 (or nothing), but whatever... As long as there aren't spaces.

Rob
