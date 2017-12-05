Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x244.google.com (mail-lf0-x244.google.com. [2a00:1450:4010:c07::244])
        by gmr-mx.google.com with ESMTPS id r6si132078wrg.2.2017.12.05.12.37.10
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Dec 2017 12:37:10 -0800 (PST)
Received: by mail-lf0-x244.google.com with SMTP id f13so1779206lff.12
        for <linux-ntb@googlegroups.com>; Tue, 05 Dec 2017 12:37:10 -0800 (PST)
Return-Path: <fancer.lancer@gmail.com>
Date: Tue, 5 Dec 2017 23:37:17 +0300
From: Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH v2 09/15] NTB: ntb_test: Update ntb_tool link tests
Message-ID: <20171205203717.GH1701@mobilestation>
References: <20171203191736.3399-1-fancer.lancer@gmail.com>
 <20171203191736.3399-10-fancer.lancer@gmail.com>
 <CAPoiz9yLgxR3QtuZ16YpSjREz8-imgmua4VFFyy0mQVqdFN_Sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPoiz9yLgxR3QtuZ16YpSjREz8-imgmua4VFFyy0mQVqdFN_Sg@mail.gmail.com>
To: Jon Mason <jdmason@kudzu.us>
Cc: Dave Jiang <dave.jiang@intel.com>, "Hubbe, Allen" <Allen.Hubbe@emc.com>, "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>, "Yu, Xiangliang" <Xiangliang.Yu@amd.com>, Gary R Hook <gary.hook@amd.com>, Sergey.Semin@t-platforms.ru, linux-ntb <linux-ntb@googlegroups.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-ntb.googlegroups.com>

On Tue, Dec 05, 2017 at 01:26:29PM -0500, Jon Mason <jdmason@kudzu.us> wrote:
> On Sun, Dec 3, 2017 at 2:17 PM, Serge Semin <fancer.lancer@gmail.com> wrote:
> > Link Up and Down methods are used to change NTB link settings on
> > local side only for multi-port devices. Link is considered up
> > only if both sides local and peer set it up. Intel/AMD hardware
> > acts a bit different by assigning the Primary and Secondary roles,
> > so Primary device only is able to change the link state. Such behaviour
> > should be reflected in the test code.
> >
> > Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> > ---
> >  tools/testing/selftests/ntb/ntb_test.sh | 26 +++++++++++++++-----------
> >  1 file changed, 15 insertions(+), 11 deletions(-)
> >
> > diff --git a/tools/testing/selftests/ntb/ntb_test.sh b/tools/testing/selftests/ntb/ntb_test.sh
> > index 541ba70ad640..247458c6d8dc 100755
> > --- a/tools/testing/selftests/ntb/ntb_test.sh
> > +++ b/tools/testing/selftests/ntb/ntb_test.sh
> > @@ -138,6 +138,11 @@ function check_file()
> >         fi
> >  }
> >
> > +function subdirname()
> > +{
> > +       echo $(basename $(dirname $1)) 2> /dev/nulle
> 
> shouldn't this be /dev/null?
> 

Goot catch. That's right.

> > +}
> > +
> >  function find_pidx()
> >  {
> >         PORT=$1
> > @@ -183,9 +188,9 @@ function link_test()
> >         REM=$2
> >         EXP=0
> >
> > -       echo "Running link tests on: $(basename $LOC) / $(basename $REM)"
> > +       echo "Running link tests on: $(subdirname $LOC) / $(subdirname $REM)"
> >
> > -       if ! write_file "N" "$LOC/link" 2> /dev/null; then
> > +       if ! write_file "N" "$LOC/../link" 2> /dev/null; then
> >                 echo "  Unsupported"
> >                 return
> >         fi
> > @@ -193,12 +198,11 @@ function link_test()
> >         write_file "N" "$LOC/link_event"
> >
> >         if [[ $(read_file "$REM/link") != "N" ]]; then
> > -               echo "Expected remote link to be down in $REM/link" >&2
> > +               echo "Expected link to be down in $REM/link" >&2
> >                 exit -1
> >         fi
> >
> > -       write_file "Y" "$LOC/link"
> > -       write_file "Y" "$LOC/link_event"
> > +       write_file "Y" "$LOC/../link"
> >
> >         echo "  Passed"
> >  }
> > @@ -379,15 +383,15 @@ function ntb_tool_tests()
> >
> >         port_test "$LOCAL_TOOL" "$REMOTE_TOOL"
> >
> > -       write_file "Y" "$LOCAL_TOOL/link_event"
> > -       write_file "Y" "$REMOTE_TOOL/link_event"
> > +       LOCAL_PEER_TOOL="$LOCAL_TOOL/peer$LOCAL_PIDX"
> > +       REMOTE_PEER_TOOL="$REMOTE_TOOL/peer$REMOTE_PIDX"
> >
> > -       link_test "$LOCAL_TOOL" "$REMOTE_TOOL"
> > -       link_test "$REMOTE_TOOL" "$LOCAL_TOOL"
> > +       link_test "$LOCAL_PEER_TOOL" "$REMOTE_PEER_TOOL"
> > +       link_test "$REMOTE_PEER_TOOL" "$LOCAL_PEER_TOOL"
> >
> >         #Ensure the link is up on both sides before continuing
> > -       write_file "Y" "$LOCAL_TOOL/link_event"
> > -       write_file "Y" "$REMOTE_TOOL/link_event"
> > +       write_file "Y" "$LOCAL_PEER_TOOL/link_event"
> > +       write_file "Y" "$REMOTE_PEER_TOOL/link_event"
> >
> >         for PEER_TRANS in $(ls "$LOCAL_TOOL"/peer_trans*); do
> >                 PT=$(basename $PEER_TRANS)
> > --
> > 2.12.0
> >
