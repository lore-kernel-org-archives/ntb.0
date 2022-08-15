Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A787E
	for <ntb@lists.linux.dev>; Mon, 15 Aug 2022 16:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660581916; x=1692117916;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AYtwGwo+tHklt445OPERMo5W2VDwyV3s+VU9GrKJULc=;
  b=UDoS4tPbpIU+I9HTnqUXte33/jWIjrm93HlvYYyBC8lF6J64LiWpmReG
   Oq6VCBmbNdOv8NFRQPkFZJrL6DJW4QehBiLgbpWl4coZi+wcRDFnL2Bmh
   3079iNoUqR6G+lXKuImbdmRuxkklPRTfH5WPE4LVrOXx9WhoUV2SuGNz2
   ywSl2RMpb4JvbonhhOQA9sIOt6uJUIxYgpLOp7RDoFdxPvyQp993Zyf97
   b/Abg8fsHfzWl1CkoQkivfRbMDhXDrXIekcJ4mj3iqKCZVBgHcgvKpI0t
   AP9cAMwyrRhux9g/3ZoGs1x2IR7LgBpEbBppkNFVa3pwEsVZWN50yeKiF
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="290755097"
X-IronPort-AV: E=Sophos;i="5.93,238,1654585200"; 
   d="scan'208";a="290755097"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 09:45:15 -0700
X-IronPort-AV: E=Sophos;i="5.93,238,1654585200"; 
   d="scan'208";a="606705779"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.120.29]) ([10.212.120.29])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 09:45:14 -0700
Message-ID: <68e750b4-001f-d0d7-1449-c8eda13d4b5e@intel.com>
Date: Mon, 15 Aug 2022 09:45:13 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.12.0
Subject: Re: [PATCH v4 0/3] ntb_perf: add new 'latency' test set
Content-Language: en-US
To: Alexander Fomichev <fomichev.ru@gmail.com>, ntb@lists.linux.dev
Cc: linux@yadro.com, Jon Mason <jdmason@kudzu.us>,
 Allen Hubbe <allenbh@gmail.com>, Guo Zhengkui <guozhengkui@vivo.com>,
 fancer.lancer@gmail.com, Alexander Fomichev <a.fomichev@yadro.com>
References: <20220812165544.26307-1-fomichev.ru@gmail.com>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20220812165544.26307-1-fomichev.ru@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/12/2022 9:55 AM, Alexander Fomichev wrote:
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

Hi Alexander, can you add the change log between revisions in the cover 
letter please? That helps folks that have formerly reviewed to know what 
has changed since your last revision. Thanks!

>
> Alexander Fomichev (3):
>    ntb_perf: extend with burst latency measurement
>    ntb_perf: extend with poll latency measurement
>    ntb_perf: extend with doorbell latency measurement
>
>   drivers/ntb/test/ntb_perf.c | 829 +++++++++++++++++++++++++++++++++++-
>   1 file changed, 813 insertions(+), 16 deletions(-)
>
