Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E207E
	for <ntb@lists.linux.dev>; Sat, 23 Jul 2022 18:50:08 +0000 (UTC)
Received: by mail-lf1-f46.google.com with SMTP id t17so104240lfk.0
        for <ntb@lists.linux.dev>; Sat, 23 Jul 2022 11:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=B+vvDtYGi1XDKiuGjmDw/lVU+xC9oujhBoztFUY2G+U=;
        b=SlWw/tImFQZIeS1Hg1TtKzgSZQ49TJZ9bTLtA3YySZ2LrccpK+g5tHfRNOnwpTOwzZ
         ly8aO31AcU0X43fVYjnTzcZ5U9PXvri7Setm6Uehj2NeCVG6Wjzq1eOrcpFVPGBB2kJl
         3EPxeCd7hCS9tcwd4b4eBwXXOQMN9lCdGOE9pIgR9I1NDzezeoxImAWWsfYDwZk5QTZv
         2jlE8byeiWrusQDzQr8VBArJn7GJAUHKjVGsEFg/7NZ+M0DNaan0sHO5hpD2kBViTQaT
         pfYaxsrpL3CqUEkhCtiyKvxCfpF3IiopehUCN704LF2wp6sMtmunyKlPJljjP4r2K765
         GX/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=B+vvDtYGi1XDKiuGjmDw/lVU+xC9oujhBoztFUY2G+U=;
        b=JkEAmHKFso7Hlc/qSrfypMJmm3fcdPG7pJkBJoHPZ0DISVHuwULJZyIThclgQR/kmO
         ZgbFkuSbl1BpRspUHDu+eZRUhCR8Mi47q0nYJ0swAOqbOfAEzorgt25ahp2A/2J7ajqK
         4sOE/PxrT8DTAp2zJBD1n/vC2nOqAbDWSBa/BOM5gFUsAED2gg+fPScY/v95L3E5PDTv
         RGniHqQWD6y5LN2H0Dtd5+oY7uTxiCYz6ZTZ+3KFYwI//Ua6Bb6Mx6mH83tvLwJjGpor
         5oKCW/u2sZIdtI1TGPyOFqkAFI2BBzI+7/avcLYM8U+kOeyxskaDF+fVQtSjLkpOo/mY
         QZWA==
X-Gm-Message-State: AJIora9Z5Rm4UH9zibOKe5rT/YJ7wuGMIxpTOMNxn59AF3oR9Of5DVF2
	QLfHV61NdPo24TdgyaWpr1fFvg==
X-Google-Smtp-Source: AGRyM1tJ3m1Ldo3gY1ozOqzQBPwlbigKbf8YB3WWehnFWJAkReNx2LOf/rTS6Rxfn1qC7HMI24wTxw==
X-Received: by 2002:a05:6512:10d0:b0:48a:6cee:50d0 with SMTP id k16-20020a05651210d000b0048a6cee50d0mr2039323lfg.222.1658602206736;
        Sat, 23 Jul 2022 11:50:06 -0700 (PDT)
Received: from [192.168.10.173] (93.81-167-86.customer.lyse.net. [81.167.86.93])
        by smtp.gmail.com with ESMTPSA id h11-20020a0565123c8b00b0048a7d33e0f0sm447803lfv.261.2022.07.23.11.50.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Jul 2022 11:50:06 -0700 (PDT)
Message-ID: <2c11d0b0-b012-ea24-5c3c-305bbdd231a0@linaro.org>
Date: Sat, 23 Jul 2022 20:50:03 +0200
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 3/4] dt-bindings: irqchip: imx mu work as msi
 controller
Content-Language: en-US
To: Frank Li <Frank.Li@nxp.com>, jdmason@kudzu.us, maz@kernel.org,
 tglx@linutronix.de, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 shawnguo@kernel.org, s.hauer@pengutronix.de, kw@linux.com,
 bhelgaas@google.com
Cc: kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 peng.fan@nxp.com, aisheng.dong@nxp.com, kernel@pengutronix.de,
 festevam@gmail.com, linux-imx@nxp.com, kishon@ti.com,
 lorenzo.pieralisi@arm.com, ntb@lists.linux.dev
References: <20220720213036.1738628-1-Frank.Li@nxp.com>
 <20220720213036.1738628-4-Frank.Li@nxp.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220720213036.1738628-4-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/07/2022 23:30, Frank Li wrote:
> imx mu support generate irq by write a register.
> provide msi controller support so other driver
> can use it by standard msi interface.

Please start sentences with capital letter. Unfortunately I don't
understand the sentences. Please describe shortly the hardware.


> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../interrupt-controller/fsl,mu-msi.yaml      | 88 +++++++++++++++++++
>  1 file changed, 88 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml
> new file mode 100644
> index 0000000000000..e125294243af3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.yaml
> @@ -0,0 +1,88 @@
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
> +  for one processor to signal the other processor using interrupts.
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
> +    minItems: 2

Not minItems but maxItems in general, but anyway you need to actually
list and describe the items (and then skip min/max)

> +
> +  reg-names:
> +    items:
> +      - const: a
> +      - const: b
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 2

and here you correctly use maxItems, so why min in reg? Anyway, instead
you need to list and describe the items.

Actually I asked you this last time about interrupts, so you ignored
that comment.

> +
> +  power-domain-names:
> +    items:
> +      - const: a
> +      - const: b
> +
> +  interrupt-controller: true
> +
> +  msi-controller: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - msi-controller
> +  - interrupt-controller

Why different order than used in properties?



Best regards,
Krzysztof
