Return-Path: <jdmason@kudzu.us>
Received: from mail-qk0-x243.google.com (mail-qk0-x243.google.com. [2607:f8b0:400d:c09::243])
        by gmr-mx.google.com with ESMTPS id t14si799513ywf.18.2017.08.26.20.50.17
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Aug 2017 20:50:17 -0700 (PDT)
Received: by mail-qk0-x243.google.com with SMTP id o184so2926307qkc.4
        for <linux-ntb@googlegroups.com>; Sat, 26 Aug 2017 20:50:17 -0700 (PDT)
Return-Path: <jdmason@kudzu.us>
From: Jon Mason <jdmason@kudzu.us>
Date: Sat, 26 Aug 2017 23:50:14 -0400
Subject: [GIT PULL] NTB bug fixes for v4.13
Message-ID: <20170827035014.GA8789@graymalkin.kudzu.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Hello Linus,
Here are a few NTB bug fixes for 4.13.  Please consider pulling them.

Thanks,
Jon



The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://github.com/jonmason/ntb tags/ntb-4.13-bugfixes

for you to fetch changes up to 0eb46345364d7318b11068c46e8a68d5dc10f65e:

  ntb: ntb_test: ensure the link is up before trying to configure the mws (2017-08-01 15:18:59 -0400)

----------------------------------------------------------------
NTB bug fixes to address an incorrect ntb_mw_count reference in the NTB
transport, improperly bringing down the link if SPADs are corrupted, and
an out-of-order issue regarding link negotiation and data passing.

----------------------------------------------------------------
Dave Jiang (1):
      ntb: transport shouldn't disable link due to bogus values in SPADs

Logan Gunthorpe (2):
      ntb: use correct mw_count function in ntb_tool and ntb_transport
      ntb: ntb_test: ensure the link is up before trying to configure the mws

 drivers/ntb/ntb_transport.c             | 6 ++----
 drivers/ntb/test/ntb_tool.c             | 2 +-
 tools/testing/selftests/ntb/ntb_test.sh | 4 ++++
 3 files changed, 7 insertions(+), 5 deletions(-)
