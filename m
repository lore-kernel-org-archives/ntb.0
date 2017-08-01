Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id o128si128748itc.1.2017.08.01.11.17.54
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Aug 2017 11:17:54 -0700 (PDT)
References: <20170725205753.4735-1-logang@deltatee.com>
 <20170725205753.4735-7-logang@deltatee.com> <20170801181452.GE4186@kudzu.us>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <c4235dc9-90d0-1e68-7c73-c2a5bec83712@deltatee.com>
Date: Tue, 1 Aug 2017 12:17:47 -0600
MIME-Version: 1.0
In-Reply-To: <20170801181452.GE4186@kudzu.us>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 06/16] ntb: ensure ntb_mw_get_align() is only called
 when the link is up
To: Jon Mason <jdmason@kudzu.us>
Cc: linux-ntb@googlegroups.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>, Bjorn Helgaas <bhelgaas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kurt Schwemmer <kurt.schwemmer@microsemi.com>, Stephen Bates <sbates@raithlin.com>, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

Hey,

On 01/08/17 12:14 PM, Jon Mason wrote:
> This also looks like a bug fix.  However, given that it is a little more
> invasive and no one reporting any problems with it, I'm less apt to
> pull it into the bug-fixes branch without anyone compilaining of a
> bug (lest I break something in -stable).

Yes, 6 and 7 change a semantic of that function. I wouldn't call them
bug fixes. But you can't pull 7 without pulling 6, as 7 would break
everything unless the change in 6 occurs.

Thanks,

Logan
