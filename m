Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8386E538C
	for <ntb@lists.linux.dev>; Fri, 15 Jul 2022 23:06:32 +0000 (UTC)
Received: by mail-io1-f53.google.com with SMTP id y2so4974675ior.12
        for <ntb@lists.linux.dev>; Fri, 15 Jul 2022 16:06:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=WS+m6FCV1ih7kQYyoEE+Xpgv4hF6eBI9SGC0nwJm3wI=;
        b=zXTv1cSppvTaDO9MwJWD+XPFsGEjbYLfHdhLnXmqvTRPkvgcLKqBoL4PkEb3ibmVME
         /M7maQP9cnnl0SP6yT0w7Cde94inep4M8YdQDDkXNRsf/0zTRprmNI1dBTbzaS7wdsqp
         ew7TxPi5Kh78wz1e2TeuIVPRqSkEfiqNm9Cq8M75mINTqA3BlicVxde7n/XwycK3lMgk
         uPEiPsacUJWpeyvmYjOTvPMubTwEPYOsRtY5qgWR2BIJL/ypCR+3GRvvAXXcfIPZqV6A
         rh8G9tPDTL5rZG1eR3mvuuJF2dHJ7blQ3VBe8/Q0BBF+UPOoMyExXiOFStG/u/0CyXhX
         NYaw==
X-Gm-Message-State: AJIora/MHn/TNtq+ecYIuOEWDMyTgOnVlutmOQgW5eypp5JmY199uS7v
	lJh+5AMAMiADeiJqtJvxkw==
X-Google-Smtp-Source: AGRyM1vJzwIneWYq4VBZo4Q8Al9UejZ/c08fHYNczA4GDDXLOiIf81FvnXssYQRPzsCwTbZnDVFD6w==
X-Received: by 2002:a05:6602:1346:b0:669:35d4:1a81 with SMTP id i6-20020a056602134600b0066935d41a81mr8128000iov.112.1657926391461;
        Fri, 15 Jul 2022 16:06:31 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id b13-20020a92ce0d000000b002dc6fd9a84bsm2149256ilo.79.2022.07.15.16.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 16:06:31 -0700 (PDT)
Received: (nullmailer pid 1631476 invoked by uid 1000);
	Fri, 15 Jul 2022 23:06:28 -0000
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: bhelgaas@google.com, robh+dt@kernel.org, lorenzo.pieralisi@arm.com, peng.fan@nxp.com, ntb@lists.linux.dev, kernel@vger.kernel.org, s.hauer@pengutronix.de, aisheng.dong@nxp.com, kw@linux.com, linux-arm-kernel@lists.infradead.org, kishon@ti.com, maz@kernel.org, festevam@gmail.com, shawnguo@kernel.org, tglx@linutronix.de, krzysztof.kozlowski+dt@linaro.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, jdmason@kudzu.us, linux-imx@nxp.com, kernel@pengutronix.de
In-Reply-To: <20220715192219.1489403-4-Frank.Li@nxp.com>
References: <20220715192219.1489403-1-Frank.Li@nxp.com> <20220715192219.1489403-4-Frank.Li@nxp.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: irqchip: imx mu work as msi controller
Date: Fri, 15 Jul 2022 17:06:28 -0600
Message-Id: <1657926388.230921.1631475.nullmailer@robh.at.kernel.org>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>

On Fri, 15 Jul 2022 14:22:18 -0500, Frank Li wrote:
> imx mu support generate irq by write a register.
> provide msi controller support so other driver
> can use it by standard msi interface.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../interrupt-controller/fsl,mu-msi.yaml      | 88 +++++++++++++++++++
>  1 file changed, 88 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.example.dtb: interrupt-controller@5d270000: '#interrupt-cells' is a dependency of 'interrupt-controller'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.example.dtb: interrupt-controller@5d270000: '#interrupt-cells' is a dependency of 'interrupt-controller'
	From schema: /usr/local/lib/python3.10/dist-packages/dtschema/schemas/interrupt-controller.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

