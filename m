Return-Path: <rdunlap@infradead.org>
Received: from casper.infradead.org (casper.infradead.org. [2001:8b0:10b:1236::1])
        by gmr-mx.google.com with ESMTPS id 14si778834wmk.1.2020.07.03.20.45.29
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 20:45:29 -0700 (PDT)
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 03/17] Documentation/driver-api: firmware/firmware_cache: drop doubled word
Date: Fri,  3 Jul 2020 20:44:48 -0700
Message-Id: <20200704034502.17199-4-rdunlap@infradead.org>
In-Reply-To: <20200704034502.17199-1-rdunlap@infradead.org>
References: <20200704034502.17199-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, William Breathitt Gray <vilhelm.gray@gmail.com>, linux-iio@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, linux-nvdimm@lists.01.org, linux-usb@vger.kernel.org, Eli Billauer <eli.billauer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

Drop the doubled word "if".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/driver-api/firmware/firmware_cache.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200701.orig/Documentation/driver-api/firmware/firmware_cache.rst
+++ linux-next-20200701/Documentation/driver-api/firmware/firmware_cache.rst
@@ -27,7 +27,7 @@ Some implementation details about the fi
   uses all synchronous call except :c:func:`request_firmware_into_buf`.
 
 * If an asynchronous call is used the firmware cache is only set up for a
-  device if if the second argument (uevent) to request_firmware_nowait() is
+  device if the second argument (uevent) to request_firmware_nowait() is
   true. When uevent is true it requests that a kobject uevent be sent to
   userspace for the firmware request through the sysfs fallback mechanism
   if the firmware file is not found.
