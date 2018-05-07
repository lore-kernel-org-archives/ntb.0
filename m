Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id u10-v6si1455418ywh.4.2018.05.06.22.29.24
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 06 May 2018 22:29:24 -0700 (PDT)
References: <1525634420-19370-1-git-send-email-araut@codeaurora.org>
 <1525634420-19370-2-git-send-email-araut@codeaurora.org>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <65020028-564a-c679-e31f-2aa7d4390666@deltatee.com>
Date: Sun, 6 May 2018 23:29:20 -0600
MIME-Version: 1.0
In-Reply-To: <1525634420-19370-2-git-send-email-araut@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/4] NTB : Introduce message library
To: Atul Raut <araut@codeaurora.org>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Hey Atul,

Thanks for this work. I had a couple thoughts:

On 06/05/18 01:20 PM, Atul Raut wrote:
> +enum nt_cmd {
> +	NT_CMD_INVAL = -1,/* invalid spad command */
> +	NT_CMD_SSIZE = 0, /* send out buffer size */
> +	NT_CMD_RSIZE = 1, /* recv in  buffer size */
> +	NT_CMD_SXLAT = 2, /* send in  buffer xlat */
> +	NT_CMD_RXLAT = 3, /* recv out buffer xlat */
> +	NT_CMD_CLEAR = 4, /* clear allocated memory */
> +	NT_STS_DONE  = 5, /* init is done */
> +	NT_STS_LNKUP = 6, /* link up state flag */
> +	NT_QP_LINKS        = 7, /* available QP link */
> +	NT_CMD_NUM_MWS        = 8, /* number of memory windows */
> +	NT_CMD_NUM_QPS        = 9, /* number of QP */
> +	NT_CMD_NTB_VERSION    = 10, /* ntb version */
> +};
>

Should we really encode the type of data sent in the library? I feel
like a good API should be agnostic to what's being sent and allow for
generic data so future users can do different things and this library
doesn't has to list all types of values for all future clients.

> +/**
> + * Messages-base commands interface
> + */
> +#define NT_MSG_CMD		0
> +#define NT_MSG_CMD_WID	        1
> +#define NT_MSG_LDATA		2
> +#define NT_MSG_HDATA		3
> +#define NT_MSG_CNT		4

The current Switchtec hardware has 4 messages but the driver reserves
one for link management. So I'd rather not increase the number of
messages required from 3 to 4. Do we really need a cmd_wid message? Can
this not be encoded in the cmd message?

Logan
