Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id o17si396312ito.4.2017.06.17.09.11.58
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Jun 2017 09:11:58 -0700 (PDT)
References: <20170615203729.9009-1-logang@deltatee.com>
 <000001d2e6a7$dfc719a0$9f554ce0$@dell.com>
 <daa95888-a786-b6d4-5e56-b9ac5b38a181@deltatee.com>
 <20170616163324.GA15472@mobilestation>
 <883bdb76-972c-7de9-0208-2d0933f192d4@deltatee.com>
 <20170616183824.GA5175@mobilestation.tp-local.ru>
 <33b6c321-c0af-7340-8e8e-e929a00005c7@deltatee.com>
 <20170616202100.GA24969@mobilestation.tp-local.ru>
 <20170617050959.GC6040@kroah.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <cf24258a-fa26-047f-e347-31c2b36a641a@deltatee.com>
Date: Sat, 17 Jun 2017 10:11:33 -0600
MIME-Version: 1.0
In-Reply-To: <20170617050959.GC6040@kroah.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [RFC PATCH 00/13] Switchtec NTB Support
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>, Serge Semin <fancer.lancer@gmail.com>
Cc: Allen Hubbe <Allen.Hubbe@dell.com>, linux-ntb@googlegroups.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 'Jon Mason' <jdmason@kudzu.us>, 'Dave Jiang' <dave.jiang@intel.com>, 'Bjorn Helgaas' <bhelgaas@google.com>, 'Kurt Schwemmer' <kurt.schwemmer@microsemi.com>, 'Stephen Bates' <sbates@raithlin.com>, Sergey.Semin@t-platforms.ru
List-ID: <linux-ntb.googlegroups.com>



On 16/06/17 11:09 PM, 'Greg Kroah-Hartman' wrote:
> Ah, but the patchset does seem to properly formatted.  At least it's
> easy for me to review as-published, while a much smaller number of
> patches, making much larger individual patches, would be much much
> harder to review.
> 
> But what do I know...
> 
> Oh wait, I review more kernel patches than anyone else :)

Thanks Greg.

> Logan, given that you need to rebase these on the "new" ntb api (and why
> the hell is that tree on github? We can't take kernel git pulls from
> github), is it worth reviewing this patch series as-is, or do you want
> us to wait?

I think initial review at this time will still be useful. I don't expect
the patchset will change _that_ much.

Logan
