Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A456622;
	Fri,  9 Sep 2022 01:43:49 +0000 (UTC)
Received: by mail-ot1-f43.google.com with SMTP id h9-20020a9d5549000000b0063727299bb4so210904oti.9;
        Thu, 08 Sep 2022 18:43:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=kgAGirvJfdV3oB1r2QFilMXE0qgu9JtE1NsMjf6XFLY=;
        b=OP8X26apmUDOOf1orSteUWORoM+yTIuCB5vRd/484q0vaNqOWDkIUwkk210fu0IeSO
         XQ5upJCfCchuQ9YRmREQgERZGxV/sY57aKeIdP3E9UXX09SKjsyqUGuXO4sa7/WvKQP+
         IHpdcv1WqBlhmeChx0k6uDJwQuKy1Fzk5CR3ccMfwxRwdz+roFYvHDuptsHF8V4fNf+/
         izkuGUiC+IYYfJjeXiSiamHh/7nRxOOD1QBcGCN62XfnsDSDLFBTmgvi/Ax1YtG/cPV5
         VrezUKq23lPXOzdBo7xI2RUjGvYbonPh2atoHIBJOV444GF8Khk7dvU2V9zafdzmBIod
         bSOA==
X-Gm-Message-State: ACgBeo1ziCfqPkyouvvAbAiT/34GQi3VOVhpac4m32SwhYP4Tg64DQT0
	3X5wTd6SZ26v7KVxUIDd0Q==
X-Google-Smtp-Source: AA6agR5i2t4iZ8enK9UJxaM3KxuW+PQOhJgW4tqlPDGLyRN8vJfn+FxaRNRJx75tuZ0LmnK4pAh3Gw==
X-Received: by 2002:a05:6830:1bfa:b0:637:1491:2ac7 with SMTP id k26-20020a0568301bfa00b0063714912ac7mr4569354otb.9.1662687828152;
        Thu, 08 Sep 2022 18:43:48 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e7-20020a056870c34700b0012696ac05d5sm483842oak.19.2022.09.08.18.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 18:43:47 -0700 (PDT)
Received: (nullmailer pid 3745755 invoked by uid 1000);
	Fri, 09 Sep 2022 01:43:46 -0000
Date: Thu, 8 Sep 2022 20:43:46 -0500
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: lorenzo.pieralisi@arm.com, linux-pci@vger.kernel.org, maz@kernel.org, ntb@lists.linux.dev, robh+dt@kernel.org, kishon@ti.com, imx@lists.linux.dev, bhelgaas@google.com, festevam@gmail.com, peng.fan@nxp.com, jdmason@kudzu.us, manivannan.sadhasivam@linaro.org, kw@linux.com, aisheng.dong@nxp.com, kernel@pengutronix.de, shawnguo@kernel.org, linux-imx@nxp.com, krzysztof.kozlowski+dt@linaro.org, s.hauer@pengutronix.de, devicetree@vger.kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lznuaa@gmail.com
Subject: Re: [PATCH v9 3/4] dt-bindings: irqchip: imx mu work as msi
 controller
Message-ID: <20220909014346.GA3745691-robh@kernel.org>
References: <20220907034856.3101570-1-Frank.Li@nxp.com>
 <20220907034856.3101570-4-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907034856.3101570-4-Frank.Li@nxp.com>

On Tue, 06 Sep 2022 22:48:55 -0500, Frank Li wrote:
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

Reviewed-by: Rob Herring <robh@kernel.org>
