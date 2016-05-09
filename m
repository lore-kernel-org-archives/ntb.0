Return-Path: <kallol@nucleodyne.in>
Received: from mail-lf0-x233.google.com (mail-lf0-x233.google.com. [2a00:1450:4010:c07::233])
        by gmr-mx.google.com with ESMTPS id ai9si1078138lbc.2.2016.05.09.15.25.51
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 May 2016 15:25:51 -0700 (PDT)
Received: by mail-lf0-x233.google.com with SMTP id m64so215530004lfd.1
        for <linux-ntb@googlegroups.com>; Mon, 09 May 2016 15:25:51 -0700 (PDT)
MIME-Version: 1.0
Sender: kallol@nucleodyne.in
Date: Mon, 9 May 2016 15:25:50 -0700
Message-ID: <CAH=XD5_QVjhSezg-AwO0UrEEwraX2ingWmMbJG0iewyhqbT39Q@mail.gmail.com>
Subject: Intel NTB and a switch in between
From: Kallol Biswas <kallol@nucleodyne.com>
Content-Type: text/plain; charset=UTF-8
To: linux-ntb@googlegroups.com, linux-pci@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

We have a requirement to setup intel processor NTB.

We understand that NTB-NTB back to back connection works, but
what if we put a transparent bridge (PCIe Switch) in between two NTBs?


Kallol
