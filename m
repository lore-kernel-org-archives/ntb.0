Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id c13si64173qth.1.2017.12.05.11.11.57
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Dec 2017 11:11:58 -0800 (PST)
References: <20171203191736.3399-1-fancer.lancer@gmail.com>
 <20171203191736.3399-2-fancer.lancer@gmail.com>
 <CAPoiz9xTRToABuuop77j7GcsLaZjYWD1Ght9kGc-Bo9A0w5ddw@mail.gmail.com>
 <20171205173154.GB1701@mobilestation>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <c86120cc-6144-f648-27b9-5865970449e4@deltatee.com>
Date: Tue, 5 Dec 2017 12:11:48 -0700
MIME-Version: 1.0
In-Reply-To: <20171205173154.GB1701@mobilestation>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 01/15] NTB: Rename NTB messaging API methods
To: Serge Semin <fancer.lancer@gmail.com>, Jon Mason <jdmason@kudzu.us>
Cc: Dave Jiang <dave.jiang@intel.com>, "Hubbe, Allen" <Allen.Hubbe@emc.com>, "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>, "Yu, Xiangliang" <Xiangliang.Yu@amd.com>, Gary R Hook <gary.hook@amd.com>, Sergey.Semin@t-platforms.ru, linux-ntb <linux-ntb@googlegroups.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-ntb.googlegroups.com>



On 05/12/17 10:31 AM, Serge Semin wrote:
>>> -static int idt_ntb_msg_read(struct ntb_dev *ntb, int midx, int *pidx, u32 *msg)
>>> +static u32 idt_ntb_msg_read(struct ntb_dev *ntb, int *pidx, int midx)
>>>   {
>>>          struct idt_ntb_dev *ndev = to_ndev_ntb(ntb);
>>>
>>>          if (midx < 0 || IDT_MSG_CNT <= midx)
>>> -               return -EINVAL;
>>> +               return (u32)-1;
>>
>> Please don't do this.  If this is an error return standard error
>> number.  And why are we casting to an unsigned int now?
>>
> 
> We discussed these changes on the v1 series. Additionally I asked similar
> question sometime ago even before the patchset was introduced.
> This patch is made to provide the Message interface similar to the Scratchpad
> one. I didn't introduce anything new or unjustified. As you can see the
> spad_read/peer_spad_read methods return u32 type too. As well as the
> Intel/AMD callbacks. The functions are intentionally made to return FFs
> in case if some of the passed arguments get out from the allowed limits.
> In such circumstances the return value emulates a situation like if user would
> reference an invalid PCIe MMIO address. Since the 32-bits register can in general
> have any value including -errno ones, then returning an error within the NTB API
> would be incorrect. I remember Allen described it this way.
> Nobody argued about it last time. If you think it's incorrect, then it should be
> changed in both Scratchpad and Message register interfaces.

I agree with Jon to not make this change. The original interface is 
better. Making the interface similar to spad_read() has no value 
especially seeing it makes it less correct. As you mention, *msg can be 
any value (even -1) so this restricts the values possible message values 
(making future potential hidden bugs) and removes error information 
(making debugging more difficult).

I haven't really looked into it but, if anything, it would make sense to 
make the spad_read function more like this one.

Logan
