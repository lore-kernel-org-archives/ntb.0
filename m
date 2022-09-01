Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7CF6D3F
	for <ntb@lists.linux.dev>; Thu,  1 Sep 2022 18:17:54 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id l65so7864432pfl.8
        for <ntb@lists.linux.dev>; Thu, 01 Sep 2022 11:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=zI/BTKFXJXbsFO1kxQzveFTmwvhlHGn8PgFA+S1jres=;
        b=lbGN4Kp3lRbdgZAgZthVUQrgacQyY9T1ORf4+IRNyEdsR08hfaasoXVs5DtXtNjkTt
         wTxeqEsp7RBY+UWH7L93OCDfVRg9a1qSh9cBwhtS4I6Er4mCMCBHZU5JSui19cnXXiig
         44oPiVPAXmom3N3thvuWvMaOvOfbAWjPKiQSDzINje0Iw3JqQRthMh0s8MIbff5OnpvO
         N9tS9ZKZ0SL5YyBB3QM4IjwgO1zAcad5VDu0Kunmmzc158kOPOqoqYiZnKQaU3pCner0
         QYRlE7l5InBZMbljno6S49tduW45wREpYyIuNPHbDZ1EkbLBhOg8Xve56z8sFCfzHqVq
         iV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=zI/BTKFXJXbsFO1kxQzveFTmwvhlHGn8PgFA+S1jres=;
        b=6jaQcEO6KbnMGXk8bXtezXaGdZ1qa3wiFdeLadixHQh9oq5BDlWFEo2Mn4bsKxouc4
         LpL7ZvafBlx56zBiZfJZniZKGk1bJjJM+2SAmAqgaNlxU+p+yYaWDzc0KiNONBrbqUS8
         4j6YryuVGMNyp2hgjsw4Hp5ls0HM5iyUxpZ/jdSAjoU+IG7xCprC/TXBbun1oZw+4kg7
         l9tn923YsHUyEh1rc6fQUqHRpwJoqIL5bGMvw9Y9DTRs/xq/vI6xvzzz+1n0c+xkXCCu
         Ic1gznsgvOjxlkRj1vuwPKNVSEgxyOPvb1HJrWCWCC+fJqCJRFxyYEBFtx9MRFZX5XPP
         x1mg==
X-Gm-Message-State: ACgBeo3sXh6piVAUuXm/F7ooMumburAz29SX8b2WmQZchZszwqbHeER2
	7WuBPpYmWxS8uGiMp58gGz88bg==
X-Google-Smtp-Source: AA6agR7kM8iGzccwGQ6iMySe4S2grbdHOsy/itfUuKWXsnekyj0x05dNeHnyQVuTcw2HeZHUxsgADQ==
X-Received: by 2002:a05:6a00:88a:b0:53a:b7a0:ea3a with SMTP id q10-20020a056a00088a00b0053ab7a0ea3amr9698501pfj.21.1662056274006;
        Thu, 01 Sep 2022 11:17:54 -0700 (PDT)
Received: from C02F63J9MD6R.bytedance.net ([61.120.150.77])
        by smtp.gmail.com with ESMTPSA id b13-20020a170903228d00b0017519b86996sm6320538plh.218.2022.09.01.11.17.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Sep 2022 11:17:53 -0700 (PDT)
From: Zhuo Chen <chenzhuo.1@bytedance.com>
To: fancer.lancer@gmail.com,
	jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	bhelgaas@google.com,
	ruscur@russell.cc,
	oohall@gmail.com,
	james.smart@broadcom.com,
	dick.kennedy@broadcom.com,
	jejb@linux.ibm.com,
	martin.petersen@oracle.com
Cc: chenzhuo.1@bytedance.com,
	ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-scsi@vger.kernel.org
Subject: [PATCH 2/3] PCI/ERR: Clear fatal status in pcie_do_recovery()
Date: Fri,  2 Sep 2022 02:16:33 +0800
Message-Id: <20220901181634.99591-3-chenzhuo.1@bytedance.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220901181634.99591-1-chenzhuo.1@bytedance.com>
References: <20220901181634.99591-1-chenzhuo.1@bytedance.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When state is pci_channel_io_frozen in pcie_do_recovery(),
the severity is fatal and fatal status should be cleared.
So we add pci_aer_clear_fatal_status().

Since pcie_aer_is_native() in pci_aer_clear_fatal_status()
and pci_aer_clear_nonfatal_status() contains the function of
'if (host->native_aer || pcie_ports_native)', so we move them
out of it.

Signed-off-by: Zhuo Chen <chenzhuo.1@bytedance.com>
---
 drivers/pci/pcie/err.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 0c5a143025af..e0a8ade4c3fe 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -243,10 +243,14 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	 * it is responsible for clearing this status.  In that case, the
 	 * signaling device may not even be visible to the OS.
 	 */
-	if (host->native_aer || pcie_ports_native) {
+	if (host->native_aer || pcie_ports_native)
 		pcie_clear_device_status(dev);
+
+	if (state == pci_channel_io_frozen)
+		pci_aer_clear_fatal_status(dev);
+	else
 		pci_aer_clear_nonfatal_status(dev);
-	}
+
 	pci_info(bridge, "device recovery successful\n");
 	return status;
 
-- 
2.30.1 (Apple Git-130)

