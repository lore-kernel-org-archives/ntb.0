Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id d63si511319itb.2.2017.06.17.09.17.05
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Jun 2017 09:17:06 -0700 (PDT)
References: <20170615203729.9009-1-logang@deltatee.com>
 <20170615203729.9009-3-logang@deltatee.com> <20170617051145.GD6040@kroah.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <04e01458-e57b-a328-d4ff-c1fbb8664bb1@deltatee.com>
Date: Sat, 17 Jun 2017 10:16:53 -0600
MIME-Version: 1.0
In-Reply-To: <20170617051145.GD6040@kroah.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [RFC PATCH 02/13] switchtec: export class symbol for use in upper
 layer driver
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-ntb@googlegroups.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>, Bjorn Helgaas <bhelgaas@google.com>, Kurt Schwemmer <kurt.schwemmer@microsemi.com>, Stephen Bates <sbates@raithlin.com>
List-ID: <linux-ntb.googlegroups.com>



On 16/06/17 11:11 PM, Greg Kroah-Hartman wrote:
> EXPORT_SYMBOL_GPL()?
> 
> And do you really have to move from a dynamic class to a static one?  I
> know it will work just the same, but I hate seeing static structures
> that have reference counts on them :)

I'll change both for v1. I didn't really need a static one. I just saw
an example of some other user of class_interface which and it seemed
appropriate.

Logan
