Return-Path: <dave.jiang@intel.com>
Received: from mga06.intel.com (mga06.intel.com. [134.134.136.31])
        by gmr-mx.google.com with ESMTPS id a82-v6si1632039qkj.1.2018.07.13.08.48.03
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 08:48:03 -0700 (PDT)
Subject: Re: AER event in NTB
References: <CAM+4PA3A-eL9uSVvrgf_RV+qoLi8CLd0qE4Ru7LWgdFSqQBsBg@mail.gmail.com>
 <88bbdd2f-ac2f-058e-1beb-5e6bcbfcf258@intel.com>
 <CAM+4PA2SQ+=F47-SrmrbeOTsFhw0OihtbpFsXq-pkUOHvht8MA@mail.gmail.com>
From: Dave Jiang <dave.jiang@intel.com>
Message-ID: <56d92ea7-0184-7f14-edc7-69f9ab0f4483@intel.com>
Date: Fri, 13 Jul 2018 08:47:50 -0700
MIME-Version: 1.0
In-Reply-To: <CAM+4PA2SQ+=F47-SrmrbeOTsFhw0OihtbpFsXq-pkUOHvht8MA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
To: Grace Zhuang <gzhuang@celestica.com>
Cc: linux-ntb@googlegroups.com, Jon Mason <jdmason@kudzu.us>
List-ID: <linux-ntb.googlegroups.com>



On 07/13/2018 01:25 AM, Grace Zhuang wrote:
> Thanks Dave. 
> I studied Intel documents these days.
> I found In SKX_EDS_vol2B_546833_Rev1_7.pdf :
> 
> In Figure 4-1 NTB Internal Endpoint 
>     There is Vendor-Specific Advanced Error Reporting Capability.
> But in Figure 4-4 NTB External Endpoint 
>     There is standard Advanced Error Reporting Capability.

As far as I know the standard report mechanism is not supported by the
hardware.

> 
> 
> Grace Zhuang(庄燕子）
> Diagnostics Engineer
> +86-21-61006028 ext:7637
> 13917171202
> gzhuang@celestica.com <mailto:gzhuang@celestica.com>
> www.celestica.com <http://www.celestica.com> 
> 
> On Tue, Jul 3, 2018 at 12:09 AM, Dave Jiang <dave.jiang@intel.com
> <mailto:dave.jiang@intel.com>> wrote:
> 
> 
> 
>     On 07/01/2018 09:33 PM, Grace Zhuang wrote:
>     > On Purley platform, have any AER event/msi will be reported in dmesg?
>     > I found there was a ntb-aer branch, but it was maintained before 2015.
> 
>     Intel NTB does not support standard PCIe AER. Support was never added
>     for it. I think that branch was Jon playing around with the proprietary
>     support. I don't believe it ties into the Linux standard PCIe AER
>     framework.
> 
> 
