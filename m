Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id o26-v6si593062qto.1.2018.10.15.10.55.55
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 10:55:55 -0700 (PDT)
References: <1539375618-6782-1-git-send-email-asierra@xes-inc.com>
 <CAJ80savCdO_VM_0As28+H5KB6ejapbFV2OVoRpPnU9bLyijqRw@mail.gmail.com>
 <1171724234.130293.1539620853528.JavaMail.zimbra@xes-inc.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <a06eb3b3-7e49-a72f-df21-5c36c592c88d@deltatee.com>
Date: Mon, 15 Oct 2018 11:55:46 -0600
MIME-Version: 1.0
In-Reply-To: <1171724234.130293.1539620853528.JavaMail.zimbra@xes-inc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 0/2] NTB: Stash private data in transport client device
To: Aaron Sierra <asierra@xes-inc.com>, Allen Hubbe <allenbh@gmail.com>
Cc: linux-ntb <linux-ntb@googlegroups.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, davem@davemloft.net
List-ID: <linux-ntb.googlegroups.com>



On 2018-10-15 10:27 a.m., Aaron Sierra wrote:
>> On Fri, Oct 12, 2018 at 4:20 PM Aaron Sierra <asierra@xes-inc.com> wrote:
>>> Support NTB transport client device drivers stashing a reference to
>>> their private device representation within the transport client device
>>> for trivial lookup.
>>
>> Can dev_get/set_drvdata() be used instead?
> 
> Allen, sure that would work just fine. You're asking for dev_get_drvdata
> and dev_set_drvdata to be used behind-the-scenes as an implementation
> detail, right?

I agree with Allen that the drvdata functions already fill this need.
There's no reason to create NTB specific wrappers for them. Just use
them directly.

The cleanup for ntb_netdev_remove() is very nice and I'll be happy to
add my review when it uses drvdata.

> I'd like to add this cleanup as a call to ntb_transport_client_set_pdata()
> in ntb_transport_client_release(), so all transport client drivers get it for
> free if that's alright with you.

IMO setting it to NULL right before kfree-ing the structure is  unnecessary.

Logan
