Return-Path: <jani.nikula@intel.com>
Received: from mga14.intel.com (mga14.intel.com. [192.55.52.115])
        by gmr-mx.google.com with ESMTPS id k6si581862ybd.5.2020.12.11.01.52.15
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Dec 2020 01:52:15 -0800 (PST)
From: Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [Intel-gfx] [patch 13/30] drm/i915/lpe_audio: Remove pointless irq_to_desc() usage
In-Reply-To: <X9J7h+myHaraeoKH@intel.com>
References: <20201210192536.118432146@linutronix.de> <20201210194043.862572239@linutronix.de> <X9J7h+myHaraeoKH@intel.com>
Date: Fri, 11 Dec 2020 11:51:57 +0200
Message-ID: <87zh2k7jr6.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>, Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Linus Walleij <linus.walleij@linaro.org>, dri-devel@lists.freedesktop.org, Chris Wilson <chris@chris-wilson.co.uk>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Russell King <linux@armlinux.org.uk>, afzal mohammed <afzal.mohd.ma@gmail.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Dave Jiang <dave.jiang@intel.com>, Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org, Marc Zyngier <maz@kernel.org>, Helge Deller <deller@gmx.de>, Michal Simek <michal.simek@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org, intel-gfx@lists.freedesktop.org, Wambui Karuga <wambui.karugax@gmail.com>, Allen Hubbe <allenbh@gmail.com>, Will Deacon <will@kernel.org>, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, linux-gpio@vger.kernel.org, Stefano Stabellini <sstabellini@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org, Juergen Gross <jgross@suse.com>, David Airlie <airlied@linux.ie>, linux-parisc@vger.kernel.org, netdev@vger.kernel.org, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, LKML <linux-kernel@vger.kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Jon Mason <jdmason@kudzu.us>, linux-ntb@googlegroups.com, Saeed Mahameed <saeedm@nvidia.com>, "David S. Miller" <davem@davemloft.net>
List-ID: <linux-ntb.googlegroups.com>

On Thu, 10 Dec 2020, Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com=
> wrote:
> On Thu, Dec 10, 2020 at 08:25:49PM +0100, Thomas Gleixner wrote:
>> Nothing uses the result and nothing should ever use it in driver code.
>>=20
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Jani Nikula <jani.nikula@linux.intel.com>
>> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
>> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
>> Cc: David Airlie <airlied@linux.ie>
>> Cc: Daniel Vetter <daniel@ffwll.ch>
>> Cc: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
>> Cc: Chris Wilson <chris@chris-wilson.co.uk>
>> Cc: Wambui Karuga <wambui.karugax@gmail.com>
>> Cc: intel-gfx@lists.freedesktop.org
>> Cc: dri-devel@lists.freedesktop.org
>
> Reviewed-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>

Thomas, I presume you want to merge this series as a whole.

Acked-by: Jani Nikula <jani.nikula@intel.com>

for merging via whichever tree makes most sense. Please let us know if
you want us to pick this up via drm-intel instead.

>
>> ---
>>  drivers/gpu/drm/i915/display/intel_lpe_audio.c |    4 ----
>>  1 file changed, 4 deletions(-)
>>=20
>> --- a/drivers/gpu/drm/i915/display/intel_lpe_audio.c
>> +++ b/drivers/gpu/drm/i915/display/intel_lpe_audio.c
>> @@ -297,13 +297,9 @@ int intel_lpe_audio_init(struct drm_i915
>>   */
>>  void intel_lpe_audio_teardown(struct drm_i915_private *dev_priv)
>>  {
>> -	struct irq_desc *desc;
>> -
>>  	if (!HAS_LPE_AUDIO(dev_priv))
>>  		return;
>>=20=20
>> -	desc =3D irq_to_desc(dev_priv->lpe_audio.irq);
>> -
>>  	lpe_audio_platdev_destroy(dev_priv);
>>=20=20
>>  	irq_free_desc(dev_priv->lpe_audio.irq);
>>=20
>> _______________________________________________
>> Intel-gfx mailing list
>> Intel-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/intel-gfx

--=20
Jani Nikula, Intel Open Source Graphics Center
