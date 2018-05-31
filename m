Return-Path: <dave.jiang@intel.com>
Received: from mga07.intel.com (mga07.intel.com. [134.134.136.100])
        by gmr-mx.google.com with ESMTPS id x1-v6si220438pgp.4.2018.05.31.12.31.10
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 May 2018 12:31:10 -0700 (PDT)
Subject: Re: ntb_tool cannot dma_alloc_coherent with CMA (over switchtec)
References: <8A1F3ACA2F40C04FBF91985D6F491D7C0176649B@MX302CL01.corp.emc.com>
From: Dave Jiang <dave.jiang@intel.com>
Message-ID: <1f327d5f-5bd9-12ee-2569-8f66eb0034c2@intel.com>
Date: Thu, 31 May 2018 12:31:09 -0700
MIME-Version: 1.0
In-Reply-To: <8A1F3ACA2F40C04FBF91985D6F491D7C0176649B@MX302CL01.corp.emc.com>
Content-Type: multipart/alternative;
 boundary="------------3CFF2E0C1BF77A943B2399DE"
Content-Language: en-US
To: "Glimcher, Boris" <Boris.Glimcher@dell.com>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

This is a multi-part message in MIME format.
--------------3CFF2E0C1BF77A943B2399DE
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit


On 5/31/2018 9:32 AM, Glimcher, Boris wrote:
>
> Hi,
>
> I’m trying to enlarge buffers I use in ntb_tool by using cma:
>
> $ dmesg | grep cma
>
> [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-4.14.17 
> root=UUID=71fb5fd6-0242-444e-8e17-d31d65051f61 ro crashkernel=auto 
> rhgb quiet cma=32G hugepages=100000 intel_pstate=disable
>
> [    0.000000] cma: Reserved 32768 MiB at 0x000000f87fc00000
>
> [    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-4.14.17 
> root=UUID=71fb5fd6-0242-444e-8e17-d31d65051f61 ro crashkernel=auto 
> rhgb quiet cma=32G hugepages=100000 intel_pstate=disable
>
> [    0.000000] Memory: 6057140K/1073389456K available (10252K kernel 
> code, 2231K rwdata, 3476K rodata, 2252K init, 3040K bss, 17104596K 
> reserved, 33554432K cma-reserved)
>
> grep -i cma /proc/meminfo
>
> CmaTotal: 33554432 kB
>
> CmaFree: 33501788 kB
>
> After loading drivers I allocate memory (uses dma_alloc_coherent):
>
> echo 20971520 > /sys/kernel/debug/ntb_tool/0000\:3b\:00.1/peer_trans1
>
> I get this stack:
>
> [  313.224544] switchtec 0000:3b:00.1: swiotlb buffer is full (sz: 
> 20971520 bytes)
>
> [  313.224546] swiotlb: coherent allocation failed for device 
> 0000:3b:00.1 size=20971520
>
So it's quite difficult to allocate CMA memory on x86 without iommu 
enabled as I discovered. Anything larger than 4M and you are pretty much 
doing it by luck. When you turn the iommu on it does not go through 
swiotlb and that seems to work fairly well.


> [  313.224550] Call Trace:
>
> [  313.224560]  dump_stack+0x5c/0x83
>
> [  313.224567] swiotlb_alloc_coherent+0x14c/0x160
>
> [  313.224572] tool_peer_mw_trans_write+0x1b2/0x320 [ntb_tool]
>
> [  313.224578]  ? perf_trace_mm_compaction_migratepages+0x5a/0x120
>
> [  313.224584] full_proxy_write+0x5a/0xa0
>
> [  313.224589]  __vfs_write+0x33/0x170
>
> [  313.224594]  ? handle_mm_fault+0xc4/0x1d0
>
> [  313.224599]  ? __audit_syscall_entry+0xaf/0x100
>
> [  313.224601]  vfs_write+0xad/0x1a0
>
> [  313.224603]  SyS_write+0x52/0xc0
>
> [  313.224608]  do_syscall_64+0x61/0x1a0
>
> [  313.224614] entry_SYSCALL64_slow_path+0x25/0x25
>
> [  313.224616] RIP: 0033:0x7f79ac50e840
>
> [  313.224617] RSP: 002b:00007ffc8e89afe8 EFLAGS: 00000246 ORIG_RAX: 
> 0000000000000001
>
> [  313.224619] RAX: ffffffffffffffda RBX: 0000000000000009 RCX: 
> 00007f79ac50e840
>
> [  313.224619] RDX: 0000000000000009 RSI: 00007f79ace2d000 RDI: 
> 0000000000000001
>
> [  313.224620] RBP: 00007f79ace2d000 R08: 000000000000000a R09: 
> 00007f79ace27740
>
> [  313.224621] R10: 00007ffc8e89ad90 R11: 0000000000000246 R12: 
> 00007f79ac7e2400
>
> [  313.224622] R13: 0000000000000009 R14: 0000000000000001 R15: 
> 0000000000000000
>
> Any help please?
>
> --
>
> Best regards, Boris
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
> https://groups.google.com/d/msgid/linux-ntb/8A1F3ACA2F40C04FBF91985D6F491D7C0176649B%40MX302CL01.corp.emc.com 
> <https://groups.google.com/d/msgid/linux-ntb/8A1F3ACA2F40C04FBF91985D6F491D7C0176649B%40MX302CL01.corp.emc.com?utm_medium=email&utm_source=footer>.
> For more options, visit https://groups.google.com/d/optout.

--------------3CFF2E0C1BF77A943B2399DE
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 5/31/2018 9:32 AM, Glimcher, Boris
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:8A1F3ACA2F40C04FBF91985D6F491D7C0176649B@MX302CL01.corp.emc.com">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <div class="WordSection1">
        <p class="MsoPlainText">Hi,<o:p></o:p></p>
        <p class="MsoPlainText"><o:p> </o:p></p>
        <p class="MsoPlainText">I’m trying to enlarge buffers I use in
          ntb_tool by using cma:<o:p></o:p></p>
        <p class="MsoPlainText" style="text-indent:.5in">$ dmesg | grep
          cma<o:p></o:p></p>
        <p class="MsoPlainText" style="text-indent:.5in">[    0.000000]
          Command line: BOOT_IMAGE=/vmlinuz-4.14.17
          root=UUID=71fb5fd6-0242-444e-8e17-d31d65051f61 ro
          crashkernel=auto rhgb quiet cma=32G hugepages=100000
          intel_pstate=disable<o:p></o:p></p>
        <p class="MsoPlainText" style="text-indent:.5in">[    0.000000]
          cma: Reserved 32768 MiB at 0x000000f87fc00000<o:p></o:p></p>
        <p class="MsoPlainText" style="text-indent:.5in">[    0.000000]
          Kernel command line: BOOT_IMAGE=/vmlinuz-4.14.17
          root=UUID=71fb5fd6-0242-444e-8e17-d31d65051f61 ro
          crashkernel=auto rhgb quiet cma=32G hugepages=100000
          intel_pstate=disable<o:p></o:p></p>
        <p class="MsoPlainText" style="text-indent:.5in">[    0.000000]
          Memory: 6057140K/1073389456K available (10252K kernel code,
          2231K rwdata, 3476K rodata, 2252K init, 3040K bss, 17104596K
          reserved, 33554432K cma-reserved)<o:p></o:p></p>
        <p class="MsoPlainText"><o:p> </o:p></p>
        <p class="MsoPlainText">grep -i cma /proc/meminfo <o:p></o:p></p>
        <p class="MsoPlainText" style="text-indent:.5in">CmaTotal:      
          33554432 kB<o:p></o:p></p>
        <p class="MsoPlainText" style="text-indent:.5in">CmaFree:       
          33501788 kB<o:p></o:p></p>
        <p class="MsoPlainText"><o:p> </o:p></p>
        <p class="MsoPlainText">After loading drivers I allocate memory
          (uses dma_alloc_coherent):<o:p></o:p></p>
        <p class="MsoPlainText" style="text-indent:.5in">echo 20971520
          &gt; /sys/kernel/debug/ntb_tool/0000\:3b\:00.1/peer_trans1<o:p></o:p></p>
        <p class="MsoPlainText"><o:p> </o:p></p>
        <p class="MsoPlainText">I get this stack:<o:p></o:p></p>
        <p class="MsoPlainText"><o:p> </o:p></p>
        <p class="MsoPlainText">[  313.224544] switchtec 0000:3b:00.1:
          swiotlb buffer is full (sz: 20971520 bytes)<o:p></o:p></p>
        <p class="MsoPlainText">[  313.224546] swiotlb: coherent
          allocation failed for device 0000:3b:00.1 size=20971520<o:p></o:p></p>
      </div>
    </blockquote>
    <p>So it's quite difficult to allocate CMA memory on x86 without
      iommu enabled as I discovered. Anything larger than 4M and you are
      pretty much doing it by luck. When you turn the iommu on it does
      not go through swiotlb and that seems to work fairly well. <br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite"
cite="mid:8A1F3ACA2F40C04FBF91985D6F491D7C0176649B@MX302CL01.corp.emc.com">
      <div class="WordSection1">
        <p class="MsoPlainText">[  313.224550] Call Trace:<o:p></o:p></p>
        <p class="MsoPlainText">[  313.224560]  dump_stack+0x5c/0x83<o:p></o:p></p>
        <p class="MsoPlainText">[  313.224567] 
          swiotlb_alloc_coherent+0x14c/0x160<o:p></o:p></p>
        <p class="MsoPlainText">[  313.224572] 
          tool_peer_mw_trans_write+0x1b2/0x320 [ntb_tool]<o:p></o:p></p>
        <p class="MsoPlainText">[  313.224578]  ?
          perf_trace_mm_compaction_migratepages+0x5a/0x120<o:p></o:p></p>
        <p class="MsoPlainText">[  313.224584] 
          full_proxy_write+0x5a/0xa0<o:p></o:p></p>
        <p class="MsoPlainText">[  313.224589]  __vfs_write+0x33/0x170<o:p></o:p></p>
        <p class="MsoPlainText">[  313.224594]  ?
          handle_mm_fault+0xc4/0x1d0<o:p></o:p></p>
        <p class="MsoPlainText">[  313.224599]  ?
          __audit_syscall_entry+0xaf/0x100<o:p></o:p></p>
        <p class="MsoPlainText">[  313.224601]  vfs_write+0xad/0x1a0<o:p></o:p></p>
        <p class="MsoPlainText">[  313.224603]  SyS_write+0x52/0xc0<o:p></o:p></p>
        <p class="MsoPlainText">[  313.224608]  do_syscall_64+0x61/0x1a0<o:p></o:p></p>
        <p class="MsoPlainText">[  313.224614] 
          entry_SYSCALL64_slow_path+0x25/0x25<o:p></o:p></p>
        <p class="MsoPlainText">[  313.224616] RIP: 0033:0x7f79ac50e840<o:p></o:p></p>
        <p class="MsoPlainText">[  313.224617] RSP:
          002b:00007ffc8e89afe8 EFLAGS: 00000246 ORIG_RAX:
          0000000000000001<o:p></o:p></p>
        <p class="MsoPlainText">[  313.224619] RAX: ffffffffffffffda
          RBX: 0000000000000009 RCX: 00007f79ac50e840<o:p></o:p></p>
        <p class="MsoPlainText">[  313.224619] RDX: 0000000000000009
          RSI: 00007f79ace2d000 RDI: 0000000000000001<o:p></o:p></p>
        <p class="MsoPlainText">[  313.224620] RBP: 00007f79ace2d000
          R08: 000000000000000a R09: 00007f79ace27740<o:p></o:p></p>
        <p class="MsoPlainText">[  313.224621] R10: 00007ffc8e89ad90
          R11: 0000000000000246 R12: 00007f79ac7e2400<o:p></o:p></p>
        <p class="MsoPlainText">[  313.224622] R13: 0000000000000009
          R14: 0000000000000001 R15: 0000000000000000<o:p></o:p></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <p class="MsoNormal">Any help please?<o:p></o:p></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <p class="MsoNormal">--<o:p></o:p></p>
        <p class="MsoNormal">Best regards, Boris<o:p></o:p></p>
        <p class="MsoNormal"><o:p> </o:p></p>
      </div>
      -- <br>
      You received this message because you are subscribed to the Google
      Groups "linux-ntb" group.<br>
      To unsubscribe from this group and stop receiving emails from it,
      send an email to <a
        href="mailto:linux-ntb+unsubscribe@googlegroups.com"
        moz-do-not-send="true">linux-ntb+unsubscribe@googlegroups.com</a>.<br>
      To post to this group, send email to <a
        href="mailto:linux-ntb@googlegroups.com" moz-do-not-send="true">linux-ntb@googlegroups.com</a>.<br>
      To view this discussion on the web visit <a
href="https://groups.google.com/d/msgid/linux-ntb/8A1F3ACA2F40C04FBF91985D6F491D7C0176649B%40MX302CL01.corp.emc.com?utm_medium=email&amp;utm_source=footer"
        moz-do-not-send="true">https://groups.google.com/d/msgid/linux-ntb/8A1F3ACA2F40C04FBF91985D6F491D7C0176649B%40MX302CL01.corp.emc.com</a>.<br>
      For more options, visit <a
        href="https://groups.google.com/d/optout" moz-do-not-send="true">https://groups.google.com/d/optout</a>.<br>
    </blockquote>
  </body>
</html>

--------------3CFF2E0C1BF77A943B2399DE--
