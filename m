Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id h77si3685itb.0.2017.07.17.09.36.51
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jul 2017 09:36:51 -0700 (PDT)
References: <20170626195041.6190-1-logang@deltatee.com>
 <000001d2ef5f$1ed1e750$5c75b5f0$@dell.com>
 <CAPoiz9wapj4qx5pSRhHpNWOiSHKgAXNu6xdVeecBNQEo72U4Xw@mail.gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <296b3d42-ce65-a521-b2de-db3459ac543a@deltatee.com>
Date: Mon, 17 Jul 2017 10:36:41 -0600
MIME-Version: 1.0
In-Reply-To: <CAPoiz9wapj4qx5pSRhHpNWOiSHKgAXNu6xdVeecBNQEo72U4Xw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ntb: use correct mw_count function in ntb_tool and
 ntb_transport
To: Jon Mason <jdmason@kudzu.us>, Allen Hubbe <Allen.Hubbe@dell.com>
Cc: linux-ntb@googlegroups.com, linux-kernel <linux-kernel@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

Hi John,


On 17/07/17 09:16 AM, Jon Mason wrote:
> Per your request, this has been applied to my ntb-next branch.

This isn't a huge issue but I meant for this patch to fix the mistake in
the new ntb_api before it hit 4.13.

On the other hand, seeing there's no way to actually trigger the issue
until the switchtec driver is merged I guess it's okay to leave it the
way you did it.

Thanks,

Logan
