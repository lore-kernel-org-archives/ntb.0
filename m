Return-Path: <Allen.Hubbe@dell.com>
Received: from esa2.dell-outbound.iphmx.com (esa2.dell-outbound.iphmx.com. [68.232.149.220])
        by gmr-mx.google.com with ESMTPS id h18si1118779ywc.2.2016.12.07.07.10.06
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Dec 2016 07:10:07 -0800 (PST)
From: "Allen Hubbe" <Allen.Hubbe@dell.com>
References: <1503156503.754106.1481072956836.JavaMail.zimbra@xes-inc.com> <000001d2509b$2d829050$8887b0f0$@dell.com>
In-Reply-To: <000001d2509b$2d829050$8887b0f0$@dell.com>
Subject: RE: correct ntb_spad_count comment typo
Date: Wed, 7 Dec 2016 10:09:45 -0500
Message-ID: <000101d2509b$f25511a0$d6ff34e0$@dell.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
To: 'Allen Hubbe' <Allen.Hubbe@dell.com>, 'Aaron Sierra' <asierra@xes-inc.com>, 'Jon Mason' <jdmason@kudzu.us>, 'Dave Jiang' <dave.jiang@intel.com>
Cc: linux-ntb@googlegroups.com, 'Jiri Kosina' <trivial@kernel.org>
List-ID: <linux-ntb.googlegroups.com>

From: Allen Hubbe
> From: Aaron Sierra
> > The comment for ntb_spad_count incorrectly referred to ntb_mw_count.
> >
> > Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
> 
> Acked-by: Allen Hubbe <Allen.Hubbe@dell.com>
> 

Actually, the commit subject line should include the subsystem name.

"NTB: Correct ntb_spad_count comment typo"

John might fix this after accepting the patch as is, but it would be easier if you amend the commit and send v2 with a new subject line.

Thanks,
Allen

> > ---
> >  include/linux/ntb.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/ntb.h b/include/linux/ntb.h
> > index 6f47562..50a7dbe 100644
> > --- a/include/linux/ntb.h
> > +++ b/include/linux/ntb.h
> > @@ -892,15 +892,15 @@ static inline int ntb_spad_is_unsafe(struct ntb_dev *ntb)
> >  	if (!ntb->ops->spad_is_unsafe)
> >  		return 0;
> >
> >  	return ntb->ops->spad_is_unsafe(ntb);
> >  }
> >
> >  /**
> > - * ntb_mw_count() - get the number of scratchpads
> > + * ntb_spad_count() - get the number of scratchpads
> >   * @ntb:	NTB device context.
> >   *
> >   * Hardware and topology may support a different number of scratchpads.
> >   *
> >   * Return: the number of scratchpads.
> >   */
> >  static inline int ntb_spad_count(struct ntb_dev *ntb)
> > --
> > 1.9.1
> 
> 
> --
> You received this message because you are subscribed to the Google Groups "linux-ntb"
> group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-
> ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-
> ntb/000001d2509b%242d829050%248887b0f0%24%40dell.com.
> For more options, visit https://groups.google.com/d/optout.

