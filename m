Return-Path: <wesleyshenggit@sina.com>
Received: from mail7-212.sinamail.sina.com.cn (mail7-212.sinamail.sina.com.cn. [202.108.7.212])
        by gmr-mx.google.com with SMTP id q49-v6si420946qte.3.2018.10.09.22.36.00
        for <linux-ntb@googlegroups.com>;
        Tue, 09 Oct 2018 22:36:01 -0700 (PDT)
From: Wesley Sheng <wesleyshenggit@sina.com>
Subject: [PATCH v3] NTB: switchtec_ntb: Update switchtec documentation with pre-requisites for NTB
Date: Wed, 10 Oct 2018 20:33:08 +0800
Message-Id: <1539174788-25878-1-git-send-email-wesleyshenggit@sina.com>
To: kurt.schwemmer@microsemi.com, logang@deltatee.com, corbet@lwn.net, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com, linux-ntb@googlegroups.com
Cc: Wesley Yung <wesley.yung@microchip.com>, Kelvin Cao <kelvin.cao@microchip.com>, Wesley Sheng <wesleyshenggit@sina.com>
List-ID: <linux-ntb.googlegroups.com>


From: Wesley Yung <wesley.yung@microchip.com>

The ntb_hw_switchtec driver has requirements on kernel configuration
so we add these notes to the documentation and also clean up a few 
other sentences in the documentation.

Signed-off-by: Wesley Yung <wesley.yung@microchip.com>
Signed-off-by: Kelvin Cao <kelvin.cao@microchip.com>
Signed-off-by: Wesley Sheng <wesleyshenggit@sina.com>
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


