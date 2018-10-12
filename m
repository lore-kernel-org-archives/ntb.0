Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id r132-v6si80394vke.0.2018.10.12.10.54.17
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 10:54:17 -0700 (PDT)
References: <1539174788-25878-1-git-send-email-wesleyshenggit@sina.com>
 <20181012113040.52bfff58@lwn.net>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <f6dbcdc1-b1e1-98e8-fbcb-73fc6f92ce67@deltatee.com>
Date: Fri, 12 Oct 2018 11:54:11 -0600
MIME-Version: 1.0
In-Reply-To: <20181012113040.52bfff58@lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3] NTB: switchtec_ntb: Update switchtec documentation
 with pre-requisites for NTB
To: Jonathan Corbet <corbet@lwn.net>, Wesley Sheng <wesleyshenggit@sina.com>
Cc: kurt.schwemmer@microsemi.com, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com, linux-ntb@googlegroups.com, Wesley Yung <wesley.yung@microchip.com>, Kelvin Cao <kelvin.cao@microchip.com>
List-ID: <linux-ntb.googlegroups.com>



On 2018-10-12 11:30 a.m., Jonathan Corbet wrote:
> On Wed, 10 Oct 2018 20:33:08 +0800
> Wesley Sheng <wesleyshenggit@sina.com> wrote:
> 
>> The ntb_hw_switchtec driver has requirements on kernel configuration
>> so we add these notes to the documentation and also clean up a few 
>> other sentences in the documentation.
>>
>> Signed-off-by: Wesley Yung <wesley.yung@microchip.com>
>> Signed-off-by: Kelvin Cao <kelvin.cao@microchip.com>
>> Signed-off-by: Wesley Sheng <wesleyshenggit@sina.com>
> 
> So why all of these signoffs for such a small patch?  Who is the actual
> author of the patch?

It was originally two very small patches from Mr. Yung[1] and Mr. Cao[2]
combined and then cleaned up for upstream by Mr. Sheng.

There will likely be a bit more of this as they intend on upstreaming
more of the work that has been done out-of-tree. I believe most of this
is minor bug fixes and small feature additions.

Logan

[1]
https://github.com/Microsemi/switchtec-kernel/commit/5e7e7709c8ce6f37163113a8b6282aa4a788b6a0

[2]
https://github.com/Microsemi/switchtec-kernel/commit/e25fbb7267a742d08ca0802e0a6886c183e8b7b4


