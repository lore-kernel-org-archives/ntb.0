Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org. [2401:3900:2:1::2])
        by gmr-mx.google.com with ESMTPS id 105si876820uas.1.2017.11.20.14.37.23
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Nov 2017 14:37:23 -0800 (PST)
Date: Tue, 21 Nov 2017 09:37:19 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [GIT PULL] NTB bug fixes for v4.15
Message-ID: <20171121093719.211f8194@canb.auug.org.au>
In-Reply-To: <338c8f27-369b-11c4-f764-b8f726038f35@deltatee.com>
References: <20171119152536.GA17838@graymalkin.kudzu.us>
	<CA+55aFwOJziwpmsi1TN-CA2i7jrWQE_GC9DjPg9-8x3mwz3uHQ@mail.gmail.com>
	<e1e178fa-9da4-13bb-f070-0fa9094a74c7@deltatee.com>
	<CA+55aFwmGk=279M9D2XzpuVoMuB_MPw+2n4vb47ZYh72GM6gaw@mail.gmail.com>
	<338c8f27-369b-11c4-f764-b8f726038f35@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jon Mason <jdmason@kudzu.us>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Hi Logan,

On Sun, 19 Nov 2017 23:51:48 -0700 Logan Gunthorpe <logang@deltatee.com> wrote:
>
> > I do want to protest the timing and the lack of linux-next coverage.
> > If it has really been ready for months, why hasn't it been in
> > linux-next at all?  
> 
> Understood. I can't speak for Jon, but in the future if I have patches
> in the queue, I will definitely remind him to send it to Stephen for the
> linux-next tree. And I'll make sure it gets there ahead of the merge window.

OK, all I need is the (git) URL for a tree/branch (or tag) and a
contact (or more than one) to whom I can report conflicts and build
problems.  I then fetch it every day (so all you have to do it add stuff
to that branch when it is ready).

I noticed that one of the current set of commits removed Jon as a
MAINTAINER, so I am not sure what part he would play.
-- 
Cheers,
Stephen Rothwell
