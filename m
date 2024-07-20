Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr [80.12.242.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBC03A1C4
	for <ntb@lists.linux.dev>; Sat, 20 Jul 2024 10:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721473193; cv=none; b=ZIa0r1qqEW0wrXWtN7GZRe104VBF1t8RYqyhJdLxZ9OSEOYjXet02aCwKaYYFlqJFbjrVDFXXWhngezimkROyfWTRg16HRWYdN3ao4XcyOm4pVj/nNwSrOp+KxjnT2WNVgj68pzah4dj6RNUvHTmSY+IbLJzxU/uEh0D5zHDUZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721473193; c=relaxed/simple;
	bh=3eJP5D2gLY2qGLsJ+PSb5K2vvmVn2tcyQqDbjoG+glw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZpT0tdmvLeW3o6bY3moXB6Jt25FcCoF2/8VksUL37BNesGSvzxx42qjRAzu8rgn2kvGp78VgfHWoTqaQ8m1nYauZb5MX6R4sgtZBBM6t5Wk/Q2r3oNYwS99L+ceDltRrViXYseIBvT9rpY/HO9pGotCxv+cEfsulx5nLah/Bg7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=lngDg7eb; arc=none smtp.client-ip=80.12.242.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="lngDg7eb"
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id V7oSskCfXOGeaV7oSswaIZ; Sat, 20 Jul 2024 12:59:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1721473182;
	bh=/Oc6zHUJ3PsZDwx3kEOlE52feOVHzNSUSRVZP+ZoPqE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=lngDg7ebFxzciPH9gWGq9jkDnDew+kqNbMu28oDWUv1HQe3IN0S9BsCR/+QTtMeY8
	 EoKSnB367Ck8ERNoIVnSt1oBAJYVGpDGjEojaOYuspkdHrXTOwl7lAsehu/V07s/Yf
	 X2/H5N1Mh2gWqdf2drbimqHXj1KKSAjUMfRPyMvF1eIuk1Y47ITg2tjJ44l5ghYcKL
	 QJGxSn3RiBCvt+o4hEhx/dyn0Ta5EAW7GXBGhrPIyob/Bax9L0Qgg92+84lVOu7lNu
	 FuksPrBHgG3C4Bv1IFGdfyN1PdEM702c3n5d5lO4vI7LelG9o9Ct/cvguEhYT5rlJz
	 dTttig84WNQeA==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 20 Jul 2024 12:59:42 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	ntb@lists.linux.dev
Subject: [PATCH] ntb: Constify struct bus_type
Date: Sat, 20 Jul 2024 12:59:36 +0200
Message-ID: <50a28f39b1f0d0201b2645d2a8239e1819dc924b.1721473166.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct bus_type' is not modified in this driver.

Constifying this structure moves some data to a read-only section, so
increase overall security, especially when the structure holds some
function pointers.

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
  69682	   4593	    152	  74427	  122bb	drivers/ntb/ntb_transport.o
   5847	    448	     32	   6327	   18b7	drivers/ntb/core.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  69858	   4433	    152	  74443	  122cb	drivers/ntb/ntb_transport.o
   6007	    288	     32	   6327	   18b7	drivers/ntb/core.o


Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested-only.
---
 drivers/ntb/core.c          | 4 ++--
 drivers/ntb/ntb_transport.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ntb/core.c b/drivers/ntb/core.c
index d702bee78082..ed6f4adc6130 100644
--- a/drivers/ntb/core.c
+++ b/drivers/ntb/core.c
@@ -72,7 +72,7 @@ MODULE_VERSION(DRIVER_VERSION);
 MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESCRIPTION);
 
-static struct bus_type ntb_bus;
+static const struct bus_type ntb_bus;
 static void ntb_dev_release(struct device *dev);
 
 int __ntb_register_client(struct ntb_client *client, struct module *mod,
@@ -298,7 +298,7 @@ static void ntb_dev_release(struct device *dev)
 	complete(&ntb->released);
 }
 
-static struct bus_type ntb_bus = {
+static const struct bus_type ntb_bus = {
 	.name = "ntb",
 	.probe = ntb_probe,
 	.remove = ntb_remove,
diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 77e55debeed6..a79f68e18d3f 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -314,7 +314,7 @@ static void ntb_transport_bus_remove(struct device *dev)
 	put_device(dev);
 }
 
-static struct bus_type ntb_transport_bus = {
+static const struct bus_type ntb_transport_bus = {
 	.name = "ntb_transport",
 	.match = ntb_transport_bus_match,
 	.probe = ntb_transport_bus_probe,
-- 
2.45.2

