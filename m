Return-Path: <jdmason@kudzu.us>
Received: from mail-wi0-f175.google.com (mail-wi0-f175.google.com. [209.85.212.175])
        by gmr-mx.google.com with ESMTPS id w4si254354wiz.0.2015.10.04.19.48.52
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Oct 2015 19:48:52 -0700 (PDT)
Received: by wicge5 with SMTP id ge5so100481900wic.0
        for <linux-ntb@googlegroups.com>; Sun, 04 Oct 2015 19:48:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1443859782-16773-2-git-send-email-sudipm.mukherjee@gmail.com>
References: <1443859782-16773-1-git-send-email-sudipm.mukherjee@gmail.com>
	<1443859782-16773-2-git-send-email-sudipm.mukherjee@gmail.com>
Date: Sun, 4 Oct 2015 22:48:52 -0400
Message-ID: <CAPoiz9x-sHit56RhmrnKamk5GC=5vMpeBjZ8cYc+-Bg8tSP8Qw@mail.gmail.com>
Subject: Re: [PATCH 2/2] NTB: remove unused variable
From: Jon Mason <jdmason@kudzu.us>
Content-Type: text/plain; charset=UTF-8
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Sat, Oct 3, 2015 at 4:09 AM, Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
> These variables were not used anywhere. So remove them.
>
> Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>

Applied.

Thanks,
Jon

> ---
>  drivers/ntb/ntb_transport.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 69953ee..28f9a03 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -928,7 +928,6 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
>                                     unsigned int qp_num)
>  {
>         struct ntb_transport_qp *qp;
> -       struct ntb_transport_mw *mw;
>         phys_addr_t mw_base;
>         resource_size_t mw_size;
>         unsigned int num_qps_mw, tx_size;
> @@ -939,7 +938,6 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
>         qp_count = nt->qp_count;
>
>         mw_num = QP_TO_MW(nt, qp_num);
> -       mw = &nt->mw_vec[mw_num];
>
>         qp = &nt->qp_vec[qp_num];
>         qp->qp_num = qp_num;
> @@ -1930,13 +1928,11 @@ EXPORT_SYMBOL_GPL(ntb_transport_link_up);
>   */
>  void ntb_transport_link_down(struct ntb_transport_qp *qp)
>  {
> -       struct pci_dev *pdev;
>         int val;
>
>         if (!qp)
>                 return;
>
> -       pdev = qp->ndev->pdev;
>         qp->client_ready = false;
>
>         val = ntb_spad_read(qp->ndev, QP_LINKS);
> --
> 1.9.1
>
