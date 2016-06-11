Return-Path: <allenbh@gmail.com>
Received: from mail-yw0-x241.google.com (mail-yw0-x241.google.com. [2607:f8b0:4002:c05::241])
        by gmr-mx.google.com with ESMTPS id o205si987979ywb.7.2016.06.10.19.35.51
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jun 2016 19:35:51 -0700 (PDT)
Received: by mail-yw0-x241.google.com with SMTP id l126so10528188ywe.3
        for <linux-ntb@googlegroups.com>; Fri, 10 Jun 2016 19:35:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d9488f2c946644c2b1258a78929d3543747283ec.1465598632.git.logang@deltatee.com>
References: <cover.1465598632.git.logang@deltatee.com> <d9488f2c946644c2b1258a78929d3543747283ec.1465598632.git.logang@deltatee.com>
From: Allen Hubbe <allenbh@gmail.com>
Date: Fri, 10 Jun 2016 22:35:51 -0400
Message-ID: <CAJ80savw=Lpzpf5VT2X=Uge0XO13nrwmw6SypvhiPgLsK6CLOw@mail.gmail.com>
Subject: Re: [PATCH 5/8] ntb_tool: BUG: Ensure the buffer size is large enough
 to return all spads
Content-Type: text/plain; charset=UTF-8
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Shuah Khan <shuahkh@osg.samsung.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, linux-kselftest@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

On Fri, Jun 10, 2016 at 6:54 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
> On hardware with 32 scratchpad registers the spad field in ntb tool
> could chop off the end. The maximum buffer size is increased from
> 256 to 15 times the number or scratchpads.
>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

It could be marginally better if there was an explanation to accompany
the magic number 15, but it's not a big deal.  One might guess it has
something to do with the expected length of the formatted string.

Acked-by: Allen Hubbe <Allen.Hubbe@emc.com>

> ---
>  drivers/ntb/test/ntb_tool.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
> index 4c01057..954e1d5 100644
> --- a/drivers/ntb/test/ntb_tool.c
> +++ b/drivers/ntb/test/ntb_tool.c
> @@ -368,7 +368,9 @@ static ssize_t tool_spadfn_read(struct tool_ctx *tc, char __user *ubuf,
>         if (!spad_read_fn)
>                 return -EINVAL;
>
> -       buf_size = min_t(size_t, size, 0x100);
> +       spad_count = ntb_spad_count(tc->ntb);
> +
> +       buf_size = min_t(size_t, size, spad_count * 15);
>
>         buf = kmalloc(buf_size, GFP_KERNEL);
>         if (!buf)
> @@ -376,7 +378,6 @@ static ssize_t tool_spadfn_read(struct tool_ctx *tc, char __user *ubuf,
>
>         pos = 0;
>
> -       spad_count = ntb_spad_count(tc->ntb);
>         for (i = 0; i < spad_count; ++i) {
>                 pos += scnprintf(buf + pos, buf_size - pos, "%d\t%#x\n",
>                                  i, spad_read_fn(tc->ntb, i));
> --
> 2.1.4
>
> --
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/d9488f2c946644c2b1258a78929d3543747283ec.1465598632.git.logang%40deltatee.com.
> For more options, visit https://groups.google.com/d/optout.
