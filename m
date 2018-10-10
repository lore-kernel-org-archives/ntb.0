Return-Path: <dave.jiang@intel.com>
Received: from mga06.intel.com (mga06.intel.com. [134.134.136.31])
        by gmr-mx.google.com with ESMTPS id 131si410789vkx.3.2018.10.10.08.55.22
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 08:55:22 -0700 (PDT)
Subject: Re: Inbound translation setting failure in coherent allocation
References: <8C51E45097385D46B526390C84E223A34EE561EB@MX202CL01.corp.emc.com>
From: Dave Jiang <dave.jiang@intel.com>
Message-ID: <762f4d04-b879-8e71-483d-3cd9310185eb@intel.com>
Date: Wed, 10 Oct 2018 08:55:20 -0700
MIME-Version: 1.0
In-Reply-To: <8C51E45097385D46B526390C84E223A34EE561EB@MX202CL01.corp.emc.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
To: "Margolin, Omer" <Omer.Margolin@dell.com>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>, Serge Semin <fancer.lancer@gmail.com>
Cc: "Glimcher, Boris" <Boris.Glimcher@dell.com>, "Zekri, Ishay" <Ishay.Zekri@dell.com>
List-ID: <linux-ntb.googlegroups.com>


On 10/10/2018 06:11 AM, Margolin, Omer wrote:
> Hello,
> 
> Trying to evaluate the raw performance of Intel NTB using ntb_perf test
> tool we get a failure in coherent allocation.
> 
> response from Dave Jiang dave.jiang@intel.com <mailto:dave.jiang@intel.com>:
> "Hello. Upstream has been making quite a bit of changes recently to
> ntb_perf. If it's failing for you can you please post it to the ntb
> mailing list and inquire there? Hopefully it's just something Sergei did
> and he can help you fix. Thanks!"
> 
> Sergei can you please check if this is a result of latest changes?
> 
>  
> 
> Details:
> 
> ntb_perf module was loaded using the command below on both sides of the
> NTB connection:
> modprobe ntb_hw_intel b2b_mw_idx=0 b2b_mw_share=0 dyndbg=+pmfl
> 
> Failure in setting inbuf translation.
> [ 553.816242] ntb_perf 0000:82:00.0: Failed to set inbuf translation

Serge,
This is odd because the Intel driver does not have peer_mw_set_trans().
It should've just returned 0. Thoughts?

> 
> Using the MW (allocation and translation) works using ntb_tool
> 
> dmesg details:
> 
> 
>   NTB Perf
> 
> 
>     Failure for 1M coherent allocation:
> 
> [ 162.949502] Intel(R) PCI-E Non-Transparent Bridge Driver 2.0
> [ 162.955791] ntb_hw_intel:gen3_init_dev:242: ntb_hw_intel 0000:82:00.0:
> ppd 0x1d topo NTB_TOPO_B2B_DSD
> [ 162.955798] ntb_hw_intel:gen3_setup_b2b_mw:157: ntb_hw_intel
> 0000:82:00.0: IMBAR1XLMT 0x2000000000000000
> [ 162.955802] ntb_hw_intel:gen3_setup_b2b_mw:162: ntb_hw_intel
> 0000:82:00.0: IMBAR2XLMT 0x4000000000000000
> [ 162.956809] ntb_hw_intel:ndev_init_isr:410: ntb_hw_intel 0000:82:00.0:
> Using 33 msix interrupts
> [ 162.956892] ntb_hw_intel 0000:82:00.0: NTB device registered.
> [ 162.973528] ntb_perf:perf_init_peers:1427: ntb_perf 0000:82:00.0:
> Global port index 1
> [ 162.973533] ntb_perf:perf_init_service:673: ntb_perf 0000:82:00.0:
> Message service unsupported
> [ 162.973536] ntb_perf:perf_init_service:681: ntb_perf 0000:82:00.0:
> Scratchpad service initialized
> [ 162.973548] ntb_perf:perf_enable_service:723: ntb_perf 0000:82:00.0:
> DB bits unmasked 0x2
> [ 162.973552] ntb_hw_intel:intel_ntb3_link_enable:429: ntb_hw_intel
> 0000:82:00.0: Enabling link with max_speed -1 max_width -1
> [ 162.973556] ntb_perf:perf_cmd_exec:449: ntb_perf 0000:82:00.0: CMD exec: 0
> [ 162.973568] ntb_perf:perf_spad_cmd_send:261: ntb_perf 0000:82:00.0:
> CMD send: 0 0x100000
> [ 167.827758] ntb_hw_intel:ndev_vec_isr:352: ntb_hw_intel 0000:82:00.0:
> irq: 243 nvec->num: 1
> [ 167.827764] ntb_hw_intel:ndev_interrupt:332: ntb_hw_intel
> 0000:82:00.0: vec 1 vec_mask 2
> [ 167.827772] ntb_perf:perf_db_event:509: ntb_perf 0000:82:00.0: DB vec
> 1 mask 0x2 bits 0x2
> [ 167.827778] ntb_perf:perf_spad_cmd_recv:339: ntb_perf 0000:82:00.0:
> CMD recv: 0 0x400000000
> [ 167.827781] ntb_perf:perf_cmd_exec:449: ntb_perf 0000:82:00.0: CMD exec: 1
> [ 171.807351] ntb_perf 0000:82:00.0: Failed to set inbuf translation
> [ 171.813539] ntb_hw_intel:intel_ntb3_mw_set_trans:498: ntb_hw_intel
> 0000:82:00.0: BAR 2 IMBARXBASE: 0x0
> [ 171.813542] ntb_hw_intel:intel_ntb3_mw_set_trans:509: ntb_hw_intel
> 0000:82:00.0: BAR 2 IMBARXLMT: 0xd9000000000
> [ 171.813546] ntb_hw_intel:intel_ntb3_mw_set_trans:530: ntb_hw_intel
> 0000:82:00.0: BAR 2 EMBARXLMT: 0x800000000000
> [ 262.244384] ntb_hw_intel:intel_ntb_link_disable:1005: ntb_hw_intel
> 0000:82:00.0: Disabling link
> [ 262.244391] ntb_perf:perf_cmd_exec:449: ntb_perf 0000:82:00.0: CMD exec: 4
> [ 262.244439] ntb_hw_intel:ndev_vec_isr:352: ntb_hw_intel 0000:82:00.0:
> irq: 273 nvec->num: 31
> [ 262.244445] ntb_hw_intel:ndev_interrupt:332: ntb_hw_intel
> 0000:82:00.0: vec 31 vec_mask ffffffff80000000
> 
> 
>   NTB tool:
> 
> 
>     Successful allocation and data transfer using ntb_tool on 16G MW (idx 1)
> 
> [root@xbrick4000-n1 ~]# echo 1073741824 >
> /sys/kernel/debug/ntb_tool/0000:82:00.0/peer0/mw_trans1
> [root@xbrick4000-n1 ~]#
> [root@xbrick4000-n1 ~]#
> [root@xbrick4000-n1 ~]# grep Cma /proc/meminfo
> CmaTotal: 33554432 kB
> CmaFree: 16765120 kB
> 
> [ 973.330070] ntb_hw_intel:ndev_vec_isr:352: ntb_hw_intel 0000:82:00.0:
> irq: 255 nvec->num: 31
> [ 973.330076] ntb_hw_intel:ndev_interrupt:332: ntb_hw_intel
> 0000:82:00.0: vec 31 vec_mask ffffffff80000000
> [ 973.330086] ntb_tool:tool_link_event:299: ntb_tool 0000:82:00.0: link
> is up speed 3 width 8
> [ 973.330092] ntb_tool:tool_db_event:313: ntb_tool 0000:82:00.0:
> doorbell vec 31 mask 0x80000000 bits 0x0
> [ 995.713469] ntb_hw_intel:intel_ntb3_mw_set_trans:498: ntb_hw_intel
> 0000:82:00.0: BAR 2 IMBARXBASE: 0x5840700000
> [ 995.713475] ntb_hw_intel:intel_ntb3_mw_set_trans:509: ntb_hw_intel
> 0000:82:00.0: BAR 2 IMBARXLMT: 0xd9000100000
> [ 995.713481] ntb_hw_intel:intel_ntb3_mw_set_trans:530: ntb_hw_intel
> 0000:82:00.0: BAR 2 EMBARXLMT: 0x800000100000
> [ 1148.789358] ntb_hw_intel:intel_ntb3_mw_set_trans:498: ntb_hw_intel
> 0000:82:00.0: BAR 4 IMBARXBASE: 0x5c00000000
> [ 1148.789363] ntb_hw_intel:intel_ntb3_mw_set_trans:509: ntb_hw_intel
> 0000:82:00.0: BAR 4 IMBARXLMT: 0xd0400000000
> [ 1148.789367] ntb_hw_intel:intel_ntb3_mw_set_trans:530: ntb_hw_intel
> 0000:82:00.0: BAR 4 EMBARXLMT: 0x1000400000000
> 
> [root@xbrick4000-n2 ~]# echo 0xADD0BA5E:1073741824 >
> /sys/kernel/debug/ntb_tool/0000:82:00.0/peer0/peer_mw_trans1
> [root@xbrick4000-n2 ~]# echo "Hello from the other side" >
> /sys/kernel/debug/ntb_tool/0000:82:00.0/peer0/peer_mw1
> 
> [root@xbrick4000-n1 ~]# head -c70
> /sys/kernel/debug/ntb_tool/0000:82:00.0/peer0/mw1
> Hello from the other side
> 
> Thanks,
> 
>  
> 
> *Omer Margolin | Hardware Engineer | XtremIO/EMC²*
> 
> *Mobile: +972 54 4660539 | Office: +972 72 2563334*
> 
> *Address: Kibbutz Glil-Yam, Herzelia 4690500, Israel*
> 
> *Email: omer.margolin@emc.com <mailto:omer.margolin@emc.com>*
> 
> XtremIO_EMC
> 
>  
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
> https://groups.google.com/d/msgid/linux-ntb/8C51E45097385D46B526390C84E223A34EE561EB%40MX202CL01.corp.emc.com
> <https://groups.google.com/d/msgid/linux-ntb/8C51E45097385D46B526390C84E223A34EE561EB%40MX202CL01.corp.emc.com?utm_medium=email&utm_source=footer>.
> For more options, visit https://groups.google.com/d/optout.
