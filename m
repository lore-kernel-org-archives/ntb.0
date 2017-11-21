Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org. [103.22.144.67])
        by gmr-mx.google.com with ESMTPS id s24si587684plp.2.2017.11.21.14.19.06
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Nov 2017 14:19:06 -0800 (PST)
Date: Wed, 22 Nov 2017 09:19:02 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [GIT PULL] NTB bug fixes for v4.15
Message-ID: <20171122091902.6e2c3f84@canb.auug.org.au>
In-Reply-To: <da4e7995-817d-e996-afa4-22560f1d8aac@deltatee.com>
References: <20171119152536.GA17838@graymalkin.kudzu.us>
	<CA+55aFwOJziwpmsi1TN-CA2i7jrWQE_GC9DjPg9-8x3mwz3uHQ@mail.gmail.com>
	<e1e178fa-9da4-13bb-f070-0fa9094a74c7@deltatee.com>
	<CA+55aFwmGk=279M9D2XzpuVoMuB_MPw+2n4vb47ZYh72GM6gaw@mail.gmail.com>
	<338c8f27-369b-11c4-f764-b8f726038f35@deltatee.com>
	<20171121093719.211f8194@canb.auug.org.au>
	<da4e7995-817d-e996-afa4-22560f1d8aac@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jon Mason <jdmason@kudzu.us>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ntb@googlegroups.com, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>
List-ID: <linux-ntb.googlegroups.com>

Hi Logan,

On Mon, 20 Nov 2017 15:53:07 -0700 Logan Gunthorpe <logang@deltatee.com> wrote:
>
> On 20/11/17 03:37 PM, Stephen Rothwell wrote:
> > OK, all I need is the (git) URL for a tree/branch (or tag) and a
> > contact (or more than one) to whom I can report conflicts and build
> > problems.  I then fetch it every day (so all you have to do it add stuff
> > to that branch when it is ready).
> > 
> > I noticed that one of the current set of commits removed Jon as a
> > MAINTAINER, so I am not sure what part he would play.
> >   
> 
> The branch you would want to automatically fetch is
> 
> https://github.com/jonmason/ntb.git ntb-next
> 
> Jon's probably the contact you want for merge conflicts (Jon Mason 
> <jdmason@kudzu.us>) as he's the one who typically pushes to those 
> branches and submits PRs to Linus. You could also add the mailing list: 
> linux-ntb@googlegroups.com. Dave and Allen are also maintainers but I'll 
> let them speak up if they want to be contacted for this.

So, I really need Jon to request this inclusion (sorry).  And I would
prefer to not add it until after -rc1 has been released i.e. next week
probably.
-- 
Cheers,
Stephen Rothwell
