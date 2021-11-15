Date: Mon, 15 Nov 2021 08:51:46 -0800 (PST)
From: Eyal ben ner <eyalbenn@gmail.com>
Message-Id: <24826bb2-da96-4ea8-9b75-6f40425e0368n@googlegroups.com>
Subject: ntb_tool: asymmetric windows
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_4986_966976853.1636995106189"
To: linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

------=_Part_4986_966976853.1636995106189
Content-Type: multipart/alternative; 
	boundary="----=_Part_4987_455102966.1636995106189"

------=_Part_4987_455102966.1636995106189
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit




Hi,

Newbie question: I'm using 2 Xeon(R) Silver 4214 nodes (ntb3 hw) with 
4.19.177 kernel.

I loaded the ntb_tool modules and connected both nodes.

I created 8KB buffer on node A, I mapped a (8KB) window on node B, I wrote 
8KB file to the window and succeed to read the file completely from the 
debugfs on node A (so far, we are good).

I restarted node A buffer content.

Next, I created additional 4KB buffer on node B, then I wrote the same 8KB 
file to the same old 8KB window on node B, but now I read only 4KB on node 
A, the rest 4KB is the initialized data of the buffer.

Below I'll put the exact commands I used.

Is this a knows issue?

Any idea how to solve this issue?

 

Thanks,

Eyal

 

1st stage:

Node A:

1.      insmod ntb/test/ntb_tool.ko

Node B:

1.      insmod ntb/test/ntb_tool.ko 

Node A:

1.      export DBG_DIR=/sys/kernel/debug/ntb_tool/0000:0a:00.0

2.      cat $DBG_DIR/peer0/link

3.      echo Y > $DBG_DIR/link

4.      cat $DBG_DIR/peer0/link

Node B:

1.      export DBG_DIR=/sys/kernel/debug/ntb_tool/0000:0a:00.0

2.      cat $DBG_DIR/peer0/link

3.      echo Y > $DBG_DIR/link

4.      cat $DBG_DIR/peer0/link

Node A:

1.      echo 8192 > $DBG_DIR/peer0/mw_trans0

2.      cat 2.txt > $DBG_DIR/peer0/mw

3.      head -c 8192 $DBG_DIR/peer0/mw0 > 1s_1st_r.txt

Node B:

1.      echo 0x1000000000:8192  > $DBG_DIR/peer0/peer_mw_trans0

2.      cat 5.txt  > $DBG_DIR/peer0/peer_mw0

Node A:

1.      head -c 8192 $DBG_DIR/peer0/mw0 > 1s_2nd_r.txt

 

2nd stage:

Node B:

1.      echo 4096 > $DBG_DIR/peer0/mw_trans0

Node A:

1.      cat 2.txt > $DBG_DIR/peer0/mw0

2.      head -c 8192 $DBG_DIR/peer0/mw0 > 2s_1st_r.txt

Node B:

1.      cat 5.txt  > $DBG_DIR/peer0/peer_mw0

Node A:

1.      head -c 8192 $DBG_DIR/peer0/mw0 > 2s_2nd_r.txt

 

 

 

------=_Part_4987_455102966.1636995106189
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<p><br>
Hi,</p>

<p>Newbie question: I'm using 2 Xeon(R) Silver 4214 nodes (ntb3 hw)&nbsp;with 4.19.177 kernel.</p>

<p>I loaded the ntb_tool modules and connected both
nodes.</p>

<p>I created 8KB buffer on node A, I mapped a (8KB)
window on node B, I wrote 8KB file to the window and succeed to read
the file completely from the debugfs on node A (so far, we are good).</p>

<p>I restarted node A buffer content.</p>

<p>Next, I created additional 4KB buffer on node B, then I wrote
the same 8KB file to the same old 8KB window on node B, but now I read only 4KB
on node A, the rest 4KB is the initialized data of the buffer.</p>

<p>Below I'll put the exact commands I used.</p>

<p>Is this a knows issue?</p>

<p>Any
idea how to solve this issue?</p>

<p>&nbsp;</p>

<p>Thanks,</p>

<p>Eyal</p>

<p>&nbsp;</p>

<p>1st
stage:</p>

<p>Node
A:</p>

<p>1.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<span dir="LTR"></span>insmod ntb/test/ntb_tool.ko</p>

<p>Node
B:</p>

<p>1.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<span dir="LTR"></span>insmod ntb/test/ntb_tool.ko </p>

<p>Node
A:</p>

<p>1.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<span dir="LTR"></span>export
DBG_DIR=/sys/kernel/debug/ntb_tool/0000:0a:00.0</p>

<p>2.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<span dir="LTR"></span>cat $DBG_DIR/peer0/link</p>

<p>3.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<span dir="LTR"></span>echo Y &gt; $DBG_DIR/link</p>

<p>4.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<span dir="LTR"></span>cat $DBG_DIR/peer0/link</p>

<p>Node
B:</p>

<p>1.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<span dir="LTR"></span>export
DBG_DIR=/sys/kernel/debug/ntb_tool/0000:0a:00.0</p>

<p>2.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<span dir="LTR"></span>cat $DBG_DIR/peer0/link</p>

<p>3.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<span dir="LTR"></span>echo Y &gt; $DBG_DIR/link</p>

<p>4.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<span dir="LTR"></span>cat $DBG_DIR/peer0/link</p>

<p>Node
A:</p>

<p>1.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<span dir="LTR"></span>echo
8192 &gt; $DBG_DIR/peer0/mw_trans0</p>

<p>2.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<span dir="LTR"></span>cat
2.txt &gt; $DBG_DIR/peer0/mw</p>

<p>3.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<span dir="LTR"></span>head
-c 8192 $DBG_DIR/peer0/mw0 &gt; 1s_1st_r.txt</p>

<p>Node
B:</p>

<p>1.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<span dir="LTR"></span>echo
0x1000000000:8192&nbsp; &gt; $DBG_DIR/peer0/peer_mw_trans0</p>

<p>2.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<span dir="LTR"></span>cat
5.txt&nbsp; &gt; $DBG_DIR/peer0/peer_mw0</p>

<p>Node
A:</p>

<p>1.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<span dir="LTR"></span>head
-c 8192 $DBG_DIR/peer0/mw0 &gt; 1s_2nd_r.txt</p>

<p>&nbsp;</p>

<p>2nd
stage:</p>

<p>Node
B:</p>

<p>1.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<span dir="LTR"></span>echo
4096 &gt; $DBG_DIR/peer0/mw_trans0</p>

<p>Node
A:</p>

<p>1.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<span dir="LTR"></span>cat
2.txt &gt; $DBG_DIR/peer0/mw0</p>

<p>2.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<span dir="LTR"></span>head
-c 8192 $DBG_DIR/peer0/mw0 &gt; 2s_1st_r.txt</p>

<p>Node
B:</p>

<p>1.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<span dir="LTR"></span>cat
5.txt&nbsp; &gt; $DBG_DIR/peer0/peer_mw0</p>

<p>Node
A:</p>

<p>1.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<span dir="LTR"></span>head
-c 8192 $DBG_DIR/peer0/mw0 &gt; 2s_2nd_r.txt</p>

<p>&nbsp;</p>

<p>&nbsp;</p>

<p>&nbsp;</p>
------=_Part_4987_455102966.1636995106189--

------=_Part_4986_966976853.1636995106189--
