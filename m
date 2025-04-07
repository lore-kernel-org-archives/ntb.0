Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1F927604A;
	Mon,  7 Apr 2025 18:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049846; cv=none; b=EJ886oP84TieMPQj6UQAO1DRpNXputoZrIN8qrXMQQCZDIpIfuIxLGVv3eI6Osv7a85Uzi0MNu+RTpJv4gpYVtFnTKFNVvqxUNCl+nwvdOdUSe1MPXu6Xp56Fseik1yf3VkwkRBH6luNAoViCy+oC1qkdtmcOiN3bFjbbu7OGQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049846; c=relaxed/simple;
	bh=SOK9h3Wb3/41Kn3ijvmrIoKkfNx8JXzgpHVY+lre5DA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kPhdgsT2vlbmqYEoP1oVE2sglat81njyJvbk6sADI2C5KHSN/A4Fv0KhkLT8OzhHjBs3Xt69Vfyaz3H8eVscYFmXPWnxT0OPmMrKYxKRHJeN0+NbQ48W0mGxbt8UJn2JeBPr7WLEDmtEYPeFAUW5CDsd5+kcPInkINQH8P8F+cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZ3fgnLD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZ3fgnLD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 027E4C4CEE7;
	Mon,  7 Apr 2025 18:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049846;
	bh=SOK9h3Wb3/41Kn3ijvmrIoKkfNx8JXzgpHVY+lre5DA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fZ3fgnLDfmRCGhaeHEEUo3zN+YrSBOx9/2JwFttzpgF/0Wuc62Zbxt8nPKlPDHknp
	 gAvCkG6OM2A0HdRawr4jj04Y+cAgaN1YLPc+2fOnKCqzH0nxr8gCdhHldWKznNc9m4
	 PCKE0m4BLJ/1PDic1yHAVGTJJHa45jMAAxfByM5OAxMmHYcQMgP0I2V7JUqZ3oIKQz
	 K1rrepiO6zNslRmSl1DdOsUj4LV+XwB0EDI7Od6SH7AqlNMh2mOPWIipaldc4+ThgJ
	 +HCxfw8Nz5ij5jm3wHY1TDv56XwXNCeXgkD7Qfk3LQePzLN/ourHqbB+4XziREeW0P
	 13KQY2tZFaA1g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	kernel test robot <lkp@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Jon Mason <jdmason@kudzu.us>,
	Sasha Levin <sashal@kernel.org>,
	allenbh@gmail.com,
	fancer.lancer@gmail.com,
	bhelgaas@google.com,
	zhangjiao2@cmss.chinamobile.com,
	pstanner@redhat.com,
	ntb@lists.linux.dev
Subject: [PATCH AUTOSEL 6.12 2/7] ntb: reduce stack usage in idt_scan_mws
Date: Mon,  7 Apr 2025 14:17:13 -0400
Message-Id: <20250407181718.3184348-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181718.3184348-1-sashal@kernel.org>
References: <20250407181718.3184348-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.22
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit aff12700b8dd7422bfe2277696e192af4df9de8f ]

idt_scan_mws() puts a large fixed-size array on the stack and copies
it into a smaller dynamically allocated array at the end. On 32-bit
targets, the fixed size can easily exceed the warning limit for
possible stack overflow:

drivers/ntb/hw/idt/ntb_hw_idt.c:1041:27: error: stack frame size (1032) exceeds limit (1024) in 'idt_scan_mws' [-Werror,-Wframe-larger-than]

Change it to instead just always use dynamic allocation for the
array from the start. It's too big for the stack, but not actually
all that much for a permanent allocation.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/all/202205111109.PiKTruEj-lkp@intel.com/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Jon Mason <jdmason@kudzu.us>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ntb/hw/idt/ntb_hw_idt.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
index 6fc9dfe824747..419de7038570d 100644
--- a/drivers/ntb/hw/idt/ntb_hw_idt.c
+++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
@@ -1041,7 +1041,7 @@ static inline char *idt_get_mw_name(enum idt_mw_type mw_type)
 static struct idt_mw_cfg *idt_scan_mws(struct idt_ntb_dev *ndev, int port,
 				       unsigned char *mw_cnt)
 {
-	struct idt_mw_cfg mws[IDT_MAX_NR_MWS], *ret_mws;
+	struct idt_mw_cfg *mws;
 	const struct idt_ntb_bar *bars;
 	enum idt_mw_type mw_type;
 	unsigned char widx, bidx, en_cnt;
@@ -1049,6 +1049,11 @@ static struct idt_mw_cfg *idt_scan_mws(struct idt_ntb_dev *ndev, int port,
 	int aprt_size;
 	u32 data;
 
+	mws = devm_kcalloc(&ndev->ntb.pdev->dev, IDT_MAX_NR_MWS,
+			   sizeof(*mws), GFP_KERNEL);
+	if (!mws)
+		return ERR_PTR(-ENOMEM);
+
 	/* Retrieve the array of the BARs registers */
 	bars = portdata_tbl[port].bars;
 
@@ -1103,16 +1108,7 @@ static struct idt_mw_cfg *idt_scan_mws(struct idt_ntb_dev *ndev, int port,
 		}
 	}
 
-	/* Allocate memory for memory window descriptors */
-	ret_mws = devm_kcalloc(&ndev->ntb.pdev->dev, *mw_cnt, sizeof(*ret_mws),
-			       GFP_KERNEL);
-	if (!ret_mws)
-		return ERR_PTR(-ENOMEM);
-
-	/* Copy the info of detected memory windows */
-	memcpy(ret_mws, mws, (*mw_cnt)*sizeof(*ret_mws));
-
-	return ret_mws;
+	return mws;
 }
 
 /*
-- 
2.39.5

