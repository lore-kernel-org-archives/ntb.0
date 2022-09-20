Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85867C
	for <ntb@lists.linux.dev>; Tue, 20 Sep 2022 10:13:00 +0000 (UTC)
Received: by mail-lf1-f42.google.com with SMTP id a3so2913226lfk.9
        for <ntb@lists.linux.dev>; Tue, 20 Sep 2022 03:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=Kj8G7tQXp3dB2CskDYDfYJI+6PpZ7oU+0ic/ZP4IQy4=;
        b=VTTlqqsAIS6WArmTLHA68hWn7TJ4vlFNMWzhSyFGAYhOfla3D27i4EMKgcppiv4eO2
         fnXiXx5JyOSyxf8pZa11wyl0A1bZaIlby15dkwXlzbTaRD7i1YMKKo8PUdVDVvvkdh1e
         mZhQgEj3rT4OGkPhmf85Dwla6Fsts7du69InDTEpiqcC43HftCmXlF545MstqA0/+dQF
         hZ05hv0ZUkGOO7Ul+VpjE+0ULdV41Jv99aqtPz0RXwmDV74ZItMF5v1onlDmb82AQsLO
         uJzfhh3l8GhpWSM6LkaSo02AhRVIUjQ66ghKx+WCL3vXLVX22CEKJAh2Sp//c3JHE/st
         6HbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Kj8G7tQXp3dB2CskDYDfYJI+6PpZ7oU+0ic/ZP4IQy4=;
        b=0M2W4KHiLoW/G9toUvlAIN23Ldhzl9W+9M2HxOQeJOdImSvh6SKBZG46qjgVh+T2n3
         KpRSphNyp5NhJRyZxGAx9ktMrtjCWml8h/nFWv657su5b/y3dMVsfe1eJzcgE7UjGbyN
         b2Cv8HcVs3TaXFdXo07eFhfNYEx7hpg4I6Btoib1LkfFo8LCCs8zCw602B4A8lurbvRG
         8aC0BOYHUzu6Z/xTU/HUjGKlTmi2hG8HOAgrS61iJlopfofQMYNm7UXRkm28CPb2o+Br
         Fwf3wMHOiPbobcIIEfE6qx2KaRZJi4lPgZa8CEywDwADji3QsdBcBi6ivAwp6Lc3dGua
         2S9A==
X-Gm-Message-State: ACrzQf057wJqQVgGrtGmU8G3DNOzTvMfWjf8Dxfa31WdUFV+mvg7cfDN
	SfivJP9+A1TDBHjQxjDj1EU9eyeGD8VwodfCcOJVXg==
X-Google-Smtp-Source: AMsMyM7lM95/SWWgu+uEQ5wpzRiVAE+KO6sg3f85kueFZza2jw62yeG4FNCpANipI6vltZ8i4/+KJBjvx/FkixK4Ce8=
X-Received: by 2002:a05:6512:3183:b0:498:fa29:35fe with SMTP id
 i3-20020a056512318300b00498fa2935femr7658789lfe.523.1663668778693; Tue, 20
 Sep 2022 03:12:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220916075651.64957-1-mie@igel.co.jp> <20220919185545.GA1022691@bhelgaas>
In-Reply-To: <20220919185545.GA1022691@bhelgaas>
From: Shunsuke Mie <mie@igel.co.jp>
Date: Tue, 20 Sep 2022 19:12:47 +0900
Message-ID: <CANXvt5oWtyh8KiEpk2Ad1sbn9e8FNoy3A99k+xkoujOFA3DhdA@mail.gmail.com>
Subject: Re: [PATCH] PCI: endpoint: pci-epf-{,v}ntb: fix a check for no epc
 alignment constraint
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, Kishon Vijay Abraham I <kishon@ti.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2022=E5=B9=B49=E6=9C=8820=E6=97=A5(=E7=81=AB) 3:55 Bjorn Helgaas <helgaas@k=
ernel.org>:
>
> On Fri, Sep 16, 2022 at 04:56:51PM +0900, Shunsuke Mie wrote:
> > Some pci endpoint controllers has not alignment constraint, and the
>
> s/pci/PCI/
> s/has not/have no/
> s/constraint/constraints/
>
> > epc_features->align becomes 0. In this case, IS_ALIGNED() in
> > epf_ntb_config_spad_bar_alloc() doesn't work well. So this patch adds t=
he 0
> > checking before the IS_ALIGNED().
>
> s/So this patch adds .../Check for this before IS_ALIGNED()/
Thank you. I'll fix these.
>
> > Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
> > ---
> >  drivers/pci/endpoint/functions/pci-epf-ntb.c  | 2 +-
> >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-ntb.c b/drivers/pci=
/endpoint/functions/pci-epf-ntb.c
> > index 9a00448c7e61..f74155ee8d72 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-ntb.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-ntb.c
> > @@ -1021,7 +1021,7 @@ static int epf_ntb_config_spad_bar_alloc(struct e=
pf_ntb *ntb,
> >       peer_size =3D peer_epc_features->bar_fixed_size[peer_barno];
> >
> >       /* Check if epc_features is populated incorrectly */
> > -     if ((!IS_ALIGNED(size, align)))
> > +     if (align && (!IS_ALIGNED(size, align)))
> >               return -EINVAL;
> >
> >       spad_count =3D ntb->spad_count;
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pc=
i/endpoint/functions/pci-epf-vntb.c
> > index 0ea85e1d292e..5e346c0a0f05 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > @@ -418,7 +418,7 @@ static int epf_ntb_config_spad_bar_alloc(struct epf=
_ntb *ntb)
> >       size =3D epc_features->bar_fixed_size[barno];
> >       align =3D epc_features->align;
> >
> > -     if ((!IS_ALIGNED(size, align)))
> > +     if (align && !IS_ALIGNED(size, align))
> >               return -EINVAL;
> >
> >       spad_count =3D ntb->spad_count;
> > --
> > 2.17.1
> >

Best,
Shunsuke
