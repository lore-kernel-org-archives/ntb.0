Return-Path: <dave.jiang@intel.com>
Received: from mga01.intel.com (mga01.intel.com. [192.55.52.88])
        by gmr-mx.google.com with ESMTPS id j13-v6si89674ioa.1.2018.07.02.09.09.40
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 09:09:40 -0700 (PDT)
Subject: Re: AER event in NTB
References: <CAM+4PA3A-eL9uSVvrgf_RV+qoLi8CLd0qE4Ru7LWgdFSqQBsBg@mail.gmail.com>
From: Dave Jiang <dave.jiang@intel.com>
Message-ID: <88bbdd2f-ac2f-058e-1beb-5e6bcbfcf258@intel.com>
Date: Mon, 2 Jul 2018 09:09:38 -0700
MIME-Version: 1.0
In-Reply-To: <CAM+4PA3A-eL9uSVvrgf_RV+qoLi8CLd0qE4Ru7LWgdFSqQBsBg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
To: Grace Zhuang <gzhuang@celestica.com>
Cc: linux-ntb@googlegroups.com, Jon Mason <jdmason@kudzu.us>
List-ID: <linux-ntb.googlegroups.com>



On 07/01/2018 09:33 PM, Grace Zhuang wrote:
> On Purley platform, have any AER event/msi will be reported in dmesg?
> I found there was a ntb-aer branch, but it was maintained before 2015.

Intel NTB does not support standard PCIe AER. Support was never added
for it. I think that branch was Jon playing around with the proprietary
support. I don't believe it ties into the Linux standard PCIe AER
framework.
