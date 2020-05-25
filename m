Return-Path: <allenbh@gmail.com>
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com. [2a00:1450:4864:20::334])
        by gmr-mx.google.com with ESMTPS id c10si515861lji.1.2020.05.25.12.18.00
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2020 12:18:00 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id u12so931001wmd.3
        for <linux-ntb@googlegroups.com>; Mon, 25 May 2020 12:18:00 -0700 (PDT)
MIME-Version: 1.0
References: <ca1ae048-bb3d-4aec-8d89-17178734f097@googlegroups.com>
In-Reply-To: <ca1ae048-bb3d-4aec-8d89-17178734f097@googlegroups.com>
From: Allen Hubbe <allenbh@gmail.com>
Date: Mon, 25 May 2020 15:17:48 -0400
Message-ID: <CAJ80sav6-3OEYp3wTUQ-nc541-Zzb3dNCxnXaLY4x7AjLn=tug@mail.gmail.com>
Subject: Re: Using NTRDMA with Intel Skylake in b2b configuration
Content-Type: text/plain; charset="UTF-8"
To: Anubhav Guleria <anubhav.nitsri.it@gmail.com>
Cc: linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

Hi Anubhav,

On Sun, May 24, 2020 at 5:37 PM Anubhav Guleria
<anubhav.nitsri.it@gmail.com> wrote:
>
>
> Hi,
> I am trying to setup ntrdma(https://github.com/ntrdma/ntrdma-ext) with Intel Skylake b2b configuration and Linux 4.14.178.
> Following is how my memory windows are setup:
> 1) MW[0] (BAR23): dma_alloc_coherent
> 2) MW[1] (BAR45): memremap

It would be interesting to know the size of the windows, and any
module parameters used with ntb_hw_intel.  The last memory window
needs to be at least as large as the installed dram of the system.

> Further, what I understand that in case of MR registering there are 2 steps[ntrdma_reg_user_mr()]:
>
> 1) Call ib_umem_get() to Pin and DMA Map userspace Memory.
> 2) Then, prepare a memory buffer in a NTB window, by ntc_mr_buf_map_dma(..).
>
> The doubt that I have is that is it necessary to have the dma_addr from step 1 to be within the limits of NTB window, in this case MW[0] ?
> And if so, is there some specific configuration that needs to be made?

The dma addresses of the memory needs to fall within the translation
range of the window.  If the memory is not within the window, then the
peer will not be able to access it.  There is no bounce buffer for
memory not in the range.

Step 2 is to communicate the offset in the memory window to the peer,
which is the same as the dma address because the translation range is
zero-based.  Then the peer will access the memory directly.

>
> Also, is above configuration of MWs correct?
>
> Thanks in advance.

Welcome,
Allen
