Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id w2si867625pfg.0.2017.01.10.15.34.44
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jan 2017 15:34:44 -0800 (PST)
References: <1483407036-20697-1-git-send-email-logang@deltatee.com>
 <20170110215527.GD13381@kudzu.us>
 <CAPoiz9wZq1m-7=CsyUKK07+vCm3Lyhf+z77TooUmff4-v_mh_Q@mail.gmail.com>
 <1484089612.12006.11.camel@perches.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <ebef7d4f-1e3d-b70f-741b-3f06b820289a@deltatee.com>
Date: Tue, 10 Jan 2017 16:34:41 -0700
MIME-Version: 1.0
In-Reply-To: <1484089612.12006.11.camel@perches.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 0/2] Style fixes: open code obfuscating macros
To: Joe Perches <joe@perches.com>, Jon Mason <jdmason@kudzu.us>
Cc: Xiangliang Yu <Xiangliang.Yu@amd.com>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-ntb@googlegroups.com, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-ntb.googlegroups.com>



On 10/01/17 04:06 PM, Joe Perches wrote:
> It might also be better to add and use YA
> logging macro like ndev_dbg
> 
> #define ndev_dvg(ndev, fmt, ...)	\
> 	dev_dbg(&(ndev)->ntb.pdev->dev, fmt, ##__VA_ARGS__)
> 
> so that the new temporaries that are used just
> for debugging are not required.
> 

I feel like that's going in the exact opposite direction from what Greg
was looking for... I think the point is to hide less of where the device
is coming from, not to create a new and different macro that hides
things in a different way.

Or, more likely, I _think_ Greg would suggest that this is showing that
the driver model isn't really being used properly. Perhaps, we should be
printing against the ntb struct device instead of the pci device so
there is no dereferencing.

Logan
