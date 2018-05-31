Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id g1-v6si2770554pfk.0.2018.05.31.11.48.35
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 May 2018 11:48:35 -0700 (PDT)
References: <8A1F3ACA2F40C04FBF91985D6F491D7C0176649B@MX302CL01.corp.emc.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <52648710-cf4a-9072-c03b-9a0f3fe7c19d@deltatee.com>
Date: Thu, 31 May 2018 12:48:32 -0600
MIME-Version: 1.0
In-Reply-To: <8A1F3ACA2F40C04FBF91985D6F491D7C0176649B@MX302CL01.corp.emc.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: ntb_tool cannot dma_alloc_coherent with CMA (over switchtec)
To: "Glimcher, Boris" <Boris.Glimcher@dell.com>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>


On 31/05/18 10:32 AM, Glimcher, Boris wrote:
> I’m trying to enlarge buffers I use in ntb_tool by using cma:

Hmm, not sure what the problem is. Is this x86?

It would also be useful to see a complete dmesg trace.

Logan
