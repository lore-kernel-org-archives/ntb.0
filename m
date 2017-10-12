Return-Path: <lsgunthorpe@gmail.com>
Received: from mail-io0-x230.google.com (mail-io0-x230.google.com. [2607:f8b0:4001:c06::230])
        by gmr-mx.google.com with ESMTPS id m186si1697075pfm.2.2017.10.12.11.38.38
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Oct 2017 11:38:38 -0700 (PDT)
Received: by mail-io0-x230.google.com with SMTP id f20so6476004ioj.9
        for <linux-ntb@googlegroups.com>; Thu, 12 Oct 2017 11:38:38 -0700 (PDT)
Return-Path: <lsgunthorpe@gmail.com>
Subject: Re: Is the Scratchpad Implementation Using a LUT Standard?
References: <9aa73260-8b02-4e86-b7d4-9bc3afd745a6@googlegroups.com>
 <000001d341d2$87574f20$9605ed60$@dell.com>
 <6107eb07-3889-4f1a-ad50-264256772dae@googlegroups.com>
 <38ffd174-b66f-4077-8cdc-679e412242fc@googlegroups.com>
 <20171011174114.GA25306@mobilestation>
 <ef57a986-936e-ba87-663e-b8866a6b9fcd@gmail.com>
 <CA+GK6ekKuvkzLod=LJ4+MqVH0MTKwyQTcvOpUEzfBAjkGeYyBg@mail.gmail.com>
From: Logan Gunthorpe <lsgunthorpe@gmail.com>
Message-ID: <bcccee97-cb4c-7d8a-c55d-c17d09972c1e@gmail.com>
Date: Thu, 12 Oct 2017 12:38:35 -0600
MIME-Version: 1.0
In-Reply-To: <CA+GK6ekKuvkzLod=LJ4+MqVH0MTKwyQTcvOpUEzfBAjkGeYyBg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
To: D Meyer <dmeyer@gigaio.com>
Cc: Serge Semin <fancer.lancer@gmail.com>, linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

On 12/10/17 12:31 PM, D Meyer wrote:
> Imagine accessing PiB of storage that uses memory semantics (early
> last year PCI-SIG noted a vendor selling an endpoint capable of 2 TB),
> a sea of GPGPU cards, etc. in a heterogeneous cloud computing
> environment, and wanting to control access to windows of that stuff
> being used by multiple applications running in one or more hosts. A
> small number of windows are not sufficient. LUTs provide a good method
> for being able to establish long-lasting as well as ephemeral
> translations and, in conjunction with IOMMU, PCIe's ACS, etc. as well
> as various QoS features could provide a good start on data protection
> and client performance.
>
> This much bigger than ntb_transport  to support networks with some
> NVMe drives and GPU endpoints. Fun!
>
> LUTs aren't an afterthought. I think they're really valuable.
See my comment in my previous email. Until there's some published code
(preferably upstream) that uses them it's not worth assuming what those
uses might be and giving yourself arbitrary restrictions that may never 
come
to pass. The market may never even want what you are imagining.

Logan


