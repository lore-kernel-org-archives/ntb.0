Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E398923D6A
	for <ntb@lists.linux.dev>; Fri, 12 May 2023 20:24:40 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6439e6f5a33so6312112b3a.2
        for <ntb@lists.linux.dev>; Fri, 12 May 2023 13:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683923080; x=1686515080;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UL0Y7AcgIKWYgo3/+uocMBWRsQApCNigbVY517heGnU=;
        b=pQ1KCGwuoha6xq4gYQ4EL9rVYk9oxIQJaOktGLlY09APJIiwftPq7eIGybyc+qGYCW
         TgGLWLKFKVgjVsN17CJ2YLxAitqQBFmCL1dli5vSGjrcaItuYd8apSA/XFyDb8tn9vZZ
         p5VzapVPjKJw7pYdtK1ktLM6dgrFCY/I2LSQH5WGsJW1TO+6J/GzugFdaa8x6tHk9Xdj
         f5RRmiQF63sI8LPVW31BQKkHL8MJ0oGD+z/aOluHQV9pdO6SqhWQ67c+qtWEUxvX/sip
         kF7X616jE60PJKdoTU6oEaHZz5qgIYDit8g0liz0lfZaVqJjdZr/iALXeyIZk9n883uj
         VFjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683923080; x=1686515080;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UL0Y7AcgIKWYgo3/+uocMBWRsQApCNigbVY517heGnU=;
        b=N7f/f8HPZ7muj/+6exMJpRDBZoobKqitjJNuI6jowLx6sDCpyuZ+pq5DRQl7psRHKL
         cXiFh0/XenaEIrYHyC1Rw7+EyEjqCodxWxRXDssD6akoN9gTh8dLUPvWeMp6/wgO3Me+
         Z+5DeNxI6SJR+iZYCMdtS9B8mLWX/SFYKqjD86/wur9Kfua02vcZQsjLni0/4Hc31YiE
         5pv2N35j0ieFIUTrg+rQZQ4R+IfVrAxMlvLVnJrAv6d20/ERu1SpWm+Y5nijKRWeAr66
         e+ZuAome94BfhDDnXdLUco5+agA0D6AYK1cLyxeqXr3vnVzuydw6s5PLqKXdNphls5Bt
         I8aw==
X-Gm-Message-State: AC+VfDzJd2fc2VFwPS+SyviqMuX6OHwQ5qQcNXlUZmwpgrOJzvrO1Hw4
	3szSyG3mq+dENJMwSDJ5Cww=
X-Google-Smtp-Source: ACHHUZ7n0bNapAnUsn0KFnkeYXXyTUpNckwUxqzD90EgZH8oOuXSKkzz/hLUI/SvI8PlBHFRArhkjw==
X-Received: by 2002:a17:90a:fa91:b0:246:634d:a89c with SMTP id cu17-20020a17090afa9100b00246634da89cmr25214437pjb.41.1683923080114;
        Fri, 12 May 2023 13:24:40 -0700 (PDT)
Received: from yoga ([2400:1f00:13:5d8c:29b4:3ace:81ca:10f])
        by smtp.gmail.com with ESMTPSA id n12-20020a17090a9f0c00b0024e05b7ba8bsm21081816pjp.25.2023.05.12.13.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 13:24:39 -0700 (PDT)
Date: Sat, 13 May 2023 01:54:34 +0530
From: Anup Sharma <anupnewsmail@gmail.com>
To: Sanjay R Mehta <sanju.mehta@amd.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>, ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ntb: hw: amd: Fix debugfs_create_dir error checking
Message-ID: <ZF6ggnry8BVjQyYE@yoga>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The debugfs_create_dir function returns ERR_PTR in case of error, and the
only correct way to check if an error occurred is 'IS_ERR' inline function.
This patch will replace the null-comparison with IS_ERR.

Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
Suggested-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
 drivers/ntb/hw/amd/ntb_hw_amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index 04550b1f984c..05bdee1c78e6 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -941,7 +941,7 @@ static void ndev_init_debugfs(struct amd_ntb_dev *ndev)
 		ndev->debugfs_dir =
 			debugfs_create_dir(pci_name(ndev->ntb.pdev),
 					   debugfs_dir);
-		if (!ndev->debugfs_dir)
+		if (IS_ERR(ndev->debugfs_dir))
 			ndev->debugfs_info = NULL;
 		else
 			ndev->debugfs_info =
-- 
2.34.1

