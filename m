Date: Mon, 6 May 2019 07:43:07 -0700 (PDT)
From: trifundroid94@gmail.com
Message-Id: <dfedc9af-85cd-4b78-9249-3ce794fbe3b5@googlegroups.com>
Subject: NTB connectivity issue under heavy load
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_1936_941372203.1557153787637"
To: linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

------=_Part_1936_941372203.1557153787637
Content-Type: multipart/alternative; 
	boundary="----=_Part_1937_1705440660.1557153787637"

------=_Part_1937_1705440660.1557153787637
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello everyone,

I am not sure if this is the right place to ask but I am going to anyway 
since this problem has been bothering us for quite some time now.

A PC running kernel 4.16.7 and TI's ARM based SoC running kernel 4.14 are 
connected via NTB.
The ntb_netdev drivers are correctly loaded on both sides and the hosts are 
able to ping each other indefinitely. However, when under some heavier 
load, the connection breaks. At first we thought that it only happens when 
running TCP but it also happened for UDP as a transport protocol. 
The Wireshark logs show that the hosts simply forget where the other side 
is regarding ARP protocol. In other words, they know the IP of the peer but 
not its MAC address. We have not found a way to somehow hardcode this, 
especially knowing that the MAC address of the virtual eth made by 
ntb_netdev driver is randomized. The only solution is to restart the whole 
system and start again which is unacceptable.

Has this behavior been observed before? Is there any fix for this?

Thank you in advance.

------=_Part_1937_1705440660.1557153787637
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<div dir="ltr"><div>Hello everyone,</div><div><br></div><div>I am not sure if this is the right place to ask but I am going to anyway since this problem has been bothering us for quite some time now.</div><div><br></div><div> A PC running kernel 4.16.7 and TI&#39;s ARM based SoC running kernel 4.14 
are connected via NTB.</div><div>The ntb_netdev drivers are correctly loaded on both sides and the hosts 
are able to ping each other indefinitely. However, when under some 
heavier load, the connection breaks. At first we thought that it only 
happens when running TCP but it also happened for UDP as a transport protocol. <br></div><div>The Wireshark logs show that the hosts simply forget where the other side is regarding ARP protocol. In other words, they know the IP of the peer but not its MAC address. We have not found a way to somehow hardcode this, especially knowing that the MAC address of the virtual eth made by ntb_netdev driver is randomized. The only solution is to restart the whole system and start again which is unacceptable.</div><div><br></div><div>Has this behavior been observed before? Is there any fix for this?</div><div><br></div><div>Thank you in advance.<br></div></div>
------=_Part_1937_1705440660.1557153787637--

------=_Part_1936_941372203.1557153787637--
