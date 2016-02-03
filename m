Return-Path: <baruch@tkos.co.il>
Received: from mx.tkos.co.il (guitar.tcltek.co.il. [192.115.133.116])
        by gmr-mx.google.com with ESMTPS id h123si203224wmd.0.2016.02.02.23.44.05
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Feb 2016 23:44:06 -0800 (PST)
From: Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH] NTB: doc: remove underscore escaping
Date: Wed,  3 Feb 2016 09:43:57 +0200
Message-Id: <8b17fab4dd0a98d2b19d40b000b81312de551732.1454485437.git.baruch@tkos.co.il>
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>
Cc: linux-ntb@googlegroups.com, Baruch Siach <baruch@tkos.co.il>
List-ID: <linux-ntb.googlegroups.com>

This escaping sequence makes the plain text file hard to read, and obscures the
name of identifies like module parameters. This is probably a left over from a
markup version of the text.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 Documentation/ntb.txt | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/Documentation/ntb.txt b/Documentation/ntb.txt
index 1d9bbabb6c79..1a7f5731a130 100644
--- a/Documentation/ntb.txt
+++ b/Documentation/ntb.txt
@@ -26,7 +26,7 @@ as ntb hardware, or hardware drivers, are inserted and removed.  The
 registration uses the Linux Device framework, so it should feel familiar to
 anyone who has written a pci driver.
 
-### NTB Transport Client (ntb\_transport) and NTB Netdev (ntb\_netdev)
+### NTB Transport Client (ntb_transport) and NTB Netdev (ntb_netdev)
 
 The primary client for NTB is the Transport client, used in tandem with NTB
 Netdev.  These drivers function together to create a logical link to the peer,
@@ -37,7 +37,7 @@ Transport queue pair.  Network data is copied between socket buffers and the
 Transport queue pair buffer.  The Transport client may be used for other things
 besides Netdev, however no other applications have yet been written.
 
-### NTB Ping Pong Test Client (ntb\_pingpong)
+### NTB Ping Pong Test Client (ntb_pingpong)
 
 The Ping Pong test client serves as a demonstration to exercise the doorbell
 and scratchpad registers of NTB hardware, and as an example simple NTB client.
@@ -55,16 +55,16 @@ Module Parameters:
 	registers.  By default, Ping Pong will not attempt to exercise such
 	hardware.  You may override this behavior at your own risk by setting
 	unsafe=1.
-* delay\_ms - Specify the delay between receiving a doorbell
+* delay_ms - Specify the delay between receiving a doorbell
 	interrupt event and setting the peer doorbell register for the next
 	round.
-* init\_db - Specify the doorbell bits to start new series of rounds.  A new
+* init_db - Specify the doorbell bits to start new series of rounds.  A new
 	series begins once all the doorbell bits have been shifted out of
 	range.
 * dyndbg - It is suggested to specify dyndbg=+p when loading this module, and
 	then to observe debugging output on the console.
 
-### NTB Tool Test Client (ntb\_tool)
+### NTB Tool Test Client (ntb_tool)
 
 The Tool test client serves for debugging, primarily, ntb hardware and drivers.
 The Tool provides access through debugfs for reading, setting, and clearing the
@@ -74,7 +74,7 @@ The Tool does not currently have any module parameters.
 
 Debugfs Files:
 
-* *debugfs*/ntb\_tool/*hw*/ - A directory in debugfs will be created for each
+* *debugfs*/ntb_tool/*hw*/ - A directory in debugfs will be created for each
 	NTB device probed by the tool.  This directory is shortened to *hw*
 	below.
 * *hw*/db - This file is used to read, set, and clear the local doorbell.  Not
@@ -84,16 +84,16 @@ Debugfs Files:
 	followed by the bits to clear.
 * *hw*/mask - This file is used to read, set, and clear the local doorbell mask.
 	See *db* for details.
-* *hw*/peer\_db - This file is used to read, set, and clear the peer doorbell.
+* *hw*/peer_db - This file is used to read, set, and clear the peer doorbell.
 	See *db* for details.
-* *hw*/peer\_mask - This file is used to read, set, and clear the peer doorbell
+* *hw*/peer_mask - This file is used to read, set, and clear the peer doorbell
 	mask.  See *db* for details.
 * *hw*/spad - This file is used to read and write local scratchpads.  To read
 	the values of all scratchpads, read the file.  To write values, write a
 	series of pairs of scratchpad number and value
 	(eg: `echo '4 0x123 7 0xabc' > spad`
 	# to set scratchpads `4` and `7` to `0x123` and `0xabc`, respectively).
-* *hw*/peer\_spad - This file is used to read and write peer scratchpads.  See
+* *hw*/peer_spad - This file is used to read and write peer scratchpads.  See
 	*spad* for details.
 
 ## NTB Hardware Drivers
@@ -101,27 +101,27 @@ Debugfs Files:
 NTB hardware drivers should register devices with the NTB core driver.  After
 registering, clients probe and remove functions will be called.
 
-### NTB Intel Hardware Driver (ntb\_hw\_intel)
+### NTB Intel Hardware Driver (ntb_hw_intel)
 
 The Intel hardware driver supports NTB on Xeon and Atom CPUs.
 
 Module Parameters:
 
-* b2b\_mw\_idx - If the peer ntb is to be accessed via a memory window, then use
+* b2b_mw_idx - If the peer ntb is to be accessed via a memory window, then use
 	this memory window to access the peer ntb.  A value of zero or positive
 	starts from the first mw idx, and a negative value starts from the last
 	mw idx.  Both sides MUST set the same value here!  The default value is
 	`-1`.
-* b2b\_mw\_share - If the peer ntb is to be accessed via a memory window, and if
+* b2b_mw_share - If the peer ntb is to be accessed via a memory window, and if
 	the memory window is large enough, still allow the client to use the
 	second half of the memory window for address translation to the peer.
-* xeon\_b2b\_usd\_bar2\_addr64 - If using B2B topology on Xeon hardware, use
+* xeon_b2b_usd_bar2_addr64 - If using B2B topology on Xeon hardware, use
 	this 64 bit address on the bus between the NTB devices for the window
 	at BAR2, on the upstream side of the link.
-* xeon\_b2b\_usd\_bar4\_addr64 - See *xeon\_b2b\_bar2\_addr64*.
-* xeon\_b2b\_usd\_bar4\_addr32 - See *xeon\_b2b\_bar2\_addr64*.
-* xeon\_b2b\_usd\_bar5\_addr32 - See *xeon\_b2b\_bar2\_addr64*.
-* xeon\_b2b\_dsd\_bar2\_addr64 - See *xeon\_b2b\_bar2\_addr64*.
-* xeon\_b2b\_dsd\_bar4\_addr64 - See *xeon\_b2b\_bar2\_addr64*.
-* xeon\_b2b\_dsd\_bar4\_addr32 - See *xeon\_b2b\_bar2\_addr64*.
-* xeon\_b2b\_dsd\_bar5\_addr32 - See *xeon\_b2b\_bar2\_addr64*.
+* xeon_b2b_usd_bar4_addr64 - See *xeon_b2b_bar2_addr64*.
+* xeon_b2b_usd_bar4_addr32 - See *xeon_b2b_bar2_addr64*.
+* xeon_b2b_usd_bar5_addr32 - See *xeon_b2b_bar2_addr64*.
+* xeon_b2b_dsd_bar2_addr64 - See *xeon_b2b_bar2_addr64*.
+* xeon_b2b_dsd_bar4_addr64 - See *xeon_b2b_bar2_addr64*.
+* xeon_b2b_dsd_bar4_addr32 - See *xeon_b2b_bar2_addr64*.
+* xeon_b2b_dsd_bar5_addr32 - See *xeon_b2b_bar2_addr64*.
-- 
2.7.0

