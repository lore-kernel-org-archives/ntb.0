Return-Path: <dave.jiang@intel.com>
Received: from mga03.intel.com (mga03.intel.com. [134.134.136.65])
        by gmr-mx.google.com with ESMTPS id l14-v6si2872938uaa.4.2018.05.31.13.15.33
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 May 2018 13:15:33 -0700 (PDT)
Subject: Re: ntb_tool cannot dma_alloc_coherent with CMA (over switchtec)
References: <8A1F3ACA2F40C04FBF91985D6F491D7C0176649B@MX302CL01.corp.emc.com>
 <1f327d5f-5bd9-12ee-2569-8f66eb0034c2@intel.com>
 <8A1F3ACA2F40C04FBF91985D6F491D7C01766605@MX302CL01.corp.emc.com>
From: Dave Jiang <dave.jiang@intel.com>
Message-ID: <e04364ff-cbbf-b53d-a35d-9b55a6cb0857@intel.com>
Date: Thu, 31 May 2018 13:15:31 -0700
MIME-Version: 1.0
In-Reply-To: <8A1F3ACA2F40C04FBF91985D6F491D7C01766605@MX302CL01.corp.emc.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
To: "Glimcher, Boris" <Boris.Glimcher@dell.com>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>



On 05/31/2018 12:44 PM, Glimcher, Boris wrote:
> Dave,
> 
>  
> 
> How can I enable IOMMU?

Turn VTd on in your BIOS. Set intel_iommu=on as a kernel boot parameter.
If you are using Intel CPU.

> 
> Are you referring to “NTB: PCI Quirk to Enable Switchtec NT
> Functionality with IOMMU On” patch?
> 
>  
> 
> --
> 
> Best regards, Boris
> 
> Let me google that for you <http://lmgtfy.com/>
> 
>  
> 
> *From:*linux-ntb@googlegroups.com [mailto:linux-ntb@googlegroups.com]
> *On Behalf Of *Dave Jiang
> *Sent:* Thursday, May 31, 2018 22:31
> *To:* Glimcher, Boris; linux-ntb@googlegroups.com
> *Subject:* Re: ntb_tool cannot dma_alloc_coherent with CMA (over switchtec)
> 
>  
> 
>  
> 
> On 5/31/2018 9:32 AM, Glimcher, Boris wrote:
> 
>     Hi,
> 
>      
> 
>     I’m trying to enlarge buffers I use in ntb_tool by using cma:
> 
>     $ dmesg | grep cma
> 
>     [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-4.14.17
>     root=UUID=71fb5fd6-0242-444e-8e17-d31d65051f61 ro crashkernel=auto
>     rhgb quiet cma=32G hugepages=100000 intel_pstate=disable
> 
>     [    0.000000] cma: Reserved 32768 MiB at 0x000000f87fc00000
> 
>     [    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-4.14.17
>     root=UUID=71fb5fd6-0242-444e-8e17-d31d65051f61 ro crashkernel=auto
>     rhgb quiet cma=32G hugepages=100000 intel_pstate=disable
> 
>     [    0.000000] Memory: 6057140K/1073389456K available (10252K kernel
>     code, 2231K rwdata, 3476K rodata, 2252K init, 3040K bss, 17104596K
>     reserved, 33554432K cma-reserved)
> 
>      
> 
>     grep -i cma /proc/meminfo
> 
>     CmaTotal:       33554432 kB
> 
>     CmaFree:        33501788 kB
> 
>      
> 
>     After loading drivers I allocate memory (uses dma_alloc_coherent):
> 
>     echo 20971520 > /sys/kernel/debug/ntb_tool/0000\:3b\:00.1/peer_trans1
> 
>      
> 
>     I get this stack:
> 
>      
> 
>     [  313.224544] switchtec 0000:3b:00.1: swiotlb buffer is full (sz:
>     20971520 bytes)
> 
>     [  313.224546] swiotlb: coherent allocation failed for device
>     0000:3b:00.1 size=20971520
> 
> So it's quite difficult to allocate CMA memory on x86 without iommu
> enabled as I discovered. Anything larger than 4M and you are pretty much
> doing it by luck. When you turn the iommu on it does not go through
> swiotlb and that seems to work fairly well.
> 
>  
> 
>     [  313.224550] Call Trace:
> 
>     [  313.224560]  dump_stack+0x5c/0x83
> 
>     [  313.224567]  swiotlb_alloc_coherent+0x14c/0x160
> 
>     [  313.224572]  tool_peer_mw_trans_write+0x1b2/0x320 [ntb_tool]
> 
>     [  313.224578]  ? perf_trace_mm_compaction_migratepages+0x5a/0x120
> 
>     [  313.224584]  full_proxy_write+0x5a/0xa0
> 
>     [  313.224589]  __vfs_write+0x33/0x170
> 
>     [  313.224594]  ? handle_mm_fault+0xc4/0x1d0
> 
>     [  313.224599]  ? __audit_syscall_entry+0xaf/0x100
> 
>     [  313.224601]  vfs_write+0xad/0x1a0
> 
>     [  313.224603]  SyS_write+0x52/0xc0
> 
>     [  313.224608]  do_syscall_64+0x61/0x1a0
> 
>     [  313.224614]  entry_SYSCALL64_slow_path+0x25/0x25
> 
>     [  313.224616] RIP: 0033:0x7f79ac50e840
> 
>     [  313.224617] RSP: 002b:00007ffc8e89afe8 EFLAGS: 00000246 ORIG_RAX:
>     0000000000000001
> 
>     [  313.224619] RAX: ffffffffffffffda RBX: 0000000000000009 RCX:
>     00007f79ac50e840
> 
>     [  313.224619] RDX: 0000000000000009 RSI: 00007f79ace2d000 RDI:
>     0000000000000001
> 
>     [  313.224620] RBP: 00007f79ace2d000 R08: 000000000000000a R09:
>     00007f79ace27740
> 
>     [  313.224621] R10: 00007ffc8e89ad90 R11: 0000000000000246 R12:
>     00007f79ac7e2400
> 
>     [  313.224622] R13: 0000000000000009 R14: 0000000000000001 R15:
>     0000000000000000
> 
>      
> 
>     Any help please?
> 
>      
> 
>     --
> 
>     Best regards, Boris
> 
>      
> 
>     -- 
>     You received this message because you are subscribed to the Google
>     Groups "linux-ntb" group.
>     To unsubscribe from this group and stop receiving emails from it,
>     send an email to linux-ntb+unsubscribe@googlegroups.com
>     <mailto:linux-ntb+unsubscribe@googlegroups.com>.
>     To post to this group, send email to linux-ntb@googlegroups.com
>     <mailto:linux-ntb@googlegroups.com>.
>     To view this discussion on the web visit
>     https://groups.google.com/d/msgid/linux-ntb/8A1F3ACA2F40C04FBF91985D6F491D7C0176649B%40MX302CL01.corp.emc.com
>     <https://groups.google.com/d/msgid/linux-ntb/8A1F3ACA2F40C04FBF91985D6F491D7C0176649B%40MX302CL01.corp.emc.com?utm_medium=email&utm_source=footer>.
>     For more options, visit https://groups.google.com/d/optout.
> 
> -- 
> You received this message because you are subscribed to the Google
> Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send
> an email to linux-ntb+unsubscribe@googlegroups.com
> <mailto:linux-ntb+unsubscribe@googlegroups.com>.
> To post to this group, send email to linux-ntb@googlegroups.com
> <mailto:linux-ntb@googlegroups.com>.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/linux-ntb/1f327d5f-5bd9-12ee-2569-8f66eb0034c2%40intel.com
> <https://groups.google.com/d/msgid/linux-ntb/1f327d5f-5bd9-12ee-2569-8f66eb0034c2%40intel.com?utm_medium=email&utm_source=footer>.
> For more options, visit https://groups.google.com/d/optout.
> 
