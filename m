Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6F63A3823;
	Thu, 12 Mar 2026 05:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773292458; cv=none; b=ictMuNKYt8WZvuoucwfcielMQ/pe2MLKqRyTo+A8DPpY8isJF8nGsv25RWhkIRbJlmXQeIY9X7teSIM9+XSJOWE4GSjwdXFBTOtkAMsfuP5a0d6+lHb5tHlxZ2wVQyMGNAXuRiOOVPyz1LfJ4km3CS8gmNyzUd5ZpPCPgTpKMpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773292458; c=relaxed/simple;
	bh=5BV2tj7yrtmJFZHH3zM3lD9SVSuV5vIfnblrde4VFX8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JnLGjlnN/nzjKm8TwEvMgtlTuLyaMd6YQW0cJcRKpopZNvt4ZgnDpHonmvwP+Zks6FXddwmAvmL+U5vTfcnMkBuh/hoSjdncqN5OdXbo3UlV/snETEnTADO1cXsytSBssDAzrpu9khIWzsTlxRH8w5ARBo79bHt3C3uNFHrYC6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xD1gNmRd; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xD1gNmRd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=T2OItaLgnwfX7X30/8ScB5Em6LMffj8O35tmDx0lrlw=; b=xD1gNmRd7kQSlZXGxUK4C8zIke
	D0P3E5x9cky8yX0i+hX9tG8LMgjhoeLS0TVVLllJM8lSiW75o5ikzgExd65jNhtpFl7J65QPuRaCS
	msnVy+mmDcom3hX0ZgvEDrwKd64/LzH9PgP0WXhufuNap/ruyQ34pPR0EO1VBmAAhCxwqzbVM7Rys
	6jti6o6T7vikWo40nuYKP7B4KYKLVcwq14IgrlWDdoJYYN5TpIn4dXY0HDnQ3KAeUOlkGXHe9F57P
	qdlAPizNUnckNH+sONR9LOtzBe9gqrHgi/Y0awgS01PjzBp3MdrBOnjHQUg7YXwSvTPw1+aZvgh39
	3Uxp4EQA==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0YNE-0000000DL93-1ro1;
	Thu, 12 Mar 2026 05:14:16 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	ntb@lists.linux.dev
Subject: [PATCH] NTB: fix kernel-doc warnings in ntb.h
Date: Wed, 11 Mar 2026 22:14:15 -0700
Message-ID: <20260312051415.683874-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct a function name and function parameter name to avoid
kernel-doc warnings:

Warning: include/linux/ntb.h:575 expecting prototype for
 ntb_default_port_count(). Prototype was for ntb_default_peer_port_count()
 instead
Warning: include/linux/ntb.h:590 function parameter 'pidx' not
 described in 'ntb_default_peer_port_number'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Jon Mason <jdmason@kudzu.us>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Allen Hubbe <allenbh@gmail.com>
Cc: ntb@lists.linux.dev

 include/linux/ntb.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20260311.orig/include/linux/ntb.h
+++ linux-next-20260311/include/linux/ntb.h
@@ -563,7 +563,7 @@ void ntb_msg_event(struct ntb_dev *ntb);
 int ntb_default_port_number(struct ntb_dev *ntb);
 
 /**
- * ntb_default_port_count() - get the default number of peer device ports
+ * ntb_default_peer_port_count() - get the default number of peer device ports
  * @ntb:	NTB device context.
  *
  * By default hardware driver supports just one peer device.
@@ -578,7 +578,7 @@ int ntb_default_peer_port_count(struct n
 /**
  * ntb_default_peer_port_number() - get the default peer port by given index
  * @ntb:	NTB device context.
- * @idx:	Peer port index (should not differ from zero).
+ * @pidx:	Peer port index (should not differ from zero).
  *
  * By default hardware driver supports just one peer device, so this method
  * shall return the corresponding value from enum ntb_default_port.
