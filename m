Return-Path: <dave.jiang@intel.com>
Received: from mga01.intel.com (mga01.intel.com. [192.55.52.88])
        by gmr-mx.google.com with ESMTPS id s140-v6si670335oie.1.2018.05.01.08.44.19
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 08:44:19 -0700 (PDT)
Subject: Re: memcpy over NTB
References: <8A1F3ACA2F40C04FBF91985D6F491D7C017448F2@MX302CL01.corp.emc.com>
From: Dave Jiang <dave.jiang@intel.com>
Message-ID: <fbb64815-593c-7de1-f1a8-1bfafc718e33@intel.com>
Date: Tue, 1 May 2018 08:44:17 -0700
MIME-Version: 1.0
In-Reply-To: <8A1F3ACA2F40C04FBF91985D6F491D7C017448F2@MX302CL01.corp.emc.com>
Content-Type: multipart/alternative;
 boundary="------------2C4D0E4C91A28CD1026441F8"
Content-Language: en-US
To: linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

This is a multi-part message in MIME format.
--------------2C4D0E4C91A28CD1026441F8
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit


On 5/1/2018 5:09 AM, Glimcher, Boris wrote:
>
> Hi,
>
> I’ve been testing NTB over Microsemi PCIe switch for a few weeks using 
> NTB_PERF
>
> and other tools from the kernel over ntb_hw_switchtec.c (from 
> https://github.com/Microsemi/switchtec-kernel 
> <https://github.com/Microsemi/switchtec-kernel>)
>
> I’d like to move to user space now and for starters I would like to do 
> a simple MEMCPY over NTB to the peer’s memory.
>
> What the best approach for this? What kernel drivers I must use/modify?
>
There are a lot of people that create VFIO user drivers in place of the 
kernel driver. That's probably an approach. Also, VFIO mediated device 
approach may also be a possibility. Have the kernel driver configure and 
carve out a virtual device for your app to consume.


> Thanks,
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
> https://groups.google.com/d/msgid/linux-ntb/8A1F3ACA2F40C04FBF91985D6F491D7C017448F2%40MX302CL01.corp.emc.com 
> <https://groups.google.com/d/msgid/linux-ntb/8A1F3ACA2F40C04FBF91985D6F491D7C017448F2%40MX302CL01.corp.emc.com?utm_medium=email&utm_source=footer>.
> For more options, visit https://groups.google.com/d/optout.

--------------2C4D0E4C91A28CD1026441F8
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 5/1/2018 5:09 AM, Glimcher, Boris
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:8A1F3ACA2F40C04FBF91985D6F491D7C017448F2@MX302CL01.corp.emc.com">
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
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <div class="WordSection1">
        <p class="MsoNormal">Hi,<o:p></o:p></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <p class="MsoNormal">I’ve been testing NTB over Microsemi PCIe
          switch for a few weeks using NTB_PERF<o:p></o:p></p>
        <p class="MsoNormal">and other tools from the kernel over <span
            style="font-size:10.5pt;font-family:&quot;Segoe
            UI&quot;,sans-serif;background:white">
            ntb_hw_switchtec.c</span> (from <a
            href="https://github.com/Microsemi/switchtec-kernel"
            moz-do-not-send="true">
            https://github.com/Microsemi/switchtec-kernel</a>)<o:p></o:p></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <p class="MsoNormal">I’d like to move to user space now and for
          starters I would like to do a simple MEMCPY over NTB to the
          peer’s memory.<o:p></o:p></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <p class="MsoNormal">What the best approach for this? What
          kernel drivers I must use/modify?<o:p></o:p></p>
      </div>
    </blockquote>
    <p>There are a lot of people that create VFIO user drivers in place
      of the kernel driver. That's probably an approach. Also, VFIO
      mediated device approach may also be a possibility. Have the
      kernel driver configure and carve out a virtual device for your
      app to consume. <br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite"
cite="mid:8A1F3ACA2F40C04FBF91985D6F491D7C017448F2@MX302CL01.corp.emc.com">
      <div class="WordSection1">
        <p class="MsoNormal"><o:p> </o:p></p>
        <p class="MsoNormal">Thanks,<o:p></o:p></p>
        <p class="MsoNormal">--<o:p></o:p></p>
        <p class="MsoNormal">Best regards, Boris<o:p></o:p></p>
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
href="https://groups.google.com/d/msgid/linux-ntb/8A1F3ACA2F40C04FBF91985D6F491D7C017448F2%40MX302CL01.corp.emc.com?utm_medium=email&amp;utm_source=footer"
        moz-do-not-send="true">https://groups.google.com/d/msgid/linux-ntb/8A1F3ACA2F40C04FBF91985D6F491D7C017448F2%40MX302CL01.corp.emc.com</a>.<br>
      For more options, visit <a
        href="https://groups.google.com/d/optout" moz-do-not-send="true">https://groups.google.com/d/optout</a>.<br>
    </blockquote>
  </body>
</html>

--------------2C4D0E4C91A28CD1026441F8--
