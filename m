Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB5910EB
	for <ntb@lists.linux.dev>; Fri, 29 Apr 2022 08:53:37 +0000 (UTC)
Received: by mail-lj1-f182.google.com with SMTP id q14so9684613ljc.12
        for <ntb@lists.linux.dev>; Fri, 29 Apr 2022 01:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=loxrZrEbhJ3xNEs21Wj1YrPjzUeuXfYfk2XtqyZiU90=;
        b=F1H4btF5ZCK4G4t2yTcR6H9SxK+jw82aAoGzOOjP6caWubm5j34aesnB/7AfagIqh1
         x1l3JkepzCAdRQrzcl3+mn5OV4WK2bPMOHVwxtoYYsrs6KIslwyu/CX/IYUP6cbhBoEJ
         uHiJnddbyziEx/E6DTYAmZKp2FhSaXDF0OPKaJJUw4G6BEBs4hOAtzp9tPp7UCJOyB/a
         t069g/dFmwWg1qsc6OjBXxTz3tBdhf393F1zaNuuGn4lXywjgePeX4UhoxXu6HY4w4NS
         ZF/TtNoYmVKg3+UUNGB9PWi5KtjxaurEzsKtve852RPMrOXjPGjoZjZkxfvHjvz8TPlI
         E0rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=loxrZrEbhJ3xNEs21Wj1YrPjzUeuXfYfk2XtqyZiU90=;
        b=qDKyfEO7pGC5ztKBT5hNnk1r2231QBamMdHjCLgs5zzifD6TXaK8jCsBHvky7esbw5
         BLolLquiwqgohWabVsEzAJZMeLC60iVaF7JE1yaLJhV7x7ghrJXIHfUprZinhJmlUXly
         fHdlJ5IdljrdT43r09OL00ImkWuOs/Gh+FiRyjRn+BHGA3T/tPtJw6Ce7mMnnzW7eRzz
         U1yVcsiadBMCvC6RhbVljPOD3ZD4G93NHQo9b2WLd6666SRxMbPvvhDeqdDTEZLariq3
         R5pYrsx4Yl6cLzs5Y/aVn1UBhV3UmD1p1MU88OyEiIBj0wf394DJnUEmIhdFvmP1vqcW
         X+6w==
X-Gm-Message-State: AOAM533THFejlG01t5fY75dR7fSUXgVDiGx0CtHxy83W2m1vIFWyYZfE
	bQ0eTsoGHkintLSReFntRnM=
X-Google-Smtp-Source: ABdhPJwG5lXOFqjQeEafrudOJ/IrcZ8XNjzUBV3pwJ63el4zIyHut+6C6gQdi8JjZLHMQ3AtvLpIJA==
X-Received: by 2002:a2e:9b4d:0:b0:244:da30:84c2 with SMTP id o13-20020a2e9b4d000000b00244da3084c2mr24527600ljj.359.1651222414861;
        Fri, 29 Apr 2022 01:53:34 -0700 (PDT)
Received: from localhost ([62.217.189.101])
        by smtp.gmail.com with ESMTPSA id d2-20020a056512320200b004721999f1cesm186657lfe.66.2022.04.29.01.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 01:53:34 -0700 (PDT)
Date: Fri, 29 Apr 2022 11:53:33 +0300
From: Alexander Fomichev <fomichev.ru@gmail.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: ntb@lists.linux.dev, linux@yadro.com, Jon Mason <jdmason@kudzu.us>,
	Allen Hubbe <allenbh@gmail.com>,
	Guo Zhengkui <guozhengkui@vivo.com>,
	Alexander Fomichev <a.fomichev@yadro.com>
Subject: Re: [PATCH v2 2/3] ntb_perf: extend with poll latency measurement
Message-ID: <20220429085333.is4wky7gslqjtbin@yadro.com>
References: <20220422113703.48820-1-fomichev.ru@gmail.com>
 <20220422113703.48820-2-fomichev.ru@gmail.com>
 <384e2fc0-27be-00f9-974d-70a4acdee1c5@intel.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <384e2fc0-27be-00f9-974d-70a4acdee1c5@intel.com>

Hi Dave,

On Mon, Apr 25, 2022 at 09:49:43AM -0700, Dave Jiang wrote:
> 
> On 4/22/2022 4:37 AM, Alexander Fomichev wrote:
> > From: Alexander Fomichev <a.fomichev@yadro.com>
> > 
> > The proposed change extends ntb_perf with 2nd of 3 new metrics. The resulting
> > test is fully backward compatible.
> > 
> > 2. Poll latency. It's a delay between start to send 1 byte to the
> > remote system and receiving the confirmation. The remote system needs to
> > be run in server mode beforehand. Then the server polls the input buffer
> > and on receiving data immediately sends the confirmation back.
> 
> This is a general comment. Please make the commit logs as they are
> individual standalone patches and not refer to each other.

OK.

> 
> > 
> > Signed-off-by: Alexander Fomichev <a.fomichev@yadro.com>
> > ---
> >   drivers/ntb/test/ntb_perf.c | 365 +++++++++++++++++++++++++++++++++++-
> >   1 file changed, 364 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
> > index 79faa4a7fe94..d4664410e543 100644
> > --- a/drivers/ntb/test/ntb_perf.c
> > +++ b/drivers/ntb/test/ntb_perf.c
> > @@ -85,7 +85,7 @@
> >   #include <linux/ntb.h>
> >   #define DRIVER_NAME		"ntb_perf"
> > -#define DRIVER_VERSION		"2.0"
> > +#define DRIVER_VERSION		"2.1"
> 
> Oddly random version change in the middle patch.
> 
I will re-number every feature as minor version change, accumulating your
comment to the 3rd patch.

> 
> >   MODULE_LICENSE("Dual BSD/GPL");
> >   MODULE_VERSION(DRIVER_VERSION);
> > @@ -133,6 +133,10 @@ static unsigned long lat_time_ms = 1000; /* default 1s */
> >   module_param(lat_time_ms, ulong, 0644);
> >   MODULE_PARM_DESC(lat_time_ms, "Time (in ms) to test latency");
> > +static unsigned long lat_timeout_us = 500;
> > +module_param(lat_timeout_us, ulong, 0644);
> > +MODULE_PARM_DESC(lat_timeout_us, "Timeout (in us) to wait for server reply");
> 
> I would refrain from using the word "timeout" for variable and description
> as that's typically used for when a set time expires. Maybe "Roundtrip
> Latency" would be the better description?
> 
In this case it's a real timemout. The client polls the buffer waiting
for the server reply. If that amount of time expired and no reply word
encountered, then an error reported.


-- 
Regards,
  Alexander
