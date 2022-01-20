Return-Path: <keescook@chromium.org>
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com. [2607:f8b0:4864:20::102f])
        by gmr-mx.google.com with ESMTPS id k8si489253ybt.2.2022.01.20.15.34.04
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jan 2022 15:34:04 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id d12-20020a17090a628c00b001b4f47e2f51so8908309pjj.3
        for <linux-ntb@googlegroups.com>; Thu, 20 Jan 2022 15:34:04 -0800 (PST)
Return-Path: <keescook@chromium.org>
Date: Thu, 20 Jan 2022 15:34:02 -0800
From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH][next] NTB/msi: Use struct_size() helper in devm_kzalloc()
Message-ID: <202201201533.975AD386E@keescook>
References: <20220120230247.GA40182@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120230247.GA40182@embeddedor>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

On Thu, Jan 20, 2022 at 05:02:47PM -0600, Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded version,
> in order to avoid any potential type mistakes or integer overflows that,
> in the worst scenario, could lead to heap overflows.
> 
> Also, address the following sparse warnings:
> drivers/ntb/msi.c:46:23: warning: using sizeof on a flexible structure
> 
> Link: https://github.com/KSPP/linux/issues/174
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Heh, the variable was even named struct_size. ;)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
