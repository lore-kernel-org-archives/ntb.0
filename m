Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D592F23
	for <ntb@lists.linux.dev>; Wed,  2 Feb 2022 20:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643832839; x=1675368839;
  h=message-id:date:mime-version:to:from:subject:
   content-transfer-encoding;
  bh=YkLsVOb1RUGIXQzJMKGfzQDxVPSJbJxaLL1azJItlMo=;
  b=dIqgow0bn3fjCciq469iGqULIYF7MSDUzogQ9emLTFWEv7jUStxzDz8I
   h4tKhDBYxfmGB6fwVK/UKM/18/39pT2yS27aiIgQi0AOtmzvvWj11oiK9
   HziJVpL1gcL7zrNOeqIRie1eFWo1VaJ45KlaRwUoVhWkDh6beZDvd+gai
   8PUlXoFm/VQ4S7xBfowi1AJBCQZ3vT3jxlXjUrbNvlt8ANBekdE2sxdoD
   2/d7Pc8ibblYqHlSJENR6CCQJdu5eb7jjyOWkXW7d85IB4P25rCVl2c7x
   l1g5mvImZ5reZKS2OOM20mHRfa7qFjGzoBk4wlrGQoj2Jqn3MfVt7W5VN
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="334370844"
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="334370844"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 12:13:58 -0800
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="538448978"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.209.184.227]) ([10.209.184.227])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 12:13:58 -0800
Message-ID: <e49bfda5-6f90-38c7-628e-365c61502487@intel.com>
Date: Wed, 2 Feb 2022 13:13:57 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To: ntb@lists.linux.dev
From: Dave Jiang <dave.jiang@intel.com>
Subject: testing list posting
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

test 1 2 3

