Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C607D7E;
	Wed, 19 Oct 2022 16:25:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F56C433D7;
	Wed, 19 Oct 2022 16:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666196758;
	bh=0bQZmrlbRpZ9ws+WGy2M+UgT6k1lZNfVBuaSFzLXw34=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=bgKBhraCjC02RBHGDBxVDk0T2QrFrwdkGvIJjEwnDcjqAQ6L/IZOn0PGaEjhJ3De1
	 wEYu9+peZyhs/Z09c/sptBwGV4MpcwLBVNBJT6I5t448bc/nVSBeaxUDE43qViiceN
	 AhfTwm6u3aXJwn5e6S38/u48wVLaIQA6FisX0OrtI1eyI43l7t8ZGHaDwASHkLsXIK
	 PioWvdTw7YINsp72XRHIFfYSho3PqeEAFtGKvUCGICKA0hK9FN8WQq/CJpIKt9awGu
	 04Iro2lETydQt1dDAH4VLMsXzc1PbLxLd9w2wxiHgklGObhoQBcdNz5+9Y80KFl5no
	 1Qmv3U9ZdyYnA==
Date: Wed, 19 Oct 2022 11:25:56 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: imx@lists.linux.dev, Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"open list:NTB DRIVER CORE" <ntb@lists.linux.dev>,
	"open list:PCI ENDPOINT SUBSYSTEM" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v13 1/6] PCI: endpoint: pci-epf-vntb: Clean up kernel_doc
 warning
Message-ID: <20221019162556.GA20373@bhelgaas>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221007191326.193079-3-Frank.Li@nxp.com>

On Fri, Oct 07, 2022 at 03:13:21PM -0400, Frank Li wrote:
> From: Frank Li <frank.li@nxp.com>
> 
> Cleanup warning found by scripts/kernel-doc
> Consolidate term
>     host, host1 to HOST
>     vhost, vHost, Vhost, VHOST2 to VHOST

When you post a series of several patches, it's nice if you include a
[0/n] cover letter to tie them all together.  Regrettably, this is not
very well covered in the documentation, but here's a pointer:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/5.Posting.rst?id=v6.0#n334

And if you look at the archives, you'll see lots of examples:

  https://lore.kernel.org/linux-pci/
