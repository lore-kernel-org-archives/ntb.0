Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id r1si1412032pfg.4.2017.01.11.09.48.55
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jan 2017 09:48:56 -0800 (PST)
References: <1483407036-20697-1-git-send-email-logang@deltatee.com>
 <20170110215527.GD13381@kudzu.us>
 <CAPoiz9wZq1m-7=CsyUKK07+vCm3Lyhf+z77TooUmff4-v_mh_Q@mail.gmail.com>
 <1484089612.12006.11.camel@perches.com>
 <ebef7d4f-1e3d-b70f-741b-3f06b820289a@deltatee.com>
 <20170111065036.GA4111@kroah.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <b6de6b70-7dbd-d8e6-9967-b9590fef91ad@deltatee.com>
Date: Wed, 11 Jan 2017 10:48:51 -0700
MIME-Version: 1.0
In-Reply-To: <20170111065036.GA4111@kroah.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 0/2] Style fixes: open code obfuscating macros
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Joe Perches <joe@perches.com>, Jon Mason <jdmason@kudzu.us>, Xiangliang Yu <Xiangliang.Yu@amd.com>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>, linux-ntb@googlegroups.com, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-ntb.googlegroups.com>



On 10/01/17 11:50 PM, Greg Kroah-Hartman wrote:
> You should be printing against the ntb struct device, as that's the
> "correct" structure here, and not the PCI device at all, as that's too
> far up the device chain from what the driver is supposed to be doing.

Yup, agreed and thanks. My v2 patchset already makes this change.

Logan
