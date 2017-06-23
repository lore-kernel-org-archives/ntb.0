Return-Path: <Allen.Hubbe@dell.com>
Received: from esa4.dell-outbound.iphmx.com (esa4.dell-outbound.iphmx.com. [68.232.149.214])
        by gmr-mx.google.com with ESMTPS id x20si222985ywj.11.2017.06.23.06.18.32
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Jun 2017 06:18:33 -0700 (PDT)
From: "Allen Hubbe" <Allen.Hubbe@dell.com>
References: <20170615203729.9009-1-logang@deltatee.com> <20170619200659.GA20437@kudzu.us> <9615f074-5b81-210b-eb88-218a59d65198@deltatee.com> <000001d2eb85$daecdea0$90c69be0$@dell.com> <8a1ff94c-8689-0d4c-cc33-7b495daa065a@deltatee.com> <000101d2eba4$b45b1e40$1d115ac0$@dell.com> <aec6f161-eaf8-19cf-ee5a-155d67da38ba@deltatee.com> <000201d2eba8$dade4ac0$909ae040$@dell.com> <4d932597-3592-2ce1-5a5f-cb5ba36a3a93@deltatee.com>
In-Reply-To: <4d932597-3592-2ce1-5a5f-cb5ba36a3a93@deltatee.com>
Subject: RE: New NTB API Issue
Date: Fri, 23 Jun 2017 09:18:12 -0400
Message-ID: <000001d2ec23$2bd9f300$838dd900$@dell.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-us
To: 'Logan Gunthorpe' <logang@deltatee.com>, 'Jon Mason' <jdmason@kudzu.us>
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, 'Dave Jiang' <dave.jiang@intel.com>, 'Serge Semin' <fancer.lancer@gmail.com>, 'Kurt Schwemmer' <kurt.schwemmer@microsemi.com>, 'Stephen Bates' <sbates@raithlin.com>, 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
List-ID: <linux-ntb.googlegroups.com>

From: Logan Gunthorpe
> On 6/22/2017 4:42 PM, Allen Hubbe wrote:
> > From: Logan Gunthorpe
> >> Any thoughts on changing the semantics of mw_get_align so it must =
be
> >> called with the link up?
> >
> > The intention of these is that these calls return information from =
the local port.  The calls
> themselves don't reach across the link to the peer, but the =
information returned from the local port
> needs to be communicated for setting up the translation end-to-end.
>=20
> Ok, well if it's from the local port, then splitting up mw_get_range
> into peer_mw_get_addr and mw_get_align is confusing because one has =
the
> peer designation and the other doesn't. And all the clients apply the
> alignments to the remote bar so they'd technically need to transfer =
them
> across the link somehow.

By "remote" do you mean the source or destination of a write?

Yes, clients should transfer the address and size information to the =
peer.

> > I would like to understand why this hardware needs link up.  Are =
there registers on the local port
> that are only valid after link up?
>=20
> We only need the link up if we are trying to find the alignment
> requirements (and max_size) of the peer's bar. In theory, switchtec

Maybe this is the confusion.  None of these api calls are to reach =
across to the peer port, as to get the size of the peer's bar.  They are =
to get information from the local port, or to configure the local port.

Some mw configuration is done at the destination, as for Intel and AMD, =
and some configuration is done on the source side, for IDT.  The local =
configuration of the port on one side could depend on information from =
the remote port on the other side.  For example in IDT, the mw =
translation configured on the source side needs to know destination =
address information.  Likewise, if there is any difference in the size =
of the range that can be translated by ports on opposing sides, that =
needs to be negotiated.

> could have different sizes of bars on both sides of the link and
> different alignment requirements. Though, in practice, this is =
probably
> unlikely.
>=20
> > Can you post snippets of how ntb_mw_get_align and =
ntb_peer_mw_get_addr might be implemented for the
> Switchtec?
>=20
> Hmm, yes, but lets sort out my confusion on the semantics per above =
first.

Some snippets of code would help me understand your interpretation of =
the api semantics more exactly.

> Logan

