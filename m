Return-Path: <linus971@gmail.com>
Received: from mail-it0-x233.google.com (mail-it0-x233.google.com. [2607:f8b0:4001:c0b::233])
        by gmr-mx.google.com with ESMTPS id q125si326461ywg.4.2017.11.19.10.12.05
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Nov 2017 10:12:05 -0800 (PST)
Received: by mail-it0-x233.google.com with SMTP id u132so9405937ita.0
        for <linux-ntb@googlegroups.com>; Sun, 19 Nov 2017 10:12:05 -0800 (PST)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20171119152536.GA17838@graymalkin.kudzu.us>
References: <20171119152536.GA17838@graymalkin.kudzu.us>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 19 Nov 2017 08:12:04 -1000
Message-ID: <CA+55aFwOJziwpmsi1TN-CA2i7jrWQE_GC9DjPg9-8x3mwz3uHQ@mail.gmail.com>
Subject: Re: [GIT PULL] NTB bug fixes for v4.15
Content-Type: text/plain; charset="UTF-8"
To: Jon Mason <jdmason@kudzu.us>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Sun, Nov 19, 2017 at 5:25 AM, Jon Mason <jdmason@kudzu.us> wrote:
> Hello Linus,
> Here is a new Switchtec NTB driver and a few NTB bug fixes for 4.15.
> It's been sitting in my ntb-next branch for some time and should be
> throughly tested.  Please consider pulling them.

They may have been in your ntb-next branch for some time, but they
haven't been in linux-next at all.

Normally I might not care much.

This release I asked people to send their stuff early so that I'd get
it before my travels.

I am now traveling, and am not inclined to pull stuff that hasn't been
in linux-next unless it's just obviously bug-fixes.

           Linus
