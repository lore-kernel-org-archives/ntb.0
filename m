Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id r8si12378948pfa.5.2016.12.27.16.16.24
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Dec 2016 16:16:24 -0800 (PST)
References: <6a532e4dff499983cd96bc9a4653686a88d9cb08.1482883799.git.Allen.Hubbe@dell.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <33d317ca-249c-300f-ce7f-a2953bfe138b@deltatee.com>
Date: Tue, 27 Dec 2016 17:16:22 -0700
MIME-Version: 1.0
In-Reply-To: <6a532e4dff499983cd96bc9a4653686a88d9cb08.1482883799.git.Allen.Hubbe@dell.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] NTB: ntb_test: modprobe on remote host
To: Allen Hubbe <Allen.Hubbe@dell.com>, linux-ntb@googlegroups.com
Cc: Jon Mason <jdmason@kudzu.us>
List-ID: <linux-ntb.googlegroups.com>

Looks good to me.

Acked-by: Logan Gunthorpe <logang@deltatee.com>

On 27/12/16 05:12 PM, Allen Hubbe wrote:
> Signed-off-by: Allen Hubbe <Allen.Hubbe@dell.com>
> ---
>  tools/testing/selftests/ntb/ntb_test.sh | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/ntb/ntb_test.sh b/tools/testing/selftests/ntb/ntb_test.sh
> index a676d3eefefb..4e70e19255bc 100755
> --- a/tools/testing/selftests/ntb/ntb_test.sh
> +++ b/tools/testing/selftests/ntb/ntb_test.sh
> @@ -85,6 +85,10 @@ set -e
>  function _modprobe()
>  {
>          modprobe "$@"
> +
> +	if [[ "$REMOTE_HOST" != "" ]]; then
> +		ssh "$REMOTE_HOST" modprobe "$@"
> +	fi
>  }
>  
>  function split_remote()
> 
