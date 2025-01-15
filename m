Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8E178F3B
	for <ntb@lists.linux.dev>; Wed, 15 Jan 2025 18:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736965725; cv=none; b=j0OPzbDRaPFWfhz2Gh9fGOSIMaEUJZjSATeiJi8gAfDVRza6Q0LHcEtlMEtdmjmbEoJC/Q7BbRVb3x84sDhn1vheKfYi8TFL8q2M2rJXyEzvh45WlZTFzIHIA8U+VpHIkxft9l2YTAQ+Ma8+rr4x9uOyPZJbSGCH0UETTmJGRFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736965725; c=relaxed/simple;
	bh=xNeYzSK3zL2lGDOr6R1RJV1FuHlfXpO8MLFSu4jISbc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k0YYGSu7YzRULW5ukTdSyAvcdyr21W4SPWro43E63wmWJjVRrlGIKFLXtqWUuswn+t90jXavx7tiNgdjDVyxC1pUoH7FaxEBapuobUZtovwo+jlP0i0IpuwVsDxLSrGHbenbMN0gLEAuCSY3UcW9k9K5uGwpn/lv3ffG6IhxKzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=RmfnBgs8; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="RmfnBgs8"
Received: from fpc.intra.ispras.ru (unknown [10.10.165.17])
	by mail.ispras.ru (Postfix) with ESMTPSA id 6BD9E40777BC;
	Wed, 15 Jan 2025 18:28:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 6BD9E40777BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1736965713;
	bh=/8Eyh7O9bpDg/OyeWKB2DrDQebuGwJUMHzlI8f8c3+c=;
	h=From:To:Cc:Subject:Date:From;
	b=RmfnBgs8y57Wtm0yVOvSNzvSKhVWlksCZtzTYLaHayuR9Not45ns5v8AM1L8z2jOs
	 F2NjrTid2xR2NGxl/06rWX3467ONMtDmk8gPZ4quzGQLCtq8BoXKXnwZYmHNJPWx1C
	 cGAPI8AFXjbm2EdaYNJ1jNfiHuFqsHI3ULksVHg4=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Jon Mason <jdmason@kudzu.us>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH] ntb: use 64-bit arithmetic for the MSI doorbell mask
Date: Wed, 15 Jan 2025 21:28:17 +0300
Message-Id: <20250115182817.24445-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

msi_db_mask is of type 'u64', still the standard 'int' arithmetic is
performed to compute its value.

While most of the ntb_hw drivers actually don't utilize the higher 32
bits of the doorbell mask now, this may be the case for Switchtec - see
switchtec_ntb_init_db().

Found by Linux Verification Center (linuxtesting.org) with SVACE static
analysis tool.

Fixes: 2b0569b3b7e6 ("NTB: Add MSI interrupt support to ntb_transport")
Cc: stable@vger.kernel.org
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 drivers/ntb/ntb_transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index a22ea4a4b202..4f775c3e218f 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1353,7 +1353,7 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 	qp_count = ilog2(qp_bitmap);
 	if (nt->use_msi) {
 		qp_count -= 1;
-		nt->msi_db_mask = 1 << qp_count;
+		nt->msi_db_mask = BIT_ULL(qp_count);
 		ntb_db_clear_mask(ndev, nt->msi_db_mask);
 	}
 
-- 
2.39.5

