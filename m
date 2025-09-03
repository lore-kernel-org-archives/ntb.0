Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47B02AF00
	for <ntb@lists.linux.dev>; Wed,  3 Sep 2025 02:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756866050; cv=none; b=UKr/5a2yu47ZTR0qUVRPjhECsu2Ul4ZCywOUZ+uR0EmAIlabs+W5r2PfJnIcDS2dkUO7cX+IaSYRsF9Ews6qJ5YCML5U/G5YAfbM76MqhW9pkydsCnbj5lvoqK0sBrBgwN6Mb4S1GbK2gQGHJMPUKWdQ3kQrp7bYiWE+rAly4n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756866050; c=relaxed/simple;
	bh=DnWnFqNhE95DJq5W/8mxcJr3OyjwwtDpJjN+VfxI/tc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S9wlYuUS4g3s1IYf9zEE2VO9+IGS55uxgN0u5sWv4buJx0XVrrb+k8Ms0oFOPw+AZ9niyuzrk9Xhn5kwnvp+tF2nQpBfEymCB7/I7azNMyAR6gO6NP5Wazvx4ZQeHX6cLvMj6mrh3XW/q1iLPhNSG6sA4O0fXxgy7IOvKn8INjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CoBYPevB; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CoBYPevB"
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-b0225483ca0so628116266b.2
        for <ntb@lists.linux.dev>; Tue, 02 Sep 2025 19:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756866047; x=1757470847; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/70R56Z9K+3RS357Qzbv1U5VUL/YzpdkZBjEBEQaFk=;
        b=CoBYPevBrFPmIVUrxkmamvHfbi3Tq3bQ6KWQx27737emM7IneAfWBW3nLkXoOosQPu
         Dj3cYFWIP9ltbWV75yC7qZkcqHLZ9aZkkdKHMwLP0o7QjrxzOJJPxtVMVlJfSGOmUvis
         5EwOetNXsDE5mR+5Eu0tVIY8vK+8XKW4RClULhPcWefEp3YhOvsXfPl2fZ8WQcCcfDoq
         dEYbnBLfAJlX43kWIyMQcQYmtXx2kCkXWe6nKOtTlOC9EjppQAE+4djJ5lz41G4kZh04
         GV9p6EHU0yRLXcepj0xBji/25kmZu0RbgmE2KXcYeMOUEvYs8/tNta/MTLSmwQdqsTNG
         0ZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756866047; x=1757470847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/70R56Z9K+3RS357Qzbv1U5VUL/YzpdkZBjEBEQaFk=;
        b=EaLQ41clT7mWSETdtw1yneKYlmFgy2uJ98XNixGVKu2092+BfK2YPnyYe+RdRczn1q
         IF45lswnaPUWxwv4rGbW11vRU+8gKmZnIYo77VCGnVlgxRPzyLR6DgY+laFYJSuotVoz
         ws8G3MW1RTxXL3/DYjipznUVf/5MgMH8vvlzs8HH73mhQqtQvEDMP5Hb3dbY4vaopdRB
         /xdAjPxcSBbhYxafTbfSBtZ3DMAkoxbm5xVjXcvY2Qb+pVFqq0FsqxkO8ajF5lclXcw9
         ZYP6KSiWHoM4I7DVl+Jpvji9IvwOl/QGGH4kZBgCUm9cdZhlsPoEHUTLexC5m77msPvk
         PZCg==
X-Forwarded-Encrypted: i=1; AJvYcCWaysHc1+4redAAp84kMbLbnh614rbYfUiDiYpn8OD6FPSsEZE0WPGcJx2nFV8cHgr3IqM=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz/Pb62HvEInmOWBFzGwnWQYUPOjpp3YH2hKwSvlt17Vq8frgTF
	imjCiAnTavQv9BrkYaOprz6K7gNaPmZLkurT5Mq32VUwfyRxeoQgVSbIZP69YCQ1OvmyMsREgH1
	u4FLcOele5kZWj3M0BieCM93HAJ2Tug==
X-Gm-Gg: ASbGnctCb4I8DbsLrmtPfDo21zfpTyygPp6tgHMQ3rYR+HiAKLixXUOnFc984WqFQjs
	qPvvVfFEufgW4NbNI93p71bKsq084O+pGiz7pL36YaHIURgRv80YQ0Ve5FlgD9gDCLy7pIxWsdd
	py27b1yYRZRHuv9HwDepgfK02G4oP+MLIjSzPgMtTPT+WM9vr/f9KkOaKo/kg8hg0RD0DTE9kFJ
	Xx04Q==
X-Google-Smtp-Source: AGHT+IHmu98fbG+D9HV47qFCZHXVCXT/ybu3qrOz2yU8u8qNaogplji0a1idlXZ5HIcemxPhoSwFCD/ZIn/QgSiWyvY=
X-Received: by 2002:a17:907:7fac:b0:afe:f9fc:89be with SMTP id
 a640c23a62f3a-b01d8a2fe32mr1392418466b.1.1756866046985; Tue, 02 Sep 2025
 19:20:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <aKwpnFtdtBlDv69O@didi-ThinkCentre-M930t-N000> <483cc0f8-6caa-4124-a724-433ff0d798fa@intel.com>
In-Reply-To: <483cc0f8-6caa-4124-a724-433ff0d798fa@intel.com>
From: yuanli fu <fuyuanli0722@gmail.com>
Date: Wed, 3 Sep 2025 10:20:33 +0800
X-Gm-Features: Ac12FXxUazAw9qplODu8aGIlMVqGbDpS_b406Pv-MWbS9iukSXEPLn4fYjgPqpg
Message-ID: <CABbqxmc+jkpgiHrWb5UH2FRZtaNpe4754qis=cPKtidW6+Vj6Q@mail.gmail.com>
Subject: Re: [PATCH v2] ntb: Add mutex to make link_event_callback executed linearly.
To: Dave Jiang <dave.jiang@intel.com>
Cc: jdmason@kudzu.us, allenbh@gmail.com, ntb@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dave Jiang <dave.jiang@intel.com> =E4=BA=8E2025=E5=B9=B48=E6=9C=8825=E6=97=
=A5=E5=91=A8=E4=B8=80 23:06=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> On 8/25/25 2:15 AM, fuyuanli wrote:
> > Since the CPU selected by schedule_work is uncertain, multiple link_eve=
nt
> > callbacks may be executed at same time. For example, after peer's link =
is
> > up, it is down quickly before local link_work completed. If link_cleanu=
p
> > is added to the workqueue of another CPU, then link_work and link_clean=
up
> > may be executed at the same time. So add a mutex to prevent them from b=
eing
> > executed concurrently.
> >
> > Signed-off-by: fuyuanli <fuyuanli@didiglobal.com>
>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Hi Dave,

Hope you are doing well.

Just wanted to gently follow up on this patch which you had acked
before. Is there
anything else I can do to help get this merged? Perhaps it needs a rebase o=
n a
different tree?

Thanks for your time and all your work!

Best regards,
Yuanli Fu


>
> > ---
> > v2:
> > 1) use guard() instead of lock & unlock functions.
> >
> > v1:
> > Link: https://lore.kernel.org/all/aKiBi4ZDlbgzed%2Fz@didi-ThinkCentre-M=
930t-N000/
> > ---
> >  drivers/ntb/ntb_transport.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> > index 4f775c3e218f..eb875e3db2e3 100644
> > --- a/drivers/ntb/ntb_transport.c
> > +++ b/drivers/ntb/ntb_transport.c
> > @@ -59,6 +59,7 @@
> >  #include <linux/slab.h>
> >  #include <linux/types.h>
> >  #include <linux/uaccess.h>
> > +#include <linux/mutex.h>
> >  #include "linux/ntb.h"
> >  #include "linux/ntb_transport.h"
> >
> > @@ -241,6 +242,9 @@ struct ntb_transport_ctx {
> >       struct work_struct link_cleanup;
> >
> >       struct dentry *debugfs_node_dir;
> > +
> > +     /* Make sure workq of link event be executed serially */
> > +     struct mutex link_event_lock;
> >  };
> >
> >  enum {
> > @@ -1024,6 +1028,7 @@ static void ntb_transport_link_cleanup_work(struc=
t work_struct *work)
> >       struct ntb_transport_ctx *nt =3D
> >               container_of(work, struct ntb_transport_ctx, link_cleanup=
);
> >
> > +     guard(mutex)(&nt->link_event_lock);
> >       ntb_transport_link_cleanup(nt);
> >  }
> >
> > @@ -1047,6 +1052,8 @@ static void ntb_transport_link_work(struct work_s=
truct *work)
> >       u32 val;
> >       int rc =3D 0, i, spad;
> >
> > +     guard(mutex)(&nt->link_event_lock);
> > +
> >       /* send the local info, in the opposite order of the way we read =
it */
> >
> >       if (nt->use_msi) {
>
