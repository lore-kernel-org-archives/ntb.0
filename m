Return-Path: <BATV+bd442da0e4c2cc164bb2+5625+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org. [2607:7c80:54:e::133])
        by gmr-mx.google.com with ESMTPS id 143si5453763vkw.4.2019.01.17.07.46.19
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 07:46:19 -0800 (PST)
Date: Thu, 17 Jan 2019 07:46:12 -0800
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 0/8] Virtio-over-PCIe on non-MIC
Message-ID: <20190117154612.GA6262@infradead.org>
References: <20190116163253.23780-1-vincent.whitchurch@axis.com>
 <CAK8P3a2ifu9X+SXgoDPSFMYwnKr=Yex8_tD4qRimcOQAhuEa8Q@mail.gmail.com>
 <20190117105441.eqediwlekofp2srg@axis.com>
 <CAK8P3a2HtSJCLVdLcs=f0b5wv-k-6E_Z4Pt3Yp_kazUZh-Ek9A@mail.gmail.com>
 <20190117151906.odvozs6kz3uvx32y@axis.com>
 <20190117152142.GB20359@infradead.org>
 <20190117153206.2flxqb26tbdrwp4z@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117153206.2flxqb26tbdrwp4z@axis.com>
To: Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc: Christoph Hellwig <hch@infradead.org>, Arnd Bergmann <arnd@arndb.de>, sudeep.dutt@intel.com, ashutosh.dixit@intel.com, gregkh <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-pci <linux-pci@vger.kernel.org>, linux-ntb@googlegroups.com, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

On Thu, Jan 17, 2019 at 04:32:06PM +0100, Vincent Whitchurch wrote:
> If I understand you correctly, I think you're talking about the RC
> running the virtio drivers and the endpoint implementing the virtio
> device?  This vop stuff is used for the other way around: the virtio
> device is implement on the RC and the endpoint runs the virtio drivers.

Oh.  That is really weird and not that way I'd implement it..
