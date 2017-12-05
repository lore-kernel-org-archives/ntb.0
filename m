Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id l22si673004ita.2.2017.12.05.11.16.59
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Dec 2017 11:16:59 -0800 (PST)
References: <20171203191736.3399-1-fancer.lancer@gmail.com>
 <20171203191736.3399-6-fancer.lancer@gmail.com>
 <CAPoiz9yy8sMHTHzBYS3AJYArmnfQY-ntHrZa_m3G3-ALxa_QyA@mail.gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <aa4e3376-7113-9a7a-548c-be0ee685edb5@deltatee.com>
Date: Tue, 5 Dec 2017 12:16:57 -0700
MIME-Version: 1.0
In-Reply-To: <CAPoiz9yy8sMHTHzBYS3AJYArmnfQY-ntHrZa_m3G3-ALxa_QyA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 05/15] NTB: ntb_tool: Add full multi-port NTB API
 support
To: Jon Mason <jdmason@kudzu.us>, Serge Semin <fancer.lancer@gmail.com>
Cc: Dave Jiang <dave.jiang@intel.com>, "Hubbe, Allen" <Allen.Hubbe@emc.com>, "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>, "Yu, Xiangliang" <Xiangliang.Yu@amd.com>, Gary R Hook <gary.hook@amd.com>, Sergey.Semin@t-platforms.ru, linux-ntb <linux-ntb@googlegroups.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-ntb.googlegroups.com>



On 05/12/17 11:03 AM, Jon Mason wrote:
>> +static ssize_t tool_fn_read(struct tool_ctx *tc, char __user *ubuf,
>> +                           size_t size, loff_t *offp,
>> +                           u64 (*fn_read)(struct ntb_dev *))
>>   {
>>          size_t buf_size;
>> -       char *buf;
>> -       ssize_t pos, rc;
>> +       char buf[32];
> 
> I would think you would want the malloc like before, but if not then
> make this a #define and reference it as necessary throughout the code.

I disagree. Allocating a small 32-byte buf on the stack is a nice 
cleanup. I'm not sure what you are referring to about the #define.

Logan
