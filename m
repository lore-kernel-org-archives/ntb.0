Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E8253BE
	for <ntb@lists.linux.dev>; Tue, 16 Aug 2022 17:56:19 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id a4so1794648wrq.1
        for <ntb@lists.linux.dev>; Tue, 16 Aug 2022 10:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=k5DkGkTOKyCfGJSB3JVSoc8oJOjT+G0s0ql7SDBxRkA=;
        b=a7uuP9Lj0ZWS1UlXzGzuRS1wQ12lW7eFvBZ1x3feeUA4IpgadpznseHR/cAM2hFN+h
         QiVj4oucnkZOLC4AU9Is0nPEgXM6aRTJDVMvOVhE3FtfUzaR271n+bu7NDC16D8y/73j
         p8JcRA0ELEooGfoDIAwQtEIhjkcxvXfZoISoj+JtWTvolIZMYeEo81xPNQOOBg/Ab6Ra
         j+7TxSIzvSOBhTBjO7h28sq2HqgLzE+WS58GSkpHIpNRh4XXvMPeEyx1AtBtkP0Zs7sE
         v/dvCMn7A1fs5L5juo7CiIJFTrpsDMlFyRydLN07DO98vnMR3BhGXiEybdkuRJnxt7UM
         Q5BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=k5DkGkTOKyCfGJSB3JVSoc8oJOjT+G0s0ql7SDBxRkA=;
        b=uUgrOedFnRq+lX13O5Oy3OGKFWz4mQg/chHuJmdgdLwZ/qXSajjUWMau9XH59ocRSV
         H23iq0ztzUKV+dznuTdm7mWWe50GkEysGdsOGrg1+FVuwbuS00j433DBNKP3N0uzwNnV
         F5BoPVDC0DhVCC4gGPuPBWhUVTLReYzvH6U90OfPkFe8Xj29cMR+btTgo6FEzKNYQcjm
         z2rkuFtx+bjCA1wvypCU0Ta5fvOXzB49vgusijHp7B8SxG1mxrH179qusqnuv6joryBw
         EZ7CyF1tJSho8+xyHLAnOy1FyRjNUknivkhMpco9ndHEUuLM3aNEOZ8azUMua9rsnJS8
         qgBg==
X-Gm-Message-State: ACgBeo39/lM/tQEQCPuJOIagyxyY3S8P0swmKvYHgvuAHfOPstShDORa
	lXPRTiDqPv6tDPJ2KMiuCCk=
X-Google-Smtp-Source: AA6agR7ve1RThPpT1dJnCIpHTak7OCIHWHZMczFKRXLDCvhfIm8hlUV1WSdmvH9ip2yd1GCysKrWVQ==
X-Received: by 2002:a5d:5e82:0:b0:223:71e4:9128 with SMTP id ck2-20020a5d5e82000000b0022371e49128mr12226670wrb.227.1660672577603;
        Tue, 16 Aug 2022 10:56:17 -0700 (PDT)
Received: from localhost ([185.36.143.175])
        by smtp.gmail.com with ESMTPSA id t16-20020adfdc10000000b0021e5f32ade7sm10747704wri.68.2022.08.16.10.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 10:56:17 -0700 (PDT)
Date: Tue, 16 Aug 2022 20:56:15 +0300
From: Alexander Fomichev <fomichev.ru@gmail.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: ntb@lists.linux.dev, linux@yadro.com, Jon Mason <jdmason@kudzu.us>,
	Allen Hubbe <allenbh@gmail.com>,
	Guo Zhengkui <guozhengkui@vivo.com>, fancer.lancer@gmail.com,
	Alexander Fomichev <a.fomichev@yadro.com>
Subject: Re: [PATCH v4 0/3] ntb_perf: add new 'latency' test set
Message-ID: <20220816175615.noyouup5dputyacu@yadro.com>
References: <20220812165544.26307-1-fomichev.ru@gmail.com>
 <68e750b4-001f-d0d7-1449-c8eda13d4b5e@intel.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68e750b4-001f-d0d7-1449-c8eda13d4b5e@intel.com>

Hi Dave,

On Mon, Aug 15, 2022 at 09:45:13AM -0700, Dave Jiang wrote:
> 
> Hi Alexander, can you add the change log between revisions in the cover
> letter please? That helps folks that have formerly reviewed to know what has
> changed since your last revision. Thanks!
> 


Changelog V4:

- Disable latency measurement by default ('perf_latency' module parameter),
  suggested by Serge Semin.
- Produce warning and continue instead of termination with error in case
  of few steps and thus inaccurate measurement. Suggested by Serge Semin.
- Integrate Max Filippov's patch "drivers/ntb/test: avoid 64-bit modulus
  operation" to eliminate compile errors on 32 bit architectures.
  https://lore.kernel.org/ntb/20220627155710.2067032-1-jcmvbkbc@gmail.com/


-- 
Regards,
  Alexander
