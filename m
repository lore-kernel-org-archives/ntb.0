Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7A71DC198
	for <ntb@lists.linux.dev>; Mon, 27 Apr 2026 02:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777255229; cv=pass; b=UXr/dbFJ9ufO0Wy74zFtPJNyLHRzTb4kq1MB3F+Ilz9Wp3VEJVjyhKHq0TNwkfYw8HNbjIj0P3b2jC1QYsjCIq+8zl7F9IJnnOOxS4/PejOg7oRjv2y+GTuG6w7vcD1VDnSXTXQiYmI+wuPlD/BAVyUuEMU2bFvIGDIO5v++bTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777255229; c=relaxed/simple;
	bh=XTcvLGVqRi+xyY7GWE8c+PssvnxyGfo+XrgCHY9FKnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eINbiRSDDWNab6f9kMrk7UhtGCzH1lJizyTfKvAcZZ/TlQP8CmdF2xXzP4I3CK0rw4egOulWiGl8/BahrbxTSXFVTD6JgBJGwA/F1UnoCXeOX+Ch67LG6/TriBBGGbRdoQrPtfbCZv6XLrSG0dMTa4VeU1e3uPPglPe5ymtpchs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fsGvIK6V; arc=pass smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fsGvIK6V"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-38be5e86918so107750821fa.3
        for <ntb@lists.linux.dev>; Sun, 26 Apr 2026 19:00:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777255226; cv=none;
        d=google.com; s=arc-20240605;
        b=YweCDs948OolMSqyMTQoKzKCjLlmbqn9+bhmd9U2VB5fTAEGMmlxBxo5cTUDQJOGYS
         fARkMDFfR+ISBHhSND3F9X7A0e14cb6GAmmTEK9HuEhJs7vXO20iKD+Juwzf/89znmXp
         nY9OtUSeo+z7LJAACWs1OZyZAQujvV2DAA2JaWQhhp1rrhBtz87orwn7i4vXBUxoC9wn
         Y3autPWM78GmUqxUmj9RpCDvjQYPtLOuVIKgnMD0F5Upr7daRYDfIJGq4l3Zc7Gxpibo
         vUo7zzx6Eh2rorxQs8QR52mX3SleipFUFpNR2ICEQK+H5w4pdZW0HcWf0RfPMca55tUD
         0X3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Suwl013w+3TdVex5nWeGuqN4SegFs3PMrP9yQ2sH0ko=;
        fh=ZXNpNDcZvdDQCIToqHvFY1CAqlM6CLD8ZJn1W/nsznE=;
        b=gkhuUlIFWnyRCjsmw7Y7Yi9166coaD6Qk9g4sA3BUETttWbLwxrGHAsMgvP9NxhgW8
         fMCHaAPcY/78LH3rBQGR6SeD69J9KD4HpBK3qVWLUAgdpR+0Zs2SMEIEs0VMpp59jhye
         TjQ3QnXQWIGaQ5XcrH80KMLlI5ED4AM0q/Jr/vNWaAOj7a9ccvvN82CnOuIb4rlBWiMH
         dzZnKX76Ew99Jt7PRirPnLIaHpqUF46SVVvsC3Cr8qCA/4CUtX0gEkC6pNm3cbMWiCCk
         OhllEBy7aD8gNL0SYbqpflfSseFK1v84dEn5POgyLUSJUi0wQceQsUPUXi0lar6/NVBv
         tyIQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777255226; x=1777860026; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Suwl013w+3TdVex5nWeGuqN4SegFs3PMrP9yQ2sH0ko=;
        b=fsGvIK6VpoUdIzkCVcxJ5I2z3S3RjqJKex/NFqrvN27GjwGBXo2l5r1pGX4MdN6/B0
         fMIe//o1mMarHEhWqiitKu1L9YO7X/vV9tgqUSP56CTF7SkaVX2Ur1ePB/nwhte0vh6b
         KP/t6fVZdAorC8MmN87miAoqko5UNQo500aPNZcDphwST9zGENAXjtMcOPjz1/BabjAB
         4Zd4ynbC/4xiWTH50Ip8HOD0nGM1dZQFwyxzl869YFJFftqmt3J0L/xSmgXIkcAjke6e
         rO1jqfSU+X4dlG2w5RpS93heJOl2Sx50WMV3tC/wb8PuEyRq1H/saWM2BPl2xI1rDTJv
         prnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777255226; x=1777860026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Suwl013w+3TdVex5nWeGuqN4SegFs3PMrP9yQ2sH0ko=;
        b=jY5ZsKqOjI8ltd45Ic+TTwaGa7flBgYHwLYPK1GxKoB6wbOAEBI5nVL0CNQSg/cxMK
         20c69Gn77FoPwbY7UG1v4M66fI3cML15ulrrGNIjmqXdG+zrqi0F8yhZp9118+fZtaq2
         7/T3VfsL3jogSSUxWPoMhdNGHi01ocOLkdsomILwDhicxBqozGIdYRjdUh4orDGzcPN0
         EtFwxGdC7yJe9TApIg58Zq8K2wlHC+PXVZc43IvHcBsTuMEQC9tXTukEI1koq9fXA5aV
         Gza0khqNRseW1CvF/nqa5eQtD1jfFstzALlPF95fYMHd0p20+lg/veTYKWNiPA4+zF1U
         /5vA==
X-Forwarded-Encrypted: i=1; AFNElJ8xyDgQIbhkBNuU3L71cbASzLOXXqbxHAo3j0tMORvGdbEkTZ7+LBMJxQS/1yme0BW0Cfw=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz9/9kwaTLcPVK+XyDjPuIqHCvXHxIiwjhyAvIxksrlu7y5Iu44
	TKqhGqjK4JySpcxNsawL50pmP+zTBKtkv5gpXm6wGPaK+bSAC7oR3JW8ayhWSlQVju7PG/xQqjh
	U0h8A34odTmeKCQClt3QXf6xNptyS/gM=
X-Gm-Gg: AeBDies2fPmJhDoro3iplS4VIT/3u3mGGc4NdkZzXfGAwrMCEZVXkrUeUMQv4K/NAuy
	JptsS4deKIpsQ6tKrLvzqQHzlRkQXAdvMBm6N87GtHCp2YsbZRQItF609e+iZwt+o3dUQwKvg/7
	KDciTywscFlTQkkq43JubG+vPN2FhwCSgeQiYmFKz3P+P39UkIkIuC/lQdtHU0iq06Is+tteBWh
	Op2ctyAuMf+MotOF4ShzHiayyLO4lbhRlRgLMziVTXF7JxeBQe97IIPuolHadIIwDQU0XNg2U1K
	AhMbamvxeXNPwVSfvzFC38fjsytWKg==
X-Received: by 2002:a05:651c:b2c:b0:38a:a7b4:15e8 with SMTP id
 38308e7fff4ca-38ec7813beamr137707761fa.12.1777255225572; Sun, 26 Apr 2026
 19:00:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260424092340.3792297-1-liu.airalert@gmail.com> <2834c77d-9077-4462-9e64-3460fe9d2ec0@intel.com>
In-Reply-To: <2834c77d-9077-4462-9e64-3460fe9d2ec0@intel.com>
From: xingbang liu <liu.airalert@gmail.com>
Date: Mon, 27 Apr 2026 10:00:14 +0800
X-Gm-Features: AVHnY4I6f6rNt3HSmFG5ugHAzkgrcvUeUBl8dRFfxyrxK4Is5VkGFensjhQOC4s
Message-ID: <CAFO7Ud+kTaWn==aref726VYfqaEjb5m7ADvXdFL4rCNXCO-Rtg@mail.gmail.com>
Subject: Re: [PATCH v1] ntb_transport: replace wmb() with dma_wmb() in TX paths
To: Dave Jiang <dave.jiang@intel.com>
Cc: jdmason@kudzu.us, allenbh@gmail.com, ntb@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi DJ ,

Thanks for the review and the explanation.

I understand that dma_wmb() is intended for CPU =E2=86=92 device DMA visibi=
lity, and
since this path writes to MMIO (peer memory window), a full wmb() is requir=
ed
to guarantee that all writes are visible before the notification/doorbell.

I will withdraw this patch and keep the wmb() in place.

Thanks,
Xingbang Liu

Dave Jiang <dave.jiang@intel.com> =E4=BA=8E2026=E5=B9=B44=E6=9C=8824=E6=97=
=A5=E5=91=A8=E4=BA=94 23:32=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> On 4/24/26 2:23 AM, Xingbang Liu wrote:
> > The TX paths currently use wmb() after memcpy_toio() to ensure that
> > writes to the peer memory window are visible before subsequent
> > notification.
> >
> > The actual ordering requirement is to ensure that data written to the
> > peer memory is observed before the associated notification or status
> > update. This matches the semantics of dma_wmb(), which orders memory
> > writes with respect to external observers.
> >
> > The peer memory window is mapped with ioremap_wc(), allowing
> > write-combining. On weakly ordered architectures such as arm64,
> > dma_wmb() ensures that prior writes are committed from write-combining
> > buffers and become visible to the peer before subsequent operations.
> >
> > This aligns with common patterns in PCIe-based drivers, where it is
> > used to order descriptor or payload writes before notification, while
> > avoiding the stronger ordering semantics of wmb().
> >
> > The ordering with respect to peer observation is completed by the
> > subsequent notification mechanism.
> >
> > No functional change is intended.
> >
> > Signed-off-by: Xingbang Liu <liu.airalert@gmail.com>
>
> NAK. dma_wmb() is used for shared memory between CPU and a device. For ex=
ample:
>
> memcpy(dma_buffer, data, size);
> dma_wmb(); /* Ensure CPU writes visible to device DMA */
> writel(DOORBELL, device->reg + DB_OFFSET); /* trigger device DMA from dma=
_buffer */
>
> In this case we are copying data to MMIO and therefore wmb() is needed to=
 ensure all MMIO writes have happened before we proceed.
>
> DJ
>
> > ---
> >  drivers/ntb/ntb_transport.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> > index 7cabc82305d6..c8ef46ddcc57 100644
> > --- a/drivers/ntb/ntb_transport.c
> > +++ b/drivers/ntb/ntb_transport.c
> > @@ -1791,7 +1791,7 @@ static void ntb_memcpy_tx_on_stack(struct ntb_que=
ue_entry *entry, void __iomem *
> >  #endif
> >
> >       /* Ensure that the data is fully copied out before setting the fl=
ags */
> > -     wmb();
> > +     dma_wmb();
> >
> >       ntb_tx_copy_callback(entry, NULL);
> >  }
>
