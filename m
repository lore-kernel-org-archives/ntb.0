Return-Path: <Allen.Hubbe@dell.com>
Received: from esa1.dell-outbound.iphmx.com (esa1.dell-outbound.iphmx.com. [68.232.153.90])
        by gmr-mx.google.com with ESMTPS id x138si3637738ywx.6.2016.12.27.12.46.34
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Dec 2016 12:46:34 -0800 (PST)
Received: from maildlpprd06.lss.emc.com (maildlpprd06.lss.emc.com [10.253.24.38])
	by mailuogwprd05.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with ESMTP id uBRKkURC001868
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
	for <linux-ntb@googlegroups.com>; Tue, 27 Dec 2016 15:46:32 -0500
Received: from mailsyshubprd08.lss.emc.com (mailhub.lss.emc.com [10.253.24.64]) by maildlpprd06.lss.emc.com (RSA Interceptor) for <linux-ntb@googlegroups.com>; Tue, 27 Dec 2016 15:46:10 -0500
Received: from USENHUBBEAL2C (USENHUBBEAL2C.corp.emc.com [10.97.40.74])
	by mailsyshubprd08.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with ESMTP id uBRKkLU4009364
	for <linux-ntb@googlegroups.com>; Tue, 27 Dec 2016 15:46:22 -0500
From: "Allen Hubbe" <Allen.Hubbe@dell.com>
Subject: crash unloading ntb_transport
Date: Tue, 27 Dec 2016 15:46:21 -0500
Message-ID: <03f201d26082$484b8710$d8e29530$@dell.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_03F3_01D26058.5F7C83F0"
Content-Language: en-us
To: linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

This is a multipart message in MIME format.

------=_NextPart_000_03F3_01D26058.5F7C83F0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit

Test attempted using jonmason/ntb at dfb7d24c5ad5c986f2417f52784738b67cfedd4d.
 
With latest, it crashes when removing the modules.
 
[ 1494.330594] ntb_hw_intel 0000:80:03.0: qp 0: Send Link Down
[ 1494.358126] ntb_hw_intel 0000:80:03.0: NTB Transport QP 0 freed
[ 1494.364771] ntb_hw_intel 0000:00:03.0: qp 0: Send Link Down
[ 1494.400171] ntb_hw_intel 0000:00:03.0: NTB Transport QP 0 freed
[ 1494.431502] BUG: unable to handle kernel NULL pointer dereference at 00000000000000a8
[ 1494.440267] IP: [<ffffffff816c3def>] down_write+0x1f/0x40
[ 1494.446312] PGD ff3231067 [ 1494.449136] PUD ff5600067
PMD 0 [ 1494.452760]
[ 1494.454430] Oops: 0002 [#1] SMP
 
Entering kdb (current=0xffff880ff4ea2c00, pid 1297) on processor 1 Oops: (null)
due to oops @ 0xffffffff816c3def
CPU: 1 PID: 1297 Comm: rmmod Not tainted 4.9.0-ntb #25
Hardware name: EMC 900-565-027/110-325-102B-00, BIOS 23.27 12/10/2014
task: ffff880ff4ea2c00 task.stack: ffffc9000d784000
RIP: 0010:[<ffffffff816c3def>]  [<ffffffff816c3def>] down_write+0x1f/0x40
RSP: 0018:ffffc9000d787d98  EFLAGS: 00010246
RAX: 00000000000000a8 RBX: 00000000000000a8 RCX: 0000000000000001
RDX: ffffffff00000001 RSI: ffff881ff5d49258 RDI: 00000000000000a8
RBP: ffffc9000d787da0 R08: ffffffffa01b2500 R09: 000000018022000f
R10: 00000000f7f6f701 R11: ffff880ff7f6f4b0 R12: ffff880ff3e53d98
R13: ffff880ff3e53de0 R14: ffff880ff3e53d40 R15: ffff880ff3e53d40
FS:  00007f65381b3740(0000) GS:ffff880fffc40000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000000000a8 CR3: 0000000ff69e9000 CR4: 00000000001406e0
Stack:
ffff881ff5d49200 ffffc9000d787de0 ffffffff812ad0ed ffffffffa01390e0
ffff881ff5d49200 ffff881ff467cc00 0000000000000001 0000000000000000
ffff881ff4569800 ffffc9000d787e18 ffffffffa0135171 ffff881ff4569800
Call Trace:
[<ffffffff812ad0ed>] debugfs_remove_recursive+0x4d/0x190
[<ffffffffa0135171>] ntb_transport_free+0x61/0x160 [ntb_transport]
[<ffffffffa0031115>] ntb_remove+0x25/0x40 [ntb]
[<ffffffff8147e81a>] __device_release_driver+0x9a/0x140
[<ffffffff8147e9c8>] driver_detach+0xb8/0xc0
[<ffffffff8147d7f5>] bus_remove_driver+0x55/0xd0
[<ffffffff8147f18c>] driver_unregister+0x2c/0x50
[<ffffffffa003117e>] ntb_unregister_client+0xe/0x10 [ntb]
[<ffffffffa01379ae>] ntb_transport_exit+0x1c/0x66e [ntb_transport]
[<ffffffff8110d3ba>] SyS_delete_module+0x1ba/0x220
[<ffffffff81003a47>] do_syscall_64+0x67/0x180
[<ffffffff816c64ab>] entry_SYSCALL64_slow_path+0x25/0x25
Code: 66 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 55 48 89 e5 53 48 89 fb e8 3e e1 ff ff 48 ba 01 00 00 00 ff ff ff ff 48 89 d8 <f0> 48 0f c1 10 85 d2 74 05 e8 53 2d c9 ff 65 48 8b 04 25 c0 d2

------=_NextPart_000_03F3_01D26058.5F7C83F0
Content-Type: text/html;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head><meta =
http-equiv=3DContent-Type content=3D"text/html; charset=3Dutf-8"><meta =
name=3DProgId content=3DWord.Document><meta name=3DGenerator =
content=3D"Microsoft Word 14"><meta name=3DOriginator =
content=3D"Microsoft Word 14"><link rel=3DFile-List =
href=3D"cid:filelist.xml@01D26058.5EAE5E80"><!--[if gte mso 9]><xml>
<o:OfficeDocumentSettings>
<o:AllowPNG/>
</o:OfficeDocumentSettings>
</xml><![endif]--><!--[if gte mso 9]><xml>
<w:WordDocument>
<w:SpellingState>Clean</w:SpellingState>
<w:GrammarState>Clean</w:GrammarState>
<w:TrackMoves/>
<w:TrackFormatting/>
<w:EnvelopeVis/>
<w:PunctuationKerning/>
<w:ValidateAgainstSchemas/>
<w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>
<w:IgnoreMixedContent>false</w:IgnoreMixedContent>
<w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>
<w:DoNotPromoteQF/>
<w:LidThemeOther>EN-US</w:LidThemeOther>
<w:LidThemeAsian>X-NONE</w:LidThemeAsian>
<w:LidThemeComplexScript>X-NONE</w:LidThemeComplexScript>
<w:Compatibility>
<w:BreakWrappedTables/>
<w:SnapToGridInCell/>
<w:WrapTextWithPunct/>
<w:UseAsianBreakRules/>
<w:DontGrowAutofit/>
<w:SplitPgBreakAndParaMark/>
<w:EnableOpenTypeKerning/>
<w:DontFlipMirrorIndents/>
<w:OverrideTableStyleHps/>
</w:Compatibility>
<m:mathPr>
<m:mathFont m:val=3D"Cambria Math"/>
<m:brkBin m:val=3D"before"/>
<m:brkBinSub m:val=3D"&#45;-"/>
<m:smallFrac m:val=3D"off"/>
<m:dispDef/>
<m:lMargin m:val=3D"0"/>
<m:rMargin m:val=3D"0"/>
<m:defJc m:val=3D"centerGroup"/>
<m:wrapIndent m:val=3D"1440"/>
<m:intLim m:val=3D"subSup"/>
<m:naryLim m:val=3D"undOvr"/>
</m:mathPr></w:WordDocument>
</xml><![endif]--><!--[if gte mso 9]><xml>
<w:LatentStyles DefLockedState=3D"false" DefUnhideWhenUsed=3D"true" =
DefSemiHidden=3D"true" DefQFormat=3D"false" DefPriority=3D"99" =
LatentStyleCount=3D"267">
<w:LsdException Locked=3D"false" Priority=3D"0" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" QFormat=3D"true" Name=3D"Normal"/>
<w:LsdException Locked=3D"false" Priority=3D"9" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" QFormat=3D"true" Name=3D"heading 1"/>
<w:LsdException Locked=3D"false" Priority=3D"9" QFormat=3D"true" =
Name=3D"heading 2"/>
<w:LsdException Locked=3D"false" Priority=3D"9" QFormat=3D"true" =
Name=3D"heading 3"/>
<w:LsdException Locked=3D"false" Priority=3D"9" QFormat=3D"true" =
Name=3D"heading 4"/>
<w:LsdException Locked=3D"false" Priority=3D"9" QFormat=3D"true" =
Name=3D"heading 5"/>
<w:LsdException Locked=3D"false" Priority=3D"9" QFormat=3D"true" =
Name=3D"heading 6"/>
<w:LsdException Locked=3D"false" Priority=3D"9" QFormat=3D"true" =
Name=3D"heading 7"/>
<w:LsdException Locked=3D"false" Priority=3D"9" QFormat=3D"true" =
Name=3D"heading 8"/>
<w:LsdException Locked=3D"false" Priority=3D"9" QFormat=3D"true" =
Name=3D"heading 9"/>
<w:LsdException Locked=3D"false" Priority=3D"39" Name=3D"toc 1"/>
<w:LsdException Locked=3D"false" Priority=3D"39" Name=3D"toc 2"/>
<w:LsdException Locked=3D"false" Priority=3D"39" Name=3D"toc 3"/>
<w:LsdException Locked=3D"false" Priority=3D"39" Name=3D"toc 4"/>
<w:LsdException Locked=3D"false" Priority=3D"39" Name=3D"toc 5"/>
<w:LsdException Locked=3D"false" Priority=3D"39" Name=3D"toc 6"/>
<w:LsdException Locked=3D"false" Priority=3D"39" Name=3D"toc 7"/>
<w:LsdException Locked=3D"false" Priority=3D"39" Name=3D"toc 8"/>
<w:LsdException Locked=3D"false" Priority=3D"39" Name=3D"toc 9"/>
<w:LsdException Locked=3D"false" Priority=3D"35" QFormat=3D"true" =
Name=3D"caption"/>
<w:LsdException Locked=3D"false" Priority=3D"10" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" QFormat=3D"true" Name=3D"Title"/>
<w:LsdException Locked=3D"false" Priority=3D"1" Name=3D"Default =
Paragraph Font"/>
<w:LsdException Locked=3D"false" Priority=3D"11" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" QFormat=3D"true" Name=3D"Subtitle"/>
<w:LsdException Locked=3D"false" Priority=3D"22" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" QFormat=3D"true" Name=3D"Strong"/>
<w:LsdException Locked=3D"false" Priority=3D"20" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" QFormat=3D"true" Name=3D"Emphasis"/>
<w:LsdException Locked=3D"false" Priority=3D"59" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Table Grid"/>
<w:LsdException Locked=3D"false" UnhideWhenUsed=3D"false" =
Name=3D"Placeholder Text"/>
<w:LsdException Locked=3D"false" Priority=3D"1" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" QFormat=3D"true" Name=3D"No Spacing"/>
<w:LsdException Locked=3D"false" Priority=3D"60" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Light Shading"/>
<w:LsdException Locked=3D"false" Priority=3D"61" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Light List"/>
<w:LsdException Locked=3D"false" Priority=3D"62" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Light Grid"/>
<w:LsdException Locked=3D"false" Priority=3D"63" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Medium Shading 1"/>
<w:LsdException Locked=3D"false" Priority=3D"64" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Medium Shading 2"/>
<w:LsdException Locked=3D"false" Priority=3D"65" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Medium List 1"/>
<w:LsdException Locked=3D"false" Priority=3D"66" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Medium List 2"/>
<w:LsdException Locked=3D"false" Priority=3D"67" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Medium Grid 1"/>
<w:LsdException Locked=3D"false" Priority=3D"68" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Medium Grid 2"/>
<w:LsdException Locked=3D"false" Priority=3D"69" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Medium Grid 3"/>
<w:LsdException Locked=3D"false" Priority=3D"70" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Dark List"/>
<w:LsdException Locked=3D"false" Priority=3D"71" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Colorful Shading"/>
<w:LsdException Locked=3D"false" Priority=3D"72" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Colorful List"/>
<w:LsdException Locked=3D"false" Priority=3D"73" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Colorful Grid"/>
<w:LsdException Locked=3D"false" Priority=3D"60" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Light Shading Accent 1"/>
<w:LsdException Locked=3D"false" Priority=3D"61" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Light List Accent 1"/>
<w:LsdException Locked=3D"false" Priority=3D"62" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Light Grid Accent 1"/>
<w:LsdException Locked=3D"false" Priority=3D"63" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Medium Shading 1 Accent 1"/>
<w:LsdException Locked=3D"false" Priority=3D"64" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Medium Shading 2 Accent 1"/>
<w:LsdException Locked=3D"false" Priority=3D"65" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Medium List 1 Accent 1"/>
<w:LsdException Locked=3D"false" UnhideWhenUsed=3D"false" =
Name=3D"Revision"/>
<w:LsdException Locked=3D"false" Priority=3D"34" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" QFormat=3D"true" Name=3D"List Paragraph"/>
<w:LsdException Locked=3D"false" Priority=3D"29" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" QFormat=3D"true" Name=3D"Quote"/>
<w:LsdException Locked=3D"false" Priority=3D"30" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" QFormat=3D"true" Name=3D"Intense Quote"/>
<w:LsdException Locked=3D"false" Priority=3D"66" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Medium List 2 Accent 1"/>
<w:LsdException Locked=3D"false" Priority=3D"67" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Medium Grid 1 Accent 1"/>
<w:LsdException Locked=3D"false" Priority=3D"68" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Medium Grid 2 Accent 1"/>
<w:LsdException Locked=3D"false" Priority=3D"69" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Medium Grid 3 Accent 1"/>
<w:LsdException Locked=3D"false" Priority=3D"70" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Dark List Accent 1"/>
<w:LsdException Locked=3D"false" Priority=3D"71" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Colorful Shading Accent 1"/>
<w:LsdException Locked=3D"false" Priority=3D"72" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Colorful List Accent 1"/>
<w:LsdException Locked=3D"false" Priority=3D"73" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Colorful Grid Accent 1"/>
<w:LsdException Locked=3D"false" Priority=3D"60" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Light Shading Accent 2"/>
<w:LsdException Locked=3D"false" Priority=3D"61" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Light List Accent 2"/>
<w:LsdException Locked=3D"false" Priority=3D"62" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Light Grid Accent 2"/>
<w:LsdException Locked=3D"false" Priority=3D"63" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Medium Shading 1 Accent 2"/>
<w:LsdException Locked=3D"false" Priority=3D"64" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Medium Shading 2 Accent 2"/>
<w:LsdException Locked=3D"false" Priority=3D"65" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Medium List 1 Accent 2"/>
<w:LsdException Locked=3D"false" Priority=3D"66" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Medium List 2 Accent 2"/>
<w:LsdException Locked=3D"false" Priority=3D"67" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Medium Grid 1 Accent 2"/>
<w:LsdException Locked=3D"false" Priority=3D"68" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Medium Grid 2 Accent 2"/>
<w:LsdException Locked=3D"false" Priority=3D"69" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Medium Grid 3 Accent 2"/>
<w:LsdException Locked=3D"false" Priority=3D"70" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Dark List Accent 2"/>
<w:LsdException Locked=3D"false" Priority=3D"71" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Colorful Shading Accent 2"/>
<w:LsdException Locked=3D"false" Priority=3D"72" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Colorful List Accent 2"/>
<w:LsdException Locked=3D"false" Priority=3D"73" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Colorful Grid Accent 2"/>
<w:LsdException Locked=3D"false" Priority=3D"60" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Light Shading Accent 3"/>
<w:LsdException Locked=3D"false" Priority=3D"61" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Light List Accent 3"/>
<w:LsdException Locked=3D"false" Priority=3D"62" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Light Grid Accent 3"/>
<w:LsdException Locked=3D"false" Priority=3D"63" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Medium Shading 1 Accent 3"/>
<w:LsdException Locked=3D"false" Priority=3D"64" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Medium Shading 2 Accent 3"/>
<w:LsdException Locked=3D"false" Priority=3D"65" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Medium List 1 Accent 3"/>
<w:LsdException Locked=3D"false" Priority=3D"66" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Medium List 2 Accent 3"/>
<w:LsdException Locked=3D"false" Priority=3D"67" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Medium Grid 1 Accent 3"/>
<w:LsdException Locked=3D"false" Priority=3D"68" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Medium Grid 2 Accent 3"/>
<w:LsdException Locked=3D"false" Priority=3D"69" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Medium Grid 3 Accent 3"/>
<w:LsdException Locked=3D"false" Priority=3D"70" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Dark List Accent 3"/>
<w:LsdException Locked=3D"false" Priority=3D"71" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Colorful Shading Accent 3"/>
<w:LsdException Locked=3D"false" Priority=3D"72" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Colorful List Accent 3"/>
<w:LsdException Locked=3D"false" Priority=3D"73" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Colorful Grid Accent 3"/>
<w:LsdException Locked=3D"false" Priority=3D"60" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Light Shading Accent 4"/>
<w:LsdException Locked=3D"false" Priority=3D"61" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Light List Accent 4"/>
<w:LsdException Locked=3D"false" Priority=3D"62" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Light Grid Accent 4"/>
<w:LsdException Locked=3D"false" Priority=3D"63" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Medium Shading 1 Accent 4"/>
<w:LsdException Locked=3D"false" Priority=3D"64" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Medium Shading 2 Accent 4"/>
<w:LsdException Locked=3D"false" Priority=3D"65" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Medium List 1 Accent 4"/>
<w:LsdException Locked=3D"false" Priority=3D"66" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Medium List 2 Accent 4"/>
<w:LsdException Locked=3D"false" Priority=3D"67" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Medium Grid 1 Accent 4"/>
<w:LsdException Locked=3D"false" Priority=3D"68" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Medium Grid 2 Accent 4"/>
<w:LsdException Locked=3D"false" Priority=3D"69" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Medium Grid 3 Accent 4"/>
<w:LsdException Locked=3D"false" Priority=3D"70" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Dark List Accent 4"/>
<w:LsdException Locked=3D"false" Priority=3D"71" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Colorful Shading Accent 4"/>
<w:LsdException Locked=3D"false" Priority=3D"72" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Colorful List Accent 4"/>
<w:LsdException Locked=3D"false" Priority=3D"73" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Colorful Grid Accent 4"/>
<w:LsdException Locked=3D"false" Priority=3D"60" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Light Shading Accent 5"/>
<w:LsdException Locked=3D"false" Priority=3D"61" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Light List Accent 5"/>
<w:LsdException Locked=3D"false" Priority=3D"62" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Light Grid Accent 5"/>
<w:LsdException Locked=3D"false" Priority=3D"63" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Medium Shading 1 Accent 5"/>
<w:LsdException Locked=3D"false" Priority=3D"64" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Medium Shading 2 Accent 5"/>
<w:LsdException Locked=3D"false" Priority=3D"65" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Medium List 1 Accent 5"/>
<w:LsdException Locked=3D"false" Priority=3D"66" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Medium List 2 Accent 5"/>
<w:LsdException Locked=3D"false" Priority=3D"67" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Medium Grid 1 Accent 5"/>
<w:LsdException Locked=3D"false" Priority=3D"68" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Medium Grid 2 Accent 5"/>
<w:LsdException Locked=3D"false" Priority=3D"69" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Medium Grid 3 Accent 5"/>
<w:LsdException Locked=3D"false" Priority=3D"70" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Dark List Accent 5"/>
<w:LsdException Locked=3D"false" Priority=3D"71" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Colorful Shading Accent 5"/>
<w:LsdException Locked=3D"false" Priority=3D"72" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Colorful List Accent 5"/>
<w:LsdException Locked=3D"false" Priority=3D"73" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Colorful Grid Accent 5"/>
<w:LsdException Locked=3D"false" Priority=3D"60" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Light Shading Accent 6"/>
<w:LsdException Locked=3D"false" Priority=3D"61" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Light List Accent 6"/>
<w:LsdException Locked=3D"false" Priority=3D"62" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Light Grid Accent 6"/>
<w:LsdException Locked=3D"false" Priority=3D"63" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Medium Shading 1 Accent 6"/>
<w:LsdException Locked=3D"false" Priority=3D"64" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Medium Shading 2 Accent 6"/>
<w:LsdException Locked=3D"false" Priority=3D"65" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Medium List 1 Accent 6"/>
<w:LsdException Locked=3D"false" Priority=3D"66" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Medium List 2 Accent 6"/>
<w:LsdException Locked=3D"false" Priority=3D"67" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Medium Grid 1 Accent 6"/>
<w:LsdException Locked=3D"false" Priority=3D"68" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Medium Grid 2 Accent 6"/>
<w:LsdException Locked=3D"false" Priority=3D"69" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Medium Grid 3 Accent 6"/>
<w:LsdException Locked=3D"false" Priority=3D"70" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Dark List Accent 6"/>
<w:LsdException Locked=3D"false" Priority=3D"71" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Colorful Shading Accent 6"/>
<w:LsdException Locked=3D"false" Priority=3D"72" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Colorful List Accent 6"/>
<w:LsdException Locked=3D"false" Priority=3D"73" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" Name=3D"Colorful Grid Accent 6"/>
<w:LsdException Locked=3D"false" Priority=3D"19" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" QFormat=3D"true" Name=3D"Subtle Emphasis"/>
<w:LsdException Locked=3D"false" Priority=3D"21" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" QFormat=3D"true" Name=3D"Intense Emphasis"/>
<w:LsdException Locked=3D"false" Priority=3D"31" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" QFormat=3D"true" Name=3D"Subtle Reference"/>
<w:LsdException Locked=3D"false" Priority=3D"32" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" QFormat=3D"true" Name=3D"Intense Reference"/>
<w:LsdException Locked=3D"false" Priority=3D"33" SemiHidden=3D"false" =
UnhideWhenUsed=3D"false" QFormat=3D"true" Name=3D"Book Title"/>
<w:LsdException Locked=3D"false" Priority=3D"37" Name=3D"Bibliography"/>
<w:LsdException Locked=3D"false" Priority=3D"39" QFormat=3D"true" =
Name=3D"TOC Heading"/>
</w:LatentStyles>
</xml><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;
	mso-font-alt:"Century Gothic";
	mso-font-charset:0;
	mso-generic-font-family:swiss;
	mso-font-pitch:variable;
	mso-font-signature:-536870145 1073786111 1 0 415 0;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-unhide:no;
	mso-style-qformat:yes;
	mso-style-parent:"";
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";
	mso-ascii-font-family:Calibri;
	mso-fareast-font-family:Calibri;
	mso-hansi-font-family:Calibri;
	mso-bidi-font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{mso-style-noshow:yes;
	mso-style-priority:99;
	color:blue;
	text-decoration:underline;
	text-underline:single;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-noshow:yes;
	mso-style-priority:99;
	color:purple;
	text-decoration:underline;
	text-underline:single;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	mso-style-noshow:yes;
	mso-style-unhide:no;
	mso-ansi-font-size:11.0pt;
	mso-bidi-font-size:11.0pt;
	font-family:"Calibri","sans-serif";
	mso-ascii-font-family:Calibri;
	mso-fareast-font-family:Calibri;
	mso-hansi-font-family:Calibri;
	mso-bidi-font-family:"Times New Roman";
	color:windowtext;}
span.SpellE
	{mso-style-name:"";
	mso-spl-e:yes;}
span.GramE
	{mso-style-name:"";
	mso-gram-e:yes;}
.MsoChpDefault
	{mso-style-type:export-only;
	mso-default-props:yes;
	font-family:"Calibri","sans-serif";
	mso-ascii-font-family:Calibri;
	mso-fareast-font-family:Calibri;
	mso-hansi-font-family:Calibri;
	mso-bidi-font-family:"Times New Roman";}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-paper-source:0;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 10]><style>/* Style Definitions */
table.MsoNormalTable
	{mso-style-name:"Table Normal";
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-priority:99;
	mso-style-parent:"";
	mso-padding-alt:0in 5.4pt 0in 5.4pt;
	mso-para-margin:0in;
	mso-para-margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";
	mso-ascii-font-family:Calibri;
	mso-hansi-font-family:Calibri;}
</style><![endif]--><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-US link=3Dblue =
vlink=3Dpurple style=3D'tab-interval:.5in'><div class=3DWordSection1><p =
class=3DMsoNormal>Test attempted using <span =
class=3DSpellE>jonmason</span>/ntb at =
dfb7d24c5ad5c986f2417f52784738b67cfedd4d.<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>With latest, =
it crashes when removing the modules.<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal><span =
class=3DGramE>[ 1494.330594</span>] <span =
class=3DSpellE>ntb_hw_intel</span> 0000:80:03.0: qp 0: Send Link =
Down<o:p></o:p></p><p class=3DMsoNormal><span class=3DGramE>[ =
1494.358126</span>] <span class=3DSpellE>ntb_hw_intel</span> =
0000:80:03.0: NTB Transport QP 0 freed<o:p></o:p></p><p =
class=3DMsoNormal><span class=3DGramE>[ 1494.364771</span>] <span =
class=3DSpellE>ntb_hw_intel</span> 0000:00:03.0: qp 0: Send Link =
Down<o:p></o:p></p><p class=3DMsoNormal><span class=3DGramE>[ =
1494.400171</span>] <span class=3DSpellE>ntb_hw_intel</span> =
0000:00:03.0: NTB Transport QP 0 freed<o:p></o:p></p><p =
class=3DMsoNormal><span class=3DGramE>[ 1494.431502</span>] BUG: unable =
to handle kernel NULL pointer dereference at =
00000000000000a8<o:p></o:p></p><p class=3DMsoNormal><span =
class=3DGramE>[ 1494.440267</span>] IP: [&lt;ffffffff816c3def&gt;] =
down_write+0x1f/0x40<o:p></o:p></p><p class=3DMsoNormal><span =
class=3DGramE>[ 1494.446312</span>] PGD ff3231067 [ 1494.449136] PUD =
ff5600067<o:p></o:p></p><p class=3DMsoNormal>PMD 0 <span class=3DGramE>[ =
1494.452760</span>]<o:p></o:p></p><p class=3DMsoNormal><span =
class=3DGramE>[ 1494.454430</span>] Oops: 0002 [#1] SMP<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>Entering =
<span class=3DSpellE>kdb</span> (current=3D0xffff880ff4ea2c00, <span =
class=3DSpellE><span class=3DGramE>pid</span></span> 1297) on processor =
1 Oops: (null)<o:p></o:p></p><p class=3DMsoNormal><span =
class=3DGramE>due</span> to oops @ 0xffffffff816c3def<o:p></o:p></p><p =
class=3DMsoNormal>CPU: 1 PID: 1297 <span class=3DSpellE>Comm</span>: =
<span class=3DSpellE>rmmod</span> <span class=3DGramE>Not</span> tainted =
4.9.0-ntb #25<o:p></o:p></p><p class=3DMsoNormal>Hardware name: EMC =
900-565-027/110-325-102B-00, BIOS <span class=3DGramE>23.27 =
12/10/2014</span><o:p></o:p></p><p class=3DMsoNormal><span =
class=3DGramE>task</span>: ffff880ff4ea2c00 <span =
class=3DSpellE>task.stack</span>: ffffc9000d784000<o:p></o:p></p><p =
class=3DMsoNormal>RIP: <span =
class=3DGramE>0010:</span>[&lt;ffffffff816c3def&gt;]<span =
style=3D'mso-spacerun:yes'>=C2=A0 </span>[&lt;ffffffff816c3def&gt;] =
down_write+0x1f/0x40<o:p></o:p></p><p class=3DMsoNormal>RSP: <span =
class=3DGramE>0018:ffffc9000d787d98<span =
style=3D'mso-spacerun:yes'>=C2=A0 </span>EFLAGS</span>: =
00010246<o:p></o:p></p><p class=3DMsoNormal>RAX: 00000000000000a8 RBX: =
00000000000000a8 RCX: 0000000000000001<o:p></o:p></p><p =
class=3DMsoNormal>RDX: ffffffff00000001 RSI: ffff881ff5d49258 RDI: =
00000000000000a8<o:p></o:p></p><p class=3DMsoNormal>RBP: =
ffffc9000d787da0 R08: ffffffffa01b2500 R09: =
000000018022000f<o:p></o:p></p><p class=3DMsoNormal>R10: =
00000000f7f6f701 R11: ffff880ff7f6f4b0 R12: =
ffff880ff3e53d98<o:p></o:p></p><p class=3DMsoNormal>R13: =
ffff880ff3e53de0 R14: ffff880ff3e53d40 R15: =
ffff880ff3e53d40<o:p></o:p></p><p class=3DMsoNormal>FS:<span =
style=3D'mso-spacerun:yes'>=C2=A0 </span><span =
class=3DGramE>00007f65381b3740(</span>0000) GS:ffff880fffc40000(0000) =
knlGS:0000000000000000<o:p></o:p></p><p class=3DMsoNormal>CS:<span =
style=3D'mso-spacerun:yes'>=C2=A0 </span>0010 DS: 0000 ES: 0000 CR0: =
0000000080050033<o:p></o:p></p><p class=3DMsoNormal>CR2: =
00000000000000a8 CR3: 0000000ff69e9000 CR4: =
00000000001406e0<o:p></o:p></p><p =
class=3DMsoNormal>Stack:<o:p></o:p></p><p class=3DMsoNormal> =
ffff881ff5d49200 ffffc9000d787de0 ffffffff812ad0ed =
ffffffffa01390e0<o:p></o:p></p><p class=3DMsoNormal> ffff881ff5d49200 =
ffff881ff467cc00 0000000000000001 0000000000000000<o:p></o:p></p><p =
class=3DMsoNormal> ffff881ff4569800 ffffc9000d787e18 ffffffffa0135171 =
ffff881ff4569800<o:p></o:p></p><p class=3DMsoNormal>Call =
Trace:<o:p></o:p></p><p class=3DMsoNormal> [&lt;ffffffff812ad0ed&gt;] =
debugfs_remove_recursive+0x4d/0x190<o:p></o:p></p><p class=3DMsoNormal> =
[&lt;ffffffffa0135171&gt;] ntb_transport_free+0x61/0x160 [<span =
class=3DSpellE>ntb_transport</span>]<o:p></o:p></p><p class=3DMsoNormal> =
[&lt;ffffffffa0031115&gt;] ntb_remove+0x25/0x40 [ntb]<o:p></o:p></p><p =
class=3DMsoNormal> [&lt;ffffffff8147e81a&gt;] =
__device_release_driver+0x9a/0x140<o:p></o:p></p><p class=3DMsoNormal> =
[&lt;ffffffff8147e9c8&gt;] driver_detach+0xb8/0xc0<o:p></o:p></p><p =
class=3DMsoNormal> [&lt;ffffffff8147d7f5&gt;] =
bus_remove_driver+0x55/0xd0<o:p></o:p></p><p class=3DMsoNormal> =
[&lt;ffffffff8147f18c&gt;] driver_unregister+0x2c/0x50<o:p></o:p></p><p =
class=3DMsoNormal> [&lt;ffffffffa003117e&gt;] =
ntb_unregister_client+0xe/0x10 [ntb]<o:p></o:p></p><p class=3DMsoNormal> =
[&lt;ffffffffa01379ae&gt;] ntb_transport_exit+0x1c/0x66e [<span =
class=3DSpellE>ntb_transport</span>]<o:p></o:p></p><p class=3DMsoNormal> =
[&lt;ffffffff8110d3ba&gt;] =
SyS_delete_module+0x1ba/0x220<o:p></o:p></p><p class=3DMsoNormal> =
[&lt;ffffffff81003a47&gt;] do_syscall_64+0x67/0x180<o:p></o:p></p><p =
class=3DMsoNormal> [&lt;ffffffff816c64ab&gt;] =
entry_SYSCALL64_slow_path+0x25/0x25<o:p></o:p></p><p =
class=3DMsoNormal>Code: 66 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 =
00 55 48 89 e5 53 48 89 fb e8 3e e1 <span class=3DSpellE>ff</span> <span =
class=3DSpellE>ff</span> 48 <span class=3DSpellE>ba</span> 01 00 00 00 =
<span class=3DSpellE>ff</span> <span class=3DSpellE>ff</span> <span =
class=3DSpellE>ff</span> <span class=3DSpellE>ff</span> 48 89 d8 =
&lt;f0&gt; 48 0f c1 10 85 d2 74 05 e8 53 2d c9 <span =
class=3DSpellE>ff</span> 65 48 8b 04 25 c0 =
d2<o:p></o:p></p></div></body></html>
------=_NextPart_000_03F3_01D26058.5F7C83F0--

