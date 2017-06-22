Return-Path: <Allen.Hubbe@dell.com>
Received: from esa1.dell-outbound.iphmx.com (esa1.dell-outbound.iphmx.com. [68.232.153.90])
        by gmr-mx.google.com with ESMTPS id w77si159316ywg.10.2017.06.22.15.13.12
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Jun 2017 15:13:13 -0700 (PDT)
From: "Allen Hubbe" <Allen.Hubbe@dell.com>
References: <20170615203729.9009-1-logang@deltatee.com> <20170619200659.GA20437@kudzu.us> <9615f074-5b81-210b-eb88-218a59d65198@deltatee.com> <000001d2eb85$daecdea0$90c69be0$@dell.com> <8a1ff94c-8689-0d4c-cc33-7b495daa065a@deltatee.com>
In-Reply-To: <8a1ff94c-8689-0d4c-cc33-7b495daa065a@deltatee.com>
Subject: RE: New NTB API Issue
Date: Thu, 22 Jun 2017 18:12:56 -0400
Message-ID: <000101d2eba4$b45b1e40$1d115ac0$@dell.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-us
To: 'Logan Gunthorpe' <logang@deltatee.com>, 'Jon Mason' <jdmason@kudzu.us>
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, 'Dave Jiang' <dave.jiang@intel.com>, 'Serge Semin' <fancer.lancer@gmail.com>, 'Kurt Schwemmer' <kurt.schwemmer@microsemi.com>, 'Stephen Bates' <sbates@raithlin.com>, 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
List-ID: <linux-ntb.googlegroups.com>

From: Logan Gunthorpe
> On 6/22/2017 12:32 PM, Allen Hubbe wrote:
> > From: Logan Gunthorpe
> >> 2) The changes to the Intel and AMD driver for mw_get_align sets
> >> *max_size to the local pci resource size. (Thus making the =
assumption
> >> that the local is the same as the peer, which is wrong). max_size =
isn't
> >> actually used for anything so it's not _really_ an issue, but I do =
think
> >> it's confusing and incorrect. I'd suggest we remove max_size until
> >> something actually needs it, or at least set it to zero in cases =
where
> >> the hardware doesn't support returning the size of the peer's =
memory
> >> window (ie. in the Intel and AMD drivers).
> >
> > You're right, and the b2b_split in the Intel driver even makes use =
of different primary/secondary
> bar sizes. For Intel and AMD, it would make more sense to use the =
secondary bar size here.  The size
> of the secondary bar still not necessarily valid end-to-end, because =
in b2b the peer's primary bar
> size could be even smaller.
> >
> > I'm not entirely convinced that this should represent the end-to-end =
size of local and peer memory
> window configurations.  I think it should represent the largest side =
that would be valid to pass to
> ntb_mw_set_trans().  Then, the peers should communicate their =
respective max sizes (along with
> translation addresses, etc) before setting up the translations, and =
that exchange will ensure that the
> size finally used is valid end-to-end.
>=20
> But why would the client ever need to use the max_size instead of the
> actual size of the bar as retrieved and exchanged from =
peer_mw_get_addr?

The resource size given by peer_mw_get_addr might be different than the =
max_size given by ntb_mw_get_align.

I am most familiar with the ntb_hw_intel driver and that type of ntb =
hardware.  The peer_mw_get_addr size is of the primary bar on the side =
to be the source of the translated writes (or reads).  In b2b topology, =
at least, the first translation of that write lands it on the secondary =
bar of the peer ntb.  That size of that bar could different than the =
first.  The second translation lands the write in memory (eg).  So, the =
end-to-end translation is limited by the first AND second sizes.

The first point is, the *max_size returned by intel_ntb_mw_get_align =
looks wrong.  That should be the size of the secondary bar, not the =
resource size of the primary bar, of that device.

The second point is, because the sizes returned by peer_mw_get_addr, and =
ntb_mw_get_align, may be different, the two sides should communicate and =
reconcile the address and size information when setting up the =
translations.

