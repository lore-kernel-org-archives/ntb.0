Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A215C10E8
	for <ntb@lists.linux.dev>; Wed, 22 Jun 2022 09:45:01 +0000 (UTC)
Received: by mail-lf1-f41.google.com with SMTP id a2so26822269lfg.5
        for <ntb@lists.linux.dev>; Wed, 22 Jun 2022 02:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qG5+AcuVdGte124Uq5dDiYWRpdIwknEeonE9wQWpS5s=;
        b=p+V6lib03YC5sv7kAFCUzFZMH3XiKiQ8tBBbMyiu8+4lwNWy2vTIvngtx0dqKm2l0R
         EZV8vFU7IpxSwV11CCNGBRmYGGErHp/sOYiOMy/4NtokocCecq88hygjbrB7Og7pFfHG
         k8O/32lkw25OPcpHRrsMNEjXaj2fhPCXdXI+S1LX+TOrNgyIc8/Ba5GeJL5eY5Qn8Due
         rQc4Ct2yccoa60IC17bQqdJybbqCByhjvp8++nlNEePJdsSZpgvu6cuvL2daPZvGnYpT
         IOsyeAfFuE91fJv6pscPOJVkIoZrUV263MoIXWMIT1Uys1EQKiqPcFwA4zBd8eMMUAti
         Jpbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qG5+AcuVdGte124Uq5dDiYWRpdIwknEeonE9wQWpS5s=;
        b=USBXOzKF8eNfdLI0fv7oSG9of4pkpDHzZH64pMfn3yz3A1fMdP9tBikqfa4owTIaA6
         igqCMWRsJdL5+14/pYmtIe1ppZLE0lm03Ozw2BqQDZxENTk72A9b6sML2ac2s969v6bZ
         ot3KUHXM3KrS8VuXX03xgKiPb77DIY/ZP1py1l4JwwQ/XaCw3UbTrYPCeBRFVMECd/kW
         Znsl3WyvktrpxWbUFQn8Zac9SqHhquXoMFJIRyxJkpkmP+w6PAlflhZv4BiDhphrQwlH
         RYIRONixHKHWNc215cBHkHcugz2nSE0E6JumJGgJvE4dSwm4hcex/coRczPnT6KJTn/Y
         J0Ug==
X-Gm-Message-State: AJIora//ZVhE2V4wGWSWNtwERXW5tngIqXfVRuWxufzdOucfh7cTuxCl
	p+vUkjYjZNy9Ce47kSNF6bw=
X-Google-Smtp-Source: AGRyM1sdPye6z8kWMwlA8lHVm/WO/U8ihdqru/BdvUVDrbGDFfbAgYUFDcrWbnKHUJD1+5epQWaM5g==
X-Received: by 2002:a05:6512:1693:b0:474:35c:8c11 with SMTP id bu19-20020a056512169300b00474035c8c11mr1559263lfb.19.1655891099390;
        Wed, 22 Jun 2022 02:44:59 -0700 (PDT)
Received: from localhost ([62.217.189.101])
        by smtp.gmail.com with ESMTPSA id q16-20020a05651232b000b0047f6590af3asm1530020lfe.107.2022.06.22.02.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 02:44:58 -0700 (PDT)
Date: Wed, 22 Jun 2022 12:44:57 +0300
From: Alexander Fomichev <fomichev.ru@gmail.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	ntb@lists.linux.dev, linux@yadro.com,
	Allen Hubbe <allenbh@gmail.com>,
	Guo Zhengkui <guozhengkui@vivo.com>,
	Alexander Fomichev <a.fomichev@yadro.com>
Subject: Re: [PATCH v3 0/3] ntb_perf: add new 'latency' test set
Message-ID: <20220622094457.52x4gfve3g3r3kvj@yadro.com>
References: <20220513193704.36868-1-fomichev.ru@gmail.com>
 <60dd9f2e-57b1-7c9d-ca99-568c37fe286a@intel.com>
 <20220525085801.4r2l44vqiaqrbjk4@mobilestation>
 <20220620102014.7oiq3yh7jfvzacpm@yadro.com>
 <YrCHbmrNy9obZe2t@kudzu.us>
 <20220621140537.tfhsqez4wh7ehftv@mobilestation>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621140537.tfhsqez4wh7ehftv@mobilestation>

Hi Serge,

Thank you for the very detailed comments.

On Tue, Jun 21, 2022 at 05:05:37PM +0300, Serge Semin wrote:
> 
> Please also note, there is a special test-script, which rely on the
> certain test drivers semantic:
> tools/testing/selftests/ntb/ntb_test.sh
> It looks like the suggested patches don't change the already defined
> ntb_perf DebugFS interface, but still may cause the script to fail if the
> latency on the particular system will get measured too high. So should
> we have the latency-part in a separate driver, the script won't get
> affected by it. If it is required the script could be updated accordingly
> taking the new driver specifics into account.
>
As described in the cover commit message, the resulting test is fully
backward compatible. I mean that if we don't fiddle with the new sysfs
entries, then no latency measures are performed, and the test works as
it did before the patch set.
Also, I plan to make changes to "ntb_test.sh" script accordingly, after
this patch set is merged.

> Regarding the tests implementation. As I see it failing the latency
> measurements if they're performed with the too few retries isn't a good
> idea. Alexander, you said that normally performing 1000 retries is
> enough to get the latency with a good precision, but the test driver
> returns an error if the number of retries is less than 20. So what
> happens between 20 and 1000? The tests get passed, but the results
> aren't accurate or what? If so then why don't the test fail in the
> case of 30 iterations too? IMO as long as you don't define the strong
> accuracy criteria, the failure condition shouldn't be determined by
> the number of iterations. So if I were you I would execute the latency
> tests with the specified "lat_time_ms" duration and printed a warning
> if the number of iterations turned to be too low (100, 200?) most
> likely causing to have inaccurate results, but still would calculate
> the latency from the determined numbers (even if there were only one
> iteration performed).
> 
Reasonable. I can easily change this part.

> The main issue is that after applying all the changes the ntb_perf
> driver will get extended greatly with three additional sub-tests
> and thus will loose its coherency. It gets to be obvious after
> the patch 2 and 3 applied, which introduce additional client-server
> semantic and imply allocating their-own private data. All of that
> makes the code much harder to read and breaks the driver specialization.
> 
> The latency tests as them-self are very useful though. But it would be
> much better to have them implemented in a separate driver
> "ntb_latency" or something.
>
The whole 'latency' part relies on 'ntb_perf' infrastructure. Moreover,
the first patch adds only one meaningful function.  Thus separatin theg
'latency' part will make me copy a lot of code. As a compromise, I can
offer to put latency-related code into a separate .c file but leave the
whole test in a single module. That should increase readability and
eliminate code duplication.

> I am very sorry to spilling it out at this stage. I should have done
> it on v1 or v2. Anyway it's up to the driver/subsystem maintainers
> (Dave, Jon) to decide whether the suggested update is suitable despite
> of all my thoughts.
> 
Let's call for the third opinion.


-- 
Regards,
  Alexander
