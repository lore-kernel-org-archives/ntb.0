Return-Path: <Gary.Hook@amd.com>
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (mail-cys01nam02on0626.outbound.protection.outlook.com. [2a01:111:f400:fe45::626])
        by gmr-mx.google.com with ESMTPS id v77si615287ita.0.2017.05.09.07.33.18
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 May 2017 07:33:18 -0700 (PDT)
Subject: [PATCH V3 0/3] Add/expose control features for the NTB perf test
 module
From: Gary R Hook <gary.hook@amd.com>
Date: Tue, 9 May 2017 09:33:09 -0500
Message-ID: <20170509142856.12995.96207.stgit@taos.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-Path: gary.hook@amd.com
To: linux-ntb@googlegroups.com
Cc: Allen.Hubbe@emc.com, dave.jiang@intel.com, jdmason@kudzu.us
List-ID: <linux-ntb.googlegroups.com>

The goal of this series is to add and expose some control mechanisms for the
performance test module:

 - Provide a switch to allow memory and threads to be anywhere, as
   opposed to only the NTB node.
 - The debug filesystem entries do not need to be retained after they
   are set up. Remove the variables from the context structure and make
   them automatic,
 - Create a debug-fs entry for every module parameter. This allows test
   parameters to be changed, and additional tests to be run, without
   unloading the ntb_perf module each time.

Changes since V2:
 - Use on_node to decide if -anything- is required to be on the NTB node.

Changes since V1:
 - Split patch into appropriate pieces.

---

Gary R Hook (3):
      ntb: Add a module option to control affinity of DMA channels
      ntb: Remove debug-fs variables from the context structure
      ntb: Add more debugfs support for ntb_perf testing options


 drivers/ntb/test/ntb_perf.c |   72 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 54 insertions(+), 18 deletions(-)

--
You can't fix stupid. But you can fix ignorance.
