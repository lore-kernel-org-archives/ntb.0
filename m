Return-Path: <jdmason@kudzu.us>
Received: from mail-qk0-x244.google.com (mail-qk0-x244.google.com. [2607:f8b0:400d:c09::244])
        by gmr-mx.google.com with ESMTPS id z17si290791ywd.6.2017.01.10.13.51.14
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jan 2017 13:51:14 -0800 (PST)
Received: by mail-qk0-x244.google.com with SMTP id 11so12815458qkl.0
        for <linux-ntb@googlegroups.com>; Tue, 10 Jan 2017 13:51:14 -0800 (PST)
Return-Path: <jdmason@kudzu.us>
Date: Tue, 10 Jan 2017 16:51:11 -0500
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH 1/2] NTB: ntb_test: modprobe on remote host
Message-ID: <20170110215110.GB13381@kudzu.us>
References: <6a532e4dff499983cd96bc9a4653686a88d9cb08.1482883799.git.Allen.Hubbe@dell.com>
 <33d317ca-249c-300f-ce7f-a2953bfe138b@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33d317ca-249c-300f-ce7f-a2953bfe138b@deltatee.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Allen Hubbe <Allen.Hubbe@dell.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Tue, Dec 27, 2016 at 05:16:22PM -0700, Logan Gunthorpe wrote:
> Looks good to me.
> 
> Acked-by: Logan Gunthorpe <logang@deltatee.com>
> 
> On 27/12/16 05:12 PM, Allen Hubbe wrote:
> > Signed-off-by: Allen Hubbe <Allen.Hubbe@dell.com>

Applied to my ntb tree

Thanks,
Jon

> > ---
> >  tools/testing/selftests/ntb/ntb_test.sh | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/ntb/ntb_test.sh b/tools/testing/selftests/ntb/ntb_test.sh
> > index a676d3eefefb..4e70e19255bc 100755
> > --- a/tools/testing/selftests/ntb/ntb_test.sh
> > +++ b/tools/testing/selftests/ntb/ntb_test.sh
> > @@ -85,6 +85,10 @@ set -e
> >  function _modprobe()
> >  {
> >          modprobe "$@"
> > +
> > +	if [[ "$REMOTE_HOST" != "" ]]; then
> > +		ssh "$REMOTE_HOST" modprobe "$@"
> > +	fi
> >  }
> >  
> >  function split_remote()
> > 
