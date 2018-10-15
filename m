Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id v207-v6si543142oia.3.2018.10.15.13.42.44
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 13:42:45 -0700 (PDT)
References: <1539375618-6782-1-git-send-email-asierra@xes-inc.com>
 <1539635567-13523-1-git-send-email-asierra@xes-inc.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <fd250881-5331-1426-8e1f-b2492966107a@deltatee.com>
Date: Mon, 15 Oct 2018 14:42:38 -0600
MIME-Version: 1.0
In-Reply-To: <1539635567-13523-1-git-send-email-asierra@xes-inc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ntb_netdev: Simplify remove with client device drvdata
To: Aaron Sierra <asierra@xes-inc.com>, linux-ntb@googlegroups.com
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, "David S. Miller" <davem@davemloft.net>
List-ID: <linux-ntb.googlegroups.com>



On 2018-10-15 2:32 p.m., Aaron Sierra wrote:
> Replace the elaborate private structure global linked-list used in
> ntb_netdev_probe() and ntb_netdev_remove() by stashing our private
> data in the NTB transport client device.
> 
> Signed-off-by: Aaron Sierra <asierra@xes-inc.com>

Looks good to me. Thanks.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
