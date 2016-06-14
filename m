Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id c11si1563431pfc.2.2016.06.14.08.45.49
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jun 2016 08:45:49 -0700 (PDT)
References: <cover.1465598632.git.logang@deltatee.com>
 <773161e84a4447a0a91edb42fe18171819ef2319.1465598632.git.logang@deltatee.com>
 <CAPoiz9wNM4esrdpyyMYgL4p_P-p1ke1tapmzita-5ijnHX--5w@mail.gmail.com>
 <576011B5.1090807@osg.samsung.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <5760269C.7030104@deltatee.com>
Date: Tue, 14 Jun 2016 09:45:32 -0600
MIME-Version: 1.0
In-Reply-To: <576011B5.1090807@osg.samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 8/8] ntb_test: Add a selftest script for the NTB subsystem
To: Shuah Khan <shuahkh@osg.samsung.com>, Jon Mason <jdmason@kudzu.us>
Cc: Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-kernel <linux-kernel@vger.kernel.org>, linux-ntb@googlegroups.com, linux-kselftest@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

On 14/06/16 08:16 AM, Shuah Khan wrote:
> On 06/14/2016 08:06 AM, Jon Mason wrote:
>> On Fri, Jun 10, 2016 at 6:54 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
>>> This script automates testing doorbells, scratchpads and memory windows
>>> for an NTB device. It can be run locally, with the NTB looped
>>> back to the same host or use SSH to remotely control the second host.
>>>
>>> In the single host case, the script just needs to be passed two
>>> arguments: a PCI ID for each side of the link. In the two host case
>>> the -r option must be used to specify the remote hostname (which must
>>> be SSH accessible and should probably have ssh-keys exchanged).
>>
>> I appreciate the work that you are putting in here, but test shell
>> scripts are not accepted into the kernel source.

Yeah, I wasn't aware of this rule. I previously did some work on a very
similar shell script for NVM fabrics. Though that hasn't made it to
upstream yet.

> I don't see any reason for this script to be not part of kernel selftests.
> I think it will be a good addition. We probably don't want to include it in
> the auto run of the selftest suite.
> Jon! I you would like to take this script through your ntb tree, here is
> my ack for the script for kselftest part.
> 
> Acked-by: Shuah Khan <shuahkh@osg.samsung.com>
> 

Thanks Shauh!

>> I think a better place for this to be shared would be on the github
>> account wiki, https://github.com/jonmason/ntb/wiki
>> In fact, I'd really like for someone to add some pages there on using
>> the ntb tools and testing.  If you are willing, I'd be most
>> appreciative.

I can probably make some time for this later in the week.


Logan

