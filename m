Return-Path: <dave.jiang@intel.com>
Received: from mga03.intel.com (mga03.intel.com. [134.134.136.65])
        by gmr-mx.google.com with ESMTPS id v13si276986pjt.2.2021.02.01.08.12.41
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Feb 2021 08:12:42 -0800 (PST)
Subject: [PATCH] ntb: intel: remove invalid email address in header comment
From: Dave Jiang <dave.jiang@intel.com>
Date: Mon, 01 Feb 2021 09:12:39 -0700
Message-ID: 
 <161219595972.2978237.5196893078187316626.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: jdmason@kudzu.us
Cc: linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Remove Jon's old email address.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/ntb/hw/intel/ntb_hw_intel.h |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.h b/drivers/ntb/hw/intel/ntb_hw_intel.h
index 05e2335c9596..b233d1c6ba2d 100644
--- a/drivers/ntb/hw/intel/ntb_hw_intel.h
+++ b/drivers/ntb/hw/intel/ntb_hw_intel.h
@@ -43,9 +43,6 @@
  *   OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
  * Intel PCIe NTB Linux driver
- *
- * Contact Information:
- * Jon Mason <jon.mason@intel.com>
  */
 
 #ifndef NTB_HW_INTEL_H


