Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB084428
	for <ntb@lists.linux.dev>; Tue,  9 Aug 2022 15:43:33 +0000 (UTC)
Received: by mail-lf1-f53.google.com with SMTP id e15so17623249lfs.0
        for <ntb@lists.linux.dev>; Tue, 09 Aug 2022 08:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=1hIGgJa0LvdfzK0Iqnyr+7fenyygS147aw8MU86jF6Q=;
        b=zFiv6kRTE4ZIAvPyCCDRv4cBNB3hAVRJGTWJ7v/fPXA1MjjHUnTd92IB9Mwl2KQhiE
         QkkgrjBC7T610K453iDCv/RmDXZHcLfa7Ig93wt6CZiN2gJGPQzUtKlY22OfuTbX6i06
         DAVe4Jj3/dPcMi3TJ3eG/ohpkZfbdBuD0iFqp7EDZcXSHWA274oawd05QnMjZlVsM3Sk
         /LINxzEXZOMNvixreFuCNgLprbzabMJctFKmjwAxBfUMikSohItunBBFINEUYmxziaD1
         aBUVqYS+9DaREf1V3k7RqqoAF7xY+UeQhnibD2VH/jzlWHTZ++2AXmfcQh3hX3h3W5ct
         3LCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=1hIGgJa0LvdfzK0Iqnyr+7fenyygS147aw8MU86jF6Q=;
        b=saoBo8/9bKkjZVLac9y/XTmZQY65xKaajBIvWotE2CtdC6uZ/WeIOreJGFVKxssnPd
         nlaaJPo64To292KKRYHv3YiVfHUj3UPR4vTI24ZVucYCp2J9iKjsUO6Hd6mYcEuPEZjx
         vaXwHEI9cs4IAQ5qJ9fcBRBO3s5JXNx0vwS66SKgZpnJzD7ZDP3OECZd3aaZzu+jtKES
         mnVzB0UWBI6QrCmrCn+TZtwuco0Gr/3dA33N+p+8CqJX5NOvO7XA2M7USP+YPYrkBPns
         g+yNmW6s0T/pq1b8+1YfSRwVOBw/y6pyncaL2CVrql1jBtXv8nyVdbmHrcrGDdGnXD7q
         i39g==
X-Gm-Message-State: ACgBeo0OIp9+z5eYjtucJRB+FbV1rPRbyVGwtnXlh1A8guD5pjNbE8Ja
	zaXTwUgIQlPeTA0wIOYXUr91sb/aUKbs0crA88LlNQ==
X-Google-Smtp-Source: AA6agR6wXbIAxCrDU+m865xiKL4EgQ4aAuznyqFaaXA6tY9q2l9FVIqJIbKCpadp9iryW/DKrEmzmTs+/THNhVa4WNI=
X-Received: by 2002:a05:6512:2828:b0:48a:f624:28b0 with SMTP id
 cf40-20020a056512282800b0048af62428b0mr7726767lfb.29.1660059812032; Tue, 09
 Aug 2022 08:43:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220513193704.36868-1-fomichev.ru@gmail.com> <60dd9f2e-57b1-7c9d-ca99-568c37fe286a@intel.com>
 <20220525085801.4r2l44vqiaqrbjk4@mobilestation> <20220620102014.7oiq3yh7jfvzacpm@yadro.com>
 <YrCHbmrNy9obZe2t@kudzu.us> <20220621140537.tfhsqez4wh7ehftv@mobilestation>
 <20220622094457.52x4gfve3g3r3kvj@yadro.com> <20220622203648.jo6raa4h57g24el2@mobilestation>
In-Reply-To: <20220622203648.jo6raa4h57g24el2@mobilestation>
From: Jon Mason <jdmason@kudzu.us>
Date: Tue, 9 Aug 2022 11:43:20 -0400
Message-ID: <CAPoiz9y5_6=N0tRo2n22bFpFb2GEcbfC8L8a4J+EZjeEegTbiA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] ntb_perf: add new 'latency' test set
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Alexander Fomichev <fomichev.ru@gmail.com>, Dave Jiang <dave.jiang@intel.com>, ntb@lists.linux.dev, 
	linux@yadro.com, Allen Hubbe <allenbh@gmail.com>, Guo Zhengkui <guozhengkui@vivo.com>, 
	Alexander Fomichev <a.fomichev@yadro.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, Jun 22, 2022 at 4:36 PM Serge Semin <fancer.lancer@gmail.com> wrote:
>
> On Wed, Jun 22, 2022 at 12:44:57PM +0300, Alexander Fomichev wrote:
> > Hi Serge,
> >
> > Thank you for the very detailed comments.
> >
> > On Tue, Jun 21, 2022 at 05:05:37PM +0300, Serge Semin wrote:
> > >
> > > Please also note, there is a special test-script, which rely on the
> > > certain test drivers semantic:
> > > tools/testing/selftests/ntb/ntb_test.sh
> > > It looks like the suggested patches don't change the already defined
> > > ntb_perf DebugFS interface, but still may cause the script to fail if the
> > > latency on the particular system will get measured too high. So should
> > > we have the latency-part in a separate driver, the script won't get
> > > affected by it. If it is required the script could be updated accordingly
> > > taking the new driver specifics into account.
> > >
>
> > As described in the cover commit message, the resulting test is fully
> > backward compatible. I mean that if we don't fiddle with the new sysfs
> > entries, then no latency measures are performed, and the test works as
> > it did before the patch set.
>
> sysfs? Did you mean debugfs?
> Anyway the DebugFS interface will be indeed backward compatible, but
> functionally the performance test won't be the same. AFAICS at the
> very least the burst-latency test is executed by default together with
> the standard performance test. It may cause ntb_test.sh regressions on
> the systems (the test will fail if the latency is too high), which
> haven't had any problem before.
>
> > Also, I plan to make changes to "ntb_test.sh" script accordingly, after
> > this patch set is merged.
>
> Good. It will be much easier to do should you have the latency test
> implemented as a separate driver.
>
> >
> > > Regarding the tests implementation. As I see it failing the latency
> > > measurements if they're performed with the too few retries isn't a good
> > > idea. Alexander, you said that normally performing 1000 retries is
> > > enough to get the latency with a good precision, but the test driver
> > > returns an error if the number of retries is less than 20. So what
> > > happens between 20 and 1000? The tests get passed, but the results
> > > aren't accurate or what? If so then why don't the test fail in the
> > > case of 30 iterations too? IMO as long as you don't define the strong
> > > accuracy criteria, the failure condition shouldn't be determined by
> > > the number of iterations. So if I were you I would execute the latency
> > > tests with the specified "lat_time_ms" duration and printed a warning
> > > if the number of iterations turned to be too low (100, 200?) most
> > > likely causing to have inaccurate results, but still would calculate
> > > the latency from the determined numbers (even if there were only one
> > > iteration performed).
> > >
> > Reasonable. I can easily change this part.
> >
> > > The main issue is that after applying all the changes the ntb_perf
> > > driver will get extended greatly with three additional sub-tests
> > > and thus will loose its coherency. It gets to be obvious after
> > > the patch 2 and 3 applied, which introduce additional client-server
> > > semantic and imply allocating their-own private data. All of that
> > > makes the code much harder to read and breaks the driver specialization.
> > >
> > > The latency tests as them-self are very useful though. But it would be
> > > much better to have them implemented in a separate driver
> > > "ntb_latency" or something.
> > >
>
> > The whole 'latency' part relies on 'ntb_perf' infrastructure.
>
> Yeah, it's very handy, isn't it? =)
> Originally it has been created in a way so the perf-test would be
> portable across all the supported NTB HW types: local- and peer-based
> MW xlate address setup (Intel/AMD/Switchtec NTB HW vs IDT NTB HW),
> Scratchpad and Messages capable devices (Intel/AMD/Switchtec NTB HW vs
> IDT NTB HW). My idea was to provide a reference of how a portable NTB
> application could be designed. (It took some hard time to debug that
> part on the Intel/AMD hardware since nobody of the current maintainers
> had an access to one at that moment.) On the next step I was going to
> move the communication part of the ntb_perf driver to a separate
> kernel module as a communication library (which could be used for the
> inter-domains basic communications on top of the DB+Spad/MSG
> interface), but alas didn't find a time to get to work on it.
>
> > Moreover,
> > the first patch adds only one meaningful function.  Thus separatin theg
> > 'latency' part will make me copy a lot of code. As a compromise, I can
> > offer to put latency-related code into a separate .c file but leave the
> > whole test in a single module. That should increase readability and
> > eliminate code duplication.
>
> What would be much better if you detached the infrastructure part into
> a separate module, which could be afterwards used by the ntb_perf and
> your ntb_latency drivers.
>
> What would be the best if you created it as a kernel library with a
> well-defined interface, which could be used not only by the test
> drivers, but by any kernel application (most importantly by the NTB
> transport driver) for the basic communications (like MW xlate address
> exchange, portable MW xlate address setup, etc).
>
> >
> > > I am very sorry to spilling it out at this stage. I should have done
> > > it on v1 or v2. Anyway it's up to the driver/subsystem maintainers
> > > (Dave, Jon) to decide whether the suggested update is suitable despite
> > > of all my thoughts.
> > >
>
> > Let's call for the third opinion.
>
> Ok.
>
> -Sergey

The merge window is closing soon. I'm going to drop the v3 that I
currently have and let this cook for a little longer.  Let's do a v4
with all of the feedback that has been agreed on, and then we can take
a look again.

Thanks,
Jon

> >
> >
> > --
> > Regards,
> >   Alexander
