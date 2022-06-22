Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D23137A
	for <ntb@lists.linux.dev>; Wed, 22 Jun 2022 11:24:29 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id DB13D68AA6; Wed, 22 Jun 2022 13:16:41 +0200 (CEST)
Date: Wed, 22 Jun 2022 13:16:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Serge Semin <Sergey.Semin@baikalelectronics.ru>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Vladimir Murzin <vladimir.murzin@arm.com>,
	Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
	Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@bootlin.com>,
	linux-arm-kernel@lists.infradead.org,
	Srujana Challa <schalla@marvell.com>,
	Arnaud Ebalard <arno@natisbad.org>,
	Boris Brezillon <bbrezillon@kernel.org>,
	linux-crypto@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, Li Yang <leoyang.li@nxp.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-renesas-soc@vger.kernel.org,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@linux.ie>,
	Gerd Hoffmann <kraxel@redhat.com>, Tomasz Figa <tfiga@chromium.org>,
	Oded Gabbay <ogabbay@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	linux-arm-msm@vger.kernel.org, Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>, Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>, ntb@lists.linux.dev,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-direct: take dma-ranges/offsets into account in
 resource mapping
Message-ID: <20220622111641.GA27618@lst.de>
References: <20220610080802.11147-1-Sergey.Semin@baikalelectronics.ru> <20220620213755.kczuriyildoublzi@mobilestation>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620213755.kczuriyildoublzi@mobilestation>
User-Agent: Mutt/1.5.17 (2007-11-01)

I'd really like to hear something from the driver maintainers.  The
cod change itself looks fine, we just need to make sure it does not
break any driver assumptions.

And I think at least for the PCIe P2P and NTB cases I fear it might
break them.  The proper logic for those is in the p2p helpers, but
it seems like not everyone is using them.
