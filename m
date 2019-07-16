Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id y15si811556iof.5.2019.07.15.20.46.45
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Jul 2019 20:46:45 -0700 (PDT)
References: <20190716130341.03b02792@canb.auug.org.au>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <7ec45bb7-4e72-2415-21f7-44dadaa0fada@deltatee.com>
Date: Mon, 15 Jul 2019 21:46:42 -0600
MIME-Version: 1.0
In-Reply-To: <20190716130341.03b02792@canb.auug.org.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: linux-next: build warning after merge of the ntb tree
To: Stephen Rothwell <sfr@canb.auug.org.au>, Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Jon Mason <jdmason@kudzu.us>, NTB Mailing List <linux-ntb@googlegroups.com>, Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-ntb.googlegroups.com>



On 2019-07-15 9:03 p.m., Stephen Rothwell wrote:
> Hi all,
> 
> After merging the ntb tree, today's linux-next build (x86_64 allmodconfig)
> produced this warning:
> 
> WARNING: could not open /home/sfr/next/next/drivers/ntb/ntb.c: No such file or directory
> 
> The only thing I could see that might be relevant is commit
> 
>   56dce8121e97 ("kbuild: split out *.mod out of {single,multi}-used-m rules")
> 
> and some others in the kbuild tree. Nothing has changed recently in the
> ntb tree ...
> 
> drievrs/ntb builds a module called ntb but there is no ntb.c file.
> 
> Any ideas?

I renamed the ntb.c file to core.c so we could add more files to build
ntb.ko. See [1].

Thanks,

Logan


[1]
https://lore.kernel.org/linux-iommu/20190422210528.15289-6-logang@deltatee.com/
