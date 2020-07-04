Return-Path: <rdunlap@infradead.org>
Received: from casper.infradead.org (casper.infradead.org. [2001:8b0:10b:1236::1])
        by gmr-mx.google.com with ESMTPS id i66si361030lji.4.2020.07.03.20.45.18
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 20:45:18 -0700 (PDT)
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 00/17] Documentation/driver-api: eliminate duplicated words
Date: Fri,  3 Jul 2020 20:44:45 -0700
Message-Id: <20200704034502.17199-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, William Breathitt Gray <vilhelm.gray@gmail.com>, linux-iio@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, linux-nvdimm@lists.01.org, linux-usb@vger.kernel.org, Eli Billauer <eli.billauer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

Remove occurrences of duplicated words in Documentation/driver-api/.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: linux-iio@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org
Cc: Jon Mason <jdmason@kudzu.us>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Allen Hubbe <allenbh@gmail.com>
Cc: linux-ntb@googlegroups.com
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: linux-nvdimm@lists.01.org
Cc: linux-usb@vger.kernel.org
Cc: Eli Billauer <eli.billauer@gmail.com>


 Documentation/driver-api/dmaengine/provider.rst        |    2 +-
 Documentation/driver-api/driver-model/platform.rst     |    2 +-
 Documentation/driver-api/firmware/built-in-fw.rst      |    2 +-
 Documentation/driver-api/firmware/direct-fs-lookup.rst |    2 +-
 Documentation/driver-api/firmware/firmware_cache.rst   |    2 +-
 Documentation/driver-api/firmware/request_firmware.rst |    2 +-
 Documentation/driver-api/generic-counter.rst           |    2 +-
 Documentation/driver-api/iio/buffers.rst               |    2 +-
 Documentation/driver-api/media/cec-core.rst            |    2 +-
 Documentation/driver-api/media/dtv-frontend.rst        |    6 +++---
 Documentation/driver-api/media/v4l2-controls.rst       |    4 ++--
 Documentation/driver-api/media/v4l2-dev.rst            |    2 +-
 Documentation/driver-api/ntb.rst                       |    2 +-
 Documentation/driver-api/nvdimm/nvdimm.rst             |    2 +-
 Documentation/driver-api/uio-howto.rst                 |    2 +-
 Documentation/driver-api/usb/URB.rst                   |    2 +-
 Documentation/driver-api/xillybus.rst                  |    2 +-
 17 files changed, 20 insertions(+), 20 deletions(-)
