Return-Path: <Boris.Glimcher@dell.com>
Received: from esa6.dell-outbound.iphmx.com (esa6.dell-outbound.iphmx.com. [68.232.149.229])
        by gmr-mx.google.com with ESMTPS id y6-v6si1032913qtn.1.2018.05.31.09.33.15
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 May 2018 09:33:16 -0700 (PDT)
From: "Glimcher, Boris" <Boris.Glimcher@dell.com>
Received: from maildlpprd56.lss.emc.com (maildlpprd56.lss.emc.com [10.106.48.160])
	by mailuogwprd53.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with ESMTP id w4VGXBpB031336
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
	for <linux-ntb@googlegroups.com>; Thu, 31 May 2018 12:33:13 -0400
Received: from mailusrhubprd54.lss.emc.com (mailusrhubprd54.lss.emc.com [10.106.48.19]) by maildlpprd56.lss.emc.com (RSA Interceptor) for <linux-ntb@googlegroups.com>; Thu, 31 May 2018 12:32:54 -0400
Received: from MXHUB308.corp.emc.com (MXHUB308.corp.emc.com [10.146.3.34])
	by mailusrhubprd54.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with ESMTP id w4VGWrFO000571
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=FAIL)
	for <linux-ntb@googlegroups.com>; Thu, 31 May 2018 12:32:53 -0400
Subject: ntb_tool cannot dma_alloc_coherent with CMA (over switchtec)
Date: Thu, 31 May 2018 16:32:52 +0000
Message-ID: <8A1F3ACA2F40C04FBF91985D6F491D7C0176649B@MX302CL01.corp.emc.com>
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_8A1F3ACA2F40C04FBF91985D6F491D7C0176649BMX302CL01corpem_"
MIME-Version: 1.0
To: "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

--_000_8A1F3ACA2F40C04FBF91985D6F491D7C0176649BMX302CL01corpem_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,



I'm trying to enlarge buffers I use in ntb_tool by using cma:

$ dmesg | grep cma

[    0.000000] Command line: BOOT_IMAGE=3D/vmlinuz-4.14.17 root=3DUUID=3D71=
fb5fd6-0242-444e-8e17-d31d65051f61 ro crashkernel=3Dauto rhgb quiet cma=3D3=
2G hugepages=3D100000 intel_pstate=3Ddisable

[    0.000000] cma: Reserved 32768 MiB at 0x000000f87fc00000

[    0.000000] Kernel command line: BOOT_IMAGE=3D/vmlinuz-4.14.17 root=3DUU=
ID=3D71fb5fd6-0242-444e-8e17-d31d65051f61 ro crashkernel=3Dauto rhgb quiet =
cma=3D32G hugepages=3D100000 intel_pstate=3Ddisable

[    0.000000] Memory: 6057140K/1073389456K available (10252K kernel code, =
2231K rwdata, 3476K rodata, 2252K init, 3040K bss, 17104596K reserved, 3355=
4432K cma-reserved)



grep -i cma /proc/meminfo

CmaTotal:       33554432 kB

CmaFree:        33501788 kB



After loading drivers I allocate memory (uses dma_alloc_coherent):

echo 20971520 > /sys/kernel/debug/ntb_tool/0000\:3b\:00.1/peer_trans1



I get this stack:



[  313.224544] switchtec 0000:3b:00.1: swiotlb buffer is full (sz: 20971520=
 bytes)

[  313.224546] swiotlb: coherent allocation failed for device 0000:3b:00.1 =
size=3D20971520

[  313.224550] Call Trace:

[  313.224560]  dump_stack+0x5c/0x83

[  313.224567]  swiotlb_alloc_coherent+0x14c/0x160

[  313.224572]  tool_peer_mw_trans_write+0x1b2/0x320 [ntb_tool]

[  313.224578]  ? perf_trace_mm_compaction_migratepages+0x5a/0x120

[  313.224584]  full_proxy_write+0x5a/0xa0

[  313.224589]  __vfs_write+0x33/0x170

[  313.224594]  ? handle_mm_fault+0xc4/0x1d0

[  313.224599]  ? __audit_syscall_entry+0xaf/0x100

[  313.224601]  vfs_write+0xad/0x1a0

[  313.224603]  SyS_write+0x52/0xc0

[  313.224608]  do_syscall_64+0x61/0x1a0

[  313.224614]  entry_SYSCALL64_slow_path+0x25/0x25

[  313.224616] RIP: 0033:0x7f79ac50e840

[  313.224617] RSP: 002b:00007ffc8e89afe8 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000001

[  313.224619] RAX: ffffffffffffffda RBX: 0000000000000009 RCX: 00007f79ac5=
0e840

[  313.224619] RDX: 0000000000000009 RSI: 00007f79ace2d000 RDI: 00000000000=
00001

[  313.224620] RBP: 00007f79ace2d000 R08: 000000000000000a R09: 00007f79ace=
27740

[  313.224621] R10: 00007ffc8e89ad90 R11: 0000000000000246 R12: 00007f79ac7=
e2400

[  313.224622] R13: 0000000000000009 R14: 0000000000000001 R15: 00000000000=
00000

Any help please?

--
Best regards, Boris


--_000_8A1F3ACA2F40C04FBF91985D6F491D7C0176649BMX302CL01corpem_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
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
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoPlainText">Hi,<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">I&#8217;m trying to enlarge buffers I use in ntb_=
tool by using cma:<o:p></o:p></p>
<p class=3D"MsoPlainText" style=3D"text-indent:.5in">$ dmesg | grep cma<o:p=
></o:p></p>
<p class=3D"MsoPlainText" style=3D"text-indent:.5in">[&nbsp;&nbsp;&nbsp; 0.=
000000] Command line: BOOT_IMAGE=3D/vmlinuz-4.14.17 root=3DUUID=3D71fb5fd6-=
0242-444e-8e17-d31d65051f61 ro crashkernel=3Dauto rhgb quiet cma=3D32G huge=
pages=3D100000 intel_pstate=3Ddisable<o:p></o:p></p>
<p class=3D"MsoPlainText" style=3D"text-indent:.5in">[&nbsp;&nbsp;&nbsp; 0.=
000000] cma: Reserved 32768 MiB at 0x000000f87fc00000<o:p></o:p></p>
<p class=3D"MsoPlainText" style=3D"text-indent:.5in">[&nbsp;&nbsp;&nbsp; 0.=
000000] Kernel command line: BOOT_IMAGE=3D/vmlinuz-4.14.17 root=3DUUID=3D71=
fb5fd6-0242-444e-8e17-d31d65051f61 ro crashkernel=3Dauto rhgb quiet cma=3D3=
2G hugepages=3D100000 intel_pstate=3Ddisable<o:p></o:p></p>
<p class=3D"MsoPlainText" style=3D"text-indent:.5in">[&nbsp;&nbsp;&nbsp; 0.=
000000] Memory: 6057140K/1073389456K available (10252K kernel code, 2231K r=
wdata, 3476K rodata, 2252K init, 3040K bss, 17104596K reserved, 33554432K c=
ma-reserved)<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">grep -i cma /proc/meminfo <o:p></o:p></p>
<p class=3D"MsoPlainText" style=3D"text-indent:.5in">CmaTotal:&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; 33554432 kB<o:p></o:p></p>
<p class=3D"MsoPlainText" style=3D"text-indent:.5in">CmaFree:&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; 33501788 kB<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">After loading drivers I allocate memory (uses dma=
_alloc_coherent):<o:p></o:p></p>
<p class=3D"MsoPlainText" style=3D"text-indent:.5in">echo 20971520 &gt; /sy=
s/kernel/debug/ntb_tool/0000\:3b\:00.1/peer_trans1<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">I get this stack:<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">[&nbsp; 313.224544] switchtec 0000:3b:00.1: swiot=
lb buffer is full (sz: 20971520 bytes)<o:p></o:p></p>
<p class=3D"MsoPlainText">[&nbsp; 313.224546] swiotlb: coherent allocation =
failed for device 0000:3b:00.1 size=3D20971520<o:p></o:p></p>
<p class=3D"MsoPlainText">[&nbsp; 313.224550] Call Trace:<o:p></o:p></p>
<p class=3D"MsoPlainText">[&nbsp; 313.224560]&nbsp; dump_stack&#43;0x5c/0x8=
3<o:p></o:p></p>
<p class=3D"MsoPlainText">[&nbsp; 313.224567]&nbsp; swiotlb_alloc_coherent&=
#43;0x14c/0x160<o:p></o:p></p>
<p class=3D"MsoPlainText">[&nbsp; 313.224572]&nbsp; tool_peer_mw_trans_writ=
e&#43;0x1b2/0x320 [ntb_tool]<o:p></o:p></p>
<p class=3D"MsoPlainText">[&nbsp; 313.224578]&nbsp; ? perf_trace_mm_compact=
ion_migratepages&#43;0x5a/0x120<o:p></o:p></p>
<p class=3D"MsoPlainText">[&nbsp; 313.224584]&nbsp; full_proxy_write&#43;0x=
5a/0xa0<o:p></o:p></p>
<p class=3D"MsoPlainText">[&nbsp; 313.224589]&nbsp; __vfs_write&#43;0x33/0x=
170<o:p></o:p></p>
<p class=3D"MsoPlainText">[&nbsp; 313.224594]&nbsp; ? handle_mm_fault&#43;0=
xc4/0x1d0<o:p></o:p></p>
<p class=3D"MsoPlainText">[&nbsp; 313.224599]&nbsp; ? __audit_syscall_entry=
&#43;0xaf/0x100<o:p></o:p></p>
<p class=3D"MsoPlainText">[&nbsp; 313.224601]&nbsp; vfs_write&#43;0xad/0x1a=
0<o:p></o:p></p>
<p class=3D"MsoPlainText">[&nbsp; 313.224603]&nbsp; SyS_write&#43;0x52/0xc0=
<o:p></o:p></p>
<p class=3D"MsoPlainText">[&nbsp; 313.224608]&nbsp; do_syscall_64&#43;0x61/=
0x1a0<o:p></o:p></p>
<p class=3D"MsoPlainText">[&nbsp; 313.224614]&nbsp; entry_SYSCALL64_slow_pa=
th&#43;0x25/0x25<o:p></o:p></p>
<p class=3D"MsoPlainText">[&nbsp; 313.224616] RIP: 0033:0x7f79ac50e840<o:p>=
</o:p></p>
<p class=3D"MsoPlainText">[&nbsp; 313.224617] RSP: 002b:00007ffc8e89afe8 EF=
LAGS: 00000246 ORIG_RAX: 0000000000000001<o:p></o:p></p>
<p class=3D"MsoPlainText">[&nbsp; 313.224619] RAX: ffffffffffffffda RBX: 00=
00000000000009 RCX: 00007f79ac50e840<o:p></o:p></p>
<p class=3D"MsoPlainText">[&nbsp; 313.224619] RDX: 0000000000000009 RSI: 00=
007f79ace2d000 RDI: 0000000000000001<o:p></o:p></p>
<p class=3D"MsoPlainText">[&nbsp; 313.224620] RBP: 00007f79ace2d000 R08: 00=
0000000000000a R09: 00007f79ace27740<o:p></o:p></p>
<p class=3D"MsoPlainText">[&nbsp; 313.224621] R10: 00007ffc8e89ad90 R11: 00=
00000000000246 R12: 00007f79ac7e2400<o:p></o:p></p>
<p class=3D"MsoPlainText">[&nbsp; 313.224622] R13: 0000000000000009 R14: 00=
00000000000001 R15: 0000000000000000<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Any help please?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">--<o:p></o:p></p>
<p class=3D"MsoNormal">Best regards, Boris<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_8A1F3ACA2F40C04FBF91985D6F491D7C0176649BMX302CL01corpem_--
