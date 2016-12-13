Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x242.google.com (mail-lf0-x242.google.com. [2a00:1450:4010:c07::242])
        by gmr-mx.google.com with ESMTPS id h23si897631wmi.1.2016.12.13.15.49.34
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Dec 2016 15:49:34 -0800 (PST)
Received: by mail-lf0-x242.google.com with SMTP id p100so220325lfg.2
        for <linux-ntb@googlegroups.com>; Tue, 13 Dec 2016 15:49:34 -0800 (PST)
Return-Path: <fancer.lancer@gmail.com>
From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH v3 7/9] NTB: Add new Memory Windows API documentation
Date: Wed, 14 Dec 2016 02:49:19 +0300
Message-Id: <1481672961-10753-8-git-send-email-fancer.lancer@gmail.com>
In-Reply-To: <1481672961-10753-1-git-send-email-fancer.lancer@gmail.com>
References: <1481576902-21091-1-git-send-email-fancer.lancer@gmail.com>
 <1481672961-10753-1-git-send-email-fancer.lancer@gmail.com>
To: jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, Xiangliang.Yu@amd.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

Since the new API slightly changes the way a typical NTB client driver
works, the documentation file needs to be appropriately updated.

Acked-by: Allen Hubbe <Allen.Hubbe@dell.com>
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 Documentation/ntb.txt | 99 ++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 91 insertions(+), 8 deletions(-)

diff --git a/Documentation/ntb.txt b/Documentation/ntb.txt
index 1d9bbab..a5af4f0 100644
--- a/Documentation/ntb.txt
+++ b/Documentation/ntb.txt
@@ -1,14 +1,16 @@
 # NTB Drivers
 
 NTB (Non-Transparent Bridge) is a type of PCI-Express bridge chip that connects
-the separate memory systems of two computers to the same PCI-Express fabric.
-Existing NTB hardware supports a common feature set, including scratchpad
-registers, doorbell registers, and memory translation windows.  Scratchpad
-registers are read-and-writable registers that are accessible from either side
-of the device, so that peers can exchange a small amount of information at a
-fixed address.  Doorbell registers provide a way for peers to send interrupt
-events.  Memory windows allow translated read and write access to the peer
-memory.
+the separate memory systems of two or more computers to the same PCI-Express
+fabric. Existing NTB hardware supports a common feature set: doorbell
+registers and memory translation windows, as well as non common features like
+scratchpad and message registers. Scratchpad registers are read-and-writable
+registers that are accessible from either side of the device, so that peers can
+exchange a small amount of information at a fixed address. Message registers can
+be utilized for the same purpose. Additionally they are provided with with
+special status bits to make sure the information isn't rewritten by another
+peer. Doorbell registers provide a way for peers to send interrupt events.
+Memory windows allow translated read and write access to the peer memory.
 
 ## NTB Core Driver (ntb)
 
@@ -26,6 +28,87 @@ as ntb hardware, or hardware drivers, are inserted and removed.  The
 registration uses the Linux Device framework, so it should feel familiar to
 anyone who has written a pci driver.
 
+### NTB Typical client driver implementation
+
+Primary purpose of NTB is to share some peace of memory between at least two
+systems. So the NTB device features like Scratchpad/Message registers are
+mainly used to perform the proper memory window initialization. Typically
+there are two types of memory window interfaces supported by the NTB API:
+inbound translation configured on the local ntb port and outbound translation
+configured by the peer, on the peer ntb port. The first type is
+depicted on the next figure
+
+Inbound translation:
+ Memory:              Local NTB Port:      Peer NTB Port:      Peer MMIO:
+  ____________
+ | dma-mapped |-ntb_mw_set_trans(addr)  |
+ | memory     |        _v____________   |   ______________
+ | (addr)     |<======| MW xlat addr |<====| MW base addr |<== memory-mapped IO
+ |------------|       |--------------|  |  |--------------|
+
+So typical scenario of the first type memory window initialization looks:
+1) allocate a memory region, 2) put translated address to NTB config,
+3) somehow notify a peer device of performed initialization, 4) peer device
+maps corresponding outbound memory window so to have access to the shared
+memory region.
+
+The second type of interface, that implies the shared windows being
+initialized by a peer device, is depicted on the figure:
+
+Outbound translation:
+ Memory:        Local NTB Port:    Peer NTB Port:      Peer MMIO:
+  ____________                      ______________
+ | dma-mapped |                |   | MW base addr |<== memory-mapped IO
+ | memory     |                |   |--------------|
+ | (addr)     |<===================| MW xlat addr |<-ntb_peer_mw_set_trans(addr)
+ |------------|                |   |--------------|
+
+Typical scenario of the second type interface initialization would be:
+1) allocate a memory region, 2) somehow deliver a translated address to a peer
+device, 3) peer puts the translated address to NTB config, 4) peer device maps
+outbound memory window so to have access to the shared memory region.
+
+As one can see the described scenarios can be combined in one portable
+algorithm.
+ Local device:
+  1) Allocate memory for a shared window
+  2) Initialize memory window by translated address of the allocated region
+     (it may fail if local memory window initialization is unsupported)
+  3) Send the translated address and memory window index to a peer device
+ Peer device:
+  1) Initialize memory window with retrieved address of the allocated
+     by another device memory region (it may fail if peer memory window
+     initialization is unsupported)
+  2) Map outbound memory window
+
+In accordance with this scenario, the NTB Memory Window API can be used as
+follows:
+ Local device:
+  1) ntb_mw_count(pidx) - retrieve number of memory ranges, which can
+     be allocated for memory windows between local device and peer device
+     of port with specified index.
+  2) ntb_get_align(pidx, midx) - retrieve parameters restricting the
+     shared memory region alignment and size. Then memory can be properly
+     allocated.
+  3) Allocate physically contiguous memory region in compliance with
+     restrictions retrieved in 2).
+  4) ntb_mw_set_trans(pidx, midx) - try to set translation address of
+     the memory window with specified index for the defined peer device
+     (it may fail if local translated address setting is not supported)
+  5) Send translated base address (usually together with memory window
+     number) to the peer device using, for instance, scratchpad or message
+     registers.
+ Peer device:
+  1) ntb_peer_mw_set_trans(pidx, midx) - try to set received from other
+     device (related to pidx) translated address for specified memory
+     window. It may fail if retrieved address, for instance, exceeds
+     maximum possible address or isn't properly aligned.
+  2) ntb_peer_mw_get_addr(widx) - retrieve MMIO address to map the memory
+     window so to have an access to the shared memory.
+
+Also it is worth to note, that method ntb_mw_count(pidx) should return the
+same value as ntb_peer_mw_count() on the peer with port index - pidx.
+
 ### NTB Transport Client (ntb\_transport) and NTB Netdev (ntb\_netdev)
 
 The primary client for NTB is the Transport client, used in tandem with NTB
-- 
2.6.6

