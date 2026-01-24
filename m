Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC57A2836B0
	for <ntb@lists.linux.dev>; Sat, 24 Jan 2026 22:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769294694; cv=none; b=qvVFcfdgCEE+zzRcwzBScjZkaeTLctmlq+rHHMBIvPbfp2nse9dBKU908Qk/9vlWpvpLmdcqzipXmvks85ofzMpnuoNQcJNRzsZLLPDlBmxM34jz+V+bMkJtBtJxN44ZVnSvn3B0yi6FIW/lcnnsBIBaVjlH7F0NiDLMAQBybJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769294694; c=relaxed/simple;
	bh=zas1CqGZJLPQBkFyRs8f/Sr8zPtFDUywHaUfkYq9etE=;
	h=From:Date:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ftWMumfqyrGr67B1kc2TCixdWLJHltwG+vaAOxL7hZSO6RH1fI8pCwxJIEiJ9BGpVXb/iIISnnIi/MiUHKCQM6Sn7ePQQzCmazYKT2yEE0GSgJ5BB1O9QraIdj2iCmffUhCY3SYoGztK3Ci95C0DOE9FyQ6Qf8KYAXqiQnQ/cF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kudzu.us; spf=none smtp.mailfrom=kudzu.us; dkim=pass (2048-bit key) header.d=kudzu-us.20230601.gappssmtp.com header.i=@kudzu-us.20230601.gappssmtp.com header.b=iDzD8tXj; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kudzu.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kudzu.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kudzu-us.20230601.gappssmtp.com header.i=@kudzu-us.20230601.gappssmtp.com header.b="iDzD8tXj"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5014e1312c6so20750211cf.2
        for <ntb@lists.linux.dev>; Sat, 24 Jan 2026 14:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20230601.gappssmtp.com; s=20230601; t=1769294690; x=1769899490; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=svpuiBb9RdWimXKj9okngd0hqRUKHzYYZkjEJlJjwq8=;
        b=iDzD8tXjM0hSQd5b7VHRItegFCKQB3VOoWeJabpCchEMSW7T1n+JqzWxyLLuUA65NE
         gwInyZVoVIqe3ynnUUi9bOs58gCZ3RaU4fbylYtrNB89GcDv9gYoSslI4nMknEBykR+B
         Lzp7CbRhmdcOmUghke575g4CgBKWAjxy273Oz6czHSiSZkxVRecZ1LCQUQk3zx/8FZfJ
         z//R6QNhLXn+i8RbLdf8kfvCYaDm5UAx4ilBtPbTUQ60sHq6xMFDIzXvhYwe8cr4CuZe
         sOuL8/gLHXbcNoY3jP4jiaHErs2z1UTq0geXF+NFJ9vIUlJpkUtSYs1qRxTs3Q7ojk+p
         kM6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769294690; x=1769899490;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=svpuiBb9RdWimXKj9okngd0hqRUKHzYYZkjEJlJjwq8=;
        b=tBkdEFK6tum0RnhNixeJWHq99gIfSAtLGWQNekcVrbXidH1gxPfX81TDgxQ1GyG0Yz
         4Y6I4qDtEJgNSIMIY/bV4qsG02VXanHjT4wxxGGfQe8hj9kSxbp2bOV5+kbKXEevKnQz
         k1bb4aS+ZSX/JqlkhQF2UvnVU86bwfGFk2WfWiLo5aPFaJ9B18EIKdT/PKhVPLgRj3tP
         3m8En/2iyOmqDTGcm+iIasODJlJE1TrIbtWTjMEa118c+W60gqmF8TOMRZj3bX9YmBWj
         cj08sPEjoR8IpfdZgGqflIixHGNfZM9PE1yFwVGSOW6/UrrdLnj0FVxnlrd35rEmN1tu
         4vkA==
X-Forwarded-Encrypted: i=1; AJvYcCV+2Nz15eNx6ZfKOijNRZFGd5VX5uM+41Cqm6jPukDwc9RXozDQ6af5HC4dj+uMsV3R3fc=@lists.linux.dev
X-Gm-Message-State: AOJu0YyE+CU6fGd2PVF/V7npxTiaDw8eHacFmZcYc2tHC74PUU1rA0F5
	OqOWHfmgnLB33gGDZM4NVcjJBG0+R9g0nxTCv4qoU6swCELbNZERuFgcnz36FkcYOIjdfz7/+Sc
	pWwA=
X-Gm-Gg: AZuq6aIBvoo1iRzrFGlS+BYSWuY8V4re0y7X/pS1k+w1VXK+cedUPsMUUbkt1bW5xpm
	OUzbRCXmGXIy7kpGnFQadQaJa5QN5AUvWdL+ULIyRU2rPV5ce8d1faJyB7CWGsizwtHzO3DU5WK
	oPI064qaF9VgFXSl9UVkAPgKtMPDWBkTr8beYkfvqFAulq+MM8QFLJ1+5jQ2qj7FY8Clau5Liza
	ChUw5mgUsJc6iimHBq8GRdWlSy84uB00icZmbx0cMrnqjLLi5c5M9L+/Tydp5M5o2hiyxUplx2M
	FHQ9vVc1CvSERmzvzMl93ZK6gWx5op5M2BvUJqdumMflgKBAcYBwGacPLblHKwwYvyZyASNbmDM
	8PAjCHlXwYqRSCg9aacHmXa95ypLQJMtwGMAls9QfXBUVu1/CsPq01xl5FCein9MTdSqCr2Ud4A
	Cc
X-Received: by 2002:ac8:594a:0:b0:502:a063:c436 with SMTP id d75a77b69052e-50314cdee53mr1414761cf.70.1769294690448;
        Sat, 24 Jan 2026 14:44:50 -0800 (PST)
Received: from localhost ([136.56.27.188])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-502f7ec4f7fsm48677911cf.8.2026.01.24.14.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jan 2026 14:44:49 -0800 (PST)
From: Jon Mason <jdmason@kudzu.us>
X-Google-Original-From: Jon Mason <jdm@athena.kudzu.us>
Date: Sat, 24 Jan 2026 17:44:46 -0500
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Subject: [GIT PULL] NTB bug fixes for 6.19
Message-ID: <aXVLXurQVtt7q6pf@athena.kudzu.us>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Linus,
Sorry for the last minute PR, but there is an uninitialized mutex bug
that was just found.  Please consider pulling it for 6.19.

Thanks,
Jon



The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:

  Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)

are available in the Git repository at:

  https://github.com/jonmason/ntb tags/ntb-6.19-bugfixes

for you to fetch changes up to 2ccb5e8dbcd2dedf13e0270165ac48bd79b7f673:

  ntb: transport: Fix uninitialized mutex (2026-01-17 11:57:39 -0500)

----------------------------------------------------------------
Bug fix for uninitialized mutex in ntb transport

----------------------------------------------------------------
Dave Jiang (1):
      ntb: transport: Fix uninitialized mutex

 drivers/ntb/ntb_transport.c | 1 +
 1 file changed, 1 insertion(+)
