Date: Tue, 27 Oct 2020 15:32:06 -0700 (PDT)
From: Gera Kazakov <gera.kazakov@liqid.com>
Message-Id: <479fb8a5-e3e9-4cd9-a084-7a18a2bac57dn@googlegroups.com>
Subject: ntb_unregister_device problem
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_214_1691689788.1603837926607"
To: linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

------=_Part_214_1691689788.1603837926607
Content-Type: multipart/alternative; 
	boundary="----=_Part_215_1205169160.1603837926607"

------=_Part_215_1205169160.1603837926607
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

I noticed that when I call ntb_unregister_device from my HW driver for NTB, 
the ntb_transport emits this message:

ntb_transport 0000:0b:00.0: ntb_netdev0 still attached to bus, removing

The network interface disappears however something is left behind. On 
subsequent call to ntb_register_device I get:

debugfs: Directory '0000:0b:00.0' with parent 'ntb_transport' already 
present!

No network device gets created. To fix I have to reload the ntb_transport 
and ntb_netdev modules.
Am I missing something in HW device unregistration sequence?

Thank you.

------=_Part_215_1205169160.1603837926607
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

I noticed that when I call ntb_unregister_device from my HW driver for NTB, the ntb_transport emits this message:<div><br></div><div><font face="Courier New">ntb_transport 0000:0b:00.0: ntb_netdev0 still attached to bus, removing</font><br></div><div><br></div><div>The network interface disappears however something is left behind. On subsequent call to ntb_register_device I get:</div><div><br></div><div><font face="Courier New">debugfs: Directory '0000:0b:00.0' with parent 'ntb_transport' already present!</font><br></div><div><font face="Courier New"><br></font></div><div>No network device gets created. To fix I have to reload the ntb_transport and ntb_netdev modules.</div><div>Am I missing something in HW device unregistration sequence?</div><div><br></div><div>Thank you.</div>
------=_Part_215_1205169160.1603837926607--

------=_Part_214_1691689788.1603837926607--
