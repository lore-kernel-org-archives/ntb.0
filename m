Return-Path: <epilmore@gigaio.com>
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com. [2a00:1450:4864:20::42f])
        by gmr-mx.google.com with ESMTPS id z70si993610wmc.2.2019.04.24.15.46.20
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 15:46:20 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id a9so9767716wrp.6
        for <linux-ntb@googlegroups.com>; Wed, 24 Apr 2019 15:46:20 -0700 (PDT)
MIME-Version: 1.0
From: Eric Pilmore <epilmore@gigaio.com>
Date: Wed, 24 Apr 2019 15:46:09 -0700
Message-ID: <CAOQPn8vMn4h=oGWWKa3Uge7WYMkmRAmTyhR6RPjGVtrR1hfhOQ@mail.gmail.com>
Subject: NVMe peer2peer TLPs over NTB getting split
Content-Type: text/plain; charset="UTF-8"
To: linux-ntb <linux-ntb@googlegroups.com>, linux-pci@vger.kernel.org
Cc: Armen Baloyan <abaloyan@gigaio.com>, D Meyer <dmeyer@gigaio.com>, S Taylor <staylor@gigaio.com>, E Pilmore <epilmore@gigaio.com>
List-ID: <linux-ntb.googlegroups.com>

Hi Folks,

Does anybody know why a Host Bridge might break up a full-sized (max
payload) TLP into single byte TLPs when those TLPs are traveling from
peer-to-peer?

Some context. This issue involves a NVMe drive writing (DMA)
"directly" to the remote memory in a server across a NTB. The
following diagram is intended to show the layout:

     Host                 Host
   (port 8)             (port 0)
     /  \                 /  \
    /    \               /    \
    |    |               |    |
..+-+--+-+--+..........+-+--+-+--+..
: | NT | US |          | NT | US | :
: +-+--+-+--+          +-+--+-+--+ :
:   |                    |    |    :
:   |                    |    |    :
:   +--------------------+    |    :
:                           +-+--+ :
............................| DS |..
    switch                  +-+--+
                              |
                              |
                              |
                             NVMe
                           (port 32)

Sorry if my ascii art did not translate.  In a nutshell:
- PCIe switch in play here is a Switchtec device.
- 3 ports of PCIe switch configured (ports 0, 8, 32).
- Port 8 configured as NT+USP and connected to a Host and in its own partition.
- Port 0 configured as NT+USP and connected to a Host and in its own partition.
- Port 32 configured as a DSP and in the same partition as the host on
Port 0. Thus the NVMe drive is directly accessible by Port 0 Host and
visible in his PCIe tree.
- IOMMU is enabled on both hosts.

The NVMe drive is instructed to send (DMA Write) some data into
buffers that reside in Port 8 Host. The destination address for this
DMA is a PCI BAR based address for the NT interface that Port 0 Host
is plugged into. Under the covers, the NT interface on Port 0 will
translate incoming addresses into a physical DRAM address in Port 8
Host.

The Switchtec device supports a tool that allows us to capture Ingres
(only) TLPs that are entering the switch. As such, for the data path
NVMe -> Port 8 Host, I can capture the TLPs being sent by the NVMe as
well as the same packets getting redirected into the NT on Port 0
Host.

Now for the mystery! The TLP packet capture shows full size (256 byte)
TLPs coming from the NVMe drive into the switch, as we would expect.
However, the packets captured coming from Port 0 host, which are the
relayed packets based on the destination address, are just ONE byte
TLPs!! Note that these TLPs coming through the NT for Port 0 Host have
a RequesterID of the respective Host Bridge, which is presumably
because the transactions had to travel through the IOMMU.

A sample TLP (header) from originating NVMe (port 32):
"60 00 00 40 92 00 00 ff 00 00 02 f0 fe d8 70 00 "
   - BDF of NVMe drive = 92.00
   - TLP size = 0x40 = 64 words = 256 bytes

Sample TLP (header) captured from Port 0 host NT:
"60 00 00 01 00 00 00 01 00 00 02 f0 fe d9 60 14 "
"60 00 00 01 00 00 01 02 00 00 02 f0 fe d9 60 14 "
"60 00 00 01 00 00 02 04 00 00 02 f0 fe d9 60 14 "
"60 00 00 01 00 00 03 08 00 00 02 f0 fe d9 60 14 "
    - BDF of originator = 00.00 (host bridge)
    - TLP size = 0x01 = 1 word = 4 bytes, however 1st BE only has 1
bit set indicating, just one byte in word is valid.

As you can see, 4 TLPs, each writing one byte (note the 1st BE field
01->02->04->08)

Does anybody know why these TLPs might get split up like this? Is it
an oddity of having to go through the IOMMU?  Maybe something related
to endian swapping? Something related to attempting to go
peer-to-peer? Our switch is configured with a TLP max payload of 256
bytes

Sorry for the long email, but any assistance is greatly appreciated.
Thanks,
Eric

-- 
Eric Pilmore
epilmore@gigaio.com
http://gigaio.com
Phone: (858) 775 2514

This e-mail message is intended only for the individual(s) to whom
it is addressed and may contain information that is privileged,
confidential, proprietary, or otherwise exempt from disclosure under
applicable law. If you believe you have received this message in
error, please advise the sender by return e-mail and delete it from
your mailbox.
Thank you.
