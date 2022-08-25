Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6EA4C74
	for <ntb@lists.linux.dev>; Thu, 25 Aug 2022 21:21:33 +0000 (UTC)
Received: by mail-oi1-f176.google.com with SMTP id w196so24579131oiw.10
        for <ntb@lists.linux.dev>; Thu, 25 Aug 2022 14:21:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=P5RpiV54xqAQLIQ9ti/eGfwgmfPwohj6xoxpANXur1M=;
        b=MCoYWKmIVf4LfktPGHTP49tasgvHPg7UybwRbkU0mRh+cfV8LnRaoJK3Fg0uqyKNAn
         PvPrCbEZWhWbNm4frderCt4/XhscvwVESTb7JZdGls1QVO5Xc26tjH91mKncQGZkAuSl
         LIVea9HqoKADHWVL7UX1lzcFbUHxWemPoIHwXi2ZhivSvq+qeBBPZKZ2T6oqa2mSh9qA
         WYCAH3+WjhtJMativiuO+NH6S82JluwHKy/g08Y2E6MjhHmv6ThYLDC2TZCsBVUDTeEz
         NMPXYTekQYxzHhNt1xSjWefVLRGKPKvNpRWJxNQzWAHgHWQT8Z4nf1zNux+7DbMxdI0N
         jOXQ==
X-Gm-Message-State: ACgBeo1rzc2Yv0manb4WD1WJsPKESrFgT3DF+MhrbayIp4uHHbCrwu1E
	ulhl2A9nkQyw5liYq3JyWQ==
X-Google-Smtp-Source: AA6agR5/0JfId/JjJ0kohOyVrYVEqVArMvPe43p5PabjDPHZudT8GG3n1U2UdnD7kxSyi1MSSSrDoQ==
X-Received: by 2002:a05:6808:e85:b0:345:4fc2:4444 with SMTP id k5-20020a0568080e8500b003454fc24444mr401838oil.245.1661462492547;
        Thu, 25 Aug 2022 14:21:32 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e20-20020a056830201400b006394756c04fsm119369otp.0.2022.08.25.14.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 14:21:32 -0700 (PDT)
Received: (nullmailer pid 1709275 invoked by uid 1000);
	Thu, 25 Aug 2022 21:21:30 -0000
Date: Thu, 25 Aug 2022 16:21:30 -0500
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: maz@kernel.org, tglx@linutronix.de, krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de, kw@linux.com, bhelgaas@google.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, peng.fan@nxp.com, aisheng.dong@nxp.com, jdmason@kudzu.us, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, kishon@ti.com, lorenzo.pieralisi@arm.com, ntb@lists.linux.dev, lznuaa@gmail.com
Subject: Re: [PATCH v7 3/4] dt-bindings: irqchip: imx mu work as msi
 controller
Message-ID: <20220825212130.GA1705214-robh@kernel.org>
References: <20220822155130.2491006-1-Frank.Li@nxp.com>
 <20220822155130.2491006-4-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822155130.2491006-4-Frank.Li@nxp.com>

On Mon, Aug 22, 2022 at 10:51:29AM -0500, Frank Li wrote:
> I.MX mu support generate irq by write a register. Provide msi controller
> support so other driver such as PCI EP can use it by standard msi
> interface as doorbell.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../interrupt-controller/fsl,mu-msi.yaml      | 98 +++++++++++++++++++
>  1 file changed, 98 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml
> new file mode 100644
> index 0000000000000..ac07b138e24c0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml
> @@ -0,0 +1,98 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/fsl,mu-msi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale/NXP i.MX Messaging Unit (MU) work as msi controller
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
> +      - const: processor a-facing
> +      - const: processor b-facing

Isn't 'a' and 'b' sufficient to distinguish? Personally, doesn't really 
look like a case that benefits from -names at all.

In any case, -names shouldn't have spaces.

> +
> +  interrupts:
> +    description: a side interrupt number.
> +    maxItems: 1
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
> +      - const: processor a-facing
> +      - const: processor b-facing

Same here.

> +
> +  interrupt-controller: true
> +
> +  msi-controller: true
> +
> +  "#msi-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-controller
> +  - msi-controller

#msi-cells should be required.

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/firmware/imx/rsrc.h>
> +
> +    msi-controller@5d270000 {
> +        compatible = "fsl,imx6sx-mu-msi";
> +        msi-controller;
> +        #msi-cells = <0>;
> +        interrupt-controller;
> +        reg = <0x5d270000 0x10000>,     /* A side */
> +              <0x5d300000 0x10000>;     /* B side */
> +        reg-names = "processor a-facing", "processor b-facing";
> +        interrupts = <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>;
> +        power-domains = <&pd IMX_SC_R_MU_12A>,
> +                        <&pd IMX_SC_R_MU_12B>;
> +        power-domain-names = "processor a-facing", "processor b-facing";
> +    };
> -- 
> 2.35.1
> 
> 
