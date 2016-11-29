Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x242.google.com (mail-lf0-x242.google.com. [2a00:1450:4010:c07::242])
        by gmr-mx.google.com with ESMTPS id f71si335427wmf.2.2016.11.29.09.15.48
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Nov 2016 09:15:48 -0800 (PST)
Received: by mail-lf0-x242.google.com with SMTP id o141so13357507lff.1
        for <linux-ntb@googlegroups.com>; Tue, 29 Nov 2016 09:15:47 -0800 (PST)
Return-Path: <fancer.lancer@gmail.com>
From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 00/22] NTB: Alter kernel API to support multi-port devices
Date: Tue, 29 Nov 2016 20:15:55 +0300
Message-Id: <1480439777-1080-1-git-send-email-fancer.lancer@gmail.com>
To: jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, Xiangliang.Yu@amd.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

There are devices, like IDT PCIe-switches, which have more than just two ports.
Particularly one device can have up to eight ports with NTB-function activated.
In order to support such devices, NTB kernel API should be altered since
currently it's optimized to work with two-ports devices only.

Here are the changes I made to conform the design we discussed a few months ago:

1) Port-index-related methods are added to KAPI
 ntb_port_number();
 ntb_peer_port_count();
 ntb_peer_port_number(pdix);
 ntb_peer_port_idx(port);

2) Link state method returns bitfield of link states for each reachable port
 u64 ntb_link_is_up();
 
3) Link enable/disable methods work with local link side of NTB
 ntb_link_enable()/ntb_link_disable();
 
4) NTB memory window related interface does the following things
 ntb_mw_count(pidx); - number of inbound memory windows, which can be allocated
for shared buffer with specified peer device.
 ntb_mw_get_align(pidx, widx); - get alignment and size restrition parameters
to properly allocate inbound memory region.
 ntb_peer_mw_count(); - get number of outbound memory windows.
 ntb_peer_mw_get_addr(widx); - get mapping address of an outbound memory window 

Inbound MW based hardware:
 ntb_mw_set_trans(pidx, widx); - set translation address of allocated inbound
memory window so a peer device could access it.
 ntb_mw_clear_trans(pidx, widx); - clear the translation address of an inbound
memory window.

Outbound MW based hardware:
 ntb_peer_mw_set_trans(pidx, widx); - set translation address of a memory
window retrieved from a peer device
 ntb_peer_mw_clear_trans(pidx, widx); - clear the translation address of an
outbound memory window

5) Scratchpad interface needs to support multi-port devices as well
 ntb_spad_count() - return number of Scratchpad per each port
 ntb_peer_spad_addr(pidx, sidx) - address of Scratchpad register of the
peer device with pidx-index
 ntb_peer_spad_read(pidx, sidx) - read specified Scratchpad register of the
peer with pidx-index
 ntb_peer_spad_write(pidx, sidx) - write data to Scratchpad register of the
peer with pidx-index

6) Introduce new messaging interface of NTB KAPI
 ntb_msg_count(); - get number of message registers
 ntb_msg_inbits(); - get bitfield of inbound message registers status
 ntb_msg_outbits(); - get bitfield of outbound message registers status
 ntb_msg_read_sts(); - read the inbound and outbound message registers status
 ntb_msg_clear_sts(); - clear status bits of message registers
 ntb_msg_set_mask(); - mask interrupts raised by status bits of message
registers.
 ntb_msg_clear_mask(); - clear interrupts mask bits of message registers
 ntb_msg_recv(midx, *pidx); - read message register with specified index,
additionally getting peer port index which data received from
 ntb_msg_send(midx, pidx); - write data to the specified message register
sending it to the passed peer device connected over a pidx port
 ntb_msg_event(); - notify driver context of a new message event
 
7) Topology reduced to be either P2P (port-to-port) or B2B (bridge-to-bridge).
Since there is port number introduced to be part of ntb_dev structure, real
port number can be used to determine Primary and Secondary sides. Intel and AMD
driver are altered to support this novation.

8) Standard test drivers: PingPong, Debugging tool and Raw Perf as well as NTB
Transport drivers don't support multi-port devices at the moment.
Since we haven't got any real multi-port hadrware driver, it's dangerous to
make any serious alterations in the debugging tools. So I have made those
drivers to work the way they wokred before, but using the new NTB API.
The situation will change when I finish porting my current IDT NTB driver to
support new API. Then I'll be able to refactor the tools and test them using
real multi-port hardware.

The changes are made on top of the NTB-fork of the kernel:
https://github.com/jonmason/ntb
of "ntb"-branch with last commit:
9c763584b7c8911106bb77af7e648bef09af9d80 Linux 4.9-rc6

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

Serge Semin (22):
  NTB: Move link state API being first in sources
  NTB: Add peer indexed ports NTB API
  NTB: Alter NTB API to support both inbound and outbound MW based
    interfaces
  NTB: Add messaging NTB API
  NTB: Alter Scratchpads NTB API to support multi-ports interface
  NTB: Slightly alter link state NTB API
  NTB: Fix a few ntb.h issues
  NTB: Add T-Platforms copyrights to NTB API
  NTB Intel: Move link-related methods being first in the driver
  NTB Intel: Add port-related NTB API callback methods
  NTB Intel: Alter MW interface to fit new NTB API
  NTB Intel: Alter Scratchpads interface to fit new NTB API
  NTB Intel: Add T-Platforms copyrights to Intel NTB driver
  NTB AMD: Move link-related methods being first in the driver
  NTB AMD: Add port-related NTB API callback methods
  NTB AMD: Alter MW interface to fit new NTB API
  NTB AMD: Alter Scratchpads interface to fit new NTB API
  NTB AMD: Add T-Platforms copyrights to AMD NTB driver
  NTB PingPong: Alter driver to work with two-ports NTB API
  NTB Tool: Alter driver to work with two-ports NTB API
  NTB Perf: Alter driver to work with two-ports NTB API
  NTB Transport: Alter driver to work with two-ports NTB API

 drivers/ntb/hw/amd/ntb_hw_amd.c     | 310 +++++++++------
 drivers/ntb/hw/amd/ntb_hw_amd.h     |  12 +
 drivers/ntb/hw/intel/ntb_hw_intel.c | 420 ++++++++++++--------
 drivers/ntb/hw/intel/ntb_hw_intel.h |  12 +
 drivers/ntb/ntb.c                   |  15 +
 drivers/ntb/ntb_transport.c         |  43 +-
 drivers/ntb/test/ntb_perf.c         |  27 +-
 drivers/ntb/test/ntb_pingpong.c     |  11 +-
 drivers/ntb/test/ntb_tool.c         |  87 +++--
 include/linux/ntb.h                 | 753 +++++++++++++++++++++++++++++-------
 10 files changed, 1221 insertions(+), 469 deletions(-)

-- 
2.6.6

