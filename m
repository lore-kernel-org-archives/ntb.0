Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x241.google.com (mail-lf0-x241.google.com. [2a00:1450:4010:c07::241])
        by gmr-mx.google.com with ESMTPS id p199si1298757wmd.1.2016.07.26.12.50.57
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jul 2016 12:50:57 -0700 (PDT)
Received: by mail-lf0-x241.google.com with SMTP id 33so933146lfw.3
        for <linux-ntb@googlegroups.com>; Tue, 26 Jul 2016 12:50:57 -0700 (PDT)
Return-Path: <fancer.lancer@gmail.com>
From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 0/3] ntb: Asynchronous NTB devices support
Date: Tue, 26 Jul 2016 22:50:16 +0300
Message-Id: <1469562619-21705-1-git-send-email-fancer.lancer@gmail.com>
To: jdmason@kudzu.us
Cc: dave.jiang@intel.com, Allen.Hubbe@emc.com, Xiangliang.Yu@amd.com, Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

Currently developed NTB-bus supports AMD and Intel Non-transparent PCIe-bridges
only. These bridges implement "synchronous" interfaces, which means that memory
window translated addresses can be direcly specified from one side to another
by writing to a corresponding value to a register. Unlike Intel and AMD there
is another vendor - IDT, which produces synchronous and asynchrnous
NTB PCIe-switches. If synchronous NTB IDT PCIe-switches works almost the same
way as AMD and Intel devices do, the asynchronous ones don't. Due to the
registers field specification the translated base addresses of memory windows
can not be directly specified to a peer. To solve the problem IDT asynchronous
PCIe-switches implement messaging interface to send any kind of information
from one RC to another including translated base addresses. In the framework of
this patches we developed a set of callback functions for the NTB-bus devices
programming interface and drivers for the NT-functions of the following IDT
PCIe-switches:
 - 89HPES24NT6AG2,
 - 89HPES32NT8AG2,
 - 89HPES32NT8BG2,
 - 89HPES12NT12G2,
 - 89HPES16NT16G2,
 - 89HPES24NT24G2,
 - 89HPES32NT24AG2,
 - 89HPES32NT24BG2,
and a set of NTB client drivers to test each subsystem of the IDT NTB drivers
separately.

The patches source code was tested on the hardware with IDT 89HPES32NT8AG2
PCIe-switch connected to root complexes running x64 big endian and x32 little
endian CPUs. The code was warningless built by x86_64, MIPS64 BE and
MIPS32 LE GNU GCC compilers.

To make it easely applicable to the Linux kernel NTB subsystem, the patches were
taken from the top of the "ntb-next" branch of the forked NTB git repository:
https://github.com/fancer/ntb/tree/ntb-next
(it is the fork of https://github.com/jonmason/ntb/tree/ntb-next)
so the hash of the last preceding branch commit was:
04a819bbee3fa4dfe22034e2724dab4efb63f0bd

There are a some types of checkpatch warnings I left unfixed in the framework of
the source code. Here is the reason why:

1) WARNING: Comparisons should place the constant on the right side of the test
Reason: The whole code is written for typos safety. Writing the constants on
the left side of comparisons prevents the code from compiling if "=" and "=="
are mistakenly confused.

2) WARNING: braces {} are not necessary for any arm of this statement
Reason: Even though the braces aren't really necessary, I left them in there
to make the code better distinguishable from the rest of the code.

3) WARNING: Avoid crashing the kernel - try using WARN_ON & recovery code
rather than BUG() or BUG_ON()
Reason: If the BUG()/BUG_ON() macro were invoked, something was really wrong,
so the developer should make sure all the configurations are correct. Otherwise
one should not use the driver.

4) WARNING: line over 80 characters
Reason: Most of these warnings appear due to just 3-5 excess characters, which
can not be excluded without reducing the code readability. The exception is the
registers tables, which are described in the item 8).

5) WARNING: Block comments use a trailing */ on a separate line
Reason: All of those warnings mean that the comment closure pattern"*/" is
specified in the end of the last comment line. If one puts the pattern to a
next line, comments visually get separated from the code they are made for. It
reduces the readability.

6) WARNING: quoted string split across lines
Reason: There was no way to reduce string lengths, so the only way to split
it across lines.

7) WARNING: do not add new typedefs
Reason: They are really needed there and added with full respect to the coding
style document.

8) ERROR: Macros with multiple statements should be enclosed in a do - while
loop
ERROR: Macros with complex values should be enclosed in parentheses
Reason: Those macros are used to create a very suitable registers table using
"enum-switch-case-macro" design pattern with o(1) access to the register
address, size and description. So adding the parentheses and do - while
statements will break the pattern. Additionally they aren't used anywhere else,
than in the framework of the pattern functions.

Of course all of these warnings are discussable, except the last one. It would
be really painful to remove it from the code =)

As one can see I thoroughly annotated and commented the drivers source code, so
it would be easier to study it by kernel hackers.

Here is what the current design of NTB-bus and IDT NTB function drivers
lacks of:
1) No support of Punch-Through functionlity of IDT PCIe-switches
2) DMA is not supported by the current revision of IDT NTB driver
3) Theoretically local and peer root complexes can have different CPU
architecture like x86 and x64. In this way, the dma_addr_t type will
have different size, which may lead to errors when x64 RC allocates
a shared buffer above 4GB memory.

One more suggestion. Since after adding this set of patches there will be two
types of devices the NTB-bus supports, we may want to implement the traditional
linux kernel bus device-drivers matching algorithm using some new
struct ntb_device_id and id_tables.

Thanks,

=============================
Serge V. Semin
Leading Programmer
Embedded SW development group
T-platforms
=============================

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

fancer (3):
  ntb: Add asynchronous devices support to NTB-bus interface
  ntb: IDT 89HPES*NT* PCIe-switches NTB device driver
  ntb: Test client drivers for asynchronous NTB devices

 drivers/ntb/Kconfig                    |    4 +-
 drivers/ntb/hw/Kconfig                 |    1 +
 drivers/ntb/hw/Makefile                |    6 +-
 drivers/ntb/hw/amd/ntb_hw_amd.c        |   49 +-
 drivers/ntb/hw/idt/Kconfig             |   21 +
 drivers/ntb/hw/idt/Makefile            |    5 +
 drivers/ntb/hw/idt/ntb_hw_idt.c        | 4050 ++++++++++++++++++++++++++++++++
 drivers/ntb/hw/idt/ntb_hw_idt.h        |  390 +++
 drivers/ntb/hw/idt/ntb_hw_idt_quirks.c |  163 ++
 drivers/ntb/hw/idt/ntb_hw_idt_quirks.h |  114 +
 drivers/ntb/hw/idt/ntb_hw_idt_regmap.h |  877 +++++++
 drivers/ntb/hw/intel/ntb_hw_intel.c    |   59 +-
 drivers/ntb/ntb.c                      |   86 +-
 drivers/ntb/ntb_transport.c            |   19 +-
 drivers/ntb/test/Kconfig               |   32 +
 drivers/ntb/test/Makefile              |    9 +-
 drivers/ntb/test/ntb_db_test.c         |  677 ++++++
 drivers/ntb/test/ntb_msg_test.c        |  736 ++++++
 drivers/ntb/test/ntb_mw_test.c         | 1531 ++++++++++++
 drivers/ntb/test/ntb_perf.c            |   16 +-
 drivers/ntb/test/ntb_pingpong.c        |    5 +
 drivers/ntb/test/ntb_tool.c            |   25 +-
 include/linux/ntb.h                    |  600 ++++-
 23 files changed, 9309 insertions(+), 166 deletions(-)
 create mode 100644 drivers/ntb/hw/idt/Kconfig
 create mode 100644 drivers/ntb/hw/idt/Makefile
 create mode 100644 drivers/ntb/hw/idt/ntb_hw_idt.c
 create mode 100644 drivers/ntb/hw/idt/ntb_hw_idt.h
 create mode 100644 drivers/ntb/hw/idt/ntb_hw_idt_quirks.c
 create mode 100644 drivers/ntb/hw/idt/ntb_hw_idt_quirks.h
 create mode 100644 drivers/ntb/hw/idt/ntb_hw_idt_regmap.h
 create mode 100644 drivers/ntb/test/ntb_db_test.c
 create mode 100644 drivers/ntb/test/ntb_msg_test.c
 create mode 100644 drivers/ntb/test/ntb_mw_test.c

-- 
2.6.6

