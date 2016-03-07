Return-Path: <jdmason@kudzu.us>
Received: from mail-vk0-x244.google.com (mail-vk0-x244.google.com. [2607:f8b0:400c:c05::244])
        by gmr-mx.google.com with ESMTPS id c66si566019vkf.0.2016.03.07.05.47.33
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Mar 2016 05:47:33 -0800 (PST)
Received: by mail-vk0-x244.google.com with SMTP id e6so8923133vkh.1
        for <linux-ntb@googlegroups.com>; Mon, 07 Mar 2016 05:47:33 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20160229163526.199357.42464.stgit@djiang5-desk3.ch.intel.com>
References: <20160229163526.199357.42464.stgit@djiang5-desk3.ch.intel.com>
Date: Mon, 7 Mar 2016 08:47:32 -0500
Message-ID: <CAPoiz9ypp+ObzWXKr8mxKEggcMHGnUqhNvqQ3wjhWQNFOLygPw@mail.gmail.com>
Subject: Re: [PATCH v2] ntb: stop link work when we do not have memory
From: Jon Mason <jdmason@kudzu.us>
Content-Type: text/plain; charset=UTF-8
To: Dave Jiang <dave.jiang@intel.com>
Cc: "Hubbe, Allen" <allen.hubbe@emc.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Mon, Feb 29, 2016 at 11:35 AM, Dave Jiang <dave.jiang@intel.com> wrote:
> Instead of keep trying to go through the init routine when we aren't able
> to allocate memory, we should just stop and go down.

Applied.  Thanks!

>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/ntb/ntb_transport.c |    9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 06d4e58..a44fb09 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -829,7 +829,7 @@ static void ntb_transport_link_work(struct work_struct *work)
>         struct pci_dev *pdev = ndev->pdev;
>         resource_size_t size;
>         u32 val;
> -       int rc, i, spad;
> +       int rc = 0, i, spad;
>
>         /* send the local info, in the opposite order of the way we read it */
>         for (i = 0; i < nt->mw_count; i++) {
> @@ -899,6 +899,13 @@ static void ntb_transport_link_work(struct work_struct *work)
>  out1:
>         for (i = 0; i < nt->mw_count; i++)
>                 ntb_free_mw(nt, i);
> +
> +       /* if there's an actual failure, we should just bail */
> +       if (rc < 0) {
> +               ntb_link_disable(ndev);
> +               return;
> +       }
> +
>  out:
>         if (ntb_link_is_up(ndev, NULL, NULL) == 1)
>                 schedule_delayed_work(&nt->link_work,
>
> --
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/20160229163526.199357.42464.stgit%40djiang5-desk3.ch.intel.com.
> For more options, visit https://groups.google.com/d/optout.
