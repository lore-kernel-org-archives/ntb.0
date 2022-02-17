Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BEB435D
	for <ntb@lists.linux.dev>; Thu, 17 Feb 2022 16:31:34 +0000 (UTC)
Received: by mail-yb1-f180.google.com with SMTP id bt13so14226079ybb.2
        for <ntb@lists.linux.dev>; Thu, 17 Feb 2022 08:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gigaio-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KOMv/3OsceOXLKUzvBcSQZyjFovZexHBYllHNC5xJvA=;
        b=bPc6qeeze8TrY8+5nh4AYkcw7FP4KuncSMK05ykuYZSAXpVqQ1OkhdER5WMXrnsiej
         vYsTbojKjt4i+Rlj+/0akbyIRyw87EWDQ15cRHxwDtt+F+TaQwvpxBr+mx1yg8YFlUD0
         +QeypCdkzd/vtSCXtaEr2O+DjKRUKH2nfIPCqaHpbnZM6KM8ld0/Zmk2mFoCES9kg+w/
         Mo5kXMiCP+Meax5AqC+zsXBiVQ5zf4uZuSrpJWEdTiV8UJE4SKYpy12qXqdXFaEwsWSA
         NE5n1yYg4YOxZnlv2e4jpX3Ltke5jNXh/Q3VBTR6HGgh8EciFMGg6akTGun8y1UgIFfa
         WrHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KOMv/3OsceOXLKUzvBcSQZyjFovZexHBYllHNC5xJvA=;
        b=7EM3mOZLexPMceUET/Xb+9EXd8TC4j3Y55xF2OJ2f0ENd8aUAiWFSctsWGto6vRDZh
         tw3xCdcBPAYSInFlSUgNBxahzJk/Fv0fWpbm2MU3MSs903fflPgjY9a51XeLbbzE1eRt
         kteVUonZk2yA0ThQ9VbbZVq3Lue7Y2TFPj80gUR1y6ne4BIZ2Vs8u1DuSsbbI1I2iB/R
         4F9FgrENPbZPwmYPqJO991aBtaJ9OPFgz9LScdsyjf6qp0zbtZU4lnHZxvq8DlBGD5zy
         2fSIhRC4A8kyq0YK+58WTVb1LkZ+uW97yEeQs+/SwhKBXZD/45aMI8MEPxLIJZMzWt3P
         EPXg==
X-Gm-Message-State: AOAM531S0nA7fFRvzGGv5kjX8sT/r52wMmxtvrF2lfAmhjjdvClkHKDE
	CNJ0+RaBoHJEoYPPSLPwVakKXhGpjWyFM1XmMeUvew==
X-Google-Smtp-Source: ABdhPJxdDwWSNFxQAKsBML9Sa+JWlZseCqAw6DVU1UvXpaQDIZUuVmxWwDqBYup1OXZXW2dwBScirXoUwtAhMd3YBA4=
X-Received: by 2002:a25:23ca:0:b0:623:f32b:1184 with SMTP id
 j193-20020a2523ca000000b00623f32b1184mr3161961ybj.273.1645115493754; Thu, 17
 Feb 2022 08:31:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAH6h+hfwRFMW47ONT+zC8Z1Y-30gb4dPEwTOtatN86EMeUajpA@mail.gmail.com>
 <1d53b232-dc0a-c7d3-69a1-8cb17ff83601@deltatee.com> <CAH6h+hdbOEjpU5tn+MwDm-h=47b4kzMHDZhSc51hA0VOZLp_8g@mail.gmail.com>
In-Reply-To: <CAH6h+hdbOEjpU5tn+MwDm-h=47b4kzMHDZhSc51hA0VOZLp_8g@mail.gmail.com>
From: Eric Pilmore <epilmore@gigaio.com>
Date: Thu, 17 Feb 2022 08:31:22 -0800
Message-ID: <CAOQPn8vVMKF8GMd2kXNCGawWZBcjOCM_7XFkq+YX2rbQ9wTOgw@mail.gmail.com>
Subject: Re: ntb_netdev Communication Failure Issue
To: Marc Smith <msmith626@gmail.com>
Cc: Logan Gunthorpe <logang@deltatee.com>, ntb@lists.linux.dev, 
	Kelvin Cao <kelvin.cao@microchip.com>, kelvincao@outlook.com
Content-Type: text/plain; charset="UTF-8"

On Thu, Feb 17, 2022 at 7:22 AM Marc Smith <msmith626@gmail.com> wrote:
>
>
> Is it possible there are some special NTB/BIOS settings needed for
> this hardware?

I'm assuming you have the switch (NTB) properly configured so that the
respective partitions can talk to each other. The other part is
ensuring that the NT BAR did properly enumerate. If it is large, it
can become a challenge for some BIOSes to be able to enumerate it.  Do
a "sudo lspci -vvv -s <BDF>" with the BDF of the NT EP, and ensure
that the BARs (Regions 2,4) have MMIO space assigned.

When you try to run, anything interesting show up in "dmesg", such as
DMAR errors?

Eric
