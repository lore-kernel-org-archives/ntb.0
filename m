Return-Path: <jdmason@kudzu.us>
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com. [2607:f8b0:4864:20::841])
        by gmr-mx.google.com with ESMTPS id u126si1084414ybg.0.2020.05.31.12.55.41
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 May 2020 12:55:41 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id z1so6216604qtn.2
        for <linux-ntb@googlegroups.com>; Sun, 31 May 2020 12:55:41 -0700 (PDT)
Return-Path: <jdmason@kudzu.us>
Date: Sun, 31 May 2020 15:55:39 -0400
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH] NTB: correct ntb_peer_spad_addr and ntb_peer_spad_read
 comment typos
Message-ID: <20200531195539.GD4620@kudzu.us>
References: <20200526075943.20756-1-wesley.sheng@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526075943.20756-1-wesley.sheng@amd.com>
To: Wesley Sheng <wesley.sheng@amd.com>
Cc: dave.jiang@intel.com, allenbh@gmail.com, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, wesleyshenggit@sina.com
List-ID: <linux-ntb.googlegroups.com>

On Tue, May 26, 2020 at 03:59:43PM +0800, Wesley Sheng wrote:
> The comment for ntb_peer_spad_addr and ntb_peer_spad_read
> incorrectly referred to peer doorbell register and local
> scratchpad register.
> 
> Signed-off-by: Wesley Sheng <wesley.sheng@amd.com>

Pulled into the ntb branch

Thanks,
Jon

> ---
>  include/linux/ntb.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/ntb.h b/include/linux/ntb.h
> index 8c13538aeffe..b9b0d805d0f9 100644
> --- a/include/linux/ntb.h
> +++ b/include/linux/ntb.h
> @@ -1351,7 +1351,7 @@ static inline int ntb_spad_write(struct ntb_dev *ntb, int sidx, u32 val)
>   * @sidx:	Scratchpad index.
>   * @spad_addr:	OUT - The address of the peer scratchpad register.
>   *
> - * Return the address of the peer doorbell register.  This may be used, for
> + * Return the address of the peer scratchpad register.  This may be used, for
>   * example, by drivers that offload memory copy operations to a dma engine.
>   *
>   * Return: Zero on success, otherwise an error number.
> @@ -1373,7 +1373,7 @@ static inline int ntb_peer_spad_addr(struct ntb_dev *ntb, int pidx, int sidx,
>   *
>   * Read the peer scratchpad register, and return the value.
>   *
> - * Return: The value of the local scratchpad register.
> + * Return: The value of the peer scratchpad register.
>   */
>  static inline u32 ntb_peer_spad_read(struct ntb_dev *ntb, int pidx, int sidx)
>  {
> -- 
> 2.16.2
> 
