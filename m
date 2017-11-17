Return-Path: <pombredanne@nexb.com>
Received: from mail-wm0-x243.google.com (mail-wm0-x243.google.com. [2a00:1450:400c:c09::243])
        by gmr-mx.google.com with ESMTPS id a67si294492edf.3.2017.11.17.06.54.30
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Nov 2017 06:54:30 -0800 (PST)
Received: by mail-wm0-x243.google.com with SMTP id x63so6986084wmf.2
        for <linux-ntb@googlegroups.com>; Fri, 17 Nov 2017 06:54:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171117142038.GE17880@kroah.com>
References: <20171117142038.GE17880@kroah.com>
From: Philippe Ombredanne <pombredanne@nexb.com>
Date: Fri, 17 Nov 2017 15:53:49 +0100
Message-ID: <CAOFm3uGa01Zkpc7sDeosB0HSKcqb4gjiQK32wF8aq7VcNAEkZQ@mail.gmail.com>
Subject: Re: [PATCH] ntb: remove unneeded DRIVER_LICENSE #defines
Content-Type: text/plain; charset="UTF-8"
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>, Gary R Hook <gary.hook@amd.com>, Serge Semin <fancer.lancer@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Fri, Nov 17, 2017 at 3:20 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> There is no need to #define the license of the driver, just put it in
> the MODULE_LICENSE() line directly as a text string.
>
> This allows tools that check that the module license matches the source
> code license to work properly, as there is no need to unwind the
> unneeded dereference, especially when the string is defined just a few
> lines above the usage of it.
>
> Cc: Jon Mason <jdmason@kudzu.us>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Allen Hubbe <Allen.Hubbe@emc.com>
> Cc: Gary R Hook <gary.hook@amd.com>
> Cc: Serge Semin <fancer.lancer@gmail.com>
> Reported-by: Philippe Ombredanne <pombredanne@nexb.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


Reviewed-by: Philippe Ombredanne <pombredanne@nexb.com>
-- 
Cordially
Philippe Ombredanne
