Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E34118784B
	for <ntb@lists.linux.dev>; Sun, 22 Sep 2024 01:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726968447; cv=none; b=tWyXk3Va3LQHl/jK2yUSS65uPD7a0PeoFKbqLwxsfQB7DnMwlOybNaDFBCkvOhhvatO6LiHD6yqLTlAvI2QjiXdBBrPMppdtvbtIBZBDL+ZHm/oRXmXJulgendck/sv0GGvgWqDpe3SBWE1KIF+ZdJByMixY+UnwGNwVIJLkun4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726968447; c=relaxed/simple;
	bh=jhApeWXdt1Yl3qfPidDGfpcHeqO1wsOY63AXNx1p5dA=;
	h=From:Date:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YWN7NCu1a3x86z/PSli68OBm08TBV5vVNV7mcDp3a5B0u+RObKrHTNB58yTVke1rUs9VhXz00g8RckABgyFgA0gwsJ7O8L9m91AU1Wfu/Oky8FuWJnK5aiDYoPjjDUobiZyyvLGMCltmvlqlYLIBOevo1Z6pPuzdR9lPii9bBHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kudzu.us; spf=none smtp.mailfrom=kudzu.us; dkim=pass (2048-bit key) header.d=kudzu-us.20230601.gappssmtp.com header.i=@kudzu-us.20230601.gappssmtp.com header.b=Dpi9cQGV; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kudzu.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kudzu.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kudzu-us.20230601.gappssmtp.com header.i=@kudzu-us.20230601.gappssmtp.com header.b="Dpi9cQGV"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7a99de9beb2so209028285a.3
        for <ntb@lists.linux.dev>; Sat, 21 Sep 2024 18:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20230601.gappssmtp.com; s=20230601; t=1726968444; x=1727573244; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nbFdl7VnXEX4Mb6253inW/2BiKmBhWMhiUAP4BaCSe4=;
        b=Dpi9cQGVfdEn2mtKXQwZ2Vrm2iola6LkJNxYZCl7gNyoUfabO7ErgxiFhIPFz+1Ddl
         ij1toPA2Um6lR+B/Chq3NxjT9K7Ug1eDv2EHCIud/0rCDFLpnBJf+UARXT+pO1XA/Mzt
         UPowQqXkdCTVrNkGvPR9i8NDZw1yF0oq9bRBjEKcUlj7EWCGyE5DQbxRK8r6qY90ADVk
         fX1uv8GHJxid0X5iwk02Ls5c3CroXCKk5O4AefpjkxIIfITVUFQZ1z1V1VGl8b6FSvX6
         l6MEHx0hwjIbLevXjy2Ng6N0eyt5PchMdoiXuTQkpMQVBZrCOKKeoAUd2gj+sK9WJKWq
         iPNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726968444; x=1727573244;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nbFdl7VnXEX4Mb6253inW/2BiKmBhWMhiUAP4BaCSe4=;
        b=j2k6HgBhgxv/TEq2o0fXo9vAW7J6T1F+sGhIn2R+W3LbtywF4BfrsUqcF5XlJcO7zW
         oPkJ1nXs6x8aAC0gv5wY7QHci36/8S45U/CRkmdWXsBZqwpUvo4LvtJl99T4H4zLslOI
         3vWa+8DYVRlBeei6LKH+PNS7GI63TSeXc1oYraQNLGCh0qwGrMAs3fA6PYOcCZgmkV3X
         M5BRl6SuC4+4ezJxUxOpCclGADsG02lveF7EGYo4YPNh5PKv2OjKbvm236fYaqVOPpit
         dKbRu2+Lsj6OLhpQ3mKpMNaualwbdHZkGzoAS1pdlLxaPK5XCCZ1YjSYjPqEjDQ+Rj6h
         F84g==
X-Forwarded-Encrypted: i=1; AJvYcCUNigWsvSgj/WP7XutpRfX//NAv+b/EalvRmUlH2jdRo7kRX+tfRT/78Gckg9apNnhE5GA=@lists.linux.dev
X-Gm-Message-State: AOJu0Yzz93/Bgsl+RouVDZCeWtoyM4O4i8UvG1b+CRry8rnGiLWsb0Jn
	H8ACPRWUFVy1Nmyc7SyWfBewnwbTdllx9zZWjkLNNjlld1kX7ZCac4iFJN4WzA==
X-Google-Smtp-Source: AGHT+IEhl551TnvEEJss7ZzCqTbWO2F19ZkWKlgBIyvPJ3bYZZrKvTQ0j2VVrnpt80t+9fxizdDGYw==
X-Received: by 2002:a05:620a:3908:b0:7a9:bf9f:5ccb with SMTP id af79cd13be357-7acb8d813c1mr1118210485a.1.1726968443952;
        Sat, 21 Sep 2024 18:27:23 -0700 (PDT)
Received: from localhost ([136.54.20.50])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7acb07e01c8sm335928985a.19.2024.09.21.18.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2024 18:27:23 -0700 (PDT)
From: Jon Mason <jdmason@kudzu.us>
X-Google-Original-From: Jon Mason <jdm@athena.kudzu.us>
Date: Sat, 21 Sep 2024 21:27:22 -0400
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Subject: [GIT PULL] NTB bug fixes for v6.12
Message-ID: <Zu9yehc5ZdgUO_Ws@athena.kudzu.us>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Linus,
Here are a few NTB bug fixes for 6.12.  Please consider pulling them.

Thanks,
Jon



The following changes since commit 98f7e32f20d28ec452afb208f9cffc08448a2652:

  Linux 6.11 (2024-09-15 16:57:56 +0200)

are available in the Git repository at:

  https://github.com/jonmason/ntb tags/ntb-6.12

for you to fetch changes up to 061a785a114f159e990ea8ed8d1b7dca4b41120f:

  ntb: Force physically contiguous allocation of rx ring buffers (2024-09-20 10:51:25 -0400)

----------------------------------------------------------------
Bug fixes for intel ntb driver debugfs, use after free in switchtec
driver, ntb transport rx ring buffers.  Also, cleanups in printks,
kernel-docs, and idt driver comment.

----------------------------------------------------------------
Christophe JAILLET (1):
      ntb: Constify struct bus_type

Dave Jiang (1):
      ntb: Force physically contiguous allocation of rx ring buffers

Jinjie Ruan (1):
      ntb: intel: Fix the NULL vs IS_ERR() bug for debugfs_create_dir()

Kaixin Wang (1):
      ntb: ntb_hw_switchtec: Fix use after free vulnerability in switchtec_ntb_remove due to race condition

Max Hawking (1):
      ntb_perf: Fix printk format

Randy Dunlap (2):
      NTB: ntb_transport: fix all kernel-doc warnings
      NTB: epf: don't misuse kernel-doc marker

zhang jiao (1):
      ntb: idt: Fix the cacography in ntb_hw_idt.c

 drivers/ntb/core.c                     |  4 ++--
 drivers/ntb/hw/epf/ntb_hw_epf.c        |  2 +-
 drivers/ntb/hw/idt/ntb_hw_idt.c        |  2 +-
 drivers/ntb/hw/intel/ntb_hw_gen1.c     |  2 +-
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c |  1 +
 drivers/ntb/ntb_transport.c            | 33 ++++++++++++++++++++++++---------
 drivers/ntb/test/ntb_perf.c            |  2 +-
 7 files changed, 31 insertions(+), 15 deletions(-)
