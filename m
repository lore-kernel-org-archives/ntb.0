Return-Path: <robh+dt@kernel.org>
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.99])
        by gmr-mx.google.com with ESMTPS id t132si82656pfc.6.2020.05.22.09.11.21
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 May 2020 09:11:21 -0700 (PDT)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 55A8E207F9
	for <linux-ntb@googlegroups.com>; Fri, 22 May 2020 16:11:21 +0000 (UTC)
Received: by mail-ot1-f51.google.com with SMTP id h7so8633973otr.3
        for <linux-ntb@googlegroups.com>; Fri, 22 May 2020 09:11:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200514145927.17555-1-kishon@ti.com>
In-Reply-To: <20200514145927.17555-1-kishon@ti.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Fri, 22 May 2020 10:11:09 -0600
Message-ID: <CAL_JsqKxe5FtZfiQKcQFFLOM5F52kx-q8vZspPTXhcWg+3rJvQ@mail.gmail.com>
Subject: Re: [PATCH 00/19] Implement NTB Controller using multiple PCI EP
Content-Type: text/plain; charset="UTF-8"
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Tom Joseph <tjoseph@cadence.com>, Bjorn Helgaas <bhelgaas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, PCI <linux-pci@vger.kernel.org>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Thu, May 14, 2020 at 8:59 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> This series is about implementing SW defined NTB using
> multiple endpoint instances. This series has been tested using
> 2 endpoint instances in J7 connected to two DRA7 boards. However there
> is nothing platform specific for the NTB functionality.
>
> This was presented in Linux Plumbers Conference. The presentation
> can be found @ [1]

I'd like to know why putting this into DT is better than configfs.
Does it solve some problem? Doing things in userspace is so much
easier and more flexible than modifying and updating a DT.

I don't really think the PCI endpoint stuff is mature enough to be
putting into DT either.

Rob
