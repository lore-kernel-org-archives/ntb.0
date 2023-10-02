Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D1B200AA
	for <ntb@lists.linux.dev>; Mon,  2 Oct 2023 22:15:06 +0000 (UTC)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5a21ea6baccso3834327b3.1
        for <ntb@lists.linux.dev>; Mon, 02 Oct 2023 15:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696284905; x=1696889705; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s5a3Q1xhqNAcA5xTT9kTi0iSFNzhQO0gu9ItZ1UpTyY=;
        b=B+M+Bz7L0nJAOfMFAJiAugIacmVFd+p2Sw55b5o0SkV3YBeUdYNEfWj4FO8F2slVmE
         Eu83ycJyMV6cZAuc1MVrpvh38HKovzLHCaHo5eOzoBgr9ldClo2ZeYXeTfW7pr0tlxW3
         9yFdfQ389sSQ7aAW6obwK4qPUKKB7Dpg2GXG8FSLKErZYu3Y2Mv3cG6BGopg3pSic7Kr
         s1yQLJosB7YNT2Rz1zk9WmN22lRQbU8whAq6kcUc9mWggVn5UIOHF8Qr0uRkeQ21NRLp
         GClEwX1pMn1Wlkvac0QzI9iJ2K8IEZjk03idsyTsjTc+OsvNnAeWz2AdNX+q3ez39CfW
         I2Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696284905; x=1696889705;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s5a3Q1xhqNAcA5xTT9kTi0iSFNzhQO0gu9ItZ1UpTyY=;
        b=EFH2KdRN1yaElUWWzMAhuk2VOb5r2OwjqliNJ4C8vH/6ydaY7ucEGkqd2W1CsDphrb
         TgyD+tmvUb+riFMmAsM+zLCMw9WvPxdPrhhqbKTYEdajt5H6VU27/2Ff1vFtflqU+Uzy
         30G2568yJ42+oR7JhbRY61opw2fWUurJ6ljpkCfkqu/e7LvP68P1d6lJxsj/RmQEpBeG
         JqmqVl8Q1VQiuG4yOIrM+SzxRBNm7ScEg0AwM7ygCd65l4Y/2PO6h37BQuJD7rzMzm2u
         /VekajhHpgvLIMs79pC6wbmrt2VxKQiZUucXrMq1EiMDWAEAzn+QTplAous/cZWah30X
         w0Ng==
X-Gm-Message-State: AOJu0YzC7D+bLNZZ8iVryUfEs1eI3Xml6lIEtyXJp2mslQSqbeWFQc2C
	XSUIPutgifJ9b3x5SiU2eKycsVfD7/Fl0p0I0eMZk+CbmxY=
X-Google-Smtp-Source: AGHT+IEJVwvifvIInX+rBLYA5P2+5pL+irfgHPjcwotqCKrS5mmPfFTD/10TYQwH/tjhaeKAXZxhkaynr5PHC8XDl2Q=
X-Received: by 2002:a0d:d681:0:b0:576:bfc7:1e43 with SMTP id
 y123-20020a0dd681000000b00576bfc71e43mr13148075ywd.25.1696284905354; Mon, 02
 Oct 2023 15:15:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received: by 2002:a05:7010:5304:b0:386:acc6:d160 with HTTP; Mon, 2 Oct 2023
 15:15:04 -0700 (PDT)
From: am jom <amjom66@gmail.com>
Date: Tue, 3 Oct 2023 01:45:04 +0330
Message-ID: <CAJXBUywjYMh3xqJ=ePByWjzeP4LRE7Bc3K5qAcZuXG=tBx+20g@mail.gmail.com>
Subject: Problem with 8G dma memory allocation
To: ntb@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

I have a Supermicro x10drs-2u board, Intel Xeon E5, 2600v3, with PLX
NTB switch. I have installed Centos 7 and mainline linux kernel 6.5.3
with added PLX driver from TrueNAS. There 2 main boards with PLX ntb
devices already attached in hardware through a bus named M2

CMA and DMA are active and I can reserve like 8G, CMA memory at 4G.
There are other network devices using CMA and they are working. I know
that ntb_hw_plx.ko by Truenas needs 8G memory space

When i load ntb_transport.ko module, the related kernel thread crashes
by the following error message:

Unable to alloc MW buff of size 8,589,934,592

The problem is with dma_alloc_coherent() which fails and has errors
and it seems that it can not find any CMA reserved memory as the crash
dump reports (by dmesg) invalid operation in _alloc_pages() at last
and the "cma" term is not seen in the crash dump .

for CMA alignment i chose 2, and 2 areas and 8G size. what size and
alignment should i set by the kernel config variables?

Is there any kernel i can use to drive PLX ntb bridge device? Kernel
detects several PLX devices regarding this switch like PEX8717,
PEX8732 and 87d0 and ntb_hw_plx.ko is being attached to 8732 network
device
