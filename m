Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B5A7B
	for <ntb@lists.linux.dev>; Sun, 21 Aug 2022 18:48:59 +0000 (UTC)
Received: by mail-lf1-f44.google.com with SMTP id l1so12005614lfk.8
        for <ntb@lists.linux.dev>; Sun, 21 Aug 2022 11:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=C2FwcWzogOkDxC9omazd58oqypiCR0Liv8LuSilJTJ4=;
        b=HOlHdQCk+GI1cZZo+5s+eUA3BBpWJznwVEcuQQ/DvgbA2kE9V1q4SIbHaYkWu3a3bo
         R5iTxzTqpM6iCW5U+I4CCICFTlJkajNwbtgRx493r5GMFVJVJqM5KyMYGtiYLnNQp763
         Rk07sIBP2U0bG6nvQp2sJ/50NQdVAWqHeVD7srOavYfRjkx40EBFi3H+NGYyvOyl1YZy
         nQmKYYiCX5geSt7Bu8QZZo1dHaUU1aNWgD4HBzJ6qoGNshwkRhNaVeQTcJEnnYraUeEu
         jlQSbWbMJBIWheTSk0R5yi5WGdZ6xHPaqWuu1q+w3ygUdcTC0HzbxnVs0R6lNWVVJU3f
         Ajkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=C2FwcWzogOkDxC9omazd58oqypiCR0Liv8LuSilJTJ4=;
        b=DHOTtAuuFUXNjP1HXj46UFRZyGF4EYOldSSw/uyi/8bFbrWt01fbzP5qrFVsfLEr08
         VpNqhuTNRF6GmIWLlv/qqMN7R2MSKubpcNeSQdH0J8ORc/br3nvxaTdPhOCEkRp9CT3B
         s1an/4Ucp+rHF0V8PmfEOMfcVmi8B2mSKLuYYkVGNt18AAkHgIY03Q4qwF3VdMR0biYp
         v9M1V9c2NUzCU3lGhVSGuC2A+VeP0XFSpb06CEktS7f+U2uiqsj1SLqWTwEakDXDUJuu
         weOxZnaxlz0n8mRhQsaiHgCatmZrjoMY4tDT/PsSeaI9UETDyWxOoNhlswdY4Ldi9lXH
         39Mw==
X-Gm-Message-State: ACgBeo0cZessUjGm44OBWVHEuka6JsdJdBODdIJ6QZlp+oEN6Xea5qL6
	cZfslTc9c3yyzj68txeAcHo=
X-Google-Smtp-Source: AA6agR5ep7N5xTdmxrdmQwdFbYhP2h9Yo7Hzgb6sOPwJQ9vYOWEJkMxiFqC5vJEFqjfrCY+spNFSvg==
X-Received: by 2002:a05:6512:1524:b0:48a:aff5:59d0 with SMTP id bq36-20020a056512152400b0048aaff559d0mr5490209lfb.122.1661107737646;
        Sun, 21 Aug 2022 11:48:57 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id s20-20020a056512215400b00492b313d37csm1582138lfr.134.2022.08.21.11.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 11:48:57 -0700 (PDT)
Date: Sun, 21 Aug 2022 21:48:55 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Alexander Fomichev <fomichev.ru@gmail.com>
Cc: ntb@lists.linux.dev, linux@yadro.com, Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
	Guo Zhengkui <guozhengkui@vivo.com>,
	Alexander Fomichev <a.fomichev@yadro.com>
Subject: Re: [PATCH v4 0/3] ntb_perf: add new 'latency' test set
Message-ID: <20220821184855.shajhgjq54ohctwc@mobilestation>
References: <20220812165544.26307-1-fomichev.ru@gmail.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220812165544.26307-1-fomichev.ru@gmail.com>

On Fri, Aug 12, 2022 at 07:55:41PM +0300, Alexander Fomichev wrote:
> From: Alexander Fomichev <a.fomichev@yadro.com>
> 
> The ntb_perf test provides a tool for NTB hardware performance
> evaluation. For software impact elimination the test uses a simple method
> (let's call it 'burst' mode), when the local system sends to the remote
> system a data set and counts time interval until hardware completion
> report, without the remote side confirming, nor data integrity check.
> The measured metric is a 'burst' throughput bandwidth of NTB connection.
> 
> The patches extend ntb_perf with 3 new metrics:
> 1) Burst latency
> 2) Poll latency
> 3) Doorbell latency
> 
> The resulting test set is fully backward compatible.

As before I think the latency test would be better to live in a
separate driver as I suggested here:
https://lore.kernel.org/ntb/20220622203648.jo6raa4h57g24el2@mobilestation/
The Messages/Spad+Doorbell-based communication part of the ntb_perf
driver could be moved into a separate module as a preparation patch.
The best approach would to create some kind of NTB communication
library, which could be used not only by the perf and latency tests,
but by the client drivers like NTB-transport, etc. Thus we'll finally
have a complete initialization solution for all types of the NTB
hardware: local and peer MW-based, Messages and Spad-based.

-Sergey

> 
> Alexander Fomichev (3):
>   ntb_perf: extend with burst latency measurement
>   ntb_perf: extend with poll latency measurement
>   ntb_perf: extend with doorbell latency measurement
> 
>  drivers/ntb/test/ntb_perf.c | 829 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 813 insertions(+), 16 deletions(-)
> 
> -- 
> 2.37.1
> 
