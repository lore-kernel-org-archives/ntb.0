Return-Path: <asierra@xes-inc.com>
Received: from mail.xes-mad.com (xes-mad.com. [162.248.234.2])
        by gmr-mx.google.com with ESMTP id v16-v6si445651ybe.1.2018.10.15.09.27.34
        for <linux-ntb@googlegroups.com>;
        Mon, 15 Oct 2018 09:27:34 -0700 (PDT)
Date: Mon, 15 Oct 2018 11:27:33 -0500 (CDT)
From: Aaron Sierra <asierra@xes-inc.com>
Message-ID: <1171724234.130293.1539620853528.JavaMail.zimbra@xes-inc.com>
In-Reply-To: <CAJ80savCdO_VM_0As28+H5KB6ejapbFV2OVoRpPnU9bLyijqRw@mail.gmail.com>
References: <1539375618-6782-1-git-send-email-asierra@xes-inc.com> <CAJ80savCdO_VM_0As28+H5KB6ejapbFV2OVoRpPnU9bLyijqRw@mail.gmail.com>
Subject: Re: [PATCH 0/2] NTB: Stash private data in transport client device
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Allen Hubbe <allenbh@gmail.com>
Cc: linux-ntb <linux-ntb@googlegroups.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, davem@davemloft.net
List-ID: <linux-ntb.googlegroups.com>

----- Original Message -----
> From: "Allen Hubbe" <allenbh@gmail.com>
> Sent: Monday, October 15, 2018 9:59:28 AM

> On Fri, Oct 12, 2018 at 4:20 PM Aaron Sierra <asierra@xes-inc.com> wrote:
>>
>> Support NTB transport client device drivers stashing a reference to
>> their private device representation within the transport client device
>> for trivial lookup.
> 
> Can dev_get/set_drvdata() be used instead?

Allen, sure that would work just fine. You're asking for dev_get_drvdata
and dev_set_drvdata to be used behind-the-scenes as an implementation
detail, right?
 
>> Use the new stashing mechanism to simplify ntb_netdev device probe
>> and remove. This optimization will also benefit any out-of-tree
>> drivers that care to use it.
> 
> Simplify ntb_netdev_remove() looks good.  Please also set(NULL) on remove.

I'd like to add this cleanup as a call to ntb_transport_client_set_pdata()
in ntb_transport_client_release(), so all transport client drivers get it for
free if that's alright with you.

-Aaron S.

>>
>> Aaron Sierra (2):
>>   NTB: transport: Support client device private data
>>   ntb_netdev: Simplify remove with client private data
>>
>>  drivers/net/ntb_netdev.c      | 28 +++-------------------------
>>  drivers/ntb/ntb_transport.c   | 19 +++++++++++++++++++
>>  include/linux/ntb_transport.h |  2 ++
>>  3 files changed, 24 insertions(+), 25 deletions(-)
>>
>> --
>> 2.7.4
