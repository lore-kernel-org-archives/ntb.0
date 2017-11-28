Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id q125si179291ywg.4.2017.11.27.17.42.51
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Nov 2017 17:42:52 -0800 (PST)
References: <CAJQW-Q4_hJ+23T0qhK9BRMbcfqdF7rnJkWWPmGKfN5WzyD-eJg@mail.gmail.com>
 <CAPoiz9zzL6jZeCa4o+AQN2j8J-5nMxQkojWdVEAb96==+v+awg@mail.gmail.com>
 <37fc41d9-5191-6f41-fd65-e175f0c661fa@deltatee.com>
 <0557295a-c60c-4aff-95ec-cb93296066ce@googlegroups.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <87e0fa6c-025c-d5b6-b683-dbb6be9cb115@deltatee.com>
Date: Mon, 27 Nov 2017 18:42:49 -0700
MIME-Version: 1.0
In-Reply-To: <0557295a-c60c-4aff-95ec-cb93296066ce@googlegroups.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Subject: Re: Ntb Transport Driver Problem After Power-up
To: Karl Kao <karl.kao@gmail.com>, linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>



On 27/11/17 05:14 PM, Karl Kao wrote:
> Would Microsemi turn off the NTB pcie link once the hardware chip is
> being through a reset?
> We can have the chip by default disable NTB link until hardware driver
> is loaded to make sure either reset or power cycle that the NTB link
> will be down.

The hardware chip won't be reset in this situation. That would kill the
other host. The "NTB link" is tracked in the driver as hardware only has
support for link events on each of the ports.

Logan
