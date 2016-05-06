Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwdur.emc.com (mailuogwdur.emc.com. [128.221.224.79])
        by gmr-mx.google.com with ESMTPS id y205si1439022ywg.7.2016.05.06.06.06.23
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 May 2016 06:06:23 -0700 (PDT)
From: "Allen Hubbe" <Allen.Hubbe@emc.com>
References: <CAO+9SsOojQ2NoRqUKCgJexBtCA=rB0JThw2q70svPAaY04-UJw@mail.gmail.com>
In-Reply-To: <CAO+9SsOojQ2NoRqUKCgJexBtCA=rB0JThw2q70svPAaY04-UJw@mail.gmail.com>
Subject: RE: Need information about understanding PCIE non-transparent bridge
Date: Fri, 6 May 2016 09:05:58 -0400
Message-ID: <000001d1a798$08a195d0$19e4c170$@emc.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
To: 'sridhar T S' <sridhar.lochu@gmail.com>
Cc: linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Hi Sridhar,

If you have NTB hardware already physically connected and
configured in your BIOS, then you can build and load the
linux ntb modules.

Here is the documentation on linux ntb modules.  It says
what the modules do, and how to use them.

http://lxr.free-electrons.com/source/Documentation/ntb.txt

If you are interested in testing or demonstrating basic NTB
functionality, try ntb_tool and ntb_pingpong.  There is
also a network device over NTB supported by ntb_transport
and ntb_netdev together.

Please let me know if you have any questions not answered in
the documentation.  I am happy to help.

Allen

From: sridhar T S
>
> Hi allen,
>
> myself sridhar, working as senior software engineer.
> i wanted to understand about PCIE non-transparent bridge.
>
> i will be testing the linux device driver for NTB, for now
> i have a very fair understanding about the architecture.
>
> need some ideas about how to test the NTB device driver
> across NTB systems for proper system operations with
> respect to NTB device driver for linux
>
> your inputs and information will be helpful.
>
> thanks in advance.
>
> regards,
> Sridhar 



