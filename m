Return-Path: <Allen.Hubbe@dell.com>
Received: from esa7.dell-outbound.iphmx.com (esa7.dell-outbound.iphmx.com. [68.232.153.96])
        by gmr-mx.google.com with ESMTPS id d17si134408ywb.4.2017.06.22.11.33.10
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Jun 2017 11:33:10 -0700 (PDT)
From: "Allen Hubbe" <Allen.Hubbe@dell.com>
References: <20170615203729.9009-1-logang@deltatee.com> <20170619200659.GA20437@kudzu.us> <9615f074-5b81-210b-eb88-218a59d65198@deltatee.com>
In-Reply-To: <9615f074-5b81-210b-eb88-218a59d65198@deltatee.com>
Subject: RE: New NTB API Issue
Date: Thu, 22 Jun 2017 14:32:06 -0400
Message-ID: <000001d2eb85$daecdea0$90c69be0$@dell.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-us
To: 'Logan Gunthorpe' <logang@deltatee.com>, 'Jon Mason' <jdmason@kudzu.us>
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, 'Dave Jiang' <dave.jiang@intel.com>, 'Serge Semin' <fancer.lancer@gmail.com>, 'Kurt Schwemmer' <kurt.schwemmer@microsemi.com>, 'Stephen Bates' <sbates@raithlin.com>, 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
List-ID: <linux-ntb.googlegroups.com>

From: Logan Gunthorpe
> Hey Guys,
>=20
> I've run into some subtle issues with the new API:
>=20
> It has to do with splitting mw_get_range into mw_get_align and
> peer_mw_get_addr.
>=20
> The original mw_get_range returned the size of the /local/ memory
> window's size, address and alignment requirements. The ntb clients =
then
> take the local size and transmit it via spads to the peer which would
> use it in setting up the memory window. However, it made the =
assumption
> that the alignment restrictions were symmetric on both hosts seeing =
they
> were not sent across the link.
>=20
> The new API makes a sensible change for this in that mw_get_align
> appears to be intended to return the alignment restrictions (and now
> size) of the peer. This helps a bit for the Switchtec driver but =
appears
> to be a semantic change that wasn't really reflected in the changes to
> the other NTB code. So, I see a couple of issues:
>=20
> 1) With our hardware, we can't actually know anything about the peer's
> memory windows until the peer has finished its setup (ie. the link is
> up). However, all the clients call the function during probe, before =
the
> link is ready. There's really no good reason for this, so I think we
> should change the clients so that mw_get_align is called only when the
> link is up.
>=20
> 2) The changes to the Intel and AMD driver for mw_get_align sets
> *max_size to the local pci resource size. (Thus making the assumption
> that the local is the same as the peer, which is wrong). max_size =
isn't
> actually used for anything so it's not _really_ an issue, but I do =
think
> it's confusing and incorrect. I'd suggest we remove max_size until
> something actually needs it, or at least set it to zero in cases where
> the hardware doesn't support returning the size of the peer's memory
> window (ie. in the Intel and AMD drivers).

You're right, and the b2b_split in the Intel driver even makes use of =
different primary/secondary bar sizes. For Intel and AMD, it would make =
more sense to use the secondary bar size here.  The size of the =
secondary bar still not necessarily valid end-to-end, because in b2b the =
peer's primary bar size could be even smaller.

I'm not entirely convinced that this should represent the end-to-end =
size of local and peer memory window configurations.  I think it should =
represent the largest side that would be valid to pass to =
ntb_mw_set_trans().  Then, the peers should communicate their respective =
max sizes (along with translation addresses, etc) before setting up the =
translations, and that exchange will ensure that the size finally used =
is valid end-to-end.

>=20
> Thoughts?
>=20
> Logan

