Return-Path: <rdunlap@infradead.org>
Received: from casper.infradead.org (casper.infradead.org. [2001:8b0:10b:1236::1])
        by gmr-mx.google.com with ESMTPS id i18si778663edr.1.2020.07.03.20.45.57
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 20:45:57 -0700 (PDT)
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 08/17] Documentation/driver-api: media/cec-core: drop doubled word
Date: Fri,  3 Jul 2020 20:44:53 -0700
Message-Id: <20200704034502.17199-9-rdunlap@infradead.org>
In-Reply-To: <20200704034502.17199-1-rdunlap@infradead.org>
References: <20200704034502.17199-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, William Breathitt Gray <vilhelm.gray@gmail.com>, linux-iio@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, linux-nvdimm@lists.01.org, linux-usb@vger.kernel.org, Eli Billauer <eli.billauer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

Drop the doubled word "the".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org
---
 Documentation/driver-api/media/cec-core.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200701.orig/Documentation/driver-api/media/cec-core.rst
+++ linux-next-20200701/Documentation/driver-api/media/cec-core.rst
@@ -341,7 +341,7 @@ So this must work:
 	$ cat einj.txt >error-inj
 
 The first callback is called when this file is read and it should show the
-the current error injection state:
+current error injection state:
 
 .. c:function::
 	int (*error_inj_show)(struct cec_adapter *adap, struct seq_file *sf);
