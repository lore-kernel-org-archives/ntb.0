Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D341124BD03;
	Mon, 27 Oct 2025 16:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761584134; cv=none; b=aqVrIXC7pQobS7Ged5k37aD7m8viIzeBLmI5KbfD/0ogmkNc7Bq+4AOODJugB6hjhi6jRVdDqGVMcT8nwgzJlFug0C+UGBNvciMtpBk5iFEaYHPrcwNrnQkRJxdSD1ic08UNUKnX8pMN+sZPUluSG0Mu6EmPvmuG1ANnNI4hWcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761584134; c=relaxed/simple;
	bh=yMEBsANcu4IpFQdB9+hbRWbC1n4bjjQ9lcVVRlxt+vo=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=hjfmz5SC5vRv3VykPvl13UOD2O9x+ZfnLkDDueyYBoHk626sPnG8DnEZdw/sPs+KxzdNWXVi1hgwO6RaBUy+t1Hgom7K/E4emWoNAIKn6BDNQD5536uoDT3+q4gV3bssj0UsvinMz81uDu95ac4k6XnZoD6em7PDl+MMDOsubq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=UvD149nl; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="UvD149nl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=rQUcxmgexwzPqQ1CiRoa1HBQYOicEvuy6f29OVpMOgI=; b=UvD149nl+0qsUbO64Py2IlWKxt
	uMGqaC7atCMAHUamEhKu9qkeiIENSNuHG5go35dCwlj1FbucS2dEO9lJGn/c0Ymmk8iTRy9pfQFgr
	09jEccT/grTC3Rs5sGEfjesPh62WyGeFKPssAto03fZuKLCVnMyOZ3yTCZya6Ob1b9quoVzlXNH2+
	jnQ+IswdT0RqXTPCFOUW+ql/RZSZIGWV29VghWS1PsnRJ3fKOf1QCYm+SPkxNotHZlboUHbFDkCsV
	Xo+74TB+lpNaDWKWYIky7yELsgG2UKEMooPV95Kn1wvVRymN2fhfAST8V4c5ZnzHUxJAvYYZaBz+k
	/569PYxg==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1vDQ7T-00000004t78-2vUp;
	Mon, 27 Oct 2025 10:30:56 -0600
Message-ID: <030a4195-ed20-4f5f-8841-ea5385bb4a8c@deltatee.com>
Date: Mon, 27 Oct 2025 10:30:52 -0600
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Koichiro Den <den@valinux.co.jp>, ntb@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com
References: <20251027004331.562345-1-den@valinux.co.jp>
 <20251027004331.562345-2-den@valinux.co.jp>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20251027004331.562345-2-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: den@valinux.co.jp, ntb@lists.linux.dev, linux-kernel@vger.kernel.org, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH 1/4] NTB: ntb_transport: Handle remapped contiguous region
 in vmalloc space
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2025-10-26 18:43, Koichiro Den wrote:
> The RX buffer virtual address may reside in vmalloc space depending on
> the allocation path, where virt_to_page() is invalid.
> 
> Use a helper that chooses vmalloc_to_page() or virt_to_page() as
> appropriate. This is safe since the buffer is guaranteed to be
> physically contiguous.

I think this statement needs some explanation.

vmalloc memory is generally not contiguous and using vmalloc_to_page()
like this seems very questionable.

I did a very quick look and found that "offset" may come from
dma_alloc_attrs() which can also return coherent memory that would be in
vmalloc space and would be contiguous.

However, in my cursory look, it appears that the kernel address returned
by dma_alloc_attrs() is eventually passed to dma_map_page() in order to
obtain the dma address a second time. This is really ugly, and almost
certainly not expected by the dma layer.

This requires a bit of a change, but it seems to me that if
dma_alloc_attrs() is used, the dma address it returns should be used
directly and a second map should be avoided completely. Then we wouldn't
need the unusual use of vmalloc_to_page().

At the very least, I think these issues need to be mentioned in the
commit message.

Logan
