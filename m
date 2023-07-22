Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCD6EC7;
	Sat, 22 Jul 2023 23:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
	s=default2002; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=lBbeBShkkFDKlYKODKONmviuP1PzwtNjdCIXfLBCH5Q=; b=U/fTHd6XLgHw07JnC6UGT4NDP7
	6R6cEX0o9tbjE+KIcISQVgwOm0QDWaNoCgOyBAaVwp7BQeTo/Q/H9o5Jw/IlXzDznat9zzISccA4q
	0Q0cYlLbu0eKM8OfgpSiLgcdPQkDLFMaMTtz8OOJDaAPHIo5Dele+ZVKuLSOkDJ1pbvx8KM7h21gt
	fLHlfPQ3X8y9fb2Bxkx+Psne3yOJo5NBYmIFaFlm7qNETrhu2Y69GgiSxxxHU6sTYXpP5+qWsng7E
	LLE0C7IgoCrVBouApHS/f13Dp0gD/PuCHmtJjWfYCbwf2LqHHlHc2r7LM9LPkJhJ6mp+k5NQ/pPE5
	mM5OhDDw==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www381.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <lars@metafoo.de>)
	id 1qNLiz-0001HF-P4; Sun, 23 Jul 2023 01:09:21 +0200
Received: from [136.25.87.181] (helo=lars-desktop.lan)
	by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <lars@metafoo.de>)
	id 1qNLiz-000OAF-4P; Sun, 23 Jul 2023 01:09:21 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	linux-pci@vger.kernel.org,
	mhi@lists.linux.dev,
	ntb@lists.linux.dev,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/5] PCI: endpoint: Make pci_epf_ops in pci_epf_driver const
Date: Sat, 22 Jul 2023 16:08:44 -0700
Message-Id: <20230722230848.589428-1-lars@metafoo.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.8/26977/Sat Jul 22 09:27:56 2023)

The pci_epf_ops struct contains a set of callbacks that are used by the
pci_epf_driver. The ops struct is never modified by the epf core itself.

Marking the ops pointer const allows epf drivers to declare their
pci_epf_ops struct to be const. This allows the struct to be placed in the
read-only section. Which for example brings some security benefits as the
callbacks can not be overwritten.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/linux/pci-epf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 3f44b6aec477..34be3f1da46c 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -98,7 +98,7 @@ struct pci_epf_driver {
 	void	(*remove)(struct pci_epf *epf);
 
 	struct device_driver	driver;
-	struct pci_epf_ops	*ops;
+	const struct pci_epf_ops *ops;
 	struct module		*owner;
 	struct list_head	epf_group;
 	const struct pci_epf_device_id	*id_table;
-- 
2.39.2

