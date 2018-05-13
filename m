Return-Path: <allenbh@gmail.com>
Received: from mail-yb0-x22c.google.com (mail-yb0-x22c.google.com. [2607:f8b0:4002:c09::22c])
        by gmr-mx.google.com with ESMTPS id g1-v6si726066ioc.0.2018.05.12.17.31.35
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 May 2018 17:31:35 -0700 (PDT)
Received: by mail-yb0-x22c.google.com with SMTP id r13-v6so3033457ybm.12
        for <linux-ntb@googlegroups.com>; Sat, 12 May 2018 17:31:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJ80sav37tU2XhmuUN6NAA9LK9i2frPK7K87O+Tpqf6=J9gpeA@mail.gmail.com>
References: <1525634420-19370-1-git-send-email-araut@codeaurora.org>
 <1525634420-19370-3-git-send-email-araut@codeaurora.org> <20180511224401.GA5458@mobilestation>
 <CAJ80sav37tU2XhmuUN6NAA9LK9i2frPK7K87O+Tpqf6=J9gpeA@mail.gmail.com>
From: Allen Hubbe <allenbh@gmail.com>
Date: Sat, 12 May 2018 20:31:34 -0400
Message-ID: <CAJ80sauLUqOC0HHA8X272PC2dQLCyh7BgXOWnQWmFpPKPY0j6w@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] NTB : Add message library NTB API
Content-Type: text/plain; charset="UTF-8"
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Atul Raut <araut@codeaurora.org>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Sat, May 12, 2018 at 8:25 PM, Allen Hubbe <allenbh@gmail.com> wrote:
> int send_cmd(u32 cmd_num, void *data, size_t size)
...
>         if (!(ack_val & CMD_ACK_BIT) == !(cmd_val & CMD_SEQ_BIT))
>                 goto out;

Let that be !=.

If the ack bit is received by the peer is the same as the seq bit sent
to the peer, let that indicate acknowledement of the command sent to
the peer.  In other words.  If ==, ok to send the next message.  If
!=, need to wait for peer to ack the current message.
