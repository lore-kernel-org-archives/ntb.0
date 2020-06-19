Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id q1si230524pjj.0.2020.06.19.12.11.02
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 12:11:02 -0700 (PDT)
References: <20200619172514.GA1074@embeddedor>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <268330b2-e42b-4d62-1ff0-8462d68e498e@deltatee.com>
Date: Fri, 19 Jun 2020 13:10:55 -0600
MIME-Version: 1.0
In-Reply-To: <20200619172514.GA1074@embeddedor>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH][next] NTB: Use struct_size() helper in devm_kzalloc()
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-ID: <linux-ntb.googlegroups.com>



On 2020-06-19 11:25 a.m., Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded version
> in order to avoid any potential type mistakes. Also, remove unnecessary
> variable _struct_size_.
> 
> This code was detected with the help of Coccinelle and, audited and
> fixed manually.
> 
> Addresses-KSPP-ID: https://github.com/KSPP/linux/issues/83
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Cool, I didn't know that existed! Thanks!

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

> ---
>  drivers/ntb/test/ntb_msi_test.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/ntb/test/ntb_msi_test.c b/drivers/ntb/test/ntb_msi_test.c
> index 99d826ed9c34..7095ecd6223a 100644
> --- a/drivers/ntb/test/ntb_msi_test.c
> +++ b/drivers/ntb/test/ntb_msi_test.c
> @@ -319,7 +319,6 @@ static void ntb_msit_remove_dbgfs(struct ntb_msit_ctx *nm)
>  static int ntb_msit_probe(struct ntb_client *client, struct ntb_dev *ntb)
>  {
>  	struct ntb_msit_ctx *nm;
> -	size_t struct_size;
>  	int peers;
>  	int ret;
>  
> @@ -352,9 +351,7 @@ static int ntb_msit_probe(struct ntb_client *client, struct ntb_dev *ntb)
>  		return ret;
>  	}
>  
> -	struct_size = sizeof(*nm) + sizeof(*nm->peers) * peers;
> -
> -	nm = devm_kzalloc(&ntb->dev, struct_size, GFP_KERNEL);
> +	nm = devm_kzalloc(&ntb->dev, struct_size(nm, peers, peers), GFP_KERNEL);
>  	if (!nm)
>  		return -ENOMEM;
>  
> 
