Return-Path: <jdmason@kudzu.us>
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com. [2607:f8b0:4864:20::d43])
        by gmr-mx.google.com with ESMTPS id j21si1406398pfe.5.2019.09.10.09.42.20
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2019 09:42:20 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id d25so39056645iob.6
        for <linux-ntb@googlegroups.com>; Tue, 10 Sep 2019 09:42:20 -0700 (PDT)
MIME-Version: 1.0
References: <1553859137-4439-1-git-send-email-Sanju.Mehta@amd.com> <MN2PR12MB3455BFCFE060E38FEDF686E1E52E0@MN2PR12MB3455.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB3455BFCFE060E38FEDF686E1E52E0@MN2PR12MB3455.namprd12.prod.outlook.com>
From: Jon Mason <jdmason@kudzu.us>
Date: Tue, 10 Sep 2019 17:42:12 +0100
Message-ID: <CAPoiz9wqa4zhhitBeu8XDvOckhVWpEviPdk=UTCh-pLUvk9QvQ@mail.gmail.com>
Subject: Re: [PATCH] point to right memory window index
Content-Type: text/plain; charset="UTF-8"
To: "Mehta, Sanju" <Sanju.Mehta@amd.com>
Cc: "dave.jiang@intel.com" <dave.jiang@intel.com>, "allenbh@gmail.com" <allenbh@gmail.com>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>
List-ID: <linux-ntb.googlegroups.com>

On Wed, Apr 10, 2019 at 11:24 AM Mehta, Sanju <Sanju.Mehta@amd.com> wrote:
>
> Hi All,
>
> Any comments on below patch?

I wasn't cc'ed, so this one missed my inbox.  Applied to ntb-next, thanks.

>
> Thanks & Regards,
> Sanjay Mehta
>
> -----Original Message-----
> From: Mehta, Sanju <Sanju.Mehta@amd.com>
> Sent: Friday, March 29, 2019 5:03 PM
> To: S-k, Shyam-sundar <Shyam-sundar.S-k@amd.com>; jdmason@kudzu.us; dave.jiang@intel.com; allenbh@gmail.com
> Cc: linux-ntb@googlegroups.com; linux-kernel@vger.kernel.org; Mehta, Sanju <Sanju.Mehta@amd.com>
> Subject: [PATCH] point to right memory window index
>
> From: Sanjay R Mehta <sanju.mehta@amd.com>
>
> second parameter of ntb_peer_mw_get_addr is pointing to wrong memory window index by passing "peer gidx" instead of "local gidx".
>
> For ex, "local gidx" value is '0' and "peer gidx" value is '1', then
>
> on peer side ntb_mw_set_trans() api is used as below with gidx pointing to local side gidx which is '0', so memroy window '0' is chosen and XLAT '0'
> will be programmed by peer side.
>
>     ntb_mw_set_trans(perf->ntb, peer->pidx, peer->gidx, peer->inbuf_xlat,
>                     peer->inbuf_size);
>
> Now, on local side ntb_peer_mw_get_addr() is been used as below with gidx pointing to "peer gidx" which is '1', so pointing to memory window '1'
> instead of memory window '0'.
>
>     ntb_peer_mw_get_addr(perf->ntb,  peer->gidx, &phys_addr,
>                         &peer->outbuf_size);
>
> So this patch pass "local gidx" as parameter to ntb_peer_mw_get_addr().
>
> Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
> ---
>  drivers/ntb/test/ntb_perf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c index c7d1a48..08e18d7 100644
> --- a/drivers/ntb/test/ntb_perf.c
> +++ b/drivers/ntb/test/ntb_perf.c
> @@ -1381,7 +1381,7 @@ static int perf_setup_peer_mw(struct perf_peer *peer)
>         int ret;
>
>         /* Get outbound MW parameters and map it */
> -       ret = ntb_peer_mw_get_addr(perf->ntb, peer->gidx, &phys_addr,
> +       ret = ntb_peer_mw_get_addr(perf->ntb, perf->gidx, &phys_addr,
>                                    &peer->outbuf_size);
>         if (ret)
>                 return ret;
> --
> 2.7.4
>
