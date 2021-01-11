Return-Path: <tglx@linutronix.de>
Received: from galois.linutronix.de (Galois.linutronix.de. [2a0a:51c0:0:12e:550::1])
        by gmr-mx.google.com with ESMTPS id i22si786162ljj.8.2021.01.11.02.14.39
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 02:14:39 -0800 (PST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 02/30] genirq: Move status flag checks to core
In-Reply-To: <20201227192049.GA195845@roeck-us.net>
References: <20201210192536.118432146@linutronix.de> <20201210194042.703779349@linutronix.de> <20201227192049.GA195845@roeck-us.net>
Date: Mon, 11 Jan 2021 11:14:38 +0100
Message-ID: <87im837pbl.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
To: Guenter Roeck <linux@roeck-us.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, dri-devel@lists.freedesktop.org, Chris Wilson <chris@chris-wilson.co.uk>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org, Will Deacon <will@kernel.org>, Michal Simek <michal.simek@xilinx.com>, linux-s390@vger.kernel.org, afzal mohammed <afzal.mohd.ma@gmail.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Dave Jiang <dave.jiang@intel.com>, xen-devel@lists.xenproject.org, Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org, Marc Zyngier <maz@kernel.org>, Helge Deller <deller@gmx.de>, Russell King <linux@armlinux.org.uk>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-pci@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Wambui Karuga <wambui.karugax@gmail.com>, Allen Hubbe <allenbh@gmail.com>, Juergen Gross <jgross@suse.com>, David Airlie <airlied@linux.ie>, linux-gpio@vger.kernel.org, Stefano Stabellini <sstabellini@kernel.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, linux-parisc@vger.kernel.org, Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Tariq Toukan <tariqt@nvidia.com>, Jon Mason <jdmason@kudzu.us>, linux-ntb@googlegroups.com, intel-gfx@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>
List-ID: <linux-ntb.googlegroups.com>

On Sun, Dec 27 2020 at 11:20, Guenter Roeck wrote:
> On Thu, Dec 10, 2020 at 08:25:38PM +0100, Thomas Gleixner wrote:
> Yes, but that means that irq_check_status_bit() may be called from modules,
> but it is not exported, resulting in build errors such as the following.
>
> arm64:allmodconfig:
>
> ERROR: modpost: "irq_check_status_bit" [drivers/perf/arm_spe_pmu.ko] undefined!

Duh. Yes, that lacks an export obviously.

Thanks,

        tglx
