Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id i11-v6si306208uak.0.2018.07.05.09.56.54
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Jul 2018 09:56:54 -0700 (PDT)
References: <1527106686-18852-1-git-send-email-dmeyer@gigaio.com>
 <20180630015002.GL40928@bhelgaas-glaptop.roam.corp.google.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <2e882f94-3ac6-3e27-b670-4996b350cae5@deltatee.com>
Date: Thu, 5 Jul 2018 10:56:45 -0600
MIME-Version: 1.0
In-Reply-To: <20180630015002.GL40928@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 0/2] PCI Quirk Patchset for Microsemi Switchtec NTB
To: Bjorn Helgaas <helgaas@kernel.org>, dmeyer@gigaio.com
Cc: kurt.schwemmer@microsemi.com, linux-pci@vger.kernel.org, linux-ntb@googlegroups.com, bhelgaas@google.com, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

Thanks for cleaning this up Bjorn.

On 29/06/18 07:50 PM, Bjorn Helgaas wrote:
> Please review and holler if I broke something.

I pulled your branch, reviewed it and lightly tested it. Everything
looks good to me.

> This touches drivers/ntb/hw/..., which isn't my area.  Let me know if you'd
> rather take these through a different tree.

The NTB change is very minor, and there's nothing this will conflict
with so I think it's fine to go through the PCI tree.

Logan
