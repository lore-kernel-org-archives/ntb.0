Return-Path: <Sanju.Mehta@amd.com>
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (mail-eopbgr740088.outbound.protection.outlook.com. [40.107.74.88])
        by gmr-mx.google.com with ESMTPS id u13si265232iof.2.2019.02.15.01.17.53
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 01:17:53 -0800 (PST)
From: "Mehta, Sanju" <Sanju.Mehta@amd.com>
Subject: [PATCH 0/4] bug fixes in ntb_hw_amd and ntb_perf
Date: Fri, 15 Feb 2019 09:17:51 +0000
Message-ID: <1550222224-26475-1-git-send-email-Sanju.Mehta@amd.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
To: "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>, "jdmason@kudzu.us" <jdmason@kudzu.us>, "dave.jiang@intel.com" <dave.jiang@intel.com>, "allenbh@gmail.com" <allenbh@gmail.com>
Cc: "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Mehta, Sanju" <Sanju.Mehta@amd.com>
List-ID: <linux-ntb.googlegroups.com>

From: Sanjay R Mehta <sanju.mehta@amd.com>

Add bug fix for ntb_perf and ntb_hw_amd

Sanjay R Mehta (4):
  NTB: ntb_perf: Increased the number of message retries to 1000
  NTB: ntb_perf: Disable NTB link after clearing peer XLAT registers
  NTB: ntb_perf: Clear stale values in doorbell and command SPAD
    register
  NTB: ntb_hw_amd: set peer limit register

 drivers/ntb/hw/amd/ntb_hw_amd.c |  8 ++++----
 drivers/ntb/test/ntb_perf.c     | 14 +++++++++++---
 2 files changed, 15 insertions(+), 7 deletions(-)

--=20
2.7.4

