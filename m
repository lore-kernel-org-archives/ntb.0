Return-Path: <Allen.Hubbe@dell.com>
Received: from esa1.dell-outbound.iphmx.com (esa1.dell-outbound.iphmx.com. [68.232.153.90])
        by gmr-mx.google.com with ESMTPS id o206si45320ywb.12.2017.06.05.10.58.28
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Jun 2017 10:58:28 -0700 (PDT)
From: "Allen Hubbe" <Allen.Hubbe@dell.com>
References: <20170605161324.11696-1-logang@deltatee.com>
In-Reply-To: <20170605161324.11696-1-logang@deltatee.com>
Subject: RE: [PATCH] NTB: ntb_test: fix bug printing ntb_perf results
Date: Mon, 5 Jun 2017 13:58:11 -0400
Message-ID: <000001d2de25$4c858260$e5908720$@dell.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
To: 'Logan Gunthorpe' <logang@deltatee.com>, linux-ntb@googlegroups.com
Cc: 'Jon Mason' <jdmason@kudzu.us>
List-ID: <linux-ntb.googlegroups.com>

From: Logan Gunthorpe
> The code mistakenly prints the local perf results for the remote test
> so the script reports identical results for both directions. Fix this
> by ensuring we print the remote result.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Cc: Jon Mason <jdmason@kudzu.us>
> Cc: Allen Hubbe <Allen.Hubbe@dell.com>

Acked-by: Allen Hubbe <Allen.Hubbe@dell.com>

> ---
> 
>  Oops, this was my own bug.
> 
>  tools/testing/selftests/ntb/ntb_test.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ntb/ntb_test.sh
> b/tools/testing/selftests/ntb/ntb_test.sh
> index a676d3eefefb..13f5198ba0ee 100755
> --- a/tools/testing/selftests/ntb/ntb_test.sh
> +++ b/tools/testing/selftests/ntb/ntb_test.sh
> @@ -305,7 +305,7 @@ function perf_test()
>  	echo "Running remote perf test $WITH DMA"
>  	write_file "" $REMOTE_PERF/run
>  	echo -n "  "
> -	read_file $LOCAL_PERF/run
> +	read_file $REMOTE_PERF/run
>  	echo "  Passed"
> 
>  	_modprobe -r ntb_perf
> --
> 2.11.0

