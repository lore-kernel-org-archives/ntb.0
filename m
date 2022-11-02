Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19102773C;
	Wed,  2 Nov 2022 23:03:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64ECCC433D6;
	Wed,  2 Nov 2022 23:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1667430183;
	bh=bFi5GLyHkJTTp2mySqmcb6bpgXQEzy01l8XhyjLqLwc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=IsiVrEYIQTvhRrDuo/Y+YcBBa26GjLjC5soSFr8/j8SbVhaO3dq0v0lkVx5jqjIjM
	 DpNuE1GnSE3i3VipHqD4BakhZRtRNBUj6QICP+4yYy/fLbJGBZPNjz/Ew4XFfbexDy
	 z2KMyI6WNZoBfkjZT5DDoEi+FCVWMVht7yf+fDiw3EwLGJ5IEs6R8rrBw1fpxB58oo
	 vk3gUp9PYW8ED7tooVNE1V2xzfJdjp6t4tzpTlk7B2TtA0+JXzprZJ0hzy+ksP5KPt
	 iHtgSTBDRjpqPQSAGvkgLPQG60/Ywylf9+6V61ooHgvnrObd3xSKItzW51dl0diyhD
	 OOLh3HRhxufrQ==
Date: Wed, 2 Nov 2022 18:03:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: mani@kernel.org, allenbh@gmail.com, bhelgaas@google.com,
	dave.jiang@intel.com, imx@lists.linux.dev, jdmason@kudzu.us,
	kw@linux.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, lpieralisi@kernel.org,
	ntb@lists.linux.dev
Subject: Re: [PATCH v16 0/7]  pci-epf-vntb clean up
Message-ID: <20221102230302.GA6394@bhelgaas>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102141014.1025893-1-Frank.Li@nxp.com>

On Wed, Nov 02, 2022 at 10:10:07AM -0400, Frank Li wrote:
> continue patch series https://www.spinics.net/lists/linux-pci/msg130372.html
> https://www.spinics.net/lists/linux-pci/msg130924.html
> 
> Lorenzo suggest create new series. Version number continue from old one
> Change from v15 to v16
>   consistent subject
>   Add () after pci_epc_mem_free_addr

Don't forget these comments on your v15:
https://lore.kernel.org/r/20221101172006.GA1264778@bhelgaas
