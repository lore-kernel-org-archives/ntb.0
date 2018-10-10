Return-Path: <Omer.Margolin@dell.com>
Received: from esa6.dell-outbound.iphmx.com (esa6.dell-outbound.iphmx.com. [68.232.149.229])
        by gmr-mx.google.com with ESMTPS id j6-v6si823922iog.1.2018.10.10.06.12.30
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 06:12:30 -0700 (PDT)
Received: from pps.filterd (m0142699.ppops.net [127.0.0.1])
	by mx0a-00154901.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9ADQJiL013005
	for <linux-ntb@googlegroups.com>; Wed, 10 Oct 2018 09:29:52 -0400
Received: from esa5.dell-outbound2.iphmx.com (esa5.dell-outbound2.iphmx.com [68.232.153.203])
	by mx0a-00154901.pphosted.com with ESMTP id 2n1dekstwt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-ntb@googlegroups.com>; Wed, 10 Oct 2018 09:29:52 -0400
From: "Margolin, Omer" <Omer.Margolin@dell.com>
Received: from maildlpprd54.lss.emc.com (maildlpprd54.lss.emc.com [10.106.48.158])
	by mailuogwprd52.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with ESMTP id w9ADCCcA001968
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
	for <linux-ntb@googlegroups.com>; Wed, 10 Oct 2018 09:12:13 -0400
Received: from mailusrhubprd51.lss.emc.com (mailusrhubprd51.lss.emc.com [10.106.48.24]) by maildlpprd54.lss.emc.com (RSA Interceptor) for <linux-ntb@googlegroups.com>; Wed, 10 Oct 2018 09:11:54 -0400
Received: from MXHUB203.corp.emc.com (MXHUB203.corp.emc.com [10.253.68.29])
	by mailusrhubprd51.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with ESMTP id w9ADBse5012427
	(version=TLSv1.2 cipher=AES128-SHA256 bits=128 verify=FAIL)
	for <linux-ntb@googlegroups.com>; Wed, 10 Oct 2018 09:11:54 -0400
Subject: Inbound translation setting failure in coherent allocation
Date: Wed, 10 Oct 2018 13:11:53 +0000
Message-ID: <8C51E45097385D46B526390C84E223A34EE561EB@MX202CL01.corp.emc.com>
Content-Language: en-US
Content-Type: multipart/related;
	boundary="_004_8C51E45097385D46B526390C84E223A34EE561EBMX202CL01corpem_";
	type="multipart/alternative"
MIME-Version: 1.0
To: "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>
Cc: "Glimcher, Boris" <Boris.Glimcher@dell.com>, "Zekri, Ishay" <Ishay.Zekri@dell.com>, "Margolin, Omer" <Omer.Margolin@dell.com>
List-ID: <linux-ntb.googlegroups.com>

--_004_8C51E45097385D46B526390C84E223A34EE561EBMX202CL01corpem_
Content-Type: multipart/alternative;
	boundary="_000_8C51E45097385D46B526390C84E223A34EE561EBMX202CL01corpem_"

--_000_8C51E45097385D46B526390C84E223A34EE561EBMX202CL01corpem_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,

Trying to evaluate the raw performance of Intel NTB using ntb_perf test too=
l we get a failure in coherent allocation.

response from Dave Jiang dave.jiang@intel.com<mailto:dave.jiang@intel.com>:
"Hello. Upstream has been making quite a bit of changes recently to
ntb_perf. If it's failing for you can you please post it to the ntb
mailing list and inquire there? Hopefully it's just something Sergei did
and he can help you fix. Thanks!"

Sergei can you please check if this is a result of latest changes?



Details:

ntb_perf module was loaded using the command below on both sides of the NTB=
 connection:
modprobe ntb_hw_intel b2b_mw_idx=3D0 b2b_mw_share=3D0 dyndbg=3D+pmfl

Failure in setting inbuf translation.
[ 553.816242] ntb_perf 0000:82:00.0: Failed to set inbuf translation

Using the MW (allocation and translation) works using ntb_tool

dmesg details:

NTB Perf
Failure for 1M coherent allocation:

[ 162.949502] Intel(R) PCI-E Non-Transparent Bridge Driver 2.0
[ 162.955791] ntb_hw_intel:gen3_init_dev:242: ntb_hw_intel 0000:82:00.0: pp=
d 0x1d topo NTB_TOPO_B2B_DSD
[ 162.955798] ntb_hw_intel:gen3_setup_b2b_mw:157: ntb_hw_intel 0000:82:00.0=
: IMBAR1XLMT 0x2000000000000000
[ 162.955802] ntb_hw_intel:gen3_setup_b2b_mw:162: ntb_hw_intel 0000:82:00.0=
: IMBAR2XLMT 0x4000000000000000
[ 162.956809] ntb_hw_intel:ndev_init_isr:410: ntb_hw_intel 0000:82:00.0: Us=
ing 33 msix interrupts
[ 162.956892] ntb_hw_intel 0000:82:00.0: NTB device registered.
[ 162.973528] ntb_perf:perf_init_peers:1427: ntb_perf 0000:82:00.0: Global =
port index 1
[ 162.973533] ntb_perf:perf_init_service:673: ntb_perf 0000:82:00.0: Messag=
e service unsupported
[ 162.973536] ntb_perf:perf_init_service:681: ntb_perf 0000:82:00.0: Scratc=
hpad service initialized
[ 162.973548] ntb_perf:perf_enable_service:723: ntb_perf 0000:82:00.0: DB b=
its unmasked 0x2
[ 162.973552] ntb_hw_intel:intel_ntb3_link_enable:429: ntb_hw_intel 0000:82=
:00.0: Enabling link with max_speed -1 max_width -1
[ 162.973556] ntb_perf:perf_cmd_exec:449: ntb_perf 0000:82:00.0: CMD exec: =
0
[ 162.973568] ntb_perf:perf_spad_cmd_send:261: ntb_perf 0000:82:00.0: CMD s=
end: 0 0x100000
[ 167.827758] ntb_hw_intel:ndev_vec_isr:352: ntb_hw_intel 0000:82:00.0: irq=
: 243 nvec->num: 1
[ 167.827764] ntb_hw_intel:ndev_interrupt:332: ntb_hw_intel 0000:82:00.0: v=
ec 1 vec_mask 2
[ 167.827772] ntb_perf:perf_db_event:509: ntb_perf 0000:82:00.0: DB vec 1 m=
ask 0x2 bits 0x2
[ 167.827778] ntb_perf:perf_spad_cmd_recv:339: ntb_perf 0000:82:00.0: CMD r=
ecv: 0 0x400000000
[ 167.827781] ntb_perf:perf_cmd_exec:449: ntb_perf 0000:82:00.0: CMD exec: =
1
[ 171.807351] ntb_perf 0000:82:00.0: Failed to set inbuf translation
[ 171.813539] ntb_hw_intel:intel_ntb3_mw_set_trans:498: ntb_hw_intel 0000:8=
2:00.0: BAR 2 IMBARXBASE: 0x0
[ 171.813542] ntb_hw_intel:intel_ntb3_mw_set_trans:509: ntb_hw_intel 0000:8=
2:00.0: BAR 2 IMBARXLMT: 0xd9000000000
[ 171.813546] ntb_hw_intel:intel_ntb3_mw_set_trans:530: ntb_hw_intel 0000:8=
2:00.0: BAR 2 EMBARXLMT: 0x800000000000
[ 262.244384] ntb_hw_intel:intel_ntb_link_disable:1005: ntb_hw_intel 0000:8=
2:00.0: Disabling link
[ 262.244391] ntb_perf:perf_cmd_exec:449: ntb_perf 0000:82:00.0: CMD exec: =
4
[ 262.244439] ntb_hw_intel:ndev_vec_isr:352: ntb_hw_intel 0000:82:00.0: irq=
: 273 nvec->num: 31
[ 262.244445] ntb_hw_intel:ndev_interrupt:332: ntb_hw_intel 0000:82:00.0: v=
ec 31 vec_mask ffffffff80000000

NTB tool:
Successful allocation and data transfer using ntb_tool on 16G MW (idx 1)

[root@xbrick4000-n1 ~]# echo 1073741824 > /sys/kernel/debug/ntb_tool/0000:8=
2:00.0/peer0/mw_trans1
[root@xbrick4000-n1 ~]#
[root@xbrick4000-n1 ~]#
[root@xbrick4000-n1 ~]# grep Cma /proc/meminfo
CmaTotal: 33554432 kB
CmaFree: 16765120 kB

[ 973.330070] ntb_hw_intel:ndev_vec_isr:352: ntb_hw_intel 0000:82:00.0: irq=
: 255 nvec->num: 31
[ 973.330076] ntb_hw_intel:ndev_interrupt:332: ntb_hw_intel 0000:82:00.0: v=
ec 31 vec_mask ffffffff80000000
[ 973.330086] ntb_tool:tool_link_event:299: ntb_tool 0000:82:00.0: link is =
up speed 3 width 8
[ 973.330092] ntb_tool:tool_db_event:313: ntb_tool 0000:82:00.0: doorbell v=
ec 31 mask 0x80000000 bits 0x0
[ 995.713469] ntb_hw_intel:intel_ntb3_mw_set_trans:498: ntb_hw_intel 0000:8=
2:00.0: BAR 2 IMBARXBASE: 0x5840700000
[ 995.713475] ntb_hw_intel:intel_ntb3_mw_set_trans:509: ntb_hw_intel 0000:8=
2:00.0: BAR 2 IMBARXLMT: 0xd9000100000
[ 995.713481] ntb_hw_intel:intel_ntb3_mw_set_trans:530: ntb_hw_intel 0000:8=
2:00.0: BAR 2 EMBARXLMT: 0x800000100000
[ 1148.789358] ntb_hw_intel:intel_ntb3_mw_set_trans:498: ntb_hw_intel 0000:=
82:00.0: BAR 4 IMBARXBASE: 0x5c00000000
[ 1148.789363] ntb_hw_intel:intel_ntb3_mw_set_trans:509: ntb_hw_intel 0000:=
82:00.0: BAR 4 IMBARXLMT: 0xd0400000000
[ 1148.789367] ntb_hw_intel:intel_ntb3_mw_set_trans:530: ntb_hw_intel 0000:=
82:00.0: BAR 4 EMBARXLMT: 0x1000400000000

[root@xbrick4000-n2 ~]# echo 0xADD0BA5E:1073741824 > /sys/kernel/debug/ntb_=
tool/0000:82:00.0/peer0/peer_mw_trans1
[root@xbrick4000-n2 ~]# echo "Hello from the other side" > /sys/kernel/debu=
g/ntb_tool/0000:82:00.0/peer0/peer_mw1

[root@xbrick4000-n1 ~]# head -c70 /sys/kernel/debug/ntb_tool/0000:82:00.0/p=
eer0/mw1
Hello from the other side
Thanks,

Omer Margolin | Hardware Engineer | XtremIO/EMC=B2
Mobile: +972 54 4660539 | Office: +972 72 2563334
Address: Kibbutz Glil-Yam, Herzelia 4690500, Israel
Email: omer.margolin@emc.com<mailto:omer.margolin@emc.com>
[XtremIO_EMC]


--_000_8C51E45097385D46B526390C84E223A34EE561EBMX202CL01corpem_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"Segoe UI";
	panose-1:2 11 5 2 4 2 4 2 2 3;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
h1
	{mso-style-priority:9;
	mso-style-link:"Heading 1 Char";
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:24.0pt;
	font-family:"Times New Roman",serif;
	font-weight:bold;}
h2
	{mso-style-priority:9;
	mso-style-link:"Heading 2 Char";
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:18.0pt;
	font-family:"Times New Roman",serif;
	font-weight:bold;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p
	{mso-style-priority:99;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:12.0pt;
	font-family:"Times New Roman",serif;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.Heading1Char
	{mso-style-name:"Heading 1 Char";
	mso-style-priority:9;
	mso-style-link:"Heading 1";
	font-family:"Times New Roman",serif;
	font-weight:bold;}
span.Heading2Char
	{mso-style-name:"Heading 2 Char";
	mso-style-priority:9;
	mso-style-link:"Heading 2";
	font-family:"Times New Roman",serif;
	font-weight:bold;}
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
<p style=3D"margin-bottom:12.0pt;background:white"><span style=3D"font-size=
:10.5pt;font-family:&quot;Segoe UI&quot;,sans-serif;color:#24292E">Hello,<o=
:p></o:p></span></p>
<p style=3D"margin-bottom:12.0pt;background:white"><span style=3D"font-size=
:10.5pt;font-family:&quot;Segoe UI&quot;,sans-serif;color:#24292E">Trying t=
o evaluate the raw performance of Intel NTB using ntb_perf test tool we get=
 a failure in coherent allocation.<o:p></o:p></span></p>
<p style=3D"mso-margin-top-alt:0in;margin-right:0in;margin-bottom:12.0pt;ma=
rgin-left:0in;background:white">
<span style=3D"font-size:10.5pt;font-family:&quot;Segoe UI&quot;,sans-serif=
;color:#24292E">response from Dave Jiang&nbsp;<a href=3D"mailto:dave.jiang@=
intel.com"><span style=3D"color:#0366D6">dave.jiang@intel.com</span></a>:<b=
r>
&quot;Hello. Upstream has been making quite a bit of changes recently to<br=
>
ntb_perf. If it's failing for you can you please post it to the ntb<br>
mailing list and inquire there? Hopefully it's just something Sergei did<br=
>
and he can help you fix. Thanks!&quot;<o:p></o:p></span></p>
<p style=3D"margin-top:0in;background:white;box-sizing: border-box;font-var=
iant-ligatures: normal;font-variant-caps: normal;orphans: 2;text-align:star=
t;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-style: initial;t=
ext-decoration-color: initial;word-spacing:0px">
<span style=3D"font-size:10.5pt;font-family:&quot;Segoe UI&quot;,sans-serif=
;color:#24292E">Sergei can you please check if this is a result of latest c=
hanges?<o:p></o:p></span></p>
<p style=3D"margin-bottom:12.0pt;background:white"><span style=3D"font-size=
:10.5pt;font-family:&quot;Segoe UI&quot;,sans-serif;color:#24292E"><o:p>&nb=
sp;</o:p></span></p>
<p style=3D"margin-bottom:12.0pt;background:white"><span style=3D"font-size=
:10.5pt;font-family:&quot;Segoe UI&quot;,sans-serif;color:#24292E">Details:=
<o:p></o:p></span></p>
<p style=3D"mso-margin-top-alt:0in;margin-right:0in;margin-bottom:12.0pt;ma=
rgin-left:0in;background:white;box-sizing: border-box;font-variant-ligature=
s: normal;font-variant-caps: normal;orphans: 2;text-align:start;widows: 2;-=
webkit-text-stroke-width: 0px;text-decoration-style: initial;text-decoratio=
n-color: initial;word-spacing:0px">
<span style=3D"font-size:10.5pt;font-family:&quot;Segoe UI&quot;,sans-serif=
;color:#24292E">ntb_perf module was loaded using the command below on both =
sides of the NTB connection:<br>
modprobe ntb_hw_intel b2b_mw_idx=3D0 b2b_mw_share=3D0 dyndbg=3D&#43;pmfl<o:=
p></o:p></span></p>
<p style=3D"mso-margin-top-alt:0in;margin-right:0in;margin-bottom:12.0pt;ma=
rgin-left:0in;background:white;box-sizing: border-box;font-variant-ligature=
s: normal;font-variant-caps: normal;orphans: 2;text-align:start;widows: 2;-=
webkit-text-stroke-width: 0px;text-decoration-style: initial;text-decoratio=
n-color: initial;word-spacing:0px">
<span style=3D"font-size:10.5pt;font-family:&quot;Segoe UI&quot;,sans-serif=
;color:#24292E">Failure in setting inbuf translation.<br>
[ 553.816242] ntb_perf 0000:82:00.0: Failed to set inbuf translation<o:p></=
o:p></span></p>
<p style=3D"mso-margin-top-alt:0in;margin-right:0in;margin-bottom:12.0pt;ma=
rgin-left:0in;background:white;box-sizing: border-box;font-variant-ligature=
s: normal;font-variant-caps: normal;orphans: 2;text-align:start;widows: 2;-=
webkit-text-stroke-width: 0px;text-decoration-style: initial;text-decoratio=
n-color: initial;word-spacing:0px">
<span style=3D"font-size:10.5pt;font-family:&quot;Segoe UI&quot;,sans-serif=
;color:#24292E">Using the MW (allocation and translation) works using ntb_t=
ool<o:p></o:p></span></p>
<p style=3D"mso-margin-top-alt:0in;margin-right:0in;margin-bottom:12.0pt;ma=
rgin-left:0in;background:white;box-sizing: border-box;font-variant-ligature=
s: normal;font-variant-caps: normal;orphans: 2;text-align:start;widows: 2;-=
webkit-text-stroke-width: 0px;text-decoration-style: initial;text-decoratio=
n-color: initial;word-spacing:0px">
<span style=3D"font-size:10.5pt;font-family:&quot;Segoe UI&quot;,sans-serif=
;color:#24292E">dmesg details:<o:p></o:p></span></p>
<div style=3D"mso-element:para-border-div;border:none;border-bottom:solid #=
EAECEF 1.0pt;padding:0in 0in 4.0pt 0in;background:white">
<h1 style=3D"mso-margin-top-alt:.25in;margin-right:0in;margin-bottom:12.0pt=
;margin-left:0in;background:white;border:none;padding:0in;box-sizing: borde=
r-box;font-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;t=
ext-align:start;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-st=
yle: initial;text-decoration-color: initial;word-spacing:0px">
<span style=3D"font-family:&quot;Segoe UI&quot;,sans-serif;color:#24292E">N=
TB Perf<o:p></o:p></span></h1>
<h2 style=3D"mso-margin-top-alt:.25in;margin-right:0in;margin-bottom:12.0pt=
;margin-left:0in;background:white;border:none;padding:0in;box-sizing: borde=
r-box;font-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;t=
ext-align:start;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-st=
yle: initial;text-decoration-color: initial;word-spacing:0px">
<span style=3D"font-family:&quot;Segoe UI&quot;,sans-serif;color:#24292E">F=
ailure for 1M coherent allocation:<o:p></o:p></span></h2>
</div>
<p style=3D"mso-margin-top-alt:0in;margin-right:0in;margin-bottom:12.0pt;ma=
rgin-left:0in;background:white;box-sizing: border-box;font-variant-ligature=
s: normal;font-variant-caps: normal;orphans: 2;text-align:start;widows: 2;-=
webkit-text-stroke-width: 0px;text-decoration-style: initial;text-decoratio=
n-color: initial;word-spacing:0px">
<span style=3D"font-size:10.5pt;font-family:&quot;Segoe UI&quot;,sans-serif=
;color:#24292E">[ 162.949502] Intel(R) PCI-E Non-Transparent Bridge Driver =
2.0<br>
[ 162.955791] ntb_hw_intel:gen3_init_dev:242: ntb_hw_intel 0000:82:00.0: pp=
d 0x1d topo NTB_TOPO_B2B_DSD<br>
[ 162.955798] ntb_hw_intel:gen3_setup_b2b_mw:157: ntb_hw_intel 0000:82:00.0=
: IMBAR1XLMT 0x2000000000000000<br>
[ 162.955802] ntb_hw_intel:gen3_setup_b2b_mw:162: ntb_hw_intel 0000:82:00.0=
: IMBAR2XLMT 0x4000000000000000<br>
[ 162.956809] ntb_hw_intel:ndev_init_isr:410: ntb_hw_intel 0000:82:00.0: Us=
ing 33 msix interrupts<br>
[ 162.956892] ntb_hw_intel 0000:82:00.0: NTB device registered.<br>
[ 162.973528] ntb_perf:perf_init_peers:1427: ntb_perf 0000:82:00.0: Global =
port index 1<br>
[ 162.973533] ntb_perf:perf_init_service:673: ntb_perf 0000:82:00.0: Messag=
e service unsupported<br>
[ 162.973536] ntb_perf:perf_init_service:681: ntb_perf 0000:82:00.0: Scratc=
hpad service initialized<br>
[ 162.973548] ntb_perf:perf_enable_service:723: ntb_perf 0000:82:00.0: DB b=
its unmasked 0x2<br>
[ 162.973552] ntb_hw_intel:intel_ntb3_link_enable:429: ntb_hw_intel 0000:82=
:00.0: Enabling link with max_speed -1 max_width -1<br>
[ 162.973556] ntb_perf:perf_cmd_exec:449: ntb_perf 0000:82:00.0: CMD exec: =
0<br>
[ 162.973568] ntb_perf:perf_spad_cmd_send:261: ntb_perf 0000:82:00.0: CMD s=
end: 0 0x100000<br>
[ 167.827758] ntb_hw_intel:ndev_vec_isr:352: ntb_hw_intel 0000:82:00.0: irq=
: 243 nvec-&gt;num: 1<br>
[ 167.827764] ntb_hw_intel:ndev_interrupt:332: ntb_hw_intel 0000:82:00.0: v=
ec 1 vec_mask 2<br>
[ 167.827772] ntb_perf:perf_db_event:509: ntb_perf 0000:82:00.0: DB vec 1 m=
ask 0x2 bits 0x2<br>
[ 167.827778] ntb_perf:perf_spad_cmd_recv:339: ntb_perf 0000:82:00.0: CMD r=
ecv: 0 0x400000000<br>
[ 167.827781] ntb_perf:perf_cmd_exec:449: ntb_perf 0000:82:00.0: CMD exec: =
1<br>
[ 171.807351] ntb_perf 0000:82:00.0: Failed to set inbuf translation<br>
[ 171.813539] ntb_hw_intel:intel_ntb3_mw_set_trans:498: ntb_hw_intel 0000:8=
2:00.0: BAR 2 IMBARXBASE: 0x0<br>
[ 171.813542] ntb_hw_intel:intel_ntb3_mw_set_trans:509: ntb_hw_intel 0000:8=
2:00.0: BAR 2 IMBARXLMT: 0xd9000000000<br>
[ 171.813546] ntb_hw_intel:intel_ntb3_mw_set_trans:530: ntb_hw_intel 0000:8=
2:00.0: BAR 2 EMBARXLMT: 0x800000000000<br>
[ 262.244384] ntb_hw_intel:intel_ntb_link_disable:1005: ntb_hw_intel 0000:8=
2:00.0: Disabling link<br>
[ 262.244391] ntb_perf:perf_cmd_exec:449: ntb_perf 0000:82:00.0: CMD exec: =
4<br>
[ 262.244439] ntb_hw_intel:ndev_vec_isr:352: ntb_hw_intel 0000:82:00.0: irq=
: 273 nvec-&gt;num: 31<br>
[ 262.244445] ntb_hw_intel:ndev_interrupt:332: ntb_hw_intel 0000:82:00.0: v=
ec 31 vec_mask ffffffff80000000<o:p></o:p></span></p>
<div style=3D"mso-element:para-border-div;border:none;border-bottom:solid #=
EAECEF 1.0pt;padding:0in 0in 4.0pt 0in;background:white">
<h1 style=3D"mso-margin-top-alt:.25in;margin-right:0in;margin-bottom:12.0pt=
;margin-left:0in;background:white;border:none;padding:0in;box-sizing: borde=
r-box;font-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;t=
ext-align:start;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-st=
yle: initial;text-decoration-color: initial;word-spacing:0px">
<span style=3D"font-family:&quot;Segoe UI&quot;,sans-serif;color:#24292E">N=
TB tool:<o:p></o:p></span></h1>
<h2 style=3D"mso-margin-top-alt:.25in;margin-right:0in;margin-bottom:12.0pt=
;margin-left:0in;background:white;border:none;padding:0in;box-sizing: borde=
r-box;font-variant-ligatures: normal;font-variant-caps: normal;orphans: 2;t=
ext-align:start;widows: 2;-webkit-text-stroke-width: 0px;text-decoration-st=
yle: initial;text-decoration-color: initial;word-spacing:0px">
<span style=3D"font-family:&quot;Segoe UI&quot;,sans-serif;color:#24292E">S=
uccessful allocation and data transfer using ntb_tool on 16G MW (idx 1)<o:p=
></o:p></span></h2>
</div>
<p style=3D"mso-margin-top-alt:0in;margin-right:0in;margin-bottom:12.0pt;ma=
rgin-left:0in;background:white;box-sizing: border-box;font-variant-ligature=
s: normal;font-variant-caps: normal;orphans: 2;text-align:start;widows: 2;-=
webkit-text-stroke-width: 0px;text-decoration-style: initial;text-decoratio=
n-color: initial;word-spacing:0px">
<span style=3D"font-size:10.5pt;font-family:&quot;Segoe UI&quot;,sans-serif=
;color:#24292E">[root@xbrick4000-n1 ~]# echo 1073741824 &gt; /sys/kernel/de=
bug/ntb_tool/0000:82:00.0/peer0/mw_trans1<br>
[root@xbrick4000-n1 ~]#<br>
[root@xbrick4000-n1 ~]#<br>
[root@xbrick4000-n1 ~]# grep Cma /proc/meminfo<br>
CmaTotal: 33554432 kB<br>
CmaFree: 16765120 kB<o:p></o:p></span></p>
<p style=3D"mso-margin-top-alt:0in;margin-right:0in;margin-bottom:12.0pt;ma=
rgin-left:0in;background:white;box-sizing: border-box;font-variant-ligature=
s: normal;font-variant-caps: normal;orphans: 2;text-align:start;widows: 2;-=
webkit-text-stroke-width: 0px;text-decoration-style: initial;text-decoratio=
n-color: initial;word-spacing:0px">
<span style=3D"font-size:10.5pt;font-family:&quot;Segoe UI&quot;,sans-serif=
;color:#24292E">[ 973.330070] ntb_hw_intel:ndev_vec_isr:352: ntb_hw_intel 0=
000:82:00.0: irq: 255 nvec-&gt;num: 31<br>
[ 973.330076] ntb_hw_intel:ndev_interrupt:332: ntb_hw_intel 0000:82:00.0: v=
ec 31 vec_mask ffffffff80000000<br>
[ 973.330086] ntb_tool:tool_link_event:299: ntb_tool 0000:82:00.0: link is =
up speed 3 width 8<br>
[ 973.330092] ntb_tool:tool_db_event:313: ntb_tool 0000:82:00.0: doorbell v=
ec 31 mask 0x80000000 bits 0x0<br>
[ 995.713469] ntb_hw_intel:intel_ntb3_mw_set_trans:498: ntb_hw_intel 0000:8=
2:00.0: BAR 2 IMBARXBASE: 0x5840700000<br>
[ 995.713475] ntb_hw_intel:intel_ntb3_mw_set_trans:509: ntb_hw_intel 0000:8=
2:00.0: BAR 2 IMBARXLMT: 0xd9000100000<br>
[ 995.713481] ntb_hw_intel:intel_ntb3_mw_set_trans:530: ntb_hw_intel 0000:8=
2:00.0: BAR 2 EMBARXLMT: 0x800000100000<br>
[ 1148.789358] ntb_hw_intel:intel_ntb3_mw_set_trans:498: ntb_hw_intel 0000:=
82:00.0: BAR 4 IMBARXBASE: 0x5c00000000<br>
[ 1148.789363] ntb_hw_intel:intel_ntb3_mw_set_trans:509: ntb_hw_intel 0000:=
82:00.0: BAR 4 IMBARXLMT: 0xd0400000000<br>
[ 1148.789367] ntb_hw_intel:intel_ntb3_mw_set_trans:530: ntb_hw_intel 0000:=
82:00.0: BAR 4 EMBARXLMT: 0x1000400000000<o:p></o:p></span></p>
<p style=3D"mso-margin-top-alt:0in;margin-right:0in;margin-bottom:12.0pt;ma=
rgin-left:0in;background:white;box-sizing: border-box;font-variant-ligature=
s: normal;font-variant-caps: normal;orphans: 2;text-align:start;widows: 2;-=
webkit-text-stroke-width: 0px;text-decoration-style: initial;text-decoratio=
n-color: initial;word-spacing:0px">
<span style=3D"font-size:10.5pt;font-family:&quot;Segoe UI&quot;,sans-serif=
;color:#24292E">[root@xbrick4000-n2 ~]# echo 0xADD0BA5E:1073741824 &gt; /sy=
s/kernel/debug/ntb_tool/0000:82:00.0/peer0/peer_mw_trans1<br>
[root@xbrick4000-n2 ~]# echo &quot;Hello from the other side&quot; &gt; /sy=
s/kernel/debug/ntb_tool/0000:82:00.0/peer0/peer_mw1<o:p></o:p></span></p>
<p style=3D"mso-margin-top-alt:0in;margin-right:0in;margin-bottom:12.0pt;ma=
rgin-left:0in;background:white;box-sizing: border-box;font-variant-ligature=
s: normal;font-variant-caps: normal;orphans: 2;text-align:start;widows: 2;-=
webkit-text-stroke-width: 0px;text-decoration-style: initial;text-decoratio=
n-color: initial;word-spacing:0px">
<span style=3D"font-size:10.5pt;font-family:&quot;Segoe UI&quot;,sans-serif=
;color:#24292E">[root@xbrick4000-n1 ~]# head -c70 /sys/kernel/debug/ntb_too=
l/0000:82:00.0/peer0/mw1<br>
Hello from the other side<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"box-sizing: border-box;font-variant-ligatur=
es: normal;font-variant-caps: normal;orphans: 2;text-align:start;widows: 2;=
-webkit-text-stroke-width: 0px;text-decoration-style: initial;text-decorati=
on-color: initial;word-spacing:0px">
Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif;color:#215868">Omer Margolin | Hardware Engineer | =
XtremIO/EMC=B2<o:p></o:p></span></b></p>
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif;color:#215868">Mobile: &#43;972 54 4660539 | Office=
: &#43;972 72 2563334<o:p></o:p></span></b></p>
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif;color:#215868">Address: Kibbutz Glil-Yam, Herzelia =
4690500, Israel<o:p></o:p></span></b></p>
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif;color:#215868">Email:
<a href=3D"mailto:omer.margolin@emc.com"><span style=3D"color:blue">omer.ma=
rgolin@emc.com</span></a><o:p></o:p></span></b></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.5pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black"><img border=3D"0" width=3D"299" height=3D=
"48" id=3D"Picture_x0020_1" src=3D"cid:image001.jpg@01D460B3.F41B4F70" alt=
=3D"XtremIO_EMC"></span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_8C51E45097385D46B526390C84E223A34EE561EBMX202CL01corpem_--

--_004_8C51E45097385D46B526390C84E223A34EE561EBMX202CL01corpem_
Content-Type: image/jpeg; name="image001.jpg"
Content-Description: image001.jpg
Content-Disposition: inline; filename="image001.jpg"; size=3275;
	creation-date="Wed, 10 Oct 2018 13:11:52 GMT";
	modification-date="Wed, 10 Oct 2018 13:11:52 GMT"
Content-ID: <image001.jpg@01D460B3.F41B4F70>
Content-Transfer-Encoding: base64

/9j/4AAQSkZJRgABAQEAYABgAAD/2wBDAAoHBwkHBgoJCAkLCwoMDxkQDw4ODx4WFxIZJCAmJSMg
IyIoLTkwKCo2KyIjMkQyNjs9QEBAJjBGS0U+Sjk/QD3/2wBDAQsLCw8NDx0QEB09KSMpPT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT3/wAARCAAwASsDASIA
AhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQA
AAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3
ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWm
p6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEA
AwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSEx
BhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElK
U1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3
uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwD2aiuQ
8XW93p1sb6zvZVXdhoyeB9KwNGutY1m++yw37I20tljXRGhzR509DmliOWXI1qenUVx//CPeIP8A
oKD8zT9BGqWfiKSz1GdpV8vcp7GpdJWbUrlqq7pOLR1tFUtR00X6cTSwuBwyNjH4V5reatqdnfT2
4vpG8pym7PXFFKj7TZiq1vZbo9Xorn/CGstqul7Z23XEJ2sT1PvXQVnOLhJxZrCanFSQUVyXjPxD
Lp5itbKTbM3zMw7D0rD0TVNW1jVI7M37RhgSWx6VtHDycOe+hjLExjPktdnpNFV7O1+yQBGleVu7
t1Ncz4h8aLYyva6eoklXhnPRT/WsoU3N2iaTqKEbyOuori9O0bV9bhW61HUZoFflUj4JFRaz4evd
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
Ejj/AGhmpaKAGpGkShY1VVHYDFOoooA//9k=

--_004_8C51E45097385D46B526390C84E223A34EE561EBMX202CL01corpem_--
