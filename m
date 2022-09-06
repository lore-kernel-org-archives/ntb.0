Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D055886F2;
	Tue,  6 Sep 2022 21:41:07 +0000 (UTC)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-11ee4649dfcso31572232fac.1;
        Tue, 06 Sep 2022 14:41:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=EW+cR7KJ28XYEq6YcUljunwqIl+1KGyFFiNfE5ICVAA=;
        b=XdWCf+nbG/B7N0covPgbe0Ht4/ZD1QInodJS8CKDvMGBf/mIJEFCKpD0NmxXc7fIZE
         US/k/Qz+xBA+NewkHH60k/a70pvAQNEFydsyPGbnGmQGoljjuhlWZhs3fNI72c3wfTXF
         xdvHEP5M+f+pCfZBtbb+KH6rKvtMqL+ej0seAifwr6uLXR08B8kbXkDXZ+7Hy/iY6JBj
         ZObgMhJg/TUXFlaVfrnyWqHJanmyd3xbRK379fa+exS1bPCsu+XnZ+MYgDmqgeGAFJZU
         VR/RRAk170n2T9GjZ49Ukjj51ThLgjijtAwYz1oXCemfoqc8ujH0qevoAom+8raObBH0
         FxCw==
X-Gm-Message-State: ACgBeo2TF1EBydu9ossD8HjeLWz/7KlEFwoRubP5Gl8g2sD1J3a6ZhJp
	8Csx5DQ0D+f0LyJJgEInwA==
X-Google-Smtp-Source: AA6agR6f9fGCXs1O4gA9YicEAr3WSKrESrdckaoq8Rl9HDETjjj10oBq0P1Nl9KEbeC0SbXW6hLrmg==
X-Received: by 2002:a05:6808:158a:b0:343:7564:91f1 with SMTP id t10-20020a056808158a00b00343756491f1mr10822132oiw.23.1662500466925;
        Tue, 06 Sep 2022 14:41:06 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id be36-20020a05687058a400b000f5e89a9c60sm7648953oab.3.2022.09.06.14.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 14:41:05 -0700 (PDT)
Received: (nullmailer pid 1224959 invoked by uid 1000);
	Tue, 06 Sep 2022 21:41:00 -0000
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de, devicetree@vger.kernel.org, tglx@linutronix.de, festevam@gmail.com, ntb@lists.linux.dev, shawnguo@kernel.org, krzysztof.kozlowski+dt@linaro.org, maz@kernel.org, kishon@ti.com, peng.fan@nxp.com, imx@lists.linux.dev, lorenzo.pieralisi@arm.com, kw@linux.com, lznuaa@gmail.com, jdmason@kudzu.us, linux-imx@nxp.com, linux-pci@vger.kernel.org, s.hauer@pengutronix.de, bhelgaas@google.com, aisheng.dong@nxp.com
In-Reply-To: <20220906194052.3079599-4-Frank.Li@nxp.com>
References: <20220906194052.3079599-1-Frank.Li@nxp.com> <20220906194052.3079599-4-Frank.Li@nxp.com>
Subject: Re: [PATCH v8 3/4] dt-bindings: irqchip: imx mu work as msi controller
Date: Tue, 06 Sep 2022 16:41:00 -0500
Message-Id: <1662500460.117998.1224958.nullmailer@robh.at.kernel.org>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>

On Tue, 06 Sep 2022 14:40:51 -0500, Frank Li wrote:
> I.MX mu support generate irq by write a register. Provide msi controller
> support so other driver such as PCI EP can use it by standard msi
> interface as doorbell.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../interrupt-controller/fsl,mu-msi.yaml      | 99 +++++++++++++++++++
>  1 file changed, 99 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.example.dtb: msi-controller@5d270000: reg-names:0: 'processor-a-side' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.example.dtb: msi-controller@5d270000: reg-names:1: 'processor-b-side' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.example.dtb: msi-controller@5d270000: power-domain-names:0: 'processor-a-side' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.example.dtb: msi-controller@5d270000: power-domain-names:1: 'processor-b-side' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

