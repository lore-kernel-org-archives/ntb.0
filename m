Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id i5-v6si83319pfi.1.2018.10.11.09.36.44
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 09:36:45 -0700 (PDT)
References: <1539182575-26851-1-git-send-email-wesley.sheng@microchip.com>
 <20181011162747.GP5906@bhelgaas-glaptop.roam.corp.google.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <f601ab82-7bcc-01cf-70d5-67c4de6a5abb@deltatee.com>
Date: Thu, 11 Oct 2018 10:36:41 -0600
MIME-Version: 1.0
In-Reply-To: <20181011162747.GP5906@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3] NTB: switchtec_ntb: Update switchtec documentation
 with pre-requisites for NTB
To: Bjorn Helgaas <helgaas@kernel.org>, Wesley Sheng <wesley.sheng@microchip.com>
Cc: bhelgaas@google.com, corbet@lwn.net, kurt.schwemmer@microsemi.com, linux-ntb@googlegroups.com, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Wesley Yung <wesley.yung@microchip.com>, Kelvin Cao <kelvin.cao@microchip.com>, Jon Mason <jdmason@kudzu.us>
List-ID: <linux-ntb.googlegroups.com>



On 2018-10-11 10:27 a.m., Bjorn Helgaas wrote:
> I'm not sure who should really own this file:
> 
>   $ ./scripts/get_maintainer.pl -f Documentation/switchtec.txt
>   Kurt Schwemmer <kurt.schwemmer@microsemi.com> (maintainer:PCI DRIVER FOR MICROSEMI SWITCHTEC)
>   Logan Gunthorpe <logang@deltatee.com> (maintainer:PCI DRIVER FOR MICROSEMI SWITCHTEC)
>   Jonathan Corbet <corbet@lwn.net> (maintainer:DOCUMENTATION)
>   linux-pci@vger.kernel.org (open list:PCI DRIVER FOR MICROSEMI SWITCHTEC)
>   linux-doc@vger.kernel.org (open list:DOCUMENTATION)
>   linux-kernel@vger.kernel.org (open list)
> 
> and Jon (NTB driver core maintainer) has applied recent updates
> to it.
> 
> But in the interest of forward progress, I applied this patch with
> Logan's ack to pci/misc for v4.20.

Thanks. I'm not really sure what's going on in the NTB tree these days
as Jon hasn't picked up anything in a while so it's probably better this
went through PCI. It was originally created through the PCI tree, there
shouldn't be any conflicts, and I can't see anyone else objecting.

Logan
