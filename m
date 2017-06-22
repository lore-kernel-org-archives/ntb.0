Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id 81si188827ith.1.2017.06.22.13.10.12
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Jun 2017 13:10:13 -0700 (PDT)
References: <20170622164817.25515-1-logang@deltatee.com>
 <20170622164817.25515-5-logang@deltatee.com>
 <20170622210828.27304f6a@alans-desktop>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <401cdb64-6fdb-be30-b8bc-bf51c1a35074@deltatee.com>
Date: Thu, 22 Jun 2017 14:09:55 -0600
MIME-Version: 1.0
In-Reply-To: <20170622210828.27304f6a@alans-desktop>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 4/7] alpha: provide ioread64 and iowrite64 implementations
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-ntb@googlegroups.com, linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org, dri-devel@lists.freedesktop.org, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Bates <sbates@raithlin.com>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

On 6/22/2017 2:08 PM, Alan Cox wrote:
> But this does not do the same thing as an ioread64 with regards to
> atomicity or side effects on the device. The same is true of the other
> hacks. You either have a real 64bit single read/write from MMIO space or
> you don't. You can't fake it.

Yes, I know. But is it not better than having every driver that wants to 
use these functions fake it themselves?

Logan

