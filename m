Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1506720E0
	for <ntb@lists.linux.dev>; Mon, 25 Jul 2022 20:28:15 +0000 (UTC)
Received: by mail-lf1-f53.google.com with SMTP id w15so11732813lft.11
        for <ntb@lists.linux.dev>; Mon, 25 Jul 2022 13:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=O2CYov6VR9WRgLV7z6Vc4s5eGjcXRfw3rMK6o2AVod4=;
        b=RR3XETVpwiUnj5jXaPQvAbUGMN7jphRUcKg0sN6ks3ItxY+ywhthjjY6zMH+9uvnop
         RFinhCM8/0aJU7SZ1AOaP4MOEvU5LAx/q7xtZJyki5KlfhAErO1eSkz2Sa1HdXKIVXXp
         HMYzKSLPc5EWqhST2qrRh6cVxrC30ViLwp3aos8viQ0cstFmm9V+ls+/1loscT8fsYxJ
         36cnrFD+SbdN5mteoOksk+vFYAJIi67J8gUoGepfvZN846G6RPEbmfl5l6WbHlA60HyE
         mYaCrbv06HbueVXkkB5vuDmV0flizq481lYBzNI3aIPoTBQ3UbBqCJzz8V+4h6l/QKQa
         p/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=O2CYov6VR9WRgLV7z6Vc4s5eGjcXRfw3rMK6o2AVod4=;
        b=CmE14BeVepccBdVfAZfxiOUteLmhNJi0F+udwOr/bUgZ1OX1bRKzwK328J1b51uoGa
         fZnkXgNa2WPCfQvLYzczkIg3HgxCmPNLt9h8pXcgH8S6xjMTGu3oxX2aXAJI+AepzoZV
         34dzmnWugohy5ILtY7P/ElFHTVGatRo/CpTKna6d0zc6CEjG8odL4FwBiUcoYGqDwtte
         spxEtlqWDukld81H44DhAs5LWWGe6NXPPTDKcYhzLdZ5mn+R5XB+fC5U91iVvT0idxP2
         QkXWOQ0OPzaP18BeFq/5p+YapKkI4Cw0DgpKf1sf+qQ8W9zyhTNukxRaNcNnR679+f69
         IF2w==
X-Gm-Message-State: AJIora82WLyCFDSgAgSO4ySJyHdhJCV/yh2jOpmXeOgtY1xmg1vbyjux
	jfg0p91jrRTU9tn2IDBpoH+FFQ==
X-Google-Smtp-Source: AGRyM1vkjXrbVPKhc4CGN2oLklJ4LfkjLtfOC9TYzvAxNETYrZFYaB6EWiVDnv+7KcXSWKzsP7Cd+w==
X-Received: by 2002:ac2:4a8f:0:b0:48a:9705:c81d with SMTP id l15-20020ac24a8f000000b0048a9705c81dmr1262795lfp.63.1658780893176;
        Mon, 25 Jul 2022 13:28:13 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id 27-20020ac25f5b000000b004896ed8dce3sm1448860lfz.2.2022.07.25.13.28.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jul 2022 13:28:12 -0700 (PDT)
Message-ID: <979a618d-a107-af3d-c101-de6eb9e89464@linaro.org>
Date: Mon, 25 Jul 2022 22:28:11 +0200
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [EXT] Re: [PATCH v3 3/4] dt-bindings: irqchip: imx mu work as msi
 controller
Content-Language: en-US
To: Frank Li <frank.li@nxp.com>, "jdmason@kudzu.us" <jdmason@kudzu.us>,
 "maz@kernel.org" <maz@kernel.org>, "tglx@linutronix.de"
 <tglx@linutronix.de>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "kw@linux.com" <kw@linux.com>, "bhelgaas@google.com" <bhelgaas@google.com>
Cc: "kernel@vger.kernel.org" <kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Peng Fan <peng.fan@nxp.com>, Aisheng Dong <aisheng.dong@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "festevam@gmail.com" <festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>,
 "kishon@ti.com" <kishon@ti.com>,
 "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
 "ntb@lists.linux.dev" <ntb@lists.linux.dev>
References: <20220720213036.1738628-1-Frank.Li@nxp.com>
 <20220720213036.1738628-4-Frank.Li@nxp.com>
 <2c11d0b0-b012-ea24-5c3c-305bbdd231a0@linaro.org>
 <PAXPR04MB9186010F8F364CFB760064DF88959@PAXPR04MB9186.eurprd04.prod.outlook.com>
 <7994d7c7-ae13-a136-f60c-40fd9918565d@linaro.org>
 <PAXPR04MB91860D406AF430B16032EA5488959@PAXPR04MB9186.eurprd04.prod.outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <PAXPR04MB91860D406AF430B16032EA5488959@PAXPR04MB9186.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/07/2022 18:55, Frank Li wrote:

>>>> Not minItems but maxItems in general, but anyway you need to actually
>>>> list and describe the items (and then skip min/max)
>>> [Frank Li]
>>>       I am not sure format.  Any example?
>>>
>>> Reg:
>>>       Items:
>>>            - description:  a side register
>>>            - description: b side register
>>
>> Yes, but then explain what is A and B in bindings description.
> 
> [Frank Li]  How about "A(B) side base register address."
> Any other description need?  

In top-level description you have:
  "The MU also provides the ability for one processor to signal the
other processor using interrupts."

so maybe:
  "The MU also provides the ability for one processor (A side) to signal
the other processor (B side) using interrupts."

> 
>>
>> Why MU, which sits on A side needs to access other side (B) registers?
> 
> [Frank Li] MU work as MSI controller for PCI EP.  So driver need provide
> B side register to PCI EP by msi_msg.   PCI EP driver use this address to set
> PCI bar<n>.  Then PCI host can write this address to trigger PCIe EP side irq
> As doorbell. 
> 
> MU MSI driver also need A side register
> To get irq status.  So MU MSI need both side registers. 

OK.


Best regards,
Krzysztof
