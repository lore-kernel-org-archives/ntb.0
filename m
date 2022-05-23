Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E5B36E
	for <ntb@lists.linux.dev>; Mon, 23 May 2022 18:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653331117; x=1684867117;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=P3BDX2WOHpu+10+RiFx1Jqrr+/lRISVvGRKHMIVwQD0=;
  b=B1kYg0+E1RIU7dMhtoGnf6A06ztDLaPwe741L5/hGTyYEPxGs5/udZuw
   k0dQxaz/qbVP2tw7J42kFUV7Z8liSGtCbeqs2oyfLjvbnn5lj0+oyx3Nd
   ZHaVmMskifluhDoPW0XfUMaIQUKRHWnjJKn16us/+6tXBd3m+sv1GGw/G
   9zgHvAHapBrnAYpq0l9sWN/7Weq03Cb4cNUqY4l7UYVYaJSjVstkIUgbu
   Q5FKDeK67NhH/hYiuVl/kPmLTC1dTQMhGENPnssVPYeay9CjYMSU1CIHb
   uvNwzYMqw4SYs1qCgE2QYjWLHoNSl9+fEyqTQ+OXN4wi5lLh1QNDG/Sza
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="359715621"
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="359715621"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 11:38:36 -0700
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="526078472"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.65.78]) ([10.212.65.78])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 11:38:35 -0700
Message-ID: <60dd9f2e-57b1-7c9d-ca99-568c37fe286a@intel.com>
Date: Mon, 23 May 2022 11:38:35 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.0
Subject: Re: [PATCH v3 0/3] ntb_perf: add new 'latency' test set
Content-Language: en-US
To: Alexander Fomichev <fomichev.ru@gmail.com>, ntb@lists.linux.dev
Cc: linux@yadro.com, Jon Mason <jdmason@kudzu.us>,
 Allen Hubbe <allenbh@gmail.com>, Guo Zhengkui <guozhengkui@vivo.com>,
 fancer.lancer@gmail.com, Alexander Fomichev <a.fomichev@yadro.com>
References: <20220513193704.36868-1-fomichev.ru@gmail.com>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20220513193704.36868-1-fomichev.ru@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/13/2022 12:37 PM, Alexander Fomichev wrote:
> From: Alexander Fomichev <a.fomichev@yadro.com>
>
> The ntb_perf test provides a tool for NTB hardware performance
> evaluation. For software impact elimination the test uses a simple method
> (let's call it 'burst' mode), when the local system sends to the remote
> system a data set and counts time interval until hardware completion
> report, without the remote side confirming, nor data integrity check.
> The measured metric is a 'burst' throughput bandwidth of NTB connection.
>
> The patches extend ntb_perf with 3 new metrics:
> 1) Burst latency
> 2) Poll latency
> 3) Doorbell latency
>
> The resulting test set is fully backward compatible.
>
> Alexander Fomichev (3):
>    ntb_perf: extend with burst latency measurement
>    ntb_perf: extend with poll latency measurement
>    ntb_perf: extend with doorbell latency measurement
>
>   drivers/ntb/test/ntb_perf.c | 826 +++++++++++++++++++++++++++++++++++-
>   1 file changed, 810 insertions(+), 16 deletions(-)

Looks ok to me. Probably should get Serge's ack.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

