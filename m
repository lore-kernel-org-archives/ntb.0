Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id e18si214783qtc.5.2017.11.30.14.06.18
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Nov 2017 14:06:18 -0800 (PST)
References: <20171130214107.21194-1-fancer.lancer@gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <05386287-e0c2-5dd3-4e9b-6f64c61f8405@deltatee.com>
Date: Thu, 30 Nov 2017 15:06:15 -0700
MIME-Version: 1.0
In-Reply-To: <20171130214107.21194-1-fancer.lancer@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] NTB: ntb_hw_idt: Set NTB_TOPO_SWITCH topology
To: Serge Semin <fancer.lancer@gmail.com>, jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, Shyam-sundar.S-k@amd.com, Xiangliang.Yu@amd.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>



On 30/11/17 02:41 PM, Serge Semin wrote:
> Since Switchtec patch there has been a new topology added to
> the NTB API. It's called NTB_TOPO_SWITCH and dedicated for
> PCIe switch chips. Even though topo field isn't used within the
> IDT driver much, lets set it for the sake of unification.
> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> Acked-by: Serge Semin <fancer.lancer@gmail.com>

You don't need to Ack your own patches ;)

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
