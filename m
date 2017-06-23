Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id c67si276297itb.5.2017.06.23.14.59.53
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Jun 2017 14:59:53 -0700 (PDT)
References: <9615f074-5b81-210b-eb88-218a59d65198@deltatee.com>
 <000001d2eb85$daecdea0$90c69be0$@dell.com>
 <8a1ff94c-8689-0d4c-cc33-7b495daa065a@deltatee.com>
 <000101d2eba4$b45b1e40$1d115ac0$@dell.com>
 <aec6f161-eaf8-19cf-ee5a-155d67da38ba@deltatee.com>
 <000201d2eba8$dade4ac0$909ae040$@dell.com>
 <4d932597-3592-2ce1-5a5f-cb5ba36a3a93@deltatee.com>
 <000001d2ec23$2bd9f300$838dd900$@dell.com>
 <5aa9c438-e152-4caa-2c6d-cbbd130a0eb2@deltatee.com>
 <000101d2ec53$f2830840$d78918c0$@dell.com>
 <20170623214708.GA26488@mobilestation>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <99f37cec-993d-9c9c-c602-310700a1659c@deltatee.com>
Date: Fri, 23 Jun 2017 15:59:48 -0600
MIME-Version: 1.0
In-Reply-To: <20170623214708.GA26488@mobilestation>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: New NTB API Issue
To: Serge Semin <fancer.lancer@gmail.com>, Allen Hubbe <Allen.Hubbe@dell.com>
Cc: 'Jon Mason' <jdmason@kudzu.us>, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, 'Dave Jiang' <dave.jiang@intel.com>, 'Kurt Schwemmer' <kurt.schwemmer@microsemi.com>, 'Stephen Bates' <sbates@raithlin.com>, 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
List-ID: <linux-ntb.googlegroups.com>

Hey,

Thanks Serge for the detailed explanation. This is pretty much exactly
as I had thought it should be interpreted. My only problem remains that
my hardware can't provide ntb_mw_get_align until the port it is asking
about has configured itself. The easiest way to solve this is to only
allow access when the link to that port is up. It's not a complicated
change and would actually simplify ntb_transport and ntb_perf a little.

Is this ok with you Allen? If it is, I can include a patch in my next
switchtec submission.

Thanks,

Logan
