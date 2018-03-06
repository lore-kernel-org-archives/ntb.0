Return-Path: <andy.shevchenko@gmail.com>
Received: from mail-qk0-x234.google.com (mail-qk0-x234.google.com. [2607:f8b0:400d:c09::234])
        by gmr-mx.google.com with ESMTPS id v8si853060ywg.3.2018.03.06.02.48.30
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Mar 2018 02:48:30 -0800 (PST)
Received: by mail-qk0-x234.google.com with SMTP id r140so141579qke.12
        for <linux-ntb@googlegroups.com>; Tue, 06 Mar 2018 02:48:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180305190824.847-8-logang@deltatee.com>
References: <20180305190824.847-1-logang@deltatee.com> <20180305190824.847-8-logang@deltatee.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 6 Mar 2018 12:48:29 +0200
Message-ID: <CAHp75Vc41MwtDr24-z3po2nx3Hr7_=tFUD0odcrbnVTP4SnJ1g@mail.gmail.com>
Subject: Re: [PATCH v11 7/7] ntb: ntb_hw_switchtec: Cleanup 64bit IO defines
 to use the common header
Content-Type: text/plain; charset="UTF-8"
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, linux-ntb@googlegroups.com, linux-crypto <linux-crypto@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>, Jon Mason <jdmason@kudzu.us>
List-ID: <linux-ntb.googlegroups.com>

On Mon, Mar 5, 2018 at 9:08 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
> Clean up the ifdefs which conditionally defined the io{read|write}64
> functions in favour of the new common io-64-nonatomic-lo-hi header.

>  #include <linux/kthread.h>
>  #include <linux/interrupt.h>
>  #include <linux/ntb.h>
> +#include <linux/io-64-nonatomic-lo-hi.h>

A nit, can we preserve alphabetical ordering?


-- 
With Best Regards,
Andy Shevchenko
