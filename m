Return-Path: <jdmason@kudzu.us>
Received: from mail-vk0-x241.google.com (mail-vk0-x241.google.com. [2607:f8b0:400c:c05::241])
        by gmr-mx.google.com with ESMTPS id q78si402149vkb.1.2016.05.09.05.11.33
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 May 2016 05:11:33 -0700 (PDT)
Received: by mail-vk0-x241.google.com with SMTP id c189so5465160vkb.3
        for <linux-ntb@googlegroups.com>; Mon, 09 May 2016 05:11:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAO+9SsM2z8QW_RVBaw3g7=nOehppq98zQ_1Zw10a7gofiBBgFA@mail.gmail.com>
References: <CAO+9SsOojQ2NoRqUKCgJexBtCA=rB0JThw2q70svPAaY04-UJw@mail.gmail.com>
	<000001d1a798$08a195d0$19e4c170$@emc.com>
	<CAO+9SsM2z8QW_RVBaw3g7=nOehppq98zQ_1Zw10a7gofiBBgFA@mail.gmail.com>
Date: Mon, 9 May 2016 08:11:33 -0400
Message-ID: <CAPoiz9zk=giGU=3kZme3Cc2LLTLQi+p-92K9Wwmfd+Nz-Ftntg@mail.gmail.com>
Subject: Re: Need information about understanding PCIE non-transparent bridge
From: Jon Mason <jdmason@kudzu.us>
Content-Type: text/plain; charset=UTF-8
To: sridhar T S <sridhar.lochu@gmail.com>
Cc: Allen Hubbe <Allen.Hubbe@emc.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Mon, May 9, 2016 at 5:23 AM, sridhar T S <sridhar.lochu@gmail.com> wrote:
> hi Allen,
>
> yes, am interested in testing the ntb functionality using Linux mainly our
> test OS will be Ubuntu.
> i would welcome your suggestions and ideas upon the system configuration,
> tools/applications, server setup between the primary and secondary machines.
>
> below is my queries:
>
> 1. Can you let me know how to use the tools ntb_tool and ntb_pingpong to
> test the ntb connection.

See Documentation/ntb.txt

> 2. NTB setup configuration i.e how to configure the two systems for NTB data
> access
>             a. which file system server to create for testing between
> platforms.

Not sure what you mean here.  Are you referring to NFS?

>             b. third party tools to verify the ntb bandwidth

None are known to exist

> 3. How to access non bar0 data transactions between ntb machines?
>             a. can you suggest any tools or applications that can be used to
> verfiy from operating system perspective

Each BAR is exposed as a separate memory window.  If you have > 1 BAR,
then you will have a separate MW that the client can use (unless it is
being used by the kernel to workaround HW issues).

> 4. how can we initiate data transfer using the system DMA?

This will happen automatically if the DMA engine is enabled in the kernel

>
> i will keep you posted on any more queries in this thread
>
> regards,
> Sridhar
>
> On Fri, May 6, 2016 at 6:35 PM, Allen Hubbe <Allen.Hubbe@emc.com> wrote:
>>
>> Hi Sridhar,
>>
>> If you have NTB hardware already physically connected and
>> configured in your BIOS, then you can build and load the
>> linux ntb modules.
>>
>> Here is the documentation on linux ntb modules.  It says
>> what the modules do, and how to use them.
>>
>> http://lxr.free-electrons.com/source/Documentation/ntb.txt
>>
>> If you are interested in testing or demonstrating basic NTB
>> functionality, try ntb_tool and ntb_pingpong.  There is
>> also a network device over NTB supported by ntb_transport
>> and ntb_netdev together.
>>
>> Please let me know if you have any questions not answered in
>> the documentation.  I am happy to help.
>>
>> Allen
>>
>> From: sridhar T S
>> >
>> > Hi allen,
>> >
>> > myself sridhar, working as senior software engineer.
>> > i wanted to understand about PCIE non-transparent bridge.
>> >
>> > i will be testing the linux device driver for NTB, for now
>> > i have a very fair understanding about the architecture.
>> >
>> > need some ideas about how to test the NTB device driver
>> > across NTB systems for proper system operations with
>> > respect to NTB device driver for linux
>> >
>> > your inputs and information will be helpful.
>> >
>> > thanks in advance.
>> >
>> > regards,
>> > Sridhar
>>
>>
>>
>
> --
> You received this message because you are subscribed to the Google Groups
> "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/linux-ntb/CAO%2B9SsM2z8QW_RVBaw3g7%3DnOehppq98zQ_1Zw10a7gofiBBgFA%40mail.gmail.com.
>
> For more options, visit https://groups.google.com/d/optout.
