Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC36ECF
	for <ntb@lists.linux.dev>; Tue, 21 Jun 2022 14:05:42 +0000 (UTC)
Received: by mail-lj1-f178.google.com with SMTP id s14so8840631ljs.3
        for <ntb@lists.linux.dev>; Tue, 21 Jun 2022 07:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=k7ghLFrXeD/95LGgnJ72XmbqXKPndYyGp+IbxssW2Fo=;
        b=bcWFT5cQr2RniAR2FXU9m7us0HlvTZfY/fmY7Bg9Y4JiD0nlMOF/kUrIX68geGzgOj
         qNFulvaPG2AHk88oiBfeFqXkKn/DCSE2tAZ6MKmolNFRszBnPJnRUE++V0FECqJRD2A8
         b703cDGj+lWMHL2fZa/B48AC9akGzGyeVeFQxUQj1kO8ZV5z29tpztw9J31j8khIsZhc
         pBcoiPeK2MPaI0KXtMtiVBO77J/9n5VDl+hMfdKt0jq8tFQCKg5CcGo8LPGov1K0jtVf
         BcOmVvVrNBJvH44kO2FAw8nRn7jkxBpwVibp7GX+OZWtaKvjBsxv3jjPkJ9Wy36RmLkr
         gRGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k7ghLFrXeD/95LGgnJ72XmbqXKPndYyGp+IbxssW2Fo=;
        b=oMO6u5MMOh37Y3xte0JC7ieWgyVvn7BL6I0R5xoyyVLCW2jaFMymTWWXnzYiFZvwun
         kLk9Ug4TluHXoMkdj7SmhH4GQ1ZkJkzxE3C/t9exz1LpWsjMBePwuebR23Yq0ALexeqO
         hIcxAs54TIrHhJkJOUcTbiBGpvIt+EoWpYCJD4tS0Ycc6GJnELsZYUiyvDKCwF74XVN6
         w6r0k9/tdxVB6xuGJ5A0M36h1cZozKGvEViENCr3xQ65ljR8kJv6w4ZqgxaQ/QrA7/m5
         jPDmQB5ZgxJywwuzh9JRjGbKTYP02TdXSL/bhvQKgDX2V5FEs2rgzRteIVlZzwowGMJ5
         oteQ==
X-Gm-Message-State: AJIora/8XPeuzSYpKtqDl1Qh2xtCIN0UrTyUFomyJJknkmAuTO+cUgCL
	Nm9MmbFbEQd1Ml+zNJS3vl8=
X-Google-Smtp-Source: AGRyM1savavciv7i0hVkmI4UhRJUSVuvIHtl+J4eg2WH9WdrT7j0Ldoq332Aj3sSf+ox+M+LTovffA==
X-Received: by 2002:a2e:b88e:0:b0:255:953a:8d33 with SMTP id r14-20020a2eb88e000000b00255953a8d33mr13906666ljp.38.1655820340482;
        Tue, 21 Jun 2022 07:05:40 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id l3-20020a2e99c3000000b0025574e803fasm2027579ljj.18.2022.06.21.07.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 07:05:39 -0700 (PDT)
Date: Tue, 21 Jun 2022 17:05:37 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Jon Mason <jdmason@kudzu.us>
Cc: Alexander Fomichev <fomichev.ru@gmail.com>,
	Dave Jiang <dave.jiang@intel.com>, ntb@lists.linux.dev,
	linux@yadro.com, Allen Hubbe <allenbh@gmail.com>,
	Guo Zhengkui <guozhengkui@vivo.com>,
	Alexander Fomichev <a.fomichev@yadro.com>
Subject: Re: [PATCH v3 0/3] ntb_perf: add new 'latency' test set
Message-ID: <20220621140537.tfhsqez4wh7ehftv@mobilestation>
References: <20220513193704.36868-1-fomichev.ru@gmail.com>
 <60dd9f2e-57b1-7c9d-ca99-568c37fe286a@intel.com>
 <20220525085801.4r2l44vqiaqrbjk4@mobilestation>
 <20220620102014.7oiq3yh7jfvzacpm@yadro.com>
 <YrCHbmrNy9obZe2t@kudzu.us>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrCHbmrNy9obZe2t@kudzu.us>

Hi folks,

On Mon, Jun 20, 2022 at 10:42:54AM -0400, Jon Mason wrote:
> On Mon, Jun 20, 2022 at 01:20:14PM +0300, Alexander Fomichev wrote:
> > Hi Serge,
> > 
> > On Wed, May 25, 2022 at 11:58:01AM +0300, Serge Semin wrote:
> > > 
> > > Ok. I'll have a look at the series on this week.
> > > 
> > 
> > I kindly remind you about the review.

I am very sorry for the huge delay with the review especially after I
promised to have a look at the series one month ago.

> 

> I've pulled this into my ntb branch.  So, barring a nack by Serge,
> I'll push it for v5.20.  And if I see an ack by him, I'll try to add
> that in as well :)

I've thoroughly looked at the entire series and IMO in the current
state I wouldn't recommend to merge it in.
The main issue is that after applying all the changes the ntb_perf
driver will get extended greatly with three additional sub-tests
and thus will loose its coherency. It gets to be obvious after
the patch 2 and 3 applied, which introduce additional client-server
semantic and imply allocating their-own private data. All of that
makes the code much harder to read and breaks the driver specialization.

The latency tests as them-self are very useful though. But it would be
much better to have them implemented in a separate driver
"ntb_latency" or something.

Please also note, there is a special test-script, which rely on the
certain test drivers semantic:
tools/testing/selftests/ntb/ntb_test.sh
It looks like the suggested patches don't change the already defined
ntb_perf DebugFS interface, but still may cause the script to fail if the
latency on the particular system will get measured too high. So should
we have the latency-part in a separate driver, the script won't get
affected by it. If it is required the script could be updated accordingly
taking the new driver specifics into account.

Regarding the tests implementation. As I see it failing the latency
measurements if they're performed with the too few retries isn't a good
idea. Alexander, you said that normally performing 1000 retries is
enough to get the latency with a good precision, but the test driver
returns an error if the number of retries is less than 20. So what
happens between 20 and 1000? The tests get passed, but the results
aren't accurate or what? If so then why don't the test fail in the
case of 30 iterations too? IMO as long as you don't define the strong
accuracy criteria, the failure condition shouldn't be determined by
the number of iterations. So if I were you I would execute the latency
tests with the specified "lat_time_ms" duration and printed a warning
if the number of iterations turned to be too low (100, 200?) most
likely causing to have inaccurate results, but still would calculate
the latency from the determined numbers (even if there were only one
iteration performed).

I am very sorry to spilling it out at this stage. I should have done
it on v1 or v2. Anyway it's up to the driver/subsystem maintainers
(Dave, Jon) to decide whether the suggested update is suitable despite
of all my thoughts.

-Sergey

> 
> Thanks,
> Jon
> 
> > Thanks.
> > 
> > -- 
> > Regards,
> >   Alexander
