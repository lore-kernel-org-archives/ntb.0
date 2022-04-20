Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170BD10ED
	for <ntb@lists.linux.dev>; Wed, 20 Apr 2022 08:46:41 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id g18so2016716ejc.10
        for <ntb@lists.linux.dev>; Wed, 20 Apr 2022 01:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QArLsIT6s7ntTWKM79ixwz9SubeDVO+01rJZYCmJhAI=;
        b=OsIBgFMwkBRs8Cs9x6FSqYpOYCxffAMrLFyciN8d4alWeBg0B3naUc5D4lFt/Zy5Z9
         oxz4hmz/fUARL5SRiGrU028x2VvNTvV/TBWLe1Q/FYgxlrp1wdw+oMovghLTMQBmUkoc
         t9MRNC/qpOZo7ivU/O8sfIN/GdojfxQ/EBbgVbG7RDOJ3Vwe3LAwR87JZD2Cxg3RtiQ+
         dCnuIJnxIAwyOyoAyZBlBipC7Grg5tMl/6yhiA7djiSTZ66M/CqoiretBkcZ8n+bloU5
         LY5FImBBanm5ZjvtSm4jLVzdtXO/yr2/RHHXZpsjl2SaFS3+um/PgcSfDuQC1WnNg3Ki
         OT6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QArLsIT6s7ntTWKM79ixwz9SubeDVO+01rJZYCmJhAI=;
        b=HhYbUAXueH7Hxsrv8P8IpAed56zphAoVjUeHLLNfqSSlte2uhjyEjX68k7oKaepoJ2
         wjOPF2FhcB91WqHC7i1rQy1reFxLYIbEyz9BPnt5GpfcIqXPf4+JLmrrDziQw8tbs8IU
         54OMuK9OVT2hGEVTWgHwEhQd91ozuR4N/XEtfIkMzT6t9v6Q0Xs8f5D5Vc83pti0SM/s
         +Q++8ipCFE2HWO8pl4xwRQH/r9tt6FLLhS2bjKjLCIjyhTzdB2tjybKZtsEICYIT96LA
         HBDaRvRN9jYEb1zXQ5T+Zbkb6VsXazG3OR3IQrVveHsEm0goNODqf/o4KnRCMqnCBKLo
         qDkg==
X-Gm-Message-State: AOAM5322IXoFJUISxgb/yC3uu+R8hLk70eJS5cVPDGmTqttTmaaN1FJn
	4dMhninhZPamF/Xsqi4sRfpYBkpyKiH3W6ZMk4Q=
X-Google-Smtp-Source: ABdhPJxDX2Ox5D1qveJJ6puhBQK4jNgpG+yRgcrayoM/GjnIN4VQYO0yVUePdYt8VF0a6RX+J3+SnMl5GmeYMKU8AZg=
X-Received: by 2002:a17:907:7f9f:b0:6ef:a120:4ea6 with SMTP id
 qk31-20020a1709077f9f00b006efa1204ea6mr13428222ejc.607.1650444400170; Wed, 20
 Apr 2022 01:46:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220419071855.23338-1-guozhengkui@vivo.com> <7cb4d3be-925f-05bd-78fe-67a69dfee18d@deltatee.com>
In-Reply-To: <7cb4d3be-925f-05bd-78fe-67a69dfee18d@deltatee.com>
From: Alexander Fomichev <fomichev.ru@gmail.com>
Date: Wed, 20 Apr 2022 11:46:28 +0300
Message-ID: <CAEKnZG4qTOn8mbTNPaaHbkttnfLz9Nc88DpCcm84T32hiPA5uQ@mail.gmail.com>
Subject: Re: [PATCH] ntb_perf: fix doubletest cocci warning
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Guo Zhengkui <guozhengkui@vivo.com>, Jon Mason <jdmason@kudzu.us>, 
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, Serge Semin <fancer.lancer@gmail.com>, 
	"open list:NTB DRIVER CORE" <ntb@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>, 
	zhengkui_guo@outlook.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, nice catch.
I'll include it into the next patch version.

Regards,
Alexander.

=D0=B2=D1=82, 19 =D0=B0=D0=BF=D1=80. 2022 =D0=B3. =D0=B2 18:50, Logan Gunth=
orpe <logang@deltatee.com>:
>
>
>
> On 2022-04-19 01:18, Guo Zhengkui wrote:
> > `!data->ops.init` has been repeated triple. The original logic is to
> > check whether `.init`, `.run` and `.clear` callbacks are NULL or not.
> >
> > Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
>
> This appears to be a patch against Alexander's patch which has not been
> accepted yet. Posting a note on his patch so he fixes it for the next
> posting would be preferable.
>
> Logan
>
> > ---
> >  drivers/ntb/test/ntb_perf.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
> > index c106c3a5097e..dcae4be91365 100644
> > --- a/drivers/ntb/test/ntb_perf.c
> > +++ b/drivers/ntb/test/ntb_perf.c
> > @@ -1451,7 +1451,7 @@ static void perf_ext_lat_work(struct work_struct =
*work)
> >  {
> >       struct perf_ext_lat_data *data =3D to_ext_lat_data(work);
> >
> > -     if (!data->ops.init || !data->ops.init || !data->ops.init) {
> > +     if (!data->ops.init || !data->ops.run || !data->ops.clear) {
> >               struct perf_ctx *perf =3D data->perf;
> >
> >               data->status =3D -EFAULT;
