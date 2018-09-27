Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id r9-v6si94002qkk.5.2018.09.27.09.38.31
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 09:38:31 -0700 (PDT)
References: <DM2PR11MB010585C1D5584683B31CCF5495140@DM2PR11MB0105.namprd11.prod.outlook.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <2164850f-0772-026e-19a0-73747d03aa93@deltatee.com>
Date: Thu, 27 Sep 2018 10:38:27 -0600
MIME-Version: 1.0
In-Reply-To: <DM2PR11MB010585C1D5584683B31CCF5495140@DM2PR11MB0105.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] NTB: switchtec_ntb: Update switchtec documentation
 with pre-requisites for NTB
To: Wesley.Sheng@microchip.com, kurt.schwemmer@microsemi.com, bhelgaas@google.com, corbet@lwn.net
Cc: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>



On 2018-09-27 12:36 a.m., Wesley.Sheng@microchip.com wrote:
> Update switchtec documentation
> 1.add pre-requisites for NTB driver
> 2.misc updates
>  change NTB hardware driver name to ntb_hw_switchtec
>  update the description of 2 partitions limit
>  add reference to Linux Documentation/ntb.txt
>  add use of term 'Command ID'
>  add use of term 'Command Return Value'
>  add a missing ')'

You need a better commit message. It needs to describe, in plain
English, why the maintainers should merge this, not itemize the
individual changes (that's what the patch body tells us).

>  * A write must consist of at least 4 bytes and no more than 1028 bytes.
> -  The first four bytes will be interpreted as the command to run and
> -  the remainder will be used as the input data. A write will send the
> +  The first 4 bytes will be interpreted as the Command ID and the  
> + remainder will be used as the input data. A write will send the
>    command to the firmware to begin processing.

You still have some broken white space in this patch. Notice the spacing
before "remainder" compared to the previous line.

>  * Each write must be followed by exactly one read. Any double write will
>  @@ -45,9 +45,9 @@ The char device has the following semantics:
>    produce an error.
>  
>  * A read will block until the firmware completes the command and return
> -  the four bytes of status plus up to 1024 bytes of output data. (The
> -  length will be specified by the size parameter of the read call --
> -  reading less than 4 bytes will produce an error.
> +  the 4-byte Command Return Value plus up to 1024 bytes of output  
> + data. (The length will be specified by the size parameter of the read  
> + call -- reading less than 4 bytes will produce an error.)

Here too.

>  * The poll call will also be supported for userspace applications that
>    need to do other things while waiting for the command to complete.
> @@ -83,10 +83,20 @@ The following IOCTLs are also supported by the device:
>  Non-Transparent Bridge (NTB) Driver
>  ===================================
>  
> -An NTB driver is provided for the switchtec hardware in switchtec_ntb.
> -Currently, it only supports switches configured with exactly 2 
> -partitions. It also requires the following configuration settings:
> +An NTB hardware driver is provided for the Switchtec hardware in 
> +ntb_hw_switchtec. Currently, it only supports switches configured with 
> +exactly 2 NT partitions and zero or more non-NT partitions. It also 
> +requires the following configuration settings:
>  
> -* Both partitions must be able to access each other's GAS spaces.
> +* Both NT partitions must be able to access each other's GAS spaces.
>    Thus, the bits in the GAS Access Vector under Management Settings
>    must be set to support this.
> +* Kernel configuration MUST include support for NTB (CONFIG_NTB needs
> +  to be set)
> +
> +NT EP BAR 2 will be dynamically configured as a Direct Window, and the 
> +configuration file does not need to configure it explicitly.
> +
> +Please refer to Documentation/ntb.txt in Linux source tree for an 
> +overall understanding of the Linux NTB stack. ntb_hw_switchtec works as 
> +an NTB Hardware Driver in this stack.
> 
