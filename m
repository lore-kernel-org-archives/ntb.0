Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F2236404E
	for <ntb@lists.linux.dev>; Thu,  7 May 2026 07:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778139673; cv=none; b=tRIkVjmbXPqDPePp3e3JuuFA77KjuuoNxxF0W5yiAZ74Y+Ff1LqSywLanC7G86ZJJJKUNxDzaCPTzvXEo7w/TUWtOI2fq7HJA4vw6qjembiO0pZqupQOYlCfML8yVI5uiEyqi7vojBZ29YrYriWOCVxoLAKAVPYDaBn/E+9JuK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778139673; c=relaxed/simple;
	bh=zYn0NAbMIemhcf9KQ7HHXMBNR44M5VU7D/E/Bh5tCuY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sS9Sj7d1RUkVv8JKIHJfMYhU8T1778xF3yVUWm6XWY4qlshra9sVRXlS/hv5ki+xFZ+6Af/p/0Y0WpORCWvB5EjyKNLFAX0Vw/jdPVXx3ZjgzuRDd/a4znixBr73fPro2PyOoY4aPDyQmM9BxOPdX9HxDPv9xu2KDsyFndkjEmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=jHvcU9WY; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="jHvcU9WY"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-449d6c68ed8so435668f8f.0
        for <ntb@lists.linux.dev>; Thu, 07 May 2026 00:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778139668; x=1778744468; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TDs0FjTJGyLZfxxKCIU9nMCf+BNfVsDVGApUmlQVDlk=;
        b=jHvcU9WYl25q8sg30PMp8/n+41N+mx07kuzuW+ar1FueSItBRe0/WqF4qogtS+7cj/
         Xx38kUI33QcggoZOzR9z9O5rYhPqzbeBdA8GUh8eAmGpwQCk9A82CwRQ0Od+VQWAEns0
         MqnNxAJQhvUyJErmu2Yhu8fR/5Prs397U6/5V0Pk+DKqqLZ7H4spr3DdYQe7PpiJxnRS
         1xfmlfEL46yTrh4l8k704spGlyXrWpF3bsWik4bZ2h8BOeL0lUWy3FfxeseUimhOoP0Y
         LIrHCzWD598SNC5tBH8OOwrCGdpgytmaKZ+A8b83Y1nWArzQdRaM3sHc41upA4mSbTb4
         AKYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778139668; x=1778744468;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TDs0FjTJGyLZfxxKCIU9nMCf+BNfVsDVGApUmlQVDlk=;
        b=blGZqRf4h+0vQTN4hn5YzLgLus/FNlqRl+HZBkir2EKpLF77vxIqXyw/c7WvoJUdbD
         z2ab0Qy670G/f9aojiYegX5QKNsApz5okt++OHm7b/JWm4ZdijJFMgayfKDD4LssMTqL
         a7VTTfXEinWFeyaJ9Ff/4UieIrDEbPjf01UOQ32fOps9OYRM9MenlAHzMw+qFtSG5l2d
         h/M+LUNcJNekAJ7QbcYYHdJf3YGzdsAOpL6r5D1c0PUTollbvQsF7kVo8Hv4eREVuZbJ
         Vht7VhJQ2NPFozIyhXuico6a07G3/DIWq7pUn+L03X85Zt8m785cu1NSZKqCLvEIvgc4
         +gVg==
X-Forwarded-Encrypted: i=1; AFNElJ8UTmsf1G+FKH7PVHbOInHKD3qroPzH7aMOHzyg/gr2rjQtgV0PxLjGNACHKMq3jk8D2PU=@lists.linux.dev
X-Gm-Message-State: AOJu0YySnKVDzzXzjoiP9QkGeuzM6wgqsPSGh1WB4dSMj78fGuxDutaE
	3XQS94MAkb6qaz3BivR0TN8dR8Yz0HDP7HDFwP9rx65Ftw+bwOGk8Cj3t+W4VypgLcs=
X-Gm-Gg: AeBDievQn7+ro2l1tqk6nJ7g+QBC3p0bNu52cBGnk2l1Y3cbrAavL6lKTlurB6x2bBj
	jil5mLSi4BCpVu0W5iu4779l8HeCJPgSC2PmDEH5g9UPI8FflsDxE58M9X4f4iBXJLkkxusHBoC
	dpJbseGx2rRQ3CbSbRdOU5GXJTLe9vqTga/yp4OhdToBTx3/NE7lrCnCdV3iGRwQkE42znUPM0d
	v9bx6qilmgwfBYk1E7EIjwwYDvIccmd6M91NrUDZPnsx9Nc3YJXWroVLCFqmukpEuCZKmt6hdQz
	v9OJQn3SLVcfbVDMqlnBUi0B+bugXrRKPUmQIjrWTiQdrVUrAXVjGgRzwRDT45YTYHRENyBj5IG
	aYG8K7jYOLRDYKGIK2rmTRDp0iE/erBq90AjExIbX60D7EmEHJeEb4kCFejOsqoLnzSRDIO18Xe
	iRxQgTvwg7cO8jMbmvOK2CRL4yFaGgABDQs+Ugs9ceGb4Ejbf+XvrmA4WL/ZFp1wA4ymef+M7XO
	ihE6m0XngbATc1d+e6StQcUBGuBu5gWn8CY
X-Received: by 2002:a05:6000:a86:b0:452:a209:560 with SMTP id ffacd0b85a97d-452a209059emr3208881f8f.28.1778139668151;
        Thu, 07 May 2026 00:41:08 -0700 (PDT)
Received: from localhost (p200300f65f114e08ac341e0bb79e5496.dip0.t-ipconnect.de. [2003:f6:5f11:4e08:ac34:1e0b:b79e:5496])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-45052a48f63sm17954621f8f.16.2026.05.07.00.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 00:41:07 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
	ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ntb: amd: Use named initializer for pci_device_id::driver_data
Date: Thu,  7 May 2026 09:41:01 +0200
Message-ID: <20260507074102.2654314-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4704; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=zYn0NAbMIemhcf9KQ7HHXMBNR44M5VU7D/E/Bh5tCuY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBp/EIObM8Rtcc5+1yOYV1qUxbS+iKJcKfF0+RDc q+r0WJuc96JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCafxCDgAKCRCPgPtYfRL+ Tr34B/0fLp//mb91LE3usxH9TeOtQD8ro7NysCPa1yli0eM/eeIbhwZLwmqOxR66+pCd/yAyn7c N4AwHji7KdBu3lSbR+NElArzKRHF+k9hKylgX7cY1QHqglQCVeq/x1rKo3/AO4+uw7ubt/Zw6Mi xcoMTXchqUYBa27iFPFu2CEhdLA/j7r017JxifqALHGJptPa8bsZgMjBm4N4Rc0GFHdGuup5r/s lCDkAeHrsnHP68TY303p0hpx/dmQhhmC+JB20tqt+W6m/Z/AVE/+j651xzKV+ATeW4nfo/Q+tQ9 M5CqWTkwLeLCCMcvwjyeSrJXQleTLW/Q7JpFp/URo7ivYExX
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The current list initialisation depends on the well hidden two zeros in
the PCI_VDEVICE macro. Instead use a named initialisation that is more
robust and easier to understand.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
Hello,

while being a cleanup that can stand on its own this is also a
preparation for making .driver_data an anonymous union which allows to
do:

	diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
	index 55408b431365..ee77d1235ec4 100644
	--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
	+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
	@@ -1233,7 +1233,7 @@ static int amd_ntb_pci_probe(struct pci_dev *pdev,
			goto err_ndev;
		}

	-	ndev->dev_data = (struct ntb_dev_data *)id->driver_data;
	+	ndev->dev_data = id->driver_data_ptr;

		ndev_init_struct(ndev, pdev);

	@@ -1328,14 +1328,14 @@ static const struct ntb_dev_data dev_data[] = {
	 };

	 static const struct pci_device_id amd_ntb_pci_tbl[] = {
	-	{ PCI_VDEVICE(AMD, 0x145b), .driver_data = (kernel_ulong_t)&dev_data[0] },
	-	{ PCI_VDEVICE(AMD, 0x148b), .driver_data = (kernel_ulong_t)&dev_data[1] },
	-	{ PCI_VDEVICE(AMD, 0x14c0), .driver_data = (kernel_ulong_t)&dev_data[1] },
	-	{ PCI_VDEVICE(AMD, 0x14c3), .driver_data = (kernel_ulong_t)&dev_data[1] },
	-	{ PCI_VDEVICE(AMD, 0x155a), .driver_data = (kernel_ulong_t)&dev_data[1] },
	-	{ PCI_VDEVICE(AMD, 0x17d4), .driver_data = (kernel_ulong_t)&dev_data[1] },
	-	{ PCI_VDEVICE(AMD, 0x17d7), .driver_data = (kernel_ulong_t)&dev_data[2] },
	-	{ PCI_VDEVICE(HYGON, 0x145b), .driver_data = (kernel_ulong_t)&dev_data[0] },
	+	{ PCI_VDEVICE(AMD, 0x145b), .driver_data_ptr = &dev_data[0] },
	+	{ PCI_VDEVICE(AMD, 0x148b), .driver_data_ptr = &dev_data[1] },
	+	{ PCI_VDEVICE(AMD, 0x14c0), .driver_data_ptr = &dev_data[1] },
	+	{ PCI_VDEVICE(AMD, 0x14c3), .driver_data_ptr = &dev_data[1] },
	+	{ PCI_VDEVICE(AMD, 0x155a), .driver_data_ptr = &dev_data[1] },
	+	{ PCI_VDEVICE(AMD, 0x17d4), .driver_data_ptr = &dev_data[1] },
	+	{ PCI_VDEVICE(AMD, 0x17d7), .driver_data_ptr = &dev_data[2] },
	+	{ PCI_VDEVICE(HYGON, 0x145b), .driver_data_ptr = &dev_data[0] },
		{ }
	 };
	 MODULE_DEVICE_TABLE(pci, amd_ntb_pci_tbl);

which is also a nice cleanup *and* further hints at also doing

	diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.h b/drivers/ntb/hw/amd/ntb_hw_amd.h
	index e8c3165fa38b..4ef7bafd21f7 100644
	--- a/drivers/ntb/hw/amd/ntb_hw_amd.h
	+++ b/drivers/ntb/hw/amd/ntb_hw_amd.h
	@@ -186,7 +186,7 @@ struct amd_ntb_dev {
		u32 cntl_sta;
		u32 peer_sta;

	-	struct ntb_dev_data *dev_data;
	+	const struct ntb_dev_data *dev_data;
		unsigned char mw_count;
		unsigned char spad_count;
		unsigned char db_count;

due to a compiler warning. So all in all this yields easier to read
initialisation (not shorter and more compact but easier to grasp),
better type safety and harder to make mistakes due to the added const.

Best regards
Uwe
---
 drivers/ntb/hw/amd/ntb_hw_amd.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index 1a163596ddf5..55408b431365 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -1328,15 +1328,15 @@ static const struct ntb_dev_data dev_data[] = {
 };
 
 static const struct pci_device_id amd_ntb_pci_tbl[] = {
-	{ PCI_VDEVICE(AMD, 0x145b), (kernel_ulong_t)&dev_data[0] },
-	{ PCI_VDEVICE(AMD, 0x148b), (kernel_ulong_t)&dev_data[1] },
-	{ PCI_VDEVICE(AMD, 0x14c0), (kernel_ulong_t)&dev_data[1] },
-	{ PCI_VDEVICE(AMD, 0x14c3), (kernel_ulong_t)&dev_data[1] },
-	{ PCI_VDEVICE(AMD, 0x155a), (kernel_ulong_t)&dev_data[1] },
-	{ PCI_VDEVICE(AMD, 0x17d4), (kernel_ulong_t)&dev_data[1] },
-	{ PCI_VDEVICE(AMD, 0x17d7), (kernel_ulong_t)&dev_data[2] },
-	{ PCI_VDEVICE(HYGON, 0x145b), (kernel_ulong_t)&dev_data[0] },
-	{ 0, }
+	{ PCI_VDEVICE(AMD, 0x145b), .driver_data = (kernel_ulong_t)&dev_data[0] },
+	{ PCI_VDEVICE(AMD, 0x148b), .driver_data = (kernel_ulong_t)&dev_data[1] },
+	{ PCI_VDEVICE(AMD, 0x14c0), .driver_data = (kernel_ulong_t)&dev_data[1] },
+	{ PCI_VDEVICE(AMD, 0x14c3), .driver_data = (kernel_ulong_t)&dev_data[1] },
+	{ PCI_VDEVICE(AMD, 0x155a), .driver_data = (kernel_ulong_t)&dev_data[1] },
+	{ PCI_VDEVICE(AMD, 0x17d4), .driver_data = (kernel_ulong_t)&dev_data[1] },
+	{ PCI_VDEVICE(AMD, 0x17d7), .driver_data = (kernel_ulong_t)&dev_data[2] },
+	{ PCI_VDEVICE(HYGON, 0x145b), .driver_data = (kernel_ulong_t)&dev_data[0] },
+	{ }
 };
 MODULE_DEVICE_TABLE(pci, amd_ntb_pci_tbl);
 

base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.47.3

