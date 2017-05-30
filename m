Return-Path: <dave.jiang@intel.com>
Received: from mga05.intel.com (mga05.intel.com. [192.55.52.43])
        by gmr-mx.google.com with ESMTPS id r81si870408pfk.13.2017.05.30.09.34.03
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 May 2017 09:34:03 -0700 (PDT)
Subject: Re: Cabling for NTB between Intel Xeon E5 v4 servers
References: <CAO_EM_n81HfXZY-X+OuQWX0T=0E5BYpfJJEf+WQVC1DzyyWkLA@mail.gmail.com>
From: Dave Jiang <dave.jiang@intel.com>
Message-ID: <657df2b1-18f5-9435-6477-98701a1aaa92@intel.com>
Date: Tue, 30 May 2017 09:34:02 -0700
MIME-Version: 1.0
In-Reply-To: <CAO_EM_n81HfXZY-X+OuQWX0T=0E5BYpfJJEf+WQVC1DzyyWkLA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Ed Swierk <eswierk@skyportsystems.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>



On 05/26/2017 07:00 PM, 'Ed Swierk' via linux-ntb wrote:
> I'm trying to set up a PCIe link between Intel Xeon E5 v4 (S2600WT)
> servers running Linux 4.10.17, as a testbed for performance
> measurements. My goal is to evaluate feasibility NTB on a custom Xeon
> D-based plug-in card, but as a first step I'm sticking with systems on
> which NTB is already known to (or supposed to) work.

So you'll need PCIe retimer cards. Not redrivers. The hw people
recommended using iDT based card pair. Others may work but have not
tried. I don't know what to recommend because we have an in-house
cabling set that's not commercially available for testing. Also, make
sure your BIOS support NTB and BAR size change and also it turns off SSC
when NTB is on.

> 
> I read https://github.com/davejiang/linux/wiki/Intel-NTB-Startup-Guide
> and every other document I could find on Intel NTB, but I'm stuck on a
> basic question: what kind of cable should I use to connect the PCIe slots?
> 
> I found some card-and-cable kits
> at http://www.onestopsystems.com/expansion-kits, but these are quite
> expensive ($thousands).
> 
> Another idea is to use so-called mini-SAS HD aka SFF-8643, which I
> understand can carry PCIe x4, along with a pair of PCIe-to-SF-8643
> adapters
> (e.g. https://www.startech.com/HDD/Adapters/pcie-nvme-u2-ssd-adapter~PEX4SFF8643).
> The TX-to-RX wiring seems like it should work, but I have no idea about
> signal integrity through such a cable.
> 
> There's also the SuperMicro AOC-SLG3-2E4R, which is similar to the
> StarTech card but claims to have redriver circuitry.
> 
> What cabling have folks successfully used for NTB between Intel
> Xeon-based servers?
> 
> --Ed
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
> https://groups.google.com/d/msgid/linux-ntb/CAO_EM_n81HfXZY-X%2BOuQWX0T%3D0E5BYpfJJEf%2BWQVC1DzyyWkLA%40mail.gmail.com
> <https://groups.google.com/d/msgid/linux-ntb/CAO_EM_n81HfXZY-X%2BOuQWX0T%3D0E5BYpfJJEf%2BWQVC1DzyyWkLA%40mail.gmail.com?utm_medium=email&utm_source=footer>.
> For more options, visit https://groups.google.com/d/optout.
