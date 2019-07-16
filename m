Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id b74si765998yba.4.2019.07.16.10.41.13
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Jul 2019 10:41:13 -0700 (PDT)
References: <20190716173448.eswemneatvjwnxny@yadro.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <9428e069-19dd-d020-1a47-f33d99bd01ac@deltatee.com>
Date: Tue, 16 Jul 2019 11:41:09 -0600
MIME-Version: 1.0
In-Reply-To: <20190716173448.eswemneatvjwnxny@yadro.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ntb_hw_switchtec: make ntb_mw_set_trans() work when addr
 == 0
To: Alexander Fomichev <fomichev.ru@gmail.com>, linux-ntb@googlegroups.com, linux-pci@vger.kernel.org
Cc: Allen Hubbe <allenbh@gmail.com>, linux@yadro.com
List-ID: <linux-ntb.googlegroups.com>



On 2019-07-16 11:34 a.m., Alexander Fomichev wrote:
> On switchtec_ntb_mw_set_trans() call, when (only) address == 0, it acts as
> ntb_mw_clear_trans(). Fix this, since address == 0 and size != 0 is valid
> combination for setting translation.
> 
> Signed-off-by: Alexander Fomichev <fomichev.ru@gmail.com>

Looks good, thanks.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

> ---
>  drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> index db49677..45b9513 100644
> --- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> +++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> @@ -305,7 +305,7 @@ static int switchtec_ntb_mw_set_trans(struct ntb_dev *ntb, int pidx, int widx,
>  	if (rc)
>  		return rc;
>  
> -	if (addr == 0 || size == 0) {
> +	if (size == 0) {
>  		if (widx < nr_direct_mw)
>  			switchtec_ntb_mw_clr_direct(sndev, widx);
>  		else
> 
