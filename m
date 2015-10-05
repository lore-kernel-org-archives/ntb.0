Return-Path: <jdmason@kudzu.us>
Received: from mail-wi0-f180.google.com (mail-wi0-f180.google.com. [209.85.212.180])
        by gmr-mx.google.com with ESMTPS id c7si269460wiy.3.2015.10.04.19.37.45
        for <linux-ntb@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Oct 2015 19:37:45 -0700 (PDT)
Received: by wicgb1 with SMTP id gb1so99384223wic.1
        for <linux-ntb@googlegroups.com>; Sun, 04 Oct 2015 19:37:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1443859782-16773-1-git-send-email-sudipm.mukherjee@gmail.com>
References: <1443859782-16773-1-git-send-email-sudipm.mukherjee@gmail.com>
Date: Sun, 4 Oct 2015 22:37:45 -0400
Message-ID: <CAPoiz9x4sE8JJujuXCagdOu-xY57OUmk_bOXj69ZAZyRT+9jPw@mail.gmail.com>
Subject: Re: [PATCH 1/2] NTB: fix access of free-ed pointer
From: Jon Mason <jdmason@kudzu.us>
Content-Type: text/plain; charset=UTF-8
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Sat, Oct 3, 2015 at 4:09 AM, Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
> We were accessing nt->mw_vec after freeing it. Fix the error path so
> that we free nt->mw_vec after we have finished using it.
>
> Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>

Good catch.  Pulled into my ntb branch.

Thanks,
Jon


> ---
>  drivers/ntb/ntb_transport.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 6e3ee90..69953ee 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -1080,7 +1080,7 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
>                                   GFP_KERNEL, node);
>         if (!nt->qp_vec) {
>                 rc = -ENOMEM;
> -               goto err2;
> +               goto err1;
>         }
>
>         if (nt_debugfs_dir) {
> @@ -1092,7 +1092,7 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
>         for (i = 0; i < qp_count; i++) {
>                 rc = ntb_transport_init_queue(nt, i);
>                 if (rc)
> -                       goto err3;
> +                       goto err2;
>         }
>
>         INIT_DELAYED_WORK(&nt->link_work, ntb_transport_link_work);
> @@ -1100,12 +1100,12 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
>
>         rc = ntb_set_ctx(ndev, nt, &ntb_transport_ops);
>         if (rc)
> -               goto err3;
> +               goto err2;
>
>         INIT_LIST_HEAD(&nt->client_devs);
>         rc = ntb_bus_init(nt);
>         if (rc)
> -               goto err4;
> +               goto err3;
>
>         nt->link_is_up = false;
>         ntb_link_enable(ndev, NTB_SPEED_AUTO, NTB_WIDTH_AUTO);
> @@ -1113,17 +1113,16 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
>
>         return 0;
>
> -err4:
> -       ntb_clear_ctx(ndev);
>  err3:
> -       kfree(nt->qp_vec);
> +       ntb_clear_ctx(ndev);
>  err2:
> -       kfree(nt->mw_vec);
> +       kfree(nt->qp_vec);
>  err1:
>         while (i--) {
>                 mw = &nt->mw_vec[i];
>                 iounmap(mw->vbase);
>         }
> +       kfree(nt->mw_vec);
>  err:
>         kfree(nt);
>         return rc;
> --
> 1.9.1
>
