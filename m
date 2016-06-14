Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwdur.emc.com (mailuogwdur.emc.com. [128.221.224.79])
        by gmr-mx.google.com with ESMTPS id d71si2092319ywb.3.2016.06.14.08.54.44
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jun 2016 08:54:44 -0700 (PDT)
From: "Allen Hubbe" <Allen.Hubbe@emc.com>
References: <cover.1465598632.git.logang@deltatee.com> <e447cedb6197b62f141e7688ed2329c259f33eb9.1465598632.git.logang@deltatee.com> <CAJ80sasERM19iz7d9+VeyDg-nasQvBpSqe9crB16GBMez8dFew@mail.gmail.com> <575C2E28.9020604@deltatee.com> <CAJ80sasHLMN3FZnFOKgfU6d7KBmr4zt2H5ej58EapYDBaoqZag@mail.gmail.com> <000101d1c653$bc673280$35359780$@emc.com> <57602736.7090709@deltatee.com>
In-Reply-To: <57602736.7090709@deltatee.com>
Subject: RE: [PATCH 6/8] ntb_tool: Add link status file to debugfs
Date: Tue, 14 Jun 2016 11:54:16 -0400
Message-ID: <000301d1c655$02e46f60$08ad4e20$@emc.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
To: 'Logan Gunthorpe' <logang@deltatee.com>, 'Allen Hubbe' <allenbh@gmail.com>
Cc: 'Jon Mason' <jdmason@kudzu.us>, 'Dave Jiang' <dave.jiang@intel.com>, 'Shuah Khan' <shuahkh@osg.samsung.com>, 'Sudip Mukherjee' <sudipm.mukherjee@gmail.com>, 'Arnd Bergmann' <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, linux-kselftest@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

From: Logan Gunthorpe
> On 14/06/16 09:45 AM, Allen Hubbe wrote:
> >
> > Feel free to disregard my suggestion above.  I hope my comment has not cost you too much
> time.
> >
> > The way you have written it already, and used it in the self-test script is much more
> concise.
> >
> >>> + * root@self# echo > $DBG_DIR/link
> >
> > Acked-by: Allen.Hubbe@emc.com
> >
> >
> >
> > Eventually, I think it would be useful to let ntb_tool enable and disable the link.  In
> that case, it might also be useful in a test script to wait for link down, not just link
> up.
> >
> > What about this:
> >
> > # Wait for the link to be up or down
> > root@self# echo 1 > $DBG_DIR/link
> > root@self# echo 0 > $DBG_DIR/link
> >
> > It need not be a part of this patch, but eventually:
> >
> > # Enable or disable the link
> > root@self# echo 1 > $DBG_DIR/link_ctrl
> > root@self# echo 0 > $DBG_DIR/link_ctrl
> >
> > # Reading the link_ctrl file can also give the link status
> > root@self# cat $DBG_DIR/link_ctrl
> >
> > Finally, I wonder if the file called "link" in this patch should be called "link_wait"
> or similar, so its purpose is obviously not for enabling and disabling the link.
> >
> 
> Actually I've already implemented something similar to your original
> suggestion. I'll be submitting a v2 of this set shortly.

Ok.  Thanks.  I'll accept the blame if anyone doesn't like it.

