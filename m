Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id u13si355278ita.3.2017.06.29.11.33.33
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Jun 2017 11:33:33 -0700 (PDT)
References: <20170629032648.3073-1-logang@deltatee.com>
 <20170629032648.3073-15-logang@deltatee.com>
 <000001d2f103$291602f0$7b4208d0$@dell.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <bc717da6-0bac-b198-3047-293165e65925@deltatee.com>
Date: Thu, 29 Jun 2017 12:33:21 -0600
MIME-Version: 1.0
In-Reply-To: <000001d2f103$291602f0$7b4208d0$@dell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 14/16] switchtec_ntb: implement scratchpad registers
To: Allen Hubbe <Allen.Hubbe@dell.com>, linux-ntb@googlegroups.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: 'Jon Mason' <jdmason@kudzu.us>, 'Dave Jiang' <dave.jiang@intel.com>, 'Bjorn Helgaas' <bhelgaas@google.com>, 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>, 'Kurt Schwemmer' <kurt.schwemmer@microsemi.com>, 'Stephen Bates' <sbates@raithlin.com>, 'Serge Semin' <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

On 6/29/2017 12:11 PM, Allen Hubbe wrote:
> This could get in the way of letting the driver support more than two ports later on.  Is there already a plan to change this to support more than two ports?

Well, as I mentioned this patchset is only to support 2 ports. Future 
work will expand this and remove the restriction. The core concept of 
the emulated spads doesn't get in the way but will need some further 
consideration.

But multi-port support will need a lot more work in the ntb clients 
anyway. There's no sense having support in my driver until I can 
actually test things. And I'll probably be fine doing some of the client 
work once we get there.

> This is also not the only hardware to lack scratchpads, but does have memory windows.  Wouldn't it be better for a software substitute like this to be done in a way that it is not tied to a specific hardware driver?

Yeah, we discussed this previously. Some of this is kind of hardware 
dependent though. In this case we are using a small fixed size LUT 
window. If the other hardware doesn't have similar support, using up one 
of the BAR memory windows (which are a very limited resource) for this 
might not make sense.

The switchtec driver also uses this special memory window to negotiate 
link status.

Anyway, I'm happy to collaborate to making what common parts we can 
possible with the IDT driver but Serge seemed against the whole concept 
of emulation.

Logan


