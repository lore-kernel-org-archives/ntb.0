Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A733D89
	for <ntb@lists.linux.dev>; Fri,  8 Jul 2022 21:32:05 +0000 (UTC)
Received: by mail-il1-f173.google.com with SMTP id h16so5603150ila.2
        for <ntb@lists.linux.dev>; Fri, 08 Jul 2022 14:32:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=mPK7JqtCJf89laULVPANQB+hprBgnI5b+pSKYiY3/w8=;
        b=2mX9kAKTcQfxv3qD6Ig/meZaAu1NWXeuh2Vbk9d+G2AlVDX3JH7qDIMVCk6KuyQB7T
         y6tPe5SRzE+iYZHZ5uul6J6wDkphf0zId08VpxkX4cDeeHoxK79lXXIF559DwIUPHQYO
         Ehnubi3nGJKsStDoEIK6Nq3ScttApwNA7/oi6ERNarp1X70b7T173QCfLEvDeNCmV8ha
         SMg61bmDDXRsMS/2igsnXuP5uxRQ55w8OSxVoD7xOkNOVJ7mDPMlrEQFOARJ4ypmcG+U
         Ky36ZTE9Hz6n/vNDewJgmu9H6N7iwnSYQ009FZfw4Dikk/9QXrkt0AH38EAuPTl0qJoP
         lKQQ==
X-Gm-Message-State: AJIora/fHAWo1O05yUCpyXzQ7eKqPWdNqfKFGdmZ+RN5xzKkvH6zdvJ2
	NFvMcAqrwUZ6CDVBOJwuxw==
X-Google-Smtp-Source: AGRyM1tCjV1LWB4OVa94Ub7ppM+PyrcTgBMr3Gdo0En5H45DKfvVy4UHV6k2oZR63GxcoKo/GZSd4A==
X-Received: by 2002:a92:c811:0:b0:2dc:14bf:e15d with SMTP id v17-20020a92c811000000b002dc14bfe15dmr3121986iln.305.1657315924369;
        Fri, 08 Jul 2022 14:32:04 -0700 (PDT)
Received: from robh.at.kernel.org ([98.38.210.73])
        by smtp.gmail.com with ESMTPSA id a11-20020a02734b000000b0033ebd47834fsm1530397jae.128.2022.07.08.14.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 14:32:03 -0700 (PDT)
Received: (nullmailer pid 1508198 invoked by uid 1000);
	Fri, 08 Jul 2022 21:32:02 -0000
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: shawnguo@kernel.org, aisheng.dong@nxp.com, kw@linux.com, tglx@linutronix.de, peng.fan@nxp.com, linux-kernel@vger.kernel.org, kishon@ti.com, linux-imx@nxp.com, krzysztof.kozlowski+dt@linaro.org, s.hauer@pengutronix.de, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org, jdmason@kudzu.us, lorenzo.pieralisi@arm.com, devicetree@vger.kernel.org, festevam@gmail.com, ntb@lists.linux.dev, maz@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org
In-Reply-To: <20220707210238.917477-2-Frank.Li@nxp.com>
References: <20220707210238.917477-1-Frank.Li@nxp.com> <20220707210238.917477-2-Frank.Li@nxp.com>
Subject: Re: [PATCH 2/3] dt-bindings: irqchip: imx mu work as msi controller
Date: Fri, 08 Jul 2022 15:32:02 -0600
Message-Id: <1657315922.435976.1508197.nullmailer@robh.at.kernel.org>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>

On Thu, 07 Jul 2022 16:02:37 -0500, Frank Li wrote:
> imx mu support generate irq by write a register.
> provide msi controller support so other driver
> can use it by standard msi interface.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../interrupt-controller/fsl,mu-msi.yaml      | 94 +++++++++++++++++++
>  1 file changed, 94 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.example.dts:31.41-42 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:383: Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1404: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

