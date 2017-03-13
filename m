Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net. [184.105.139.130])
        by gmr-mx.google.com with ESMTP id a3si3327306pfb.2.2017.03.13.15.26.15
        for <linux-ntb@googlegroups.com>;
        Mon, 13 Mar 2017 15:26:15 -0700 (PDT)
Date: Mon, 13 Mar 2017 15:26:14 -0700 (PDT)
Message-Id: <20170313.152614.1626587191925692450.davem@davemloft.net>
Subject: Re: [PATCH] net: net_netdev: use new api
 ethtool_{get|set}_link_ksettings
From: David Miller <davem@davemloft.net>
In-Reply-To: <1489097413-4202-1-git-send-email-tremyfr@gmail.com>
References: <1489097413-4202-1-git-send-email-tremyfr@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: tremyfr@gmail.com
Cc: jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, linux-ntb@googlegroups.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

From: Philippe Reynes <tremyfr@gmail.com>
Date: Thu,  9 Mar 2017 23:10:13 +0100

> The ethtool api {get|set}_settings is deprecated.
> We move this driver to new api {get|set}_link_ksettings.
> 
> As I don't have the hardware, I'd be very pleased if
> someone may test this patch.
> 
> Signed-off-by: Philippe Reynes <tremyfr@gmail.com>

Applied.
