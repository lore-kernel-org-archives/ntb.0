Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CF8AD49
	for <ntb@lists.linux.dev>; Tue,  7 Mar 2023 16:26:31 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id cw28so54626723edb.5
        for <ntb@lists.linux.dev>; Tue, 07 Mar 2023 08:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678206389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1gyN0Y9p8hJ4ax2W78FF1WA4EkbsuVJwY8Lp0RHjxAk=;
        b=XS3J9PKMVkp2llI3EniM5oVARXgLfq8B27XoVNkPr9G/6Dr14z6EOEiDHeM0ivzwI7
         aMzhtEsZG5dszunTWKFDmpH0BqHtJhXW2Rvj0iqHi/CL13Bmq3uU9nus9AAJbg12k9g3
         b91HMCrHEs6F+AOL4+ONelPHAw8pMm50VAt+W+iwD86cRNkHs90WDqwkIGbE6b+tePcD
         9pqDLDsrhCuC0vXJusPNfo+RJ6n+IYRvAUM+QpZwr4GqgPJF5Eo2KpkNP6gPtUCBGs+e
         LObE95EN/a5f7DJdKajPZW8Zt9gZh9+vC1PNxyK5R0pPIOEkh9dBrCOXr9qa8U6Tjd60
         OKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678206389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1gyN0Y9p8hJ4ax2W78FF1WA4EkbsuVJwY8Lp0RHjxAk=;
        b=bPAKlP0Io2JHPrWYD56KCOPN1ybB4bYug02dks0DKwT+xGl/kS3LJq5cns6/6ntA8e
         WJjb83UYUlQ6ZSEbRPz5wVx0T6nEw7khLUB+GrSIpAnqHcB6LI6jIemxlIxtl+RboOVK
         6k2Ns/BYMtRU51MpE1yZ0mwQgv/XChZkAGuekKVDIuXiMJtF6wdlnIs16Se/64zKFCN2
         aOoqpcPfFaS/1ZewJAThrljAaUntpJNNYsQr7uBIq+f8YgeBHwSVpUQRVqfrkjzKGDKQ
         Z4AwRnVDNz0AaJnGCuZl31hMtK/DdgVclT1UXTd15EY49C5qEmmbv6SbKgJPve5krWqW
         KnbQ==
X-Gm-Message-State: AO0yUKVRH+dOTs8Xx/5IrxfrUdQMJJ4kgrHcAon/sIi6V9cjxU2+y0Pa
	ikiQRYfkne11c1jzLmhOJGiyv+I6Nt1aXJOuivc=
X-Google-Smtp-Source: AK7set+MKhM5nzwXvuYxHTjDStwp5VRKkrpFSwuzzH15A+TQ1olYMZoJ9YWSvbiN8Oe2+lhRulwR/yvpLoNDaBmGhoE=
X-Received: by 2002:a17:906:ce38:b0:8b1:30da:b585 with SMTP id
 sd24-20020a170906ce3800b008b130dab585mr7545049ejb.6.1678206389353; Tue, 07
 Mar 2023 08:26:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230306152810.ptb622tfhoxehhdc@mobilestation>
 <20230307122021.1569285-1-void0red@gmail.com> <e4ac3d74-9a91-e4ff-eee3-67237f35ac7b@intel.com>
In-Reply-To: <e4ac3d74-9a91-e4ff-eee3-67237f35ac7b@intel.com>
From: Kang Chen <void0red@gmail.com>
Date: Wed, 8 Mar 2023 00:26:17 +0800
Message-ID: <CANE+tVo98AZuRGcAshv5W6v2+fKjTruDVRRdgjfyAVk93cC3_g@mail.gmail.com>
Subject: Re: [PATCH v2] ntb_tool: check null return of devm_kcalloc in tool_init_mws
To: Dave Jiang <dave.jiang@intel.com>
Cc: fancer.lancer@gmail.com, allenbh@gmail.com, jdmason@kudzu.us, 
	linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

What a cool tool, thanks for your suggestions.

On Wed, Mar 8, 2023 at 12:06=E2=80=AFAM Dave Jiang <dave.jiang@intel.com> w=
rote:
>
>
>
> On 3/7/23 5:20 AM, Kang Chen wrote:
> > devm_kcalloc may fails, tc->peers[pidx].outmws might be null
> > and will cause null pointer dereference later.
> >
> > Fixes: 7f46c8b3a552 ("NTB: ntb_tool: Add full multi-port NTB API suppor=
t")
> > Signed-off-by: Kang Chen <void0red@gmail.com>
> > Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
>
> You forgot to pick up my review tag. I do recommend using the tool 'b4'.
> It picks up all the tags for you and works rather well.
>
> > ---
> > v2 -> v1: add Fixes and Reviewed-by tags
> >
> >   drivers/ntb/test/ntb_tool.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
> > index 5ee0afa62..eeeb4b1c9 100644
> > --- a/drivers/ntb/test/ntb_tool.c
> > +++ b/drivers/ntb/test/ntb_tool.c
> > @@ -998,6 +998,8 @@ static int tool_init_mws(struct tool_ctx *tc)
> >               tc->peers[pidx].outmws =3D
> >                       devm_kcalloc(&tc->ntb->dev, tc->peers[pidx].outmw=
_cnt,
> >                                  sizeof(*tc->peers[pidx].outmws), GFP_K=
ERNEL);
> > +             if (tc->peers[pidx].outmws =3D=3D NULL)
> > +                     return -ENOMEM;
> >
> >               for (widx =3D 0; widx < tc->peers[pidx].outmw_cnt; widx++=
) {
> >                       tc->peers[pidx].outmws[widx].pidx =3D pidx;
