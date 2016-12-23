Return-Path: <jdmason@kudzu.us>
Received: from mail-ua0-x244.google.com (mail-ua0-x244.google.com. [2607:f8b0:400c:c08::244])
        by gmr-mx.google.com with ESMTPS id n64si2600470vkc.3.2016.12.23.13.18.59
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Dec 2016 13:18:59 -0800 (PST)
Received: by mail-ua0-x244.google.com with SMTP id i68so9607316uad.1
        for <linux-ntb@googlegroups.com>; Fri, 23 Dec 2016 13:18:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <201612220129.zpe0GTYW%fengguang.wu@intel.com>
References: <201612220129.zpe0GTYW%fengguang.wu@intel.com>
From: Jon Mason <jdmason@kudzu.us>
Date: Fri, 23 Dec 2016 16:18:58 -0500
Message-ID: <CAPoiz9zXjStDcZ18CYT=N7MVgSyOpd6piyTFHvx2xZ9jan_KtQ@mail.gmail.com>
Subject: Re: [ntb:ntb-next 4/9] drivers/ntb/ntb_transport.c:1189:9: warning:
 'rc' may be used uninitialized in this function
Content-Type: text/plain; charset=UTF-8
To: kbuild test robot <fengguang.wu@intel.com>
Cc: Shyam Sundar S K <ssundark@amd.com>, kbuild-all@01.org, linux-ntb@googlegroups.com, "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>, "Agrawal, Nitesh-kumar" <Nitesh-kumar.Agrawal@amd.com>, "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>
List-ID: <linux-ntb.googlegroups.com>

This was a good catch.  Since it was an easy fix, I corected the patch
in question to return the proper value.

Thanks,
Jon

On Wed, Dec 21, 2016 at 12:39 PM, kbuild test robot
<fengguang.wu@intel.com> wrote:
> tree:   https://github.com/jonmason/ntb ntb-next
> head:   6fc20c5d731273eb7270d61f210f2d2611d41e6c
> commit: 88c8f47690103712dd530ebf4282cb311aea1379 [4/9] ntb_transport: Limit memory windows based on available, scratchpads
> config: x86_64-randconfig-x010-201651 (attached as .config)
> compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
> reproduce:
>         git checkout 88c8f47690103712dd530ebf4282cb311aea1379
>         # save the attached .config to linux build tree
>         make ARCH=x86_64
>
> Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
> http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings
>
> All warnings (new ones prefixed by >>):
>
>    drivers/ntb/ntb_transport.c: In function 'ntb_transport_probe':
>>> drivers/ntb/ntb_transport.c:1189:9: warning: 'rc' may be used uninitialized in this function [-Wmaybe-uninitialized]
>      return rc;
>             ^~
>
> vim +/rc +1189 drivers/ntb/ntb_transport.c
>
> e26a5843 Allen Hubbe     2015-04-09  1173       ntb_link_event(ndev);
> fce8a7bb Jon Mason       2012-11-16  1174
> fce8a7bb Jon Mason       2012-11-16  1175       return 0;
> fce8a7bb Jon Mason       2012-11-16  1176
> 948d3a65 Jon Mason       2013-04-18  1177  err3:
> d4adee09 Sudip Mukherjee 2015-10-03  1178       ntb_clear_ctx(ndev);
> 948d3a65 Jon Mason       2013-04-18  1179  err2:
> d4adee09 Sudip Mukherjee 2015-10-03  1180       kfree(nt->qp_vec);
> fce8a7bb Jon Mason       2012-11-16  1181  err1:
> e26a5843 Allen Hubbe     2015-04-09  1182       while (i--) {
> e26a5843 Allen Hubbe     2015-04-09  1183               mw = &nt->mw_vec[i];
> e26a5843 Allen Hubbe     2015-04-09  1184               iounmap(mw->vbase);
> e26a5843 Allen Hubbe     2015-04-09  1185       }
> d4adee09 Sudip Mukherjee 2015-10-03  1186       kfree(nt->mw_vec);
> fce8a7bb Jon Mason       2012-11-16  1187  err:
> fce8a7bb Jon Mason       2012-11-16  1188       kfree(nt);
> fce8a7bb Jon Mason       2012-11-16 @1189       return rc;
> fce8a7bb Jon Mason       2012-11-16  1190  }
> fce8a7bb Jon Mason       2012-11-16  1191
> e26a5843 Allen Hubbe     2015-04-09  1192  static void ntb_transport_free(struct ntb_client *self, struct ntb_dev *ndev)
> fce8a7bb Jon Mason       2012-11-16  1193  {
> e26a5843 Allen Hubbe     2015-04-09  1194       struct ntb_transport_ctx *nt = ndev->ctx;
> e26a5843 Allen Hubbe     2015-04-09  1195       struct ntb_transport_qp *qp;
> e26a5843 Allen Hubbe     2015-04-09  1196       u64 qp_bitmap_alloc;
> fce8a7bb Jon Mason       2012-11-16  1197       int i;
>
> :::::: The code at line 1189 was first introduced by commit
> :::::: fce8a7bb5b4bfb8a27324703fd5b002ee9247e90 PCI-Express Non-Transparent Bridge Support
>
> :::::: TO: Jon Mason <jon.mason@intel.com>
> :::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
