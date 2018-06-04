Return-Path: <allenbh@gmail.com>
Received: from mail-wm0-x235.google.com (mail-wm0-x235.google.com. [2a00:1450:400c:c09::235])
        by gmr-mx.google.com with ESMTPS id t30-v6si368481lfd.0.2018.06.04.05.08.42
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Jun 2018 05:08:42 -0700 (PDT)
Received: by mail-wm0-x235.google.com with SMTP id z6-v6so13950715wma.0
        for <linux-ntb@googlegroups.com>; Mon, 04 Jun 2018 05:08:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <e46a0926-7118-4009-886f-c1252cb93d62@googlegroups.com>
References: <e46a0926-7118-4009-886f-c1252cb93d62@googlegroups.com>
From: Allen Hubbe <allenbh@gmail.com>
Date: Mon, 4 Jun 2018 08:08:41 -0400
Message-ID: <CAJ80sasPx7HFT2wgD7tMpmEVKPraHg+oQJ-zoUkNyRpnB8to+Q@mail.gmail.com>
Subject: Re: Problem with the connection status (Link-status) after loading
 the driver ntb_hw_intel
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Ka Vi <yato.iacs@gmail.com>
Cc: linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

On Mon, Jun 4, 2018 at 7:07 AM, Ka Vi <yato.iacs@gmail.com> wrote:
>
> Hi
>
> After loading the ntb.ko and ntb_hw_intel drivers, the
> /sys/kernel/debug/ntb_hw_intel/0000:00:03.0/info file appears, indicating
> that Link-Status is Down.
> When the ntb_transport driver is loaded, the Link-Status state goes to Up=
.
> When the ntb_netdev driver is loaded, the eth0 device appears. When
> assigning ip-addressing to both devices eth0, we have a ping between them=
.
>
> After downloading the ntc_ntb_msi driver, the folders by / sys / kernel /
> debug / ntc_ntb_msi, / sys / kernel / debug / ntrdma, / sys / class /
> infiniband are empty. In the / sys / class / infiniband_verbs folder ther=
e
> is only one "abi_version" file containing one "6" character.

Was the ntb_transport driver unloaded before loading ntc_ntb_msi?

> Why does not the link go into UP status when loading ntb_hw_intel?

The hw driver only provides an interface for the hardware.

> And it
> appears only after ntb_transport, it's kind of like different things.

The transport driver tells the hw driver to bring up the interface.

> Also what it is necessary to make, what the link would pass in status UP =
at
> loading ntb_hw_intel?

If the link is allowed to go up before the transport driver is loaded,
then some other signal would be needed to indicate when the transport
driver becomes ready for communication.  Doing it this way, the link
up signal not only indicates that the link is physically up, but also
that the peer is ready for communication over the link.

> All did according to the instructions
> https://github.com/jonmason/ntb/wiki/Linux-NTB-HOWTO-build-and-install
>
> //---------------------------------------------------------------
> Spread spectrum clock is turned off by default.
>
> NTB Window Size:
> PBAR23SZ 22
> PBAR45SZ 20
> SBAR23SZ 20
> SBAR45SZ 20
>
> System Gooxi, Debian 4.9, 16Gb RAM. Intel=C2=AE Xeon=C2=AE E5-2603 v4
