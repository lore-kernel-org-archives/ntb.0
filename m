Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FF822F11
	for <ntb@lists.linux.dev>; Sun,  4 Feb 2024 16:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707063701; cv=none; b=NWBPBLa6uF/3K0Prd3MNTeQBnX9IlYICuv+Z0CZXGMAFpzQ68aD3mWsN+/mu+eTAF0UhRByZee7GrL2r/VLYH053ay1C/1UoEsJFV0avZp+NMFWA1aSVlhFEeKL3i9JC/JU1vgu4av6ZIry8njQFw6Nh4JW+HcOsdpv9/TSZLq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707063701; c=relaxed/simple;
	bh=o2JftdH1Lhh0GDvslzWGXgMsYHPICO40Ht1z1kVrKj0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Spbq3NbdRz8NBlpLqUL67GZKeL7XDiO2Fe9aCkz5EurSpewivzkymxkTqPAuQCuWEsnL3Lrm/bjP3mxEUuE4PVSvm4WD5jiXbqiw1ch19FZ4YjmnurgLvz6sOCV4WMXetjluRPu1RUD61c/B7T+y7RxLIZrRR4nR8pseWy/q+7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=O+Z2XWVv reason="key not found in DNS"; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="O+Z2XWVv"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-53fa455cd94so2736000a12.2
        for <ntb@lists.linux.dev>; Sun, 04 Feb 2024 08:21:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707063699; x=1707668499;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QjiJPQVvtwUyBqU7KJO38zWmQJXbmgfQDFzxeewrpks=;
        b=TM5U7ClHJpxaRzO87mpOzCzYpywslKcTXrhHOlh0EiwL7KOh3m876EtTPpN+2KJiig
         U8iTlvOEdlyTxFaG4ikOrUGJrPWPxj+srNgTqVrjkJh1iOAHbsp+kws+PinhoJr0vbe1
         Ff2L5ET97aoSQ4Rj6WC6b2JgdhXOTMkvI9+h6qH3oB9rDBWNK6nKK7wVusDJA/leLBLo
         SWegaCNcFJXooi/6eXLicl+69KoUhwoiSHskLFBGEqtgb9fMWehAwnBcgBPIPm2/HRdC
         Tao4vKGSKUrGrT2Cf8qWxKsBffhnpoSlailP1PNwHf2aGHQComigV54vO49KMfqf/RS7
         07Ag==
X-Gm-Message-State: AOJu0YwR7fRdrY4Y4H+HpcCv8VxdUeLaIGEKTI5ysRTrbx07PLnfSF8x
	PXrjL7z+H4DaLbwpaIerwXtuHDvI402aKFbcpMUT297hnEHE9+TT
X-Google-Smtp-Source: AGHT+IF8je7qQu/s7vJVwCPZGn/23M5VeoaV3eOb9d1YPqK2zrOabeBIxhivh1P6Nrgc95i9dTRwTQ==
X-Received: by 2002:a05:6a00:2b58:b0:6e0:3329:1044 with SMTP id du24-20020a056a002b5800b006e033291044mr1675780pfb.29.1707063699536;
        Sun, 04 Feb 2024 08:21:39 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUrR1KL5euiahwckJ9aaO9NAK2Z6RDRB7p1VBjX73QYAQuzLb4OEoHaNudmXQ7qO8bV2/O16epE6JYi0bSUCd+hMUAyZ5+pROfdp1p+Qmu4vwfocCgVpQJApXbIQ3n6jjpHR4JWnFxWnf+0QHBxB5H6vbg27cFsay39S3ZX0VnoedM7B6rJXkGFxmdVQwXOYc5e
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id h3-20020aa786c3000000b006ddd112c7c9sm5140654pfo.145.2024.02.04.08.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 08:21:38 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1707063697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QjiJPQVvtwUyBqU7KJO38zWmQJXbmgfQDFzxeewrpks=;
	b=O+Z2XWVvP0UMKrW1QPxP07yofSO2OaCGbAltbXl9QrHxKQiTW4R3a46MLao8mVppQFSQlY
	SoSOPJsMX/Nj7FTZcq9pdZ/VIvZvEVVS+PzwL6W+Iw4bf0BNlXNic4FQN1V7MbbgRnocp8
	M8pdz0FeK1xgwxVSLwa1ek7QZXA0PY4DFP3It8xi5i8VgXJprQz+TwT2dak8WexMN005lC
	r07kNwpgzWxY7q44Bgw+quTsxTdflVyuiJwnFtJmrGbonZwpPEQ6Xs/NWBs6iwSCco5H4o
	qHGQE+QlUnxX89+pqiXVd5klgqTHNbHzpuqfcR6u8d7eFVq2Yq5WhzLmKPSMmw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 04 Feb 2024 13:22:00 -0300
Subject: [PATCH 1/2] ntb: ntb_transport: make ntb_transport_bus const
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240204-bus_cleanup-ntb-v1-1-155184f60d5f@marliere.net>
References: <20240204-bus_cleanup-ntb-v1-0-155184f60d5f@marliere.net>
In-Reply-To: <20240204-bus_cleanup-ntb-v1-0-155184f60d5f@marliere.net>
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
 Allen Hubbe <allenbh@gmail.com>
Cc: ntb@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=991; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=o2JftdH1Lhh0GDvslzWGXgMsYHPICO40Ht1z1kVrKj0=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlv7mrsYfIx/tjByMzOoLAMVwhjhFxyD3oTBQsx
 9ozryIlcb+JAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb+5qwAKCRDJC4p8Y4ZY
 ptUUD/41Qi5N2w1Zlibh7z3PcppcnEYkxeEtme7bJ6LuGKcenNm3iPaZSn6RTbHLtiOa+L0PZEw
 0XIQERCz0BHrUUi4Uk8D1ZN/Zxp571wZVKxO+ecTvI2VEN6fQF8+IavxwfQ0DVu2oSKnR21amY1
 jk1KhtopQFV7+uGEpTZMqSP97drkrRt7niDw+Djt4ub87qA3tn6/0pomPqO9SD3+Q0T2L1Jbqma
 C+VikRZwu2QDV//aOC9eDryjNPVtohb+jdw9Tp6SMiukWF+ZxfYjgTxhv1e23XaUBGe87qaFH9i
 bDZ31lB82p/52hBPyN3UPAMhjufcX86xY+9UriEIt4YoMcuK1yyjsTSYAgCmM/yJ79ZXZYm5ybl
 LsGvERxf7mjEaO/UgfhDh5qIzsrzbQT+Q60zD/KkoPgG2b16ZsaDrY0SjZaKtkK+tI/zomZxo4U
 m0yDhgPpf7OZQSkMQJ2Kb2BL2t9ujImoIHr5S4nEmj8l35Wp2r4J3qU6bQ6pW67ROPhglAiMdgN
 WV7rjiy9ciTHIb6MHeh4NqJ3eUJGrcL80gi6YN8qpkAYmx4bE1j4StlapxxwsSUzgLCS4fRwSrm
 QdNzwp0I+dwmpgPGMt7L7ZHTsIxR7IzRDvP08ljLE4w6Ykvl8j9BGGZVJbJZwuq+qI77UKbjUTK
 1Nh9ackxPgNawgw==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the ntb_transport_bus variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/ntb/ntb_transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index f9e7847a378e..0291d80611dc 100644
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
2.43.0

