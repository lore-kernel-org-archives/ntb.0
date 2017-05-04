Return-Path: <Gary.Hook@amd.com>
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (mail-sn1nam01on0077.outbound.protection.outlook.com. [104.47.32.77])
        by gmr-mx.google.com with ESMTPS id p67si123719pfk.2.2017.05.04.13.21.12
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 May 2017 13:21:12 -0700 (PDT)
Subject: [PATCH V2 0/3] Add/expose control features for the NTB perf test
 module
From: Gary R Hook <gary.hook@amd.com>
Date: Thu, 4 May 2017 15:21:06 -0500
Message-ID: <20170504201544.10113.13551.stgit@taos.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-Path: gary.hook@amd.com
To: linux-ntb@googlegroups.com
Cc: Allen.Hubbe@emc.com, dave.jiang@intel.com, jdmason@kudzu.us
List-ID: <linux-ntb.googlegroups.com>

The goal of this series is to add and expose some control mechanisms for
the performance test module:
 - Provide a switch to allow memory and threads to be off of the NTB
   node.
 - The debug filesystem entries do not need to be retained after they
   are set up. Remove the variables from the context structure and make
   them automatic, 
 - Create a debug-fs entry for every module parameter. This allows test
   parameters to be changes, and additional tests to be run, without
   unloading ntb_perf the module each time.

---

Gary R Hook (3):
      ntb: Add a module option to control affinity of DMA channels
      ntb: Remove debug-fs variables from the context structure
      ntb: Add more debugfs support for ntb_perf testing options


 drivers/ntb/test/ntb_perf.c |   72 +++++++++++++++++++++++++++++++++----------
 1 file changed, 56 insertions(+), 16 deletions(-)

--
I'm pretty sure donuts would help.
