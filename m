Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id x26-v6si106981qtp.2.2018.07.20.09.33.47
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 09:33:47 -0700 (PDT)
References: <20180609000819.13883-1-logang@deltatee.com>
 <20180609000819.13883-10-logang@deltatee.com>
 <20180615195152.GA25605@mobilestation>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <641e5245-9e77-7e8e-aa70-6c7e73636a22@deltatee.com>
Date: Fri, 20 Jul 2018 10:33:36 -0600
MIME-Version: 1.0
In-Reply-To: <20180615195152.GA25605@mobilestation>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 8/8] NTB: ntb_test: Fix bug when counting remote files
To: Serge Semin <fancer.lancer@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Shuah Khan <shuah@kernel.org>
List-ID: <linux-ntb.googlegroups.com>



On 15/06/18 01:51 PM, Serge Semin wrote:
> I also tested this script in the looped-back setup. It is the case when two
> NTB-device ports are available at the same RootComplex. So the NTB can be
> configured from the single executional context. In this case the REMOTE_HOST is left
> empty, so the colon is left prepended to the corresponding paths and causes multiple
> errors including the one fixed by this patch. In order to fix it, we need to discard
> the colon for remote-less case, for instance, by the next patch:
> 
> @@ -482,7 +495,11 @@ function perf_test()
>  function ntb_tool_tests()
>  {
>  	LOCAL_TOOL="$DEBUGFS/ntb_tool/$LOCAL_DEV"
> -	REMOTE_TOOL="$REMOTE_HOST:$DEBUGFS/ntb_tool/$REMOTE_DEV"
> +	if [[ "${REMOTE_HOST}" != "" ]]; then
> +		REMOTE_TOOL="$REMOTE_HOST:$DEBUGFS/ntb_tool/$REMOTE_DEV"
> +	else
> +		REMOTE_TOOL="$DEBUGFS/ntb_tool/$REMOTE_DEV"
> +	fi
>  
>  	echo "Starting ntb_tool tests..."
>  
> And so on for REMOTE_PP and REMOTE_PERF. It is necessary for NTB devices, which ports
> are looped-back to the same Root-Port. Would you be amenable if you resent this patch
> together with the fix I suggested?
I took a closer look at this and it's not necessary. (Note: I do the
majority of my testing in a looped-back setup).

What you didn't notice is that split_remote() separates the colon
whether there is a host or not. It's not passed to ssh or cat (or
whatever) directly. So the change you propose will actually break the
how it was designed.

Logan

