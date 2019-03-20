Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.99])
        by gmr-mx.google.com with ESMTPS id v2si197279qka.0.2019.03.20.14.13.34
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 14:13:34 -0700 (PDT)
Date: Wed, 20 Mar 2019 16:13:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH] drivers: ntb: Kconfig: pedantic cleanups
Message-ID: <20190320211331.GF251185@google.com>
References: <1551898265-18909-1-git-send-email-info@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551898265-18909-1-git-send-email-info@metux.net>
To: "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: linux-kernel@vger.kernel.org, kurt.schwemmer@microsemi.com, logang@deltatee.com, linux-ntb@googlegroups.com, linux-pci@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

[+cc Jon, Dave, Allen (NTB core maintainers)]

Hi Enrico,

I added the NTB maintainers, who will deal with these, but since
you're fixing pedantic issues, I'll give you some pedantic comments :)

The first is that you might put something here in the commit log, eg,
"fix Kconfig help text indentation" or whatever you're doing.

On Wed, Mar 06, 2019 at 07:51:05PM +0100, Enrico Weigelt, metux IT consult wrote:
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  drivers/ntb/Kconfig          | 20 ++++++++++----------
>  drivers/ntb/hw/amd/Kconfig   |  4 ++--
>  drivers/ntb/hw/idt/Kconfig   | 41 ++++++++++++++++++++---------------------
>  drivers/ntb/hw/intel/Kconfig |  4 ++--
>  drivers/ntb/hw/mscc/Kconfig  |  8 ++++----
>  drivers/ntb/test/Kconfig     | 26 +++++++++++++-------------
>  6 files changed, 51 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/ntb/Kconfig b/drivers/ntb/Kconfig
> index 95944e5..5ce3fdd 100644
> --- a/drivers/ntb/Kconfig
> +++ b/drivers/ntb/Kconfig
> @@ -2,13 +2,13 @@ menuconfig NTB
>  	tristate "Non-Transparent Bridge support"
>  	depends on PCI
>  	help
> -	 The PCI-E Non-transparent bridge hardware is a point-to-point PCI-E bus
> -	 connecting 2 systems.  When configured, writes to the device's PCI
> -	 mapped memory will be mirrored to a buffer on the remote system.  The
> -	 ntb Linux driver uses this point-to-point communication as a method to
> -	 transfer data from one system to the other.
> +	  The PCI-E Non-transparent bridge hardware is a point-to-point PCI-E bus

The usual spelling is "PCIe" instead of "PCI-E".

s/Non-transparent bridge/non-transparent bridge/

A "point-to-point PCIe bus" is usually called a "PCIe Link".

> +	  connecting 2 systems.  When configured, writes to the device's PCI
> +	  mapped memory will be mirrored to a buffer on the remote system.  The
> +	  ntb Linux driver uses this point-to-point communication as a method to

s/ntb Linux driver/Linux ntb driver/

> +	  transfer data from one system to the other.
>  
> -	 If unsure, say N.
> +	  If unsure, say N.
>  
>  if NTB
>  
> @@ -19,10 +19,10 @@ source "drivers/ntb/test/Kconfig"
>  config NTB_TRANSPORT
>  	tristate "NTB Transport Client"
>  	help
> -	 This is a transport driver that enables connected systems to exchange
> -	 messages over the ntb hardware.  The transport exposes a queue pair api
> -	 to client drivers.
> +	  This is a transport driver that enables connected systems to exchange
> +	  messages over the ntb hardware.  The transport exposes a queue pair api

s/ntb hardware/NTB hardware/

(I think it makes sense to use "ntb" when referring to the driver,
since that's its name, but when referring to the hardware, "NTB" is
being used as an acronym and probably should be capitalized.)

> +	  to client drivers.
>  
> -	 If unsure, say N.
> +	  If unsure, say N.
>  
>  endif # NTB
> diff --git a/drivers/ntb/hw/amd/Kconfig b/drivers/ntb/hw/amd/Kconfig
> index cfe903c..9a90f17 100644
> --- a/drivers/ntb/hw/amd/Kconfig
> +++ b/drivers/ntb/hw/amd/Kconfig
> @@ -2,6 +2,6 @@ config NTB_AMD
>  	tristate "AMD Non-Transparent Bridge support"
>  	depends on X86_64
>  	help
> -	 This driver supports AMD NTB on capable Zeppelin hardware.
> +	  This driver supports AMD NTB on capable Zeppelin hardware.
>  
> -	 If unsure, say N.
> +	  If unsure, say N.
> diff --git a/drivers/ntb/hw/idt/Kconfig b/drivers/ntb/hw/idt/Kconfig
> index f8948cf..5d106ac 100644
> --- a/drivers/ntb/hw/idt/Kconfig
> +++ b/drivers/ntb/hw/idt/Kconfig
> @@ -3,28 +3,27 @@ config NTB_IDT
>  	depends on PCI
>  	select HWMON
>  	help
> -	 This driver supports NTB of cappable IDT PCIe-switches.
> +	  This driver supports NTB of cappable IDT PCIe-switches.
>  
> -	 Some of the pre-initializations must be made before IDT PCIe-switch
> -	 exposes it NT-functions correctly. It should be done by either proper
> -	 initialisation of EEPROM connected to master smbus of the switch or
> -	 by BIOS using slave-SMBus interface changing corresponding registers
> -	 value. Evidently it must be done before PCI bus enumeration is
> -	 finished in Linux kernel.
> +	  Some of the pre-initializations must be made before IDT PCIe-switch
> +	  exposes it NT-functions correctly. It should be done by either proper

s/it/its/

s/correctly//
s/proper//

I always think "correct" and "proper" are sort of useless in comments.
Who wants to write incorrect or improper code?  Besides, they don't
convey any specific information.

> +	  initialisation of EEPROM connected to master smbus of the switch or
> +	  by BIOS using slave-SMBus interface changing corresponding registers

Capitalize "smbus/SMBus" consistently.  I think "SMBus" is typical.

> +	  value. Evidently it must be done before PCI bus enumeration is
> +	  finished in Linux kernel.
>  
> -	 First of all partitions must be activated and properly assigned to all
> -	 the ports with NT-functions intended to be activated (see SWPARTxCTL
> -	 and SWPORTxCTL registers). Then all NT-function BARs must be enabled
> -	 with chosen valid aperture. For memory windows related BARs the
> -	 aperture settings shall determine the maximum size of memory windows
> -	 accepted by a BAR. Note that BAR0 must map PCI configuration space
> -	 registers.
> +	  First of all partitions must be activated and properly assigned to all

s/properly// again :)

> +	  the ports with NT-functions intended to be activated (see SWPARTxCTL
> +	  and SWPORTxCTL registers). Then all NT-function BARs must be enabled
> +	  with chosen valid aperture. For memory windows related BARs the
> +	  aperture settings shall determine the maximum size of memory windows
> +	  accepted by a BAR. Note that BAR0 must map PCI configuration space
> +	  registers.
>  
> -	 It's worth to note, that since a part of this driver relies on the
> -	 BAR settings of peer NT-functions, the BAR setups can't be done over
> -	 kernel PCI fixups. That's why the alternative pre-initialization
> -	 techniques like BIOS using SMBus interface or EEPROM should be
> -	 utilized.
> -
> -	 If unsure, say N.
> +	  It's worth to note, that since a part of this driver relies on the

s/note,/note/

> +	  BAR settings of peer NT-functions, the BAR setups can't be done over
> +	  kernel PCI fixups. That's why the alternative pre-initialization
> +	  techniques like BIOS using SMBus interface or EEPROM should be
> +	  utilized.
>  
> +	  If unsure, say N.
> diff --git a/drivers/ntb/hw/intel/Kconfig b/drivers/ntb/hw/intel/Kconfig
> index 91f995e..c166d50 100644
> --- a/drivers/ntb/hw/intel/Kconfig
> +++ b/drivers/ntb/hw/intel/Kconfig
> @@ -2,6 +2,6 @@ config NTB_INTEL
>  	tristate "Intel Non-Transparent Bridge support"
>  	depends on X86_64
>  	help
> -	 This driver supports Intel NTB on capable Xeon and Atom hardware.
> +	  This driver supports Intel NTB on capable Xeon and Atom hardware.
>  
> -	 If unsure, say N.
> +	  If unsure, say N.
> diff --git a/drivers/ntb/hw/mscc/Kconfig b/drivers/ntb/hw/mscc/Kconfig
> index 013ed67..74ec015 100644
> --- a/drivers/ntb/hw/mscc/Kconfig
> +++ b/drivers/ntb/hw/mscc/Kconfig
> @@ -2,8 +2,8 @@ config NTB_SWITCHTEC
>  	tristate "MicroSemi Switchtec Non-Transparent Bridge Support"
>  	select PCI_SW_SWITCHTEC
>  	help
> -	 Enables NTB support for Switchtec PCI switches. This also
> -	 selects the Switchtec management driver as they share the same
> -	 hardware interface.
> +	  Enables NTB support for Switchtec PCI switches. This also
> +	  selects the Switchtec management driver as they share the same
> +	  hardware interface.
>  
> -	 If unsure, say N.
> +	  If unsure, say N.
> diff --git a/drivers/ntb/test/Kconfig b/drivers/ntb/test/Kconfig
> index a5d0eda..416ab56 100644
> --- a/drivers/ntb/test/Kconfig
> +++ b/drivers/ntb/test/Kconfig
> @@ -1,27 +1,27 @@
>  config NTB_PINGPONG
>  	tristate "NTB Ping Pong Test Client"
>  	help
> -	 This is a simple ping pong driver that exercises the scratchpads and
> -	 doorbells of the ntb hardware.  This driver may be used to test that
> -	 your ntb hardware and drivers are functioning at a basic level.
> +	  This is a simple ping pong driver that exercises the scratchpads and
> +	  doorbells of the ntb hardware.  This driver may be used to test that
> +	  your ntb hardware and drivers are functioning at a basic level.

s/ntb/NTB/ (twice)

> -	 If unsure, say N.
> +	  If unsure, say N.
>  
>  config NTB_TOOL
>  	tristate "NTB Debugging Tool Test Client"
>  	help
> -	 This is a simple debugging driver that enables the doorbell and
> -	 scratchpad registers to be read and written from the debugfs.  This
> -	 enables more complicated debugging to be scripted from user space.
> -	 This driver may be used to test that your ntb hardware and drivers are
> -	 functioning at a basic level.
> +	  This is a simple debugging driver that enables the doorbell and
> +	  scratchpad registers to be read and written from the debugfs.  This
> +	  enables more complicated debugging to be scripted from user space.
> +	  This driver may be used to test that your ntb hardware and drivers are
> +	  functioning at a basic level.

s/ntb/NTB/

> -	 If unsure, say N.
> +	  If unsure, say N.
>  
>  config NTB_PERF
>  	tristate "NTB RAW Perf Measuring Tool"
>  	help
> -	 This is a tool to measure raw NTB performance by transferring data
> -	 to and from the window without additional software interaction.
> +	  This is a tool to measure raw NTB performance by transferring data
> +	  to and from the window without additional software interaction.
>  
> -	 If unsure, say N.
> +	  If unsure, say N.
> -- 
> 1.9.1
> 
