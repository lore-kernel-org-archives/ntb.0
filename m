Return-Path: <jdmason@kudzu.us>
Received: from mail-ua0-x241.google.com (mail-ua0-x241.google.com. [2607:f8b0:400c:c08::241])
        by gmr-mx.google.com with ESMTPS id 105si40070uas.1.2017.12.05.10.24.10
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Dec 2017 10:24:10 -0800 (PST)
Received: by mail-ua0-x241.google.com with SMTP id t24so922138uaa.13
        for <linux-ntb@googlegroups.com>; Tue, 05 Dec 2017 10:24:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171203191736.3399-8-fancer.lancer@gmail.com>
References: <20171203191736.3399-1-fancer.lancer@gmail.com> <20171203191736.3399-8-fancer.lancer@gmail.com>
From: Jon Mason <jdmason@kudzu.us>
Date: Tue, 5 Dec 2017 13:24:09 -0500
Message-ID: <CAPoiz9zZtDxynORreZkfBNCJFfk80NfnrMHrXOXkQFk0PXes_Q@mail.gmail.com>
Subject: Re: [PATCH v2 07/15] NTB: ntb_test: Safely use paths with whitespace
Content-Type: text/plain; charset="UTF-8"
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Dave Jiang <dave.jiang@intel.com>, "Hubbe, Allen" <Allen.Hubbe@emc.com>, "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>, "Yu, Xiangliang" <Xiangliang.Yu@amd.com>, Gary R Hook <gary.hook@amd.com>, Sergey.Semin@t-platforms.ru, linux-ntb <linux-ntb@googlegroups.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-ntb.googlegroups.com>

On Sun, Dec 3, 2017 at 2:17 PM, Serge Semin <fancer.lancer@gmail.com> wrote:
> If some of the variables like LOC/REM or LOCAL_*/REMOTE_* got
> whitespaces, the script may fail with syntax error.
>
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> Acked-by: Logan Gunthorpe <logang@deltatee.com>
> Fixes: a9c59ef77458 ("ntb_test: Add a selftest script for the NTB subsystem")

Looks fine to me

> ---
>  tools/testing/selftests/ntb/ntb_test.sh | 62 ++++++++++++++++-----------------
>  1 file changed, 31 insertions(+), 31 deletions(-)
>
> diff --git a/tools/testing/selftests/ntb/ntb_test.sh b/tools/testing/selftests/ntb/ntb_test.sh
> index 5fc7ad359e21..a8647ad891eb 100755
> --- a/tools/testing/selftests/ntb/ntb_test.sh
> +++ b/tools/testing/selftests/ntb/ntb_test.sh
> @@ -87,7 +87,7 @@ set -e
>
>  function _modprobe()
>  {
> -        modprobe "$@"
> +       modprobe "$@"
>
>         if [[ "$REMOTE_HOST" != "" ]]; then
>                 ssh "$REMOTE_HOST" modprobe "$@"
> @@ -274,13 +274,13 @@ function pingpong_test()
>
>         echo "Running ping pong tests on: $(basename $LOC) / $(basename $REM)"
>
> -       LOC_START=$(read_file $LOC/count)
> -       REM_START=$(read_file $REM/count)
> +       LOC_START=$(read_file "$LOC/count")
> +       REM_START=$(read_file "$REM/count")
>
>         sleep 7
>
> -       LOC_END=$(read_file $LOC/count)
> -       REM_END=$(read_file $REM/count)
> +       LOC_END=$(read_file "$LOC/count")
> +       REM_END=$(read_file "$REM/count")
>
>         if [[ $LOC_START == $LOC_END ]] || [[ $REM_START == $REM_END ]]; then
>                 echo "Ping pong counter not incrementing!" >&2
> @@ -304,15 +304,15 @@ function perf_test()
>                 max_mw_size=$MAX_MW_SIZE use_dma=$USE_DMA
>
>         echo "Running local perf test $WITH DMA"
> -       write_file "" $LOCAL_PERF/run
> +       write_file "" "$LOCAL_PERF/run"
>         echo -n "  "
> -       read_file $LOCAL_PERF/run
> +       read_file "$LOCAL_PERF/run"
>         echo "  Passed"
>
>         echo "Running remote perf test $WITH DMA"
> -       write_file "" $REMOTE_PERF/run
> +       write_file "" "$REMOTE_PERF/run"
>         echo -n "  "
> -       read_file $REMOTE_PERF/run
> +       read_file "$REMOTE_PERF/run"
>         echo "  Passed"
>
>         _modprobe -r ntb_perf
> @@ -320,39 +320,39 @@ function perf_test()
>
>  function ntb_tool_tests()
>  {
> -       LOCAL_TOOL=$DEBUGFS/ntb_tool/$LOCAL_DEV
> -       REMOTE_TOOL=$REMOTE_HOST:$DEBUGFS/ntb_tool/$REMOTE_DEV
> +       LOCAL_TOOL="$DEBUGFS/ntb_tool/$LOCAL_DEV"
> +       REMOTE_TOOL="$REMOTE_HOST:$DEBUGFS/ntb_tool/$REMOTE_DEV"
>
>         echo "Starting ntb_tool tests..."
>
>         _modprobe ntb_tool
>
> -       write_file Y $LOCAL_TOOL/link_event
> -       write_file Y $REMOTE_TOOL/link_event
> +       write_file "Y" "$LOCAL_TOOL/link_event"
> +       write_file "Y" "$REMOTE_TOOL/link_event"
>
> -       link_test $LOCAL_TOOL $REMOTE_TOOL
> -       link_test $REMOTE_TOOL $LOCAL_TOOL
> +       link_test "$LOCAL_TOOL" "$REMOTE_TOOL"
> +       link_test "$REMOTE_TOOL" "$LOCAL_TOOL"
>
>         #Ensure the link is up on both sides before continuing
> -       write_file Y $LOCAL_TOOL/link_event
> -       write_file Y $REMOTE_TOOL/link_event
> +       write_file "Y" "$LOCAL_TOOL/link_event"
> +       write_file "Y" "$REMOTE_TOOL/link_event"
>
> -       for PEER_TRANS in $(ls $LOCAL_TOOL/peer_trans*); do
> +       for PEER_TRANS in $(ls "$LOCAL_TOOL"/peer_trans*); do
>                 PT=$(basename $PEER_TRANS)
> -               write_file $MW_SIZE $LOCAL_TOOL/$PT
> -               write_file $MW_SIZE $REMOTE_TOOL/$PT
> +               write_file $MW_SIZE "$LOCAL_TOOL/$PT"
> +               write_file $MW_SIZE "$REMOTE_TOOL/$PT"
>         done
>
> -       doorbell_test $LOCAL_TOOL $REMOTE_TOOL
> -       doorbell_test $REMOTE_TOOL $LOCAL_TOOL
> -       scratchpad_test $LOCAL_TOOL $REMOTE_TOOL
> -       scratchpad_test $REMOTE_TOOL $LOCAL_TOOL
> +       doorbell_test "$LOCAL_TOOL" "$REMOTE_TOOL"
> +       doorbell_test "$REMOTE_TOOL" "$LOCAL_TOOL"
> +       scratchpad_test "$LOCAL_TOOL" "$REMOTE_TOOL"
> +       scratchpad_test "$REMOTE_TOOL" "$LOCAL_TOOL"
>
> -       for MW in $(ls $LOCAL_TOOL/mw*); do
> +       for MW in $(ls "$LOCAL_TOOL"/mw*); do
>                 MW=$(basename $MW)
>
> -               mw_test $MW $LOCAL_TOOL $REMOTE_TOOL
> -               mw_test $MW $REMOTE_TOOL $LOCAL_TOOL
> +               mw_test $MW "$LOCAL_TOOL" "$REMOTE_TOOL"
> +               mw_test $MW "$REMOTE_TOOL" "$LOCAL_TOOL"
>         done
>
>         _modprobe -r ntb_tool
> @@ -360,8 +360,8 @@ function ntb_tool_tests()
>
>  function ntb_pingpong_tests()
>  {
> -       LOCAL_PP=$DEBUGFS/ntb_pingpong/$LOCAL_DEV
> -       REMOTE_PP=$REMOTE_HOST:$DEBUGFS/ntb_pingpong/$REMOTE_DEV
> +       LOCAL_PP="$DEBUGFS/ntb_pingpong/$LOCAL_DEV"
> +       REMOTE_PP="$REMOTE_HOST:$DEBUGFS/ntb_pingpong/$REMOTE_DEV"
>
>         echo "Starting ntb_pingpong tests..."
>
> @@ -374,8 +374,8 @@ function ntb_pingpong_tests()
>
>  function ntb_perf_tests()
>  {
> -       LOCAL_PERF=$DEBUGFS/ntb_perf/$LOCAL_DEV
> -       REMOTE_PERF=$REMOTE_HOST:$DEBUGFS/ntb_perf/$REMOTE_DEV
> +       LOCAL_PERF="$DEBUGFS/ntb_perf/$LOCAL_DEV"
> +       REMOTE_PERF="$REMOTE_HOST:$DEBUGFS/ntb_perf/$REMOTE_DEV"
>
>         echo "Starting ntb_perf tests..."
>
> --
> 2.12.0
>
