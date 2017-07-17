Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id 72si840014itk.3.2017.07.17.09.50.27
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jul 2017 09:50:27 -0700 (PDT)
References: <20170626195041.6190-1-logang@deltatee.com>
 <000001d2ef5f$1ed1e750$5c75b5f0$@dell.com>
 <CAPoiz9wapj4qx5pSRhHpNWOiSHKgAXNu6xdVeecBNQEo72U4Xw@mail.gmail.com>
 <296b3d42-ce65-a521-b2de-db3459ac543a@deltatee.com>
 <CAPoiz9zsGbwRNMTNr_5G_k0adGzPwvCk_pvUhSMkE3nDK+BBrw@mail.gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <ce6f1995-0a1b-d0cc-4ef8-77fc1791f557@deltatee.com>
Date: Mon, 17 Jul 2017 10:50:20 -0600
MIME-Version: 1.0
In-Reply-To: <CAPoiz9zsGbwRNMTNr_5G_k0adGzPwvCk_pvUhSMkE3nDK+BBrw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ntb: use correct mw_count function in ntb_tool and
 ntb_transport
To: Jon Mason <jdmason@kudzu.us>
Cc: Allen Hubbe <Allen.Hubbe@dell.com>, linux-ntb@googlegroups.com, linux-kernel <linux-kernel@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>



On 17/07/17 10:46 AM, Jon Mason wrote:
> s/John/Jon

Apologies. Monday morning -- not fully awake yet.

> NP.  I'll add a "Fixes: ..." to it.  So, it'll get pulled into the
> -stable trees.

Ok, thanks, but it's not really the stable trees that need to see it
seeing 4.13 isn't released yet, it would just need to get into a
subsequent rc....

Logan
