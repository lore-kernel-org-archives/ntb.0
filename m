Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80537137923
	for <ntb@lists.linux.dev>; Sun, 28 Jun 2026 13:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782654720; cv=none; b=hmfkDslzQiSJkgzMVh+Wry7U3zzoihJZxKrLOkx3eiYHSSZbfVhT9563jPDfbXiaLwLcF4kn1z6LY5BfTlPHZnUxdyUnj3cmqwZiBozAocvE21Cex/olbeV1Sgmqh64c50B7RdvC+nzwDgMocDFnMYjd3cyhgiynijTu+oAfLJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782654720; c=relaxed/simple;
	bh=jLJDN5zBYfT3337H+rOSyCP60vu5635TrWl1qvjuOhM=;
	h=From:Date:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=W0fdH5pIQoTIpJXdcz8/m50j1G+a6qN13Gf7/y75CctVmkP6X3Uwj1odEKQLOk1rthv0llW2Qmqrtm9p6Sqj7y4ZyhSj9lfrE2ipRpwGHFgu/ACuBNwIVl3bCofpsPVC0EXX5cLtwTLBqRThSVRN+Vs62vVT6Z9vmMah0H7fhDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kudzu.us; spf=none smtp.mailfrom=kudzu.us; dkim=pass (2048-bit key) header.d=kudzu-us.20251104.gappssmtp.com header.i=@kudzu-us.20251104.gappssmtp.com header.b=mH80V4ER; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kudzu.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kudzu.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kudzu-us.20251104.gappssmtp.com header.i=@kudzu-us.20251104.gappssmtp.com header.b="mH80V4ER"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8ea70ca4fc8so15138516d6.1
        for <ntb@lists.linux.dev>; Sun, 28 Jun 2026 06:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20251104.gappssmtp.com; s=20251104; t=1782654716; x=1783259516; darn=lists.linux.dev;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:date:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y5jFnyaA1Tu5xl9Ikj52bRRy5PbISu7y67WctS3fbyQ=;
        b=mH80V4ERzX0BPhw4MP7519Nu15zdoH+5AwSpbSx0H6PsUkH861DKlE1J5bbn9vGXBf
         bqnNc7vbJy7ZJ9b1MbilQdKNb1fhjPuXKQ9qC12mmEITmwhT4aK7PbAtr0psImbgvkP0
         6hIKFVYj0ORAA2O6cK0YHl6mTTISHKYCE0d4ZUiggpxprVxTsTaXLemCRXz4p+GPiYXv
         4QsyXyTwwTVrybBRV0Geszzo0h645El+eNVWBz7OPnUuwDPMxQGHLR10umJIwTtQHPFm
         SgJRdjAJHxMLFPodluqzFeTXQH8ZhwuVWro47LrJ7RFzaqAjxofWPsx+kc8lCi3oK4DF
         44Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782654716; x=1783259516;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y5jFnyaA1Tu5xl9Ikj52bRRy5PbISu7y67WctS3fbyQ=;
        b=mlih41u2sBaIBZJtpTIdO8GOS8a6tl9tVLlqzO0aAj5DVnkgD2stIqzNdW3Mqe5T+e
         ZVg4kggflgRsyvlEX+4yk8Jg1ICCzodqUB3iA69TO/P95QwbKfdlWLSrvNUMrYxKDjMf
         YtMrDvA7C/+FcRj0fF+9xYYtX2arXGSMmtvmgUbl7Dp8r4cPY5z7Ic4HT0Is8eR23gP7
         XL3mN/NIcv+1JJZr43e/NWejCZ9KwDf1rBubLOZmKKM4IqPA86ea8nYFZ2byhETTePv1
         t2NBRukrBwlx06VLrmKu5A0OQfubodGQPjzYe8mMx9F8oq89MWQ16h6vt/olS7KPydoH
         v6VA==
X-Forwarded-Encrypted: i=1; AHgh+RplLa4AmN86oOzglGN/KJ3HCRgqYJCyx2UROu/jViEWylXkq7qn1P2c4wFVMOwZgdKc3fs=@lists.linux.dev
X-Gm-Message-State: AOJu0YzU6jgB7E+1EWYIjw4S++WmNKpYgsinojGyPruGEeOnreekZ1DP
	2L/ddG0agahpYlks5HNqwM7DeETb1FQxKUdGR3ncH6/Kcc2VuWSHBRtua+v35qfWjw==
X-Gm-Gg: AfdE7ckTAy8+Ak0/V2VrXBn4gbGEX16AvqgNiY3/m8E/4fjiJo7NNBvwvTdXUB5sWZE
	HHbT0VdAKexBEGDACXh7CiBrx947gih+aRQdpOPOFg58T3moV1QwN6zvcM8wLgF3bbmx0k+daib
	XuhhHq6xWqz6qOPzKIygEBJlxliBZSruUblr1OVPS+IZPUZU3+kWQNMMjyxn+fjehszHJ7+Efhr
	KUobnCusZZbVc0iB7btiNGol/KmnTRglJRYsg1h/z19mqvD4ZRCetnrhg/tnhy+f+YUKE4uc0gv
	Zt4x38VbaX8XUYa3rye7tyGMAHJKBmDHMOh3g8581+kChQmiuiNE+SU/oIVylFQEq32bngEIDgu
	2zXu8yFkv/PE2O4YpLlWmA/0RaMOXLMwowflei6gN0fSwxpXz+PAmc8o5snze3px5rO2MVpLi8J
	VElA==
X-Received: by 2002:a05:6214:130d:b0:8e3:9df3:f4c2 with SMTP id 6a1803df08f44-8e3b6c22c51mr357185296d6.24.1782654716418;
        Sun, 28 Jun 2026 06:51:56 -0700 (PDT)
Received: from localhost ([136.56.27.188])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8e98a3209d2sm68989076d6.14.2026.06.28.06.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 06:51:55 -0700 (PDT)
From: Jon Mason <jdmason@kudzu.us>
X-Google-Original-From: Jon Mason <jdm@athena.kudzu.us>
Date: Sun, 28 Jun 2026 09:51:52 -0400
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Subject: [GIT PULL] NTB bug fixes for 7.2
Message-ID: <akEm-BhGQDImHcmQ@athena.kudzu.us>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello Linus,

Please consider pulling this tag for v7.2.

This is a small collection of NTB fixes that have been around for a
while. Most are documentation and cleanup changes, while the primary
functional fix addresses an EPF teardown path that could trigger an
invalid unmap warning when BARs are shared.

Thanks,
Jon



The following changes since commit 8cd9520d35a6c38db6567e97dd93b1f11f185dc6:

  Linux 7.1 (2026-06-14 15:58:38 +0100)

are available in the Git repository at:

  https://github.com/jonmason/ntb tags/ntb-7.2

for you to fetch changes up to d1c3d45f87e89e5c1fa0769a72a48d1ad99106fc:

  ntb: amd: Use named initializer for pci_device_id::driver_data (2026-06-26 22:18:34 -0400)

----------------------------------------------------------------
NTB updates include an EPF bug fix to prevent an invalid unmap during
device removal, along with documentation fixes and minor AMD driver
cleanups.

----------------------------------------------------------------
Alok Tiwari (1):
      ntb_hw_amd: Fix incorrect debug message in link disable path

Koichiro Den (1):
      NTB: epf: Avoid pci_iounmap() with offset when PEER_SPAD and CONFIG share BAR

Randy Dunlap (1):
      NTB: fix kernel-doc warnings in ntb.h

Uwe Kleine-König (The Capable Hub) (1):
      ntb: amd: Use named initializer for pci_device_id::driver_data

 drivers/ntb/hw/amd/ntb_hw_amd.c | 20 ++++++++++----------
 drivers/ntb/hw/epf/ntb_hw_epf.c |  3 ++-
 include/linux/ntb.h             |  4 ++--
 3 files changed, 14 insertions(+), 13 deletions(-)
