Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id t67si12676846pfd.3.2016.12.27.16.17.10
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Dec 2016 16:17:10 -0800 (PST)
References: <6a532e4dff499983cd96bc9a4653686a88d9cb08.1482883799.git.Allen.Hubbe@dell.com>
 <c32601e4d7e389a5170386b4235266d6386a463d.1482883799.git.Allen.Hubbe@dell.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <ccae681c-e5f6-2018-af1b-517170717773@deltatee.com>
Date: Tue, 27 Dec 2016 17:17:07 -0700
MIME-Version: 1.0
In-Reply-To: <c32601e4d7e389a5170386b4235266d6386a463d.1482883799.git.Allen.Hubbe@dell.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/2] NTB: ntb_test: add parameter for doorbell bitmask
To: Allen Hubbe <Allen.Hubbe@dell.com>, linux-ntb@googlegroups.com
Cc: Jon Mason <jdmason@kudzu.us>
List-ID: <linux-ntb.googlegroups.com>

Ditto.

Acked-by: Logan Gunthorpe <logang@deltatee.com>

On 27/12/16 05:12 PM, Allen Hubbe wrote:
> If the test attempts to clear doorbell bits that are invalid for the
> hardware, then the test will fail.  Provide a parameter to specify the
> doorbell bits to clear.  Set default doorbell bits that work for XEON.
> 
> Signed-off-by: Allen Hubbe <Allen.Hubbe@dell.com>
> ---
>  tools/testing/selftests/ntb/ntb_test.sh | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/ntb/ntb_test.sh b/tools/testing/selftests/ntb/ntb_test.sh
> index 4e70e19255bc..d25b91b2ee2e 100755
> --- a/tools/testing/selftests/ntb/ntb_test.sh
> +++ b/tools/testing/selftests/ntb/ntb_test.sh
> @@ -18,6 +18,7 @@ LIST_DEVS=FALSE
>  
>  DEBUGFS=${DEBUGFS-/sys/kernel/debug}
>  
> +DB_BITMASK=0x7FFF
>  PERF_RUN_ORDER=32
>  MAX_MW_SIZE=0
>  RUN_DMA_TESTS=
> @@ -38,6 +39,7 @@ function show_help()
>  	echo "be highly recommended."
>  	echo
>  	echo "Options:"
> +	echo "  -b BITMASK      doorbell clear bitmask for ntb_tool"
>  	echo "  -C              don't cleanup ntb modules on exit"
>  	echo "  -d              run dma tests"
>  	echo "  -h              show this help message"
> @@ -52,8 +54,9 @@ function show_help()
>  function parse_args()
>  {
>  	OPTIND=0
> -	while getopts "Cdhlm:r:p:w:" opt; do
> +	while getopts "b:Cdhlm:r:p:w:" opt; do
>  		case "$opt" in
> +		b)  DB_BITMASK=${OPTARG} ;;
>  		C)  DONT_CLEANUP=1 ;;
>  		d)  RUN_DMA_TESTS=1 ;;
>  		h)  show_help; exit 0 ;;
> @@ -158,7 +161,7 @@ function doorbell_test()
>  
>  	echo "Running db tests on: $(basename $LOC) / $(basename $REM)"
>  
> -	write_file "c 0xFFFFFFFF" "$REM/db"
> +	write_file "c $DB_BITMASK" "$REM/db"
>  
>  	for ((i=1; i <= 8; i++)); do
>  		let DB=$(read_file "$REM/db") || true
> 
