Return-Path: <jdmason@kudzu.us>
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com. [2607:f8b0:4864:20::f34])
        by gmr-mx.google.com with ESMTPS id e23si1108814oti.4.2020.05.31.13.03.57
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 May 2020 13:03:57 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id dp10so3528886qvb.10
        for <linux-ntb@googlegroups.com>; Sun, 31 May 2020 13:03:57 -0700 (PDT)
Return-Path: <jdmason@kudzu.us>
Received: from kudzu.us ([2605:a601:a664:2e00:a5da:931a:7f23:1d4d])
        by smtp.gmail.com with ESMTPSA id g28sm8490590qts.88.2020.05.31.13.03.56
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2020 13:03:56 -0700 (PDT)
Date: Sun, 31 May 2020 16:03:54 -0400
From: Jon Mason <jdmason@kudzu.us>
Subject: NTB changes for v5.8
Message-ID: <20200531200354.GF4620@kudzu.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

I just pulled in all outstanding patches and pushed the ntb-next branch
to ntb.  It contains a lot of changes to the ntb test tools.  So, I
would appreciate everyone taking a moment to verify functionality on
their hardware.

Barring something significant being found, I'll send a pull request
to Linus on Wednesday (assuming v5.7 is released later today).

Thanks,
Jon
