Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x244.google.com (mail-lf0-x244.google.com. [2a00:1450:4010:c07::244])
        by gmr-mx.google.com with ESMTPS id y7si267645wmd.0.2016.08.18.14.56.10
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Aug 2016 14:56:10 -0700 (PDT)
Received: by mail-lf0-x244.google.com with SMTP id l89so2311709lfi.2
        for <linux-ntb@googlegroups.com>; Thu, 18 Aug 2016 14:56:10 -0700 (PDT)
Return-Path: <fancer.lancer@gmail.com>
Date: Fri, 19 Aug 2016 00:56:04 +0300
From: Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH v2 1/3] ntb: Add asynchronous devices support to NTB-bus
 interface
Message-ID: <20160818215604.GA19986@mobilestation>
References: <002201d1f1be$a24fe400$e6efac00$@emc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <002201d1f1be$a24fe400$e6efac00$@emc.com>
To: Allen Hubbe <Allen.Hubbe@emc.com>
Cc: jdmason@kudzu.us, dave.jiang@intel.com, Xiangliang.Yu@amd.com, Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

Hello Allen,
Sorry for the delay with response and thanks for thoughtful review.

On Mon, Aug 08, 2016 at 05:48:42PM -0400, Allen Hubbe <Allen.Hubbe@emc.com>=
 wrote:
> From: Serge Semin
> > Hello Allen.
> >=20
> > Thanks for your careful review. Going through this mailing thread I hop=
e we'll come up
> > with solutions, which improve the driver code as well as extend the Lin=
ux kernel support
> > of new devices like IDT PCIe-swtiches.
> >=20
> > Before getting to the inline commentaries I need to give some introduct=
ion to the IDT NTB-
> > related hardware so we could speak on the same language. Additionally I=
'll give a brief
> > explanation how the setup of memory windows works in IDT PCIe-switches.
>=20
> I found this to use as a reference for IDT:
> https://www.idt.com/document/man/89hpes24nt24g2-device-user-manual

Yes, it's supported by the IDT driver, although I am using a device with le=
sser number of ports:
https://www.idt.com/document/man/89hpes32nt8ag2-device-user-manual

>=20
> > First of all, before getting into the IDT NTB driver development I had =
made a research of
> > the currently developed NTB kernel API and AMD/Intel hardware drivers. =
Due to lack of the
> > hardware manuals It might be not in deep details, but I understand how =
the AMD/Intel NTB-
> > hardware drivers work. At least I understand the concept of memory wind=
owing, which led to
> > the current NTB bus kernel API.
> >=20
> > So lets get to IDT PCIe-switches. There is a whole series of NTB-relate=
d switches IDT
> > produces. All of them I split into two distinct groups:
> > 1) Two NTB-ported switches (models 89PES8NT2, 89PES16NT2, 89PES12NT3, 8=
9PES124NT3),
> > 2) Multi NTB-ported switches (models 89HPES24NT6AG2, 89HPES32NT8AG2, 89=
HPES32NT8BG2,
> > 89HPES12NT12G2, 89HPES16NT16G2, 89HPES24NT24G2, 89HPES32NT24AG2, 89HPES=
32NT24BG2).
> > Just to note all of these switches are a part of IDT PRECISE(TM) family=
 of PCI Express=EF=BF=BD
> > switching solutions. Why do I split them up? Because of the next reason=
s:
> > 1) Number of upstream ports, which have access to NTB functions (obviou=
sly, yeah? =3D)). So
> > the switches of the first group can connect just two domains over NTB. =
Unlike the second
> > group of switches, which expose a way to setup an interaction between s=
everal PCIe-switch
> > ports, which have NT-function activated.
> > 2) The groups are significantly distinct by the way of NT-functions con=
figuration.
> >=20
> > Before getting further, I should note, that the uploaded driver support=
s the second group
> > of devices only. But still I'll give a comparative explanation, since t=
he first group of
> > switches is very similar to the AMD/Intel NTBs.
> >=20
> > Lets dive into the configurations a bit deeper. Particularly NT-functio=
ns of the first
> > group of switches can be configured the same way as AMD/Intel NTB-funct=
ions are. There is
> > an PCIe end-point configuration space, which fully reflects the cross-c=
oupled local and
> > peer PCIe/NTB settings. So local Root complex can set any of the peer r=
egisters by direct
> > writing to mapped memory. Here is the image, which perfectly explains t=
he configuration
> > registers mapping:
> > https://s8.postimg.org/3nhkzqfxx/IDT_NTB_old_configspace.png
> > Since the first group switches connect only two root complexes, the rac=
e condition of
> > read/write operations to cross-coupled registers can be easily resolved=
 just by roles
> > distribution. So local root complex sets the translated base address di=
rectly to a peer
> > configuration space registers, which correspond to BAR0-BAR3 locally ma=
pped memory
> > windows. Of course 2-4 memory windows is enough to connect just two dom=
ains. That's why
> > you made the NTB bus kernel API the way it is.
> >=20
> > The things get different when one wants to have an access from one doma=
in to multiple
> > coupling up to eight root complexes in the second group of switches. Fi=
rst of all the
> > hardware doesn't support the configuration space cross-coupling anymore=
. Instead there are
> > two Global Address Space Access registers provided to have an access to=
 a peers
> > configuration space. In fact it is not a big problem, since there are n=
o much differences
> > in accessing registers over a memory mapped space or a pair of fixed Ad=
dress/Data
> > registers. The problem arises when one wants to share a memory windows =
between eight
> > domains. Five BARs are not enough for it even if they'd be configured t=
o be of x32 address
> > type. Instead IDT introduces Lookup table address translation. So BAR2/=
BAR4 can be
> > configured to translate addresses using 12 or 24 entries lookup tables.=
 Each entry can be
> > initialized with translated base address of a peer and IDT switch port,=
 which peer is
> > connected to. So when local root complex locally maps BAR2/BAR4, one ca=
n have an access to
> > a memory of a peer just by reading/writing with a shift corresponding t=
o the lookup table
> > entry. That's how more than five peers can be accessed. The root proble=
m is the way the
> > lookup table is accessed. Alas It is accessed only by a pair of "Entry =
index/Data"
> > registers. So a root complex must write an entry index to one registers=
, then read/write
> > data from another. As you might realise, that weak point leads to a rac=
e condition of
> > multiple root complexes accessing the lookup table of one shared peer. =
Alas I could not
> > come up with a simple and strong solution of the race.
>=20
> Right, multiple peers reaching across to some other peer's NTB configurat=
ion space is problematic.  I don't mean to suggest we should reach across t=
o configure the lookup table (or anything else) on a remote NTB.

Good, we settled this down.

>=20
> > That's why I've introduced the asynchronous hardware in the NTB bus ker=
nel API. Since
> > local root complex can't directly write a translated base address to a =
peer, it must wait
> > until a peer asks him to allocate a memory and send the address back us=
ing some of a
> > hardware mechanism. It can be anything: Scratchpad registers, Message r=
egisters or even
> > "crazy" doorbells bingbanging. For instance, the IDT switches of the fi=
rst group support:
> > 1) Shared Memory windows. In particular local root complex can set a tr=
anslated base
> > address to BARs of local and peer NT-function using the cross-coupled P=
CIe/NTB
> > configuration space, the same way as it can be done for AMD/Intel NTBs.
> > 2) One Doorbell register.
> > 3) Two Scratchpads.
> > 4) Four message regietsrs.
> > As you can see the switches of the first group can be considered as bot=
h synchronous and
> > asynchronous. All the NTB bus kernel API can be implemented for it incl=
uding the changes
> > introduced by this patch (I would do it if I had a corresponding hardwa=
re). AMD and Intel
> > NTBs can be considered both synchronous and asynchronous as well, altho=
ugh they don't
> > support messaging so Scratchpads can be used to send a data to a peer. =
Finally the
> > switches of the second group lack of ability to initialize BARs transla=
ted base address of
> > peers due to the race condition I described before.
> >=20
> > To sum up I've spent a lot of time designing the IDT NTB driver. I've d=
one my best to make
> > the IDT driver as much compatible with current design as possible, neve=
rtheless the NTB
> > bus kernel API had to be slightly changed. You can find answers to the =
commentaries down
> > below.
> >=20
> > On Fri, Aug 05, 2016 at 11:31:58AM -0400, Allen Hubbe <Allen.Hubbe@emc.=
com> wrote:
> > > From: Serge Semin
> > > > Currently supported AMD and Intel Non-transparent PCIe-bridges are =
synchronous
> > > > devices, so translated base address of memory windows can be direcl=
y written
> > > > to peer registers. But there are some IDT PCIe-switches which imple=
ment
> > > > complex interfaces using Lookup Tables of translation addresses. Du=
e to
> > > > the way the table is accessed, it can not be done synchronously fro=
m different
> > > > RCs, that's why the asynchronous interface should be developed.
> > > >
> > > > For these purpose the Memory Window related interface is correspond=
ingly split
> > > > as it is for Doorbell and Scratchpad registers. The definition of M=
emory Window
> > > > is following: "It is a virtual memory region, which locally reflect=
s a physical
> > > > memory of peer device." So to speak the "ntb_peer_mw_"-prefixed met=
hods control
> > > > the peers memory windows, "ntb_mw_"-prefixed functions work with th=
e local
> > > > memory windows.
> > > > Here is the description of the Memory Window related NTB-bus callba=
ck
> > > > functions:
> > > >  - ntb_mw_count() - number of local memory windows.
> > > >  - ntb_mw_get_maprsc() - get the physical address and size of the l=
ocal memory
> > > >                          window to map.
> > > >  - ntb_mw_set_trans() - set translation address of local memory win=
dow (this
> > > >                         address should be somehow retrieved from a =
peer).
> > > >  - ntb_mw_get_trans() - get translation address of local memory win=
dow.
> > > >  - ntb_mw_get_align() - get alignment of translated base address an=
d size of
> > > >                         local memory window. Additionally one can g=
et the
> > > >                         upper size limit of the memory window.
> > > >  - ntb_peer_mw_count() - number of peer memory windows (it can diff=
er from the
> > > >                          local number).
> > > >  - ntb_peer_mw_set_trans() - set translation address of peer memory=
 window
> > > >  - ntb_peer_mw_get_trans() - get translation address of peer memory=
 window
> > > >  - ntb_peer_mw_get_align() - get alignment of translated base addre=
ss and size
> > > >                              of peer memory window.Additionally one=
 can get the
> > > >                              upper size limit of the memory window.
> > > >
> > > > As one can see current AMD and Intel NTB drivers mostly implement t=
he
> > > > "ntb_peer_mw_"-prefixed methods. So this patch correspondingly rena=
mes the
> > > > driver functions. IDT NTB driver mostly expose "ntb_nw_"-prefixed m=
ethods,
> > > > since it doesn't have convenient access to the peer Lookup Table.
> > > >
> > > > In order to pass information from one RC to another NTB functions o=
f IDT
> > > > PCIe-switch implement Messaging subsystem. They currently support f=
our message
> > > > registers to transfer DWORD sized data to a specified peer. So ther=
e are two
> > > > new callback methods are introduced:
> > > >  - ntb_msg_size() - get the number of DWORDs supported by NTB funct=
ion to send
> > > >                     and receive messages
> > > >  - ntb_msg_post() - send message of size retrieved from ntb_msg_siz=
e()
> > > >                     to a peer
> > > > Additionally there is a new event function:
> > > >  - ntb_msg_event() - it is invoked when either a new message was re=
trieved
> > > >                      (NTB_MSG_NEW), or last message was successfull=
y sent
> > > >                      (NTB_MSG_SENT), or the last message failed to =
be sent
> > > >                      (NTB_MSG_FAIL).
> > > >
> > > > The last change concerns the IDs (practically names) of NTB-devices=
 on the
> > > > NTB-bus. It is not good to have the devices with same names in the =
system
> > > > and it brakes my IDT NTB driver from being loaded =3D) So I develop=
ed a simple
> > > > algorithm of NTB devices naming. Particulary it generates names "nt=
bS{N}" for
> > > > synchronous devices, "ntbA{N}" for asynchronous devices, and "ntbAS=
{N}" for
> > > > devices supporting both interfaces.
> > >
> > > Thanks for the work that went into writing this driver, and thanks fo=
r your patience
> > with the review.  Please read my initial comments inline.  I would like=
 to approach this
> > from a top-down api perspective first, and settle on that first before =
requesting any
> > specific changes in the hardware driver.  My major concern about these =
changes is that
> > they introduce a distinct classification for sync and async hardware, s=
upported by
> > different sets of methods in the api, neither is a subset of the other.
> > >
> > > You know the IDT hardware, so if any of my requests below are infeasi=
ble, I would like
> > your constructive opinion (even if it means significant changes to exis=
ting drivers) on
> > how to resolve the api so that new and existing hardware drivers can be=
 unified under the
> > same api, if possible.
> >=20
> > I understand your concern. I have been thinking of this a lot. In my op=
inion the proposed
> > in this patch alterations are the best of all variants I've been thinki=
ng about. Regarding
> > the lack of APIs subset. In fact I would not agree with that. As I desc=
ribed in the
> > introduction AMD and Intel drivers can be considered as both synchronou=
s and asynchronous,
> > since a translated base address can be directly set in a local and peer=
 configuration
> > space. Although AMD and Intel devices don't support messaging, they hav=
e Scratchpads,
> > which can be used to exchange an information between root complexes. Th=
e thing we need to
> > do is to implement ntb_mw_set_trans() and ntb_mw_get_align() for them. =
Which isn't much
> > different from the "mw_peer"-prefixed ones. The first method just sets =
a translated base
> > address to the corresponding local register. The second one does exactl=
y the same as
> > "mw_peer"-prefixed ones. I would do it, but I haven't got a hardware to=
 test, that's why I
> > left things the way it was with just slight changes of names.
>=20
> It sounds like the purpose of your ntb_mw_set_trans() [what I would call =
ntb_peer_mw_set_trans()] is similar to what is done at initialization time =
in the Intel NTB driver, so that outgoing writes are translated to the corr=
ect peer NTB BAR.  The difference is that IDT outgoing translation sets not=
 only the peer NTB address but also the port number in the translation.
> http://lxr.free-electrons.com/source/drivers/ntb/hw/intel/ntb_hw_intel.c?=
v=3D4.7#L1673
>=20
> It would be interesting to allow ntb clients to change this translation, =
eg, configure an outgoing write from local BAR23 so it hits peer secondary =
BAR45.  I don't think e.g. Intel driver should be forced to implement that,=
 but it would be interesting to think of unifying the api with that in mind.

I already said I'm not an expert of Intel and AMD hardware, moreover I don'=
t even have any
reference manual to study it. But from the first glance it's not. It doesn'=
t concern any
of peer BARs. As far as I can judge by the Intel driver code, the initializ=
ation code
specifies some fixed translation address so to get access to some memory sp=
ace of a remote
bridge. According to my observation b2b configuration looks more like so ca=
lled Punch-through
configuration in the IDT definitions. It's when two bridges are connected t=
o each other.
But I may be wrong. Although it doesn't matter at the moment.

It's much easier to explain how it works using an illustrations, otherwise =
we'll be discussing
this matter forever.

Lets start from definition what Memory Window mean. As I already said: "Mem=
ory Window is a
virtual memory region, which locally reflects a physical memory of peer/rem=
ote device."

Next suppose we've got two 32-bits Root Complexes (RC0 and RC1) connected t=
o each other over
an NTB. It doesn't matter whether it's an IDT or Intel/AMD like NTBs. The N=
TB device has two
ports: Pn and Pm, each port is connected to its own Root Complex. There are=
 doorbells,
scratchpads, and of course memory windows. Each Root Complex allocates a me=
mory buffer:
Buffer A and Buffer B. Additionally RC0 and RC1 maps memory windows at the =
corresponding
addresses: MW A and MW B. Here is how it schematically looks:
https://s3.postimg.org/so3zg0car/memory_windows_before.jpg

According to your NTB Kernel API naming (see the figure), methods are suppo=
sed to be
syntactically split into two: with "ntb_peer_" prefix and without one. And =
they are correctly
split for doorbells and scratchpads, but when it comes to memory windows, t=
he method names
syntax is kind of messed up.

Keeping in mind the definition of memory windows I introduced before, your =
ntb_mw_*_trans()
methods set/get translation base address to "BARm XLAT", so the ones memory=
 window would be
correctly connected with Buffer A. But the function doesn't have "ntb_peer_=
mw" prefix, which
does look confusing, since it works with peer configuration registers, part=
icularly with the
peer translation address of BARm - MW B.

Finally your ntb_mw_get_range() returns information about two opposite side=
s.
"Alignment"-related arguments return align of translated base address of th=
e peer, but "base"
and "size" arguments are related with virtual address of the local memory w=
indow, which has
nothing related with the peer memory window and its translated base address.

My idea was to fix this syntax incorrectness, so the memory windows NTB Ker=
nel API would look
the same way as doorbell and scratchpad ones. Here is the illustration, how=
 it works now:
https://s3.postimg.org/52mvtfpgz/memory_windows_after.jpg

As you can see, the "ntb_peer_mw_" prefixed methods are related with the pe=
er configurations
only, so ntb_peer_mw_*_trans() set/get translation base address of the peer=
 memory windows
and ntb_peer_mw_get_align() return alignment of that address. Methods with =
no "ntb_peer_mw_"
prefix, do the same thing but with translation address of the local memory =
window.
Additionally ntb_mw_get_maprsc() return a physical address of local memory =
window to=20
correspondingly map it.

In the same way the Memory Window API can be split into synchronous, asynch=
ronous and both.
If hardware (like Intel/AMD) allows to implement "ntb_peer_mw" prefixed met=
hods (see methods
marked with blue ink on the last figure), then it is considered synchronous=
, since it can
directly specify translation base addresses to the peer memory windows. If =
hardware supports
the "ntb_mw" prefixed methods only (purple ink on the figure), then it is c=
onsidered as
asynchronous, so a client driver must somehow retrieve a translation addres=
s for local
memory window. Method ntb_mw_get_maprsc() must be supported by both hardwar=
e (it is marked
with green ink). Of course there are hardware, which can support both synch=
ronous and
asynchronous API, like Intel/AMD. IDT PCIe-bridge doesn't safely support it=
 since Lookup
translation tables access method.

I hope we got it settled now. If not, We can have a Skype conversation, sin=
ce writing such a
long letters takes lot of time.

>=20
> >=20
> > > > Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> > > >
> > > > ---
> > > >  drivers/ntb/Kconfig                 |   4 +-
> > > >  drivers/ntb/hw/amd/ntb_hw_amd.c     |  49 ++-
> > > >  drivers/ntb/hw/intel/ntb_hw_intel.c |  59 +++-
> > > >  drivers/ntb/ntb.c                   |  86 +++++-
> > > >  drivers/ntb/ntb_transport.c         |  19 +-
> > > >  drivers/ntb/test/ntb_perf.c         |  16 +-
> > > >  drivers/ntb/test/ntb_pingpong.c     |   5 +
> > > >  drivers/ntb/test/ntb_tool.c         |  25 +-
> > > >  include/linux/ntb.h                 | 600 ++++++++++++++++++++++++=
+++++-------
> > > >  9 files changed, 701 insertions(+), 162 deletions(-)
> > > >
>=20
>=20
> > > > -		rc =3D ntb_mw_get_range(ndev, i, &mw->phys_addr, &mw->phys_size,
> > > > -				      &mw->xlat_align, &mw->xlat_align_size);
> > > > +		rc =3D ntb_mw_get_maprsc(ndev, i, &mw->phys_addr, &mw->phys_size=
);
> > > > +		if (rc)
> > > > +			goto err1;
> > > > +
> > > > +		rc =3D ntb_peer_mw_get_align(ndev, i, &mw->xlat_align,
> > > > +					   &mw->xlat_align_size, NULL);
> > >
> > > Looks like ntb_mw_get_range() was simpler before the change.
> > >
> >=20
> > If I didn't change NTB bus kernel API, I would have split them up anywa=
y. First of all
> > functions with long argument list look more confusing, than ones with s=
horter list. It
> > helps to stick to the "80 character per line" rule and improves readabi=
lity. Secondly the
> > function splitting improves the readability of the code in general. Whe=
n I first saw the
> > function name "ntb_mw_get_range()", it was not obvious what kind of ran=
ges this function
> > returned. The function lacked of "high code coherence" unofficial rule.=
 It is better when
> > one function does one coherent thing and return a well coherent data. P=
articularly
> > function "ntb_mw_get_range()" returned a local memory windows mapping a=
ddress and size, as
> > well as alignment of memory allocated for a peer. So now "ntb_mw_get_ma=
prsc()" method
> > returns mapping resources. If local NTB client driver is not going to a=
llocate any memory,
> > so one just doesn't need to call "ntb_peer_mw_get_align()" method at al=
l. I understand,
> > that a client driver could pass NULL to a unused arguments of the "ntb_=
mw_get_range()",
> > but still the new design is better readable.
> >=20
> > Additionally I've split them up because of the difference in the way th=
e asynchronous
> > interface works. IDT driver can not safely perform ntb_peer_mw_set_tran=
s(), that's why I
> > had to add ntb_mw_set_trans(). Each of that method should logically hav=
e related
> > "ntb_*mw_get_align()" method. Method ntb_mw_get_align() shall give to a=
 local client
> > driver a hint how the retrieved from the peer translated base address s=
hould be aligned,
> > so ntb_mw_set_trans() method would successfully return. Method ntb_peer=
_mw_get_align()
> > will give a hint how the local memory buffer should be allocated to ful=
fil a peer
> > translated base address alignment. In this way it returns restrictions =
for parameters of
> > "ntb_peer_mw_set_trans()".
> >=20
> > Finally, IDT driver is designed so Primary and Secondary ports can supp=
ort a different
> > number of memory windows. In this way methods
> > "ntb_mw_get_maprsc()/ntb_mw_set_trans()/ntb_mw_get_trans()/ntb_mw_get_a=
lign()" have
> > different range of acceptable values of the second argument, which is d=
etermined by the
> > "ntb_mw_count()" method, comparing to methods
> > "ntb_peer_mw_set_trans()/ntb_peer_mw_get_trans()/ntb_peer_mw_get_align(=
)", which memory
> > windows index restriction is determined by the "ntb_peer_mw_count()" me=
thod.
> >=20
> > So to speak the splitting was really necessary to make the API looking =
more logical.
>=20
> If this change is not required by the new hardware, please submit the cha=
nge as a separate patch.
>=20

It's required. See the previous comment.

> > > > +	/* Synchronous hardware is only supported */
> > > > +	if (!ntb_valid_sync_dev_ops(ntb)) {
> > > > +		return -EINVAL;
> > > > +	}
> > > > +
> > >
> > > It would be nice if both types could be supported by the same api.
> > >
> >=20
> > Yes, it would be. Alas it isn't possible in general. See the introducti=
on to this letter.
> > AMD and Intel devices support asynchronous interface, although they lac=
k of messaging
> > mechanism.
>=20
> What is the prototypical application of the IDT message registers?
>=20
> I'm thinking they will be the first thing available to drivers, and so on=
e primary purpose will be to exchange information for configuring memory wi=
ndows.  Can you describe how a cluster of eight nodes would discover each o=
ther and initialize?
>=20
> Are they also intended to be useful beyond memory window initialization? =
 How should they be used efficiently, so that the application can minimize =
in particular read operations on the pci bus (reading ntb device registers)=
?  Or are message registers not intended to be used in low latency communic=
ations (for that, use doorbells and memory instead)?
>=20

The prototypical application of the message registers is to exchange a smal=
l portion of
information, like translation base address for example. Imagine IDT hardwar=
e provides just
four 32-bits wide message registers. So a driver software can transfer a me=
ssage ID, memory
window index and a translation address using such a small buffer. The messa=
ge registers can't
be efficiently used for exchanging of any bigger data. One should use doorb=
ells and memory
windows instead.

I'm not a mind reader, but still supposably IDT provided them as a synchron=
ous exchange of
Scratchpads. Message registers are designed so it's impossible to send a me=
ssage to a peer
before one read a previous message. Such a design is really helpful when we=
 need to connect
few different nodes and pass information between each other. Scratchpads wo=
uld lead to too
much complications.

> >=20
> > Getting back to the discussion, we still need to provide a way to deter=
mine which type of
> > interface an NTB device supports: synchronous/asynchronous translated b=
ase address
> > initialization, Scratchpads and memory windows. Currently it can be det=
ermined by the
> > functions ntb_valid_sync_dev_ops()/ntb_valid_async_dev_ops(). I underst=
and, that it's not
> > the best solution. We can implement the traditional Linux kernel bus de=
vice-driver
> > matching, using table_ids and so on. For example, each hardware driver =
fills in a table
> > with all the functionality it supports, like: synchronous/asynchronous =
memory windows,
> > Doorbells, Scratchpads, Messaging. Then driver initialize a table of fu=
nctionality it
> > uses. NTB bus core implements a "match()" callback, which compares thos=
e two tables and
> > calls "probe()" callback method of a driver when the tables successfull=
y matches.
> >=20
> > On the other hand, we might don't have to comprehend the NTB bus core. =
We can just
> > introduce a table_id for NTB hardware device, which would just describe=
 the device vendor
> > itself, like "ntb,amd", "ntb,intel", "ntb,idt" and so on. Client driver=
 will declare a
> > supported device by its table_id. It might look easier, since
>=20
> emphasis added:
>=20
> > the client driver developer
> > should have a basic understanding of the device one develops a driver f=
or.
>=20
> This is what I'm hoping to avoid.  I would like to let the driver develop=
er write for the api, not for the specific device.  I would rather the driv=
er check "if feature x is supported" instead of "this is a sync or async de=
vice."
>=20

Ok. We can implement "features checking methods" like:
ntb_valid_link_ops(),
ntb_valid_peer_db_ops(),
ntb_valid_db_ops(),
ntb_valid_peer_spad_ops(),
ntb_valid_spad_ops(),
ntb_valid_msg_ops(),
ntb_valid_peer_mw_ops(),
ntb_valid_mw_ops().

But I am not fan of calling all of those methods in every client drivers. I=
 would rather develop
an "NTB Device - Client Driver" matching method in the framework of NTB bus=
. For example,
developer creates a client driver using Doorbells (ntb_valid_peer_db_ops/nt=
b_valid_db_ops),
Messages (ntb_valid_msg_ops) and Memory Windows (ntb_valid_peer_mw_ops/ntb_=
valid_mw_ops). Then one
declares that the driver requires the corresponding features, somewhere in =
the struct ntb_client,
like it's usually done in the "compatible" fields of matching id_tables of =
drivers (see SPI, PCI,
i2c and others), but we would call it like "feature_table" with "compatible=
" fields. Of course
every hardware driver would declare, which kind of features one supports. T=
hen the NTB bus
"match()" callback method checks whether the registered device supports all=
 features the client
driver claims. If it does, then and only then the "probe()" method of the c=
lient driver is called.

Of course, it's your decision which design to use, I am just giving a possi=
ble solutions. But the
last one gives better unification with general "Bus - Device - Driver" desi=
gn of the Linux Kernel.

> > Then NTB bus
> > kernel API core will simply match NTB devices with drivers like any oth=
er buses (PCI,
> > PCIe, i2c, spi, etc) do.
> >=20
>=20
> > > > -static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops *o=
ps)
> > > > +static inline int ntb_valid_sync_dev_ops(const struct ntb_dev *ntb)
> > > > +static inline int ntb_valid_async_dev_ops(const struct ntb_dev *nt=
b)
> > >
> > > I understand why IDT requires a different api for dealing with addres=
sing multiple
> > peers.  I would be interested in a solution that would allow, for examp=
le, the Intel
> > driver fit under the api for dealing with multiple peers, even though i=
t only supports one
> > peer.  I would rather see that, than two separate apis under ntb.
> > >
> > > Thoughts?
> > >
> > > Can the sync api be described by some subset of the async api?  Are t=
here less
> > overloaded terms we can use instead of sync/async?
> > >
> >=20
> > Answer to this concern is mostly provided in the introduction as well. =
I'll repeat it here
> > in details. As I said AMD and Intel hardware support asynchronous API e=
xcept the
> > messaging. Additionally I can even think of emulating messaging using D=
oorbells and
> > Scratchpads, but not the other way around. Why not? Before answering, h=
ere is how the
> > messaging works in IDT switches of both first and second groups (see in=
troduction for
> > describing the groups).
> >=20
> > There are four outbound and inbound message registers for each NTB port=
 in the device.
> > Local root complex can connect its any outbound message to any inbound =
message register of
> > the IDT switch. When one writes a data to an outbound message register =
it immediately gets
> > to the connected inbound message registers. Then peer can read its inbo=
und message
> > registers and empty it by clearing a corresponding bit. Then and only t=
hen next data can
> > be written to any outbound message registers connected to that inbound =
message register.
> > So the possible race condition between multiple domains sending a messa=
ge to same peer is
> > resolved by the IDT switch itself.
> >=20
> > One would ask: "Why don't you just wrap the message registers up back t=
o the same port? It
> > would look just like Scratchpads." Yes, It would. But still there are o=
nly four message
> > registers. It's not enough to distribute them between all the possibly =
connected NTB
> > ports. As I said earlier there can be up to eight domains connected, so=
 there must be at
> > least seven message register to fulfil the possible design.
> >=20
> > Howbeit all the emulations would look ugly anyway. In my opinion It's b=
etter to slightly
> > adapt design for a hardware, rather than hardware to a design. Followin=
g that rule would
> > simplify a code and support respectively.
> >=20
> > Regarding the APIs subset. As I said before async API is kind of subset=
 of synchronous
> > API. We can develop all the memory window related callback-method for A=
MD and Intel
> > hardware driver, which is pretty much easy. We can even simulate messag=
e registers by
> > using Doorbells and Scratchpads, which is not that easy, but possible. =
Alas the second
> > group of IDT switches can't implement the synchronous API, as I already=
 said in the
> > introduction.
>=20
> Message registers operate fundamentally differently from scratchpads (and=
 doorbells, for that matter).  I think we are in agreement.  It's a pain, b=
ut maybe the best we can do is require applications to check for support fo=
r scratchpads, message registers, and/or doorbells, before using any of tho=
se features.  We already have ntb_db_valid_mask() and ntb_spad_count().
>=20

Yes they do. And yes, the client drivers must somehow check whether a match=
ing NTB device
supports all the features they need. See the previous comment how I suppose=
 it can be done.

> I would like to see ntb_msg_count() and more direct access to the message=
 registers in this api.  I would prefer to see the more direct access to ha=
rdware message registers, instead of work_struct for message processing in =
the low level hardware driver.  A more direct interface to the hardware reg=
isters would be more like the existing ntb.h api: direct and low-overhead a=
s possible, providing minimal abstraction of the hardware functionality.
>=20
> I think there is still hope we can unify the memory window interface.  Ev=
en though IDT supports things like subdividing the memory windows with tabl=
e lookup, and specification of destination ports for outgoing translations,=
 I think we can support the same abstraction in the existing drivers with m=
inimal overhead.
>=20
> For existing Intel and AMD drivers, there may be only one translation per=
 memory window (there is no table to subdivide the memory window), and ther=
e is only one destination port (the peer).  The Intel and AMD drivers can i=
gnore the table index in setting up the translation (or validate that the r=
equested table index is equal to zero).
>=20

In fact we don't need to introduce any of the table index, because the tabl=
e index you are
talking about is just one peer. Since it is just a peer, then it must refer=
 to a particular
device on the Linux NTB bus. For instance we got eight NTB ports on IDT PCI=
e-bridge, one
of them is the Primary port. Then Root Complex connected to the Primary por=
t will have seven
devices on Linux NTB bus. Such design perfectly fits to your NTB Kernel API=
 and additionally
will cover all the client driver needs. In this case Primary NTB port would=
 be like an SPI, i2c
adapters or PCI root complex itself with respect to their subsidiary buses.

That's how the IDT hardware driver is designed. It gives transparent operat=
ions with NTB
kernel API.

> > Regarding the overloaded naming. The "sync/async" names are the best I =
could think of. If
> > you have any idea how one can be appropriately changed, be my guest. I =
would be really
> > glad to substitute them with something better.
> >=20
>=20
> Let's try to avoid a distinction, first, beyond just saying "not all hard=
ware will support all these features."  If we absolutely have to make a dis=
tinction, let's think of better names then.
>=20

Ok. We can stick to "featured" hardware. It sounds better.

> > > > + * ntb_msg_event() - notify driver context of event in messaging s=
ubsystem
> > > >   * @ntb:	NTB device context.
> > > > + * @ev:		Event type caused the handler invocation
> > > > + * @msg:	Message related to the event
> > > > + *
> > > > + * Notify the driver context that there is some event happaned in =
the event
> > > > + * subsystem. If NTB_MSG_NEW is emitted then the new message has j=
ust arrived.
> > > > + * NTB_MSG_SENT is rised if some message has just been successfull=
y sent to a
> > > > + * peer. If a message failed to be sent then NTB_MSG_FAIL is emitt=
ed. The very
> > > > + * last argument is used to pass the event related message. It dis=
carded right
> > > > + * after the handler returns.
> > > > + */
> > > > +void ntb_msg_event(struct ntb_dev *ntb, enum NTB_MSG_EVENT ev,
> > > > +		   struct ntb_msg *msg);
> > >
> > > I would prefer to see a notify-and-poll api (like NAPI).  This will a=
llow scheduling of
> > the message handling to be done more appropriately at a higher layer of=
 the application.
> > I am concerned to see inmsg/outmsg_work in the new hardware driver [PAT=
CH 2/3], which I
> > think would be more appropriate for a ntb transport (or higher layer) d=
river.
> > >
> >=20
> > Hmmm, that's how it's done.) MSI interrupt is raised when a new message=
 arrived into a
> > first inbound message register (the rest of message registers are used =
as an additional
> > data buffers). Then a corresponding tasklet is started to release a har=
dware interrupt
> > context. That tasklet extracts a message from the inbound message regis=
ters, puts it into
> > the driver inbound message queue and marks the registers as empty so th=
e next message
> > could be retrieved. Then tasklet starts a corresponding kernel work thr=
ead delivering all
> > new messages to a client driver, which preliminary registered "ntb_msg_=
event()" callback
> > method. When callback method "ntb_msg_event()" the passed message is di=
scarded.
>=20
> When an interrupt arrives, can you signal the upper layer that a message =
has arrived, without delivering the message?  I think the lower layer can d=
o without the work structs, instead have the same body of the work struct r=
un in the context of the upper layer polling to receive the message.
>=20

Of course we can. I could create a method like ntb_msg_read() instead of pa=
ssing a message to the
callback, but I didn't do so because if next message interrupt arrives whil=
e the previous message
still has not been read, how a client driver would find out which message c=
aused the last
interrupt? Thats why I prefer to pass the new message to the callback, so i=
f a client drivers wants
to keep track of all the received methods, then it can create it's own queu=
e.

Regarding the rest of the comment. The upper layer will have to implement t=
he work struct anyway.
Why do we need to copy that code everywhere if it can be common for all the=
 drivers? Still keep in
mind, that the incoming message registers is the register, that must be fre=
ed as fast as possible,
since another peer device can be waiting for it to be freed. So it's better=
 to read it in the
hardware driver, than to let it being done by the unreliable client.

> > > It looks like there was some rearranging of code, so big hunks appear=
 to be added or
> > removed.  Can you split this into two (or more) patches so that rearran=
ging the code is
> > distinct from more interesting changes?
> > >
> >=20
> > Lets say there was not much rearranging here. I've just put link-relate=
d method before
> > everything else. The rearranging was done from the point of methods imp=
ortance view. There
> > can't be any memory sharing and doorbells operations done before the li=
nk is established.
> > The new arrangements is reflected in ntb_valid_sync_dev_ops()/ntb_valid=
_async_dev_ops()
> > methods.
>=20
> It's unfortunate how the diff captured the changes.  Can you split this u=
p into smaller patches?
>=20

Lets settle the rest of the things down before doing this. If we don't then=
 it would be just
a waste of time.

> > > > - * ntb_mw_get_range() - get the range of a memory window
> > > > + * ntb_mw_get_maprsc() - get the range of a memory window to map
> > >
> > > What was insufficient about ntb_mw_get_range() that it needed to be s=
plit into
> > ntb_mw_get_maprsc() and ntb_mw_get_align()?  In all the places that I f=
ound in this patch,
> > it seems ntb_mw_get_range() would have been more simple.
> > >
> > > I didn't see any use of ntb_mw_get_mapsrc() in the new async test cli=
ents [PATCH 3/3].
> > So, there is no example of how usage of new api would be used different=
ly or more
> > efficiently than ntb_mw_get_range() for async devices.
> > >
> >=20
> > This concern is answered a bit earlier, when you first commented the me=
thod
> > "ntb_mw_get_range()" splitting.
> >=20
> > You could not find the "ntb_mw_get_mapsrc()" method usage because you m=
isspelled it. The
> > real method signature is "ntb_mw_get_maprsc()" (look more carefully at =
the name ending),
> > which is decrypted as "Mapping Resources", but no "Mapping Source". ntb=
/test/ntb_mw_test.c
> > driver is developed to demonstrate how the new asynchronous API is util=
ized including the
> > "ntb_mw_get_maprsc()" method usage.
>=20
> Right, I misspelled it.  It would be easier to catch a misspelling of rag=
ne.
>=20
> [PATCH v2 3/3]:
> +		/* Retrieve the physical address of the memory to map */
> +		ret =3D ntb_mw_get_maprsc(ntb, mwindx, &outmw->phys_addr,
> +			&outmw->size);
> +		if (SUCCESS !=3D ret) {
> +			dev_err_mw(ctx, "Failed to get map resources of "
> +				"outbound window %d", mwindx);
> +			mwindx--;
> +			goto err_unmap_rsc;
> +		}
> +
> +		/* Map the memory window resources */
> +		outmw->virt_addr =3D ioremap_nocache(outmw->phys_addr, outmw->size);
> +
> +		/* Retrieve the memory windows maximum size and alignments */
> +		ret =3D ntb_mw_get_align(ntb, mwindx, &outmw->addr_align,
> +			&outmw->size_align, &outmw->size_max);
> +		if (SUCCESS !=3D ret) {
> +			dev_err_mw(ctx, "Failed to get alignment options of "
> +				"outbound window %d", mwindx);
> +			goto err_unmap_rsc;
> +		}
>=20
> It looks to me like ntb_mw_get_range() would have been sufficient here.  =
If the change is required by the new driver, please show evidence of that. =
 If this change is not required by the new hardware, please submit the chan=
ge as a separate patch.
>=20

Please, see the comments before.

> > > I think ntb_peer_mw_set_trans() and ntb_mw_set_trans() are backwards.=
  Does the
> > following make sense, or have I completely misunderstood something?
> > >
> > > ntb_mw_set_trans(): set up translation so that incoming writes to the=
 memory window are
> > translated to the local memory destination.
> > >
> > > ntb_peer_mw_set_trans(): set up (what exactly?) so that outgoing writ=
es to a peer memory
> > window (is this something that needs to be configured on the local ntb?=
) are translated to
> > the peer ntb (i.e. their port/bridge) memory window.  Then, the peer's =
setting of
> > ntb_mw_set_trans() will complete the translation to the peer memory des=
tination.
> > >
> >=20
> > These functions actually do the opposite you described:
>=20
> That's the point.  I noticed that they are opposite.
>=20
> > ntb_mw_set_trans() - method sets the translated base address retrieved =
from a peer, so
> > outgoing writes to a memory window would be translated and reach the pe=
er memory
> > destination.
>=20
> In other words, this affects the translation of writes in the direction o=
f the peer memory.  I think this should be named ntb_peer_mw_set_trans().
>=20

Please, see the big comment with illustrations provided before.

> > ntb_peer_mw_set_trans() - method sets translated base address to peer c=
onfiguration space,
> > so the local incoming writes would be correctly translated on the peer =
and reach the local
> > memory destination.
>=20
> In other words, this affects the translation for writes in the direction =
of local memory.  I think this should be named ntb_mw_set_trans().
>=20

Please, see the big comment with illustrations provided before.

> > Globally thinking, these methods do the same think, when they called fr=
om opposite
> > domains. So to speak locally called "ntb_mw_set_trans()" method does th=
e same thing as the
> > method "ntb_peer_mw_set_trans()" called from a peer, and vise versa the=
 locally called
> > method "ntb_peer_mw_set_trans()" does the same procedure as the method
> > "ntb_mw_set_trans()" called from a peer.
> >=20
> > To make things simpler, think of memory windows in the framework of the=
 next definition:
> > "Memory Window is a virtual memory region, which locally reflects a phy=
sical memory of
> > peer/remote device." So when we call ntb_mw_set_trans(), we initialize =
the local memory
> > window, so the locally mapped virtual addresses would be connected with=
 the peer physical
> > memory. When we call ntb_peer_mw_set_trans(), we initialize a peer/remo=
te virtual memory
> > region, so the peer could successfully perform a writes to our local ph=
ysical memory.
> >=20
> > Of course all the actual memory read/write operations should follow up =
ntb_mw_get_maprsc()
> > and ioremap_nocache() method invocation doublet. You do the same thing =
in the client test
> > drivers for AMD and Intel hadrware.
> >=20
>=20
> > > >  /**
> > > > @@ -751,6 +1053,8 @@ static inline int ntb_db_clear_mask(struct ntb=
_dev *ntb, u64
> > db_bits)
> > > >   * append one additional dma memory copy with the doorbell registe=
r as the
> > > >   * destination, after the memory copy operations.
> > > >   *
> > > > + * This is unusual, and hardware may not be suitable to implement =
it.
> > > > + *
> > >
> > > Why is this unusual?  Do you mean async hardware may not support it?
> > >
> >=20
> > Of course I can always return an address of a Doorbell register, but it=
's not safe to do
> > it working with IDT NTB hardware driver. To make thing explained simple=
r think a IDT
> > hardware, which supports the Doorbell bits routing. Each local inbound =
Doorbell bits of
> > each port can be configured to either reflect the global switch doorbel=
l bits state or not
> > to reflect. Global doorbell bits are set by using outbound doorbell reg=
ister, which is
> > exist for every NTB port. Primary port is the port which can have an ac=
cess to multiple
> > peers, so the Primary port inbound and outbound doorbell registers are =
shared between
> > several NTB devices, sited on the linux kernel NTB bus. As you understa=
nd, these devices
> > should not interfere each other, which can happen on uncontrollable usa=
ge of Doorbell
> > registers addresses. That's why the method cou "ntb_peer_db_addr()" sho=
uld not be
> > developed for the IDT NTB hardware driver.
>=20
> I misread the diff as if this comment was added to the description of ntb=
_db_clear_mask().
>=20
> > > > +	if (!ntb->ops->spad_count)
> > > > +		return -EINVAL;
> > > > +
> > >
> > > Maybe we should return zero (i.e. there are no scratchpads).
> > >
> >=20
> > Agreed. I will fix it in the next patchset.
>=20
> Thanks.
>=20
> > > > +	if (!ntb->ops->spad_read)
> > > > +		return 0;
> > > > +
> > >
> > > Let's return ~0.  I think that's what a driver would read from the pc=
i bus for a memory
> > miss.
> > >
> >=20
> > Agreed. I will make it returning -EINVAL in the next patchset.
>=20
> I don't think we should try to interpret the returned value as an error n=
umber.  If the driver supports this method, and this is a valid scratchpad,=
 the peer can put any value in i, including a value that could be interpret=
ed as an error number.
>=20
> A driver shouldn't be using this method if it isn't supported.  But if it=
 does, I think ~0 is a better poison value than 0.  I just don't want to en=
courage drivers to try to interpret this value as an error number.
>=20

Understood. The method will return ~0 in the next patchset.

> > > > +	if (!ntb->ops->peer_spad_read)
> > > > +		return 0;
> > >
> > > Also, ~0?
> > >
> >=20
> > Agreed. I will make it returning -EINVAL in the next patchset.
>=20
> I don't think we should try to interpret the returned value as an error n=
umber.
>=20

Understood. The method will return ~0 in the next patchset.

> > > > + * ntb_msg_post() - post the message to the peer
> > > > + * @ntb:	NTB device context.
> > > > + * @msg:	Message
> > > > + *
> > > > + * Post the message to a peer. It shall be delivered to the peer b=
y the
> > > > + * corresponding hardware method. The peer should be notified abou=
t the new
> > > > + * message by calling the ntb_msg_event() handler of NTB_MSG_NEW e=
vent type.
> > > > + * If delivery is fails for some reasong the local node will get N=
TB_MSG_FAIL
> > > > + * event. Otherwise the NTB_MSG_SENT is emitted.
> > >
> > > Interesting.. local driver would be notified about completion (succes=
s or failure) of
> > delivery.  Is there any order-of-completion guarantee for the completio=
n notifications?
> > Is there some tolerance for faults, in case we never get a completion n=
otification from
> > the peer (eg. we lose the link)?  If we lose the link, report a local f=
ault, and the link
> > comes up again, can we still get a completion notification from the pee=
r, and how would
> > that be handled?
> > >
> > > Does delivery mean the application has processed the message, or is i=
t just delivery at
> > the hardware layer, or just delivery at the ntb hardware driver layer?
> > >
> >=20
> > Let me explain how the message delivery works. When a client driver cal=
ls the
> > "ntb_msg_post()" method, the corresponding message is placed in an outb=
ound messages
> > queue. Such the message queue exists for every peer device. Then a dedi=
cated kernel work
> > thread is started to send all the messages from the queue.
>=20
> Can we handle the outbound messages queue in an upper layer thread, too, =
instead of a kernel thread in this low level driver?  I think if we provide=
 more direct access to the hardware semantics of the message registers, we =
will end up with something like the following, which will also simplify the=
 hardware driver.  Leave it to the upper layer to schedule message processi=
ng after receiving an event.
>=20
> ntb_msg_event(): we received a hardware interrupt for messages. (don't re=
ad message status, or anything else)
>=20
> ntb_msg_status_read(): read and return MSGSTS bitmask (like ntb_db_read()=
).
> ntb_msg_status_clear(): clear bits in MSGSTS bitmask (like ntb_db_clear()=
).
>=20
> ntb_msg_mask_set(): set bits in MSGSTSMSK (like ntb_db_mask_set()).
> ntb_msg_mask_clear(): clear bits in MSGSTSMSK (like ntb_db_mask_clear()).
>=20
> ntb_msg_recv(): read and return INMSG and INMSGSRC of the indicated messa=
ge index.
> ntb_msg_send(): write the outgoing message register with the message.
>=20

I think such an API would make the interface too complicated. The messaging=
 is intended to be
simple for just sharing a small amount of information. Primarily for sendin=
g a translation
address. I would prefer to leave API as it is, since it covers all the appl=
ication needs.

> > If kernel thread failed to send
> > a message (for instance, if the peer IDT NTB hardware driver still has =
not freed its
> > inbound message registers), it performs a new attempt after a small tim=
eout. If after a
> > preconfigured number of attempts the kernel thread still fails to deliv=
ery the message, it
> > invokes ntb_msg_event() callback with NTB_MSG_FAIL event. If the messag=
e is successfully
> > delivered, then the method ntb_msg_event() is called with NTB_MSG_SENT =
event.
>=20
> In other words, it was delivered to the peer NTB hardware, and the peer N=
TB hardware accepted the message into an available register.  It does not m=
ean the peer application processed the message, or even that the peer drive=
r received an interrupt for the message?
>=20

Of course it doesn't mean, that the application processed the message, but =
it does mean that the
peer hardware raised the MSI interrupt, if the interrupt was enabled.

> >=20
> > To be clear the messsages are transfered directly to the peer memory, b=
ut instead they are
> > placed in the IDT NTB switch registers, then peer is notified about a n=
ew message arrived
> > at the corresponding message registers and the corresponding interrupt =
handler is called.
> >=20
> > If we loose the PCI express or NTB link between the IDT switch and a pe=
er, then the
> > ntb_msg_event() method is called with NTB_MSG_FAIL event.
>=20
> Byzantine fault is an unsolvable class of problem, so it is important to =
be clear exactly what is supposed to be guaranteed at each layer.  If we ge=
t a hardware ACK that the message was delivered, that means it was delivere=
d to the NTB hardware register, but no further.  If we do not get a hardwar=
e NAK(?), that means it was not delivered.  If the link fails or we time ou=
t waiting for a completion, we can only guess that it wasn't delivered even=
 though there is a small chance it was.  Applications need to be tolerant e=
ither way, and needs may be different depending on the application.  I woul=
d rather not add any fault tolerance (other than reporting faults) at this =
layer that is not already implemented in the hardware.
>=20
> Reading the description of OUTMSGSTS register, it is clear that we can re=
ceive a hardware NAK if an outgoing message failed.  It's not clear to me t=
hat IDT will notify any kind of ACK that an outgoing message was accepted. =
 If an application wants to send two messages, it can send the first, check=
 the bit and see there is no failure.  Does reading the status immediately =
after sending guarantee the message WAS delivered (i.e. IDT NTB hardware bl=
ocks reading the status register while there are messages in flight)?  If n=
ot, if the application sends the second message and then sees a failure, ho=
w can the application be sure the failure is not for the first message?  Do=
es the application have to wait some time (how long?) before checking the m=
essage status?
>=20

Ok, I think I need to explain it carefully. When a local Root Complex sends=
 a message to a peer,
it writes a message to its outgoing message registers, which are connected =
with the peer incoming
message registers. If that incoming message registers are still full, so pe=
er has not emptied them
by clearing a corresponding bit, then a local Root Complex gets a so called=
 NACK, on the other
words it failed to send a message. Then it tries to send the message again =
and again before a next
attempt is either succeeded or a limited number of attempts is exceeded. La=
st one would lead to
rising a NTB_MSG_FAIL event.

On the other hand before sending a message IDT driver checks whether the NT=
B link is up, if it isn't
then it raises NTB_MSG_FAIL event.

After all the discussions I am starting to realize what is the problem. The=
 problem is that we
might have differently pictures of how NTB hardware are connected.) Traditi=
onal Intel/AMD NTB
hardware are directly connected to each other so there is only one PCIe-lin=
k between two Root
Complexes, but IDT bridge is kind of single intermediate device, which has =
at least two NTB ports
connected to Root Complexes by different PCIe-links. So when one sends a me=
ssage to another and
it's accepted by hardware, then the message was put to the incoming message=
 register of the IDT
opposite port, and the peer Root Complex is just notified that a new messag=
e has arrived.

> >=20
> > Finally, I've answered to all the questions. Hopefully the things look =
clearer now.
> >=20
> > Regards,
> > -Sergey
>=20
>=20
