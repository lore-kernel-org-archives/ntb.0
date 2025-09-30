Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B512BCF4A
	for <ntb@lists.linux.dev>; Tue, 30 Sep 2025 06:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759215067; cv=none; b=Y9sOLfyl9xqAizoyANBqJlmQbYWnIGzuqm5BLsHPfZkcf6Agg4bf14HkBk70H/egt68JyrxuUtJm0a0C8hmPH031SViCExCB5yKTX1Pndr4rFnJqYRhtbUlUmaMbGDDZqmMo5LRXN4WuMs9nNyI+WNqdZvU0HcRWJmaJjuP74CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759215067; c=relaxed/simple;
	bh=QuKU6InmvBPlK5tmaJn1Vy4p1SVmh7nLnic7bLw69X8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cWT4AWxdXo3sCoTvBYxnWa/jTi9Cj1fLfQuEdWbQg7hNC95DQ42NvgKmpeFBm0jMgXrtbVI25y/xFoKlOxpZuIPuZyoeNNUtLwUEHMt64iKxHkbX7C9lhJrQosIOJAI/61M7LsaSXZ2ZD5Ik3lSMTmB3mZ8bLIZxF2H8Rzne4xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZiqsQW9; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZiqsQW9"
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-62ec5f750f7so8159355a12.3
        for <ntb@lists.linux.dev>; Mon, 29 Sep 2025 23:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759215063; x=1759819863; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xVNXZw775c2Js71zktA/SBezJeedYDwOHGneKmoyTVk=;
        b=QZiqsQW9hayss83CPcxyQOI9QYBov976zxOklnBwHrm6UxnF5pwr9pF4M0l/kaQGOm
         q2WhDgLmT6GGWYbMAEGYCbksCFQc9CvKxRtEUP4ktUgAsXhn6Wl1gwIxhItLBjv5Wn1Z
         lt//s6xYcfVvBIE3v87+9jVvCDEGtySMsekqstNQXHwbjLH2l2w3XhYUCaIvx6IXEUX0
         Sb9E/tSBLGucB4A5SdoYJcbxM1HLhRg8hyzz0DFoKa+bS4uz2m3PpANvd2H0t8Xji880
         KBkpULmuOgnQfD2D+9QrVHmkS0jnBkcXiz2TFbdJhuARHmOCLDeRZPSsK3Ja4QjCBkee
         6e3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759215063; x=1759819863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xVNXZw775c2Js71zktA/SBezJeedYDwOHGneKmoyTVk=;
        b=GVkwKWqhFj6kIevK9LQIEtQUn7pb3HGLKTg/NajtqxB1iUCSTPQdKvqxV45zBqesSd
         UbpZ5EQ1W+6UNy+tU2mFLjG+LZaaawSJUzhHBu0KHc8TSxNpNN7UDi1OpZGi7ABEPAYR
         59bDVkBit0iMp0D5SjXwzi6Z5KM7PYKt5hbCQur1IYW+5xxmQCDiXwzowG25Ab12g/hf
         9TX24gJmU5X4ZLqt1Ocm6v8J5N2Ipy4alZ9S6pNSBmzTpGfPwdDeRiQVYZY1h8cNlJir
         69uXPqcegSUXN0jdz8LboOecixJdFo97KoICSHug5iLf6wOPlTyc5wKcchalMoPXDRJg
         JXXA==
X-Forwarded-Encrypted: i=1; AJvYcCVuyamV+G/Ub5rFIIscWMVrBf4U/XGjyepiK7We42YOcPPNhXyM5Zd9yUsDqzsxDZa/sUI=@lists.linux.dev
X-Gm-Message-State: AOJu0YwzeCTyp/Hjevn6Rgk8UC0vC96PLQjrv73oIRSYJ8osemErXNVg
	cue1PN4x9TII2km+XrTwQL1jLvpNeKGHSh6VBuEy1wUEdqbaRiiZyykbMP+yDAYTeihscQBI6/L
	AlSZq2mpEIqOt1SjL3NQvyc6usHRCeM9K8sNrxQ==
X-Gm-Gg: ASbGncuCt6IVXABz1785Tse6mUEVGXCEM5tq37htJz/g2P+VCpYJJVBTE3mYZjxDSdx
	YCzwMshPCC+94XsbDj3fEFVzgxiJJfcog7oL+df0kfEl0MuJKNIFi+S50/MU/YgcDg0t6F9NipK
	1TSTKeUWaMA9tWnJngIiZ6v5Xnop61+3KXeVPR62sFkHdN2fGZvf01uuRFCvGROrDGX3YB0OY24
	JCzQHrKPnhx4vY2IbN74BKUbwv4PQ==
X-Google-Smtp-Source: AGHT+IEXSWGf6sD3vo7rf9EQ6i9O9UJK5AOiX0IqobrI8JkX5Gc6scxof3vXuUDm37WJvIfDO2cxBPjjf6V2BYq4PYs=
X-Received: by 2002:a17:907:971b:b0:b3c:a161:684c with SMTP id
 a640c23a62f3a-b3ca1617ce7mr943624266b.2.1759215063208; Mon, 29 Sep 2025
 23:51:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <aKwpnFtdtBlDv69O@didi-ThinkCentre-M930t-N000>
In-Reply-To: <aKwpnFtdtBlDv69O@didi-ThinkCentre-M930t-N000>
From: yuanli fu <fuyuanli0722@gmail.com>
Date: Tue, 30 Sep 2025 14:50:52 +0800
X-Gm-Features: AS18NWA0IfkM4D9WprNelBpW7fL-eSZ2hdWPleHyjbG7Hx95fmcgy3a8WlR9DDU
Message-ID: <CABbqxmfMLAFT8vMeCz4dXY5RfgZ-65VYXZm+P1-sO_pqKR-sPw@mail.gmail.com>
Subject: Re: [PATCH v2] ntb: Add mutex to make link_event_callback executed linearly.
To: jdmason@kudzu.us
Cc: dave.jiang@intel.com, allenbh@gmail.com, ntb@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jon

just a gentle ping on patch, Is there anything else needed from my side?
Thank you!

Best regards,
Yuanli Fu

fuyuanli <fuyuanli0722@gmail.com> =E4=BA=8E2025=E5=B9=B48=E6=9C=8825=E6=97=
=A5=E5=91=A8=E4=B8=80 17:15=E5=86=99=E9=81=93=EF=BC=9A
>
> Since the CPU selected by schedule_work is uncertain, multiple link_event
> callbacks may be executed at same time. For example, after peer's link is
> up, it is down quickly before local link_work completed. If link_cleanup
> is added to the workqueue of another CPU, then link_work and link_cleanup
> may be executed at the same time. So add a mutex to prevent them from bei=
ng
> executed concurrently.
>
> Signed-off-by: fuyuanli <fuyuanli@didiglobal.com>
> ---
> v2:
> 1) use guard() instead of lock & unlock functions.
>
> v1:
> Link: https://lore.kernel.org/all/aKiBi4ZDlbgzed%2Fz@didi-ThinkCentre-M93=
0t-N000/
> ---
>  drivers/ntb/ntb_transport.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 4f775c3e218f..eb875e3db2e3 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -59,6 +59,7 @@
>  #include <linux/slab.h>
>  #include <linux/types.h>
>  #include <linux/uaccess.h>
> +#include <linux/mutex.h>
>  #include "linux/ntb.h"
>  #include "linux/ntb_transport.h"
>
> @@ -241,6 +242,9 @@ struct ntb_transport_ctx {
>         struct work_struct link_cleanup;
>
>         struct dentry *debugfs_node_dir;
> +
> +       /* Make sure workq of link event be executed serially */
> +       struct mutex link_event_lock;
>  };
>
>  enum {
> @@ -1024,6 +1028,7 @@ static void ntb_transport_link_cleanup_work(struct =
work_struct *work)
>         struct ntb_transport_ctx *nt =3D
>                 container_of(work, struct ntb_transport_ctx, link_cleanup=
);
>
> +       guard(mutex)(&nt->link_event_lock);
>         ntb_transport_link_cleanup(nt);
>  }
>
> @@ -1047,6 +1052,8 @@ static void ntb_transport_link_work(struct work_str=
uct *work)
>         u32 val;
>         int rc =3D 0, i, spad;
>
> +       guard(mutex)(&nt->link_event_lock);
> +
>         /* send the local info, in the opposite order of the way we read =
it */
>
>         if (nt->use_msi) {
> --
> 2.34.1
>
