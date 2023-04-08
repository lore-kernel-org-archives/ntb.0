Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342FA1841;
	Sat,  8 Apr 2023 09:36:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 711FEC433EF;
	Sat,  8 Apr 2023 09:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1680946611;
	bh=+k73FcTQ+O1Em4zMqm63dksd/hIneIxZldD6Q0gfaPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n7O9Ufy020IvjnUTh+PB+o1iO5au1kw1epgfJab7qJeShOLtc4/66vdDnIcOzL9J0
	 9b7dMDmoOUWrKiQ9WHJKULjtDyVJZASjo5jLN02/4hdR7yu8xmrpwriFOotp92jLt2
	 EXhkRO5GJ5Eg4jHJYxmdhs7L7aTPZNYg0Bx4YfGr3d09T0OxKiXl5dSI2I6WszWbnc
	 M3ti5A1xctwOoG4HqjLOHXXJrdZyLcecLA06/PXJfkJGRwEBewyXGAL7CFxCDYeslx
	 VskgtbYxtH2NEfNbOvPsGPM84Cs56CoWgWH4qWSCafbT2dfnpYIDXIXtS3U/C5cnOl
	 1QtrxFB8BKdIg==
Date: Sat, 8 Apr 2023 15:06:44 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: lpieralisi@kernel.org, allenbh@gmail.com, bhelgaas@google.com,
	dave.jiang@intel.com, helgaas@kernel.org, imx@lists.linux.dev,
	jdmason@kudzu.us, kw@linux.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH 1/1] PCI: endpoint: pci-epf-vntb: fix typo span in
 comments
Message-ID: <20230408093644.GG11124@thinkpad>
References: <20221214172254.668282-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221214172254.668282-1-Frank.Li@nxp.com>

On Wed, Dec 14, 2022 at 12:22:54PM -0500, Frank Li wrote:
> Replace span with spad.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 58a23ef4b572..935748244078 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -84,15 +84,15 @@ enum epf_ntb_bar {
>   * |                                                  |
>   * |                                                  |
>   * |                                                  |
> - * +-----------------------+--------------------------+ Base+span_offset
> + * +-----------------------+--------------------------+ Base+spad_offset
>   * |                       |                          |
> - * |    Peer Span Space    |    Span Space            |
> + * |    Peer Spad Space    |    Spad Space            |
>   * |                       |                          |
>   * |                       |                          |
> - * +-----------------------+--------------------------+ Base+span_offset
> - * |                       |                          |     +span_count * 4
> + * +-----------------------+--------------------------+ Base+spad_offset
> + * |                       |                          |     +spad_count * 4
>   * |                       |                          |
> - * |     Span Space        |   Peer Span Space        |
> + * |     Spad Space        |   Peer Spad Space        |
>   * |                       |                          |
>   * +-----------------------+--------------------------+
>   *       Virtual PCI             PCIe Endpoint
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
