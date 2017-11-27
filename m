Return-Path: <jdmason@kudzu.us>
Received: from mail-vk0-x22d.google.com (mail-vk0-x22d.google.com. [2607:f8b0:400c:c05::22d])
        by gmr-mx.google.com with ESMTPS id t123si216140vkb.1.2017.11.27.08.15.25
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Nov 2017 08:15:25 -0800 (PST)
Received: by mail-vk0-x22d.google.com with SMTP id o70so17740021vkc.9
        for <linux-ntb@googlegroups.com>; Mon, 27 Nov 2017 08:15:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAOFm3uGa01Zkpc7sDeosB0HSKcqb4gjiQK32wF8aq7VcNAEkZQ@mail.gmail.com>
References: <20171117142038.GE17880@kroah.com> <CAOFm3uGa01Zkpc7sDeosB0HSKcqb4gjiQK32wF8aq7VcNAEkZQ@mail.gmail.com>
From: Jon Mason <jdmason@kudzu.us>
Date: Mon, 27 Nov 2017 11:15:24 -0500
Message-ID: <CAPoiz9zUWgVmXHV6AcHSoKXGheP9iUgqWf76rPbX2ivk6YKpPg@mail.gmail.com>
Subject: Re: [PATCH] ntb: remove unneeded DRIVER_LICENSE #defines
Content-Type: text/plain; charset="UTF-8"
To: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>, Gary R Hook <gary.hook@amd.com>, Serge Semin <fancer.lancer@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Fri, Nov 17, 2017 at 9:53 AM, Philippe Ombredanne
<pombredanne@nexb.com> wrote:
> On Fri, Nov 17, 2017 at 3:20 PM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>> There is no need to #define the license of the driver, just put it in
>> the MODULE_LICENSE() line directly as a text string.
>>
>> This allows tools that check that the module license matches the source
>> code license to work properly, as there is no need to unwind the
>> unneeded dereference, especially when the string is defined just a few
>> lines above the usage of it.
>>
>> Cc: Jon Mason <jdmason@kudzu.us>
>> Cc: Dave Jiang <dave.jiang@intel.com>
>> Cc: Allen Hubbe <Allen.Hubbe@emc.com>
>> Cc: Gary R Hook <gary.hook@amd.com>
>> Cc: Serge Semin <fancer.lancer@gmail.com>
>> Reported-by: Philippe Ombredanne <pombredanne@nexb.com>
>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
>
> Reviewed-by: Philippe Ombredanne <pombredanne@nexb.com>

Applied to my ntb-next branch.

Thanks,
Jon

> --
> Cordially
> Philippe Ombredanne
