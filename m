Return-Path: <jdmason@kudzu.us>
Received: from mail-vk0-x22b.google.com (mail-vk0-x22b.google.com. [2607:f8b0:400c:c05::22b])
        by gmr-mx.google.com with ESMTPS id i133si59160pgd.1.2017.12.05.10.51.12
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Dec 2017 10:51:12 -0800 (PST)
Received: by mail-vk0-x22b.google.com with SMTP id u84so937246vke.10
        for <linux-ntb@googlegroups.com>; Tue, 05 Dec 2017 10:51:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5A263AA7.7040109@deltatee.com>
References: <20171204175721.10322-1-logang@deltatee.com> <CAJQW-Q6DXi4ipyc_cKfa=HYAqcu1sstJXU1mJmqvWH1c1aGePA@mail.gmail.com>
 <0f0a4d34-ed0b-99cf-8f7d-d47e62235a3b@deltatee.com> <CAJQW-Q733PvoghsDMiRwp7w34h+oXVwxr_g45Z-_Wu4=NQCMuA@mail.gmail.com>
 <b02bdb42-d7fe-32dd-a591-bff7d882b97c@deltatee.com> <CAJQW-Q5p2aY2Bahx49MG24HeYvGVmW-dDBJ_aHLAqjVKGS-zpQ@mail.gmail.com>
 <5A263AA7.7040109@deltatee.com>
From: Jon Mason <jdmason@kudzu.us>
Date: Tue, 5 Dec 2017 13:51:12 -0500
Message-ID: <CAPoiz9zEv89YfC84wt5bqsqEFtdDnp9VnAtbktni0H-1fyS9OQ@mail.gmail.com>
Subject: Re: [PATCH v2] ntb_hw_switchtec: Force down the link before initializing
Content-Type: text/plain; charset="UTF-8"
To: Logan Gunthorpe <logang@deltatee.com>
Cc: ThanhTuThai <cruisethai@gmail.com>, linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

On Tue, Dec 5, 2017 at 1:20 AM, Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
> On 2017-12-04 10:12 PM, ThanhTuThai wrote:
>>
>> Dear Logan,
>>
>> The log message I mentioned on the previous mail is dmesg.
>> But I believe that it has nothing to do with the some early mail I sent,
>> I already described the issue.
>>
>> I saw your solution for soft-reset work perfectly. So I think we can
>> merge it.
>
>
> @Jon, can you please merge v1 of my original patch as it seems to fix most
> of the problem. Let me know if you need me to resend it. It's probably worth
> pushing upstream before 4.15 is released too.

I'll pull it into my ntb branch.

ThanhTuThai, if you can determine a way to fix the link issue, please
send a patch to the list.  If you need assistance with this, please
send full dmesg output and other details Logan requested and we'll see
what we (as a community) can do.

Thanks,
Jon

>
> Thanks,
>
> Logan
