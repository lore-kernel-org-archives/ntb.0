Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778C54429
	for <ntb@lists.linux.dev>; Thu, 13 Oct 2022 21:49:08 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id g28so3128326pfk.8
        for <ntb@lists.linux.dev>; Thu, 13 Oct 2022 14:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=HU/Gcb/2UahetsVrfFKFSRpifT9WH9AovTUmej45BRM=;
        b=SXetiZgzOZy/gRXhaW1c45RlvPilcMDdnFIzQYxFCkLqDpOjY0zv/u+xapn1G9pin8
         x0aKVLobV7U3pIoDH4luAyRfpGtgJ8G+DbIhypSGdzj2+L9m858860OyjsDJzk4g6yHc
         6Fat5EM06SW6JlueCAJml+Pbsm+KE7dl4WPx2/rhe1trQXOESw3l03tBAABzupHfz+iX
         h4sQ8Ev5HFUYF6pH7RILs1nAGJD72ttEpKbqW6x47Hb7LDpoKY6zKpF6rpSLovkrEn5N
         DmfiV/pupk3XlkkHfh0/bB+7sICDbVsf1h610RdYVs7HHE8zEvkncyoLlVNHQRbTs/1E
         Sq1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:message-id:date
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HU/Gcb/2UahetsVrfFKFSRpifT9WH9AovTUmej45BRM=;
        b=DtcCc+Bp7D6OTabk9J6eOOT07TAHcFST2j1OIZgnQCjJk19h7u5dPuFSKqmLH9J3BZ
         9vki5SRT5zh3ffZXi8F+uplEwF+qe2NYFk9vNDsDhZXjfgBsG7pZiwNHHl2ATcMH9l8k
         SvBc58Ka2UJ4x4aLrvUkGpbVfJq2oqfcxlpG00CULI60HgyGXNrk/kaw3i5/zCupLwXP
         Z62Daodes+YCzg4NrtTinDGR33aLm8nsqKqSzzFdBvXIHb8deU+nw8WtDCAV0apHYHYT
         QlEzcGLuUTeaqEDMwmGdSV26nh851QXvF8NQDmFKVU7MmMeQOTm5A+9NUBNRb/nofn9H
         48bA==
X-Gm-Message-State: ACrzQf34gaHQSex/oLtvg6S+nI+eQWkV14NKw1Z7OfQKm3acYCtsQ6Yg
	IPuoacCHeZy0ud5snaYLLTxJJA==
X-Google-Smtp-Source: AMsMyM60OkHIOwoPqQ6hTn09WuntLhSe+6TG9sOifv9QZgzwwhSqU+qtIUu+gCz5eCx/9FtHd8DBew==
X-Received: by 2002:a65:4585:0:b0:464:4538:c0bc with SMTP id o5-20020a654585000000b004644538c0bcmr1701513pgq.455.1665697747885;
        Thu, 13 Oct 2022 14:49:07 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id z188-20020a6233c5000000b00561c3ec5346sm164607pfz.129.2022.10.13.14.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 14:49:07 -0700 (PDT)
Subject: [PATCH] MAINTAINERS: git://github -> https://github.com for jonmason
Date: Thu, 13 Oct 2022 14:46:38 -0700
Message-Id: <20221013214638.30913-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.38.0
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
  Conor Dooley <conor.dooley@microchip.com>
From: Palmer Dabbelt <palmer@rivosinc.com>
To: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, ntb@lists.linux.dev

Github deprecated the git:// links about a year ago, so let's move to
the https:// URLs instead.

Reported-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://github.blog/2021-09-01-improving-git-protocol-security-github/
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
I've split these up by github username so folks can take them
independently, as some of these repos have been renamed at github and
thus need more than just a sed to fix them.
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c9c396e2d8a0..796ba37dd4ff 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14465,7 +14465,7 @@ M:	Allen Hubbe <allenbh@gmail.com>
 L:	ntb@lists.linux.dev
 S:	Supported
 W:	https://github.com/jonmason/ntb/wiki
-T:	git git://github.com/jonmason/ntb.git
+T:	git https://github.com/jonmason/ntb.git
 F:	drivers/net/ntb_netdev.c
 F:	drivers/ntb/
 F:	drivers/pci/endpoint/functions/pci-epf-*ntb.c
-- 
2.38.0

