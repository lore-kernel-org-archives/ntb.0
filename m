Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id f15si52132plr.1.2017.12.05.08.57.52
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Dec 2017 08:57:52 -0800 (PST)
References: <20171203191736.3399-1-fancer.lancer@gmail.com>
 <000001d36d3b$e9f211d0$bdd63570$@dell.com>
 <20171205155454.GA1701@mobilestation>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <c8bf3995-337e-8189-2216-1ec75e93a5c4@deltatee.com>
Date: Tue, 5 Dec 2017 09:57:44 -0700
MIME-Version: 1.0
In-Reply-To: <20171205155454.GA1701@mobilestation>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 00/15] NTB: Add full multi-port API support to the test
 drivers
To: Serge Semin <fancer.lancer@gmail.com>, Allen Hubbe <Allen.Hubbe@dell.com>
Cc: jdmason@kudzu.us, dave.jiang@intel.com, Shyam-sundar.S-k@amd.com, Xiangliang.Yu@amd.com, gary.hook@amd.com, Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>



On 05/12/17 08:54 AM, Serge Semin wrote:
> Yeah, I know that. As I already said, it isn't usual of my patches
> being so complicated. The reason why I made so many small renamings
> was the code refactoring. I tried to set all the test drivers code
> up to the same naming convention, so it would be easier for a code
> reader to study it. Definitely, such the alterations should have
> been done within a separate patch. But I started refactoring the
> code and changing the logic for multi-portness all together, so it
> would be too painful to unpick one from another after the work was
> done. It especially concerned the ntb_tool and ntb_perf drivers. Next
> time the procedures will be separately. Sorry for inconvenience and
> thanks for understanding.

It's really not that hard, using git, to refactor a patch. If it's such 
a mess that you can't refactor it then it's probably a good indication 
that said patch should not be merged. The vast majority of other 
maintainers in the kernel would never accept such a large convoluted 
patch as it's too difficult to determine if something unintended changed 
and it makes debugging and bisecting (once it's merged) more difficult. 
Not to mention the fact that few developers are willing to put in the 
time to untangle it enough to properly review.

> Oops. We discussed it in the IRC. We agreed to add commentaries
> around the types definition, so a reader would better understand their
> purpose. I just forgot to move the change from my repo to the fork of
> Jon's one. I'll do it and resend the patch.

I agree with Allen. The unions are completely unnecessary. If there was 
a space constraint then they could be justified but we really don't have 
that here. In my opinion, you should just drop them -- a comment doesn't 
really improve things much.

Logan
