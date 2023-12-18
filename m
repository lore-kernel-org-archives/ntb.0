Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD3749893;
	Mon, 18 Dec 2023 22:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6d7395ab92cso1002845b3a.2;
        Mon, 18 Dec 2023 14:43:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702939388; x=1703544188;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+WdvhxypQSzlZWGhf+IU0LgPAf/h827UUi/xTvTvNns=;
        b=hhqf+slGp0EZ1Z8nKkk4wPeCCDdCukChX24Mi7eJABrpReeKFzFf10NA3h4mIdSnFe
         2Dbg3DW9D/pV2aNHf+LBFkvo7Y5MK69Deas0ZA1bNdMy/W82PSulYq+q+7lwiqk0yKxD
         1HzRTkJYFrASmSeDatVqBhpD8EA6Ka9LZMyQwjXxwIdf79LhW9ognOJGYjkmBeDPEkms
         hZCBnZE4prlKcQ7yd2RD6Est1TOBvzo5T0KxXcfsLgtsOktlWQ1Vem+OsMWpgsUAW+Rx
         h6+9WxC+GIUmoXjL9Q3LTJnevwo6k3FEr5SIbrN3z6+9jmzpRhh2oA+nnrd3PRTYJSMn
         I+sw==
X-Gm-Message-State: AOJu0Yzg8epHvXCrJL+W9g8af6uiTg3SdCWeTraEJwWHvbQKBqjRLTXF
	r2XKI+jnWhKo273v4qc7MR0=
X-Google-Smtp-Source: AGHT+IHVpqC9SjFJK9PqtuBhR1gEkvAClhjy741NZa9o1NOfIAJTOcLzbrlN286BuduIo67vg2/3UA==
X-Received: by 2002:a05:6a20:4287:b0:186:e53:b64b with SMTP id o7-20020a056a20428700b001860e53b64bmr10072399pzj.47.1702939388434;
        Mon, 18 Dec 2023 14:43:08 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id k9-20020a170902c40900b001d0cd9e4248sm19540300plk.196.2023.12.18.14.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 14:43:07 -0800 (PST)
Date: Tue, 19 Dec 2023 07:43:05 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
	linux-pci@vger.kernel.org, mhi@lists.linux.dev, ntb@lists.linux.dev
Subject: Re: [PATCH 1/5] PCI: endpoint: Make pci_epf_ops in pci_epf_driver
 const
Message-ID: <20231218224305.GA2983820@rocinante>
References: <20230722230848.589428-1-lars@metafoo.de>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230722230848.589428-1-lars@metafoo.de>

Hello,

> The pci_epf_ops struct contains a set of callbacks that are used by the
> pci_epf_driver. The ops struct is never modified by the epf core itself.
> 
> Marking the ops pointer const allows epf drivers to declare their
> pci_epf_ops struct to be const. This allows the struct to be placed in the
> read-only section. Which for example brings some security benefits as the
> callbacks can not be overwritten.

Applied to endpoint, thank you!

[01/05] PCI: endpoint: Make struct pci_epf_ops in pci_epf_driver const
        https://git.kernel.org/pci/pci/c/86362293044b
[02/05] PCI: endpoint: pci-epf-mhi: Make structs pci_epf_ops and pci_epf_event_ops const
        https://git.kernel.org/pci/pci/c/150d04ddf386
[03/05] PCI: endpoint: pci-epf-ntb: Make struct pci_epf_ops const
        https://git.kernel.org/pci/pci/c/54f22c9758dc
[04/05] PCI: endpoint: pci-epf-vntb: Make struct pci_epf_ops const
        https://git.kernel.org/pci/pci/c/c21b53deda09
[05/05] PCI: endpoint: pci-epf-test: Make struct pci_epf_ops const
        https://git.kernel.org/pci/pci/c/6f517e044096

	Krzysztof
