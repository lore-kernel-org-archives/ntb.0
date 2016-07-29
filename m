Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x244.google.com (mail-lf0-x244.google.com. [2a00:1450:4010:c07::244])
        by gmr-mx.google.com with ESMTPS id o85si43785wme.0.2016.07.28.17.47.41
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jul 2016 17:47:41 -0700 (PDT)
Received: by mail-lf0-x244.google.com with SMTP id l69so4498978lfg.1
        for <linux-ntb@googlegroups.com>; Thu, 28 Jul 2016 17:47:41 -0700 (PDT)
Return-Path: <fancer.lancer@gmail.com>
Date: Fri, 29 Jul 2016 03:47:38 +0300
From: Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH v2 0/3] ntb: Asynchronous NTB devices support
Message-ID: <20160729004738.GA25441@mobilestation>
Reply-To: 1469700079-28377-1-git-send-email-fancer.lancer@gmail.com
References: <000001d1e8de$463b4c10$d2b1e430$@emc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000001d1e8de$463b4c10$d2b1e430$@emc.com>
To: Allen Hubbe <Allen.Hubbe@emc.com>
Cc: jdmason@kudzu.us, dave.jiang@intel.com, Xiangliang.Yu@amd.com, Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

Hello, Allen.
Thanks for the message. I see your point. Yes, I've seen a lot of cruel
threads in mailing threads in lkml.org , so it's not my intention to
argue about basic things like Coding Style. That's why I left most of
the warnings discussable. While you a digging into the Patch 1/3, I'll
do my best to fix the checkpatch warnings of the rest of the code. Regarding
the last checkpatch error message, I need to spend some more time to
find a way to set it free of the warnings. I hope I'll come up with
something good, at least I'll give it a try. Otherwise I'll have to
redesign the driver regmap subsystem.(

Regards,
-Sergey

On Thu, Jul 28, 2016 at 10:42:30AM -0400, Allen Hubbe <Allen.Hubbe@emc.com> wrote:
> From: Serge Semin
> > Please, find the general patchset description in the cover letter of the first
> > patchset (see the very first message in thread).
> > 
> > Changes in v2:
> >  - Fix sparc64 compilation warning in drivers/ntb/hw/idt/ntb_hw_idt.c :
> >    warning: right shift count >= width of type
> >  - Fix sparc64 compilation warnings in drivers/ntb/test/ntb_mw_test.c :
> >    warning: right shift count >= width of type
> >    warning: cast to pointer from integer of different size
> 
> Thanks for reacting to the test robot so quickly.  Since nobody else has responded yet, I would like to assure you that the patches are not being ignored.  Please be patient.  The IDT driver will be a valuable contribution to the ntb subsystem.  I am working carefully through patch 1/3 first, since it affects existing drivers and interface.
> 
> A word of caution regarding your statement, "There are a some types of checkpatch warnings I left unfixed."  Coding style can be a touchy subject, leading to some recent rants^H^H^H^H^Hdiscussion on some of the same topics that are included in that list of unfixed warnings.  Be prepared to adhere to the style guide, even if it is inconvenient and against your own logic, because that is almost always the easier and more practical approach than asking for changes or exceptions, and better for your mental health not to be on the To: list of something like https://lkml.org/lkml/2016/7/8/625.
> 
> "Of course all of these warnings are discussable, except the last one."  Be prepared, even if it will require significant changes to the code.  For really inconvenient changes, we can talk about other more readily acceptable approaches to keep the code short and elegant, as is obviously your intent.  Please be patient with the review.
> 
