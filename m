Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id 81si324228ith.1.2017.06.09.14.51.57
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Jun 2017 14:51:57 -0700 (PDT)
References: <20170605200053.6912-1-logang@deltatee.com>
 <000001d2dec6$0531db10$0f959130$@dell.com> <20170609211236.GE9847@kudzu.us>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <9fa5c040-3e67-4f0b-accb-5905aa1de6f0@deltatee.com>
Date: Fri, 9 Jun 2017 15:51:52 -0600
MIME-Version: 1.0
In-Reply-To: <20170609211236.GE9847@kudzu.us>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ntb_netdev: set the net_device's parent
To: Jon Mason <jdmason@kudzu.us>, Allen Hubbe <Allen.Hubbe@dell.com>
Cc: linux-ntb@googlegroups.com, 'Dave Jiang' <dave.jiang@intel.com>
List-ID: <linux-ntb.googlegroups.com>



On 09/06/17 03:12 PM, Jon Mason wrote:
> Adding to my ntb branch with the following line:
> Fixes: a9c59ef77458 ("ntb_test: Add a selftest script for the NTB subsystem")

Thanks Jon! But you might have gotten confused here... This particular
patch doesn't fix ntb_test, but I sent a different one that does which
you have not merged yet.

Logan
