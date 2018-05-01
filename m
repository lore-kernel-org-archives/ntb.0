Return-Path: <Boris.Glimcher@dell.com>
Received: from esa4.dell-outbound.iphmx.com (esa4.dell-outbound.iphmx.com. [68.232.149.214])
        by gmr-mx.google.com with ESMTPS id z67-v6si492396itf.2.2018.05.01.05.10.14
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 05:10:14 -0700 (PDT)
From: "Glimcher, Boris" <Boris.Glimcher@dell.com>
Received: from maildlpprd56.lss.emc.com (maildlpprd56.lss.emc.com [10.106.48.160])
	by mailuogwprd52.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with ESMTP id w41C9kE6016330
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
	for <linux-ntb@googlegroups.com>; Tue, 1 May 2018 08:09:46 -0400
Received: from mailusrhubprd02.lss.emc.com (mailusrhubprd02.lss.emc.com [10.253.24.20]) by maildlpprd56.lss.emc.com (RSA Interceptor) for <linux-ntb@googlegroups.com>; Tue, 1 May 2018 08:09:30 -0400
Received: from MXHUB301.corp.emc.com (MXHUB301.corp.emc.com [10.146.3.27])
	by mailusrhubprd02.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with ESMTP id w41C9bmI010909
	(version=TLSv1.2 cipher=AES128-SHA256 bits=128 verify=FAIL)
	for <linux-ntb@googlegroups.com>; Tue, 1 May 2018 08:09:37 -0400
Subject: memcpy over NTB
Date: Tue, 1 May 2018 12:09:36 +0000
Message-ID: <8A1F3ACA2F40C04FBF91985D6F491D7C017448F2@MX302CL01.corp.emc.com>
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_8A1F3ACA2F40C04FBF91985D6F491D7C017448F2MX302CL01corpem_"
MIME-Version: 1.0
To: "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

--_000_8A1F3ACA2F40C04FBF91985D6F491D7C017448F2MX302CL01corpem_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

I've been testing NTB over Microsemi PCIe switch for a few weeks using NTB_=
PERF
and other tools from the kernel over ntb_hw_switchtec.c (from https://githu=
b.com/Microsemi/switchtec-kernel)

I'd like to move to user space now and for starters I would like to do a si=
mple MEMCPY over NTB to the peer's memory.

What the best approach for this? What kernel drivers I must use/modify?

Thanks,
--
Best regards, Boris

--_000_8A1F3ACA2F40C04FBF91985D6F491D7C017448F2MX302CL01corpem_
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
@font-face
	{font-family:"Segoe UI";
	panose-1:2 11 5 2 4 2 4 2 2 3;}
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
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
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
<p class=3D"MsoNormal">Hi,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I&#8217;ve been testing NTB over Microsemi PCIe swit=
ch for a few weeks using NTB_PERF<o:p></o:p></p>
<p class=3D"MsoNormal">and other tools from the kernel over <span style=3D"=
font-size:10.5pt;font-family:&quot;Segoe UI&quot;,sans-serif;background:whi=
te">
ntb_hw_switchtec.c</span> (from <a href=3D"https://github.com/Microsemi/swi=
tchtec-kernel">
https://github.com/Microsemi/switchtec-kernel</a>)<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I&#8217;d like to move to user space now and for sta=
rters I would like to do a simple MEMCPY over NTB to the peer&#8217;s memor=
y.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">What the best approach for this? What kernel drivers=
 I must use/modify?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">--<o:p></o:p></p>
<p class=3D"MsoNormal">Best regards, Boris<o:p></o:p></p>
</div>
</body>
</html>

--_000_8A1F3ACA2F40C04FBF91985D6F491D7C017448F2MX302CL01corpem_--
