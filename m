Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F4AEA2
	for <ntb@lists.linux.dev>; Sun, 14 Aug 2022 20:41:43 +0000 (UTC)
Received: by mail-oi1-f174.google.com with SMTP id u9so6851993oiv.12
        for <ntb@lists.linux.dev>; Sun, 14 Aug 2022 13:41:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=9Mv3SYsV787hG2zwBPi7bzT81bYQL5Y4bZ2g9jjPhSI=;
        b=jfuXwfdNfPR1xYv8TiNysfZWdly+wF3nUDIDmcfbQWIkQqMVrkGfjI7NhVQNeaglNl
         dbClwocz86Nhf7OtpAJU4FJMuSEOdgpCSuqQPfCGUM71922Ow6xH+PgS+Q7Wn7jHW9ou
         YccCNebGv9Pv1DLebb7wKzB+CMOc9X+8bRAjhAEOlqgdN3DHQNs6+sjVeRuXYJoRrNWZ
         FDQL+cOhA5SQK2e/rV2o067ssuAksN0Xps67kH0Bo9dzeplLBMu05HjGvUBCp52gLx1c
         /YVwXzifc9q7+0rL8Q7OzAFvoDJMVz++fbt2L3iQRN5j6wW2k48Mtdupt3pi2wYgFj42
         onXg==
X-Gm-Message-State: ACgBeo38GdxIBbue/iYDBR2k6yyVOag2Hu9Oi3RZAzcWQ9iRtp7M6E+d
	07UZpnWyW9YD9uaklRURnw==
X-Google-Smtp-Source: AA6agR4uHGL9LB7gP7Q+Ajfe9FgPloWZ0Sz4kuzRLczXQqy+Qp+hbqAqrIq7K9g49rj7+MI+CQqFBQ==
X-Received: by 2002:a05:6808:10ce:b0:342:a33c:fcc with SMTP id s14-20020a05680810ce00b00342a33c0fccmr5836922ois.250.1660509702872;
        Sun, 14 Aug 2022 13:41:42 -0700 (PDT)
Received: from robh.at.kernel.org ([172.58.176.57])
        by smtp.gmail.com with ESMTPSA id r14-20020a05687032ce00b0011b98fa9ab5sm396327oac.50.2022.08.14.13.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 13:41:42 -0700 (PDT)
Received: (nullmailer pid 672588 invoked by uid 1000);
	Sun, 14 Aug 2022 20:41:38 -0000
Date: Sun, 14 Aug 2022 14:41:38 -0600
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: maz@kernel.org, tglx@linutronix.de, krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de, kw@linux.com, bhelgaas@google.com, kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, peng.fan@nxp.com, aisheng.dong@nxp.com, jdmason@kudzu.us, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, kishon@ti.com, lorenzo.pieralisi@arm.com, ntb@lists.linux.dev, lznuaa@gmail.com
Subject: Re: [PATCH v4 3/4] dt-bindings: irqchip: imx mu work as msi
 controller
Message-ID: <20220814204138.GA664328-robh@kernel.org>
References: <20220812215242.2255824-1-Frank.Li@nxp.com>
 <20220812215242.2255824-4-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220812215242.2255824-4-Frank.Li@nxp.com>

On Fri, Aug 12, 2022 at 04:52:41PM -0500, Frank Li wrote:
> I.MX mu support generate irq by write a register. Provide msi controller
> support so other driver such as PCI EP can use it by standard msi
> interface as doorbell.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../interrupt-controller/fsl,mu-msi.yaml      | 93 +++++++++++++++++++
>  1 file changed, 93 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml
> new file mode 100644
> index 0000000000000..f60fa8b686879
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml
> @@ -0,0 +1,93 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/fsl,mu-msi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP i.MX Messaging Unit (MU) work as msi controller
> +
> +maintainers:
> +  - Frank Li <Frank.Li@nxp.com>
> +
> +description: |
> +  The Messaging Unit module enables two processors within the SoC to
> +  communicate and coordinate by passing messages (e.g. data, status
> +  and control) through the MU interface. The MU also provides the ability
> +  for one processor (A side) to signal the other processor (B side) using
> +  interrupts.
> +
> +  Because the MU manages the messaging between processors, the MU uses
> +  different clocks (from each side of the different peripheral buses).
> +  Therefore, the MU must synchronize the accesses from one side to the
> +  other. The MU accomplishes synchronization using two sets of matching
> +  registers (Processor A-facing, Processor B-facing).
> +
> +  MU can work as msi interrupt controller to do doorbell
> +
> +allOf:
> +  - $ref: /schemas/interrupt-controller/msi-controller.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - fsl,imx6sx-mu-msi
> +      - fsl,imx7ulp-mu-msi
> +      - fsl,imx8ulp-mu-msi
> +      - fsl,imx8ulp-mu-msi-s4
> +
> +  reg:
> +    items:
> +      - description: a side register base address
> +      - description: b side register base address
> +
> +  reg-names:
> +    items:
> +      - const: a
> +      - const: b
> +
> +  interrupts:
> +    description: a side interrupt number.

How many?

> +
> +  clocks:
> +    maxItems: 1
> +
> +  power-domains:
> +    items:
> +      - description: a side power domain
> +      - description: b side power domain
> +
> +  power-domain-names:
> +    items:
> +      - const: a
> +      - const: b
> +
> +  interrupt-controller: true
> +
> +  msi-controller: true

#msi-cells?

(Missing is treated as 0, but new bindings should be explicit)

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-controller
> +  - msi-controller
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/firmware/imx/rsrc.h>
> +
> +    lsio_mu12: msi-controller@5d270000 {

Drop unused labels.

> +        compatible = "fsl,imx6sx-mu-msi";
> +        msi-controller;
> +        interrupt-controller;
> +        reg = <0x5d270000 0x10000>,     /* A side */
> +              <0x5d300000 0x10000>;     /* B side */
> +        reg-names = "a", "b";
> +        interrupts = <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>;
> +        power-domains = <&pd IMX_SC_R_MU_12A>,
> +                        <&pd IMX_SC_R_MU_12B>;
> +        power-domain-names = "a", "b";
> +    };
> -- 
> 2.35.1
> 
> 
