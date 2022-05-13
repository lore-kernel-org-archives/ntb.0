Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B557A
	for <ntb@lists.linux.dev>; Fri, 13 May 2022 19:37:50 +0000 (UTC)
Received: by mail-lf1-f45.google.com with SMTP id i10so16141074lfg.13
        for <ntb@lists.linux.dev>; Fri, 13 May 2022 12:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q0ARFjrF6KwxuBY3MfgQjzk7IWjijJuWccyNZkTAV9o=;
        b=db4SXpyLKBvcDV31Gq0pdC318Mnno+zr/v8L+Ddue1tObGulTRkP0zJmsS2tsN2qaP
         x6m0VVHld+88/TPFSNyGpsEZ8hB8xKow2E+hmgxnkPFKW0MSUdbdOxTSCkhP1lz9cnYf
         kk0nC0bD+vaftzlDCZNOyUV1K7Tq6Bei7xf27OtE8kgd6ZutAIGrdCdIKdOKZa3Vrd4s
         /wj6SLE7Cp29TJfkYHvfIVGjFQdFTw/eq9S64JhRPGxmX+9RBd2nOjqJnIjnNWbZOhjV
         eziMGHU7WBanF3Y9AVMmzNWPD6XvYOnBeYCoBo1n6VVQAMeKrZ5CUSJyzM0oXqm/pYRL
         yPQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q0ARFjrF6KwxuBY3MfgQjzk7IWjijJuWccyNZkTAV9o=;
        b=GSjEkFfB8WYN2BQ0KWuZG4t3QsKynXbTN0uwHr3eCI2G0cAeE8jbF/gfTfIGnIenX/
         5aiuYubRdkIHyXUki8qFZZuHKu+EU9ky7IAXuWofRVRWkE2uOk3l57HPGqGBaByYzGmi
         zXcsATkCjopzlPxjEHMGrfNFJKm6/ME0mNLPiQDUnkM0cv9o/OuZVxgbqcrZxT1gwDka
         MV9Xjnk3sB6I/wznxdMrUQbcwxKFIjdMg5OjiVc9xrBK5PFOFkuV3lVHMa60OJyTxuzA
         GvgPAYNYVUP0QHZRgTOhA6bR9XmeTiVWbPoNhFHDtLgABSivdR0yKmhWlk7oRtL3dHCt
         MSNQ==
X-Gm-Message-State: AOAM530Xpo6M+QX+ZecUsOe827lU/wA78XLemrpL+KbP63i2QDH4Ix7n
	3iydZN4QaizO6r/SNf5f4KC6oeKikd/BI/CldVw=
X-Google-Smtp-Source: ABdhPJw6ZDQNJ2Tft1mC+RhZ9/bIsPqFVW0vthr3uajvQKnMXY5GlF6i//yJ727AvSjfmoGEnYv8lQ==
X-Received: by 2002:a05:6512:3085:b0:473:b865:4e7c with SMTP id z5-20020a056512308500b00473b8654e7cmr4431635lfd.178.1652470668311;
        Fri, 13 May 2022 12:37:48 -0700 (PDT)
Received: from localhost.localdomain ([62.217.189.101])
        by smtp.googlemail.com with ESMTPSA id q12-20020ac2528c000000b0047255d211bbsm472962lfm.234.2022.05.13.12.37.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 May 2022 12:37:47 -0700 (PDT)
From: Alexander Fomichev <fomichev.ru@gmail.com>
To: ntb@lists.linux.dev
Cc: linux@yadro.com,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Guo Zhengkui <guozhengkui@vivo.com>,
	fancer.lancer@gmail.com,
	Alexander Fomichev <a.fomichev@yadro.com>
Subject: [PATCH v3 0/3] ntb_perf: add new 'latency' test set
Date: Fri, 13 May 2022 22:37:01 +0300
Message-Id: <20220513193704.36868-1-fomichev.ru@gmail.com>
X-Mailer: git-send-email 2.36.1
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Fomichev <a.fomichev@yadro.com>

The ntb_perf test provides a tool for NTB hardware performance
evaluation. For software impact elimination the test uses a simple method
(let's call it 'burst' mode), when the local system sends to the remote
system a data set and counts time interval until hardware completion
report, without the remote side confirming, nor data integrity check.
The measured metric is a 'burst' throughput bandwidth of NTB connection.

The patches extend ntb_perf with 3 new metrics:
1) Burst latency
2) Poll latency
3) Doorbell latency

The resulting test set is fully backward compatible.

Alexander Fomichev (3):
  ntb_perf: extend with burst latency measurement
  ntb_perf: extend with poll latency measurement
  ntb_perf: extend with doorbell latency measurement

 drivers/ntb/test/ntb_perf.c | 826 +++++++++++++++++++++++++++++++++++-
 1 file changed, 810 insertions(+), 16 deletions(-)

-- 
2.36.1

