Return-Path: <pebolle@tiscali.nl>
Received: from lb2-smtp-cloud6.xs4all.net (lb2-smtp-cloud6.xs4all.net. [194.109.24.28])
        by gmr-mx.google.com with ESMTPS id bc3si59763wib.2.2015.05.21.02.02.28
        for <linux-ntb@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 21 May 2015 02:02:28 -0700 (PDT)
Message-ID: <1432198946.21715.141.camel@x220>
Subject: Re: [PATCH 07/16] NTB Tool Client
From: Paul Bolle <pebolle@tiscali.nl>
Date: Thu, 21 May 2015 11:02:26 +0200
In-Reply-To: <6d1c7067f7af16088849a628a5227b2d19085098.1432135632.git.Allen.Hubbe@emc.com>
References: <cover.1432135631.git.Allen.Hubbe@emc.com>
	 <6d1c7067f7af16088849a628a5227b2d19085098.1432135632.git.Allen.Hubbe@emc.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: Allen Hubbe <Allen.Hubbe@emc.com>
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>
List-ID: <linux-ntb.googlegroups.com>

On Wed, 2015-05-20 at 11:41 -0400, Allen Hubbe wrote:
> --- a/drivers/ntb/test/Kconfig
> +++ b/drivers/ntb/test/Kconfig
> +config NTB_TOOL
> +       tristate "NTB Debugging Tool Client"
> +       depends on NTB

Same nit as for 2/16 and 7/16.

> +       help

> +        If unsure, say N.

(Please start the indentation with a tab, and not with spaces.)

Thanks,


Paul Bolle

