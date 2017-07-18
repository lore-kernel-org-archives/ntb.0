Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id 21si857192itj.0.2017.07.18.11.08.14
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jul 2017 11:08:14 -0700 (PDT)
References: <20170718160409.6493-1-logang@deltatee.com>
 <000301d2ffee$6c2db5c0$44892140$@dell.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <8ba7a175-91c2-4a95-153c-0a7b668b7fbc@deltatee.com>
Date: Tue, 18 Jul 2017 12:08:06 -0600
MIME-Version: 1.0
In-Reply-To: <000301d2ffee$6c2db5c0$44892140$@dell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 00/16] Switchtec NTB Support
To: Allen Hubbe <Allen.Hubbe@dell.com>, linux-ntb@googlegroups.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: 'Jon Mason' <jdmason@kudzu.us>, 'Dave Jiang' <dave.jiang@intel.com>, 'Bjorn Helgaas' <bhelgaas@google.com>, 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>, 'Kurt Schwemmer' <kurt.schwemmer@microsemi.com>, 'Stephen Bates' <sbates@raithlin.com>, 'Serge Semin' <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>



On 18/07/17 11:51 AM, Allen Hubbe wrote:
> Acked-by: Allen Hubbe <Allen.Hubbe@dell.com>

Thanks.

> Should the order of 6 and 7 be swapped?

Hmm, yes. I'll make the change for a v3 after more feedback comes.

> 6 - I think just the comment is best.  Rather than prohibit the use of functionality for hardware that does support the calls, in my opinion it should be left to specific hardware drivers to return an error.

As stated, I disagree. You can't allow clients to misuse the API when
testing with drivers that don't care. Otherwise, I'd have to manually
police the mailing-list for changes that would break when used with the
switchtec code. Better to make this automatic.

> 14 - I would prefer that a non-hardware-supported implementation of spads via a memory window should be common code, not reinvented in each specific hardware driver that lacks hardware spads.  You pointed out that the spads implemented here use the shared_mw construct, which is specific to this driver.  I am concerned that spads in the shared_mw (really anything in shared_mw, including this driver's indication of the peer link state) limits the applicability of this driver to just configurations of two ntb ports.  You stated this limitation upfront.

I think it should wait until other drivers actually do something similar
to common up the code. It's impossible to know exactly how it should be
made common until we know what other drivers actually need. When that
does happen I'm happy to work with anyone who wants to make it common.

The code, as is, is limited to two hosts largely because I have no way
to test multi-host setups (as no clients are ready for it) and
multi-host is also not a priority for us at the moment. The shared_mw
concept on its own will _not_ limit the number of hosts. The switchtec
hardware has special fixed size LUT memory windows (the number of these
is configurable but should have easily enough to provide one window per
port as the default is 32 and the maximum is 128). I'm not sure if other
devices provide similar functionality but it's fairly necessary for
emulating spads and link status with memory windows.

Logan
