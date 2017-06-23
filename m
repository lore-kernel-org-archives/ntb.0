Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id c139si307288itb.2.2017.06.23.16.06.48
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Jun 2017 16:06:48 -0700 (PDT)
References: <20170615203729.9009-1-logang@deltatee.com>
 <20170619200659.GA20437@kudzu.us>
 <9615f074-5b81-210b-eb88-218a59d65198@deltatee.com>
 <000001d2eb85$daecdea0$90c69be0$@dell.com>
 <8a1ff94c-8689-0d4c-cc33-7b495daa065a@deltatee.com>
 <000101d2eba4$b45b1e40$1d115ac0$@dell.com>
 <aec6f161-eaf8-19cf-ee5a-155d67da38ba@deltatee.com>
 <000201d2eba8$dade4ac0$909ae040$@dell.com>
 <4d932597-3592-2ce1-5a5f-cb5ba36a3a93@deltatee.com>
 <000001d2ec23$2bd9f300$838dd900$@dell.com>
 <5aa9c438-e152-4caa-2c6d-cbbd130a0eb2@deltatee.com>
 <000101d2ec53$f2830840$d78918c0$@dell.com>
 <eeaed83a-cd2b-91f1-e199-eaa6452edd17@deltatee.com>
 <000301d2ec6c$ffe3d4b0$ffab7e10$@dell.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <ea75d9cf-a6c6-29bc-c553-2f0a965bcaa2@deltatee.com>
Date: Fri, 23 Jun 2017 17:06:40 -0600
MIME-Version: 1.0
In-Reply-To: <000301d2ec6c$ffe3d4b0$ffab7e10$@dell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: New NTB API Issue
To: Allen Hubbe <Allen.Hubbe@dell.com>, 'Jon Mason' <jdmason@kudzu.us>
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, 'Dave Jiang' <dave.jiang@intel.com>, 'Serge Semin' <fancer.lancer@gmail.com>, 'Kurt Schwemmer' <kurt.schwemmer@microsemi.com>, 'Stephen Bates' <sbates@raithlin.com>, 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
List-ID: <linux-ntb.googlegroups.com>



On 23/06/17 04:06 PM, Allen Hubbe wrote:
> From: Logan Gunthorpe
>> But any translation can be
>> programmed by any peer.
> 
> That doesn't seem safe.  Even though it can be done as you say, would it not be better to have each specific translation under the control of exactly one driver?
> 
> If drivers can reach across and set the translation of any peer bar, they would still need to negotiate among N peers which one sets which other's translation.

Yup. In a dual host setup its not a problem seeing only the one peer
will ever set any of the memory windows. In the multi-host setup, there
has to be implicit or explicit negotiation as to which memory window
connects to which peer.

The hardware also implements locking so if two peers try to mess with
the same translation, the worst that can happen is the last peer's
settings will take effect or one peer will see an error.

Logan

