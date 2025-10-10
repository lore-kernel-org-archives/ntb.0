Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8335222688C
	for <ntb@lists.linux.dev>; Fri, 10 Oct 2025 12:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760099210; cv=none; b=hYRaKAqL6tD/iIrNv8wEdfLC/NW9DH/PiSsd1oQcMnt/S6xCwZcHRoE/Lt05sVZO6pRGRglXiPeO7iGsEQsNXaw7Gf4AhtLa04jLLfA/QWzrmZ0hyJimhVc/630BdOFSDVW0pyrxvtnN0E1xqtuYjir5X1kLFDD3QXrUxA4eqEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760099210; c=relaxed/simple;
	bh=PX9B8k66g5YeGpw1A1Ig4K6GqsxMcbr2aBy03ro+orU=;
	h=From:Date:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OVHv+8D9P4qbnycq5dKYgJW8m4eAaeLSOW7v0MYCMnwhFWsx6lyL3aYvuqXPvHWKpVhEAJXwu9TO+8jVnsUnwY7W3fQ0yG9VjScD/giwOeduuct0F15y6VHdj/CutSqT45J1rMi0bF4doamS++gKoBclyC6yNHAL06BliyjM2WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kudzu.us; spf=none smtp.mailfrom=kudzu.us; dkim=pass (2048-bit key) header.d=kudzu-us.20230601.gappssmtp.com header.i=@kudzu-us.20230601.gappssmtp.com header.b=bQIDgWL1; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kudzu.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kudzu.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kudzu-us.20230601.gappssmtp.com header.i=@kudzu-us.20230601.gappssmtp.com header.b="bQIDgWL1"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4e6d9573c2aso28893881cf.3
        for <ntb@lists.linux.dev>; Fri, 10 Oct 2025 05:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20230601.gappssmtp.com; s=20230601; t=1760099207; x=1760704007; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xrf5ZmorMGG0BuXOb/ZsEyv1LRNCievVRv+1nSG0+KY=;
        b=bQIDgWL1X4VvA4FLBDXMt1RjX1Y8k5m0xv12ODZtdPR3wyJuyxSCOBpDzDqBWXDZNh
         9Sg0r/jbw0VQEEAmpWylLWWZfm9dZjyYAvJXZqJrjrBNU+AHIjwb4vW5wOfFrc/PYpMW
         EJJZTo7qoRanaXPwMrwQNoy5PvVnpmVTbHGVYFHa8eJyh7l9We19RS/PJ82M6qk6iYJa
         LWVO8FxGymHMq1K3NT1Y2XPM3Lw1kOmZ7WGC4p7kENXHBw4jimDZHEvsSrOXfDc6pPoB
         OXVfv6PsDW1W1ZujgfBJ2Ie/73/wbnYpR1Ln94dYSpiqZi4Tv0OmuvdfrbWDhGnICbvS
         4bzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760099207; x=1760704007;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xrf5ZmorMGG0BuXOb/ZsEyv1LRNCievVRv+1nSG0+KY=;
        b=Fetahz3YsJU6KqB/baEjWpr7vg/8fPi7cBfWTt2wuvwoTBJU963Qy0JGB2qyaiKlVd
         yZXyU/Fbg9QI/7M0atStRYAhpijNY/H+c9/L4aR0DSK5+AGfiZFeuLSxYyIrOamp5oXP
         kq5tV0sTNZnQQRRV7Et7NXLCPaVXfWJevA44tI+pWgxP/H+NhZsKbDJ60xPG8Wp2Vyck
         4quvNm5V+o8hmHVKXRy8pRWKh31c8Vjsynsvu3Ee684qW9HYVSw+t8Jwzi3/OsU7R2/4
         AE1os38XqcZpbUqj2IXs+ZxVfvi0xYxsO/tVvLwuF2P0IpGKEoOzy33vzEpyCDlvH1hU
         yt+g==
X-Forwarded-Encrypted: i=1; AJvYcCVk+GLA9N6a7eCL5x0Gm+cYQKnsudVgH8nG3TuGwM5luj2HCQJe0mOsjWnZB964HEMFArM=@lists.linux.dev
X-Gm-Message-State: AOJu0YzVe7GKT88B9HOaf/TJ5U+ffpTTd7abi9ietJqZNKs0wX3oMOuJ
	KvyEVBOOLRf4X5cf752OVU4ioGDVObt8gwkKI4kGjTbfsHmEVD3XJO1/oQWfmld6xg==
X-Gm-Gg: ASbGncsp1wNDkNI5CldgMKd27+ts7cV9UrCtmWGErsl0Qc8zMrft4jS21vj/qxKrgvV
	zCwijfnRp9DSid9kNo7d56ijSIDjAOsq9KeoFZbOPPkS/IrpbzevTtiNArxMSzSdr5aSO4Ulgdf
	slj2m6C/QnZC0pOUCdosey5OuONpmXBy5jEUEXhXHefczlOAHy66wnHmdLCTVzfmY3NldDHN1oE
	xuoZAUmYLBHzwr0+vJyNUOqMln5G02S1kxM+I9K7wIrhtyhWhBScONqMagfV/0CSbrn7IHY0oEM
	JbUFSNAPXXau0F9X1fX9dRA9tEnddcD9mUECrGcLhS5+sb2bgm8Ejm4/wcMa+LYsf/oamLsyd+m
	OMwer1fWYJBzXBmKZlPmZk1ii+0C2L90j
X-Google-Smtp-Source: AGHT+IFWlqSZfOgtooYr5mvAawvwnK23V9obB0l1oEdeoDOyt34Lx4eI1XsTuexHYBHwo7UfWP+Avg==
X-Received: by 2002:a05:622a:40c4:b0:4b3:26c:bc44 with SMTP id d75a77b69052e-4e6eace79c2mr159296531cf.20.1760099207163;
        Fri, 10 Oct 2025 05:26:47 -0700 (PDT)
Received: from localhost ([136.56.27.188])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87bc35713afsm15183926d6.30.2025.10.10.05.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 05:26:46 -0700 (PDT)
From: Jon Mason <jdmason@kudzu.us>
X-Google-Original-From: Jon Mason <jdm@athena.kudzu.us>
Date: Fri, 10 Oct 2025 08:26:42 -0400
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Subject: [GIT PULL] NTB bug fixes for 6.18
Message-ID: <aOj7glAc85SXWodE@athena.kudzu.us>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Linus,
Here are a few NTB bug fixes and minor updates for 6.18.  The patches
have been in my tree for some time, but the tag is new.
Please consider pulling them.

Thanks,
Jon



The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  https://github.com/jonmason/ntb tags/ntb-6.18

for you to fetch changes up to 006824a1cb3bd4001745a2b1cc83c43fad522851:

  NTB: epf: Add Renesas rcar support (2025-09-22 09:35:21 -0400)

----------------------------------------------------------------
Add support for Renesas R-Car and allow arbitrary BAR mapping in EPF. Update
ntb_hw_amd to support the latest generation secondary topology and add a
new maintainer. Fix a bug by adding a mutex to ensure `link_event_callback`
executes sequentially.

----------------------------------------------------------------
Basavaraj Natikar (2):
      ntb_hw_amd: Update amd_ntb_get_link_status to support latest generation secondary topology
      MAINTAINERS: Update for the NTB AMD driver maintainer

Jerome Brunet (2):
      NTB: epf: Allow arbitrary BAR mapping
      NTB: epf: Add Renesas rcar support

fuyuanli (1):
      ntb: Add mutex to make link_event_callback executed linearly.

 MAINTAINERS                     |   1 +
 drivers/ntb/hw/amd/ntb_hw_amd.c |  18 +++++-
 drivers/ntb/hw/amd/ntb_hw_amd.h |   1 +
 drivers/ntb/hw/epf/ntb_hw_epf.c | 118 +++++++++++++++++++++++-----------------
 drivers/ntb/ntb_transport.c     |   7 +++
 5 files changed, 94 insertions(+), 51 deletions(-)
