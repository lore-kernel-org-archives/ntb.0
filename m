Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x243.google.com (mail-lf0-x243.google.com. [2a00:1450:4010:c07::243])
        by gmr-mx.google.com with ESMTPS id j15-v6si319437ljg.5.2018.06.15.12.51.44
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 12:51:44 -0700 (PDT)
Received: by mail-lf0-x243.google.com with SMTP id j13-v6so16223795lfb.13
        for <linux-ntb@googlegroups.com>; Fri, 15 Jun 2018 12:51:44 -0700 (PDT)
Return-Path: <fancer.lancer@gmail.com>
Date: Fri, 15 Jun 2018 22:51:52 +0300
From: Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH 8/8] NTB: ntb_test: Fix bug when counting remote files
Message-ID: <20180615195152.GA25605@mobilestation>
References: <20180609000819.13883-1-logang@deltatee.com>
 <20180609000819.13883-10-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180609000819.13883-10-logang@deltatee.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Shuah Khan <shuah@kernel.org>
List-ID: <linux-ntb.googlegroups.com>

On Fri, Jun 08, 2018 at 06:08:19PM -0600, Logan Gunthorpe <logang@deltatee.com> wrote:
> When remote files are counted in get_files_count, without using SSH,
> the code returns 0 because there is a colon prepended to $LOC. $VPATH
> should have been used instead of $LOC.
> 

Good catch. Thanks for the patch. I discovered this problem myself a few days
before you sent this patchset. So was going to submit the fix, but you were
faster.

I also tested this script in the looped-back setup. It is the case when two
NTB-device ports are available at the same RootComplex. So the NTB can be
configured from the single executional context. In this case the REMOTE_HOST is left
empty, so the colon is left prepended to the corresponding paths and causes multiple
errors including the one fixed by this patch. In order to fix it, we need to discard
the colon for remote-less case, for instance, by the next patch:

@@ -482,7 +495,11 @@ function perf_test()
 function ntb_tool_tests()
 {
 	LOCAL_TOOL="$DEBUGFS/ntb_tool/$LOCAL_DEV"
-	REMOTE_TOOL="$REMOTE_HOST:$DEBUGFS/ntb_tool/$REMOTE_DEV"
+	if [[ "${REMOTE_HOST}" != "" ]]; then
+		REMOTE_TOOL="$REMOTE_HOST:$DEBUGFS/ntb_tool/$REMOTE_DEV"
+	else
+		REMOTE_TOOL="$DEBUGFS/ntb_tool/$REMOTE_DEV"
+	fi
 
 	echo "Starting ntb_tool tests..."
 
And so on for REMOTE_PP and REMOTE_PERF. It is necessary for NTB devices, which ports
are looped-back to the same Root-Port. Would you be amenable if you resent this patch
together with the fix I suggested?

Regards,
-Sergey

> Fixes: 06bd0407d06c ("NTB: ntb_test: Update ntb_tool Scratchpad tests")
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  tools/testing/selftests/ntb/ntb_test.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ntb/ntb_test.sh b/tools/testing/selftests/ntb/ntb_test.sh
> index 08cbfbbc7029..17ca36403d04 100755
> --- a/tools/testing/selftests/ntb/ntb_test.sh
> +++ b/tools/testing/selftests/ntb/ntb_test.sh
> @@ -250,7 +250,7 @@ function get_files_count()
>  	split_remote $LOC
>  
>  	if [[ "$REMOTE" == "" ]]; then
> -		echo $(ls -1 "$LOC"/${NAME}* 2>/dev/null | wc -l)
> +		echo $(ls -1 "$VPATH"/${NAME}* 2>/dev/null | wc -l)
>  	else
>  		echo $(ssh "$REMOTE" "ls -1 \"$VPATH\"/${NAME}* | \
>  		       wc -l" 2> /dev/null)
> -- 
> 2.11.0
> 
