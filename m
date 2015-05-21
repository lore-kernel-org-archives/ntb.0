Return-Path: <pebolle@tiscali.nl>
Received: from lb1-smtp-cloud6.xs4all.net (lb1-smtp-cloud6.xs4all.net. [194.109.24.24])
        by gmr-mx.google.com with ESMTPS id bc3si58139wib.2.2015.05.21.01.51.59
        for <linux-ntb@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 21 May 2015 01:51:59 -0700 (PDT)
Message-ID: <1432198316.21715.135.camel@x220>
Subject: Re: [PATCH 02/16] NTB Abstraction Layer
From: Paul Bolle <pebolle@tiscali.nl>
Date: Thu, 21 May 2015 10:51:56 +0200
In-Reply-To: <d653819e0ebc03241fe073c9239be36a52f5e265.1432135631.git.Allen.Hubbe@emc.com>
References: <cover.1432135631.git.Allen.Hubbe@emc.com>
	 <d653819e0ebc03241fe073c9239be36a52f5e265.1432135631.git.Allen.Hubbe@emc.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: Allen Hubbe <Allen.Hubbe@emc.com>
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>
List-ID: <linux-ntb.googlegroups.com>

On Wed, 2015-05-20 at 11:41 -0400, Allen Hubbe wrote:
>  Documentation/ntb.txt               |   58 +
>  MAINTAINERS                         |   14 +-
>  drivers/net/ntb_netdev.c            |   58 +-
>  drivers/ntb/Kconfig                 |   20 +-
>  drivers/ntb/Makefile                |    4 +-
>  drivers/ntb/hw/Kconfig              |    1 +
>  drivers/ntb/hw/Makefile             |    1 +
>  drivers/ntb/hw/intel/Kconfig        |    8 +
>  drivers/ntb/hw/intel/Makefile       |    1 +
>  drivers/ntb/hw/intel/ntb_hw_intel.c | 3108 +++++++++++++++++++----------------
>  drivers/ntb/hw/intel/ntb_hw_intel.h |  591 +++----
>  drivers/ntb/ntb.c                   |  251 +++
>  drivers/ntb/ntb_transport.c         |  927 ++++++-----
>  include/linux/ntb.h                 |  983 +++++++++++
>  include/linux/ntb_transport.h       |   25 +-
>  15 files changed, 3873 insertions(+), 2177 deletions(-)
>  create mode 100644 Documentation/ntb.txt
>  create mode 100644 drivers/ntb/hw/Kconfig
>  create mode 100644 drivers/ntb/hw/Makefile
>  create mode 100644 drivers/ntb/hw/intel/Kconfig
>  create mode 100644 drivers/ntb/hw/intel/Makefile
>  create mode 100644 drivers/ntb/ntb.c
>  create mode 100644 include/linux/ntb.h

(My mailer tells me this message is over 200KB in size. Did you consider
offering bribes to get people to review this patch?)

I just spotted two nits.

> --- a/drivers/ntb/Kconfig
> +++ b/drivers/ntb/Kconfig
>  
> +if NTB
> +
> +source "drivers/ntb/hw/Kconfig"
> +
> +config NTB_TRANSPORT
> +       tristate "NTB Transport Client"
> +       depends on NTB

Superfluous dependency.

> +       help
> +        This is a transport driver that enables connected systems to exchange
> +        messages over the ntb hardware.  The transport exposes a queue pair api
> +        to client drivers.
> +
> +        If unsure, say N.
> +
> +endif # NTB

> --- /dev/null
> +++ b/drivers/ntb/hw/intel/Kconfig

> +config NTB_INTEL
> +       tristate "Intel Non-Transparent Bridge support"
> +       depends on NTB

Ditto.

> +       depends on X86
> +       help
> +        This driver supports Intel NTB on capable Xeon and Atom hardware.
> +
> +        If unsure, say N.

Thanks,


Paul Bolle

