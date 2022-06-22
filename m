Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24764111B
	for <ntb@lists.linux.dev>; Wed, 22 Jun 2022 20:36:53 +0000 (UTC)
Received: by mail-lf1-f49.google.com with SMTP id f39so14126181lfv.3
        for <ntb@lists.linux.dev>; Wed, 22 Jun 2022 13:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZfHupK9hRhtnd5t6GGGgTf2v5tyR2N/tHz46UJtTY0A=;
        b=OuiG3CCVdqEM63HFEiLL8964KoI5KAKM6xgrl7ojtMezmruEIloYuymfby9h1v50vE
         kLFrS0sdkJ6mNNX15nwpynU1HXTY2+xJVBnGdsCGsJgDgnD/ewQV0D/ZjZEojFA4KTqJ
         SqdXIwkBsr+mCyZpG84cvdsWdySUfCj4MbDkalP2v7y3Iwp2Xl0QXwQVktl882VhWdsj
         nuapD4hL4ljXX15g4oWOeHRZd4liBbAEtjPpuWW4ifSedH/yEIB3HG06eZHNJwvLxyjv
         8O9JLr8VCafSBBNotGHmortzByr1MqyPsgjWFAoAoIxx46XQuDaQCnAy53yNMPFhmQj2
         PFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZfHupK9hRhtnd5t6GGGgTf2v5tyR2N/tHz46UJtTY0A=;
        b=h+sJsmEQ2XofQ7eP10h4xgUefkrxrx5kZlgMLMhv6JOZAHxdYWsUFm3pvHKj1SXMb3
         k2swI65QnJYNT8Ftom5igzhnHrIsr1ZK16ps+vhJ9dvmgDnQq606xPz1Ebgk8SA1BgXs
         gLADPYrvEJAELNz9IuPU76Ta19eFR5Jw1kKlMRwxoRww2gH6Ix5zZRv36ElEJFj+KlmR
         in9NBqfKapFzJCPUBVPn4y7Z05axdRWf4ubA8E3W+CLeBnqdZS7rvpsIAd0LZ6IDYJsQ
         csISPE2VhBBeYW/x8Q9gql6l90qPAWzOXQWIa+HJZLsNP9Xxptxcvcx0XvsDz9XYuk9i
         G9mw==
X-Gm-Message-State: AJIora8O5Tt2dJOakv4sgqLTBymcX046w/hQbqWwilLJNlrFU4PccMQZ
	hzp0hYVp86VpXx8heWycOWw=
X-Google-Smtp-Source: AGRyM1tK84tEYHeiaSQjAeEcwgFuUSS88uDwlN6D2TUDQV/MG4/mQtYKKDXt48brGOZp1NbgqLcXBw==
X-Received: by 2002:a05:6512:202d:b0:47f:7d1b:bb7e with SMTP id s13-20020a056512202d00b0047f7d1bbb7emr3243029lfs.615.1655930211080;
        Wed, 22 Jun 2022 13:36:51 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id x4-20020a056512078400b0047f6c48a603sm1484195lfr.202.2022.06.22.13.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 13:36:50 -0700 (PDT)
Date: Wed, 22 Jun 2022 23:36:48 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Alexander Fomichev <fomichev.ru@gmail.com>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	ntb@lists.linux.dev, linux@yadro.com,
	Allen Hubbe <allenbh@gmail.com>,
	Guo Zhengkui <guozhengkui@vivo.com>,
	Alexander Fomichev <a.fomichev@yadro.com>
Subject: Re: [PATCH v3 0/3] ntb_perf: add new 'latency' test set
Message-ID: <20220622203648.jo6raa4h57g24el2@mobilestation>
References: <20220513193704.36868-1-fomichev.ru@gmail.com>
 <60dd9f2e-57b1-7c9d-ca99-568c37fe286a@intel.com>
 <20220525085801.4r2l44vqiaqrbjk4@mobilestation>
 <20220620102014.7oiq3yh7jfvzacpm@yadro.com>
 <YrCHbmrNy9obZe2t@kudzu.us>
 <20220621140537.tfhsqez4wh7ehftv@mobilestation>
 <20220622094457.52x4gfve3g3r3kvj@yadro.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622094457.52x4gfve3g3r3kvj@yadro.com>

On Wed, Jun 22, 2022 at 12:44:57PM +0300, Alexander Fomichev wrote:
> Hi Serge,
> 
> Thank you for the very detailed comments.
> 
> On Tue, Jun 21, 2022 at 05:05:37PM +0300, Serge Semin wrote:
> > 
> > Please also note, there is a special test-script, which rely on the
> > certain test drivers semantic:
> > tools/testing/selftests/ntb/ntb_test.sh
> > It looks like the suggested patches don't change the already defined
> > ntb_perf DebugFS interface, but still may cause the script to fail if the
> > latency on the particular system will get measured too high. So should
> > we have the latency-part in a separate driver, the script won't get
> > affected by it. If it is required the script could be updated accordingly
> > taking the new driver specifics into account.
> >

> As described in the cover commit message, the resulting test is fully
> backward compatible. I mean that if we don't fiddle with the new sysfs
> entries, then no latency measures are performed, and the test works as
> it did before the patch set.

sysfs? Did you mean debugfs?
Anyway the DebugFS interface will be indeed backward compatible, but
functionally the performance test won't be the same. AFAICS at the
very least the burst-latency test is executed by default together with
the standard performance test. It may cause ntb_test.sh regressions on
the systems (the test will fail if the latency is too high), which
haven't had any problem before.

> Also, I plan to make changes to "ntb_test.sh" script accordingly, after
> this patch set is merged.

Good. It will be much easier to do should you have the latency test
implemented as a separate driver.

> 
> > Regarding the tests implementation. As I see it failing the latency
> > measurements if they're performed with the too few retries isn't a good
> > idea. Alexander, you said that normally performing 1000 retries is
> > enough to get the latency with a good precision, but the test driver
> > returns an error if the number of retries is less than 20. So what
> > happens between 20 and 1000? The tests get passed, but the results
> > aren't accurate or what? If so then why don't the test fail in the
> > case of 30 iterations too? IMO as long as you don't define the strong
> > accuracy criteria, the failure condition shouldn't be determined by
> > the number of iterations. So if I were you I would execute the latency
> > tests with the specified "lat_time_ms" duration and printed a warning
> > if the number of iterations turned to be too low (100, 200?) most
> > likely causing to have inaccurate results, but still would calculate
> > the latency from the determined numbers (even if there were only one
> > iteration performed).
> > 
> Reasonable. I can easily change this part.
> 
> > The main issue is that after applying all the changes the ntb_perf
> > driver will get extended greatly with three additional sub-tests
> > and thus will loose its coherency. It gets to be obvious after
> > the patch 2 and 3 applied, which introduce additional client-server
> > semantic and imply allocating their-own private data. All of that
> > makes the code much harder to read and breaks the driver specialization.
> > 
> > The latency tests as them-self are very useful though. But it would be
> > much better to have them implemented in a separate driver
> > "ntb_latency" or something.
> >

> The whole 'latency' part relies on 'ntb_perf' infrastructure.

Yeah, it's very handy, isn't it? =)
Originally it has been created in a way so the perf-test would be
portable across all the supported NTB HW types: local- and peer-based
MW xlate address setup (Intel/AMD/Switchtec NTB HW vs IDT NTB HW),
Scratchpad and Messages capable devices (Intel/AMD/Switchtec NTB HW vs
IDT NTB HW). My idea was to provide a reference of how a portable NTB
application could be designed. (It took some hard time to debug that
part on the Intel/AMD hardware since nobody of the current maintainers
had an access to one at that moment.) On the next step I was going to
move the communication part of the ntb_perf driver to a separate
kernel module as a communication library (which could be used for the
inter-domains basic communications on top of the DB+Spad/MSG
interface), but alas didn't find a time to get to work on it.

> Moreover,
> the first patch adds only one meaningful function.  Thus separatin theg
> 'latency' part will make me copy a lot of code. As a compromise, I can
> offer to put latency-related code into a separate .c file but leave the
> whole test in a single module. That should increase readability and
> eliminate code duplication.

What would be much better if you detached the infrastructure part into
a separate module, which could be afterwards used by the ntb_perf and
your ntb_latency drivers.

What would be the best if you created it as a kernel library with a
well-defined interface, which could be used not only by the test
drivers, but by any kernel application (most importantly by the NTB
transport driver) for the basic communications (like MW xlate address
exchange, portable MW xlate address setup, etc).

> 
> > I am very sorry to spilling it out at this stage. I should have done
> > it on v1 or v2. Anyway it's up to the driver/subsystem maintainers
> > (Dave, Jon) to decide whether the suggested update is suitable despite
> > of all my thoughts.
> > 

> Let's call for the third opinion.

Ok.

-Sergey

> 
> 
> -- 
> Regards,
>   Alexander
