Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CFA291C1F
	for <ntb@lists.linux.dev>; Thu, 18 Sep 2025 16:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758213334; cv=none; b=AULvNV1tLww8pRrf6UZN6g+moR7dyq8rNeX7DZz9vFRIXSb1OBAxM6J1q2c/mYyWrzAJVIYejomHHttSSP1/zX0GVLHWDmCg40TRW17vDfnhm2XD28h7fgpZx+zYC/3b3dd1chR6l/PCakbNXnk3qmRwhb2Rb2JN3gOZW4GDrcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758213334; c=relaxed/simple;
	bh=KuBwJhyEHroPzXf6yqowCwSPODZbtbghpLMk3+jJe78=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Jj6+9soz2j6dumwL1TAtE4I+jNP5ISf4suYZwp6AMFzsdwyWI8VN9KCUKN04VSY+MAhqMT/79pjo9QsmY7o3Nwr4innRBcA4tqnRS67v6Sji7UQh1mhhP0yA8rRTIgy98/2/i1IJ48We0vKRMZxqyWhS/br5DD7p5oM57EvypsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yt3Jmd0F; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yt3Jmd0F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758213333; x=1789749333;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=KuBwJhyEHroPzXf6yqowCwSPODZbtbghpLMk3+jJe78=;
  b=Yt3Jmd0Fux/GDIZ3P3jY2O0WkUs/biz39u2TyYyGzNysCmz/v/NUrkoi
   bnlyh27Mz8EGrRUFS/KhQ2El2eXK7y/Etsl906wE6+UO0FFeHvvpKAqOt
   Br41VtVcth+H/DSHd8SdR1zt9anNwzO6jgwXUpa12udg+k1x6qDhHW+1S
   +9dnYb/6vwSWNjEVZEMmcF7ayIrl42q2eHy/ZxL3O4+LdzBFMyAUY2wF4
   5ZPKFAi4yTDEzssLnixQNhRgfIPihW6MtGriWlOf8zvbC4+t8NGL5W8GK
   WhbNn4Df5rTpRESCXuCBDxttiWOjjsZ0GIIie+F2ylZsNhfiXgVlB3umg
   Q==;
X-CSE-ConnectionGUID: v9QjlqJYT+6YbWu72iIH6w==
X-CSE-MsgGUID: 54xHD1W+RnO+l///f6958Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="48127684"
X-IronPort-AV: E=Sophos;i="6.18,275,1751266800"; 
   d="scan'208";a="48127684"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 09:35:32 -0700
X-CSE-ConnectionGUID: 6m6axGrTS2S0ZtEcbjbQpA==
X-CSE-MsgGUID: D2tVyFFKR/uBl5O8DcasIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,275,1751266800"; 
   d="scan'208";a="174864789"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [10.125.108.18]) ([10.125.108.18])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 09:35:32 -0700
Message-ID: <48320c14-eded-42b9-9336-ed8d6128b0ee@intel.com>
Date: Thu, 18 Sep 2025 09:35:30 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Updates to AMD NTB driver
To: Basavaraj Natikar <Basavaraj.Natikar@amd.com>, Shyam-sundar.S-k@amd.com,
 jdmason@kudzu.us, allenbh@gmail.com, ntb@lists.linux.dev
References: <20250918073448.1070104-1-Basavaraj.Natikar@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250918073448.1070104-1-Basavaraj.Natikar@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/18/25 12:34 AM, Basavaraj Natikar wrote:
> This patch series include changes for:
>  - Adding a new gen CPU support.
>  - Update for the NTB AMD driver maintainer.
> 
> Changes in v2:
> 	-  Reformatted block to reduce indentation
> 	   by using early returns.
> 
> Basavaraj Natikar (2):
>   ntb_hw_amd: Update amd_ntb_get_link_status to support latest
>     generation secondary topology
>   MAINTAINERS: Update for the NTB AMD driver maintainer
> 
>  MAINTAINERS                     |  1 +
>  drivers/ntb/hw/amd/ntb_hw_amd.c | 18 +++++++++++++++++-
>  drivers/ntb/hw/amd/ntb_hw_amd.h |  1 +
>  3 files changed, 19 insertions(+), 1 deletion(-)
> 
For the series,
Reviewed-by: Dave Jiang <dave.jiang@intel.com>


