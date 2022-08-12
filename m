Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43232115
	for <ntb@lists.linux.dev>; Fri, 12 Aug 2022 16:56:30 +0000 (UTC)
Received: by mail-lf1-f53.google.com with SMTP id c17so2104822lfb.3
        for <ntb@lists.linux.dev>; Fri, 12 Aug 2022 09:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=6QLysddMGGbC43u34S/YxVpYqaLmvcM7sCjkowzWT0A=;
        b=Iyz9bFhAWJDQmYbZguK7gusX8HFg7e4A5knqlscIEzq9WK3TIw75UJKV09Lub87TAn
         IBZXY1l2KDZPH8HDHF3myWcGtYRdk/StrDJQKGp4X7mZ135nOri/HtlNWy6cpjMrE8Xx
         HO8o3NE0oI0MW664rQ69F/YXd5Qej55hgQOHg9Ow3f5APV4INMssmf79L+3q++hsDdbq
         rOQMJmdm2vozLnH1334xtnctN0uxvPKFyAAe/YXyAKBXaJJSQjWRpH7DYr7igqv2Oe7v
         sNb5dRRWuSrAppFdW0oapI5r76llqBisio6bR6LeGwf0pBfLXHgdbSD8ylkNlYiitkqv
         LANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=6QLysddMGGbC43u34S/YxVpYqaLmvcM7sCjkowzWT0A=;
        b=f2C20ANaiaghguRfbFTgxH/CQ39Fw4uRrN9gcGjVE3jKeS8tFczDmoC8sgdfn6bOIB
         gNVsLF1Oc9Im7GIFMT5OpUpxNaBb5Yi2ZX8GyUBGlaQyFNEO7xHt3vvOiw8okFjkjleZ
         uO21fu1seq15IXblcYDH5qwdK1PTAwpXlECQA/w/uHhD51rh8YKQEtPIzTkrkZVgS4kk
         kj9SVlMh7TH8326BhudDWlNod21n73X2+mnYK/YUPiCydvDenECSByOTu7wTxOEBSgjg
         ki83Ic58F4XFUzuJ1j1DI1FXCBuyUVPSzbxpuNFpALLnh9uTKPvyFbRg9JIDDbPjoqMk
         XiUQ==
X-Gm-Message-State: ACgBeo1N4Qq9traK/tHo/tSc4CsCvxYNnDV5JuqtoV/ezONPiGppAI7+
	Wf5OZYmz7mUBMwR7NUfMzwIPgL6HlzWnXg==
X-Google-Smtp-Source: AA6agR7CICME9hVrIR1vo8YS6mdz6fmWuwBc7kbv02AYw80YBvYNA+V2O8w6qJbgJtRt2FKJJEuyGQ==
X-Received: by 2002:a05:6512:3c95:b0:48a:ea84:3cc6 with SMTP id h21-20020a0565123c9500b0048aea843cc6mr1762243lfv.214.1660323388261;
        Fri, 12 Aug 2022 09:56:28 -0700 (PDT)
Received: from localhost.localdomain ([62.217.189.101])
        by smtp.googlemail.com with ESMTPSA id m13-20020a056512358d00b0048a7fa5bff1sm266146lfr.248.2022.08.12.09.56.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Aug 2022 09:56:27 -0700 (PDT)
From: Alexander Fomichev <fomichev.ru@gmail.com>
To: ntb@lists.linux.dev
Cc: linux@yadro.com,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Guo Zhengkui <guozhengkui@vivo.com>,
	fancer.lancer@gmail.com,
	Alexander Fomichev <a.fomichev@yadro.com>
Subject: [PATCH v4 0/3] ntb_perf: add new 'latency' test set
Date: Fri, 12 Aug 2022 19:55:41 +0300
Message-Id: <20220812165544.26307-1-fomichev.ru@gmail.com>
X-Mailer: git-send-email 2.37.1
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

 drivers/ntb/test/ntb_perf.c | 829 +++++++++++++++++++++++++++++++++++-
 1 file changed, 813 insertions(+), 16 deletions(-)

-- 
2.37.1

