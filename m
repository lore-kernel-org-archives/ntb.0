Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4744A4A03
	for <ntb@lists.linux.dev>; Fri, 12 Aug 2022 19:49:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD57FC433C1;
	Fri, 12 Aug 2022 19:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1660333792;
	bh=ClAdKEFMDeZDn/PxO+XxTZ+M5W1kJt924rZ3ATx0KNI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=SnkRh6ofwDHbUd67L2K72I9OY6UbkNBqMqALb24vBPAbbmPNPuxXNagztBIPl4koX
	 CMGrf48XXGU1jhl0fGv37cjtoHYzFl+QJRz+fxwaGYkYAkuSdShitnr3nGu8li0MEc
	 u/BymoUKMxsqyc5IodDSvoBtJAhj6QdDvrYYD5VYYQin7l68G3YKvw0zSgaa3hrd1Q
	 uj0Z8f+vdXnu4Otg1JJOqv35QNJiNfcEZY7AJapLeQ9+m0A5eY/aVRFD2rf70T58h7
	 wuBcDalYvV1cLo+NGpy2q2TNVbHfjHDjaQ4Sf0xajrR4gdwe5QClJ8sCBEr/FECfN9
	 KRABKvSN6tPng==
Date: Fri, 12 Aug 2022 14:49:51 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jon Mason <jdmason@kudzu.us>
Cc: ntb@lists.linux.dev, Frank.Li@nxp.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add PCI Endpoint NTB drivers to NTB files
Message-ID: <20220812194951.GA1682383@bhelgaas>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220812194205.388967-1-jdmason@kudzu.us>

On Fri, Aug 12, 2022 at 03:42:05PM -0400, Jon Mason wrote:
> The PCI Endpoint NTB drivers are under the NTB umbrella.  Add an entry
> there to allow for notification of changes for it.
> 
> Signed-off-by: Jon Mason <jdmason@kudzu.us>

FWIW,

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 64379c699903..47e9f86bd712 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14254,6 +14254,7 @@ W:	https://github.com/jonmason/ntb/wiki
>  T:	git git://github.com/jonmason/ntb.git
>  F:	drivers/net/ntb_netdev.c
>  F:	drivers/ntb/
> +F:	drivers/pci/endpoint/functions/pci-epf-*ntb.c
>  F:	include/linux/ntb.h
>  F:	include/linux/ntb_transport.h
>  F:	tools/testing/selftests/ntb/
> -- 
> 2.30.2
> 
