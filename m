Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id x65si7224715vkg.2.2019.01.24.08.50.28
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 08:50:28 -0800 (PST)
References: <8e9bb3cc-b238-47e7-b206-ccaf673a8fb6@googlegroups.com>
 <56554767-0ed2-cda0-716b-c4050717a45a@deltatee.com>
 <608d408b-3150-455a-f7b7-df7838650a94@intel.com>
 <CAPWoNkL=2h-vBVBHG1J0pB_W2KpO0FHTqj3h07UhHXidjADSPQ@mail.gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <2585315c-2c2b-c402-4dd3-03bf7e6c66dd@deltatee.com>
Date: Thu, 24 Jan 2019 09:50:25 -0700
MIME-Version: 1.0
In-Reply-To: <CAPWoNkL=2h-vBVBHG1J0pB_W2KpO0FHTqj3h07UhHXidjADSPQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Missing functionality of ntb_peer_db_addr() API
To: Leon Ravich <lravich@gmail.com>, Dave Jiang <dave.jiang@intel.com>
Cc: linux-ntb <linux-ntb@googlegroups.com>, "Hubbe, Allen" <allenbh@gmail.com>
List-ID: <linux-ntb.googlegroups.com>



On 2019-01-24 6:51 a.m., Leon Ravich wrote:

>  static int switchtec_ntb_peer_db_addr(struct ntb_dev *ntb,
>                                       phys_addr_t *db_addr,
> -                                     resource_size_t *db_size)
> +                                     resource_size_t *db_size,
> +                                     u64 *db_data,
> +                                     int db_bit)
>  {
>         struct switchtec_ntb *sndev = ntb_sndev(ntb);
>         unsigned long offset;
>  
> +       if (unlikely(db_bit >= BITS_PER_LONG_LONG))
> +                       return -EINVAL;
> +
>         offset = (unsigned long)sndev->mmio_peer_dbmsg->odb -
>                 (unsigned long)sndev->stdev->mmio;
>  
> @@ -721,6 +726,8 @@ static int switchtec_ntb_peer_db_addr(struct ntb_dev
> *ntb,
>                 *db_addr = pci_resource_start(ntb->pdev, 0) + offset;
>         if (db_size)
>                 *db_size = sizeof(u32);
> +       if (db_data)
> +               *db_data = BIT_ULL(db_bit) << sndev->db_peer_shift;
>  
>         return 0;
>  }


This makes sense to me. For the switchtec parts:

Acked-by: Logan Gunthorpe <logang@deltatee.com>

Thanks!

Logan
