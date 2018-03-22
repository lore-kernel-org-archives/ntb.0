Return-Path: <luc.vanoostenryck@gmail.com>
Received: from mail-wm0-x22a.google.com (mail-wm0-x22a.google.com. [2a00:1450:400c:c09::22a])
        by gmr-mx.google.com with ESMTPS id a132-v6si218937lfb.4.2018.03.22.10.27.50
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Mar 2018 10:27:50 -0700 (PDT)
Received: by mail-wm0-x22a.google.com with SMTP id l16so17650073wmh.3
        for <linux-ntb@googlegroups.com>; Thu, 22 Mar 2018 10:27:50 -0700 (PDT)
Return-Path: <luc.vanoostenryck@gmail.com>
Date: Thu, 22 Mar 2018 18:27:48 +0100
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v14 02/10] iomap: Add big endian sparse annotations to
 mmio_{read|write}XXbe()
Message-ID: <20180322172747.4rjped3gojfuhuh2@ltop.local>
References: <20180322171703.4300-1-logang@deltatee.com>
 <20180322171703.4300-3-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180322171703.4300-3-logang@deltatee.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-ntb@googlegroups.com, linux-crypto@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Andy Shevchenko <andy.shevchenko@gmail.com>, Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>, Thomas Gleixner <tglx@linutronix.de>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>
List-ID: <linux-ntb.googlegroups.com>

On Thu, Mar 22, 2018 at 11:16:55AM -0600, Logan Gunthorpe wrote:
> Sparse produces a few warnings of the form:
> 
> lib/iomap.c:84:9: warning: cast to restricted __be16
> 
> (The kbuild robot has recently started running such checks)

Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com> 
