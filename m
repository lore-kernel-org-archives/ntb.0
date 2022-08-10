Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1711528F1
	for <ntb@lists.linux.dev>; Wed, 10 Aug 2022 14:32:09 +0000 (UTC)
Received: by mail-qk1-f179.google.com with SMTP id f14so11266374qkm.0
        for <ntb@lists.linux.dev>; Wed, 10 Aug 2022 07:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=YpyN+udWX4XSgA98wlt/UJHs51etsm5ObSE9VX5h2xE=;
        b=nvI8iij7CrAF1lGtBGnzeRsjkHihG/DjsL0NU+7csusnUOa0dcmKjvJVuz+1iSMcM6
         xyfSLkls5srJ04IZk7GDQf49UMbfr9wLYjAhFx/97UQXOYWyoc6F5iCwlAYwyF8wkR+Z
         v0+H2CZqsUUgvbNu+YjlYybl/2Zdgh4AyAOoyGhSEPzOoCosPFgL+Zj85HXKd3LEzCYt
         mP60FkQ4T5SdKg5I2q3SyrIG+ZkuoZrh/iHkURmwJJKSxHqOttwF/If9ms2vyt1Dsiry
         ZHtnST1YsUJNDAYpZgv0CnxP0iEHbR4ois+TkksUlGbCUV2lASK2HfFQRyLHsE824k79
         NJ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=YpyN+udWX4XSgA98wlt/UJHs51etsm5ObSE9VX5h2xE=;
        b=0qM0cjdiSUYGFzzXDzKI7xssG5BKzbbrZV7E63ar5d9c/xk94sh6NZWz1TMA1tyOlf
         oSi4AmPZk4ybV0Fqg4sFa951Nn9NNqua9wzURvrCTVdc4GbMPqpRc5CWaPxxZhu8TJyc
         mpmafVRY99TdIdPUObewLANNpzQKF0d5Y9/5twY6LDXZXSBVv9e7OqtIFdRVV+AZ8FIv
         DHQ+6Hq899MTCHo3adt12qhZvdKQqFKGc3yntCG8oQeJm2LDKqHYh1NlKZOJJvNKqqJJ
         OCt6IR+4tFUSlGSdz3Ylb0Wu8faZ2khIFRZXQxMm1+1hzDuMD1ui8bPHVJ2vy7JH0QJd
         bX7A==
X-Gm-Message-State: ACgBeo3KdMoJwsQz+NzH2Ae97sDrruQX4somuTFtKuW/M2VdpLeZi7o9
	MUuijjxrgp6PE6BTAJqErLpy/Q==
X-Google-Smtp-Source: AA6agR4aGwTpXkPZxJ528X/blMaLEyXJcKWwSymQoP9rQthTrJdFAaLcwRafrinbGo344sOYpy1nDw==
X-Received: by 2002:a05:620a:258d:b0:6b6:6e77:7622 with SMTP id x13-20020a05620a258d00b006b66e777622mr21025437qko.95.1660141928931;
        Wed, 10 Aug 2022 07:32:08 -0700 (PDT)
Received: from kudzu.us ([2605:a601:a608:5600::59])
        by smtp.gmail.com with ESMTPSA id f6-20020a05620a280600b006b61b2cb1d2sm13795310qkp.46.2022.08.10.07.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 07:32:08 -0700 (PDT)
Date: Wed, 10 Aug 2022 10:32:06 -0400
From: Jon Mason <jdmason@kudzu.us>
To: Rob Herring <robh+dt@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Krzysztof Wilczynski <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-kernel@vger.kernel.org" <kernel@vger.kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	PCI <linux-pci@vger.kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Dong Aisheng <aisheng.dong@nxp.com>,
	Sascha Hauer <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, ntb@lists.linux.dev
Subject: Re: [PATCH v3 3/4] dt-bindings: irqchip: imx mu work as msi
 controller
Message-ID: <YvPBZgUcOyByyicx@kudzu.us>
References: <20220720213036.1738628-1-Frank.Li@nxp.com>
 <20220720213036.1738628-4-Frank.Li@nxp.com>
 <CAL_JsqJ_yAW=noPVe3LuG-ojG5ENe27to5OEzQSgGx6jHon43A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJ_yAW=noPVe3LuG-ojG5ENe27to5OEzQSgGx6jHon43A@mail.gmail.com>

On Wed, Aug 10, 2022 at 08:01:29AM -0600, Rob Herring wrote:
> On Wed, Jul 20, 2022 at 3:31 PM Frank Li <Frank.Li@nxp.com> wrote:
> >
> > imx mu support generate irq by write a register.
> > provide msi controller support so other driver
> > can use it by standard msi interface.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  .../interrupt-controller/fsl,mu-msi.yaml      | 88 +++++++++++++++++++
> >  1 file changed, 88 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml
> 
> This is failing in linux-next now, but I'm wondering why it is there
> given all the comments.

That was my fault.  It is gone now.  I was trying to get caught up
with patches, applied everything in my inbox to ntb-next, and was
pulling stuff out when it synced (cronjob backup of all git trees to
github).

Sorry,
Jon

> 
> Error: Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.example.dts:31.41-42
> syntax error
> FATAL ERROR: Unable to parse input tree
> make[1]: *** [scripts/Makefile.lib:396:
> Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.example.dtb]
> Error 1
> 
> Rob
