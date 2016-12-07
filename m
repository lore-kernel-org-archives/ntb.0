Return-Path: <Allen.Hubbe@dell.com>
Received: from esa6.dell-outbound.iphmx.com (esa6.dell-outbound.iphmx.com. [68.232.149.229])
        by gmr-mx.google.com with ESMTPS id x138si1024640ywx.6.2016.12.07.07.04.48
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Dec 2016 07:04:48 -0800 (PST)
From: "Allen Hubbe" <Allen.Hubbe@dell.com>
References: <1503156503.754106.1481072956836.JavaMail.zimbra@xes-inc.com>
In-Reply-To: <1503156503.754106.1481072956836.JavaMail.zimbra@xes-inc.com>
Subject: RE: correct ntb_spad_count comment typo
Date: Wed, 7 Dec 2016 10:04:15 -0500
Message-ID: <000001d2509b$2d829050$8887b0f0$@dell.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
To: 'Aaron Sierra' <asierra@xes-inc.com>, 'Jon Mason' <jdmason@kudzu.us>, 'Dave Jiang' <dave.jiang@intel.com>
Cc: linux-ntb@googlegroups.com, 'Jiri Kosina' <trivial@kernel.org>
List-ID: <linux-ntb.googlegroups.com>

From: Aaron Sierra
> The comment for ntb_spad_count incorrectly referred to ntb_mw_count.
> 
> Signed-off-by: Aaron Sierra <asierra@xes-inc.com>

Acked-by: Allen Hubbe <Allen.Hubbe@dell.com>

> ---
>  include/linux/ntb.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/ntb.h b/include/linux/ntb.h
> index 6f47562..50a7dbe 100644
> --- a/include/linux/ntb.h
> +++ b/include/linux/ntb.h
> @@ -892,15 +892,15 @@ static inline int ntb_spad_is_unsafe(struct ntb_dev *ntb)
>  	if (!ntb->ops->spad_is_unsafe)
>  		return 0;
> 
>  	return ntb->ops->spad_is_unsafe(ntb);
>  }
> 
>  /**
> - * ntb_mw_count() - get the number of scratchpads
> + * ntb_spad_count() - get the number of scratchpads
>   * @ntb:	NTB device context.
>   *
>   * Hardware and topology may support a different number of scratchpads.
>   *
>   * Return: the number of scratchpads.
>   */
>  static inline int ntb_spad_count(struct ntb_dev *ntb)
> --
> 1.9.1


