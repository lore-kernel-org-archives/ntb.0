Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id o7si4832256qte.3.2019.01.23.09.30.26
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 09:30:26 -0800 (PST)
References: <8e9bb3cc-b238-47e7-b206-ccaf673a8fb6@googlegroups.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <56554767-0ed2-cda0-716b-c4050717a45a@deltatee.com>
Date: Wed, 23 Jan 2019 10:30:23 -0700
MIME-Version: 1.0
In-Reply-To: <8e9bb3cc-b238-47e7-b206-ccaf673a8fb6@googlegroups.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] Missing functionality of ntb_peer_db_addr() API
To: lravich@gmail.com, linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>



On 2019-01-23 2:28 a.m., lravich@gmail.com wrote:
>         .spad_count             = intel_ntb_spad_count,
> diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c 
> b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> index 5ee5f40..af01222 100644
> --- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> +++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> @@ -707,7 +707,9 @@ static u64 switchtec_ntb_db_read_mask(struct ntb_dev 
> *ntb)
>  
>  static int switchtec_ntb_peer_db_addr(struct ntb_dev *ntb,
>                                       phys_addr_t *db_addr,
> -                                     resource_size_t *db_size)
> +                                     resource_size_t *db_size,
> +                                     u64 *db_data,
> +                                     int db_bit)
>  {


The semantics of this interface are not clear because there are no users
in the kernel. But doesn't a correct implementation require you to set
db_data here?

Logan
