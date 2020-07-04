Return-Path: <rdunlap@infradead.org>
Received: from casper.infradead.org (casper.infradead.org. [2001:8b0:10b:1236::1])
        by gmr-mx.google.com with ESMTPS id p10si877590ljj.7.2020.07.03.20.46.40
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 20:46:40 -0700 (PDT)
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 16/17] Documentation/driver-api: media/v4l2-controls: drop doubled words
Date: Fri,  3 Jul 2020 20:45:01 -0700
Message-Id: <20200704034502.17199-17-rdunlap@infradead.org>
In-Reply-To: <20200704034502.17199-1-rdunlap@infradead.org>
References: <20200704034502.17199-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, William Breathitt Gray <vilhelm.gray@gmail.com>, linux-iio@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, linux-nvdimm@lists.01.org, linux-usb@vger.kernel.org, Eli Billauer <eli.billauer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

Drop the doubled words "type" and "the".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org
---
 Documentation/driver-api/media/v4l2-controls.rst |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20200701.orig/Documentation/driver-api/media/v4l2-controls.rst
+++ linux-next-20200701/Documentation/driver-api/media/v4l2-controls.rst
@@ -335,7 +335,7 @@ current and new values:
 	union v4l2_ctrl_ptr p_new;
 	union v4l2_ctrl_ptr p_cur;
 
-If the control has a simple s32 type type, then:
+If the control has a simple s32 type, then:
 
 .. code-block:: c
 
@@ -349,7 +349,7 @@ Within the control ops you can freely us
 themselves. The p_char pointers point to character buffers of length
 ctrl->maximum + 1, and are always 0-terminated.
 
-Unless the control is marked volatile the p_cur field points to the the
+Unless the control is marked volatile the p_cur field points to the
 current cached control value. When you create a new control this value is made
 identical to the default value. After calling v4l2_ctrl_handler_setup() this
 value is passed to the hardware. It is generally a good idea to call this
