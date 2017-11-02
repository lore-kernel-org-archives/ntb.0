Date: Thu, 2 Nov 2017 11:33:07 -0700 (PDT)
From: Karl Kao <karl.kao@tintri.com>
Message-Id: <1622b4fe-098b-4a76-bae7-c666258f9db6@googlegroups.com>
Subject: Misleading throughput number using ntb_perf with memcpy_toio()
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_2134_972485728.1509647587064"
To: linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

------=_Part_2134_972485728.1509647587064
Content-Type: multipart/alternative; 
	boundary="----=_Part_2135_1305363091.1509647587064"

------=_Part_2135_1305363091.1509647587064
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Folks,

We have one system with PLX NTB enabled with Gen3 speed on x8 lanes width. 
Technically, the NTB bandwidth is 64 Gbit/s (8192 MBytes/s) in outbound 
direction to its peer on this system.
The ntb_perf comes with the throughput number of 9147 MBytes/s which is 
misleading in comparison to hardware bandwidth of 8192 MBytes/s.

We have a few questions with regard to the misleading throughput number. 
The overall is when memcpy() returns, data may have not yet been put in 
ingress buffer inside PLX NTB which is constrained by flow control credits, 
limitation of 8192 Mbytes/s.

   - The ntb_perf moves memory block to IO bus, using memcpy_toio(), a 
   macro of memcpy(). Once cpu core is done with mov instructions, the 
   memcpy() returns. Is this statement accurate?
   - At the point when memcpy() is done with mov instructions, would the 
   data had been moved to internal buffer inside processor, instead of going 
   through IO bus into PLX chip?
   - Where is the buffer, IIO buffer? What's buffer size that can 
   accommodate gigabytes data?
   - Once we are clearer about the memcpy_tpio, would there be any API that 
   can accurately measure the IO write throughput?


[11:02][root@BRYCE2-DEV][/sys/kernel/debug/ntb_perf/0000:06:00.0]\> cat run
0: copied 4294967296 bytes in 469542 usecs, 9147 MBytes/s
[11:03][root@BRYCE2-DEV][/sys/kernel/debug/ntb_perf/0000:06:00.0]\>


Thanks,
Karl

------=_Part_2135_1305363091.1509647587064
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Folks,</div><div><br></div><div>We have one system=
 with PLX NTB enabled with Gen3 speed on x8 lanes width. Technically, the N=
TB bandwidth is 64 Gbit/s (8192 MBytes/s) in outbound direction to its peer=
 on this system.</div><div>The ntb_perf comes with the throughput number of=
 9147 MBytes/s which is misleading in comparison to hardware bandwidth of 8=
192 MBytes/s.</div><div><br></div><div>We have a few questions with regard =
to the misleading throughput number. The overall is when memcpy() returns, =
data may have not yet been put in ingress buffer inside PLX NTB which is co=
nstrained by flow control credits, limitation of 8192 Mbytes/s.</div><div><=
ul><li>The ntb_perf moves memory block to IO bus, using memcpy_toio(), a ma=
cro of memcpy(). Once cpu core is done with mov instructions, the memcpy() =
returns. Is this statement accurate?<br></li><li>At the point when memcpy()=
 is done with mov instructions, would the data had been moved to internal b=
uffer inside processor, instead of going through IO bus into PLX chip?</li>=
<li>Where is the buffer, IIO buffer? What&#39;s buffer size that can accomm=
odate gigabytes data?</li><li>Once we are clearer about the memcpy_tpio, wo=
uld there be any API that can accurately measure the IO write throughput?</=
li></ul></div><div><br></div><div>[11:02][root@BRYCE2-DEV][/sys/kernel/debu=
g/ntb_perf/0000:06:00.0]\&gt; cat run</div><div>0: copied 4294967296 bytes =
in 469542 usecs, 9147 MBytes/s</div><div>[11:03][root@BRYCE2-DEV][/sys/kern=
el/debug/ntb_perf/0000:06:00.0]\&gt;</div><div><br></div><div><br></div><di=
v>Thanks,</div><div>Karl</div></div>
------=_Part_2135_1305363091.1509647587064--

------=_Part_2134_972485728.1509647587064--
