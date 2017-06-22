Return-Path: <Allen.Hubbe@dell.com>
Received: from esa4.dell-outbound.iphmx.com (esa4.dell-outbound.iphmx.com. [68.232.149.214])
        by gmr-mx.google.com with ESMTPS id u9si205042ywe.2.2017.06.22.15.43.08
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Jun 2017 15:43:08 -0700 (PDT)
From: "Allen Hubbe" <Allen.Hubbe@dell.com>
References: <20170615203729.9009-1-logang@deltatee.com> <20170619200659.GA20437@kudzu.us> <9615f074-5b81-210b-eb88-218a59d65198@deltatee.com> <000001d2eb85$daecdea0$90c69be0$@dell.com> <8a1ff94c-8689-0d4c-cc33-7b495daa065a@deltatee.com> <000101d2eba4$b45b1e40$1d115ac0$@dell.com> <aec6f161-eaf8-19cf-ee5a-155d67da38ba@deltatee.com>
In-Reply-To: <aec6f161-eaf8-19cf-ee5a-155d67da38ba@deltatee.com>
Subject: RE: New NTB API Issue
Date: Thu, 22 Jun 2017 18:42:38 -0400
Message-ID: <000201d2eba8$dade4ac0$909ae040$@dell.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-us
To: 'Logan Gunthorpe' <logang@deltatee.com>, 'Jon Mason' <jdmason@kudzu.us>
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, 'Dave Jiang' <dave.jiang@intel.com>, 'Serge Semin' <fancer.lancer@gmail.com>, 'Kurt Schwemmer' <kurt.schwemmer@microsemi.com>, 'Stephen Bates' <sbates@raithlin.com>, 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
List-ID: <linux-ntb.googlegroups.com>

From: Logan Gunthorpe
> Any thoughts on changing the semantics of mw_get_align so it must be
> called with the link up?

The intention of these is that these calls return information from the =
local port.  The calls themselves don't reach across the link to the =
peer, but the information returned from the local port needs to be =
communicated for setting up the translation end-to-end.

I would like to understand why this hardware needs link up.  Are there =
registers on the local port that are only valid after link up?

Can you post snippets of how ntb_mw_get_align and ntb_peer_mw_get_addr =
might be implemented for the Switchtec?

