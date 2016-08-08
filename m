Return-Path: <Allen.Hubbe@emc.com>
Received: from esa6.dell-outbound.iphmx.com (esa6.dell-outbound.iphmx.com. [68.232.149.229])
        by gmr-mx.google.com with ESMTPS id d206si1886166ywh.3.2016.08.08.14.49.09
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Aug 2016 14:49:09 -0700 (PDT)
From: "Allen Hubbe" <Allen.Hubbe@emc.com>
Subject: RE: [PATCH v2 1/3] ntb: Add asynchronous devices support to NTB-bus interface
Date: Mon, 8 Aug 2016 17:48:42 -0400
Message-ID: <002201d1f1be$a24fe400$e6efac00$@emc.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-us
To: 'Serge Semin' <fancer.lancer@gmail.com>
Cc: jdmason@kudzu.us, dave.jiang@intel.com, Xiangliang.Yu@amd.com, Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

From: Serge Semin
> Hello Allen.
>=20
> Thanks for your careful review. Going through this mailing thread I =
hope we'll come up
> with solutions, which improve the driver code as well as extend the =
Linux kernel support
> of new devices like IDT PCIe-swtiches.
>=20
> Before getting to the inline commentaries I need to give some =
introduction to the IDT NTB-
> related hardware so we could speak on the same language. Additionally =
I'll give a brief
> explanation how the setup of memory windows works in IDT =
PCIe-switches.

I found this to use as a reference for IDT:
https://www.idt.com/document/man/89hpes24nt24g2-device-user-manual

> First of all, before getting into the IDT NTB driver development I had =
made a research of
> the currently developed NTB kernel API and AMD/Intel hardware drivers. =
Due to lack of the
> hardware manuals It might be not in deep details, but I understand how =
the AMD/Intel NTB-
> hardware drivers work. At least I understand the concept of memory =
windowing, which led to
> the current NTB bus kernel API.
>=20
> So lets get to IDT PCIe-switches. There is a whole series of =
NTB-related switches IDT
> produces. All of them I split into two distinct groups:
> 1) Two NTB-ported switches (models 89PES8NT2, 89PES16NT2, 89PES12NT3, =
89PES124NT3),
> 2) Multi NTB-ported switches (models 89HPES24NT6AG2, 89HPES32NT8AG2, =
89HPES32NT8BG2,
> 89HPES12NT12G2, 89HPES16NT16G2, 89HPES24NT24G2, 89HPES32NT24AG2, =
89HPES32NT24BG2).
> Just to note all of these switches are a part of IDT PRECISE(TM) =
family of PCI Express=AE
> switching solutions. Why do I split them up? Because of the next =
reasons:
> 1) Number of upstream ports, which have access to NTB functions =
(obviously, yeah? =3D)). So
> the switches of the first group can connect just two domains over NTB. =
Unlike the second
> group of switches, which expose a way to setup an interaction between =
several PCIe-switch
> ports, which have NT-function activated.
> 2) The groups are significantly distinct by the way of NT-functions =
configuration.
>=20
> Before getting further, I should note, that the uploaded driver =
supports the second group
> of devices only. But still I'll give a comparative explanation, since =
the first group of
> switches is very similar to the AMD/Intel NTBs.
>=20
> Lets dive into the configurations a bit deeper. Particularly =
NT-functions of the first
> group of switches can be configured the same way as AMD/Intel =
NTB-functions are. There is
> an PCIe end-point configuration space, which fully reflects the =
cross-coupled local and
> peer PCIe/NTB settings. So local Root complex can set any of the peer =
registers by direct
> writing to mapped memory. Here is the image, which perfectly explains =
the configuration
> registers mapping:
> https://s8.postimg.org/3nhkzqfxx/IDT_NTB_old_configspace.png
> Since the first group switches connect only two root complexes, the =
race condition of
> read/write operations to cross-coupled registers can be easily =
resolved just by roles
> distribution. So local root complex sets the translated base address =
directly to a peer
> configuration space registers, which correspond to BAR0-BAR3 locally =
mapped memory
> windows. Of course 2-4 memory windows is enough to connect just two =
domains. That's why
> you made the NTB bus kernel API the way it is.
>=20
> The things get different when one wants to have an access from one =
domain to multiple
> coupling up to eight root complexes in the second group of switches. =
First of all the
> hardware doesn't support the configuration space cross-coupling =
anymore. Instead there are
> two Global Address Space Access registers provided to have an access =
to a peers
> configuration space. In fact it is not a big problem, since there are =
no much differences
> in accessing registers over a memory mapped space or a pair of fixed =
Address/Data
> registers. The problem arises when one wants to share a memory windows =
between eight
> domains. Five BARs are not enough for it even if they'd be configured =
to be of x32 address
> type. Instead IDT introduces Lookup table address translation. So =
BAR2/BAR4 can be
> configured to translate addresses using 12 or 24 entries lookup =
tables. Each entry can be
> initialized with translated base address of a peer and IDT switch =
port, which peer is
> connected to. So when local root complex locally maps BAR2/BAR4, one =
can have an access to
> a memory of a peer just by reading/writing with a shift corresponding =
to the lookup table
> entry. That's how more than five peers can be accessed. The root =
problem is the way the
> lookup table is accessed. Alas It is accessed only by a pair of "Entry =
index/Data"
> registers. So a root complex must write an entry index to one =
registers, then read/write
> data from another. As you might realise, that weak point leads to a =
race condition of
> multiple root complexes accessing the lookup table of one shared peer. =
Alas I could not
> come up with a simple and strong solution of the race.

Right, multiple peers reaching across to some other peer's NTB =
configuration space is problematic.  I don't mean to suggest we should =
reach across to configure the lookup table (or anything else) on a =
remote NTB.

> That's why I've introduced the asynchronous hardware in the NTB bus =
kernel API. Since
> local root complex can't directly write a translated base address to a =
peer, it must wait
> until a peer asks him to allocate a memory and send the address back =
using some of a
> hardware mechanism. It can be anything: Scratchpad registers, Message =
registers or even
> "crazy" doorbells bingbanging. For instance, the IDT switches of the =
first group support:
> 1) Shared Memory windows. In particular local root complex can set a =
translated base
> address to BARs of local and peer NT-function using the cross-coupled =
PCIe/NTB
> configuration space, the same way as it can be done for AMD/Intel =
NTBs.
> 2) One Doorbell register.
> 3) Two Scratchpads.
> 4) Four message regietsrs.
> As you can see the switches of the first group can be considered as =
both synchronous and
> asynchronous. All the NTB bus kernel API can be implemented for it =
including the changes
> introduced by this patch (I would do it if I had a corresponding =
hardware). AMD and Intel
> NTBs can be considered both synchronous and asynchronous as well, =
although they don't
> support messaging so Scratchpads can be used to send a data to a peer. =
Finally the
> switches of the second group lack of ability to initialize BARs =
translated base address of
> peers due to the race condition I described before.
>=20
> To sum up I've spent a lot of time designing the IDT NTB driver. I've =
done my best to make
> the IDT driver as much compatible with current design as possible, =
nevertheless the NTB
> bus kernel API had to be slightly changed. You can find answers to the =
commentaries down
> below.
>=20
> On Fri, Aug 05, 2016 at 11:31:58AM -0400, Allen Hubbe =
<Allen.Hubbe@emc.com> wrote:
> > From: Serge Semin
> > > Currently supported AMD and Intel Non-transparent PCIe-bridges are =
synchronous
> > > devices, so translated base address of memory windows can be =
direcly written
> > > to peer registers. But there are some IDT PCIe-switches which =
implement
> > > complex interfaces using Lookup Tables of translation addresses. =
Due to
> > > the way the table is accessed, it can not be done synchronously =
from different
> > > RCs, that's why the asynchronous interface should be developed.
> > >
> > > For these purpose the Memory Window related interface is =
correspondingly split
> > > as it is for Doorbell and Scratchpad registers. The definition of =
Memory Window
> > > is following: "It is a virtual memory region, which locally =
reflects a physical
> > > memory of peer device." So to speak the "ntb_peer_mw_"-prefixed =
methods control
> > > the peers memory windows, "ntb_mw_"-prefixed functions work with =
the local
> > > memory windows.
> > > Here is the description of the Memory Window related NTB-bus =
callback
> > > functions:
> > >  - ntb_mw_count() - number of local memory windows.
> > >  - ntb_mw_get_maprsc() - get the physical address and size of the =
local memory
> > >                          window to map.
> > >  - ntb_mw_set_trans() - set translation address of local memory =
window (this
> > >                         address should be somehow retrieved from a =
peer).
> > >  - ntb_mw_get_trans() - get translation address of local memory =
window.
> > >  - ntb_mw_get_align() - get alignment of translated base address =
and size of
> > >                         local memory window. Additionally one can =
get the
> > >                         upper size limit of the memory window.
> > >  - ntb_peer_mw_count() - number of peer memory windows (it can =
differ from the
> > >                          local number).
> > >  - ntb_peer_mw_set_trans() - set translation address of peer =
memory window
> > >  - ntb_peer_mw_get_trans() - get translation address of peer =
memory window
> > >  - ntb_peer_mw_get_align() - get alignment of translated base =
address and size
> > >                              of peer memory window.Additionally =
one can get the
> > >                              upper size limit of the memory =
window.
> > >
> > > As one can see current AMD and Intel NTB drivers mostly implement =
the
> > > "ntb_peer_mw_"-prefixed methods. So this patch correspondingly =
renames the
> > > driver functions. IDT NTB driver mostly expose "ntb_nw_"-prefixed =
methods,
> > > since it doesn't have convenient access to the peer Lookup Table.
> > >
> > > In order to pass information from one RC to another NTB functions =
of IDT
> > > PCIe-switch implement Messaging subsystem. They currently support =
four message
> > > registers to transfer DWORD sized data to a specified peer. So =
there are two
> > > new callback methods are introduced:
> > >  - ntb_msg_size() - get the number of DWORDs supported by NTB =
function to send
> > >                     and receive messages
> > >  - ntb_msg_post() - send message of size retrieved from =
ntb_msg_size()
> > >                     to a peer
> > > Additionally there is a new event function:
> > >  - ntb_msg_event() - it is invoked when either a new message was =
retrieved
> > >                      (NTB_MSG_NEW), or last message was =
successfully sent
> > >                      (NTB_MSG_SENT), or the last message failed to =
be sent
> > >                      (NTB_MSG_FAIL).
> > >
> > > The last change concerns the IDs (practically names) of =
NTB-devices on the
> > > NTB-bus. It is not good to have the devices with same names in the =
system
> > > and it brakes my IDT NTB driver from being loaded =3D) So I =
developed a simple
> > > algorithm of NTB devices naming. Particulary it generates names =
"ntbS{N}" for
> > > synchronous devices, "ntbA{N}" for asynchronous devices, and =
"ntbAS{N}" for
> > > devices supporting both interfaces.
> >
> > Thanks for the work that went into writing this driver, and thanks =
for your patience
> with the review.  Please read my initial comments inline.  I would =
like to approach this
> from a top-down api perspective first, and settle on that first before =
requesting any
> specific changes in the hardware driver.  My major concern about these =
changes is that
> they introduce a distinct classification for sync and async hardware, =
supported by
> different sets of methods in the api, neither is a subset of the =
other.
> >
> > You know the IDT hardware, so if any of my requests below are =
infeasible, I would like
> your constructive opinion (even if it means significant changes to =
existing drivers) on
> how to resolve the api so that new and existing hardware drivers can =
be unified under the
> same api, if possible.
>=20
> I understand your concern. I have been thinking of this a lot. In my =
opinion the proposed
> in this patch alterations are the best of all variants I've been =
thinking about. Regarding
> the lack of APIs subset. In fact I would not agree with that. As I =
described in the
> introduction AMD and Intel drivers can be considered as both =
synchronous and asynchronous,
> since a translated base address can be directly set in a local and =
peer configuration
> space. Although AMD and Intel devices don't support messaging, they =
have Scratchpads,
> which can be used to exchange an information between root complexes. =
The thing we need to
> do is to implement ntb_mw_set_trans() and ntb_mw_get_align() for them. =
Which isn't much
> different from the "mw_peer"-prefixed ones. The first method just sets =
a translated base
> address to the corresponding local register. The second one does =
exactly the same as
> "mw_peer"-prefixed ones. I would do it, but I haven't got a hardware =
to test, that's why I
> left things the way it was with just slight changes of names.

It sounds like the purpose of your ntb_mw_set_trans() [what I would call =
ntb_peer_mw_set_trans()] is similar to what is done at initialization =
time in the Intel NTB driver, so that outgoing writes are translated to =
the correct peer NTB BAR.  The difference is that IDT outgoing =
translation sets not only the peer NTB address but also the port number =
in the translation.
http://lxr.free-electrons.com/source/drivers/ntb/hw/intel/ntb_hw_intel.c?=
v=3D4.7#L1673

It would be interesting to allow ntb clients to change this translation, =
eg, configure an outgoing write from local BAR23 so it hits peer =
secondary BAR45.  I don't think e.g. Intel driver should be forced to =
implement that, but it would be interesting to think of unifying the api =
with that in mind.

>=20
> > > Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> > >
> > > ---
> > >  drivers/ntb/Kconfig                 |   4 +-
> > >  drivers/ntb/hw/amd/ntb_hw_amd.c     |  49 ++-
> > >  drivers/ntb/hw/intel/ntb_hw_intel.c |  59 +++-
> > >  drivers/ntb/ntb.c                   |  86 +++++-
> > >  drivers/ntb/ntb_transport.c         |  19 +-
> > >  drivers/ntb/test/ntb_perf.c         |  16 +-
> > >  drivers/ntb/test/ntb_pingpong.c     |   5 +
> > >  drivers/ntb/test/ntb_tool.c         |  25 +-
> > >  include/linux/ntb.h                 | 600 =
+++++++++++++++++++++++++++++-------
> > >  9 files changed, 701 insertions(+), 162 deletions(-)
> > >


> > > -		rc =3D ntb_mw_get_range(ndev, i, &mw->phys_addr, =
&mw->phys_size,
> > > -				      &mw->xlat_align, &mw->xlat_align_size);
> > > +		rc =3D ntb_mw_get_maprsc(ndev, i, &mw->phys_addr, =
&mw->phys_size);
> > > +		if (rc)
> > > +			goto err1;
> > > +
> > > +		rc =3D ntb_peer_mw_get_align(ndev, i, &mw->xlat_align,
> > > +					   &mw->xlat_align_size, NULL);
> >
> > Looks like ntb_mw_get_range() was simpler before the change.
> >
>=20
> If I didn't change NTB bus kernel API, I would have split them up =
anyway. First of all
> functions with long argument list look more confusing, than ones with =
shorter list. It
> helps to stick to the "80 character per line" rule and improves =
readability. Secondly the
> function splitting improves the readability of the code in general. =
When I first saw the
> function name "ntb_mw_get_range()", it was not obvious what kind of =
ranges this function
> returned. The function lacked of "high code coherence" unofficial =
rule. It is better when
> one function does one coherent thing and return a well coherent data. =
Particularly
> function "ntb_mw_get_range()" returned a local memory windows mapping =
address and size, as
> well as alignment of memory allocated for a peer. So now =
"ntb_mw_get_maprsc()" method
> returns mapping resources. If local NTB client driver is not going to =
allocate any memory,
> so one just doesn't need to call "ntb_peer_mw_get_align()" method at =
all. I understand,
> that a client driver could pass NULL to a unused arguments of the =
"ntb_mw_get_range()",
> but still the new design is better readable.
>=20
> Additionally I've split them up because of the difference in the way =
the asynchronous
> interface works. IDT driver can not safely perform =
ntb_peer_mw_set_trans(), that's why I
> had to add ntb_mw_set_trans(). Each of that method should logically =
have related
> "ntb_*mw_get_align()" method. Method ntb_mw_get_align() shall give to =
a local client
> driver a hint how the retrieved from the peer translated base address =
should be aligned,
> so ntb_mw_set_trans() method would successfully return. Method =
ntb_peer_mw_get_align()
> will give a hint how the local memory buffer should be allocated to =
fulfil a peer
> translated base address alignment. In this way it returns restrictions =
for parameters of
> "ntb_peer_mw_set_trans()".
>=20
> Finally, IDT driver is designed so Primary and Secondary ports can =
support a different
> number of memory windows. In this way methods
> =
"ntb_mw_get_maprsc()/ntb_mw_set_trans()/ntb_mw_get_trans()/ntb_mw_get_ali=
gn()" have
> different range of acceptable values of the second argument, which is =
determined by the
> "ntb_mw_count()" method, comparing to methods
> =
"ntb_peer_mw_set_trans()/ntb_peer_mw_get_trans()/ntb_peer_mw_get_align()"=
, which memory
> windows index restriction is determined by the "ntb_peer_mw_count()" =
method.
>=20
> So to speak the splitting was really necessary to make the API looking =
more logical.

If this change is not required by the new hardware, please submit the =
change as a separate patch.

> > > +	/* Synchronous hardware is only supported */
> > > +	if (!ntb_valid_sync_dev_ops(ntb)) {
> > > +		return -EINVAL;
> > > +	}
> > > +
> >
> > It would be nice if both types could be supported by the same api.
> >
>=20
> Yes, it would be. Alas it isn't possible in general. See the =
introduction to this letter.
> AMD and Intel devices support asynchronous interface, although they =
lack of messaging
> mechanism.

What is the prototypical application of the IDT message registers?

I'm thinking they will be the first thing available to drivers, and so =
one primary purpose will be to exchange information for configuring =
memory windows.  Can you describe how a cluster of eight nodes would =
discover each other and initialize?

Are they also intended to be useful beyond memory window initialization? =
 How should they be used efficiently, so that the application can =
minimize in particular read operations on the pci bus (reading ntb =
device registers)?  Or are message registers not intended to be used in =
low latency communications (for that, use doorbells and memory instead)?

>=20
> Getting back to the discussion, we still need to provide a way to =
determine which type of
> interface an NTB device supports: synchronous/asynchronous translated =
base address
> initialization, Scratchpads and memory windows. Currently it can be =
determined by the
> functions ntb_valid_sync_dev_ops()/ntb_valid_async_dev_ops(). I =
understand, that it's not
> the best solution. We can implement the traditional Linux kernel bus =
device-driver
> matching, using table_ids and so on. For example, each hardware driver =
fills in a table
> with all the functionality it supports, like: synchronous/asynchronous =
memory windows,
> Doorbells, Scratchpads, Messaging. Then driver initialize a table of =
functionality it
> uses. NTB bus core implements a "match()" callback, which compares =
those two tables and
> calls "probe()" callback method of a driver when the tables =
successfully matches.
>=20
> On the other hand, we might don't have to comprehend the NTB bus core. =
We can just
> introduce a table_id for NTB hardware device, which would just =
describe the device vendor
> itself, like "ntb,amd", "ntb,intel", "ntb,idt" and so on. Client =
driver will declare a
> supported device by its table_id. It might look easier, since

emphasis added:

> the client driver developer
> should have a basic understanding of the device one develops a driver =
for.

This is what I'm hoping to avoid.  I would like to let the driver =
developer write for the api, not for the specific device.  I would =
rather the driver check "if feature x is supported" instead of "this is =
a sync or async device."

> Then NTB bus
> kernel API core will simply match NTB devices with drivers like any =
other buses (PCI,
> PCIe, i2c, spi, etc) do.
>=20

> > > -static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops =
*ops)
> > > +static inline int ntb_valid_sync_dev_ops(const struct ntb_dev =
*ntb)
> > > +static inline int ntb_valid_async_dev_ops(const struct ntb_dev =
*ntb)
> >
> > I understand why IDT requires a different api for dealing with =
addressing multiple
> peers.  I would be interested in a solution that would allow, for =
example, the Intel
> driver fit under the api for dealing with multiple peers, even though =
it only supports one
> peer.  I would rather see that, than two separate apis under ntb.
> >
> > Thoughts?
> >
> > Can the sync api be described by some subset of the async api?  Are =
there less
> overloaded terms we can use instead of sync/async?
> >
>=20
> Answer to this concern is mostly provided in the introduction as well. =
I'll repeat it here
> in details. As I said AMD and Intel hardware support asynchronous API =
except the
> messaging. Additionally I can even think of emulating messaging using =
Doorbells and
> Scratchpads, but not the other way around. Why not? Before answering, =
here is how the
> messaging works in IDT switches of both first and second groups (see =
introduction for
> describing the groups).
>=20
> There are four outbound and inbound message registers for each NTB =
port in the device.
> Local root complex can connect its any outbound message to any inbound =
message register of
> the IDT switch. When one writes a data to an outbound message register =
it immediately gets
> to the connected inbound message registers. Then peer can read its =
inbound message
> registers and empty it by clearing a corresponding bit. Then and only =
then next data can
> be written to any outbound message registers connected to that inbound =
message register.
> So the possible race condition between multiple domains sending a =
message to same peer is
> resolved by the IDT switch itself.
>=20
> One would ask: "Why don't you just wrap the message registers up back =
to the same port? It
> would look just like Scratchpads." Yes, It would. But still there are =
only four message
> registers. It's not enough to distribute them between all the possibly =
connected NTB
> ports. As I said earlier there can be up to eight domains connected, =
so there must be at
> least seven message register to fulfil the possible design.
>=20
> Howbeit all the emulations would look ugly anyway. In my opinion It's =
better to slightly
> adapt design for a hardware, rather than hardware to a design. =
Following that rule would
> simplify a code and support respectively.
>=20
> Regarding the APIs subset. As I said before async API is kind of =
subset of synchronous
> API. We can develop all the memory window related callback-method for =
AMD and Intel
> hardware driver, which is pretty much easy. We can even simulate =
message registers by
> using Doorbells and Scratchpads, which is not that easy, but possible. =
Alas the second
> group of IDT switches can't implement the synchronous API, as I =
already said in the
> introduction.

Message registers operate fundamentally differently from scratchpads =
(and doorbells, for that matter).  I think we are in agreement.  It's a =
pain, but maybe the best we can do is require applications to check for =
support for scratchpads, message registers, and/or doorbells, before =
using any of those features.  We already have ntb_db_valid_mask() and =
ntb_spad_count().

I would like to see ntb_msg_count() and more direct access to the =
message registers in this api.  I would prefer to see the more direct =
access to hardware message registers, instead of work_struct for message =
processing in the low level hardware driver.  A more direct interface to =
the hardware registers would be more like the existing ntb.h api: direct =
and low-overhead as possible, providing minimal abstraction of the =
hardware functionality.

I think there is still hope we can unify the memory window interface.  =
Even though IDT supports things like subdividing the memory windows with =
table lookup, and specification of destination ports for outgoing =
translations, I think we can support the same abstraction in the =
existing drivers with minimal overhead.

For existing Intel and AMD drivers, there may be only one translation =
per memory window (there is no table to subdivide the memory window), =
and there is only one destination port (the peer).  The Intel and AMD =
drivers can ignore the table index in setting up the translation (or =
validate that the requested table index is equal to zero).

> Regarding the overloaded naming. The "sync/async" names are the best I =
could think of. If
> you have any idea how one can be appropriately changed, be my guest. I =
would be really
> glad to substitute them with something better.
>=20

Let's try to avoid a distinction, first, beyond just saying "not all =
hardware will support all these features."  If we absolutely have to =
make a distinction, let's think of better names then.

> > > + * ntb_msg_event() - notify driver context of event in messaging =
subsystem
> > >   * @ntb:	NTB device context.
> > > + * @ev:		Event type caused the handler invocation
> > > + * @msg:	Message related to the event
> > > + *
> > > + * Notify the driver context that there is some event happaned in =
the event
> > > + * subsystem. If NTB_MSG_NEW is emitted then the new message has =
just arrived.
> > > + * NTB_MSG_SENT is rised if some message has just been =
successfully sent to a
> > > + * peer. If a message failed to be sent then NTB_MSG_FAIL is =
emitted. The very
> > > + * last argument is used to pass the event related message. It =
discarded right
> > > + * after the handler returns.
> > > + */
> > > +void ntb_msg_event(struct ntb_dev *ntb, enum NTB_MSG_EVENT ev,
> > > +		   struct ntb_msg *msg);
> >
> > I would prefer to see a notify-and-poll api (like NAPI).  This will =
allow scheduling of
> the message handling to be done more appropriately at a higher layer =
of the application.
> I am concerned to see inmsg/outmsg_work in the new hardware driver =
[PATCH 2/3], which I
> think would be more appropriate for a ntb transport (or higher layer) =
driver.
> >
>=20
> Hmmm, that's how it's done.) MSI interrupt is raised when a new =
message arrived into a
> first inbound message register (the rest of message registers are used =
as an additional
> data buffers). Then a corresponding tasklet is started to release a =
hardware interrupt
> context. That tasklet extracts a message from the inbound message =
registers, puts it into
> the driver inbound message queue and marks the registers as empty so =
the next message
> could be retrieved. Then tasklet starts a corresponding kernel work =
thread delivering all
> new messages to a client driver, which preliminary registered =
"ntb_msg_event()" callback
> method. When callback method "ntb_msg_event()" the passed message is =
discarded.

When an interrupt arrives, can you signal the upper layer that a message =
has arrived, without delivering the message?  I think the lower layer =
can do without the work structs, instead have the same body of the work =
struct run in the context of the upper layer polling to receive the =
message.

> > It looks like there was some rearranging of code, so big hunks =
appear to be added or
> removed.  Can you split this into two (or more) patches so that =
rearranging the code is
> distinct from more interesting changes?
> >
>=20
> Lets say there was not much rearranging here. I've just put =
link-related method before
> everything else. The rearranging was done from the point of methods =
importance view. There
> can't be any memory sharing and doorbells operations done before the =
link is established.
> The new arrangements is reflected in =
ntb_valid_sync_dev_ops()/ntb_valid_async_dev_ops()
> methods.

It's unfortunate how the diff captured the changes.  Can you split this =
up into smaller patches?

> > > - * ntb_mw_get_range() - get the range of a memory window
> > > + * ntb_mw_get_maprsc() - get the range of a memory window to map
> >
> > What was insufficient about ntb_mw_get_range() that it needed to be =
split into
> ntb_mw_get_maprsc() and ntb_mw_get_align()?  In all the places that I =
found in this patch,
> it seems ntb_mw_get_range() would have been more simple.
> >
> > I didn't see any use of ntb_mw_get_mapsrc() in the new async test =
clients [PATCH 3/3].
> So, there is no example of how usage of new api would be used =
differently or more
> efficiently than ntb_mw_get_range() for async devices.
> >
>=20
> This concern is answered a bit earlier, when you first commented the =
method
> "ntb_mw_get_range()" splitting.
>=20
> You could not find the "ntb_mw_get_mapsrc()" method usage because you =
misspelled it. The
> real method signature is "ntb_mw_get_maprsc()" (look more carefully at =
the name ending),
> which is decrypted as "Mapping Resources", but no "Mapping Source". =
ntb/test/ntb_mw_test.c
> driver is developed to demonstrate how the new asynchronous API is =
utilized including the
> "ntb_mw_get_maprsc()" method usage.

Right, I misspelled it.  It would be easier to catch a misspelling of =
ragne.

[PATCH v2 3/3]:
+		/* Retrieve the physical address of the memory to map */
+		ret =3D ntb_mw_get_maprsc(ntb, mwindx, &outmw->phys_addr,
+			&outmw->size);
+		if (SUCCESS !=3D ret) {
+			dev_err_mw(ctx, "Failed to get map resources of "
+				"outbound window %d", mwindx);
+			mwindx--;
+			goto err_unmap_rsc;
+		}
+
+		/* Map the memory window resources */
+		outmw->virt_addr =3D ioremap_nocache(outmw->phys_addr, outmw->size);
+
+		/* Retrieve the memory windows maximum size and alignments */
+		ret =3D ntb_mw_get_align(ntb, mwindx, &outmw->addr_align,
+			&outmw->size_align, &outmw->size_max);
+		if (SUCCESS !=3D ret) {
+			dev_err_mw(ctx, "Failed to get alignment options of "
+				"outbound window %d", mwindx);
+			goto err_unmap_rsc;
+		}

It looks to me like ntb_mw_get_range() would have been sufficient here.  =
If the change is required by the new driver, please show evidence of =
that.  If this change is not required by the new hardware, please submit =
the change as a separate patch.

> > I think ntb_peer_mw_set_trans() and ntb_mw_set_trans() are =
backwards.  Does the
> following make sense, or have I completely misunderstood something?
> >
> > ntb_mw_set_trans(): set up translation so that incoming writes to =
the memory window are
> translated to the local memory destination.
> >
> > ntb_peer_mw_set_trans(): set up (what exactly?) so that outgoing =
writes to a peer memory
> window (is this something that needs to be configured on the local =
ntb?) are translated to
> the peer ntb (i.e. their port/bridge) memory window.  Then, the peer's =
setting of
> ntb_mw_set_trans() will complete the translation to the peer memory =
destination.
> >
>=20
> These functions actually do the opposite you described:

That's the point.  I noticed that they are opposite.

> ntb_mw_set_trans() - method sets the translated base address retrieved =
from a peer, so
> outgoing writes to a memory window would be translated and reach the =
peer memory
> destination.

In other words, this affects the translation of writes in the direction =
of the peer memory.  I think this should be named =
ntb_peer_mw_set_trans().

> ntb_peer_mw_set_trans() - method sets translated base address to peer =
configuration space,
> so the local incoming writes would be correctly translated on the peer =
and reach the local
> memory destination.

In other words, this affects the translation for writes in the direction =
of local memory.  I think this should be named ntb_mw_set_trans().

> Globally thinking, these methods do the same think, when they called =
from opposite
> domains. So to speak locally called "ntb_mw_set_trans()" method does =
the same thing as the
> method "ntb_peer_mw_set_trans()" called from a peer, and vise versa =
the locally called
> method "ntb_peer_mw_set_trans()" does the same procedure as the method
> "ntb_mw_set_trans()" called from a peer.
>=20
> To make things simpler, think of memory windows in the framework of =
the next definition:
> "Memory Window is a virtual memory region, which locally reflects a =
physical memory of
> peer/remote device." So when we call ntb_mw_set_trans(), we initialize =
the local memory
> window, so the locally mapped virtual addresses would be connected =
with the peer physical
> memory. When we call ntb_peer_mw_set_trans(), we initialize a =
peer/remote virtual memory
> region, so the peer could successfully perform a writes to our local =
physical memory.
>=20
> Of course all the actual memory read/write operations should follow up =
ntb_mw_get_maprsc()
> and ioremap_nocache() method invocation doublet. You do the same thing =
in the client test
> drivers for AMD and Intel hadrware.
>=20

> > >  /**
> > > @@ -751,6 +1053,8 @@ static inline int ntb_db_clear_mask(struct =
ntb_dev *ntb, u64
> db_bits)
> > >   * append one additional dma memory copy with the doorbell =
register as the
> > >   * destination, after the memory copy operations.
> > >   *
> > > + * This is unusual, and hardware may not be suitable to implement =
it.
> > > + *
> >
> > Why is this unusual?  Do you mean async hardware may not support it?
> >
>=20
> Of course I can always return an address of a Doorbell register, but =
it's not safe to do
> it working with IDT NTB hardware driver. To make thing explained =
simpler think a IDT
> hardware, which supports the Doorbell bits routing. Each local inbound =
Doorbell bits of
> each port can be configured to either reflect the global switch =
doorbell bits state or not
> to reflect. Global doorbell bits are set by using outbound doorbell =
register, which is
> exist for every NTB port. Primary port is the port which can have an =
access to multiple
> peers, so the Primary port inbound and outbound doorbell registers are =
shared between
> several NTB devices, sited on the linux kernel NTB bus. As you =
understand, these devices
> should not interfere each other, which can happen on uncontrollable =
usage of Doorbell
> registers addresses. That's why the method cou "ntb_peer_db_addr()" =
should not be
> developed for the IDT NTB hardware driver.

I misread the diff as if this comment was added to the description of =
ntb_db_clear_mask().

> > > +	if (!ntb->ops->spad_count)
> > > +		return -EINVAL;
> > > +
> >
> > Maybe we should return zero (i.e. there are no scratchpads).
> >
>=20
> Agreed. I will fix it in the next patchset.

Thanks.

> > > +	if (!ntb->ops->spad_read)
> > > +		return 0;
> > > +
> >
> > Let's return ~0.  I think that's what a driver would read from the =
pci bus for a memory
> miss.
> >
>=20
> Agreed. I will make it returning -EINVAL in the next patchset.

I don't think we should try to interpret the returned value as an error =
number.  If the driver supports this method, and this is a valid =
scratchpad, the peer can put any value in i, including a value that =
could be interpreted as an error number.

A driver shouldn't be using this method if it isn't supported.  But if =
it does, I think ~0 is a better poison value than 0.  I just don't want =
to encourage drivers to try to interpret this value as an error number.

> > > +	if (!ntb->ops->peer_spad_read)
> > > +		return 0;
> >
> > Also, ~0?
> >
>=20
> Agreed. I will make it returning -EINVAL in the next patchset.

I don't think we should try to interpret the returned value as an error =
number.

> > > + * ntb_msg_post() - post the message to the peer
> > > + * @ntb:	NTB device context.
> > > + * @msg:	Message
> > > + *
> > > + * Post the message to a peer. It shall be delivered to the peer =
by the
> > > + * corresponding hardware method. The peer should be notified =
about the new
> > > + * message by calling the ntb_msg_event() handler of NTB_MSG_NEW =
event type.
> > > + * If delivery is fails for some reasong the local node will get =
NTB_MSG_FAIL
> > > + * event. Otherwise the NTB_MSG_SENT is emitted.
> >
> > Interesting.. local driver would be notified about completion =
(success or failure) of
> delivery.  Is there any order-of-completion guarantee for the =
completion notifications?
> Is there some tolerance for faults, in case we never get a completion =
notification from
> the peer (eg. we lose the link)?  If we lose the link, report a local =
fault, and the link
> comes up again, can we still get a completion notification from the =
peer, and how would
> that be handled?
> >
> > Does delivery mean the application has processed the message, or is =
it just delivery at
> the hardware layer, or just delivery at the ntb hardware driver layer?
> >
>=20
> Let me explain how the message delivery works. When a client driver =
calls the
> "ntb_msg_post()" method, the corresponding message is placed in an =
outbound messages
> queue. Such the message queue exists for every peer device. Then a =
dedicated kernel work
> thread is started to send all the messages from the queue.

Can we handle the outbound messages queue in an upper layer thread, too, =
instead of a kernel thread in this low level driver?  I think if we =
provide more direct access to the hardware semantics of the message =
registers, we will end up with something like the following, which will =
also simplify the hardware driver.  Leave it to the upper layer to =
schedule message processing after receiving an event.

ntb_msg_event(): we received a hardware interrupt for messages. (don't =
read message status, or anything else)

ntb_msg_status_read(): read and return MSGSTS bitmask (like =
ntb_db_read()).
ntb_msg_status_clear(): clear bits in MSGSTS bitmask (like =
ntb_db_clear()).

ntb_msg_mask_set(): set bits in MSGSTSMSK (like ntb_db_mask_set()).
ntb_msg_mask_clear(): clear bits in MSGSTSMSK (like =
ntb_db_mask_clear()).

ntb_msg_recv(): read and return INMSG and INMSGSRC of the indicated =
message index.
ntb_msg_send(): write the outgoing message register with the message.

> If kernel thread failed to send
> a message (for instance, if the peer IDT NTB hardware driver still has =
not freed its
> inbound message registers), it performs a new attempt after a small =
timeout. If after a
> preconfigured number of attempts the kernel thread still fails to =
delivery the message, it
> invokes ntb_msg_event() callback with NTB_MSG_FAIL event. If the =
message is successfully
> delivered, then the method ntb_msg_event() is called with NTB_MSG_SENT =
event.

In other words, it was delivered to the peer NTB hardware, and the peer =
NTB hardware accepted the message into an available register.  It does =
not mean the peer application processed the message, or even that the =
peer driver received an interrupt for the message?

>=20
> To be clear the messsages are transfered directly to the peer memory, =
but instead they are
> placed in the IDT NTB switch registers, then peer is notified about a =
new message arrived
> at the corresponding message registers and the corresponding interrupt =
handler is called.
>=20
> If we loose the PCI express or NTB link between the IDT switch and a =
peer, then the
> ntb_msg_event() method is called with NTB_MSG_FAIL event.

Byzantine fault is an unsolvable class of problem, so it is important to =
be clear exactly what is supposed to be guaranteed at each layer.  If we =
get a hardware ACK that the message was delivered, that means it was =
delivered to the NTB hardware register, but no further.  If we do not =
get a hardware NAK(?), that means it was not delivered.  If the link =
fails or we time out waiting for a completion, we can only guess that it =
wasn't delivered even though there is a small chance it was.  =
Applications need to be tolerant either way, and needs may be different =
depending on the application.  I would rather not add any fault =
tolerance (other than reporting faults) at this layer that is not =
already implemented in the hardware.

Reading the description of OUTMSGSTS register, it is clear that we can =
receive a hardware NAK if an outgoing message failed.  It's not clear to =
me that IDT will notify any kind of ACK that an outgoing message was =
accepted.  If an application wants to send two messages, it can send the =
first, check the bit and see there is no failure.  Does reading the =
status immediately after sending guarantee the message WAS delivered =
(i.e. IDT NTB hardware blocks reading the status register while there =
are messages in flight)?  If not, if the application sends the second =
message and then sees a failure, how can the application be sure the =
failure is not for the first message?  Does the application have to wait =
some time (how long?) before checking the message status?

>=20
> Finally, I've answered to all the questions. Hopefully the things look =
clearer now.
>=20
> Regards,
> -Sergey


