Return-Path: <Allen.Hubbe@dell.com>
Received: from esa6.dell-outbound.iphmx.com (esa6.dell-outbound.iphmx.com. [68.232.149.229])
        by gmr-mx.google.com with ESMTPS id o206si328895ywb.12.2017.06.23.15.07.02
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Jun 2017 15:07:03 -0700 (PDT)
From: "Allen Hubbe" <Allen.Hubbe@dell.com>
References: <20170615203729.9009-1-logang@deltatee.com> <20170619200659.GA20437@kudzu.us> <9615f074-5b81-210b-eb88-218a59d65198@deltatee.com> <000001d2eb85$daecdea0$90c69be0$@dell.com> <8a1ff94c-8689-0d4c-cc33-7b495daa065a@deltatee.com> <000101d2eba4$b45b1e40$1d115ac0$@dell.com> <aec6f161-eaf8-19cf-ee5a-155d67da38ba@deltatee.com> <000201d2eba8$dade4ac0$909ae040$@dell.com> <4d932597-3592-2ce1-5a5f-cb5ba36a3a93@deltatee.com> <000001d2ec23$2bd9f300$838dd900$@dell.com> <5aa9c438-e152-4caa-2c6d-cbbd130a0eb2@deltatee.com> <000101d2ec53$f2830840$d78918c0$@dell.com> <eeaed83a-cd2b-91f1-e199-eaa6452edd17@deltatee.com>
In-Reply-To: <eeaed83a-cd2b-91f1-e199-eaa6452edd17@deltatee.com>
Subject: RE: New NTB API Issue
Date: Fri, 23 Jun 2017 18:06:42 -0400
Message-ID: <000301d2ec6c$ffe3d4b0$ffab7e10$@dell.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-us
To: 'Logan Gunthorpe' <logang@deltatee.com>, 'Jon Mason' <jdmason@kudzu.us>
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, 'Dave Jiang' <dave.jiang@intel.com>, 'Serge Semin' <fancer.lancer@gmail.com>, 'Kurt Schwemmer' <kurt.schwemmer@microsemi.com>, 'Stephen Bates' <sbates@raithlin.com>, 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
List-ID: <linux-ntb.googlegroups.com>

From: Logan Gunthorpe
> But any translation can be
> programmed by any peer.

That doesn't seem safe.  Even though it can be done as you say, would it =
not be better to have each specific translation under the control of =
exactly one driver?

If drivers can reach across and set the translation of any peer bar, =
they would still need to negotiate among N peers which one sets which =
other's translation.

