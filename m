Return-Path: <tglx@linutronix.de>
Received: from galois.linutronix.de (Galois.linutronix.de. [2a0a:51c0:0:12e:550::1])
        by gmr-mx.google.com with ESMTPS id 10si390512wml.0.2020.12.11.13.27.44
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 13:27:44 -0800 (PST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 27/30] xen/events: Only force affinity mask for percpu interrupts
In-Reply-To: <9806692f-24a3-4b6f-ae55-86bd66481271@oracle.com>
References: <20201210192536.118432146@linutronix.de> <20201210194045.250321315@linutronix.de> <7f7af60f-567f-cdef-f8db-8062a44758ce@oracle.com> <2164a0ce-0e0d-c7dc-ac97-87c8f384ad82@suse.com> <871rfwiknd.fsf@nanos.tec.linutronix.de> <9806692f-24a3-4b6f-ae55-86bd66481271@oracle.com>
Date: Fri, 11 Dec 2020 22:27:43 +0100
Message-ID: <877dpoghio.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: boris.ostrovsky@oracle.com, =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Marc Zyngier <maz@kernel.org>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, afzal mohammed <afzal.mohd.ma@gmail.com>, linux-parisc@vger.kernel.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>, Chris Wilson <chris@chris-wilson.co.uk>, Wambui Karuga <wambui.karugax@gmail.com>, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Michal Simek <michal.simek@xilinx.com>, linux-pci@vger.kernel.org, Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Tariq Toukan <tariqt@nvidia.com>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>
List-ID: <linux-ntb.googlegroups.com>

On Fri, Dec 11 2020 at 09:29, boris ostrovsky wrote:

> On 12/11/20 7:37 AM, Thomas Gleixner wrote:
>> On Fri, Dec 11 2020 at 13:10, J=C3=BCrgen Gro=C3=9F wrote:
>>> On 11.12.20 00:20, boris.ostrovsky@oracle.com wrote:
>>>> On 12/10/20 2:26 PM, Thomas Gleixner wrote:
>>>>> Change the implementation so that the channel is bound to CPU0 at the=
 XEN
>>>>> level and leave the affinity mask alone. At startup of the interrupt
>>>>> affinity will be assigned out of the affinity mask and the XEN bindin=
g will
>>>>> be updated.
>>>>
>>>> If that's the case then I wonder whether we need this call at all and =
instead bind at startup time.
>>> After some discussion with Thomas on IRC and xen-devel archaeology the
>>> result is: this will be needed especially for systems running on a
>>> single vcpu (e.g. small guests), as the .irq_set_affinity() callback
>>> won't be called in this case when starting the irq.
>
> On UP are we not then going to end up with an empty affinity mask? Or
> are we guaranteed to have it set to 1 by interrupt generic code?

An UP kernel does not ever look on the affinity mask. The
chip::irq_set_affinity() callback is not invoked so the mask is
irrelevant.

A SMP kernel on a UP machine sets CPU0 in the mask so all is good.

> This is actually why I brought this up in the first place --- a
> potential mismatch between the affinity mask and Xen-specific data
> (e.g. info->cpu and then protocol-specific data in event channel
> code). Even if they are re-synchronized later, at startup time (for
> SMP).

Which is not a problem either. The affinity mask is only relevant for
setting the affinity, but it's not relevant for delivery and never can
be.

> I don't see anything that would cause a problem right now but I worry
> that this inconsistency may come up at some point.

As long as the affinity mask becomes not part of the event channel magic
this should never matter.

Look at it from hardware:

interrupt is affine to CPU0

     CPU0 runs:
=20=20=20=20=20
     set_affinity(CPU0 -> CPU1)
        local_irq_disable()
=20=20=20=20=20=20=20=20
 --> interrupt is raised in hardware and pending on CPU0

        irq hardware is reconfigured to be affine to CPU1

        local_irq_enable()

 --> interrupt is handled on CPU0

the next interrupt will be raised on CPU1

So info->cpu which is registered via the hypercall binds the 'hardware
delivery' and whenever the new affinity is written it is rebound to some
other CPU and the next interrupt is then raised on this other CPU.

It's not any different from the hardware example at least not as far as
I understood the code.

Thanks,

        tglx
