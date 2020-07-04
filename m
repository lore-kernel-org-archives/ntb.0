Return-Path: <rdunlap@infradead.org>
Received: from casper.infradead.org (casper.infradead.org. [2001:8b0:10b:1236::1])
        by gmr-mx.google.com with ESMTPS id s207si1829303wme.4.2020.07.03.20.46.23
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 20:46:23 -0700 (PDT)
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 13/17] Documentation/driver-api: nvdimm: drop doubled word
Date: Fri,  3 Jul 2020 20:44:58 -0700
Message-Id: <20200704034502.17199-14-rdunlap@infradead.org>
In-Reply-To: <20200704034502.17199-1-rdunlap@infradead.org>
References: <20200704034502.17199-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, William Breathitt Gray <vilhelm.gray@gmail.com>, linux-iio@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, linux-nvdimm@lists.01.org, linux-usb@vger.kernel.org, Eli Billauer <eli.billauer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

Drop the doubled word "to".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: linux-nvdimm@lists.01.org
---
 Documentation/driver-api/nvdimm/nvdimm.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200701.orig/Documentation/driver-api/nvdimm/nvdimm.rst
+++ linux-next-20200701/Documentation/driver-api/nvdimm/nvdimm.rst
@@ -73,7 +73,7 @@ DAX:
   process address space.
 
 DSM:
-  Device Specific Method: ACPI method to to control specific
+  Device Specific Method: ACPI method to control specific
   device - in this case the firmware.
 
 DCR:
