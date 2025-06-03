Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8C91A256E
	for <ntb@lists.linux.dev>; Tue,  3 Jun 2025 17:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748970247; cv=none; b=AAu5ifLJRmmccjHgIPV/9CYl6BZxr67kWbWVnyP98n4JpQP3zGKN6WsKtvs4ULcGIaKN9kGq5vxd8CYGPhxl5PT4kTvjsLOnSe+weckETKrS8xYwKCxoU4cSoRv2XAr1K7a21+3F/6/w5QGBP8rvnmvez2NpksSc+jGB5+jjLxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748970247; c=relaxed/simple;
	bh=JozCp67AnlSYShwlsFNUrel1ROhupwez9JoaLcJqwi0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JMto+BYRLv3kuBFUpDq1zYA2oKZyfRPTQA55RAGfX4lLh5DeX4eAKAN3p78Tj9YMUzxZrxk7q8U987MqCdgVa1tlUc0NHPEvvoMJOWj/pnN1wYKJJ75A/E1tcY1cMXSpPpidlEMVs4/9KA2535tzakZfmxTe/lHCdDtKO7kPkbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jazDsO4y; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jazDsO4y"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-442f4a3a4d6so472345e9.0
        for <ntb@lists.linux.dev>; Tue, 03 Jun 2025 10:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1748970243; x=1749575043; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3Ex2bRTEEKAaHGwwEHbqDYgjYKXMrIuwAO6C+EJ6JNE=;
        b=jazDsO4yi/MchRhpDrCUqLMxflgrSLg/6DK7ox6wWyB7DeieKx3bgcZKYq3uNBhtnN
         NEGVyLEKeN4SrGyBxlQBOH5IsPe7Mnujqkmg9jlUpE4vJqiX1dHIOOAXD3iYDbEVv5Z7
         UXCc1vBwE8+NjdrXLeyw8etfo5M+OKE3CtaRUZ1BIyxzpmA8TJdUIGJWWDZpdX70VJ4V
         WKMjVEAIqXxcD/zED1JEhDVWkxGvuRFSz8zqo9+oN5hfZKkXCfzEOyGbcsbWwxqX8ioj
         9UeGT64CU9MvzGkeUU9HL0oeQIq75fj0b42crBYKOFrQoxV6HG/QBu7yvnPV9+AvkOVy
         4HqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748970243; x=1749575043;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Ex2bRTEEKAaHGwwEHbqDYgjYKXMrIuwAO6C+EJ6JNE=;
        b=NykJ4CY7hnVl8KrsRyQa/9kBochpjZ+Ldzj3rlYaEnMIZPZbKEd6nhvyf8aKPxzPQZ
         qQYUs8mvkcGGfygkGnt90FvU511I4ylDaA7fxHshf/KGkWIGVO4uEK0ussWohHqIqn+M
         qO5Npvc2pwSG8VLL8tcKsjEslaho84yIPkz4UZqiHi10tYTFKUI4etIQuHWngnHdEZVM
         HSdaXldzp1Jbcjo04UsHt9TGEZCc40tVQnuyt7z2TP8ScqrCUpnTq0hczdDQTyJUW968
         yvqZqF1dD7gTRveNMWIDMcmNpkks+W7DLKD/cTRyyAAmbjRTDkTgpAuQfRNKDYbd/3NP
         LyFQ==
X-Gm-Message-State: AOJu0YzTIw7ZuLl1Z+f7XlEAD2WW6jsyQNyS3+OIlv3nYK9FDPePdoBD
	khEpOI/qV0hpb0PSvGinZUE0vxQGjT1X00ObV+DgirwVxZlhzl5sIpQ5wBU1e7ZklR4=
X-Gm-Gg: ASbGncujBPmz5UT81I+0sLOS3VBMbB7jPRNiM2x9tD+6AZz0vm032/sUx7NxMYZ/GYl
	14J6i+NAuZcAQhdNtfh0Rs3KlTJsUdHgHMMQRwBnMZ56jyX7k61vbb8C1xxoE7r8MYS9eVkvMCu
	MRmYOgkG9dqoyYmFdIzw9CB86LJYHj0gbuOE0f/GvdkW4fjFIpTihUyKUq+7kpw/iuy5hZtmlRH
	oOctfq50vyMbFEolR6YGx3c55lWe1G8Ucsxw4lvPe2sFViUx7tkKm9ZpY7DA3D7gLNlezGPoVO8
	oSUpI4H+dwA2QZPB3spNLbwlbQLjlvUrbfBtHw78U2LKbUp5+28RB8J1o0P6+vcsdw==
X-Google-Smtp-Source: AGHT+IF5Dhul75lrTEl3J/ypMqK/4hDiuurg9bam0ViaibUWgPSEYcpCtLq+55HUirHbAIfEI2cO9g==
X-Received: by 2002:a05:600c:a03:b0:442:f861:3536 with SMTP id 5b1f17b1804b1-451ef0129a9mr1112745e9.7.1748970242858;
        Tue, 03 Jun 2025 10:04:02 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:ce70:8503:aea6:a8ed])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a4f00972f3sm19165796f8f.69.2025.06.03.10.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 10:04:02 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH v2 0/3] PCI: endpoint: pci-epf-vntb: allow arbitrary BAR
 mapping
Date: Tue, 03 Jun 2025 19:03:37 +0200
Message-Id: <20250603-pci-vntb-bar-mapping-v2-0-fc685a22ad28@baylibre.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOkqP2gC/4WNQQqDMBBFryKz7pQktgpd9R7FRRInOlBjSCRUJ
 Hdv6gXKX70P//0DEkWmBI/mgEiZE6++gro0YGftJ0IeK4MS6i5qMFjG7DeDRkdcdAjsJ2ytbZ3
 r1I36Duo0RHL8ObWvofLMaVvjfr5k+Wv/CLNEgYLEKJVRTvfyafT+ZhPpatcFhlLKFzQV20+7A
 AAA
X-Change-ID: 20250505-pci-vntb-bar-mapping-3cc3ff624e76
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
 Allen Hubbe <allenbh@gmail.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1932; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=JozCp67AnlSYShwlsFNUrel1ROhupwez9JoaLcJqwi0=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBoPyr+4FQSbqXPzNxUs6+o4a40BkRBh1wQbRX37
 8voEuN7k0SJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCaD8q/gAKCRDm/A8cN/La
 heWDEACkRo5R+AWvaG8KCmliu8MLD1sJeFpSmJhITe/w3K55jw+N4hvySZrU5N33Sa8ETogbnfj
 PTHGmakRhQsWEjLMnaq9MrYW/1mUteyRj8GZT8D+q3Ag0xznLCzuoYgHHdUP4dE4s2c7PZcpKHE
 AkDAIARsD/MnIeO2knavb4EyOxZo0o6cGDtiWdnmtw3+JuvhgWunc9LlAje7QaA/5Q7IhMvOlC/
 mJ6jCvKq4ctfXvw/yAH2+yWVVdTSBsocCttcr8ijC5WcIQ2aXvhc7ORBEk0j/ZZGy5lQW3zKMXZ
 FEI8ueAzCdaQ/f3pKSQT7fui11qcUKyxTDIC9v3w9NKWNbNMZAPJBojddW0KsiwD+cLjJcp7jOn
 gS+kcEMRT8JKmQJJG9MwOi0fGILF577h2iAUQpj61VZXzzV1baA5mQmuXym8dWERkER6q1ShC/1
 RcKHdWq8vmTVnWbMfXLbI3o6gi1ACbscmGDxeYV7I2XL877ffiuiXaBCuGICFv9JSPrgDegJe0k
 weOGNimEalQz5YmCbTcErBtSkPGJ/Y+4XR4fcMz+OHlJklsBd2dCMxIuuyeE28kKpLF3So9vx1u
 55tK7l4SWgWoCuHxf06pvvFb0JUy4qE8f3bpEJi4UGFQVJ980k9CZ0q+EvmQOBlLGQp1t6ZKG/a
 +H/ysSoDUjGNx/A==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

The patchset allows arbitrary BAR mapping for vNTB PCI endpoint function.

This was developed for the Renesas platform with requires a mapping that
was not possible before:
* BAR0 (1MB):  CTRL+SPAD
* BAR2 (1MB):  MW0
* BAR4 (256B): Doorbell

It is possible to setup the host side driver with the mapping above without any
functional change but it makes sense to also add arbitrary mapping support
there. This is will be sent in a dedicated series.

The patchset should not change anything for existing users.

Possible next steps:
- Align the NTB endpoint function: I'd be happy to propose something there
  but I would only be able to compile test it since I do not have the HW
  to test it.
- Expose BAR configuration in the CTRL registers: I've been doodling with
  the idea to add a few extra registers in the CTRL region to describe
  the BAR mapping of the other regions. That way, there would less chance
  for the 2 sides to become mis-aligned. I'm not certain it makes sense and
  would welcome others opinion on this :)

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
Changes in v2:
- Align commit description casing style
- Delay adding MW4 enumeration to patch 3
- Apply renaming suggestion on patch 3
- Dropped patch 4 for the NTB: will be re-sent separately.
- Link to v1: https://lore.kernel.org/r/20250505-pci-vntb-bar-mapping-v1-0-0e0d12b2fa71@baylibre.com

---
Jerome Brunet (3):
      PCI: endpoint: pci-epf-vntb: Return an error code on bar init
      PCI: endpoint: pci-epf-vntb: Align mw naming with config names
      PCI: endpoint: pci-epf-vntb: Allow BAR assignment via configfs

 drivers/pci/endpoint/functions/pci-epf-vntb.c | 141 +++++++++++++++++++++++---
 1 file changed, 129 insertions(+), 12 deletions(-)
---
base-commit: db2e86db6ec76de51aff24fb0ae43987d4c02355
change-id: 20250505-pci-vntb-bar-mapping-3cc3ff624e76

Best regards,
-- 
Jerome

