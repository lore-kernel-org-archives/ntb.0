Return-Path: <linus971@gmail.com>
Received: from mail-it0-x22f.google.com (mail-it0-x22f.google.com. [2607:f8b0:4001:c0b::22f])
        by gmr-mx.google.com with ESMTPS id y127si519694itb.1.2017.06.19.20.06.18
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jun 2017 20:06:18 -0700 (PDT)
Received: by mail-it0-x22f.google.com with SMTP id m47so6111582iti.0
        for <linux-ntb@googlegroups.com>; Mon, 19 Jun 2017 20:06:18 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20170619184245.GA20187@graymalkin.kudzu.us>
References: <20170619184245.GA20187@graymalkin.kudzu.us>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 20 Jun 2017 11:06:17 +0800
Message-ID: <CA+55aFyghoL++4=b1v6qFV1wN+t6RsQX+oPhxy_w=GmDXFo5Pw@mail.gmail.com>
Subject: Re: [GIT PULL] NTB bug fixes for v4.12
Content-Type: text/plain; charset="UTF-8"
To: Jon Mason <jdmason@kudzu.us>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Tue, Jun 20, 2017 at 2:42 AM, Jon Mason <jdmason@kudzu.us> wrote:
> Hello Linus,
> Here are a few NTB bug fixes for 4.12.

So I pulled this, mainly because it removed more lines than it added
due to the revert.

But generally I absolutely *hate* pulling stuff that I can see was
committed just hours ago. Why was that branch so recent? It very
obviously cannot have been in any linux-next or 0day or gotten any
other exposure. Is there a reason for that behavior? And if there is,
just include it in the "please pull", because if it wasn't for the
"removes more lines than adds" I probably would just have decided to
ignore this.

               Linus
