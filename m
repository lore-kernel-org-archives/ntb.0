Return-Path: <wesley.sheng@microchip.com>
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (mail-bn3nam01on0045.outbound.protection.outlook.com. [104.47.33.45])
        by gmr-mx.google.com with ESMTPS id h13-v6si364140pfd.2.2018.10.10.01.30.59
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 Oct 2018 01:30:59 -0700 (PDT)
From: Wesley Sheng <wesley.sheng@microchip.com>
Subject: [PATCH v3] NTB: switchtec_ntb: Update switchtec documentation with pre-requisites for NTB
Date: Wed, 10 Oct 2018 22:42:55 +0800
Message-ID: <1539182575-26851-1-git-send-email-wesley.sheng@microchip.com>
Return-Path: wesley.sheng@microchip.com
MIME-Version: 1.0
Content-Type: text/plain
To: bhelgaas@google.com, corbet@lwn.net, logang@deltatee.com, kurt.schwemmer@microsemi.com
Cc: linux-ntb@googlegroups.com, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Wesley Yung <wesley.yung@microchip.com>, Kelvin Cao <kelvin.cao@microchip.com>, Wesley
 Sheng <wesley.sheng@microchip.com>
List-ID: <linux-ntb.googlegroups.com>

From: Wesley Yung <wesley.yung@microchip.com>

The ntb_hw_switchtec driver has requirements on kernel configuration
so we add these notes to the documentation and also clean up a few 
other sentences in the documentation.

Signed-off-by: Wesley Yung <wesley.yung@microchip.com>
Signed-off-by: Kelvin Cao <kelvin.cao@microchip.com>
Signed-off-by: Wesley Sheng <wesley.sheng@microchip.com>
---
 Documentation/switchtec.txt | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/Documentation/switchtec.txt b/Documentation/switchtec.txt
index f788264..d6f04dcc 100644
--- a/Documentation/switchtec.txt
+++ b/Documentation/switchtec.txt
@@ -23,7 +23,7 @@ The primary means of communicating with the Switchtec management firmware is
 through the Memory-mapped Remote Procedure Call (MRPC) interface.
 Commands are submitted to the interface with a 4-byte command
 identifier and up to 1KB of command specific data. The firmware will
-respond with a 4 bytes return code and up to 1KB of command specific
+respond with a 4-byte return code and up to 1KB of command specific
 data. The interface only processes a single command at a time.
 
 
@@ -36,8 +36,8 @@ device: /dev/switchtec#, one for each management endpoint in the system.
 The char device has the following semantics:
 
 * A write must consist of at least 4 bytes and no more than 1028 bytes.
-  The first four bytes will be interpreted as the command to run and
-  the remainder will be used as the input data. A write will send the
+  The first 4 bytes will be interpreted as the Command ID and the
+  remainder will be used as the input data. A write will send the
   command to the firmware to begin processing.
 
 * Each write must be followed by exactly one read. Any double write will
@@ -45,9 +45,9 @@ The char device has the following semantics:
   produce an error.
 
 * A read will block until the firmware completes the command and return
-  the four bytes of status plus up to 1024 bytes of output data. (The
-  length will be specified by the size parameter of the read call --
-  reading less than 4 bytes will produce an error.
+  the 4-byte Command Return Value plus up to 1024 bytes of output
+  data. (The length will be specified by the size parameter of the read
+  call -- reading less than 4 bytes will produce an error.)
 
 * The poll call will also be supported for userspace applications that
   need to do other things while waiting for the command to complete.
@@ -83,10 +83,20 @@ The following IOCTLs are also supported by the device:
 Non-Transparent Bridge (NTB) Driver
 ===================================
 
-An NTB driver is provided for the switchtec hardware in switchtec_ntb.
-Currently, it only supports switches configured with exactly 2
-partitions. It also requires the following configuration settings:
+An NTB hardware driver is provided for the Switchtec hardware in
+ntb_hw_switchtec. Currently, it only supports switches configured with
+exactly 2 NT partitions and zero or more non-NT partitions. It also requires
+the following configuration settings:
 
-* Both partitions must be able to access each other's GAS spaces.
+* Both NT partitions must be able to access each other's GAS spaces.
   Thus, the bits in the GAS Access Vector under Management Settings
   must be set to support this.
+* Kernel configuration MUST include support for NTB (CONFIG_NTB needs
+  to be set)
+
+NT EP BAR 2 will be dynamically configured as a Direct Window, and
+the configuration file does not need to configure it explicitly.
+
+Please refer to Documentation/ntb.txt in Linux source tree for an overall
+understanding of the Linux NTB stack. ntb_hw_switchtec works as an NTB
+Hardware Driver in this stack.
-- 
2.7.4

