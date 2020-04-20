Return-Path: <jdmason@kudzu.us>
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com. [2607:f8b0:4864:20::834])
        by gmr-mx.google.com with ESMTPS id z126si140786qkd.2.2020.04.20.08.31.55
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2020 08:31:55 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id i68so3075102qtb.5
        for <linux-ntb@googlegroups.com>; Mon, 20 Apr 2020 08:31:55 -0700 (PDT)
Return-Path: <jdmason@kudzu.us>
Received: from kudzu.us ([2605:a601:a664:2e00:8846:46a:2e78:2224])
        by smtp.gmail.com with ESMTPSA id v188sm779031qkh.47.2020.04.20.08.31.53
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 08:31:54 -0700 (PDT)
Date: Mon, 20 Apr 2020 11:31:52 -0400
From: Jon Mason <jdmason@kudzu.us>
Subject: Smatch warnings
Message-ID: <20200420153151.GA23017@kudzu.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

FYI, I was using smatch when building the NTB code and saw the following
warnings.  If anyone is bored, feel free to address them.

Thanks,
Jon

---

  CALL    scripts/checksyscalls.sh
  CALL    scripts/atomic/check-atomics.sh
  DESCEND  objtool
  CHK     include/generated/compile.h
  CHK     kernel/kheaders_data.tar.xz
  CHECK   drivers/gpu/drm/i915/display/intel_frontbuffer.c
  CC [M]  drivers/gpu/drm/i915/display/intel_frontbuffer.o
  LD [M]  drivers/gpu/drm/i915/i915.o
  CHECK   drivers/net/ntb_netdev.c
  CC [M]  drivers/net/ntb_netdev.o
  LD [M]  drivers/ntb/ntb.o
  CHECK   drivers/ntb/ntb_transport.c
drivers/ntb/ntb_transport.c:1336 ntb_transport_probe() warn: should '1 << qp_count' be a 64 bit type?
  CC [M]  drivers/ntb/ntb_transport.o
  CHECK   drivers/ntb/hw/amd/ntb_hw_amd.c
  CC [M]  drivers/ntb/hw/amd/ntb_hw_amd.o
  CHECK   drivers/ntb/hw/idt/ntb_hw_idt.c
drivers/ntb/hw/idt/ntb_hw_idt.c:2514 idt_init_dbgfs() warn: passing zero to 'PTR_ERR'
drivers/ntb/hw/idt/ntb_hw_idt.c:2760 idt_pci_probe() warn: passing zero to 'PTR_ERR'
  CC [M]  drivers/ntb/hw/idt/ntb_hw_idt.o
  CHECK   drivers/ntb/hw/intel/ntb_hw_gen1.c
  CC [M]  drivers/ntb/hw/intel/ntb_hw_gen1.o
  CHECK   drivers/ntb/hw/intel/ntb_hw_gen3.c
  CC [M]  drivers/ntb/hw/intel/ntb_hw_gen3.o
  CHECK   drivers/ntb/hw/intel/ntb_hw_gen4.c
  CC [M]  drivers/ntb/hw/intel/ntb_hw_gen4.o
  LD [M]  drivers/ntb/hw/intel/ntb_hw_intel.o
  CHECK   drivers/ntb/hw/mscc/ntb_hw_switchtec.c
  CC [M]  drivers/ntb/hw/mscc/ntb_hw_switchtec.o
  CHECK   drivers/ntb/test/ntb_pingpong.c
  CC [M]  drivers/ntb/test/ntb_pingpong.o
  CHECK   drivers/ntb/test/ntb_tool.c
drivers/ntb/test/ntb_tool.c:1288 tool_inmsg_read() error: uninitialized symbol 'pidx'.
  CC [M]  drivers/ntb/test/ntb_tool.o
  CHECK   drivers/ntb/test/ntb_perf.c
  CC [M]  drivers/ntb/test/ntb_perf.o
  CHECK   drivers/ntb/test/ntb_msi_test.c
  CC [M]  drivers/ntb/test/ntb_msi_test.o
Kernel: arch/x86/boot/bzImage is ready  (#6)
  MODPOST 7760 modules
  LD [M]  drivers/gpu/drm/i915/i915.ko
  CC [M]  drivers/net/ntb_netdev.mod.o
  LD [M]  drivers/net/ntb_netdev.ko
  CC [M]  drivers/ntb/hw/amd/ntb_hw_amd.mod.o
  LD [M]  drivers/ntb/hw/amd/ntb_hw_amd.ko
  CC [M]  drivers/ntb/hw/idt/ntb_hw_idt.mod.o
  LD [M]  drivers/ntb/hw/idt/ntb_hw_idt.ko
  CC [M]  drivers/ntb/hw/intel/ntb_hw_intel.mod.o
  LD [M]  drivers/ntb/hw/intel/ntb_hw_intel.ko
  CC [M]  drivers/ntb/hw/mscc/ntb_hw_switchtec.mod.o
  LD [M]  drivers/ntb/hw/mscc/ntb_hw_switchtec.ko
  CC [M]  drivers/ntb/ntb.mod.o
  LD [M]  drivers/ntb/ntb.ko
  CC [M]  drivers/ntb/ntb_transport.mod.o
  LD [M]  drivers/ntb/ntb_transport.ko
  CC [M]  drivers/ntb/test/ntb_msi_test.mod.o
  LD [M]  drivers/ntb/test/ntb_msi_test.ko
  CC [M]  drivers/ntb/test/ntb_perf.mod.o
  LD [M]  drivers/ntb/test/ntb_perf.ko
  CC [M]  drivers/ntb/test/ntb_pingpong.mod.o
  LD [M]  drivers/ntb/test/ntb_pingpong.ko
  CC [M]  drivers/ntb/test/ntb_tool.mod.o
  LD [M]  drivers/ntb/test/ntb_tool.ko
