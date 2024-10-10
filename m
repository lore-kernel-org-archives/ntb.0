Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728371CB513;
	Thu, 10 Oct 2024 14:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728571644; cv=none; b=QX1sVyrdcyOX0LN+8wxkLSTQ5jwtlfLtnqS000Sy+7DYQgu9S3QkKsvybF8p4jG+Ksdy1VeSfInoKaxgOGORCaYbP/M1jS8wqMBxG6nFuiFfqAsUHsjucTOHn58zT3KrS+MT2NqVYfgpbeIjy8CsajAd5E1pTBwM7yferZf6fbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728571644; c=relaxed/simple;
	bh=c86bZx+YmfvhEWvQvzDAR3YRQcbqsE152hsx636Xtrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PzSC7aou55LE4i6EIwnuy9f53wjQLS++wdvxS1pWVea3QmUl93XyoQVBo4N0dtUrWi50lLXM4BUCrOFSeQaumhwF3IDUVsEaddWrZaRVJzmk6LVQ6/Hg4Uc+zuDtqZLiUiam8mA5gRbJwEzTs0cgURBhDIcrJlemM5QbWNEJIag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eziy96ng; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eziy96ng"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728571644; x=1760107644;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c86bZx+YmfvhEWvQvzDAR3YRQcbqsE152hsx636Xtrw=;
  b=eziy96ngc+upBBrJPWlseD/4ATEMUtzp8UBZQ3JfWadZk3UKkl2nb8xE
   MQw05ZLxDVqNwkgryofCxVwIDBZoT4PNouK8rR27xihezMgXzpGDmRBlB
   8/JXERiAxI0MwDny/nVqchX3A1CEZDOtd7nhRHIgUTJLGdhAHAYfpnGYs
   NNr5Eu0hvncI8NnZrGBWjs0nUy+B/0XPFilJLfYcx6pqFWUIE/7xjM4VL
   7Uq1f5VGWczC6F63G2w8EbdALtIrv+8hFJTZD4xG0LWVqtzJyW1FX09J8
   ekCVW4nL2iNAmYiF7+6ZPikdy9n7MfukoE/CQ9eSDsnwhxmALJYvS3n8W
   Q==;
X-CSE-ConnectionGUID: XBwGe4D5RVKK1j55PYaLvA==
X-CSE-MsgGUID: g1SR4hS6Qm2Bo1L7wR2yfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="27879184"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="27879184"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 07:47:19 -0700
X-CSE-ConnectionGUID: CFVtLA2bR8m8vXo4U4Ht/Q==
X-CSE-MsgGUID: 75L4zIgtTbi5nHx/jM5AKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="76227214"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 07:47:03 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1syuRN-00000001ZEK-3XKp;
	Thu, 10 Oct 2024 17:46:57 +0300
Date: Thu, 10 Oct 2024 17:46:57 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Basavaraj Natikar <basavaraj.natikar@amd.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alex Dubov <oakad@yahoo.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rasesh Mody <rmody@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
	Igor Mitsyanko <imitsyanko@quantenna.com>,
	Sergey Matyukevich <geomatsi@gmail.com>,
	Kalle Valo <kvalo@kernel.org>, Sanjay R Mehta <sanju.mehta@amd.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Chen Ni <nichen@iscas.ac.cn>, Ricky Wu <ricky_wu@realtek.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Breno Leitao <leitao@debian.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mostafa Saleh <smostafa@google.com>, Hannes Reinecke <hare@suse.de>,
	John Garry <john.g.garry@oracle.com>,
	Soumya Negi <soumya.negi97@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Yi Liu <yi.l.liu@intel.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Christian Brauner <brauner@kernel.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Eric Auger <eric.auger@redhat.com>, Ye Bin <yebin10@huawei.com>,
	Marek =?iso-8859-1?Q?Marczykowski-G=F3recki?= <marmarek@invisiblethingslab.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Rui Salvaterra <rsalvaterra@gmail.com>,
	Marc Zyngier <maz@kernel.org>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
	ntb@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-staging@lists.linux.dev, kvm@vger.kernel.org,
	xen-devel@lists.xenproject.org, linux-sound@vger.kernel.org
Subject: Re: [RFC PATCH 02/13] ALSA: hda: hda_intel: Use always-managed
 version of pcim_intx()
Message-ID: <Zwfo4dr4bfqQGGyl@smile.fi.intel.com>
References: <20241009083519.10088-1-pstanner@redhat.com>
 <20241009083519.10088-3-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009083519.10088-3-pstanner@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Oct 09, 2024 at 10:35:08AM +0200, Philipp Stanner wrote:
> pci_intx() is a hybrid function which can sometimes be managed through
> devres. To remove this hybrid nature from pci_intx(), it is necessary to
> port users to either an always-managed or a never-managed version.
> 
> hda_intel enables its PCI-Device with pcim_enable_device(). Thus, it needs
> the always-managed version.
> 
> Replace pci_intx() with pcim_intx().

...

>  	bus->irq = chip->pci->irq;
>  	chip->card->sync_irq = bus->irq;
> -	pci_intx(chip->pci, !chip->msi);
> +	pcim_intx(chip->pci, !chip->msi);
>  	return 0;

I believe each driver needs an individual approach. Looking at the above
I would first to understand why this one is being used and why we can't
switch to pci{m}_alloc_irq_vectors(). (Yeah, managed pci_alloc_irq_vectors()
is probably still missing, I don't remember if you introduced it or not.

-- 
With Best Regards,
Andy Shevchenko


