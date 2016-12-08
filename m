Return-Path: <Allen.Hubbe@dell.com>
Received: from esa3.dell-outbound.iphmx.com (esa3.dell-outbound.iphmx.com. [68.232.153.94])
        by gmr-mx.google.com with ESMTPS id i9si2617903ywc.0.2016.12.08.09.17.16
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Dec 2016 09:17:17 -0800 (PST)
From: "Allen Hubbe" <Allen.Hubbe@dell.com>
References: <2a1282ae9ad64a34b4795541a2c290b5@mspexmb1.Beer.Town> <b40a94020de44fb6974bfcc978d1ce52@mspexmb1.Beer.Town>
In-Reply-To: <b40a94020de44fb6974bfcc978d1ce52@mspexmb1.Beer.Town>
Subject: RE: [PATCH] NTB: correct ntb_peer_spad_read for case when callback is not supplied.
Date: Thu, 8 Dec 2016 12:16:57 -0500
Message-ID: <002101d25176$e14ac450$a3e04cf0$@dell.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
To: "Wahl, Steve" <Steve.Wahl@dell.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

From: Steven Wahl
>
> Signed-off-by: Steve Wahl <Steve.Wahl@dell.com>

The only thing lacking here is a commit comment, but the change is self-explanatory.  Thanks!

Acked-by: Allen Hubbe <Allen.Hubbe@dell.com>

> ---
>  include/linux/ntb.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/linux/ntb.h b/include/linux/ntb.h
> index 6f47562..816bd98 100644
> --- a/include/linux/ntb.h
> +++ b/include/linux/ntb.h
> @@ -968,6 +968,9 @@ static inline int ntb_peer_spad_addr(struct ntb_dev *ntb, int idx,
>   */
>  static inline u32 ntb_peer_spad_read(struct ntb_dev *ntb, int idx)
>  {
> +       if (!ntb->ops->peer_spad_read)
> +               return 0;
> +
>         return ntb->ops->peer_spad_read(ntb, idx);
>  }
> 
> --
> 2.7.4

