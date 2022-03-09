Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0015104
	for <ntb@lists.linux.dev>; Wed,  9 Mar 2022 18:26:16 +0000 (UTC)
Received: by mail-yb1-f175.google.com with SMTP id l2so6162927ybe.8
        for <ntb@lists.linux.dev>; Wed, 09 Mar 2022 10:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zi/uvYShVn/Rrp88v6gtE2zKbFYdvGyxB4DxmBVY//w=;
        b=gzBMK21o9wGtylND/gONcmrpmuf2FcF1LgX1VNlbn9j4ZceCPsP6TfDzmkn3+WGRMQ
         9tqKXsJB0P0+v49+gpoLgttI8rGIHMoFJFJgbpckP7DbQZj21pp35/cdcBg7RRqqPuEj
         iOSC6/yp+M6RltIlOOGLh8tXldb0sTgD/DP7pfoh2utxNrkfxCH3VvMPoS+ecLMs1q/G
         4OHvj8MhQz3X7d63NiXWBWECWY1njSehEpTZ1mBCVsX1qRbnqI3pCazpaHISgR/gLKm3
         d3JAgbEeRKC/p3+8j4ccomE6zVDHg5I2E2zRc4vcG+n12qBq2cDkHiihvxW6h37sDgkz
         2XEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zi/uvYShVn/Rrp88v6gtE2zKbFYdvGyxB4DxmBVY//w=;
        b=EoDx0EZt3zvUsX+IYBJG//TSkrIgwprsf4ESQobKc3T+dDOiuEBPuRzYroYFHcjzyf
         3V5f0j3upD1Q1yphetGMrdmbFWO8KLGJgulByWqc7chit05aRe5fFKHtNTovlbNq63J/
         RE/psQ4YBqiIZ5Wr+cYu+3Tn+whYKA+yhNKWRbdHQ5U/jJlT26xOu+qZsmiFYFxzxg/7
         eNo26xfbWigz2u/+j7QGN0bWTknCxTWrad/vwfZxfKnVuiIUzJvJTCpnBgZGE6K+aTvE
         4MgYbv8lnHA1EA+c/8UnASYd4hbdpjrECuHKrEccnfUign7Rs3BnSR+kVlNGWT3lHCP5
         X8HQ==
X-Gm-Message-State: AOAM532xnhgDtUxOZApu1NCRLUMUSvLbfBjTyb7iiGf8ZAo5OlvB5EQm
	mxe5MzesLMybHTFL7yAbmCGGcoAe7/JfzPNJEcE=
X-Google-Smtp-Source: ABdhPJy1xyg3GU2722q561LlxcpO5UqNdHX3sJ1mKRsx8m6EYiTkWcBVIS+k66y/p8AkuDTU8PC0+6taJjTAXoQF634=
X-Received: by 2002:a25:2308:0:b0:628:9a66:7327 with SMTP id
 j8-20020a252308000000b006289a667327mr903633ybj.626.1646850375111; Wed, 09 Mar
 2022 10:26:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAH6h+hfwRFMW47ONT+zC8Z1Y-30gb4dPEwTOtatN86EMeUajpA@mail.gmail.com>
 <1d53b232-dc0a-c7d3-69a1-8cb17ff83601@deltatee.com> <CAH6h+hdbOEjpU5tn+MwDm-h=47b4kzMHDZhSc51hA0VOZLp_8g@mail.gmail.com>
 <48234e72-3458-f90b-234d-f1ffccef996f@deltatee.com> <CAH6h+hd7o7fWFVmPSn86SrgnHC5X_jfdRtn1=dAF=8w8knJK1g@mail.gmail.com>
 <0c3b408a-80b2-992d-0a75-f76977dcb4e9@deltatee.com>
In-Reply-To: <0c3b408a-80b2-992d-0a75-f76977dcb4e9@deltatee.com>
From: Marc Smith <msmith626@gmail.com>
Date: Wed, 9 Mar 2022 13:26:04 -0500
Message-ID: <CAH6h+hfNWgXCguK7xtKCQOm9F_Xc-XCSwRyfrS5nQZGoh7PKFQ@mail.gmail.com>
Subject: Re: ntb_netdev Communication Failure Issue
To: Logan Gunthorpe <logang@deltatee.com>
Cc: ntb@lists.linux.dev, Kelvin Cao <kelvin.cao@microchip.com>, kelvincao@outlook.com
Content-Type: text/plain; charset="UTF-8"

On Wed, Mar 9, 2022 at 11:52 AM Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
>
> On 2022-03-09 07:35, Marc Smith wrote:
> > No difference between the two above, and actually, comparing the
> > entire 4 MiB of GAS dump taken while working/functional versus broken
> > state shows no differences:
> > # cmp switchtec0_gas_dump_after_ifup_working.1 switchtec0_gas_dump_broken.1
>
> Well I'm stumped. It looks like the receive side is getting the
> doorbell, but when it reads the memory window the done flag is not set,
> so it doesn't process any packets. The transmit side then fills up the
> memory window and breaks.
>
> So it sounds like the read side is not reading the correct data from the
> memory window. Like it's cache or something (which it shouldn't be). But
> I have no idea what could cause that.

Anything possibly to blame in the PCIe switch firmware that could
cause this? Working with the vendor to ensure we're at the least, but
still TBD at the moment.

--Marc


>
> Logan
