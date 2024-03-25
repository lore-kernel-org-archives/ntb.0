Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0226B224FB
	for <ntb@lists.linux.dev>; Mon, 25 Mar 2024 19:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711395590; cv=none; b=hK2xvTDCQZqmN2y/S3HP2tcLRP4qKpM58EPDLPIfk6Aozkkyh+wb/QDP7MY9iStU+arw8KbtfZObDvsl1lrUoS7L7DaIJikJZ7U+FHcg9vCN5ifuJEVYZk/ewvBvJmY4hkrMHfr2O5v8Bo+Ryw/bA8Ka+rx54SSIELMb0FvwcVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711395590; c=relaxed/simple;
	bh=D6MfnrEFK0/vmjnJEcjSthiQ8tmUlQRWp4661t4UP/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQ5hQ5Zl7z1VYrp5FhVd+ugvQEdyV1j2fm3VmPwj+iBVZCyrJPtsz611NX8Hbfcxc1vqKFQA2usyge+R4OPr06AwQD+5jvy+UXmxuUpngGMG2ZW+ds6rk39idLBXawog9oOxjVQOm861rCzBBxxJ5kUuXNcRZgrL/rZr7dWcP7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HqQ7RdWG; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HqQ7RdWG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711395587; x=1742931587;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D6MfnrEFK0/vmjnJEcjSthiQ8tmUlQRWp4661t4UP/k=;
  b=HqQ7RdWG+Lw1MCIjj21cTC1fwXcPU9/EMfx1ROyiBYbmE8eU38GdtPpH
   YAjxZUCHoA+2MGA1Ui4aMl0u3s9RbcHeXqr5LNUX4n9cH0sEnSz6Y/7PL
   Un7RgwCxyAWzDNw1MXQOjI3aebAj4Z4BYwKxInG6ciJOn/ra6ZdqoosCx
   9zVX3W0fAu1teOrPKsy1hG0wLtoIpd7JXhmqMj2DpoyPtfT6kbvw37AMM
   vjwYlMzlKrnJMvn7768pvnqK7+Qp8boyfYwwjpYufYlgjRYHagdzDmClg
   imcLLoZmnEwfvDgbulyq927hXSJxo/2uwjubjmjcTipch8Fs5rjyiBGou
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6601584"
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="6601584"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 12:39:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="914852875"
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="914852875"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 12:39:42 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1roqAU-0000000G7FV-4928;
	Mon, 25 Mar 2024 21:39:38 +0200
Date: Mon, 25 Mar 2024 21:39:38 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Jaroslav Kysela <perex@perex.cz>, linux-sound@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-serial@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org, ntb@lists.linux.dev,
	Lee Jones <lee@kernel.org>, David Airlie <airlied@gmail.com>,
	amd-gfx@lists.freedesktop.org, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-rdma@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/28] mfd: intel-lpss-pci: Use PCI_IRQ_INTX
Message-ID: <ZgHS-qZliVyFD5xh@smile.fi.intel.com>
References: <20240325070944.3600338-1-dlemoal@kernel.org>
 <20240325070944.3600338-10-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325070944.3600338-10-dlemoal@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 25, 2024 at 04:09:20PM +0900, Damien Le Moal wrote:
> Use the macro PCI_IRQ_INTX instead of the deprecated PCI_IRQ_LEGACY
> macro.

Not needed anymore. MFD subsystem has a patch moving this to MSI support.
But you need to coordinate with Lee how to proceed (in case of conflicts MFD
version should be taken).

-- 
With Best Regards,
Andy Shevchenko


