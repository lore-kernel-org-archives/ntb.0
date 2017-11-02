Return-Path: <dave.jiang@intel.com>
Received: from mga11.intel.com (mga11.intel.com. [192.55.52.93])
        by gmr-mx.google.com with ESMTPS id c29si269206iod.3.2017.11.02.11.39.07
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Nov 2017 11:39:07 -0700 (PDT)
Subject: Re: Misleading throughput number using ntb_perf with memcpy_toio()
References: <1622b4fe-098b-4a76-bae7-c666258f9db6@googlegroups.com>
From: Dave Jiang <dave.jiang@intel.com>
Message-ID: <64a2604c-e675-ffbf-abc9-d6c5365eb45b@intel.com>
Date: Thu, 2 Nov 2017 11:39:04 -0700
MIME-Version: 1.0
In-Reply-To: <1622b4fe-098b-4a76-bae7-c666258f9db6@googlegroups.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Karl Kao <karl.kao@tintri.com>, linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>



On 11/02/2017 11:33 AM, Karl Kao wrote:
> Hi Folks,
> 
> We have one system with PLX NTB enabled with Gen3 speed on x8 lanes
> width. Technically, the NTB bandwidth is 64 Gbit/s (8192 MBytes/s) in
> outbound direction to its peer on this system.
> The ntb_perf comes with the throughput number of 9147 MBytes/s which is
> misleading in comparison to hardware bandwidth of 8192 MBytes/s.
> 
> We have a few questions with regard to the misleading throughput number.
> The overall is when memcpy() returns, data may have not yet been put in
> ingress buffer inside PLX NTB which is constrained by flow control
> credits, limitation of 8192 Mbytes/s.
> 
>   * The ntb_perf moves memory block to IO bus, using memcpy_toio(), a
>     macro of memcpy(). Once cpu core is done with mov instructions, the
>     memcpy() returns. Is this statement accurate?
>   * At the point when memcpy() is done with mov instructions, would the
>     data had been moved to internal buffer inside processor, instead of
>     going through IO bus into PLX chip?
>   * Where is the buffer, IIO buffer? What's buffer size that can
>     accommodate gigabytes data?
>   * Once we are clearer about the memcpy_tpio, would there be any API
>     that can accurately measure the IO write throughput?
> 
> 
> [11:02][root@BRYCE2-DEV][/sys/kernel/debug/ntb_perf/0000:06:00.0]\> cat run
> 0: copied 4294967296 bytes in 469542 usecs, 9147 MBytes/s
> [11:03][root@BRYCE2-DEV][/sys/kernel/debug/ntb_perf/0000:06:00.0]\>


Hi Karl. Yes the issue with ntb_perf is that it blindly copies into the
memory window with no acknowledgement from the peer node. So the
performance can be somewhat misleading because you don't know if it has
made it completely to the other side. The only way to know for certain
everything has made it over is to do a small read at the end of the
write I think?
