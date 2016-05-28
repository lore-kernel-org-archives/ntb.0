Return-Path: <allenbh@gmail.com>
Received: from mail-yw0-x242.google.com (mail-yw0-x242.google.com. [2607:f8b0:4002:c05::242])
        by gmr-mx.google.com with ESMTPS id d71si1091225ywb.3.2016.05.28.06.09.20
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 May 2016 06:09:20 -0700 (PDT)
Received: by mail-yw0-x242.google.com with SMTP id n16so9702861ywd.2
        for <linux-ntb@googlegroups.com>; Sat, 28 May 2016 06:09:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1464381511-18491-1-git-send-email-logang@deltatee.com>
References: <1464381511-18491-1-git-send-email-logang@deltatee.com>
Date: Sat, 28 May 2016 09:09:20 -0400
Message-ID: <CAJ80satFd9z=tdgHSPJy_BKUXRGOfUV_Kc5_dgeaChsUF62h3Q@mail.gmail.com>
Subject: Re: [PATCH] ntb_tool: Fix infinite loop bug when writing
 spad/peer_spad file
From: Allen Hubbe <allenbh@gmail.com>
Content-Type: text/plain; charset=UTF-8
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

On Fri, May 27, 2016 at 4:38 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
> If you tried to write two spads in one line, as per the example:
>
> root@peer# echo '0 0x01010101 1 0x7f7f7f7f' > $DBG_DIR/peer_spad
>
> then the CPU would freeze in an infinite loop.
>
> This wasn't immediately obvious but 'pos' was not incrementing the
> buffer, so after reading the second pair of values, 'pos' would once
> again be 3 and it would re-read the second pair of values ad infinitum.
>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Good catch.  Thanks Logan.

Acked-by: Allen Hubbe <Allen.Hubbe@emc.com>

> ---
>  drivers/ntb/test/ntb_tool.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
> index 6f5dc6c..209ef7c 100644
> --- a/drivers/ntb/test/ntb_tool.c
> +++ b/drivers/ntb/test/ntb_tool.c
> @@ -268,7 +268,7 @@ static ssize_t tool_spadfn_write(struct tool_ctx *tc,
>  {
>         int spad_idx;
>         u32 spad_val;
> -       char *buf;
> +       char *buf, *buf_ptr;
>         int pos, n;
>         ssize_t rc;
>
> @@ -288,14 +288,15 @@ static ssize_t tool_spadfn_write(struct tool_ctx *tc,
>         }
>
>         buf[size] = 0;
> -
> -       n = sscanf(buf, "%d %i%n", &spad_idx, &spad_val, &pos);
> +       buf_ptr = buf;
> +       n = sscanf(buf_ptr, "%d %i%n", &spad_idx, &spad_val, &pos);
>         while (n == 2) {
> +               buf_ptr += pos;
>                 rc = spad_write_fn(tc->ntb, spad_idx, spad_val);
>                 if (rc)
>                         break;
>
> -               n = sscanf(buf + pos, "%d %i%n", &spad_idx, &spad_val, &pos);
> +               n = sscanf(buf_ptr, "%d %i%n", &spad_idx, &spad_val, &pos);
>         }
>
>         if (n < 0)
> --
> 2.1.4
