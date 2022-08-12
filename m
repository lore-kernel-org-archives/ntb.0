Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272F94A03
	for <ntb@lists.linux.dev>; Fri, 12 Aug 2022 19:42:07 +0000 (UTC)
Received: by mail-qt1-f171.google.com with SMTP id l5so1531400qtv.4
        for <ntb@lists.linux.dev>; Fri, 12 Aug 2022 12:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=tRvDJSqP2PRIMIWloi0K1M5QOTLV+IKtWluTnY+gDdk=;
        b=ne8tXHS9XvFbtCPNTt4EzOKXPeOXPayChGUIi0O59otgNNRh9hOvuyIoWuZorZKyHv
         Cx7+EyMWJXUQcAOT2DLbJsV63zOs/uLKTtN6cHa40wFglhAzDCSreSR6Xx+drHLTj6qb
         BUGGbbVEu0laNe60mMgy58Av1pISjznYnbJc0h5u8JmQsbDCnAcKSnLf38ain7txGs0a
         VDYQbllmvWLlM8/h0GugU3g+t3LDl3SXlI71LigR8HWnMlkwY4Pp4I2IOB5GHCVV2oZa
         RUaoCvK9oVpjStRCUI4bRnQoPUgE8KjnUszbC7Ft8jNHedvdtrC7Nd4N4wTdzuofOeK/
         NCfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=tRvDJSqP2PRIMIWloi0K1M5QOTLV+IKtWluTnY+gDdk=;
        b=Ws7eOjPVZ+Hv0ZyJrJL8CF0B+RVDDDX4qmDsPWPE3qgQ+y33RYacG9C9S5BWvpPpt0
         fI2X9I87LHV/1EEldXWiiX4Ss4JKOsPPCYzZv+L2HEm12Pon9tN81s3WhcpzPoXcbH9V
         8n7ODjbrwJ/Qz0k87nK6yfAkNKtaIf48huVq6g282ZeLvM6N8j06I8bYB+QYzau4FMGA
         w4Zh4770R3a6KAA5dIkVMQMpeooNQ5ncEt9lsfirNVTsQQq5G2GIii9srE5TPEqEqBLu
         tkmaHRP7w2wHs7xUepYDm8gnBhgK/+I+l095b5yJKDMZMIGTVpSzWT8B7tXugqyghEq7
         CzCA==
X-Gm-Message-State: ACgBeo2QOZTBkmTy5yJTD42I5zzkR2SOUrwtH7gTOUgFriToAgwmlplL
	lr93aX6vbw1FIuYBwviNvKrHfbXIejQa+KN4fcg=
X-Google-Smtp-Source: AA6agR7KSWAqy9lWStTxVCzxXSLzRWMvDTYS2r4i3Gl1z15R1bxmL/BA95zCBx68zG4qMYnlsxLpeg==
X-Received: by 2002:ac8:5793:0:b0:342:ea28:742f with SMTP id v19-20020ac85793000000b00342ea28742fmr5017715qta.177.1660333326262;
        Fri, 12 Aug 2022 12:42:06 -0700 (PDT)
Received: from localhost ([2605:a601:a608:5600::59])
        by smtp.gmail.com with ESMTPSA id m20-20020ac84454000000b00342fc6a8e25sm2213257qtn.50.2022.08.12.12.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 12:42:05 -0700 (PDT)
From: Jon Mason <jdmason@kudzu.us>
To: ntb@lists.linux.dev
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Frank.Li@nxp.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: add PCI Endpoint NTB drivers to NTB files
Date: Fri, 12 Aug 2022 15:42:05 -0400
Message-Id: <20220812194205.388967-1-jdmason@kudzu.us>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PCI Endpoint NTB drivers are under the NTB umbrella.  Add an entry
there to allow for notification of changes for it.

Signed-off-by: Jon Mason <jdmason@kudzu.us>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 64379c699903..47e9f86bd712 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14254,6 +14254,7 @@ W:	https://github.com/jonmason/ntb/wiki
 T:	git git://github.com/jonmason/ntb.git
 F:	drivers/net/ntb_netdev.c
 F:	drivers/ntb/
+F:	drivers/pci/endpoint/functions/pci-epf-*ntb.c
 F:	include/linux/ntb.h
 F:	include/linux/ntb_transport.h
 F:	tools/testing/selftests/ntb/
-- 
2.30.2

