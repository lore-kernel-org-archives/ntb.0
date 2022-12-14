Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341027C;
	Wed, 14 Dec 2022 00:26:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B43C433EF;
	Wed, 14 Dec 2022 00:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1670977603;
	bh=NDgzNzla8xVcW0uTm0lMUqLVpqM6P7lvLIQIDHm7YwY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=hv51f69k1nOkqwhvVxLbREu63I/O7Y+KIgmKi81hYB/T91GuYo8bAuLiEJUFSQGSM
	 dg42kpX9k2E9HlVKit9ZurnhoiUDRyaBB//FB1AbkTEUBSd3y2VWW6wzAXU9AKE3XA
	 g9HMVocOgpwn5qzUivFll8Ki+HeILE2cs26K2W3qM6mGWJzp0VMVM6HY80/9Nxh28p
	 9rKGd9c/YS7lvKDtl1z/ceTz3kM3UEftxKAc4j2jHs/KV/3E+rgiw7tzZmd4U76+8Z
	 /v4kZM7Sytcm5Il+qUxoXcqnQiMlURELN5b4Dwgcj5uJiSxufbTzWwvB71l6OBNUWm
	 VNMmGmDCah4Aw==
Date: Tue, 13 Dec 2022 18:26:42 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: mani@kernel.org, allenbh@gmail.com, bhelgaas@google.com,
	dave.jiang@intel.com, imx@lists.linux.dev, jdmason@kudzu.us,
	kw@linux.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, lpieralisi@kernel.org,
	ntb@lists.linux.dev
Subject: Re: [PATCH v16 7/7] PCI: endpoint: pci-epf-vntb: fix sparse build
 warning at ntb->reg
Message-ID: <20221214002642.GA216337@bhelgaas>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102141014.1025893-8-Frank.Li@nxp.com>

On Wed, Nov 02, 2022 at 10:10:14AM -0400, Frank Li wrote:
> From: Frank Li <frank.li@nxp.com>
> 
>   pci-epf-vntb.c:1128:33: sparse:     expected void [noderef] __iomem *base
>   pci-epf-vntb.c:1128:33: sparse:     got struct epf_ntb_ctrl *reg
> 
> Add __iomem type convert in vntb_epf_peer_spad_read() and
> vntb_epf_peer_spad_write().

I don't understand all the bits and pieces here, but I'm a little
dubious about adding all these "(void __iomem *)"casts.  There are
very few of them in drivers/pci/, and I doubt this driver is so unique
that it needs them.

> @@ -1121,7 +1121,7 @@ static u32 vntb_epf_spad_read(struct ntb_dev *ndev, int idx)
>  	struct epf_ntb *ntb = ntb_ndev(ndev);
>  	int off = ntb->reg->spad_offset, ct = ntb->reg->spad_count * sizeof(u32);
>  	u32 val;
> -	void __iomem *base = ntb->reg;
> +	void __iomem *base = (void __iomem *)ntb->reg;
>  
>  	val = readl(base + off + ct + idx * sizeof(u32));
>  	return val;
> @@ -1132,7 +1132,7 @@ static int vntb_epf_spad_write(struct ntb_dev *ndev, int idx, u32 val)
>  	struct epf_ntb *ntb = ntb_ndev(ndev);
>  	struct epf_ntb_ctrl *ctrl = ntb->reg;
>  	int off = ctrl->spad_offset, ct = ctrl->spad_count * sizeof(u32);
> -	void __iomem *base = ntb->reg;
> +	void __iomem *base = (void __iomem *)ntb->reg;
>  
>  	writel(val, base + off + ct + idx * sizeof(u32));

These things look gratuitously different to begin with:

  int off = ntb->reg->spad_offset, ct = ntb->reg->spad_count * sizeof(u32);
  int off = ctrl->spad_offset, ct = ctrl->spad_count * sizeof(u32);

They're doing the same thing, and they should do it the same way.

Since db_data[] and db_offset[] are never referenced except to be
initialized to zero, I'm guessing the point of vntb_epf_spad_read()
and vntb_epf_spad_write() is to read/write things in those arrays?

You access other things in ntb->reg directly by dereferencing a
pointer, e.g.,

  ntb->reg->link_status |= LINK_STATUS_UP;
  addr = ntb->reg->addr;
  ctrl->command_status = COMMAND_STATUS_OK;

Why don't you just compute the appropriate *index* and access the
array directly instead of using readl() and writel()?

Bjorn
