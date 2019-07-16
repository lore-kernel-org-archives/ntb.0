Return-Path: <yamada.masahiro@socionext.com>
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com. [210.131.2.82])
        by gmr-mx.google.com with ESMTPS id f131si149118ybf.5.2019.07.15.23.03.32
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 23:03:32 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42]) (authenticated)
	by conssluserg-03.nifty.com with ESMTP id x6G636iI027203
	for <linux-ntb@googlegroups.com>; Tue, 16 Jul 2019 15:03:07 +0900
Received: by mail-vs1-f42.google.com with SMTP id k9so13099319vso.5
        for <linux-ntb@googlegroups.com>; Mon, 15 Jul 2019 23:03:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190716130341.03b02792@canb.auug.org.au>
In-Reply-To: <20190716130341.03b02792@canb.auug.org.au>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 16 Jul 2019 15:02:30 +0900
Message-ID: <CAK7LNASTDPG6bDeXj9GfWQVB559D6GEsZiUaiqCfzcPpteZxZw@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the ntb tree
Content-Type: text/plain; charset="UTF-8"
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Jon Mason <jdmason@kudzu.us>, NTB Mailing List <linux-ntb@googlegroups.com>, Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-ntb.googlegroups.com>

On Tue, Jul 16, 2019 at 12:03 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
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

commit 0539f970a8427138026d4738a7a32d869f1be300
Author: Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu Jul 11 14:44:31 2019 +0900

    kbuild: create *.mod with full directory path and remove MODVERDIR

is the first bad commit.


drivers/ntb/core.c defines MODULE_VERSION().

When CONFIG_DEBUG_SECTION_MISMATCH=y,
scripts/mod/sum.c tries to open the non-existing old
source based on the stale *.mod file
during the directory descending.


I will kill cmd_secanalysis for tomorrow's linux-next.


Thanks for catching various bugs!



-- 
Best Regards
Masahiro Yamada
