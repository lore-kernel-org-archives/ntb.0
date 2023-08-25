Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFB417FA;
	Fri, 25 Aug 2023 08:34:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E9DC433C8;
	Fri, 25 Aug 2023 08:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692952475;
	bh=FCtRh2nslorTFJV46o2tCNp1DvRCnNrBaxwZsCG8tak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YjUNLrJPPiUJlG4lIcryD4r6V7wD8BPdtN0Ru12DQxleU4yaYHjuDkNDBDT/NXTYM
	 foQVACKGxnBJNgqBD/Ws8daYb96WqoJeu+rQzFCM8cvktNR5z2N++6A+E3jjn+YTAk
	 /ohehroDPeQdRm3mrlNgtQcwknIF7kyqIjYcOUr7lMgoGGxKSzTTPFWneav12hT9IU
	 WqRprG4dHsJr+lkGpeZsLMMhIPlg+Nz8tV1LqqtAbqdnMFIsqCcX/tfh33E5TUCo2s
	 hqXsqYxB2vEcU5tvL5c/JAWCneZdAKxec1eKgxrMUnLZGQ3TZeMpuEsuEMk6YWDGr0
	 kP+8Ix7YnG26w==
Date: Fri, 25 Aug 2023 14:04:22 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>,
	"lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	Aisheng Dong <aisheng.dong@nxp.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"jdmason@kudzu.us" <jdmason@kudzu.us>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"kishon@ti.com" <kishon@ti.com>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"kw@linux.com" <kw@linux.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	dl-linux-imx <linux-imx@nxp.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"maz@kernel.org" <maz@kernel.org>,
	"ntb@lists.linux.dev" <ntb@lists.linux.dev>,
	Peng Fan <peng.fan@nxp.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>
Subject: Re: [PATCH 0/3] Add RC-to-EP doorbell with platform MSI controller
Message-ID: <20230825083422.GB6005@thinkpad>
References: <20230426203436.1277307-1-Frank.Li@nxp.com>
 <AM6PR04MB483849BE4788EE893306F38E88759@AM6PR04MB4838.eurprd04.prod.outlook.com>
 <ZIdFFV5TdAy//Aat@lizhi-Precision-Tower-5810>
 <ZLVK7xX7kPjNaah+@lizhi-Precision-Tower-5810>
 <ZOepCkqSnUmTdGHX@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZOepCkqSnUmTdGHX@lizhi-Precision-Tower-5810>

On Thu, Aug 24, 2023 at 03:01:30PM -0400, Frank Li wrote:
> On Mon, Jul 17, 2023 at 10:06:39AM -0400, Frank Li wrote:
> > On Mon, Jun 12, 2023 at 12:17:25PM -0400, Frank Li wrote:
> > > On Fri, May 12, 2023 at 02:45:12PM +0000, Frank Li wrote:
> > > > > 
> > > > > This patches add new API to pci-epf-core, so any EP driver can use it.
> > > > > 
> > > > > The key point is comments from Thomas Gleixner, who suggest use new
> > > > > PCI/IMS. But arm platform change still not be merged yet.
> > > > > 
> > > > > git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git devmsi-v2-arm
> > > > > 
> > > > > So I still use existed method implement RC to EP doorbell.
> > > > > 
> > > > > If Thomas Gleixner want to continue work on devmsi-v2-arm, I can help test
> > > > > and update this patch.
> > > > > 
> > > > 
> > > > Ping?
> > > 
> > > Ping? 
> > 
> > ping? 
> 
> @Mani
>      Do you have chance to review these patches? It provide a common
> method with GIC ITS to implement notification from RC to EP.
> 

Sorry for the delay. I was wating for a review from Thomas. But since this
series hasn't caught his attention, I'll provide my review next week.

- Mani

> Frank
> 
> > 
> > > 
> > > > 
> > > > > Frank Li (3):
> > > > >   PCI: endpoint: Add RC-to-EP doorbell support using platform MSI
> > > > >     controller
> > > > >   misc: pci_endpoint_test: Add doorbell test case
> > > > >   tools: PCI: Add 'B' option for test doorbell
> > > > > 
> > > > >  drivers/misc/pci_endpoint_test.c    |  41 +++++++++++
> > > > >  drivers/pci/endpoint/pci-epf-core.c | 109
> > > > > ++++++++++++++++++++++++++++
> > > > >  include/linux/pci-epf.h             |  16 ++++
> > > > >  include/uapi/linux/pcitest.h        |   1 +
> > > > >  tools/pci/pcitest.c                 |  16 +++-
> > > > >  5 files changed, 182 insertions(+), 1 deletion(-)
> > > > > 
> > > > > --
> > > > > 2.34.1
> > > > 

-- 
மணிவண்ணன் சதாசிவம்
