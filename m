Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x244.google.com (mail-lf0-x244.google.com. [2a00:1450:4010:c07::244])
        by gmr-mx.google.com with ESMTPS id b77si98638wmb.1.2016.08.19.02.10.06
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Aug 2016 02:10:06 -0700 (PDT)
Received: by mail-lf0-x244.google.com with SMTP id l89so2816233lfi.2
        for <linux-ntb@googlegroups.com>; Fri, 19 Aug 2016 02:10:06 -0700 (PDT)
Return-Path: <fancer.lancer@gmail.com>
Date: Fri, 19 Aug 2016 12:10:00 +0300
From: Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH v2 1/3] ntb: Add asynchronous devices support to NTB-bus
 interface
Message-ID: <20160819091000.GA14241@mobilestation>
References: <002201d1f1be$a24fe400$e6efac00$@emc.com>
 <20160818215604.GA19986@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20160818215604.GA19986@mobilestation>
To: Allen Hubbe <Allen.Hubbe@emc.com>
Cc: jdmason@kudzu.us, dave.jiang@intel.com, Xiangliang.Yu@amd.com, Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

Allen,
There is no any comment below, just this one.

After a short meditation I realized what you are trying to achieve. Your pr=
imary intentions
was to unify the NTB interface so it would fit both Inte/AMD and IDT hardwa=
re without doing
any abstraction. You may understand why I so eager in refusal this. The rea=
son of most of my
objection is that making such a unified interface will lead to IDT driver c=
omplete redevelopment.

IDT driver is developed to fit your previous NTB Kernel API. So of course I=
've made some
abstraction to keep it suitable for API and make it as simple as possible. =
That's why I
introduced coupled Messaging subsystem and kernel threads to deliver messag=
es.

Here are my conclusions if you still want a new inified interface:
1) I'm still eager of renaming the ntb_mw_* and ntb_peer_mw_* prefixed meth=
ods (see the illustrated
comment in my previous email). It just a matter of names syntax unification=
, so it would not look
confusing.

2) We could make the following interface.
Before getting to a possible interface, IDT hardware doesn't continuously e=
numerate the ports. For
instance, NTB functions can be activated on the 0, 2, 4, 6, 8, 12, 16 and 2=
0 ports. Activation is
usually done over an SMBus interface or using a EEPROM firmware.

I won't describe all the interface methods arguments, just new and importan=
t ones:

 - Link Up/down interface
ntb_link_is_up(ntb, port);
ntb_link_enable(ntb, port);
ntb_link_disable(ntb, port);

 - Memory windows interface
ntb_get_port_map(ntb); - return an array of ports with NTB function activat=
ed. There can be only
NTB function activated per port.

ntb_mw_count(ntb); - total number of local memory windows which can be init=
ialized (up to 24 for IDT).
ntb_mw_get_maprsc(ntb, idx); - get the mapping resources of the memory wind=
ow. Client
driver should know from internal logic which port is assigned to which memo=
ry window.
ntb_mw_get_align(ntb, idx); - return translation address alignment of the l=
ocal memory window.
ntb_mw_set_trans(ntb, idx, port); - set a translation address of the corres=
ponding local memory
window, so it would be connected with the RC memory of the corresponding po=
rt.
ntb_mw_get_trans(ntb, idx, port); - get a translation address of the corres=
ponding local memory
window.

ntb_peer_mw_count(ntb); - total number of peer memory windows (up to 24 for=
 IDT, but they can't
be reachable because of the race conditions I described in the first emails=
).
ntb_peer_mw_get_align(ntb, idx); - return translation address alignment of =
the peer memory window.
ntb_peer_mw_set_trans(ntb, idx, port); - set a translation address of the c=
orresponding peer memory
window, so it would be connected with the RC memory of the corresponding po=
rt (it won't work
for IDT because of the race condition).
ntb_peer_mw_get_trans(ntb, idx, port); - get a translation address of the c=
orresponding peer memory
window (it won't work for IDT).

 - Doorbell interface
Doorbells are kind of tricky in IDT. They aren't traditional doorbells like=
 the AMD/Intel ones,
because of the multiple NTB-ports. First of all there is a global doorbell =
register, which is
32-bits wide. Each port has its own outbound and inbound doorbell registers=
 (each one of 32-bits
wide). There is a global mask registers, which can mask ports outbound door=
bell registers from
affecting the global doorbell register and can mask ports inbound doorbell =
registers from being
affected by the global doorbell register.
Those mask registers can not be safely accessed from a different ports, bec=
ause of the damn race
condition. Instead we can leave them as is, so all the outbound doorbells a=
ffects all the bits of
global doorbell register and all the inbound doorbells are affected by the =
all the bits of the
global doorbell register.

So to speak we can leave the doorbell interface as is.

 - Scratchpad interface
Since the scratchpad registers are kind of just shared storages, we can lea=
ve the interface as
is. I don't think IDT will introduce Scratchpad registers in their any new =
multiport NTB-related
hardware.

 - Messaging interface
Partly we can stick to your design, but I would split the inbound and outbo=
und message statuses, because
in this way client driver developer won't have to know which part of bit-fi=
eld is related to which
inbound and outbound messages:
ntb_msg_event(ntb); - received a hardware interrupt for messages. (don't re=
ad message status, or anything else)
ntb_msg_read_sts_in(ntb); - read and return inbound MSGSTS bitmask.
ntb_msg_clear_sts_in(ntb) - clear bits of inbound MSGSTS bitmask.
ntb_msg_set_mask_in(ntb); - set bits in inbound part of MSGSTSMSK.
ntb_msg_clear_mask_in(ntb); - clear bits in inbound part of MSGSTSMSK.
ntb_msg_read_sts_out(ntb); - read and return outbound MSGSTS bitmask.
ntb_msg_clear_sts_out(ntb); - clear bits of outbound MSGSTS bitmask.
ntb_msg_set_mask_out(ntb); - set bits in outbound part of MSGSTSMSK.
ntb_msg_clear_mask_out(ntb); - clear bits in outbound part of MSGSTSMSK.
ntb_msg_count(ntb); - number of message registers
ntb_msg_recv(ntb, idx, msg, src_port); - read a message register of the cor=
responding
index and the source port of data it retrieved.
ntb_msg_send(ntb, idx, msg, target_port); - send a message to the correspon=
ding port.

3) IDT driver redevelopment will take a lot of time, since I don't have muc=
h free time to do
it. It may be half of year or even more.

From my side, such an improvement will significantly complicate the NTB Ke=
rnel API. Since you
are the subsystem maintainer it's your decision which design to choose, but=
 I don't think I'll do
the IDT driver suitable for this design anytime soon.

Regards,
-Sergey


On Fri, Aug 19, 2016 at 12:56:04AM +0300, Serge Semin <fancer.lancer@gmail.=
com> wrote:
> Hello Allen,
> Sorry for the delay with response and thanks for thoughtful review.
>=20
> On Mon, Aug 08, 2016 at 05:48:42PM -0400, Allen Hubbe <Allen.Hubbe@emc.co=
m> wrote:
> > From: Serge Semin
> > > Hello Allen.
> > >=20
> > > Thanks for your careful review. Going through this mailing thread I h=
ope we'll come up
> > > with solutions, which improve the driver code as well as extend the L=
inux kernel support
> > > of new devices like IDT PCIe-swtiches.
> > >=20
> > > Before getting to the inline commentaries I need to give some introdu=
ction to the IDT NTB-
> > > related hardware so we could speak on the same language. Additionally=
 I'll give a brief
> > > explanation how the setup of memory windows works in IDT PCIe-switche=
s.
> >=20
> > I found this to use as a reference for IDT:
> > https://www.idt.com/document/man/89hpes24nt24g2-device-user-manual
>=20
> Yes, it's supported by the IDT driver, although I am using a device with =
lesser number of ports:
> https://www.idt.com/document/man/89hpes32nt8ag2-device-user-manual
>=20
> >=20
> > > First of all, before getting into the IDT NTB driver development I ha=
d made a research of
> > > the currently developed NTB kernel API and AMD/Intel hardware drivers=
. Due to lack of the
> > > hardware manuals It might be not in deep details, but I understand ho=
w the AMD/Intel NTB-
> > > hardware drivers work. At least I understand the concept of memory wi=
ndowing, which led to
> > > the current NTB bus kernel API.
> > >=20
> > > So lets get to IDT PCIe-switches. There is a whole series of NTB-rela=
ted switches IDT
> > > produces. All of them I split into two distinct groups:
> > > 1) Two NTB-ported switches (models 89PES8NT2, 89PES16NT2, 89PES12NT3,=
 89PES124NT3),
> > > 2) Multi NTB-ported switches (models 89HPES24NT6AG2, 89HPES32NT8AG2, =
89HPES32NT8BG2,
> > > 89HPES12NT12G2, 89HPES16NT16G2, 89HPES24NT24G2, 89HPES32NT24AG2, 89HP=
ES32NT24BG2).
> > > Just to note all of these switches are a part of IDT PRECISE(TM) fami=
ly of PCI Express=EF=BF=BD
> > > switching solutions. Why do I split them up? Because of the next reas=
ons:
> > > 1) Number of upstream ports, which have access to NTB functions (obvi=
ously, yeah? =3D)). So
> > > the switches of the first group can connect just two domains over NTB=
. Unlike the second
> > > group of switches, which expose a way to setup an interaction between=
 several PCIe-switch
> > > ports, which have NT-function activated.
> > > 2) The groups are significantly distinct by the way of NT-functions c=
onfiguration.
> > >=20
> > > Before getting further, I should note, that the uploaded driver suppo=
rts the second group
> > > of devices only. But still I'll give a comparative explanation, since=
 the first group of
> > > switches is very similar to the AMD/Intel NTBs.
> > >=20
> > > Lets dive into the configurations a bit deeper. Particularly NT-funct=
ions of the first
> > > group of switches can be configured the same way as AMD/Intel NTB-fun=
ctions are. There is
> > > an PCIe end-point configuration space, which fully reflects the cross=
-coupled local and
> > > peer PCIe/NTB settings. So local Root complex can set any of the peer=
 registers by direct
> > > writing to mapped memory. Here is the image, which perfectly explains=
 the configuration
> > > registers mapping:
> > > https://s8.postimg.org/3nhkzqfxx/IDT_NTB_old_configspace.png
> > > Since the first group switches connect only two root complexes, the r=
ace condition of
> > > read/write operations to cross-coupled registers can be easily resolv=
ed just by roles
> > > distribution. So local root complex sets the translated base address =
directly to a peer
> > > configuration space registers, which correspond to BAR0-BAR3 locally =
mapped memory
> > > windows. Of course 2-4 memory windows is enough to connect just two d=
omains. That's why
> > > you made the NTB bus kernel API the way it is.
> > >=20
> > > The things get different when one wants to have an access from one do=
main to multiple
> > > coupling up to eight root complexes in the second group of switches. =
First of all the
> > > hardware doesn't support the configuration space cross-coupling anymo=
re. Instead there are
> > > two Global Address Space Access registers provided to have an access =
to a peers
> > > configuration space. In fact it is not a big problem, since there are=
 no much differences
> > > in accessing registers over a memory mapped space or a pair of fixed =
Address/Data
> > > registers. The problem arises when one wants to share a memory window=
s between eight
> > > domains. Five BARs are not enough for it even if they'd be configured=
 to be of x32 address
> > > type. Instead IDT introduces Lookup table address translation. So BAR=
2/BAR4 can be
> > > configured to translate addresses using 12 or 24 entries lookup table=
s. Each entry can be
> > > initialized with translated base address of a peer and IDT switch por=
t, which peer is
> > > connected to. So when local root complex locally maps BAR2/BAR4, one =
can have an access to
> > > a memory of a peer just by reading/writing with a shift corresponding=
 to the lookup table
> > > entry. That's how more than five peers can be accessed. The root prob=
lem is the way the
> > > lookup table is accessed. Alas It is accessed only by a pair of "Entr=
y index/Data"
> > > registers. So a root complex must write an entry index to one registe=
rs, then read/write
> > > data from another. As you might realise, that weak point leads to a r=
ace condition of
> > > multiple root complexes accessing the lookup table of one shared peer=
. Alas I could not
> > > come up with a simple and strong solution of the race.
> >=20
> > Right, multiple peers reaching across to some other peer's NTB configur=
ation space is problematic.  I don't mean to suggest we should reach across=
 to configure the lookup table (or anything else) on a remote NTB.
>=20
> Good, we settled this down.
>=20
> >=20
> > > That's why I've introduced the asynchronous hardware in the NTB bus k=
ernel API. Since
> > > local root complex can't directly write a translated base address to =
a peer, it must wait
> > > until a peer asks him to allocate a memory and send the address back =
using some of a
> > > hardware mechanism. It can be anything: Scratchpad registers, Message=
 registers or even
> > > "crazy" doorbells bingbanging. For instance, the IDT switches of the =
first group support:
> > > 1) Shared Memory windows. In particular local root complex can set a =
translated base
> > > address to BARs of local and peer NT-function using the cross-coupled=
 PCIe/NTB
> > > configuration space, the same way as it can be done for AMD/Intel NTB=
s.
> > > 2) One Doorbell register.
> > > 3) Two Scratchpads.
> > > 4) Four message regietsrs.
> > > As you can see the switches of the first group can be considered as b=
oth synchronous and
> > > asynchronous. All the NTB bus kernel API can be implemented for it in=
cluding the changes
> > > introduced by this patch (I would do it if I had a corresponding hard=
ware). AMD and Intel
> > > NTBs can be considered both synchronous and asynchronous as well, alt=
hough they don't
> > > support messaging so Scratchpads can be used to send a data to a peer=
. Finally the
> > > switches of the second group lack of ability to initialize BARs trans=
lated base address of
> > > peers due to the race condition I described before.
> > >=20
> > > To sum up I've spent a lot of time designing the IDT NTB driver. I've=
 done my best to make
> > > the IDT driver as much compatible with current design as possible, ne=
vertheless the NTB
> > > bus kernel API had to be slightly changed. You can find answers to th=
e commentaries down
> > > below.
> > >=20
> > > On Fri, Aug 05, 2016 at 11:31:58AM -0400, Allen Hubbe <Allen.Hubbe@em=
c.com> wrote:
> > > > From: Serge Semin
> > > > > Currently supported AMD and Intel Non-transparent PCIe-bridges ar=
e synchronous
> > > > > devices, so translated base address of memory windows can be dire=
cly written
> > > > > to peer registers. But there are some IDT PCIe-switches which imp=
lement
> > > > > complex interfaces using Lookup Tables of translation addresses. =
Due to
> > > > > the way the table is accessed, it can not be done synchronously f=
rom different
> > > > > RCs, that's why the asynchronous interface should be developed.
> > > > >
> > > > > For these purpose the Memory Window related interface is correspo=
ndingly split
> > > > > as it is for Doorbell and Scratchpad registers. The definition of=
 Memory Window
> > > > > is following: "It is a virtual memory region, which locally refle=
cts a physical
> > > > > memory of peer device." So to speak the "ntb_peer_mw_"-prefixed m=
ethods control
> > > > > the peers memory windows, "ntb_mw_"-prefixed functions work with =
the local
> > > > > memory windows.
> > > > > Here is the description of the Memory Window related NTB-bus call=
back
> > > > > functions:
> > > > >  - ntb_mw_count() - number of local memory windows.
> > > > >  - ntb_mw_get_maprsc() - get the physical address and size of the=
 local memory
> > > > >                          window to map.
> > > > >  - ntb_mw_set_trans() - set translation address of local memory w=
indow (this
> > > > >                         address should be somehow retrieved from =
a peer).
> > > > >  - ntb_mw_get_trans() - get translation address of local memory w=
indow.
> > > > >  - ntb_mw_get_align() - get alignment of translated base address =
and size of
> > > > >                         local memory window. Additionally one can=
 get the
> > > > >                         upper size limit of the memory window.
> > > > >  - ntb_peer_mw_count() - number of peer memory windows (it can di=
ffer from the
> > > > >                          local number).
> > > > >  - ntb_peer_mw_set_trans() - set translation address of peer memo=
ry window
> > > > >  - ntb_peer_mw_get_trans() - get translation address of peer memo=
ry window
> > > > >  - ntb_peer_mw_get_align() - get alignment of translated base add=
ress and size
> > > > >                              of peer memory window.Additionally o=
ne can get the
> > > > >                              upper size limit of the memory windo=
w.
> > > > >
> > > > > As one can see current AMD and Intel NTB drivers mostly implement=
 the
> > > > > "ntb_peer_mw_"-prefixed methods. So this patch correspondingly re=
names the
> > > > > driver functions. IDT NTB driver mostly expose "ntb_nw_"-prefixed=
 methods,
> > > > > since it doesn't have convenient access to the peer Lookup Table.
> > > > >
> > > > > In order to pass information from one RC to another NTB functions=
 of IDT
> > > > > PCIe-switch implement Messaging subsystem. They currently support=
 four message
> > > > > registers to transfer DWORD sized data to a specified peer. So th=
ere are two
> > > > > new callback methods are introduced:
> > > > >  - ntb_msg_size() - get the number of DWORDs supported by NTB fun=
ction to send
> > > > >                     and receive messages
> > > > >  - ntb_msg_post() - send message of size retrieved from ntb_msg_s=
ize()
> > > > >                     to a peer
> > > > > Additionally there is a new event function:
> > > > >  - ntb_msg_event() - it is invoked when either a new message was =
retrieved
> > > > >                      (NTB_MSG_NEW), or last message was successfu=
lly sent
> > > > >                      (NTB_MSG_SENT), or the last message failed t=
o be sent
> > > > >                      (NTB_MSG_FAIL).
> > > > >
> > > > > The last change concerns the IDs (practically names) of NTB-devic=
es on the
> > > > > NTB-bus. It is not good to have the devices with same names in th=
e system
> > > > > and it brakes my IDT NTB driver from being loaded =3D) So I devel=
oped a simple
> > > > > algorithm of NTB devices naming. Particulary it generates names "=
ntbS{N}" for
> > > > > synchronous devices, "ntbA{N}" for asynchronous devices, and "ntb=
AS{N}" for
> > > > > devices supporting both interfaces.
> > > >
> > > > Thanks for the work that went into writing this driver, and thanks =
for your patience
> > > with the review.  Please read my initial comments inline.  I would li=
ke to approach this
> > > from a top-down api perspective first, and settle on that first befor=
e requesting any
> > > specific changes in the hardware driver.  My major concern about thes=
e changes is that
> > > they introduce a distinct classification for sync and async hardware,=
 supported by
> > > different sets of methods in the api, neither is a subset of the othe=
r.
> > > >
> > > > You know the IDT hardware, so if any of my requests below are infea=
sible, I would like
> > > your constructive opinion (even if it means significant changes to ex=
isting drivers) on
> > > how to resolve the api so that new and existing hardware drivers can =
be unified under the
> > > same api, if possible.
> > >=20
> > > I understand your concern. I have been thinking of this a lot. In my =
opinion the proposed
> > > in this patch alterations are the best of all variants I've been thin=
king about. Regarding
> > > the lack of APIs subset. In fact I would not agree with that. As I de=
scribed in the
> > > introduction AMD and Intel drivers can be considered as both synchron=
ous and asynchronous,
> > > since a translated base address can be directly set in a local and pe=
er configuration
> > > space. Although AMD and Intel devices don't support messaging, they h=
ave Scratchpads,
> > > which can be used to exchange an information between root complexes. =
The thing we need to
> > > do is to implement ntb_mw_set_trans() and ntb_mw_get_align() for them=
. Which isn't much
> > > different from the "mw_peer"-prefixed ones. The first method just set=
s a translated base
> > > address to the corresponding local register. The second one does exac=
tly the same as
> > > "mw_peer"-prefixed ones. I would do it, but I haven't got a hardware =
to test, that's why I
> > > left things the way it was with just slight changes of names.
> >=20
> > It sounds like the purpose of your ntb_mw_set_trans() [what I would cal=
l ntb_peer_mw_set_trans()] is similar to what is done at initialization tim=
e in the Intel NTB driver, so that outgoing writes are translated to the co=
rrect peer NTB BAR.  The difference is that IDT outgoing translation sets n=
ot only the peer NTB address but also the port number in the translation.
> > http://lxr.free-electrons.com/source/drivers/ntb/hw/intel/ntb_hw_intel.=
c?v=3D4.7#L1673
> >=20
> > It would be interesting to allow ntb clients to change this translation=
, eg, configure an outgoing write from local BAR23 so it hits peer secondar=
y BAR45.  I don't think e.g. Intel driver should be forced to implement tha=
t, but it would be interesting to think of unifying the api with that in mi=
nd.
>=20
> I already said I'm not an expert of Intel and AMD hardware, moreover I do=
n't even have any
> reference manual to study it. But from the first glance it's not. It does=
n't concern any
> of peer BARs. As far as I can judge by the Intel driver code, the initial=
ization code
> specifies some fixed translation address so to get access to some memory =
space of a remote
> bridge. According to my observation b2b configuration looks more like so =
called Punch-through
> configuration in the IDT definitions. It's when two bridges are connected=
 to each other.
> But I may be wrong. Although it doesn't matter at the moment.
>=20
> It's much easier to explain how it works using an illustrations, otherwis=
e we'll be discussing
> this matter forever.
>=20
> Lets start from definition what Memory Window mean. As I already said: "M=
emory Window is a
> virtual memory region, which locally reflects a physical memory of peer/r=
emote device."
>=20
> Next suppose we've got two 32-bits Root Complexes (RC0 and RC1) connected=
 to each other over
> an NTB. It doesn't matter whether it's an IDT or Intel/AMD like NTBs. The=
 NTB device has two
> ports: Pn and Pm, each port is connected to its own Root Complex. There a=
re doorbells,
> scratchpads, and of course memory windows. Each Root Complex allocates a =
memory buffer:
> Buffer A and Buffer B. Additionally RC0 and RC1 maps memory windows at th=
e corresponding
> addresses: MW A and MW B. Here is how it schematically looks:
> https://s3.postimg.org/so3zg0car/memory_windows_before.jpg
>=20
> According to your NTB Kernel API naming (see the figure), methods are sup=
posed to be
> syntactically split into two: with "ntb_peer_" prefix and without one. An=
d they are correctly
> split for doorbells and scratchpads, but when it comes to memory windows,=
 the method names
> syntax is kind of messed up.
>=20
> Keeping in mind the definition of memory windows I introduced before, you=
r ntb_mw_*_trans()
> methods set/get translation base address to "BARm XLAT", so the ones memo=
ry window would be
> correctly connected with Buffer A. But the function doesn't have "ntb_pee=
r_mw" prefix, which
> does look confusing, since it works with peer configuration registers, pa=
rticularly with the
> peer translation address of BARm - MW B.
>=20
> Finally your ntb_mw_get_range() returns information about two opposite si=
des.
> "Alignment"-related arguments return align of translated base address of =
the peer, but "base"
> and "size" arguments are related with virtual address of the local memory=
 window, which has
> nothing related with the peer memory window and its translated base addre=
ss.
>=20
> My idea was to fix this syntax incorrectness, so the memory windows NTB K=
ernel API would look
> the same way as doorbell and scratchpad ones. Here is the illustration, h=
ow it works now:
> https://s3.postimg.org/52mvtfpgz/memory_windows_after.jpg
>=20
> As you can see, the "ntb_peer_mw_" prefixed methods are related with the =
peer configurations
> only, so ntb_peer_mw_*_trans() set/get translation base address of the pe=
er memory windows
> and ntb_peer_mw_get_align() return alignment of that address. Methods wit=
h no "ntb_peer_mw_"
> prefix, do the same thing but with translation address of the local memor=
y window.
> Additionally ntb_mw_get_maprsc() return a physical address of local memor=
y window to=20
> correspondingly map it.
>=20
> In the same way the Memory Window API can be split into synchronous, asyn=
chronous and both.
> If hardware (like Intel/AMD) allows to implement "ntb_peer_mw" prefixed m=
ethods (see methods
> marked with blue ink on the last figure), then it is considered synchrono=
us, since it can
> directly specify translation base addresses to the peer memory windows. I=
f hardware supports
> the "ntb_mw" prefixed methods only (purple ink on the figure), then it is=
 considered as
> asynchronous, so a client driver must somehow retrieve a translation addr=
ess for local
> memory window. Method ntb_mw_get_maprsc() must be supported by both hardw=
are (it is marked
> with green ink). Of course there are hardware, which can support both syn=
chronous and
> asynchronous API, like Intel/AMD. IDT PCIe-bridge doesn't safely support =
it since Lookup
> translation tables access method.
>=20
> I hope we got it settled now. If not, We can have a Skype conversation, s=
ince writing such a
> long letters takes lot of time.
>=20
> >=20
> > >=20
> > > > > Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> > > > >
> > > > > ---
> > > > >  drivers/ntb/Kconfig                 |   4 +-
> > > > >  drivers/ntb/hw/amd/ntb_hw_amd.c     |  49 ++-
> > > > >  drivers/ntb/hw/intel/ntb_hw_intel.c |  59 +++-
> > > > >  drivers/ntb/ntb.c                   |  86 +++++-
> > > > >  drivers/ntb/ntb_transport.c         |  19 +-
> > > > >  drivers/ntb/test/ntb_perf.c         |  16 +-
> > > > >  drivers/ntb/test/ntb_pingpong.c     |   5 +
> > > > >  drivers/ntb/test/ntb_tool.c         |  25 +-
> > > > >  include/linux/ntb.h                 | 600 ++++++++++++++++++++++=
+++++++-------
> > > > >  9 files changed, 701 insertions(+), 162 deletions(-)
> > > > >
> >=20
> >=20
> > > > > -		rc =3D ntb_mw_get_range(ndev, i, &mw->phys_addr, &mw->phys_siz=
e,
> > > > > -				      &mw->xlat_align, &mw->xlat_align_size);
> > > > > +		rc =3D ntb_mw_get_maprsc(ndev, i, &mw->phys_addr, &mw->phys_si=
ze);
> > > > > +		if (rc)
> > > > > +			goto err1;
> > > > > +
> > > > > +		rc =3D ntb_peer_mw_get_align(ndev, i, &mw->xlat_align,
> > > > > +					   &mw->xlat_align_size, NULL);
> > > >
> > > > Looks like ntb_mw_get_range() was simpler before the change.
> > > >
> > >=20
> > > If I didn't change NTB bus kernel API, I would have split them up any=
way. First of all
> > > functions with long argument list look more confusing, than ones with=
 shorter list. It
> > > helps to stick to the "80 character per line" rule and improves reada=
bility. Secondly the
> > > function splitting improves the readability of the code in general. W=
hen I first saw the
> > > function name "ntb_mw_get_range()", it was not obvious what kind of r=
anges this function
> > > returned. The function lacked of "high code coherence" unofficial rul=
e. It is better when
> > > one function does one coherent thing and return a well coherent data.=
 Particularly
> > > function "ntb_mw_get_range()" returned a local memory windows mapping=
 address and size, as
> > > well as alignment of memory allocated for a peer. So now "ntb_mw_get_=
maprsc()" method
> > > returns mapping resources. If local NTB client driver is not going to=
 allocate any memory,
> > > so one just doesn't need to call "ntb_peer_mw_get_align()" method at =
all. I understand,
> > > that a client driver could pass NULL to a unused arguments of the "nt=
b_mw_get_range()",
> > > but still the new design is better readable.
> > >=20
> > > Additionally I've split them up because of the difference in the way =
the asynchronous
> > > interface works. IDT driver can not safely perform ntb_peer_mw_set_tr=
ans(), that's why I
> > > had to add ntb_mw_set_trans(). Each of that method should logically h=
ave related
> > > "ntb_*mw_get_align()" method. Method ntb_mw_get_align() shall give to=
 a local client
> > > driver a hint how the retrieved from the peer translated base address=
 should be aligned,
> > > so ntb_mw_set_trans() method would successfully return. Method ntb_pe=
er_mw_get_align()
> > > will give a hint how the local memory buffer should be allocated to f=
ulfil a peer
> > > translated base address alignment. In this way it returns restriction=
s for parameters of
> > > "ntb_peer_mw_set_trans()".
> > >=20
> > > Finally, IDT driver is designed so Primary and Secondary ports can su=
pport a different
> > > number of memory windows. In this way methods
> > > "ntb_mw_get_maprsc()/ntb_mw_set_trans()/ntb_mw_get_trans()/ntb_mw_get=
_align()" have
> > > different range of acceptable values of the second argument, which is=
 determined by the
> > > "ntb_mw_count()" method, comparing to methods
> > > "ntb_peer_mw_set_trans()/ntb_peer_mw_get_trans()/ntb_peer_mw_get_alig=
n()", which memory
> > > windows index restriction is determined by the "ntb_peer_mw_count()" =
method.
> > >=20
> > > So to speak the splitting was really necessary to make the API lookin=
g more logical.
> >=20
> > If this change is not required by the new hardware, please submit the c=
hange as a separate patch.
> >=20
>=20
> It's required. See the previous comment.
>=20
> > > > > +	/* Synchronous hardware is only supported */
> > > > > +	if (!ntb_valid_sync_dev_ops(ntb)) {
> > > > > +		return -EINVAL;
> > > > > +	}
> > > > > +
> > > >
> > > > It would be nice if both types could be supported by the same api.
> > > >
> > >=20
> > > Yes, it would be. Alas it isn't possible in general. See the introduc=
tion to this letter.
> > > AMD and Intel devices support asynchronous interface, although they l=
ack of messaging
> > > mechanism.
> >=20
> > What is the prototypical application of the IDT message registers?
> >=20
> > I'm thinking they will be the first thing available to drivers, and so =
one primary purpose will be to exchange information for configuring memory =
windows.  Can you describe how a cluster of eight nodes would discover each=
 other and initialize?
> >=20
> > Are they also intended to be useful beyond memory window initialization=
?  How should they be used efficiently, so that the application can minimiz=
e in particular read operations on the pci bus (reading ntb device register=
s)?  Or are message registers not intended to be used in low latency commun=
ications (for that, use doorbells and memory instead)?
> >=20
>=20
> The prototypical application of the message registers is to exchange a sm=
all portion of
> information, like translation base address for example. Imagine IDT hardw=
are provides just
> four 32-bits wide message registers. So a driver software can transfer a =
message ID, memory
> window index and a translation address using such a small buffer. The mes=
sage registers can't
> be efficiently used for exchanging of any bigger data. One should use doo=
rbells and memory
> windows instead.
>=20
> I'm not a mind reader, but still supposably IDT provided them as a synchr=
onous exchange of
> Scratchpads. Message registers are designed so it's impossible to send a =
message to a peer
> before one read a previous message. Such a design is really helpful when =
we need to connect
> few different nodes and pass information between each other. Scratchpads =
would lead to too
> much complications.
>=20
> > >=20
> > > Getting back to the discussion, we still need to provide a way to det=
ermine which type of
> > > interface an NTB device supports: synchronous/asynchronous translated=
 base address
> > > initialization, Scratchpads and memory windows. Currently it can be d=
etermined by the
> > > functions ntb_valid_sync_dev_ops()/ntb_valid_async_dev_ops(). I under=
stand, that it's not
> > > the best solution. We can implement the traditional Linux kernel bus =
device-driver
> > > matching, using table_ids and so on. For example, each hardware drive=
r fills in a table
> > > with all the functionality it supports, like: synchronous/asynchronou=
s memory windows,
> > > Doorbells, Scratchpads, Messaging. Then driver initialize a table of =
functionality it
> > > uses. NTB bus core implements a "match()" callback, which compares th=
ose two tables and
> > > calls "probe()" callback method of a driver when the tables successfu=
lly matches.
> > >=20
> > > On the other hand, we might don't have to comprehend the NTB bus core=
. We can just
> > > introduce a table_id for NTB hardware device, which would just descri=
be the device vendor
> > > itself, like "ntb,amd", "ntb,intel", "ntb,idt" and so on. Client driv=
er will declare a
> > > supported device by its table_id. It might look easier, since
> >=20
> > emphasis added:
> >=20
> > > the client driver developer
> > > should have a basic understanding of the device one develops a driver=
 for.
> >=20
> > This is what I'm hoping to avoid.  I would like to let the driver devel=
oper write for the api, not for the specific device.  I would rather the dr=
iver check "if feature x is supported" instead of "this is a sync or async =
device."
> >=20
>=20
> Ok. We can implement "features checking methods" like:
> ntb_valid_link_ops(),
> ntb_valid_peer_db_ops(),
> ntb_valid_db_ops(),
> ntb_valid_peer_spad_ops(),
> ntb_valid_spad_ops(),
> ntb_valid_msg_ops(),
> ntb_valid_peer_mw_ops(),
> ntb_valid_mw_ops().
>=20
> But I am not fan of calling all of those methods in every client drivers.=
 I would rather develop
> an "NTB Device - Client Driver" matching method in the framework of NTB b=
us. For example,
> developer creates a client driver using Doorbells (ntb_valid_peer_db_ops/=
ntb_valid_db_ops),
> Messages (ntb_valid_msg_ops) and Memory Windows (ntb_valid_peer_mw_ops/nt=
b_valid_mw_ops). Then one
> declares that the driver requires the corresponding features, somewhere i=
n the struct ntb_client,
> like it's usually done in the "compatible" fields of matching id_tables o=
f drivers (see SPI, PCI,
> i2c and others), but we would call it like "feature_table" with "compatib=
le" fields. Of course
> every hardware driver would declare, which kind of features one supports.=
 Then the NTB bus
> "match()" callback method checks whether the registered device supports a=
ll features the client
> driver claims. If it does, then and only then the "probe()" method of the=
 client driver is called.
>=20
> Of course, it's your decision which design to use, I am just giving a pos=
sible solutions. But the
> last one gives better unification with general "Bus - Device - Driver" de=
sign of the Linux Kernel.
>=20
> > > Then NTB bus
> > > kernel API core will simply match NTB devices with drivers like any o=
ther buses (PCI,
> > > PCIe, i2c, spi, etc) do.
> > >=20
> >=20
> > > > > -static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops =
*ops)
> > > > > +static inline int ntb_valid_sync_dev_ops(const struct ntb_dev *n=
tb)
> > > > > +static inline int ntb_valid_async_dev_ops(const struct ntb_dev *=
ntb)
> > > >
> > > > I understand why IDT requires a different api for dealing with addr=
essing multiple
> > > peers.  I would be interested in a solution that would allow, for exa=
mple, the Intel
> > > driver fit under the api for dealing with multiple peers, even though=
 it only supports one
> > > peer.  I would rather see that, than two separate apis under ntb.
> > > >
> > > > Thoughts?
> > > >
> > > > Can the sync api be described by some subset of the async api?  Are=
 there less
> > > overloaded terms we can use instead of sync/async?
> > > >
> > >=20
> > > Answer to this concern is mostly provided in the introduction as well=
. I'll repeat it here
> > > in details. As I said AMD and Intel hardware support asynchronous API=
 except the
> > > messaging. Additionally I can even think of emulating messaging using=
 Doorbells and
> > > Scratchpads, but not the other way around. Why not? Before answering,=
 here is how the
> > > messaging works in IDT switches of both first and second groups (see =
introduction for
> > > describing the groups).
> > >=20
> > > There are four outbound and inbound message registers for each NTB po=
rt in the device.
> > > Local root complex can connect its any outbound message to any inboun=
d message register of
> > > the IDT switch. When one writes a data to an outbound message registe=
r it immediately gets
> > > to the connected inbound message registers. Then peer can read its in=
bound message
> > > registers and empty it by clearing a corresponding bit. Then and only=
 then next data can
> > > be written to any outbound message registers connected to that inboun=
d message register.
> > > So the possible race condition between multiple domains sending a mes=
sage to same peer is
> > > resolved by the IDT switch itself.
> > >=20
> > > One would ask: "Why don't you just wrap the message registers up back=
 to the same port? It
> > > would look just like Scratchpads." Yes, It would. But still there are=
 only four message
> > > registers. It's not enough to distribute them between all the possibl=
y connected NTB
> > > ports. As I said earlier there can be up to eight domains connected, =
so there must be at
> > > least seven message register to fulfil the possible design.
> > >=20
> > > Howbeit all the emulations would look ugly anyway. In my opinion It's=
 better to slightly
> > > adapt design for a hardware, rather than hardware to a design. Follow=
ing that rule would
> > > simplify a code and support respectively.
> > >=20
> > > Regarding the APIs subset. As I said before async API is kind of subs=
et of synchronous
> > > API. We can develop all the memory window related callback-method for=
 AMD and Intel
> > > hardware driver, which is pretty much easy. We can even simulate mess=
age registers by
> > > using Doorbells and Scratchpads, which is not that easy, but possible=
. Alas the second
> > > group of IDT switches can't implement the synchronous API, as I alrea=
dy said in the
> > > introduction.
> >=20
> > Message registers operate fundamentally differently from scratchpads (a=
nd doorbells, for that matter).  I think we are in agreement.  It's a pain,=
 but maybe the best we can do is require applications to check for support =
for scratchpads, message registers, and/or doorbells, before using any of t=
hose features.  We already have ntb_db_valid_mask() and ntb_spad_count().
> >=20
>=20
> Yes they do. And yes, the client drivers must somehow check whether a mat=
ching NTB device
> supports all the features they need. See the previous comment how I suppo=
se it can be done.
>=20
> > I would like to see ntb_msg_count() and more direct access to the messa=
ge registers in this api.  I would prefer to see the more direct access to =
hardware message registers, instead of work_struct for message processing i=
n the low level hardware driver.  A more direct interface to the hardware r=
egisters would be more like the existing ntb.h api: direct and low-overhead=
 as possible, providing minimal abstraction of the hardware functionality.
> >=20
> > I think there is still hope we can unify the memory window interface.  =
Even though IDT supports things like subdividing the memory windows with ta=
ble lookup, and specification of destination ports for outgoing translation=
s, I think we can support the same abstraction in the existing drivers with=
 minimal overhead.
> >=20
> > For existing Intel and AMD drivers, there may be only one translation p=
er memory window (there is no table to subdivide the memory window), and th=
ere is only one destination port (the peer).  The Intel and AMD drivers can=
 ignore the table index in setting up the translation (or validate that the=
 requested table index is equal to zero).
> >=20
>=20
> In fact we don't need to introduce any of the table index, because the ta=
ble index you are
> talking about is just one peer. Since it is just a peer, then it must ref=
er to a particular
> device on the Linux NTB bus. For instance we got eight NTB ports on IDT P=
CIe-bridge, one
> of them is the Primary port. Then Root Complex connected to the Primary p=
ort will have seven
> devices on Linux NTB bus. Such design perfectly fits to your NTB Kernel A=
PI and additionally
> will cover all the client driver needs. In this case Primary NTB port wou=
ld be like an SPI, i2c
> adapters or PCI root complex itself with respect to their subsidiary buse=
s.
>=20
> That's how the IDT hardware driver is designed. It gives transparent oper=
ations with NTB
> kernel API.
>=20
> > > Regarding the overloaded naming. The "sync/async" names are the best =
I could think of. If
> > > you have any idea how one can be appropriately changed, be my guest. =
I would be really
> > > glad to substitute them with something better.
> > >=20
> >=20
> > Let's try to avoid a distinction, first, beyond just saying "not all ha=
rdware will support all these features."  If we absolutely have to make a d=
istinction, let's think of better names then.
> >=20
>=20
> Ok. We can stick to "featured" hardware. It sounds better.
>=20
> > > > > + * ntb_msg_event() - notify driver context of event in messaging=
 subsystem
> > > > >   * @ntb:	NTB device context.
> > > > > + * @ev:		Event type caused the handler invocation
> > > > > + * @msg:	Message related to the event
> > > > > + *
> > > > > + * Notify the driver context that there is some event happaned i=
n the event
> > > > > + * subsystem. If NTB_MSG_NEW is emitted then the new message has=
 just arrived.
> > > > > + * NTB_MSG_SENT is rised if some message has just been successfu=
lly sent to a
> > > > > + * peer. If a message failed to be sent then NTB_MSG_FAIL is emi=
tted. The very
> > > > > + * last argument is used to pass the event related message. It d=
iscarded right
> > > > > + * after the handler returns.
> > > > > + */
> > > > > +void ntb_msg_event(struct ntb_dev *ntb, enum NTB_MSG_EVENT ev,
> > > > > +		   struct ntb_msg *msg);
> > > >
> > > > I would prefer to see a notify-and-poll api (like NAPI).  This will=
 allow scheduling of
> > > the message handling to be done more appropriately at a higher layer =
of the application.
> > > I am concerned to see inmsg/outmsg_work in the new hardware driver [P=
ATCH 2/3], which I
> > > think would be more appropriate for a ntb transport (or higher layer)=
 driver.
> > > >
> > >=20
> > > Hmmm, that's how it's done.) MSI interrupt is raised when a new messa=
ge arrived into a
> > > first inbound message register (the rest of message registers are use=
d as an additional
> > > data buffers). Then a corresponding tasklet is started to release a h=
ardware interrupt
> > > context. That tasklet extracts a message from the inbound message reg=
isters, puts it into
> > > the driver inbound message queue and marks the registers as empty so =
the next message
> > > could be retrieved. Then tasklet starts a corresponding kernel work t=
hread delivering all
> > > new messages to a client driver, which preliminary registered "ntb_ms=
g_event()" callback
> > > method. When callback method "ntb_msg_event()" the passed message is =
discarded.
> >=20
> > When an interrupt arrives, can you signal the upper layer that a messag=
e has arrived, without delivering the message?  I think the lower layer can=
 do without the work structs, instead have the same body of the work struct=
 run in the context of the upper layer polling to receive the message.
> >=20
>=20
> Of course we can. I could create a method like ntb_msg_read() instead of =
passing a message to the
> callback, but I didn't do so because if next message interrupt arrives wh=
ile the previous message
> still has not been read, how a client driver would find out which message=
 caused the last
> interrupt? Thats why I prefer to pass the new message to the callback, so=
 if a client drivers wants
> to keep track of all the received methods, then it can create it's own qu=
eue.
>=20
> Regarding the rest of the comment. The upper layer will have to implement=
 the work struct anyway.
> Why do we need to copy that code everywhere if it can be common for all t=
he drivers? Still keep in
> mind, that the incoming message registers is the register, that must be f=
reed as fast as possible,
> since another peer device can be waiting for it to be freed. So it's bett=
er to read it in the
> hardware driver, than to let it being done by the unreliable client.
>=20
> > > > It looks like there was some rearranging of code, so big hunks appe=
ar to be added or
> > > removed.  Can you split this into two (or more) patches so that rearr=
anging the code is
> > > distinct from more interesting changes?
> > > >
> > >=20
> > > Lets say there was not much rearranging here. I've just put link-rela=
ted method before
> > > everything else. The rearranging was done from the point of methods i=
mportance view. There
> > > can't be any memory sharing and doorbells operations done before the =
link is established.
> > > The new arrangements is reflected in ntb_valid_sync_dev_ops()/ntb_val=
id_async_dev_ops()
> > > methods.
> >=20
> > It's unfortunate how the diff captured the changes.  Can you split this=
 up into smaller patches?
> >=20
>=20
> Lets settle the rest of the things down before doing this. If we don't th=
en it would be just
> a waste of time.
>=20
> > > > > - * ntb_mw_get_range() - get the range of a memory window
> > > > > + * ntb_mw_get_maprsc() - get the range of a memory window to map
> > > >
> > > > What was insufficient about ntb_mw_get_range() that it needed to be=
 split into
> > > ntb_mw_get_maprsc() and ntb_mw_get_align()?  In all the places that I=
 found in this patch,
> > > it seems ntb_mw_get_range() would have been more simple.
> > > >
> > > > I didn't see any use of ntb_mw_get_mapsrc() in the new async test c=
lients [PATCH 3/3].
> > > So, there is no example of how usage of new api would be used differe=
ntly or more
> > > efficiently than ntb_mw_get_range() for async devices.
> > > >
> > >=20
> > > This concern is answered a bit earlier, when you first commented the =
method
> > > "ntb_mw_get_range()" splitting.
> > >=20
> > > You could not find the "ntb_mw_get_mapsrc()" method usage because you=
 misspelled it. The
> > > real method signature is "ntb_mw_get_maprsc()" (look more carefully a=
t the name ending),
> > > which is decrypted as "Mapping Resources", but no "Mapping Source". n=
tb/test/ntb_mw_test.c
> > > driver is developed to demonstrate how the new asynchronous API is ut=
ilized including the
> > > "ntb_mw_get_maprsc()" method usage.
> >=20
> > Right, I misspelled it.  It would be easier to catch a misspelling of r=
agne.
> >=20
> > [PATCH v2 3/3]:
> > +		/* Retrieve the physical address of the memory to map */
> > +		ret =3D ntb_mw_get_maprsc(ntb, mwindx, &outmw->phys_addr,
> > +			&outmw->size);
> > +		if (SUCCESS !=3D ret) {
> > +			dev_err_mw(ctx, "Failed to get map resources of "
> > +				"outbound window %d", mwindx);
> > +			mwindx--;
> > +			goto err_unmap_rsc;
> > +		}
> > +
> > +		/* Map the memory window resources */
> > +		outmw->virt_addr =3D ioremap_nocache(outmw->phys_addr, outmw->size);
> > +
> > +		/* Retrieve the memory windows maximum size and alignments */
> > +		ret =3D ntb_mw_get_align(ntb, mwindx, &outmw->addr_align,
> > +			&outmw->size_align, &outmw->size_max);
> > +		if (SUCCESS !=3D ret) {
> > +			dev_err_mw(ctx, "Failed to get alignment options of "
> > +				"outbound window %d", mwindx);
> > +			goto err_unmap_rsc;
> > +		}
> >=20
> > It looks to me like ntb_mw_get_range() would have been sufficient here.=
  If the change is required by the new driver, please show evidence of that=
.  If this change is not required by the new hardware, please submit the ch=
ange as a separate patch.
> >=20
>=20
> Please, see the comments before.
>=20
> > > > I think ntb_peer_mw_set_trans() and ntb_mw_set_trans() are backward=
s.  Does the
> > > following make sense, or have I completely misunderstood something?
> > > >
> > > > ntb_mw_set_trans(): set up translation so that incoming writes to t=
he memory window are
> > > translated to the local memory destination.
> > > >
> > > > ntb_peer_mw_set_trans(): set up (what exactly?) so that outgoing wr=
ites to a peer memory
> > > window (is this something that needs to be configured on the local nt=
b?) are translated to
> > > the peer ntb (i.e. their port/bridge) memory window.  Then, the peer'=
s setting of
> > > ntb_mw_set_trans() will complete the translation to the peer memory d=
estination.
> > > >
> > >=20
> > > These functions actually do the opposite you described:
> >=20
> > That's the point.  I noticed that they are opposite.
> >=20
> > > ntb_mw_set_trans() - method sets the translated base address retrieve=
d from a peer, so
> > > outgoing writes to a memory window would be translated and reach the =
peer memory
> > > destination.
> >=20
> > In other words, this affects the translation of writes in the direction=
 of the peer memory.  I think this should be named ntb_peer_mw_set_trans().
> >=20
>=20
> Please, see the big comment with illustrations provided before.
>=20
> > > ntb_peer_mw_set_trans() - method sets translated base address to peer=
 configuration space,
> > > so the local incoming writes would be correctly translated on the pee=
r and reach the local
> > > memory destination.
> >=20
> > In other words, this affects the translation for writes in the directio=
n of local memory.  I think this should be named ntb_mw_set_trans().
> >=20
>=20
> Please, see the big comment with illustrations provided before.
>=20
> > > Globally thinking, these methods do the same think, when they called =
from opposite
> > > domains. So to speak locally called "ntb_mw_set_trans()" method does =
the same thing as the
> > > method "ntb_peer_mw_set_trans()" called from a peer, and vise versa t=
he locally called
> > > method "ntb_peer_mw_set_trans()" does the same procedure as the method
> > > "ntb_mw_set_trans()" called from a peer.
> > >=20
> > > To make things simpler, think of memory windows in the framework of t=
he next definition:
> > > "Memory Window is a virtual memory region, which locally reflects a p=
hysical memory of
> > > peer/remote device." So when we call ntb_mw_set_trans(), we initializ=
e the local memory
> > > window, so the locally mapped virtual addresses would be connected wi=
th the peer physical
> > > memory. When we call ntb_peer_mw_set_trans(), we initialize a peer/re=
mote virtual memory
> > > region, so the peer could successfully perform a writes to our local =
physical memory.
> > >=20
> > > Of course all the actual memory read/write operations should follow u=
p ntb_mw_get_maprsc()
> > > and ioremap_nocache() method invocation doublet. You do the same thin=
g in the client test
> > > drivers for AMD and Intel hadrware.
> > >=20
> >=20
> > > > >  /**
> > > > > @@ -751,6 +1053,8 @@ static inline int ntb_db_clear_mask(struct n=
tb_dev *ntb, u64
> > > db_bits)
> > > > >   * append one additional dma memory copy with the doorbell regis=
ter as the
> > > > >   * destination, after the memory copy operations.
> > > > >   *
> > > > > + * This is unusual, and hardware may not be suitable to implemen=
t it.
> > > > > + *
> > > >
> > > > Why is this unusual?  Do you mean async hardware may not support it?
> > > >
> > >=20
> > > Of course I can always return an address of a Doorbell register, but =
it's not safe to do
> > > it working with IDT NTB hardware driver. To make thing explained simp=
ler think a IDT
> > > hardware, which supports the Doorbell bits routing. Each local inboun=
d Doorbell bits of
> > > each port can be configured to either reflect the global switch doorb=
ell bits state or not
> > > to reflect. Global doorbell bits are set by using outbound doorbell r=
egister, which is
> > > exist for every NTB port. Primary port is the port which can have an =
access to multiple
> > > peers, so the Primary port inbound and outbound doorbell registers ar=
e shared between
> > > several NTB devices, sited on the linux kernel NTB bus. As you unders=
tand, these devices
> > > should not interfere each other, which can happen on uncontrollable u=
sage of Doorbell
> > > registers addresses. That's why the method cou "ntb_peer_db_addr()" s=
hould not be
> > > developed for the IDT NTB hardware driver.
> >=20
> > I misread the diff as if this comment was added to the description of n=
tb_db_clear_mask().
> >=20
> > > > > +	if (!ntb->ops->spad_count)
> > > > > +		return -EINVAL;
> > > > > +
> > > >
> > > > Maybe we should return zero (i.e. there are no scratchpads).
> > > >
> > >=20
> > > Agreed. I will fix it in the next patchset.
> >=20
> > Thanks.
> >=20
> > > > > +	if (!ntb->ops->spad_read)
> > > > > +		return 0;
> > > > > +
> > > >
> > > > Let's return ~0.  I think that's what a driver would read from the =
pci bus for a memory
> > > miss.
> > > >
> > >=20
> > > Agreed. I will make it returning -EINVAL in the next patchset.
> >=20
> > I don't think we should try to interpret the returned value as an error=
 number.  If the driver supports this method, and this is a valid scratchpa=
d, the peer can put any value in i, including a value that could be interpr=
eted as an error number.
> >=20
> > A driver shouldn't be using this method if it isn't supported.  But if =
it does, I think ~0 is a better poison value than 0.  I just don't want to =
encourage drivers to try to interpret this value as an error number.
> >=20
>=20
> Understood. The method will return ~0 in the next patchset.
>=20
> > > > > +	if (!ntb->ops->peer_spad_read)
> > > > > +		return 0;
> > > >
> > > > Also, ~0?
> > > >
> > >=20
> > > Agreed. I will make it returning -EINVAL in the next patchset.
> >=20
> > I don't think we should try to interpret the returned value as an error=
 number.
> >=20
>=20
> Understood. The method will return ~0 in the next patchset.
>=20
> > > > > + * ntb_msg_post() - post the message to the peer
> > > > > + * @ntb:	NTB device context.
> > > > > + * @msg:	Message
> > > > > + *
> > > > > + * Post the message to a peer. It shall be delivered to the peer=
 by the
> > > > > + * corresponding hardware method. The peer should be notified ab=
out the new
> > > > > + * message by calling the ntb_msg_event() handler of NTB_MSG_NEW=
 event type.
> > > > > + * If delivery is fails for some reasong the local node will get=
 NTB_MSG_FAIL
> > > > > + * event. Otherwise the NTB_MSG_SENT is emitted.
> > > >
> > > > Interesting.. local driver would be notified about completion (succ=
ess or failure) of
> > > delivery.  Is there any order-of-completion guarantee for the complet=
ion notifications?
> > > Is there some tolerance for faults, in case we never get a completion=
 notification from
> > > the peer (eg. we lose the link)?  If we lose the link, report a local=
 fault, and the link
> > > comes up again, can we still get a completion notification from the p=
eer, and how would
> > > that be handled?
> > > >
> > > > Does delivery mean the application has processed the message, or is=
 it just delivery at
> > > the hardware layer, or just delivery at the ntb hardware driver layer?
> > > >
> > >=20
> > > Let me explain how the message delivery works. When a client driver c=
alls the
> > > "ntb_msg_post()" method, the corresponding message is placed in an ou=
tbound messages
> > > queue. Such the message queue exists for every peer device. Then a de=
dicated kernel work
> > > thread is started to send all the messages from the queue.
> >=20
> > Can we handle the outbound messages queue in an upper layer thread, too=
, instead of a kernel thread in this low level driver?  I think if we provi=
de more direct access to the hardware semantics of the message registers, w=
e will end up with something like the following, which will also simplify t=
he hardware driver.  Leave it to the upper layer to schedule message proces=
sing after receiving an event.
> >=20
> > ntb_msg_event(): we received a hardware interrupt for messages. (don't =
read message status, or anything else)
> >=20
> > ntb_msg_status_read(): read and return MSGSTS bitmask (like ntb_db_read=
()).
> > ntb_msg_status_clear(): clear bits in MSGSTS bitmask (like ntb_db_clear=
()).
> >=20
> > ntb_msg_mask_set(): set bits in MSGSTSMSK (like ntb_db_mask_set()).
> > ntb_msg_mask_clear(): clear bits in MSGSTSMSK (like ntb_db_mask_clear()=
).
> >=20
> > ntb_msg_recv(): read and return INMSG and INMSGSRC of the indicated mes=
sage index.
> > ntb_msg_send(): write the outgoing message register with the message.
> >=20
>=20
> I think such an API would make the interface too complicated. The messagi=
ng is intended to be
> simple for just sharing a small amount of information. Primarily for send=
ing a translation
> address. I would prefer to leave API as it is, since it covers all the ap=
plication needs.
>=20
> > > If kernel thread failed to send
> > > a message (for instance, if the peer IDT NTB hardware driver still ha=
s not freed its
> > > inbound message registers), it performs a new attempt after a small t=
imeout. If after a
> > > preconfigured number of attempts the kernel thread still fails to del=
ivery the message, it
> > > invokes ntb_msg_event() callback with NTB_MSG_FAIL event. If the mess=
age is successfully
> > > delivered, then the method ntb_msg_event() is called with NTB_MSG_SEN=
T event.
> >=20
> > In other words, it was delivered to the peer NTB hardware, and the peer=
 NTB hardware accepted the message into an available register.  It does not=
 mean the peer application processed the message, or even that the peer dri=
ver received an interrupt for the message?
> >=20
>=20
> Of course it doesn't mean, that the application processed the message, bu=
t it does mean that the
> peer hardware raised the MSI interrupt, if the interrupt was enabled.
>=20
> > >=20
> > > To be clear the messsages are transfered directly to the peer memory,=
 but instead they are
> > > placed in the IDT NTB switch registers, then peer is notified about a=
 new message arrived
> > > at the corresponding message registers and the corresponding interrup=
t handler is called.
> > >=20
> > > If we loose the PCI express or NTB link between the IDT switch and a =
peer, then the
> > > ntb_msg_event() method is called with NTB_MSG_FAIL event.
> >=20
> > Byzantine fault is an unsolvable class of problem, so it is important t=
o be clear exactly what is supposed to be guaranteed at each layer.  If we =
get a hardware ACK that the message was delivered, that means it was delive=
red to the NTB hardware register, but no further.  If we do not get a hardw=
are NAK(?), that means it was not delivered.  If the link fails or we time =
out waiting for a completion, we can only guess that it wasn't delivered ev=
en though there is a small chance it was.  Applications need to be tolerant=
 either way, and needs may be different depending on the application.  I wo=
uld rather not add any fault tolerance (other than reporting faults) at thi=
s layer that is not already implemented in the hardware.
> >=20
> > Reading the description of OUTMSGSTS register, it is clear that we can =
receive a hardware NAK if an outgoing message failed.  It's not clear to me=
 that IDT will notify any kind of ACK that an outgoing message was accepted=
.  If an application wants to send two messages, it can send the first, che=
ck the bit and see there is no failure.  Does reading the status immediatel=
y after sending guarantee the message WAS delivered (i.e. IDT NTB hardware =
blocks reading the status register while there are messages in flight)?  If=
 not, if the application sends the second message and then sees a failure, =
how can the application be sure the failure is not for the first message?  =
Does the application have to wait some time (how long?) before checking the=
 message status?
> >=20
>=20
> Ok, I think I need to explain it carefully. When a local Root Complex sen=
ds a message to a peer,
> it writes a message to its outgoing message registers, which are connecte=
d with the peer incoming
> message registers. If that incoming message registers are still full, so =
peer has not emptied them
> by clearing a corresponding bit, then a local Root Complex gets a so call=
ed NACK, on the other
> words it failed to send a message. Then it tries to send the message agai=
n and again before a next
> attempt is either succeeded or a limited number of attempts is exceeded. =
Last one would lead to
> rising a NTB_MSG_FAIL event.
>=20
> On the other hand before sending a message IDT driver checks whether the =
NTB link is up, if it isn't
> then it raises NTB_MSG_FAIL event.
>=20
> After all the discussions I am starting to realize what is the problem. T=
he problem is that we
> might have differently pictures of how NTB hardware are connected.) Tradi=
tional Intel/AMD NTB
> hardware are directly connected to each other so there is only one PCIe-l=
ink between two Root
> Complexes, but IDT bridge is kind of single intermediate device, which ha=
s at least two NTB ports
> connected to Root Complexes by different PCIe-links. So when one sends a =
message to another and
> it's accepted by hardware, then the message was put to the incoming messa=
ge register of the IDT
> opposite port, and the peer Root Complex is just notified that a new mess=
age has arrived.
>=20
> > >=20
> > > Finally, I've answered to all the questions. Hopefully the things loo=
k clearer now.
> > >=20
> > > Regards,
> > > -Sergey
> >=20
> >=20
