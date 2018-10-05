Return-Path: <allenbh@gmail.com>
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com. [2a00:1450:4864:20::229])
        by gmr-mx.google.com with ESMTPS id 41-v6si361467wrb.3.2018.10.05.10.03.12
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 10:03:12 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 63-v6so12251190ljs.4
        for <linux-ntb@googlegroups.com>; Fri, 05 Oct 2018 10:03:12 -0700 (PDT)
MIME-Version: 1.0
References: <20181005071234.GA8803@embeddedor.com>
In-Reply-To: <20181005071234.GA8803@embeddedor.com>
From: Allen Hubbe <allenbh@gmail.com>
Date: Fri, 5 Oct 2018 13:03:01 -0400
Message-ID: <CAJ80sasrMXyC4jDGG+-wDLLXSApM6-HdgmgGwNMtH7AMwPdCUg@mail.gmail.com>
Subject: Re: [PATCH] ntb: ntb_transport: Mark expected switch fall-throughs
Content-Type: text/plain; charset="UTF-8"
To: gustavo@embeddedor.com
Cc: Jon Mason <jdmason@kudzu.us>, dave.jiang@intel.com, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

On Fri, Oct 5, 2018 at 3:12 AM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
>
> Addresses-Coverity-ID: 1373888 ("Missing break in switch")
> Addresses-Coverity-ID: 1373889 ("Missing break in switch")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Acked-by: Allen Hubbe <allenbh@gmail.com>

> ---
>  drivers/ntb/ntb_transport.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 9398959..c643b9c 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -1278,6 +1278,7 @@ static void ntb_rx_copy_callback(void *data,
>                 case DMA_TRANS_READ_FAILED:
>                 case DMA_TRANS_WRITE_FAILED:
>                         entry->errors++;
> +                       /* fall through */
>                 case DMA_TRANS_ABORTED:
>                 {
>                         struct ntb_transport_qp *qp = entry->qp;
> @@ -1533,6 +1534,7 @@ static void ntb_tx_copy_callback(void *data,
>                 case DMA_TRANS_READ_FAILED:
>                 case DMA_TRANS_WRITE_FAILED:
>                         entry->errors++;
> +                       /* fall through */
>                 case DMA_TRANS_ABORTED:
>                 {
>                         void __iomem *offset =
> --
> 2.7.4
