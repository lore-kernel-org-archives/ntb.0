Return-Path: <allenbh@gmail.com>
Received: from mail-wr0-x229.google.com (mail-wr0-x229.google.com. [2a00:1450:400c:c0c::229])
        by gmr-mx.google.com with ESMTPS id b8-v6si770887wrn.2.2018.06.04.07.00.46
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Jun 2018 07:00:46 -0700 (PDT)
Received: by mail-wr0-x229.google.com with SMTP id h10-v6so2464781wrq.8
        for <linux-ntb@googlegroups.com>; Mon, 04 Jun 2018 07:00:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <62e8a338-e07b-4174-927c-f4f70a54949b@googlegroups.com>
References: <e46a0926-7118-4009-886f-c1252cb93d62@googlegroups.com>
 <CAJ80sasPx7HFT2wgD7tMpmEVKPraHg+oQJ-zoUkNyRpnB8to+Q@mail.gmail.com> <62e8a338-e07b-4174-927c-f4f70a54949b@googlegroups.com>
From: Allen Hubbe <allenbh@gmail.com>
Date: Mon, 4 Jun 2018 10:00:45 -0400
Message-ID: <CAJ80sauCYYOUak+1sQ=3kx_mK10pvL3pLCs_hEq-MPUaNgSD-g@mail.gmail.com>
Subject: Re: Problem with the connection status (Link-status) after loading
 the driver ntb_hw_intel
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Ka Vi <yato.iacs@gmail.com>
Cc: linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

On Mon, Jun 4, 2018 at 9:23 AM, Ka Vi <yato.iacs@gmail.com> wrote:
> Hi, Allen! Thanks for answering!
>
> 1. Was the ntb_transport driver unloaded before loading ntc_ntb_msi?
> No, I want to create a bridge using NTRDMA over PCIe NTB, bypassing the T=
CP
> / IP protocol
>
> I watched the wiki, and I did everything as indicated. And there is no us=
age
> of the ntb_transport module.
>
> After editing the configuration file
> (https://github.com/ntrdma/ntrdma/wiki#module-loading-1), I load the modu=
le
> and get an error: [ 1273.099294] ntb_hw_intel: unknown parameter 'no_msix=
'
> ignored
> All the necessary output in dmesg:
> [ 1252.681245] ioatdma: Intel(R) QuickData Technology Driver 4.00
> [ 1273.099294] ntb_hw_intel: unknown parameter 'no_msix' ignored
> [ 1273.099420] Intel(R) PCI-E Non-Transparent Bridge Driver kkk  3.0
> [ 1273.099624] ntb_hw_intel 0000:00:03.0: enabling bus mastering
> [ 1273.100007] ntb_hw_intel 0000:00:03.0: NTB device registered.
> [ 1325.970171] ntc: NTC Driver Framework 0.2
> [ 1325.974509] ntc_ntb: NTC Non Transparent Bridge 0.3

Please load ntc_ntb_msi with module parameter dyndbg=3D+p

Can you also please provide the output of:
ls -ld /sys/bus/ntb/*/driver

If it was loaded with dyndbg, and that is the last thing in dmesg,
then it looks like the probe function was never called.

>
> What is the parameter no_msix ?

That parameter was used in development, to force the hw driver to
request msi interrupts instead of msi-x.  It is no longer needed, and
ok that the parameter was ignored.

>
> Based on this, and having spent a lot of time figuring out the problem, I
> decided to go back to the beginning, and see if there is any connection
> between the controllers without loading ntb_transport. Due to the fact th=
at
> I went to a dead end, I felt that I was wrong somewhere in the beginning =
and
> therefore asked about (Problem with the connection status (Link-status)
> after loading the driver ntb_hw_intel)
>
> Maybe I'm looking for a solution in the wrong direction, and if you know =
or
> can help me, I'll be very glad.
>
>
> On Monday, 4 June 2018 15:08:42 UTC+3, Allen Hubbe wrote:
>>
>> On Mon, Jun 4, 2018 at 7:07 AM, Ka Vi <yato...@gmail.com> wrote:
>> >
>> > Hi
>> >
>> > After loading the ntb.ko and ntb_hw_intel drivers, the
>> > /sys/kernel/debug/ntb_hw_intel/0000:00:03.0/info file appears,
>> > indicating
>> > that Link-Status is Down.
>> > When the ntb_transport driver is loaded, the Link-Status state goes to
>> > Up.
>> > When the ntb_netdev driver is loaded, the eth0 device appears. When
>> > assigning ip-addressing to both devices eth0, we have a ping between
>> > them.
>> >
>> > After downloading the ntc_ntb_msi driver, the folders by / sys / kerne=
l
>> > /
>> > debug / ntc_ntb_msi, / sys / kernel / debug / ntrdma, / sys / class /
>> > infiniband are empty. In the / sys / class / infiniband_verbs folder
>> > there
>> > is only one "abi_version" file containing one "6" character.
>>
>> Was the ntb_transport driver unloaded before loading ntc_ntb_msi?
>>
>> > Why does not the link go into UP status when loading ntb_hw_intel?
>>
>> The hw driver only provides an interface for the hardware.
>>
>> > And it
>> > appears only after ntb_transport, it's kind of like different things.
>>
>> The transport driver tells the hw driver to bring up the interface.
>>
>> > Also what it is necessary to make, what the link would pass in status =
UP
>> > at
>> > loading ntb_hw_intel?
>>
>> If the link is allowed to go up before the transport driver is loaded,
>> then some other signal would be needed to indicate when the transport
>> driver becomes ready for communication.  Doing it this way, the link
>> up signal not only indicates that the link is physically up, but also
>> that the peer is ready for communication over the link.
>>
>> > All did according to the instructions
>> > https://github.com/jonmason/ntb/wiki/Linux-NTB-HOWTO-build-and-install
>> >
>> > //---------------------------------------------------------------
>> > Spread spectrum clock is turned off by default.
>> >
>> > NTB Window Size:
>> > PBAR23SZ 22
>> > PBAR45SZ 20
>> > SBAR23SZ 20
>> > SBAR45SZ 20
>> >
>> > System Gooxi, Debian 4.9, 16Gb RAM. Intel=C2=AE Xeon=C2=AE E5-2603 v4
