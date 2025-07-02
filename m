Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CD5288CA4
	for <ntb@lists.linux.dev>; Wed,  2 Jul 2025 16:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751474929; cv=none; b=CGOOBA8EvdWs0peNeMycYnyt2T25AXuqhC5uL7x0pcMCQTRoCycYVVKAFwMpIgaKLTkU1z/cb5lo0pHOh5XMMdxp0aNXYcE3umG+xnvrDL8pllSGLFztPw1NNK8jf9iHK0hM9ozz6P8VNLkfUvQvUWdYrL/TaY3+pxTYLHctrJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751474929; c=relaxed/simple;
	bh=UVwuQqNuVkaXad1gSP5IG0Q61XDJHBqnS6AA8i/xzYQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hoamr5WFFyMmMzRUGunBOwgHCuu4MOZZbMb2uXYYvIBtEBdrDRNKL0IcDKxrDUueWby+DpKT+wTV1BVYfpoV7D4huKz2ptvbLB/JbGR9PcVPb3SJCMU2LSGadQ6LKf4Olh2RB4UxFgZELdJ3qzhtkLnjLo+s+SFcR7D6btBiGYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=iD5GwRoS; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iD5GwRoS"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-451d7b50815so35995125e9.2
        for <ntb@lists.linux.dev>; Wed, 02 Jul 2025 09:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751474926; x=1752079726; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f41VpQcQDm5IrtOyRO5moqw5pFrZWSUi6EXtMoj+mX0=;
        b=iD5GwRoSl9CIiTXBumkZoxxLBAJHu9hK/WmrlB1Slr+31csxQvSLql2da/rGbumYrV
         CdQoTRhnqYYHk5njoPoaeHGGaYdHoaS8qQKLYTfffsXHxehNL2t0evhAMBLXI/AwiV86
         +eoz2p8NW+H7mCy1meZ8HnNp0itdmmxUVqOWX7Z8vnpUdjBKNiW7DpSr9JAOSfZP0Lrz
         BQIwtud7XVsfrQhEKg0nlyzINRBq9GC/tOviQ/TdNNsScn4c5USxSVjPYmBKqkP/vnVl
         pHweqzp/upyjnBXZO3aENf7zv0TEHP8Gu5hu4OgeH8rKp49FyUXrwGSnZHzNVrTOFNSZ
         j/sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751474926; x=1752079726;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f41VpQcQDm5IrtOyRO5moqw5pFrZWSUi6EXtMoj+mX0=;
        b=cz5idhEOVRGZ2zkk93AKUBAqYC3mcVkJxLfVNrk3VwIJ9vg2b0abmEJeRQdPlL+A5u
         u0oE80YLjr5/O/bOe8eFTsS8GQZ4tOjTDm3brEBzsHDv2t+y+1xQclyUHNdDjSLmvsJA
         z3PpXwKAAuOudHaDnthcF4TZG9bVId0fpohgbgN/QvhccxLsKZLGBFSvBbhTfd8D66dE
         9T0Arbo8iW21QsK0jzexaqKnX49+nUgme0ZICRoHb0lphaNCVn5Uo21wRFJcHO4l04fE
         23EhNhbZKxpwtHKPiEDDrBNumbL2PosA97sgxlErlVs9x6F6aSnKS3+16TSAFnl0aQ43
         PPTw==
X-Gm-Message-State: AOJu0Yw0/v/5cFYKVfmTW2o0mg5rdFz6i+t8nmRm7DOZ9szsiD04OQqP
	tKeleNkAA/T0YJAHgDxoGtnxQAtnfqOpkFfgfu+dURtiexOzpBLeVZRjEDB6vVzpmqw=
X-Gm-Gg: ASbGncv8hLKMfRcsMETrxY1D9VxqeMtlxA1Bs2QN0/MrWP8GvIgSc0uj3/5Vxb/eKKV
	8Fnm3ikvzQDCna0kfTM9rJ1jmqEFxmAnSsHtwxpRw8lEHUI4TkPyfGo1oVHtXY5XgPA/gG844ML
	gj2Hl1Dsr3Q8QIGxEZ1wyIJ3dQGyh1SzRd6nwcrYFLED8PDOlnDxKhCkE/wF7WszaieBFdzHl/O
	AQkDyos9G2ImPpFpLO7OVlZNALSovmLyyA82Kx5S7S1ZYtLYT+fZXC+elk6gj7ZMYsUcWrHLyL7
	jzh0wq7cRyUVdCNZOA1XZ4vXLZp38RuE6lHE8B8/FdB5mgVmgenWWsqZSMbGqVZoqTO/U5JpwGH
	y4aRht8+k5UY=
X-Google-Smtp-Source: AGHT+IEF430UREJHH7vf0pRs8CX/hqo233o+9B3pP4zeXlWCCJogYacSw896jaCZMSOhbI2fQ/nmhw==
X-Received: by 2002:a05:600c:3488:b0:43b:ce36:7574 with SMTP id 5b1f17b1804b1-454a9c70d55mr4198985e9.11.1751474926049;
        Wed, 02 Jul 2025 09:48:46 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:5542:4bad:e07b:9489])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-454a9bac51bsm2871155e9.39.2025.07.02.09.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 09:48:45 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Wed, 02 Jul 2025 18:48:34 +0200
Subject: [PATCH v3 2/2] NTB: epf: Add Renesas rcar support
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-ntb-rcar-support-v3-2-4268d9c85eb7@baylibre.com>
References: <20250702-ntb-rcar-support-v3-0-4268d9c85eb7@baylibre.com>
In-Reply-To: <20250702-ntb-rcar-support-v3-0-4268d9c85eb7@baylibre.com>
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
 Allen Hubbe <allenbh@gmail.com>
Cc: ntb@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.li@nxp.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1368; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=UVwuQqNuVkaXad1gSP5IG0Q61XDJHBqnS6AA8i/xzYQ=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBoZWLqPkQ+LD2rVrcvB3II9FHT3xPQiO7pwu8rj
 0U8zFjJPAaJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCaGVi6gAKCRDm/A8cN/La
 hRe3D/914t0bWXIEhiaKx0rY8Bb1mK9VHQPQrSfCF7xX9dpRlnDBeGng8EKipRl5t6y6twhVFFj
 7U+655hs2loVYgumvp6rnAAQlaEnXnHIn7oKxtTKr3F55qe5rdMuv97MjiVCdBJvRtvybjG1SQU
 +rq2dREWzYN40rR0kHmtEge/aenhIavHWRV0PziaqoR4wIzwKFRDimFEzSgBieqt3HaEqUYfTeU
 SNfcniEQncvHADCCXGgLZFRZazKfZ8pET3DLzihPxdL4H5SX0h13/U2fkCmcuWM7QSZeNhcNGrv
 PqYE15tCerYqrZ5fWkxygVT674pya5BsKBP66m1Dfl2mn2z/qmewZNPQ0M9rWm4qGau5gUwfMiL
 w/TWiPzJ1wDUBucNIS3HL3/VovbCTVxy+EhCE+TNcRHyiLXmVHuyVJwApWgUfNnhSXd/vogJMZn
 GD977JAkR+MXzSdI8QETyaNCnSzmVPLQnc9hfmuckTnKQWnXYm6qC4mfcWAWPk5NmOx5foNFej5
 dK0HH1EU00/LbXHXuuGO4+y3YHQTiCRqe5GLlxnmA6u6QvJJfy6kIssYbmmtFCRY+0ueHUK10J6
 dZonA8PPbLPaKjkXodCMQtbBZZ5qwupNjMTDkCtG6fa9PZ18YkggXMyIeMMr+o5gi7LjC7AADyS
 E5rBvbkvV6l2SRg==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

Add virtual non-transparent bridge support for Renesas rcar platform

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/ntb/hw/epf/ntb_hw_epf.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index 2b51156e01b0f22ef282d80c08c22af92f49307b..d3ecf25a516253e4e774e3bd835745509ef128ba 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -747,6 +747,16 @@ static const enum pci_barno mx8_map[NTB_BAR_NUM] = {
 	[BAR_MW4]	= NO_BAR
 };
 
+static const enum pci_barno rcar_barno[NTB_BAR_NUM] = {
+	[BAR_CONFIG]	= BAR_0,
+	[BAR_PEER_SPAD]	= BAR_0,
+	[BAR_DB]	= BAR_4,
+	[BAR_MW1]	= BAR_2,
+	[BAR_MW2]	= NO_BAR,
+	[BAR_MW3]	= NO_BAR,
+	[BAR_MW4]	= NO_BAR,
+};
+
 static const struct pci_device_id ntb_epf_pci_tbl[] = {
 	{
 		PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_J721E),
@@ -758,6 +768,11 @@ static const struct pci_device_id ntb_epf_pci_tbl[] = {
 		.class = PCI_CLASS_MEMORY_RAM << 8, .class_mask = 0xffff00,
 		.driver_data = (kernel_ulong_t)mx8_map,
 	},
+	{
+		PCI_DEVICE(PCI_VENDOR_ID_RENESAS, 0x0030),
+		.class = PCI_CLASS_MEMORY_RAM << 8, .class_mask = 0xffff00,
+		.driver_data = (kernel_ulong_t)rcar_barno,
+	},
 	{ },
 };
 

-- 
2.47.2

