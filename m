Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C092B7E;
	Tue,  1 Nov 2022 11:56:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C81EBC433C1;
	Tue,  1 Nov 2022 11:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1667303797;
	bh=3Gbw2UZZJhp39VIc/j5rzxNESBVTn6BHioH52Hr/85s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b0X8TrGomHpyhbg89JghPX9JWhpRs2+olb67gQK12Z9tmwl3FzmWIUaOio3TNtQKx
	 /2mJwBcfPwfzrUOVc2LruqdvMTkWax95l4sx/NycJo2uwl03tGOzoXgnJs1h0pwLvI
	 mC8iA3tJmpC3ph+OYzHwvJEQG/f+Jh6tXPfq0TG86PkwujL6j6aqHHEo4Ne1vKx5Vl
	 gOVKUJQ5HOShc6sPW3e0V7zQ9ZPKT44rGgRxngWB8GRj76jh0cdUOZk8w58JwuDB/V
	 4vT13cuJiDSnhrehI1FPHLFFaANgIsGKHmltnIIpfz/x3x9glwQlfUB8Iuleb/p6cp
	 F0zx+eMQkiJlg==
Date: Tue, 1 Nov 2022 17:26:21 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: allenbh@gmail.com, bhelgaas@google.com, dave.jiang@intel.com,
	helgaas@kernel.org, imx@lists.linux.dev, jdmason@kudzu.us,
	kw@linux.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, lpieralisi@kernel.org,
	ntb@lists.linux.dev
Subject: Re: [PATCH v14 2/7] PCI: endpoint: pci-epf-vntb: Fix indentation of
 the struct epf_ntb_ctrl
Message-ID: <20221101115621.GF54667@thinkpad>
References: <20221028155703.318928-1-Frank.Li@nxp.com>
 <20221028155703.318928-3-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221028155703.318928-3-Frank.Li@nxp.com>

On Fri, Oct 28, 2022 at 11:56:58AM -0400, Frank Li wrote:
> From: Frank Li <frank.li@nxp.com>
> 
> Indentation of the struct epf_ntb_ctrl align with other struct
> 

"Align the indentation of struct epf_ntb_ctrl with other structs in the driver"

> Signed-off-by: Frank Li <frank.li@nxp.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 28 +++++++++----------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index c0115bcb3b5e..1863006cc36c 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -99,20 +99,20 @@ enum epf_ntb_bar {
>   *       NTB Driver               NTB Driver
>   */
>  struct epf_ntb_ctrl {
> -	u32     command;
> -	u32     argument;
> -	u16     command_status;
> -	u16     link_status;
> -	u32     topology;
> -	u64     addr;
> -	u64     size;
> -	u32     num_mws;
> -	u32	reserved;
> -	u32     spad_offset;
> -	u32     spad_count;
> -	u32	db_entry_size;
> -	u32     db_data[MAX_DB_COUNT];
> -	u32     db_offset[MAX_DB_COUNT];
> +	u32 command;
> +	u32 argument;
> +	u16 command_status;
> +	u16 link_status;
> +	u32 topology;
> +	u64 addr;
> +	u64 size;
> +	u32 num_mws;
> +	u32 reserved;
> +	u32 spad_offset;
> +	u32 spad_count;
> +	u32 db_entry_size;
> +	u32 db_data[MAX_DB_COUNT];
> +	u32 db_offset[MAX_DB_COUNT];

General question: Don't we need to take care of endianess here?

Thanks,
Mani

>  } __packed;
>  
>  struct epf_ntb {
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
