Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x241.google.com (mail-lf0-x241.google.com. [2a00:1450:4010:c07::241])
        by gmr-mx.google.com with ESMTPS id i193si845478wmg.1.2016.08.07.10.50.54
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Aug 2016 10:50:54 -0700 (PDT)
Received: by mail-lf0-x241.google.com with SMTP id f93so19129829lfi.0
        for <linux-ntb@googlegroups.com>; Sun, 07 Aug 2016 10:50:54 -0700 (PDT)
Return-Path: <fancer.lancer@gmail.com>
Date: Sun, 7 Aug 2016 20:50:48 +0300
From: Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH v2 1/3] ntb: Add asynchronous devices support to NTB-bus
 interface
Message-ID: <20160807175048.GA30967@mobilestation>
References: <001401d1ef2e$8212f6b0$8638e410$@emc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <001401d1ef2e$8212f6b0$8638e410$@emc.com>
To: Allen Hubbe <Allen.Hubbe@emc.com>
Cc: jdmason@kudzu.us, dave.jiang@intel.com, Xiangliang.Yu@amd.com, Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

Hello Allen.

Thanks for your careful review. Going through this mailing thread I hope we=
'll come up with solutions, which improve the driver code as well as extend=
 the Linux kernel support of new devices like IDT PCIe-swtiches.

Before getting to the inline commentaries I need to give some introduction =
to the IDT NTB-related hardware so we could speak on the same language. Add=
itionally I'll give a brief explanation how the setup of memory windows wor=
ks in IDT PCIe-switches.

First of all, before getting into the IDT NTB driver development I had made=
 a research of the currently developed NTB kernel API and AMD/Intel hardwar=
e drivers. Due to lack of the hardware manuals It might be not in deep deta=
ils, but I understand how the AMD/Intel NTB-hardware drivers work. At least=
 I understand the concept of memory windowing, which led to the current NTB=
 bus kernel API.

So lets get to IDT PCIe-switches. There is a whole series of NTB-related sw=
itches IDT produces. All of them I split into two distinct groups:
1) Two NTB-ported switches (models 89PES8NT2, 89PES16NT2, 89PES12NT3, 89PES=
124NT3),
2) Multi NTB-ported switches (models 89HPES24NT6AG2, 89HPES32NT8AG2, 89HPES=
32NT8BG2, 89HPES12NT12G2, 89HPES16NT16G2, 89HPES24NT24G2, 89HPES32NT24AG2, =
89HPES32NT24BG2).
Just to note all of these switches are a part of IDT PRECISE(TM) family of =
PCI Express=AE switching solutions. Why do I split them up? Because of the =
next reasons:
1) Number of upstream ports, which have access to NTB functions (obviously,=
 yeah? =3D)). So the switches of the first group can connect just two domai=
ns over NTB. Unlike the second group of switches, which expose a way to set=
up an interaction between several PCIe-switch ports, which have NT-function=
 activated.
2) The groups are significantly distinct by the way of NT-functions configu=
ration.

Before getting further, I should note, that the uploaded driver supports th=
e second group of devices only. But still I'll give a comparative explanati=
on, since the first group of switches is very similar to the AMD/Intel NTBs.

Lets dive into the configurations a bit deeper. Particularly NT-functions o=
f the first group of switches can be configured the same way as AMD/Intel N=
TB-functions are. There is an PCIe end-point configuration space, which ful=
ly reflects the cross-coupled local and peer PCIe/NTB settings. So local Ro=
ot complex can set any of the peer registers by direct writing to mapped me=
mory. Here is the image, which perfectly explains the configuration registe=
rs mapping:
https://s8.postimg.org/3nhkzqfxx/IDT_NTB_old_configspace.png
Since the first group switches connect only two root complexes, the race co=
ndition of read/write operations to cross-coupled registers can be easily r=
esolved just by roles distribution. So local root complex sets the translat=
ed base address directly to a peer configuration space registers, which cor=
respond to BAR0-BAR3 locally mapped memory windows. Of course 2-4 memory wi=
ndows is enough to connect just two domains. That's why you made the NTB bu=
s kernel API the way it is.

The things get different when one wants to have an access from one domain t=
o multiple coupling up to eight root complexes in the second group of switc=
hes. First of all the hardware doesn't support the configuration space cros=
s-coupling anymore. Instead there are two Global Address Space Access regis=
ters provided to have an access to a peers configuration space. In fact it =
is not a big problem, since there are no much differences in accessing regi=
sters over a memory mapped space or a pair of fixed Address/Data registers.=
 The problem arises when one wants to share a memory windows between eight =
domains. Five BARs are not enough for it even if they'd be configured to be=
 of x32 address type. Instead IDT introduces Lookup table address translati=
on. So BAR2/BAR4 can be configured to translate addresses using 12 or 24 en=
tries lookup tables. Each entry can be initialized with translated base add=
ress of a peer and IDT switch port, which peer is connected to. So when loc=
al root complex locally maps BAR2/BAR4, one can have an access to a memory =
of a peer just by reading/writing with a shift corresponding to the lookup =
table entry. That's how more than five peers can be accessed. The root prob=
lem is the way the lookup table is accessed. Alas It is accessed only by a =
pair of "Entry index/Data" registers. So a root complex must write an entry=
 index to one registers, then read/write data from another. As you might re=
alise, that weak point leads to a race condition of multiple root complexes=
 accessing the lookup table of one shared peer. Alas I could not come up wi=
th a simple and strong solution of the race.

That's why I've introduced the asynchronous hardware in the NTB bus kernel =
API. Since local root complex can't directly write a translated base addres=
s to a peer, it must wait until a peer asks him to allocate a memory and se=
nd the address back using some of a hardware mechanism. It can be anything:=
 Scratchpad registers, Message registers or even "crazy" doorbells bingbang=
ing. For instance, the IDT switches of the first group support:
1) Shared Memory windows. In particular local root complex can set a transl=
ated base address to BARs of local and peer NT-function using the cross-cou=
pled PCIe/NTB configuration space, the same way as it can be done for AMD/I=
ntel NTBs.
2) One Doorbell register.
3) Two Scratchpads.
4) Four message regietsrs.
As you can see the switches of the first group can be considered as both sy=
nchronous and asynchronous. All the NTB bus kernel API can be implemented f=
or it including the changes introduced by this patch (I would do it if I ha=
d a corresponding hardware). AMD and Intel NTBs can be considered both sync=
hronous and asynchronous as well, although they don't support messaging so =
Scratchpads can be used to send a data to a peer. Finally the switches of t=
he second group lack of ability to initialize BARs translated base address =
of peers due to the race condition I described before.

To sum up I've spent a lot of time designing the IDT NTB driver. I've done =
my best to make the IDT driver as much compatible with current design as po=
ssible, nevertheless the NTB bus kernel API had to be slightly changed. You=
 can find answers to the commentaries down below.

On Fri, Aug 05, 2016 at 11:31:58AM -0400, Allen Hubbe <Allen.Hubbe@emc.com>=
 wrote:
> From: Serge Semin
> > Currently supported AMD and Intel Non-transparent PCIe-bridges are sync=
hronous
> > devices, so translated base address of memory windows can be direcly wr=
itten
> > to peer registers. But there are some IDT PCIe-switches which implement
> > complex interfaces using Lookup Tables of translation addresses. Due to
> > the way the table is accessed, it can not be done synchronously from di=
fferent
> > RCs, that's why the asynchronous interface should be developed.
> >=20
> > For these purpose the Memory Window related interface is correspondingl=
y split
> > as it is for Doorbell and Scratchpad registers. The definition of Memor=
y Window
> > is following: "It is a virtual memory region, which locally reflects a =
physical
> > memory of peer device." So to speak the "ntb_peer_mw_"-prefixed methods=
 control
> > the peers memory windows, "ntb_mw_"-prefixed functions work with the lo=
cal
> > memory windows.
> > Here is the description of the Memory Window related NTB-bus callback
> > functions:
> >  - ntb_mw_count() - number of local memory windows.
> >  - ntb_mw_get_maprsc() - get the physical address and size of the local=
 memory
> >                          window to map.
> >  - ntb_mw_set_trans() - set translation address of local memory window =
(this
> >                         address should be somehow retrieved from a peer=
).
> >  - ntb_mw_get_trans() - get translation address of local memory window.
> >  - ntb_mw_get_align() - get alignment of translated base address and si=
ze of
> >                         local memory window. Additionally one can get t=
he
> >                         upper size limit of the memory window.
> >  - ntb_peer_mw_count() - number of peer memory windows (it can differ f=
rom the
> >                          local number).
> >  - ntb_peer_mw_set_trans() - set translation address of peer memory win=
dow
> >  - ntb_peer_mw_get_trans() - get translation address of peer memory win=
dow
> >  - ntb_peer_mw_get_align() - get alignment of translated base address a=
nd size
> >                              of peer memory window.Additionally one can=
 get the
> >                              upper size limit of the memory window.
> >=20
> > As one can see current AMD and Intel NTB drivers mostly implement the
> > "ntb_peer_mw_"-prefixed methods. So this patch correspondingly renames =
the
> > driver functions. IDT NTB driver mostly expose "ntb_nw_"-prefixed metho=
ds,
> > since it doesn't have convenient access to the peer Lookup Table.
> >=20
> > In order to pass information from one RC to another NTB functions of IDT
> > PCIe-switch implement Messaging subsystem. They currently support four =
message
> > registers to transfer DWORD sized data to a specified peer. So there ar=
e two
> > new callback methods are introduced:
> >  - ntb_msg_size() - get the number of DWORDs supported by NTB function =
to send
> >                     and receive messages
> >  - ntb_msg_post() - send message of size retrieved from ntb_msg_size()
> >                     to a peer
> > Additionally there is a new event function:
> >  - ntb_msg_event() - it is invoked when either a new message was retrie=
ved
> >                      (NTB_MSG_NEW), or last message was successfully se=
nt
> >                      (NTB_MSG_SENT), or the last message failed to be s=
ent
> >                      (NTB_MSG_FAIL).
> >=20
> > The last change concerns the IDs (practically names) of NTB-devices on =
the
> > NTB-bus. It is not good to have the devices with same names in the syst=
em
> > and it brakes my IDT NTB driver from being loaded =3D) So I developed a=
 simple
> > algorithm of NTB devices naming. Particulary it generates names "ntbS{N=
}" for
> > synchronous devices, "ntbA{N}" for asynchronous devices, and "ntbAS{N}"=
 for
> > devices supporting both interfaces.
>=20
> Thanks for the work that went into writing this driver, and thanks for yo=
ur patience with the review.  Please read my initial comments inline.  I wo=
uld like to approach this from a top-down api perspective first, and settle=
 on that first before requesting any specific changes in the hardware drive=
r.  My major concern about these changes is that they introduce a distinct =
classification for sync and async hardware, supported by different sets of =
methods in the api, neither is a subset of the other.
>=20
> You know the IDT hardware, so if any of my requests below are infeasible,=
 I would like your constructive opinion (even if it means significant chang=
es to existing drivers) on how to resolve the api so that new and existing =
hardware drivers can be unified under the same api, if possible.

I understand your concern. I have been thinking of this a lot. In my opinio=
n the proposed in this patch alterations are the best of all variants I've =
been thinking about. Regarding the lack of APIs subset. In fact I would not=
 agree with that. As I described in the introduction AMD and Intel drivers =
can be considered as both synchronous and asynchronous, since a translated =
base address can be directly set in a local and peer configuration space. A=
lthough AMD and Intel devices don't support messaging, they have Scratchpad=
s, which can be used to exchange an information between root complexes. The=
 thing we need to do is to implement ntb_mw_set_trans() and ntb_mw_get_alig=
n() for them. Which isn't much different from the "mw_peer"-prefixed ones. =
The first method just sets a translated base address to the corresponding l=
ocal register. The second one does exactly the same as "mw_peer"-prefixed o=
nes. I would do it, but I haven't got a hardware to test, that's why I left=
 things the way it was with just slight changes of names.

>=20
> >=20
> > Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> >=20
> > ---
> >  drivers/ntb/Kconfig                 |   4 +-
> >  drivers/ntb/hw/amd/ntb_hw_amd.c     |  49 ++-
> >  drivers/ntb/hw/intel/ntb_hw_intel.c |  59 +++-
> >  drivers/ntb/ntb.c                   |  86 +++++-
> >  drivers/ntb/ntb_transport.c         |  19 +-
> >  drivers/ntb/test/ntb_perf.c         |  16 +-
> >  drivers/ntb/test/ntb_pingpong.c     |   5 +
> >  drivers/ntb/test/ntb_tool.c         |  25 +-
> >  include/linux/ntb.h                 | 600 ++++++++++++++++++++++++++++=
+-------
> >  9 files changed, 701 insertions(+), 162 deletions(-)
> >=20
> > diff --git a/drivers/ntb/Kconfig b/drivers/ntb/Kconfig
> > index 95944e5..67d80c4 100644
> > --- a/drivers/ntb/Kconfig
> > +++ b/drivers/ntb/Kconfig
> > @@ -14,8 +14,6 @@ if NTB
> >=20
> >  source "drivers/ntb/hw/Kconfig"
> >=20
> > -source "drivers/ntb/test/Kconfig"
> > -
> >  config NTB_TRANSPORT
> >  	tristate "NTB Transport Client"
> >  	help
> > @@ -25,4 +23,6 @@ config NTB_TRANSPORT
> >=20
> >  	 If unsure, say N.
> >=20
> > +source "drivers/ntb/test/Kconfig"
> > +
> >  endif # NTB
> > diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_h=
w_amd.c
> > index 6ccba0d..ab6f353 100644
> > --- a/drivers/ntb/hw/amd/ntb_hw_amd.c
> > +++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
> > @@ -55,6 +55,7 @@
> >  #include <linux/pci.h>
> >  #include <linux/random.h>
> >  #include <linux/slab.h>
> > +#include <linux/sizes.h>
> >  #include <linux/ntb.h>
> >=20
> >  #include "ntb_hw_amd.h"
> > @@ -84,11 +85,8 @@ static int amd_ntb_mw_count(struct ntb_dev *ntb)
> >  	return ntb_ndev(ntb)->mw_count;
> >  }
> >=20
> > -static int amd_ntb_mw_get_range(struct ntb_dev *ntb, int idx,
> > -				phys_addr_t *base,
> > -				resource_size_t *size,
> > -				resource_size_t *align,
> > -				resource_size_t *align_size)
> > +static int amd_ntb_mw_get_maprsc(struct ntb_dev *ntb, int idx,
> > +				 phys_addr_t *base, resource_size_t *size)
> >  {
> >  	struct amd_ntb_dev *ndev =3D ntb_ndev(ntb);
> >  	int bar;
> > @@ -103,17 +101,40 @@ static int amd_ntb_mw_get_range(struct ntb_dev *n=
tb, int idx,
> >  	if (size)
> >  		*size =3D pci_resource_len(ndev->ntb.pdev, bar);
> >=20
> > -	if (align)
> > -		*align =3D SZ_4K;
> > +	return 0;
> > +}
> > +
> > +static int amd_ntb_peer_mw_count(struct ntb_dev *ntb)
> > +{
> > +	return ntb_ndev(ntb)->mw_count;
> > +}
> > +
> > +static int amd_ntb_peer_mw_get_align(struct ntb_dev *ntb, int idx,
> > +				     resource_size_t *addr_align,
> > +				     resource_size_t *size_align,
> > +				     resource_size_t *size_max)
> > +{
> > +	struct amd_ntb_dev *ndev =3D ntb_ndev(ntb);
> > +	int bar;
> > +
> > +	bar =3D ndev_mw_to_bar(ndev, idx);
> > +	if (bar < 0)
> > +		return bar;
> > +
> > +	if (addr_align)
> > +		*addr_align =3D SZ_4K;
> > +
> > +	if (size_align)
> > +		*size_align =3D 1;
> >=20
> > -	if (align_size)
> > -		*align_size =3D 1;
> > +	if (size_max)
> > +		*size_max =3D pci_resource_len(ndev->ntb.pdev, bar);
> >=20
> >  	return 0;
> >  }
> >=20
> > -static int amd_ntb_mw_set_trans(struct ntb_dev *ntb, int idx,
> > -				dma_addr_t addr, resource_size_t size)
> > +static int amd_ntb_peer_mw_set_trans(struct ntb_dev *ntb, int idx,
> > +				     dma_addr_t addr, resource_size_t size)
> >  {
> >  	struct amd_ntb_dev *ndev =3D ntb_ndev(ntb);
> >  	unsigned long xlat_reg, limit_reg =3D 0;
> > @@ -432,8 +453,10 @@ static int amd_ntb_peer_spad_write(struct ntb_dev =
*ntb,
> >=20
> >  static const struct ntb_dev_ops amd_ntb_ops =3D {
> >  	.mw_count		=3D amd_ntb_mw_count,
> > -	.mw_get_range		=3D amd_ntb_mw_get_range,
> > -	.mw_set_trans		=3D amd_ntb_mw_set_trans,
> > +	.mw_get_maprsc		=3D amd_ntb_mw_get_maprsc,
> > +	.peer_mw_count		=3D amd_ntb_peer_mw_count,
> > +	.peer_mw_get_align	=3D amd_ntb_peer_mw_get_align,
> > +	.peer_mw_set_trans	=3D amd_ntb_peer_mw_set_trans,
> >  	.link_is_up		=3D amd_ntb_link_is_up,
> >  	.link_enable		=3D amd_ntb_link_enable,
> >  	.link_disable		=3D amd_ntb_link_disable,
> > diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.c b/drivers/ntb/hw/intel=
/ntb_hw_intel.c
> > index 40d04ef..fdb2838 100644
> > --- a/drivers/ntb/hw/intel/ntb_hw_intel.c
> > +++ b/drivers/ntb/hw/intel/ntb_hw_intel.c
> > @@ -804,11 +804,8 @@ static int intel_ntb_mw_count(struct ntb_dev *ntb)
> >  	return ntb_ndev(ntb)->mw_count;
> >  }
> >=20
> > -static int intel_ntb_mw_get_range(struct ntb_dev *ntb, int idx,
> > -				  phys_addr_t *base,
> > -				  resource_size_t *size,
> > -				  resource_size_t *align,
> > -				  resource_size_t *align_size)
> > +static int intel_ntb_mw_get_maprsc(struct ntb_dev *ntb, int idx,
> > +				   phys_addr_t *base, resource_size_t *size)
> >  {
> >  	struct intel_ntb_dev *ndev =3D ntb_ndev(ntb);
> >  	int bar;
> > @@ -828,17 +825,51 @@ static int intel_ntb_mw_get_range(struct ntb_dev =
*ntb, int idx,
> >  		*size =3D pci_resource_len(ndev->ntb.pdev, bar) -
> >  			(idx =3D=3D ndev->b2b_idx ? ndev->b2b_off : 0);
> >=20
> > -	if (align)
> > -		*align =3D pci_resource_len(ndev->ntb.pdev, bar);
> > +	return 0;
> > +}
> > +
> > +static int intel_ntb_peer_mw_count(struct ntb_dev *ntb)
> > +{
> > +	return ntb_ndev(ntb)->mw_count;
> > +}
> > +
> > +static int intel_ntb_peer_mw_get_align(struct ntb_dev *ntb, int idx,
> > +				       resource_size_t *addr_align,
> > +				       resource_size_t *size_align,
> > +				       resource_size_t *size_max)
> > +{
> > +	struct intel_ntb_dev *ndev =3D ntb_ndev(ntb);
> > +	resource_size_t bar_size, mw_size;
> > +	int bar;
> > +
> > +	if (idx >=3D ndev->b2b_idx && !ndev->b2b_off)
> > +		idx +=3D 1;
> > +
> > +	bar =3D ndev_mw_to_bar(ndev, idx);
> > +	if (bar < 0)
> > +		return bar;
> > +
> > +	bar_size =3D pci_resource_len(ndev->ntb.pdev, bar);
> > +
> > +	if (idx =3D=3D ndev->b2b_idx)
> > +		mw_size =3D bar_size - ndev->b2b_off;
> > +	else
> > +		mw_size =3D bar_size;
> > +
> > +	if (addr_align)
> > +		*addr_align =3D bar_size;
> > +
> > +	if (size_align)
> > +		*size_align =3D 1;
> >=20
> > -	if (align_size)
> > -		*align_size =3D 1;
> > +	if (size_max)
> > +		*size_max =3D mw_size;
> >=20
> >  	return 0;
> >  }
> >=20
> > -static int intel_ntb_mw_set_trans(struct ntb_dev *ntb, int idx,
> > -				  dma_addr_t addr, resource_size_t size)
> > +static int intel_ntb_peer_mw_set_trans(struct ntb_dev *ntb, int idx,
> > +				       dma_addr_t addr, resource_size_t size)
> >  {
> >  	struct intel_ntb_dev *ndev =3D ntb_ndev(ntb);
> >  	unsigned long base_reg, xlat_reg, limit_reg;
> > @@ -2220,8 +2251,10 @@ static struct intel_b2b_addr xeon_b2b_dsd_addr =
=3D {
> >  /* operations for primary side of local ntb */
> >  static const struct ntb_dev_ops intel_ntb_ops =3D {
> >  	.mw_count		=3D intel_ntb_mw_count,
> > -	.mw_get_range		=3D intel_ntb_mw_get_range,
> > -	.mw_set_trans		=3D intel_ntb_mw_set_trans,
> > +	.mw_get_maprsc		=3D intel_ntb_mw_get_maprsc,
> > +	.peer_mw_count		=3D intel_ntb_peer_mw_count,
> > +	.peer_mw_get_align	=3D intel_ntb_peer_mw_get_align,
> > +	.peer_mw_set_trans	=3D intel_ntb_peer_mw_set_trans,
> >  	.link_is_up		=3D intel_ntb_link_is_up,
> >  	.link_enable		=3D intel_ntb_link_enable,
> >  	.link_disable		=3D intel_ntb_link_disable,
> > diff --git a/drivers/ntb/ntb.c b/drivers/ntb/ntb.c
> > index 2e25307..37c3b36 100644
> > --- a/drivers/ntb/ntb.c
> > +++ b/drivers/ntb/ntb.c
> > @@ -54,6 +54,7 @@
> >  #include <linux/device.h>
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> > +#include <linux/atomic.h>
> >=20
> >  #include <linux/ntb.h>
> >  #include <linux/pci.h>
> > @@ -72,8 +73,62 @@ MODULE_AUTHOR(DRIVER_AUTHOR);
> >  MODULE_DESCRIPTION(DRIVER_DESCRIPTION);
> >=20
> >  static struct bus_type ntb_bus;
> > +static struct ntb_bus_data ntb_data;
> >  static void ntb_dev_release(struct device *dev);
> >=20
> > +static int ntb_gen_devid(struct ntb_dev *ntb)
> > +{
> > +	const char *name;
> > +	unsigned long *mask;
> > +	int id;
> > +
> > +	if (ntb_valid_sync_dev_ops(ntb) && ntb_valid_async_dev_ops(ntb)) {
> > +		name =3D "ntbAS%d";
> > +		mask =3D ntb_data.both_msk;
> > +	} else if (ntb_valid_sync_dev_ops(ntb)) {
> > +		name =3D "ntbS%d";
> > +		mask =3D ntb_data.sync_msk;
> > +	} else if (ntb_valid_async_dev_ops(ntb)) {
> > +		name =3D "ntbA%d";
> > +		mask =3D ntb_data.async_msk;
> > +	} else {
> > +		return -EINVAL;
> > +	}
> > +
> > +	for (id =3D 0; NTB_MAX_DEVID > id; id++) {
> > +		if (0 =3D=3D test_and_set_bit(id, mask)) {
> > +			ntb->id =3D id;
> > +			break;
> > +		}
> > +	}
> > +
> > +	if (NTB_MAX_DEVID > id) {
> > +		dev_set_name(&ntb->dev, name, ntb->id);
> > +	} else {
> > +		return -ENOMEM;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void ntb_free_devid(struct ntb_dev *ntb)
> > +{
> > +	unsigned long *mask;
> > +
> > +	if (ntb_valid_sync_dev_ops(ntb) && ntb_valid_async_dev_ops(ntb)) {
> > +		mask =3D ntb_data.both_msk;
> > +	} else if (ntb_valid_sync_dev_ops(ntb)) {
> > +		mask =3D ntb_data.sync_msk;
> > +	} else if (ntb_valid_async_dev_ops(ntb)) {
> > +		mask =3D ntb_data.async_msk;
> > +	} else {
> > +		/* It's impossible */
> > +		BUG();
> > +	}
> > +
> > +	clear_bit(ntb->id, mask);
> > +}
> > +
> >  int __ntb_register_client(struct ntb_client *client, struct module *mo=
d,
> >  			  const char *mod_name)
> >  {
> > @@ -99,13 +154,15 @@ EXPORT_SYMBOL(ntb_unregister_client);
> >=20
> >  int ntb_register_device(struct ntb_dev *ntb)
> >  {
> > +	int ret;
> > +
> >  	if (!ntb)
> >  		return -EINVAL;
> >  	if (!ntb->pdev)
> >  		return -EINVAL;
> >  	if (!ntb->ops)
> >  		return -EINVAL;
> > -	if (!ntb_dev_ops_is_valid(ntb->ops))
> > +	if (!ntb_valid_sync_dev_ops(ntb) && !ntb_valid_async_dev_ops(ntb))
> >  		return -EINVAL;
> >=20
> >  	init_completion(&ntb->released);
> > @@ -114,13 +171,21 @@ int ntb_register_device(struct ntb_dev *ntb)
> >  	ntb->dev.bus =3D &ntb_bus;
> >  	ntb->dev.parent =3D &ntb->pdev->dev;
> >  	ntb->dev.release =3D ntb_dev_release;
> > -	dev_set_name(&ntb->dev, "%s", pci_name(ntb->pdev));
> >=20
> >  	ntb->ctx =3D NULL;
> >  	ntb->ctx_ops =3D NULL;
> >  	spin_lock_init(&ntb->ctx_lock);
> >=20
> > -	return device_register(&ntb->dev);
> > +	/* No need to wait for completion if failed */
> > +	ret =3D ntb_gen_devid(ntb);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D device_register(&ntb->dev);
> > +	if (ret)
> > +		ntb_free_devid(ntb);
> > +
> > +	return ret;
> >  }
> >  EXPORT_SYMBOL(ntb_register_device);
> >=20
> > @@ -128,6 +193,7 @@ void ntb_unregister_device(struct ntb_dev *ntb)
> >  {
> >  	device_unregister(&ntb->dev);
> >  	wait_for_completion(&ntb->released);
> > +	ntb_free_devid(ntb);
> >  }
> >  EXPORT_SYMBOL(ntb_unregister_device);
> >=20
> > @@ -191,6 +257,20 @@ void ntb_db_event(struct ntb_dev *ntb, int vector)
> >  }
> >  EXPORT_SYMBOL(ntb_db_event);
> >=20
> > +void ntb_msg_event(struct ntb_dev *ntb, enum NTB_MSG_EVENT ev,
> > +		   struct ntb_msg *msg)
> > +{
> > +	unsigned long irqflags;
> > +
> > +	spin_lock_irqsave(&ntb->ctx_lock, irqflags);
> > +	{
> > +		if (ntb->ctx_ops && ntb->ctx_ops->msg_event)
> > +			ntb->ctx_ops->msg_event(ntb->ctx, ev, msg);
> > +	}
> > +	spin_unlock_irqrestore(&ntb->ctx_lock, irqflags);
> > +}
> > +EXPORT_SYMBOL(ntb_msg_event);
> > +
> >  static int ntb_probe(struct device *dev)
> >  {
> >  	struct ntb_dev *ntb;
> > diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> > index d5c5894..2626ba0 100644
> > --- a/drivers/ntb/ntb_transport.c
> > +++ b/drivers/ntb/ntb_transport.c
> > @@ -673,7 +673,7 @@ static void ntb_free_mw(struct ntb_transport_ctx *n=
t, int num_mw)
> >  	if (!mw->virt_addr)
> >  		return;
> >=20
> > -	ntb_mw_clear_trans(nt->ndev, num_mw);
> > +	ntb_peer_mw_set_trans(nt->ndev, num_mw, 0, 0);
> >  	dma_free_coherent(&pdev->dev, mw->buff_size,
> >  			  mw->virt_addr, mw->dma_addr);
> >  	mw->xlat_size =3D 0;
> > @@ -730,7 +730,8 @@ static int ntb_set_mw(struct ntb_transport_ctx *nt,=
 int num_mw,
> >  	}
> >=20
> >  	/* Notify HW the memory location of the receive buffer */
> > -	rc =3D ntb_mw_set_trans(nt->ndev, num_mw, mw->dma_addr, mw->xlat_size=
);
> > +	rc =3D ntb_peer_mw_set_trans(nt->ndev, num_mw, mw->dma_addr,
> > +				   mw->xlat_size);
> >  	if (rc) {
> >  		dev_err(&pdev->dev, "Unable to set mw%d translation", num_mw);
> >  		ntb_free_mw(nt, num_mw);
> > @@ -1060,7 +1061,11 @@ static int ntb_transport_probe(struct ntb_client=
 *self, struct
> > ntb_dev *ndev)
> >  	int node;
> >  	int rc, i;
> >=20
> > -	mw_count =3D ntb_mw_count(ndev);
> > +	/* Synchronous hardware is only supported */
> > +	if (!ntb_valid_sync_dev_ops(ndev))
> > +		return -EINVAL;
> > +
> > +	mw_count =3D ntb_peer_mw_count(ndev);
> >  	if (ntb_spad_count(ndev) < (NUM_MWS + 1 + mw_count * 2)) {
> >  		dev_err(&ndev->dev, "Not enough scratch pad registers for %s",
> >  			NTB_TRANSPORT_NAME);
> > @@ -1094,8 +1099,12 @@ static int ntb_transport_probe(struct ntb_client=
 *self, struct
> > ntb_dev *ndev)
> >  	for (i =3D 0; i < mw_count; i++) {
> >  		mw =3D &nt->mw_vec[i];
> >=20
> > -		rc =3D ntb_mw_get_range(ndev, i, &mw->phys_addr, &mw->phys_size,
> > -				      &mw->xlat_align, &mw->xlat_align_size);
> > +		rc =3D ntb_mw_get_maprsc(ndev, i, &mw->phys_addr, &mw->phys_size);
> > +		if (rc)
> > +			goto err1;
> > +
> > +		rc =3D ntb_peer_mw_get_align(ndev, i, &mw->xlat_align,
> > +					   &mw->xlat_align_size, NULL);
>=20
> Looks like ntb_mw_get_range() was simpler before the change.
>=20

If I didn't change NTB bus kernel API, I would have split them up anyway. F=
irst of all functions with long argument list look more confusing, than one=
s with shorter list. It helps to stick to the "80 character per line" rule =
and improves readability. Secondly the function splitting improves the read=
ability of the code in general. When I first saw the function name "ntb_mw_=
get_range()", it was not obvious what kind of ranges this function returned=
=2E The function lacked of "high code coherence" unofficial rule. It is bet=
ter when one function does one coherent thing and return a well coherent da=
ta. Particularly function "ntb_mw_get_range()" returned a local memory wind=
ows mapping address and size, as well as alignment of memory allocated for =
a peer. So now "ntb_mw_get_maprsc()" method returns mapping resources. If l=
ocal NTB client driver is not going to allocate any memory, so one just doe=
sn't need to call "ntb_peer_mw_get_align()" method at all. I understand, th=
at a client driver could pass NULL to a unused arguments of the "ntb_mw_get=
_range()", but still the new design is better readable.

Additionally I've split them up because of the difference in the way the as=
ynchronous interface works. IDT driver can not safely perform ntb_peer_mw_s=
et_trans(), that's why I had to add ntb_mw_set_trans(). Each of that method=
 should logically have related "ntb_*mw_get_align()" method. Method ntb_mw_=
get_align() shall give to a local client driver a hint how the retrieved fr=
om the peer translated base address should be aligned, so ntb_mw_set_trans(=
) method would successfully return. Method ntb_peer_mw_get_align() will giv=
e a hint how the local memory buffer should be allocated to fulfil a peer t=
ranslated base address alignment. In this way it returns restrictions for p=
arameters of "ntb_peer_mw_set_trans()".

Finally, IDT driver is designed so Primary and Secondary ports can support =
a different number of memory windows. In this way methods "ntb_mw_get_maprs=
c()/ntb_mw_set_trans()/ntb_mw_get_trans()/ntb_mw_get_align()" have differen=
t range of acceptable values of the second argument, which is determined by=
 the "ntb_mw_count()" method, comparing to methods "ntb_peer_mw_set_trans()=
/ntb_peer_mw_get_trans()/ntb_peer_mw_get_align()", which memory windows ind=
ex restriction is determined by the "ntb_peer_mw_count()" method.

So to speak the splitting was really necessary to make the API looking more=
 logical.

> >  		if (rc)
> >  			goto err1;
> >=20
> > diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
> > index 6a50f20..f2952f7 100644
> > --- a/drivers/ntb/test/ntb_perf.c
> > +++ b/drivers/ntb/test/ntb_perf.c
> > @@ -452,7 +452,7 @@ static void perf_free_mw(struct perf_ctx *perf)
> >  	if (!mw->virt_addr)
> >  		return;
> >=20
> > -	ntb_mw_clear_trans(perf->ntb, 0);
> > +	ntb_peer_mw_set_trans(perf->ntb, 0, 0, 0);
> >  	dma_free_coherent(&pdev->dev, mw->buf_size,
> >  			  mw->virt_addr, mw->dma_addr);
> >  	mw->xlat_size =3D 0;
> > @@ -488,7 +488,7 @@ static int perf_set_mw(struct perf_ctx *perf, resou=
rce_size_t size)
> >  		mw->buf_size =3D 0;
> >  	}
> >=20
> > -	rc =3D ntb_mw_set_trans(perf->ntb, 0, mw->dma_addr, mw->xlat_size);
> > +	rc =3D ntb_peer_mw_set_trans(perf->ntb, 0, mw->dma_addr, mw->xlat_siz=
e);
> >  	if (rc) {
> >  		dev_err(&perf->ntb->dev, "Unable to set mw0 translation\n");
> >  		perf_free_mw(perf);
> > @@ -559,8 +559,12 @@ static int perf_setup_mw(struct ntb_dev *ntb, stru=
ct perf_ctx *perf)
> >=20
> >  	mw =3D &perf->mw;
> >=20
> > -	rc =3D ntb_mw_get_range(ntb, 0, &mw->phys_addr, &mw->phys_size,
> > -			      &mw->xlat_align, &mw->xlat_align_size);
> > +	rc =3D ntb_mw_get_maprsc(ntb, 0, &mw->phys_addr, &mw->phys_size);
> > +	if (rc)
> > +		return rc;
> > +
> > +	rc =3D ntb_peer_mw_get_align(ntb, 0, &mw->xlat_align,
> > +				   &mw->xlat_align_size, NULL);
>=20
> Looks like ntb_mw_get_range() was simpler.
>=20

See the previous answer.

> >  	if (rc)
> >  		return rc;
> >=20
> > @@ -758,6 +762,10 @@ static int perf_probe(struct ntb_client *client, s=
truct ntb_dev *ntb)
> >  	int node;
> >  	int rc =3D 0;
> >=20
> > +	/* Synchronous hardware is only supported */
> > +	if (!ntb_valid_sync_dev_ops(ntb))
> > +		return -EINVAL;
> > +
> >  	if (ntb_spad_count(ntb) < MAX_SPAD) {
> >  		dev_err(&ntb->dev, "Not enough scratch pad registers for %s",
> >  			DRIVER_NAME);
> > diff --git a/drivers/ntb/test/ntb_pingpong.c b/drivers/ntb/test/ntb_pin=
gpong.c
> > index 7d31179..e833649 100644
> > --- a/drivers/ntb/test/ntb_pingpong.c
> > +++ b/drivers/ntb/test/ntb_pingpong.c
> > @@ -214,6 +214,11 @@ static int pp_probe(struct ntb_client *client,
> >  	struct pp_ctx *pp;
> >  	int rc;
> >=20
> > +	/* Synchronous hardware is only supported */
> > +	if (!ntb_valid_sync_dev_ops(ntb)) {
> > +		return -EINVAL;
> > +	}
> > +
> >  	if (ntb_db_is_unsafe(ntb)) {
> >  		dev_dbg(&ntb->dev, "doorbell is unsafe\n");
> >  		if (!unsafe) {
> > diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
> > index 61bf2ef..5dfe12f 100644
> > --- a/drivers/ntb/test/ntb_tool.c
> > +++ b/drivers/ntb/test/ntb_tool.c
> > @@ -675,8 +675,11 @@ static int tool_setup_mw(struct tool_ctx *tc, int =
idx, size_t
> > req_size)
> >  	if (mw->peer)
> >  		return 0;
> >=20
> > -	rc =3D ntb_mw_get_range(tc->ntb, idx, &base, &size, &align,
> > -			      &align_size);
> > +	rc =3D ntb_mw_get_maprsc(tc->ntb, idx, &base, &size);
> > +	if (rc)
> > +		return rc;
> > +
> > +	rc =3D ntb_peer_mw_get_align(tc->ntb, idx, &align, &align_size, NULL);
> >  	if (rc)
> >  		return rc;
>=20
> Looks like ntb_mw_get_range() was simpler.
>=20

See the previous answer.

> >=20
> > @@ -689,7 +692,7 @@ static int tool_setup_mw(struct tool_ctx *tc, int i=
dx, size_t
> > req_size)
> >  	if (!mw->peer)
> >  		return -ENOMEM;
> >=20
> > -	rc =3D ntb_mw_set_trans(tc->ntb, idx, mw->peer_dma, mw->size);
> > +	rc =3D ntb_peer_mw_set_trans(tc->ntb, idx, mw->peer_dma, mw->size);
> >  	if (rc)
> >  		goto err_free_dma;
> >=20
> > @@ -716,7 +719,7 @@ static void tool_free_mw(struct tool_ctx *tc, int i=
dx)
> >  	struct tool_mw *mw =3D &tc->mws[idx];
> >=20
> >  	if (mw->peer) {
> > -		ntb_mw_clear_trans(tc->ntb, idx);
> > +		ntb_peer_mw_set_trans(tc->ntb, idx, 0, 0);
> >  		dma_free_coherent(&tc->ntb->pdev->dev, mw->size,
> >  				  mw->peer,
> >  				  mw->peer_dma);
> > @@ -751,8 +754,8 @@ static ssize_t tool_peer_mw_trans_read(struct file =
*filep,
> >  	if (!buf)
> >  		return -ENOMEM;
> >=20
> > -	ntb_mw_get_range(mw->tc->ntb, mw->idx,
> > -			 &base, &mw_size, &align, &align_size);
> > +	ntb_mw_get_maprsc(mw->tc->ntb, mw->idx, &base, &mw_size);
> > +	ntb_peer_mw_get_align(mw->tc->ntb, mw->idx, &align, &align_size, NULL=
);
> >=20
> >  	off +=3D scnprintf(buf + off, buf_size - off,
> >  			 "Peer MW %d Information:\n", mw->idx);
> > @@ -827,8 +830,7 @@ static int tool_init_mw(struct tool_ctx *tc, int id=
x)
> >  	phys_addr_t base;
> >  	int rc;
> >=20
> > -	rc =3D ntb_mw_get_range(tc->ntb, idx, &base, &mw->win_size,
> > -			      NULL, NULL);
> > +	rc =3D ntb_mw_get_maprsc(tc->ntb, idx, &base, &mw->win_size);
> >  	if (rc)
> >  		return rc;
> >=20
> > @@ -913,6 +915,11 @@ static int tool_probe(struct ntb_client *self, str=
uct ntb_dev *ntb)
> >  	int rc;
> >  	int i;
> >=20
> > +	/* Synchronous hardware is only supported */
> > +	if (!ntb_valid_sync_dev_ops(ntb)) {
> > +		return -EINVAL;
> > +	}
> > +
>=20
> It would be nice if both types could be supported by the same api.
>=20

Yes, it would be. Alas it isn't possible in general. See the introduction t=
o this letter. AMD and Intel devices support asynchronous interface, althou=
gh they lack of messaging mechanism.

Getting back to the discussion, we still need to provide a way to determine=
 which type of interface an NTB device supports: synchronous/asynchronous t=
ranslated base address initialization, Scratchpads and memory windows. Curr=
ently it can be determined by the functions ntb_valid_sync_dev_ops()/ntb_va=
lid_async_dev_ops(). I understand, that it's not the best solution. We can =
implement the traditional Linux kernel bus device-driver matching, using ta=
ble_ids and so on. For example, each hardware driver fills in a table with =
all the functionality it supports, like: synchronous/asynchronous memory wi=
ndows, Doorbells, Scratchpads, Messaging. Then driver initialize a table of=
 functionality it uses. NTB bus core implements a "match()" callback, which=
 compares those two tables and calls "probe()" callback method of a driver =
when the tables successfully matches.

On the other hand, we might don't have to comprehend the NTB bus core. We c=
an just introduce a table_id for NTB hardware device, which would just desc=
ribe the device vendor itself, like "ntb,amd", "ntb,intel", "ntb,idt" and s=
o on. Client driver will declare a supported device by its table_id. It mig=
ht look easier, since the client driver developer should have a basic under=
standing of the device one develops a driver for. Then NTB bus kernel API c=
ore will simply match NTB devices with drivers like any other buses (PCI, P=
CIe, i2c, spi, etc) do.=20
=20
> >  	if (ntb_db_is_unsafe(ntb))
> >  		dev_dbg(&ntb->dev, "doorbell is unsafe\n");
> >=20
> > @@ -928,7 +935,7 @@ static int tool_probe(struct ntb_client *self, stru=
ct ntb_dev *ntb)
> >  	tc->ntb =3D ntb;
> >  	init_waitqueue_head(&tc->link_wq);
> >=20
> > -	tc->mw_count =3D min(ntb_mw_count(tc->ntb), MAX_MWS);
> > +	tc->mw_count =3D min(ntb_peer_mw_count(tc->ntb), MAX_MWS);
> >  	for (i =3D 0; i < tc->mw_count; i++) {
> >  		rc =3D tool_init_mw(tc, i);
> >  		if (rc)
> > diff --git a/include/linux/ntb.h b/include/linux/ntb.h
> > index 6f47562..d1937d3 100644
> > --- a/include/linux/ntb.h
> > +++ b/include/linux/ntb.h
> > @@ -159,13 +159,44 @@ static inline int ntb_client_ops_is_valid(const s=
truct
> > ntb_client_ops *ops)
> >  }
> >=20
> >  /**
> > + * struct ntb_msg - ntb driver message structure
> > + * @type:	Message type.
> > + * @payload:	Payload data to send to a peer
> > + * @data:	Array of u32 data to send (size might be hw dependent)
> > + */
> > +#define NTB_MAX_MSGSIZE 4
> > +struct ntb_msg {
> > +	union {
> > +		struct {
> > +			u32 type;
> > +			u32 payload[NTB_MAX_MSGSIZE - 1];
> > +		};
> > +		u32 data[NTB_MAX_MSGSIZE];
> > +	};
> > +};
> > +
> > +/**
> > + * enum NTB_MSG_EVENT - message event types
> > + * @NTB_MSG_NEW:	New message just arrived and passed to the handler
> > + * @NTB_MSG_SENT:	Posted message has just been successfully sent
> > + * @NTB_MSG_FAIL:	Posted message failed to be sent
> > + */
> > +enum NTB_MSG_EVENT {
> > +	NTB_MSG_NEW,
> > +	NTB_MSG_SENT,
> > +	NTB_MSG_FAIL
> > +};
> > +
> > +/**
> >   * struct ntb_ctx_ops - ntb driver context operations
> >   * @link_event:		See ntb_link_event().
> >   * @db_event:		See ntb_db_event().
> > + * @msg_event:		See ntb_msg_event().
> >   */
> >  struct ntb_ctx_ops {
> >  	void (*link_event)(void *ctx);
> >  	void (*db_event)(void *ctx, int db_vector);
> > +	void (*msg_event)(void *ctx, enum NTB_MSG_EVENT ev, struct ntb_msg *m=
sg);
> >  };
> >=20
> >  static inline int ntb_ctx_ops_is_valid(const struct ntb_ctx_ops *ops)
> > @@ -174,18 +205,24 @@ static inline int ntb_ctx_ops_is_valid(const stru=
ct ntb_ctx_ops
> > *ops)
> >  	return
> >  		/* ops->link_event		&& */
> >  		/* ops->db_event		&& */
> > +		/* ops->msg_event		&& */
> >  		1;
> >  }
> >=20
> >  /**
> >   * struct ntb_ctx_ops - ntb device operations
> > - * @mw_count:		See ntb_mw_count().
> > - * @mw_get_range:	See ntb_mw_get_range().
> > - * @mw_set_trans:	See ntb_mw_set_trans().
> > - * @mw_clear_trans:	See ntb_mw_clear_trans().
> >   * @link_is_up:		See ntb_link_is_up().
> >   * @link_enable:	See ntb_link_enable().
> >   * @link_disable:	See ntb_link_disable().
> > + * @mw_count:		See ntb_mw_count().
> > + * @mw_get_maprsc:	See ntb_mw_get_maprsc().
> > + * @mw_set_trans:	See ntb_mw_set_trans().
> > + * @mw_get_trans:	See ntb_mw_get_trans().
> > + * @mw_get_align:	See ntb_mw_get_align().
> > + * @peer_mw_count:	See ntb_peer_mw_count().
> > + * @peer_mw_set_trans:	See ntb_peer_mw_set_trans().
> > + * @peer_mw_get_trans:	See ntb_peer_mw_get_trans().
> > + * @peer_mw_get_align:	See ntb_peer_mw_get_align().
> >   * @db_is_unsafe:	See ntb_db_is_unsafe().
> >   * @db_valid_mask:	See ntb_db_valid_mask().
> >   * @db_vector_count:	See ntb_db_vector_count().
> > @@ -210,22 +247,38 @@ static inline int ntb_ctx_ops_is_valid(const stru=
ct ntb_ctx_ops
> > *ops)
> >   * @peer_spad_addr:	See ntb_peer_spad_addr().
> >   * @peer_spad_read:	See ntb_peer_spad_read().
> >   * @peer_spad_write:	See ntb_peer_spad_write().
> > + * @msg_post:		See ntb_msg_post().
> > + * @msg_size:		See ntb_msg_size().
> >   */
> >  struct ntb_dev_ops {
> > -	int (*mw_count)(struct ntb_dev *ntb);
> > -	int (*mw_get_range)(struct ntb_dev *ntb, int idx,
> > -			    phys_addr_t *base, resource_size_t *size,
> > -			resource_size_t *align, resource_size_t *align_size);
> > -	int (*mw_set_trans)(struct ntb_dev *ntb, int idx,
> > -			    dma_addr_t addr, resource_size_t size);
> > -	int (*mw_clear_trans)(struct ntb_dev *ntb, int idx);
> > -
> >  	int (*link_is_up)(struct ntb_dev *ntb,
> >  			  enum ntb_speed *speed, enum ntb_width *width);
> >  	int (*link_enable)(struct ntb_dev *ntb,
> >  			   enum ntb_speed max_speed, enum ntb_width max_width);
> >  	int (*link_disable)(struct ntb_dev *ntb);
> >=20
> > +	int (*mw_count)(struct ntb_dev *ntb);
> > +	int (*mw_get_maprsc)(struct ntb_dev *ntb, int idx,
> > +			     phys_addr_t *base, resource_size_t *size);
> > +	int (*mw_get_align)(struct ntb_dev *ntb, int idx,
> > +			    resource_size_t *addr_align,
> > +			    resource_size_t *size_align,
> > +			    resource_size_t *size_max);
> > +	int (*mw_set_trans)(struct ntb_dev *ntb, int idx,
> > +			    dma_addr_t addr, resource_size_t size);
> > +	int (*mw_get_trans)(struct ntb_dev *ntb, int idx,
> > +			    dma_addr_t *addr, resource_size_t *size);
> > +
> > +	int (*peer_mw_count)(struct ntb_dev *ntb);
> > +	int (*peer_mw_get_align)(struct ntb_dev *ntb, int idx,
> > +				 resource_size_t *addr_align,
> > +				 resource_size_t *size_align,
> > +				 resource_size_t *size_max);
> > +	int (*peer_mw_set_trans)(struct ntb_dev *ntb, int idx,
> > +				 dma_addr_t addr, resource_size_t size);
> > +	int (*peer_mw_get_trans)(struct ntb_dev *ntb, int idx,
> > +				 dma_addr_t *addr, resource_size_t *size);
> > +
> >  	int (*db_is_unsafe)(struct ntb_dev *ntb);
> >  	u64 (*db_valid_mask)(struct ntb_dev *ntb);
> >  	int (*db_vector_count)(struct ntb_dev *ntb);
> > @@ -259,47 +312,10 @@ struct ntb_dev_ops {
> >  			      phys_addr_t *spad_addr);
> >  	u32 (*peer_spad_read)(struct ntb_dev *ntb, int idx);
> >  	int (*peer_spad_write)(struct ntb_dev *ntb, int idx, u32 val);
> > -};
> > -
> > -static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops *ops)
> > -{
> > -	/* commented callbacks are not required: */
> > -	return
> > -		ops->mw_count				&&
> > -		ops->mw_get_range			&&
> > -		ops->mw_set_trans			&&
> > -		/* ops->mw_clear_trans			&& */
> > -		ops->link_is_up				&&
> > -		ops->link_enable			&&
> > -		ops->link_disable			&&
> > -		/* ops->db_is_unsafe			&& */
> > -		ops->db_valid_mask			&&
> >=20
> > -		/* both set, or both unset */
> > -		(!ops->db_vector_count =3D=3D !ops->db_vector_mask) &&
> > -
> > -		ops->db_read				&&
> > -		/* ops->db_set				&& */
> > -		ops->db_clear				&&
> > -		/* ops->db_read_mask			&& */
> > -		ops->db_set_mask			&&
> > -		ops->db_clear_mask			&&
> > -		/* ops->peer_db_addr			&& */
> > -		/* ops->peer_db_read			&& */
> > -		ops->peer_db_set			&&
> > -		/* ops->peer_db_clear			&& */
> > -		/* ops->peer_db_read_mask		&& */
> > -		/* ops->peer_db_set_mask		&& */
> > -		/* ops->peer_db_clear_mask		&& */
> > -		/* ops->spad_is_unsafe			&& */
> > -		ops->spad_count				&&
> > -		ops->spad_read				&&
> > -		ops->spad_write				&&
> > -		/* ops->peer_spad_addr			&& */
> > -		/* ops->peer_spad_read			&& */
> > -		ops->peer_spad_write			&&
> > -		1;
> > -}
> > +	int (*msg_post)(struct ntb_dev *ntb, struct ntb_msg *msg);
> > +	int (*msg_size)(struct ntb_dev *ntb);
> > +};
> >=20
> >  /**
> >   * struct ntb_client - client interested in ntb devices
> > @@ -310,10 +326,22 @@ struct ntb_client {
> >  	struct device_driver		drv;
> >  	const struct ntb_client_ops	ops;
> >  };
> > -
> >  #define drv_ntb_client(__drv) container_of((__drv), struct ntb_client,=
 drv)
> >=20
> >  /**
> > + * struct ntb_bus_data - NTB bus data
> > + * @sync_msk:	Synchroous devices mask
> > + * @async_msk:	Asynchronous devices mask
> > + * @both_msk:	Both sync and async devices mask
> > + */
> > +#define NTB_MAX_DEVID (8*BITS_PER_LONG)
> > +struct ntb_bus_data {
> > +	unsigned long sync_msk[8];
> > +	unsigned long async_msk[8];
> > +	unsigned long both_msk[8];
> > +};
> > +
> > +/**
> >   * struct ntb_device - ntb device
> >   * @dev:		Linux device object.
> >   * @pdev:		Pci device entry of the ntb.
> > @@ -332,15 +360,151 @@ struct ntb_dev {
> >=20
> >  	/* private: */
> >=20
> > +	/* device id */
> > +	int id;
> >  	/* synchronize setting, clearing, and calling ctx_ops */
> >  	spinlock_t			ctx_lock;
> >  	/* block unregister until device is fully released */
> >  	struct completion		released;
> >  };
> > -
> >  #define dev_ntb(__dev) container_of((__dev), struct ntb_dev, dev)
> >=20
> >  /**
> > + * ntb_valid_sync_dev_ops() - valid operations for synchronous hardwar=
e setup
> > + * @ntb:	NTB device
> > + *
> > + * There might be two types of NTB hardware differed by the way of the=
 settings
> > + * configuration. The synchronous chips allows to set the memory windo=
ws by
> > + * directly writing to the peer registers. Additionally there can be s=
hared
> > + * Scratchpad registers for synchronous information exchange. Client d=
rivers
> > + * should call this function to make sure the hardware supports the pr=
oper
> > + * functionality.
> > + */
> > +static inline int ntb_valid_sync_dev_ops(const struct ntb_dev *ntb)
> > +{
> > +	const struct ntb_dev_ops *ops =3D ntb->ops;
> > +
> > +	/* Commented callbacks are not required, but might be developed */
> > +	return	/* NTB link status ops */
> > +		ops->link_is_up					&&
> > +		ops->link_enable				&&
> > +		ops->link_disable				&&
> > +
> > +		/* Synchronous memory windows ops */
> > +		ops->mw_count					&&
> > +		ops->mw_get_maprsc				&&
> > +		/* ops->mw_get_align				&& */
> > +		/* ops->mw_set_trans				&& */
> > +		/* ops->mw_get_trans				&& */
> > +		ops->peer_mw_count				&&
> > +		ops->peer_mw_get_align				&&
> > +		ops->peer_mw_set_trans				&&
> > +		/* ops->peer_mw_get_trans			&& */
> > +
> > +		/* Doorbell ops */
> > +		/* ops->db_is_unsafe				&& */
> > +		ops->db_valid_mask				&&
> > +		/* both set, or both unset */
> > +		(!ops->db_vector_count =3D=3D !ops->db_vector_mask)	&&
> > +		ops->db_read					&&
> > +		/* ops->db_set					&& */
> > +		ops->db_clear					&&
> > +		/* ops->db_read_mask				&& */
> > +		ops->db_set_mask				&&
> > +		ops->db_clear_mask				&&
> > +		/* ops->peer_db_addr				&& */
> > +		/* ops->peer_db_read				&& */
> > +		ops->peer_db_set				&&
> > +		/* ops->peer_db_clear				&& */
> > +		/* ops->peer_db_read_mask			&& */
> > +		/* ops->peer_db_set_mask			&& */
> > +		/* ops->peer_db_clear_mask			&& */
> > +
> > +		/* Scratchpad ops */
> > +		/* ops->spad_is_unsafe				&& */
> > +		ops->spad_count					&&
> > +		ops->spad_read					&&
> > +		ops->spad_write					&&
> > +		/* ops->peer_spad_addr				&& */
> > +		/* ops->peer_spad_read				&& */
> > +		ops->peer_spad_write				&&
> > +
> > +		/* Messages IO ops */
> > +		/* ops->msg_post				&& */
> > +		/* ops->msg_size				&& */
> > +		1;
> > +}
> > +
> > +/**
> > + * ntb_valid_async_dev_ops() - valid operations for asynchronous hardw=
are setup
> > + * @ntb:	NTB device
> > + *
> > + * There might be two types of NTB hardware differed by the way of the=
 settings
> > + * configuration. The asynchronous chips does not allow to set the mem=
ory
> > + * windows by directly writing to the peer registers. Instead it imple=
ments
> > + * the additional method to communinicate between NTB nodes like messa=
ges.
> > + * Scratchpad registers aren't likely supported by such hardware. Clie=
nt
> > + * drivers should call this function to make sure the hardware supports
> > + * the proper functionality.
> > + */
> > +static inline int ntb_valid_async_dev_ops(const struct ntb_dev *ntb)
> > +{
> > +	const struct ntb_dev_ops *ops =3D ntb->ops;
> > +
> > +	/* Commented callbacks are not required, but might be developed */
> > +	return	/* NTB link status ops */
> > +		ops->link_is_up					&&
> > +		ops->link_enable				&&
> > +		ops->link_disable				&&
> > +
> > +		/* Asynchronous memory windows ops */
> > +		ops->mw_count					&&
> > +		ops->mw_get_maprsc				&&
> > +		ops->mw_get_align				&&
> > +		ops->mw_set_trans				&&
> > +		/* ops->mw_get_trans				&& */
> > +		ops->peer_mw_count				&&
> > +		ops->peer_mw_get_align				&&
> > +		/* ops->peer_mw_set_trans			&& */
> > +		/* ops->peer_mw_get_trans			&& */
> > +
> > +		/* Doorbell ops */
> > +		/* ops->db_is_unsafe				&& */
> > +		ops->db_valid_mask				&&
> > +		/* both set, or both unset */
> > +		(!ops->db_vector_count =3D=3D !ops->db_vector_mask)	&&
> > +		ops->db_read					&&
> > +		/* ops->db_set					&& */
> > +		ops->db_clear					&&
> > +		/* ops->db_read_mask				&& */
> > +		ops->db_set_mask				&&
> > +		ops->db_clear_mask				&&
> > +		/* ops->peer_db_addr				&& */
> > +		/* ops->peer_db_read				&& */
> > +		ops->peer_db_set				&&
> > +		/* ops->peer_db_clear				&& */
> > +		/* ops->peer_db_read_mask			&& */
> > +		/* ops->peer_db_set_mask			&& */
> > +		/* ops->peer_db_clear_mask			&& */
> > +
> > +		/* Scratchpad ops */
> > +		/* ops->spad_is_unsafe				&& */
> > +		/* ops->spad_count				&& */
> > +		/* ops->spad_read				&& */
> > +		/* ops->spad_write				&& */
> > +		/* ops->peer_spad_addr				&& */
> > +		/* ops->peer_spad_read				&& */
> > +		/* ops->peer_spad_write				&& */
> > +
> > +		/* Messages IO ops */
> > +		ops->msg_post					&&
> > +		ops->msg_size					&&
> > +		1;
> > +}
>=20
> I understand why IDT requires a different api for dealing with addressing=
 multiple peers.  I would be interested in a solution that would allow, for=
 example, the Intel driver fit under the api for dealing with multiple peer=
s, even though it only supports one peer.  I would rather see that, than tw=
o separate apis under ntb.
>=20
> Thoughts?
>=20
> Can the sync api be described by some subset of the async api?  Are there=
 less overloaded terms we can use instead of sync/async?
>=20

Answer to this concern is mostly provided in the introduction as well. I'll=
 repeat it here in details. As I said AMD and Intel hardware support asynch=
ronous API except the messaging. Additionally I can even think of emulating=
 messaging using Doorbells and Scratchpads, but not the other way around. W=
hy not? Before answering, here is how the messaging works in IDT switches o=
f both first and second groups (see introduction for describing the groups).

There are four outbound and inbound message registers for each NTB port in =
the device. Local root complex can connect its any outbound message to any =
inbound message register of the IDT switch. When one writes a data to an ou=
tbound message register it immediately gets to the connected inbound messag=
e registers. Then peer can read its inbound message registers and empty it =
by clearing a corresponding bit. Then and only then next data can be writte=
n to any outbound message registers connected to that inbound message regis=
ter. So the possible race condition between multiple domains sending a mess=
age to same peer is resolved by the IDT switch itself.

One would ask: "Why don't you just wrap the message registers up back to th=
e same port? It would look just like Scratchpads." Yes, It would. But still=
 there are only four message registers. It's not enough to distribute them =
between all the possibly connected NTB ports. As I said earlier there can b=
e up to eight domains connected, so there must be at least seven message re=
gister to fulfil the possible design.

Howbeit all the emulations would look ugly anyway. In my opinion It's bette=
r to slightly adapt design for a hardware, rather than hardware to a design=
=2E Following that rule would simplify a code and support respectively.

Regarding the APIs subset. As I said before async API is kind of subset of =
synchronous API. We can develop all the memory window related callback-meth=
od for AMD and Intel hardware driver, which is pretty much easy. We can eve=
n simulate message registers by using Doorbells and Scratchpads, which is n=
ot that easy, but possible. Alas the second group of IDT switches can't imp=
lement the synchronous API, as I already said in the introduction.

Regarding the overloaded naming. The "sync/async" names are the best I coul=
d think of. If you have any idea how one can be appropriately changed, be m=
y guest. I would be really glad to substitute them with something better.

> > +
> > +
> > +
> > +/**
> >   * ntb_register_client() - register a client for interest in ntb devic=
es
> >   * @client:	Client context.
> >   *
> > @@ -441,10 +605,84 @@ void ntb_link_event(struct ntb_dev *ntb);
> >  void ntb_db_event(struct ntb_dev *ntb, int vector);
> >=20
> >  /**
> > - * ntb_mw_count() - get the number of memory windows
> > + * ntb_msg_event() - notify driver context of event in messaging subsy=
stem
> >   * @ntb:	NTB device context.
> > + * @ev:		Event type caused the handler invocation
> > + * @msg:	Message related to the event
> > + *
> > + * Notify the driver context that there is some event happaned in the =
event
> > + * subsystem. If NTB_MSG_NEW is emitted then the new message has just =
arrived.
> > + * NTB_MSG_SENT is rised if some message has just been successfully se=
nt to a
> > + * peer. If a message failed to be sent then NTB_MSG_FAIL is emitted. =
The very
> > + * last argument is used to pass the event related message. It discard=
ed right
> > + * after the handler returns.
> > + */
> > +void ntb_msg_event(struct ntb_dev *ntb, enum NTB_MSG_EVENT ev,
> > +		   struct ntb_msg *msg);
>=20
> I would prefer to see a notify-and-poll api (like NAPI).  This will allow=
 scheduling of the message handling to be done more appropriately at a high=
er layer of the application.  I am concerned to see inmsg/outmsg_work in th=
e new hardware driver [PATCH 2/3], which I think would be more appropriate =
for a ntb transport (or higher layer) driver.
>=20

Hmmm, that's how it's done.) MSI interrupt is raised when a new message arr=
ived into a first inbound message register (the rest of message registers a=
re used as an additional data buffers). Then a corresponding tasklet is sta=
rted to release a hardware interrupt context. That tasklet extracts a messa=
ge from the inbound message registers, puts it into the driver inbound mess=
age queue and marks the registers as empty so the next message could be ret=
rieved. Then tasklet starts a corresponding kernel work thread delivering a=
ll new messages to a client driver, which preliminary registered "ntb_msg_e=
vent()" callback method. When callback method "ntb_msg_event()" the passed =
message is discarded.

Description of how messages are sent to a peer is provided below in the cor=
responding commentary.

> > +
> > +/**
> > + * ntb_link_is_up() - get the current ntb link state
> > + * @ntb:	NTB device context.
> > + * @speed:	OUT - The link speed expressed as PCIe generation number.
> > + * @width:	OUT - The link width expressed as the number of PCIe lanes.
> > + *
> > + * Get the current state of the ntb link.  It is recommended to query =
the link
> > + * state once after every link event.  It is safe to query the link st=
ate in
> > + * the context of the link event callback.
> > + *
> > + * Return: One if the link is up, zero if the link is down, otherwise a
> > + *		negative value indicating the error number.
> > + */
> > +static inline int ntb_link_is_up(struct ntb_dev *ntb,
> > +				 enum ntb_speed *speed, enum ntb_width *width)
> > +{
> > +	return ntb->ops->link_is_up(ntb, speed, width);
> > +}
> > +
>=20
> It looks like there was some rearranging of code, so big hunks appear to =
be added or removed.  Can you split this into two (or more) patches so that=
 rearranging the code is distinct from more interesting changes?
>=20

Lets say there was not much rearranging here. I've just put link-related me=
thod before everything else. The rearranging was done from the point of met=
hods importance view. There can't be any memory sharing and doorbells opera=
tions done before the link is established. The new arrangements is reflecte=
d in ntb_valid_sync_dev_ops()/ntb_valid_async_dev_ops() methods.

> > +/**
> > + * ntb_link_enable() - enable the link on the secondary side of the ntb
> > + * @ntb:	NTB device context.
> > + * @max_speed:	The maximum link speed expressed as PCIe generation num=
ber.
> > + * @max_width:	The maximum link width expressed as the number of PCIe =
lanes.
> >   *
> > - * Hardware and topology may support a different number of memory wind=
ows.
> > + * Enable the link on the secondary side of the ntb.  This can only be=
 done
> > + * from only one (primary or secondary) side of the ntb in primary or =
b2b
> > + * topology.  The ntb device should train the link to its maximum spee=
d and
> > + * width, or the requested speed and width, whichever is smaller, if s=
upported.
> > + *
> > + * Return: Zero on success, otherwise an error number.
> > + */
> > +static inline int ntb_link_enable(struct ntb_dev *ntb,
> > +				  enum ntb_speed max_speed,
> > +				  enum ntb_width max_width)
> > +{
> > +	return ntb->ops->link_enable(ntb, max_speed, max_width);
> > +}
> > +
> > +/**
> > + * ntb_link_disable() - disable the link on the secondary side of the =
ntb
> > + * @ntb:	NTB device context.
> > + *
> > + * Disable the link on the secondary side of the ntb.  This can only be
> > + * done from only one (primary or secondary) side of the ntb in primar=
y or b2b
> > + * topology.  The ntb device should disable the link.  Returning from =
this call
> > + * must indicate that a barrier has passed, though with no more writes=
 may pass
> > + * in either direction across the link, except if this call returns an=
 error
> > + * number.
> > + *
> > + * Return: Zero on success, otherwise an error number.
> > + */
> > +static inline int ntb_link_disable(struct ntb_dev *ntb)
> > +{
> > +	return ntb->ops->link_disable(ntb);
> > +}
> > +
> > +/**
> > + * ntb_mw_count() - get the number of local memory windows
> > + * @ntb:	NTB device context.
> > + *
> > + * Hardware and topology may support a different number of memory wind=
ows at
> > + * local and remote devices
> >   *
> >   * Return: the number of memory windows.
> >   */
> > @@ -454,122 +692,186 @@ static inline int ntb_mw_count(struct ntb_dev *=
ntb)
> >  }
> >=20
> >  /**
> > - * ntb_mw_get_range() - get the range of a memory window
> > + * ntb_mw_get_maprsc() - get the range of a memory window to map
>=20
> What was insufficient about ntb_mw_get_range() that it needed to be split=
 into ntb_mw_get_maprsc() and ntb_mw_get_align()?  In all the places that I=
 found in this patch, it seems ntb_mw_get_range() would have been more simp=
le.
>=20
> I didn't see any use of ntb_mw_get_mapsrc() in the new async test clients=
 [PATCH 3/3].  So, there is no example of how usage of new api would be use=
d differently or more efficiently than ntb_mw_get_range() for async devices.
>=20

This concern is answered a bit earlier, when you first commented the method=
 "ntb_mw_get_range()" splitting.

You could not find the "ntb_mw_get_mapsrc()" method usage because you missp=
elled it. The real method signature is "ntb_mw_get_maprsc()" (look more car=
efully at the name ending), which is decrypted as "Mapping Resources", but =
no "Mapping Source". ntb/test/ntb_mw_test.c driver is developed to demonstr=
ate how the new asynchronous API is utilized including the "ntb_mw_get_mapr=
sc()" method usage.

> >   * @ntb:	NTB device context.
> >   * @idx:	Memory window number.
> >   * @base:	OUT - the base address for mapping the memory window
> >   * @size:	OUT - the size for mapping the memory window
> > - * @align:	OUT - the base alignment for translating the memory window
> > - * @align_size:	OUT - the size alignment for translating the memory wi=
ndow
> >   *
> > - * Get the range of a memory window.  NULL may be given for any output
> > - * parameter if the value is not needed.  The base and size may be use=
d for
> > - * mapping the memory window, to access the peer memory.  The alignmen=
t and
> > - * size may be used for translating the memory window, for the peer to=
 access
> > - * memory on the local system.
> > + * Get the map range of a memory window. The base and size may be used=
 for
> > + * mapping the memory window to access the peer memory.
> >   *
> >   * Return: Zero on success, otherwise an error number.
> >   */
> > -static inline int ntb_mw_get_range(struct ntb_dev *ntb, int idx,
> > -				   phys_addr_t *base, resource_size_t *size,
> > -		resource_size_t *align, resource_size_t *align_size)
> > +static inline int ntb_mw_get_maprsc(struct ntb_dev *ntb, int idx,
> > +				    phys_addr_t *base, resource_size_t *size)
> >  {
> > -	return ntb->ops->mw_get_range(ntb, idx, base, size,
> > -			align, align_size);
> > +	return ntb->ops->mw_get_maprsc(ntb, idx, base, size);
> > +}
> > +
> > +/**
> > + * ntb_mw_get_align() - get memory window alignment of the local node
> > + * @ntb:	NTB device context.
> > + * @idx:	Memory window number.
> > + * @addr_align:	OUT - the translated base address alignment of the mem=
ory window
> > + * @size_align:	OUT - the translated memory size alignment of the memo=
ry window
> > + * @size_max:	OUT - the translated memory maximum size
> > + *
> > + * Get the alignment parameters to allocate the proper memory window. =
NULL may
> > + * be given for any output parameter if the value is not needed.
> > + *
> > + * Drivers of synchronous hardware don't have to support it.
> > + *
> > + * Return: Zero on success, otherwise an error number.
> > + */
> > +static inline int ntb_mw_get_align(struct ntb_dev *ntb, int idx,
> > +				   resource_size_t *addr_align,
> > +				   resource_size_t *size_align,
> > +				   resource_size_t *size_max)
> > +{
> > +	if (!ntb->ops->mw_get_align)
> > +		return -EINVAL;
> > +
> > +	return ntb->ops->mw_get_align(ntb, idx, addr_align, size_align, size_=
max);
> >  }
> >=20
> >  /**
> > - * ntb_mw_set_trans() - set the translation of a memory window
> > + * ntb_mw_set_trans() - set the translated base address of a peer memo=
ry window
> >   * @ntb:	NTB device context.
> >   * @idx:	Memory window number.
> > - * @addr:	The dma address local memory to expose to the peer.
> > - * @size:	The size of the local memory to expose to the peer.
> > + * @addr:	DMA memory address exposed by the peer.
> > + * @size:	Size of the memory exposed by the peer.
> > + *
> > + * Set the translated base address of a memory window. The peer prelim=
inary
> > + * allocates a memory, then someway passes the address to the remote n=
ode, that
> > + * finally sets up the memory window at the address, up to the size. T=
he address
> > + * and size must be aligned to the parameters specified by ntb_mw_get_=
align() of
> > + * the local node and ntb_peer_mw_get_align() of the peer, which must =
return the
> > + * same values. Zero size effectively disables the memory window.
> >   *
> > - * Set the translation of a memory window.  The peer may access local =
memory
> > - * through the window starting at the address, up to the size.  The ad=
dress
> > - * must be aligned to the alignment specified by ntb_mw_get_range().  =
The size
> > - * must be aligned to the size alignment specified by ntb_mw_get_range=
().
> > + * Drivers of synchronous hardware don't have to support it.
> >   *
> >   * Return: Zero on success, otherwise an error number.
> >   */
> >  static inline int ntb_mw_set_trans(struct ntb_dev *ntb, int idx,
> >  				   dma_addr_t addr, resource_size_t size)
> >  {
> > +	if (!ntb->ops->mw_set_trans)
> > +		return -EINVAL;
> > +
> >  	return ntb->ops->mw_set_trans(ntb, idx, addr, size);
> >  }
> >=20
> >  /**
> > - * ntb_mw_clear_trans() - clear the translation of a memory window
> > + * ntb_mw_get_trans() - get the translated base address of a memory wi=
ndow
> >   * @ntb:	NTB device context.
> >   * @idx:	Memory window number.
> > + * @addr:	The dma memory address exposed by the peer.
> > + * @size:	The size of the memory exposed by the peer.
> >   *
> > - * Clear the translation of a memory window.  The peer may no longer a=
ccess
> > - * local memory through the window.
> > + * Get the translated base address of a memory window spicified for th=
e local
> > + * hardware and allocated by the peer. If the addr and size are zero, =
the
> > + * memory window is effectively disabled.
> >   *
> >   * Return: Zero on success, otherwise an error number.
> >   */
> > -static inline int ntb_mw_clear_trans(struct ntb_dev *ntb, int idx)
> > +static inline int ntb_mw_get_trans(struct ntb_dev *ntb, int idx,
> > +				   dma_addr_t *addr, resource_size_t *size)
> >  {
> > -	if (!ntb->ops->mw_clear_trans)
> > -		return ntb->ops->mw_set_trans(ntb, idx, 0, 0);
> > +	if (!ntb->ops->mw_get_trans)
> > +		return -EINVAL;
> >=20
> > -	return ntb->ops->mw_clear_trans(ntb, idx);
> > +	return ntb->ops->mw_get_trans(ntb, idx, addr, size);
> >  }
> >=20
> >  /**
> > - * ntb_link_is_up() - get the current ntb link state
> > + * ntb_peer_mw_count() - get the number of peer memory windows
> >   * @ntb:	NTB device context.
> > - * @speed:	OUT - The link speed expressed as PCIe generation number.
> > - * @width:	OUT - The link width expressed as the number of PCIe lanes.
> >   *
> > - * Get the current state of the ntb link.  It is recommended to query =
the link
> > - * state once after every link event.  It is safe to query the link st=
ate in
> > - * the context of the link event callback.
> > + * Hardware and topology may support a different number of memory wind=
ows at
> > + * local and remote nodes.
> >   *
> > - * Return: One if the link is up, zero if the link is down, otherwise a
> > - *		negative value indicating the error number.
> > + * Return: the number of memory windows.
> >   */
> > -static inline int ntb_link_is_up(struct ntb_dev *ntb,
> > -				 enum ntb_speed *speed, enum ntb_width *width)
> > +static inline int ntb_peer_mw_count(struct ntb_dev *ntb)
> >  {
> > -	return ntb->ops->link_is_up(ntb, speed, width);
> > +	return ntb->ops->peer_mw_count(ntb);
> >  }
> >=20
> >  /**
> > - * ntb_link_enable() - enable the link on the secondary side of the ntb
> > + * ntb_peer_mw_get_align() - get memory window alignment of the peer
> >   * @ntb:	NTB device context.
> > - * @max_speed:	The maximum link speed expressed as PCIe generation num=
ber.
> > - * @max_width:	The maximum link width expressed as the number of PCIe =
lanes.
> > + * @idx:	Memory window number.
> > + * @addr_align:	OUT - the translated base address alignment of the mem=
ory window
> > + * @size_align:	OUT - the translated memory size alignment of the memo=
ry window
> > + * @size_max:	OUT - the translated memory maximum size
> >   *
> > - * Enable the link on the secondary side of the ntb.  This can only be=
 done
> > - * from the primary side of the ntb in primary or b2b topology.  The n=
tb device
> > - * should train the link to its maximum speed and width, or the reques=
ted speed
> > - * and width, whichever is smaller, if supported.
> > + * Get the alignment parameters to allocate the proper memory window f=
or the
> > + * peer. NULL may be given for any output parameter if the value is no=
t needed.
> >   *
> >   * Return: Zero on success, otherwise an error number.
> >   */
> > -static inline int ntb_link_enable(struct ntb_dev *ntb,
> > -				  enum ntb_speed max_speed,
> > -				  enum ntb_width max_width)
> > +static inline int ntb_peer_mw_get_align(struct ntb_dev *ntb, int idx,
> > +					resource_size_t *addr_align,
> > +					resource_size_t *size_align,
> > +					resource_size_t *size_max)
> >  {
> > -	return ntb->ops->link_enable(ntb, max_speed, max_width);
> > +	if (!ntb->ops->peer_mw_get_align)
> > +		return -EINVAL;
> > +
> > +	return ntb->ops->peer_mw_get_align(ntb, idx, addr_align, size_align,
> > +					   size_max);
> >  }
> >=20
> >  /**
> > - * ntb_link_disable() - disable the link on the secondary side of the =
ntb
> > + * ntb_peer_mw_set_trans() - set the translated base address of a peer
> > + *			     memory window
> >   * @ntb:	NTB device context.
> > + * @idx:	Memory window number.
> > + * @addr:	Local DMA memory address exposed to the peer.
> > + * @size:	Size of the memory exposed to the peer.
> >   *
> > - * Disable the link on the secondary side of the ntb.  This can only be
> > - * done from the primary side of the ntb in primary or b2b topology.  =
The ntb
> > - * device should disable the link.  Returning from this call must indi=
cate that
> > - * a barrier has passed, though with no more writes may pass in either
> > - * direction across the link, except if this call returns an error num=
ber.
> > + * Set the translated base address of a memory window exposed to the p=
eer.
> > + * The local node preliminary allocates the window, then directly writ=
es the
>=20
> I think ntb_peer_mw_set_trans() and ntb_mw_set_trans() are backwards.  Do=
es the following make sense, or have I completely misunderstood something?
>=20
> ntb_mw_set_trans(): set up translation so that incoming writes to the mem=
ory window are translated to the local memory destination.
>=20
> ntb_peer_mw_set_trans(): set up (what exactly?) so that outgoing writes t=
o a peer memory window (is this something that needs to be configured on th=
e local ntb?) are translated to the peer ntb (i.e. their port/bridge) memor=
y window.  Then, the peer's setting of ntb_mw_set_trans() will complete the=
 translation to the peer memory destination.
>=20

These functions actually do the opposite you described:

ntb_mw_set_trans() - method sets the translated base address retrieved from=
 a peer, so outgoing writes to a memory window would be translated and reac=
h the peer memory destination.

ntb_peer_mw_set_trans() - method sets translated base address to peer confi=
guration space, so the local incoming writes would be correctly translated =
on the peer and reach the local memory destination.

Globally thinking, these methods do the same think, when they called from o=
pposite domains. So to speak locally called "ntb_mw_set_trans()" method doe=
s the same thing as the method "ntb_peer_mw_set_trans()" called from a peer=
, and vise versa the locally called method "ntb_peer_mw_set_trans()" does t=
he same procedure as the method "ntb_mw_set_trans()" called from a peer.

To make things simpler, think of memory windows in the framework of the nex=
t definition: "Memory Window is a virtual memory region, which locally refl=
ects a physical memory of peer/remote device." So when we call ntb_mw_set_t=
rans(), we initialize the local memory window, so the locally mapped virtua=
l addresses would be connected with the peer physical memory. When we call =
ntb_peer_mw_set_trans(), we initialize a peer/remote virtual memory region,=
 so the peer could successfully perform a writes to our local physical memo=
ry.

Of course all the actual memory read/write operations should follow up ntb_=
mw_get_maprsc() and ioremap_nocache() method invocation doublet. You do the=
 same thing in the client test drivers for AMD and Intel hadrware.

> > + * address and size to the peer control registers. The address and siz=
e must
> > + * be aligned to the parameters specified by ntb_peer_mw_get_align() of
> > + * the local node and ntb_mw_get_align() of the peer, which must retur=
n the
> > + * same values. Zero size effectively disables the memory window.
> > + *
> > + * Drivers of synchronous hardware must support it.
> >   *
> >   * Return: Zero on success, otherwise an error number.
> >   */
> > -static inline int ntb_link_disable(struct ntb_dev *ntb)
> > +static inline int ntb_peer_mw_set_trans(struct ntb_dev *ntb, int idx,
> > +					dma_addr_t addr, resource_size_t size)
> >  {
> > -	return ntb->ops->link_disable(ntb);
> > +	if (!ntb->ops->peer_mw_set_trans)
> > +		return -EINVAL;
> > +
> > +	return ntb->ops->peer_mw_set_trans(ntb, idx, addr, size);
> > +}
> > +
> > +/**
> > + * ntb_peer_mw_get_trans() - get the translated base address of a peer
> > + *			     memory window
> > + * @ntb:	NTB device context.
> > + * @idx:	Memory window number.
> > + * @addr:	Local dma memory address exposed to the peer.
> > + * @size:	Size of the memory exposed to the peer.
> > + *
> > + * Get the translated base address of a memory window spicified for th=
e peer
> > + * hardware. If the addr and size are zero then the memory window is e=
ffectively
> > + * disabled.
> > + *
> > + * Return: Zero on success, otherwise an error number.
> > + */
> > +static inline int ntb_peer_mw_get_trans(struct ntb_dev *ntb, int idx,
> > +					dma_addr_t *addr, resource_size_t *size)
> > +{
> > +	if (!ntb->ops->peer_mw_get_trans)
> > +		return -EINVAL;
> > +
> > +	return ntb->ops->peer_mw_get_trans(ntb, idx, addr, size);
> >  }
> >=20
> >  /**
> > @@ -751,6 +1053,8 @@ static inline int ntb_db_clear_mask(struct ntb_dev=
 *ntb, u64 db_bits)
> >   * append one additional dma memory copy with the doorbell register as=
 the
> >   * destination, after the memory copy operations.
> >   *
> > + * This is unusual, and hardware may not be suitable to implement it.
> > + *
>=20
> Why is this unusual?  Do you mean async hardware may not support it?
>=20

Of course I can always return an address of a Doorbell register, but it's n=
ot safe to do it working with IDT NTB hardware driver. To make thing explai=
ned simpler think a IDT hardware, which supports the Doorbell bits routing.=
 Each local inbound Doorbell bits of each port can be configured to either =
reflect the global switch doorbell bits state or not to reflect. Global doo=
rbell bits are set by using outbound doorbell register, which is exist for =
every NTB port. Primary port is the port which can have an access to multip=
le peers, so the Primary port inbound and outbound doorbell registers are s=
hared between several NTB devices, sited on the linux kernel NTB bus. As yo=
u understand, these devices should not interfere each other, which can happ=
en on uncontrollable usage of Doorbell registers addresses. That's why the =
method cou "ntb_peer_db_addr()" should not be developed for the IDT NTB har=
dware driver.

> >   * Return: Zero on success, otherwise an error number.
> >   */
> >  static inline int ntb_peer_db_addr(struct ntb_dev *ntb,
> > @@ -901,10 +1205,15 @@ static inline int ntb_spad_is_unsafe(struct ntb_=
dev *ntb)
> >   *
> >   * Hardware and topology may support a different number of scratchpads.
> >   *
> > + * Asynchronous hardware may not support it.
> > + *
> >   * Return: the number of scratchpads.
> >   */
> >  static inline int ntb_spad_count(struct ntb_dev *ntb)
> >  {
> > +	if (!ntb->ops->spad_count)
> > +		return -EINVAL;
> > +
>=20
> Maybe we should return zero (i.e. there are no scratchpads).
>=20

Agreed. I will fix it in the next patchset.

> >  	return ntb->ops->spad_count(ntb);
> >  }
> >=20
> > @@ -915,10 +1224,15 @@ static inline int ntb_spad_count(struct ntb_dev =
*ntb)
> >   *
> >   * Read the local scratchpad register, and return the value.
> >   *
> > + * Asynchronous hardware may not support it.
> > + *
> >   * Return: The value of the local scratchpad register.
> >   */
> >  static inline u32 ntb_spad_read(struct ntb_dev *ntb, int idx)
> >  {
> > +	if (!ntb->ops->spad_read)
> > +		return 0;
> > +
>=20
> Let's return ~0.  I think that's what a driver would read from the pci bu=
s for a memory miss.=20
>=20

Agreed. I will make it returning -EINVAL in the next patchset.

> >  	return ntb->ops->spad_read(ntb, idx);
> >  }
> >=20
> > @@ -930,10 +1244,15 @@ static inline u32 ntb_spad_read(struct ntb_dev *=
ntb, int idx)
> >   *
> >   * Write the value to the local scratchpad register.
> >   *
> > + * Asynchronous hardware may not support it.
> > + *
> >   * Return: Zero on success, otherwise an error number.
> >   */
> >  static inline int ntb_spad_write(struct ntb_dev *ntb, int idx, u32 val)
> >  {
> > +	if (!ntb->ops->spad_write)
> > +		return -EINVAL;
> > +
> >  	return ntb->ops->spad_write(ntb, idx, val);
> >  }
> >=20
> > @@ -946,6 +1265,8 @@ static inline int ntb_spad_write(struct ntb_dev *n=
tb, int idx, u32
> > val)
> >   * Return the address of the peer doorbell register.  This may be used=
, for
> >   * example, by drivers that offload memory copy operations to a dma en=
gine.
> >   *
> > + * Asynchronous hardware may not support it.
> > + *
> >   * Return: Zero on success, otherwise an error number.
> >   */
> >  static inline int ntb_peer_spad_addr(struct ntb_dev *ntb, int idx,
> > @@ -964,10 +1285,15 @@ static inline int ntb_peer_spad_addr(struct ntb_=
dev *ntb, int idx,
> >   *
> >   * Read the peer scratchpad register, and return the value.
> >   *
> > + * Asynchronous hardware may not support it.
> > + *
> >   * Return: The value of the local scratchpad register.
> >   */
> >  static inline u32 ntb_peer_spad_read(struct ntb_dev *ntb, int idx)
> >  {
> > +	if (!ntb->ops->peer_spad_read)
> > +		return 0;
>=20
> Also, ~0?
>=20

Agreed. I will make it returning -EINVAL in the next patchset.

> > +
> >  	return ntb->ops->peer_spad_read(ntb, idx);
> >  }
> >=20
> > @@ -979,11 +1305,59 @@ static inline u32 ntb_peer_spad_read(struct ntb_=
dev *ntb, int idx)
> >   *
> >   * Write the value to the peer scratchpad register.
> >   *
> > + * Asynchronous hardware may not support it.
> > + *
> >   * Return: Zero on success, otherwise an error number.
> >   */
> >  static inline int ntb_peer_spad_write(struct ntb_dev *ntb, int idx, u3=
2 val)
> >  {
> > +	if (!ntb->ops->peer_spad_write)
> > +		return -EINVAL;
> > +
> >  	return ntb->ops->peer_spad_write(ntb, idx, val);
> >  }
> >=20
> > +/**
> > + * ntb_msg_post() - post the message to the peer
> > + * @ntb:	NTB device context.
> > + * @msg:	Message
> > + *
> > + * Post the message to a peer. It shall be delivered to the peer by the
> > + * corresponding hardware method. The peer should be notified about th=
e new
> > + * message by calling the ntb_msg_event() handler of NTB_MSG_NEW event=
 type.
> > + * If delivery is fails for some reasong the local node will get NTB_M=
SG_FAIL
> > + * event. Otherwise the NTB_MSG_SENT is emitted.
>=20
> Interesting.. local driver would be notified about completion (success or=
 failure) of delivery.  Is there any order-of-completion guarantee for the =
completion notifications?  Is there some tolerance for faults, in case we n=
ever get a completion notification from the peer (eg. we lose the link)?  I=
f we lose the link, report a local fault, and the link comes up again, can =
we still get a completion notification from the peer, and how would that be=
 handled?
>=20
> Does delivery mean the application has processed the message, or is it ju=
st delivery at the hardware layer, or just delivery at the ntb hardware dri=
ver layer?
>=20

Let me explain how the message delivery works. When a client driver calls t=
he "ntb_msg_post()" method, the corresponding message is placed in an outbo=
und messages queue. Such the message queue exists for every peer device. Th=
en a dedicated kernel work thread is started to send all the messages from =
the queue. If kernel thread failed to send a message (for instance, if the =
peer IDT NTB hardware driver still has not freed its inbound message regist=
ers), it performs a new attempt after a small timeout. If after a preconfig=
ured number of attempts the kernel thread still fails to delivery the messa=
ge, it invokes ntb_msg_event() callback with NTB_MSG_FAIL event. If the mes=
sage is successfully delivered, then the method ntb_msg_event() is called w=
ith NTB_MSG_SENT event.

To be clear the messsages are transfered directly to the peer memory, but i=
nstead they are placed in the IDT NTB switch registers, then peer is notifi=
ed about a new message arrived at the corresponding message registers and t=
he corresponding interrupt handler is called.

If we loose the PCI express or NTB link between the IDT switch and a peer, =
then the ntb_msg_event() method is called with NTB_MSG_FAIL event.

> > + *
> > + * Synchronous hardware may not support it.
> > + *
> > + * Return: Zero on success, otherwise an error number.
> > + */
> > +static inline int ntb_msg_post(struct ntb_dev *ntb, struct ntb_msg *ms=
g)
> > +{
> > +	if (!ntb->ops->msg_post)
> > +		return -EINVAL;
> > +
> > +	return ntb->ops->msg_post(ntb, msg);
> > +}
> > +
> > +/**
> > + * ntb_msg_size() - size of the message data
> > + * @ntb:	NTB device context.
> > + *
> > + * Different hardware may support different number of message register=
s. This
> > + * callback shall return the number of those used for data sending and
> > + * receiving including the type field.
> > + *
> > + * Synchronous hardware may not support it.
> > + *
> > + * Return: Zero on success, otherwise an error number.
> > + */
> > +static inline int ntb_msg_size(struct ntb_dev *ntb)
> > +{
> > +	if (!ntb->ops->msg_size)
> > +		return 0;
> > +
> > +	return ntb->ops->msg_size(ntb);
> > +}
> > +
> >  #endif
> > --
> > 2.6.6
>

Finally, I've answered to all the questions. Hopefully the things look clea=
rer now.

Regards,
-Sergey

