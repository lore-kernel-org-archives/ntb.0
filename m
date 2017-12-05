Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x243.google.com (mail-lf0-x243.google.com. [2a00:1450:4010:c07::243])
        by gmr-mx.google.com with ESMTPS id k6si560198wme.4.2017.12.05.12.42.15
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Dec 2017 12:42:15 -0800 (PST)
Received: by mail-lf0-x243.google.com with SMTP id j124so1830801lfg.2
        for <linux-ntb@googlegroups.com>; Tue, 05 Dec 2017 12:42:15 -0800 (PST)
Return-Path: <fancer.lancer@gmail.com>
Date: Tue, 5 Dec 2017 23:42:21 +0300
From: Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH v2 10/15] NTB: ntb_test: Update ntb_tool DB tests
Message-ID: <20171205204221.GI1701@mobilestation>
References: <20171203191736.3399-1-fancer.lancer@gmail.com>
 <20171203191736.3399-11-fancer.lancer@gmail.com>
 <CAPoiz9y9XE-sqK1n9PhD5R=wRQgEMZEeovh8yRN-_MAAyC08Tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPoiz9y9XE-sqK1n9PhD5R=wRQgEMZEeovh8yRN-_MAAyC08Tg@mail.gmail.com>
To: Jon Mason <jdmason@kudzu.us>
Cc: Dave Jiang <dave.jiang@intel.com>, "Hubbe, Allen" <Allen.Hubbe@emc.com>, "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>, "Yu, Xiangliang" <Xiangliang.Yu@amd.com>, Gary R Hook <gary.hook@amd.com>, Sergey.Semin@t-platforms.ru, linux-ntb <linux-ntb@googlegroups.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-ntb.googlegroups.com>

On Tue, Dec 05, 2017 at 01:27:57PM -0500, Jon Mason <jdmason@kudzu.us> wrote:
> On Sun, Dec 3, 2017 at 2:17 PM, Serge Semin <fancer.lancer@gmail.com> wrote:
> > DB interface of ntb_tool driver hasn't been changed much, but
> > db_valid_mask DebugFS file has still been added to new ntb_tool
> > driver. In this case it's much better to test all valid DB bits
> > instead of using the predefined mask, which may be incorrect in
> > general.
> >
> > Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> > ---
> >  tools/testing/selftests/ntb/ntb_test.sh | 29 ++++++++++++++++++-----------
> >  1 file changed, 18 insertions(+), 11 deletions(-)
> >
> > diff --git a/tools/testing/selftests/ntb/ntb_test.sh b/tools/testing/selftests/ntb/ntb_test.sh
> > index 247458c6d8dc..3d43885ea4b5 100755
> > --- a/tools/testing/selftests/ntb/ntb_test.sh
> > +++ b/tools/testing/selftests/ntb/ntb_test.sh
> > @@ -18,7 +18,6 @@ LIST_DEVS=FALSE
> >
> >  DEBUGFS=${DEBUGFS-/sys/kernel/debug}
> >
> > -DB_BITMASK=0x7FFF
> >  PERF_RUN_ORDER=32
> >  MAX_MW_SIZE=0
> >  RUN_DMA_TESTS=
> > @@ -39,7 +38,6 @@ function show_help()
> >         echo "be highly recommended."
> >         echo
> >         echo "Options:"
> > -       echo "  -b BITMASK      doorbell clear bitmask for ntb_tool"
> >         echo "  -C              don't cleanup ntb modules on exit"
> >         echo "  -d              run dma tests"
> >         echo "  -h              show this help message"
> > @@ -56,7 +54,6 @@ function parse_args()
> >         OPTIND=0
> >         while getopts "b:Cdhlm:r:p:w:" opt; do
> >                 case "$opt" in
> > -               b)  DB_BITMASK=${OPTARG} ;;
> >                 C)  DONT_CLEANUP=1 ;;
> >                 d)  RUN_DMA_TESTS=1 ;;
> >                 h)  show_help; exit 0 ;;
> > @@ -215,21 +212,30 @@ function doorbell_test()
> >
> >         echo "Running db tests on: $(basename $LOC) / $(basename $REM)"
> >
> > -       write_file "c $DB_BITMASK" "$REM/db"
> > +       DB_VALID_MASK=$(read_file "$LOC/db_valid_mask")
> >
> > -       for ((i=1; i <= 8; i++)); do
> > -               let DB=$(read_file "$REM/db") || true
> > -               if [[ "$DB" != "$EXP" ]]; then
> > +       write_file "c $DB_VALID_MASK" "$REM/db"
> > +
> > +       for ((i = 0; i < 64; i++)); do
> 
> I'm guessing this should be a tunable variable, for those systems with
> a different number of doorbells.
> 

64 is the maximum number of doorbells supported by the NTB API. But we are
checking only the valid ones for the NTB device being tested. For this purpose
the script reads the db_valid_mask file.

> 
> > +               DB=$(read_file "$REM/db")
> > +               if [[ "$DB" -ne "$EXP" ]]; then
> >                         echo "Doorbell doesn't match expected value $EXP " \
> >                              "in $REM/db" >&2
> >                         exit -1
> >                 fi
> >
> > -               let "MASK=1 << ($i-1)" || true
> > -               let "EXP=$EXP | $MASK" || true
> > +               let "MASK = (1 << $i) & $DB_VALID_MASK" || true
> > +               let "EXP = $EXP | $MASK" || true
> > +
> >                 write_file "s $MASK" "$LOC/peer_db"
> >         done
> >
> > +       write_file "c $DB_VALID_MASK" "$REM/db_mask"
> > +       write_file $DB_VALID_MASK "$REM/db_event"
> > +       write_file "s $DB_VALID_MASK" "$REM/db_mask"
> > +
> > +       write_file "c $DB_VALID_MASK" "$REM/db"
> > +
> >         echo "  Passed"
> >  }
> >
> > @@ -393,14 +399,15 @@ function ntb_tool_tests()
> >         write_file "Y" "$LOCAL_PEER_TOOL/link_event"
> >         write_file "Y" "$REMOTE_PEER_TOOL/link_event"
> >
> > +       doorbell_test "$LOCAL_TOOL" "$REMOTE_TOOL"
> > +       doorbell_test "$REMOTE_TOOL" "$LOCAL_TOOL"
> > +
> >         for PEER_TRANS in $(ls "$LOCAL_TOOL"/peer_trans*); do
> >                 PT=$(basename $PEER_TRANS)
> >                 write_file $MW_SIZE "$LOCAL_TOOL/$PT"
> >                 write_file $MW_SIZE "$REMOTE_TOOL/$PT"
> >         done
> >
> > -       doorbell_test "$LOCAL_TOOL" "$REMOTE_TOOL"
> > -       doorbell_test "$REMOTE_TOOL" "$LOCAL_TOOL"
> >         scratchpad_test "$LOCAL_TOOL" "$REMOTE_TOOL"
> >         scratchpad_test "$REMOTE_TOOL" "$LOCAL_TOOL"
> >
> > --
> > 2.12.0
> >
