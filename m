Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793541430;
	b=ytTQMEwkyZOhf5xr7/x1x0x21MLVqltT8VlS7ZO3RGa+L1emucKPOO9CQlK947f7K7rS
	 A5sg4wyPCGXXPJDzs8FRXPYq4kR1ChKCzJ9rg8H6VCrOmewGzesyNnv5mo6whvUaa80T8
	 aKmVduCQ0r5W/9DwW84/JsBMsb+SK3eK/dK7Eko3DQzSMc8THiJu/IOQZolZxBPYJ4Prg
	 aWuObv73i3Ng2sKTGDMHz8HK5WMgHsFsmfYAsOdaCcQWp/iOx9ZchFVnVrpEVT6ortPS2
	 zT9YhvGV0gpkkjgzBwW+5oUUwcJ3jPzb+KZ4zYmM7oXlGzNblfksryIR5aJUn44e4dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793541430;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1SdeQqahsjgj2IdvxOoLp/IQmogG4OUQWGtiQmCdE7I=;
	b=BnOLgFqNYVDG5ZZddx4UFmMHh76qUqKKS/o6mNhebudXV3eTv6MflzNOJ0RQQrjIedJ4
	 SiMk4DwcmlxQGBMY48EWqF4t4DxTKFyeeQCCmJ1qu6CapUdoAw5YZ+QQKutjz2QrEBs9E
	 0STnivEDq8Ae5Sme62GMpqT4EDb8Yf8FNMjcJcljeKRpO2ZX3c8ddyFrtVtaJRMX3wmCd
	 X82NLfVT99YYDLMBQC+AYYgtxVSbHAyeZMrqlq9WuNpVuB4NvD7YMmYkU4+UezupK2/vn
	 hErRhj6qZkR8oZntIvfrOULKonUyJDCtzHj88EQzsqHf3op9j4jvbLuzDnpSHtGNW/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ck3vk9vg;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E1E606A325
	for <ntb@lists.linux.dev>; Sun,  1 Nov 2026 13:57:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41E1E606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ck3vk9vg
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a2084d62cdso18785135e9.1
        for <ntb@lists.linux.dev>; Sun, 01 Nov 2026 05:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793541428; x=1794146228; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1SdeQqahsjgj2IdvxOoLp/IQmogG4OUQWGtiQmCdE7I=;
        b=Ck3vk9vgCEQSf5hZEmfUG1NWPQRuDb5gVZP8zkgRKrdQtKY2sEOLZQk+k3ZwPMm5Ai
         yatJs0YBwCAVEdxBhMDu20oVByr0QGSZdG2FF7TtKj3s6nhJoMzYv1iv3DiPOLzlDu8l
         m+yxTWsnx/SPG9cz+xdcUFdx/cgMZXVE4hYc6L3YeO3+4D8TgpOSm55mmOeUZkaz1dK5
         fARxc/E2ILSn25tdmEvCSXzzzB3osg+babQwEn1KsOcz+Y1BDb8omDyR32uhtR9kISbx
         bqz7MrzuJLvSBruTxTTVqPQrwH7wjTTa2cnl5JwTZv1QatF+JCtOeofvlmApGCHxPX+6
         r9TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793541428; x=1794146228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1SdeQqahsjgj2IdvxOoLp/IQmogG4OUQWGtiQmCdE7I=;
        b=ZaIJWVq3+b1/1whwHZaPofYG9MOGvP0xggpxfFTqDY86hxiiskv+9VmudO77l0HHVl
         aHOaQ4uBMFSmFcZY40uySRl5+ECRYD7+5n+DTXlv97eplD4JeyxOegVutIAGCnsaXvsL
         W46SdHF2ES51NaqdVqwkBTLb9zmRmFwGMH5uqROVvvVW8xiZWcpmVrfGQfi2SgUZDAbx
         +s7wORbB9Lh/czog74NqtPNP7qYvneFdaDwmFpu5BjX3Wimsd5qCdixz1LRRZBuujIZ+
         snsp6/CVEFB9wrxyKVpL7rmTSCMxO9zy6CJnQWBL8Jcxu9izYMH+OK13KmerwmWOLqxd
         W/uw==
X-Forwarded-Encrypted: i=1; AKwUvBzIxLG1hIi1Sg+TY12kT+Tze9tsro0zpsx573y+NuRKEoiBRm3sZMMuvsWjR+uNuc0YUQU=@lists.linux.dev
X-Gm-Message-State: AFq9FYIxJPyAhlLlV/8cIsGB5RtflOOUJOeG1EdsGVrqrZjczjQ2vzD2
	aK12oN3bxRulHAt84/AWDez0pfBV9GxOwWddZC/wKSJUgSV1ez7Inu4V
X-Gm-Gg: AYBFou0lTs8QLZRdrHMnBBlV1xdNTjIBMih4DOVLIGJ1Z8QdBCQ65yoTeGkC0v0KJ0p
	uaBuyGj02UkOV3NoDGf0hUl2UbwVX0RkC5+zPXoAl2X53fPZi52DXeynfXxqgSmpaK2g6Uk8vXa
	ucK+91yxZ7FQgBk8DegDlgHHL2ZF4ksv2kCjjpFcLwX8QRHDUgRWDxegCz4aXWhaPSJkiGtelOu
	7nKiq6ONTTwKXFLHC3g2dYuu+BeMTo2VvYpQ0qb3iz8uuNqVYksduFy1D11sFg2UVTx+MCjX1wg
	/L+gZwB7nEZnt0oaTU6DHC1pokFXEo0JaaQK+MYh3BTesVY+ywp2pfiELGm19Pc+/8SgfieSorR
	tXnRgJLEzZ9nAiurPiUIAta5sa7yGyB4VkWrH/1vI1ZMeawuBI03jtYfRnGhojy/XXK2Fdqe5tA
	n4IfoPVbZv+YDaq0u8aO+FHbz/SLJsv/O7iL2WO9TyPRhaJcFFA3jZI6mDe0E7kxl7bnV2lW4hr
	vy8eflbwc5PiSEi6ohhY3KZw+vkTpJQh6T7Wvp6Qw6/ocqTchyzH0Y7ZhKlFi/nMPttOC/CEQAZ
	YoDJWII5LPW9pmDv+UCcUOtB/rS6H167eGDIAg==
X-Received: by 2002:a05:600c:1c0f:b0:4a2:150f:1601 with SMTP id 5b1f17b1804b1-4ac1709a7bdmr174788285e9.12.1793541428376;
        Sun, 01 Nov 2026 05:57:08 -0800 (PST)
Received: from LAPTOP-AVI.lan ([2a06:c701:4773:6f00:9c55:89d4:b00d:2bbe])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b789ecsm13856454f8f.29.2026.11.01.05.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 05:57:07 -0800 (PST)
From: Avi Weiss <thnkslprpt@gmail.com>
To: Jon Mason <jdmason@kudzu.us>
Cc: Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Koichiro Den <den@valinux.co.jp>,
	Frank Li <Frank.Li@nxp.com>,
	ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Avi Weiss <thnkslprpt@gmail.com>
Subject: [PATCH v2 0/2] NTB: epf: serialize MW setup and report reliable errors
Date: Sun,  1 Nov 2026 15:57:04 +0200
Message-ID: <cover.1793540847.git.thnkslprpt@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Post: <mailto:ntb@lists.linux.dev>
List-Help: <mailto:ntb+help@lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
List-Owner: <mailto:ntb+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes two related NTB EPF memory-window issues.

The first patch serializes shared MW parameter writes with command
submission, preventing concurrent setups from using each other's
DMA addresses.

The second patch propagates definite endpoint command errors while
completion status can still be associated with the current command.

Changes since v1:

- koichiro pointed out that an endpoint may complete CONFIGURE_MW after
the host times out. Propagating -ETIMEDOUT can cause clients to free
DMA memory while the endpoint is still configuring the mapping.

Returning success only for the timed-out command avoids that immediate
regression, but was insufficient in the end b/c a late error from 
command A may be observed during command B. Returning that stale error
can cause B's buffer to be freed before B completes.

The second patch records whether any command has timed out and
preserves the original MW return behavior thereafter.

The first patch also prevents a pre-timeout regression: without
parameter serialization, propagating an explicit rejection from one
setup can release memory referenced by another concurrent setup.

v1: https://lists.openwall.net/linux-kernel/2026/10/27/2144
Review: https://lists.openwall.net/linux-kernel/2026/10/28/466

Avi Weiss (2):
  NTB: epf: serialize memory window parameter writes
  NTB: epf: propagate MW command errors while status is reliable

 drivers/ntb/hw/epf/ntb_hw_epf.c | 37 ++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 8 deletions(-)


base-commit: cbbddb6b08cc9900a87cccaa9b22bbe06aa4f50a
-- 
2.43.0

