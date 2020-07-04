Return-Path: <rdunlap@infradead.org>
Received: from casper.infradead.org (casper.infradead.org. [2001:8b0:10b:1236::1])
        by gmr-mx.google.com with ESMTPS id 14si778904wmk.1.2020.07.03.20.46.03
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 20:46:03 -0700 (PDT)
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 09/17] Documentation/driver-api: media/dtv-frontend: drop doubled word
Date: Fri,  3 Jul 2020 20:44:54 -0700
Message-Id: <20200704034502.17199-10-rdunlap@infradead.org>
In-Reply-To: <20200704034502.17199-1-rdunlap@infradead.org>
References: <20200704034502.17199-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, William Breathitt Gray <vilhelm.gray@gmail.com>, linux-iio@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, linux-nvdimm@lists.01.org, linux-usb@vger.kernel.org, Eli Billauer <eli.billauer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

Drop the doubled word "errors".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org
---
 Documentation/driver-api/media/dtv-frontend.rst |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-next-20200701.orig/Documentation/driver-api/media/dtv-frontend.rst
+++ linux-next-20200701/Documentation/driver-api/media/dtv-frontend.rst
@@ -244,7 +244,7 @@ Carrier Signal to Noise ratio (:ref:`DTV
     Having it available after inner FEC is more common.
 
 Bit counts post-FEC (:ref:`DTV-STAT-POST-ERROR-BIT-COUNT` and :ref:`DTV-STAT-POST-TOTAL-BIT-COUNT`)
-  - Those counters measure the number of bits and bit errors errors after
+  - Those counters measure the number of bits and bit errors after
     the forward error correction (FEC) on the inner coding block
     (after Viterbi, LDPC or other inner code).
 
@@ -253,7 +253,7 @@ Bit counts post-FEC (:ref:`DTV-STAT-POST
     see :c:type:`fe_status`).
 
 Bit counts pre-FEC (:ref:`DTV-STAT-PRE-ERROR-BIT-COUNT` and :ref:`DTV-STAT-PRE-TOTAL-BIT-COUNT`)
-  - Those counters measure the number of bits and bit errors errors before
+  - Those counters measure the number of bits and bit errors before
     the forward error correction (FEC) on the inner coding block
     (before Viterbi, LDPC or other inner code).
 
@@ -263,7 +263,7 @@ Bit counts pre-FEC (:ref:`DTV-STAT-PRE-E
     after ``FE_HAS_VITERBI``, see :c:type:`fe_status`).
 
 Block counts (:ref:`DTV-STAT-ERROR-BLOCK-COUNT` and :ref:`DTV-STAT-TOTAL-BLOCK-COUNT`)
-  - Those counters measure the number of blocks and block errors errors after
+  - Those counters measure the number of blocks and block errors after
     the forward error correction (FEC) on the inner coding block
     (before Viterbi, LDPC or other inner code).
 
