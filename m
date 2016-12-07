Return-Path: <asierra@xes-inc.com>
Received: from xes-mad.com (xes-mad.com. [216.165.139.218])
        by gmr-mx.google.com with ESMTPS id n126si1214522ita.1.2016.12.07.09.33.54
        for <linux-ntb@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 07 Dec 2016 09:33:54 -0800 (PST)
Date: Wed, 7 Dec 2016 11:33:51 -0600 (CST)
From: Aaron Sierra <asierra@xes-inc.com>
Message-ID: <1763865308.471858.1481132031876.JavaMail.zimbra@xes-inc.com>
In-Reply-To: <000101d2509b$f25511a0$d6ff34e0$@dell.com>
References: <1503156503.754106.1481072956836.JavaMail.zimbra@xes-inc.com> <000001d2509b$2d829050$8887b0f0$@dell.com> <000101d2509b$f25511a0$d6ff34e0$@dell.com>
Subject: Re: correct ntb_spad_count comment typo
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Allen Hubbe <Allen.Hubbe@dell.com>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, linux-ntb <linux-ntb@googlegroups.com>, Jiri Kosina <trivial@kernel.org>
List-ID: <linux-ntb.googlegroups.com>

----- Original Message -----
> From: "Allen Hubbe" <Allen.Hubbe@dell.com>
> Sent: Wednesday, December 7, 2016 9:09:45 AM

> From: Allen Hubbe
>> From: Aaron Sierra
>> > The comment for ntb_spad_count incorrectly referred to ntb_mw_count.
>> >
>> > Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
>> 
>> Acked-by: Allen Hubbe <Allen.Hubbe@dell.com>
>> 
> 
> Actually, the commit subject line should include the subsystem name.
> 
> "NTB: Correct ntb_spad_count comment typo"

Allen,
First of all, thanks for taking time to review my patch!

This is the exact subject that I sent out:

    [PATCH] NTB: correct ntb_spad_count comment typo

Hopefully, this is just a glitch between me and you.

> 
> John might fix this after accepting the patch as is, but it would be easier if
> you amend the commit and send v2 with a new subject line.
> 

Can anyone else confirm or deny the need for a v2?

-Aaron S.
