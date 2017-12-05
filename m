Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id a21si888524pgw.5.2017.12.04.22.20.27
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Dec 2017 22:20:27 -0800 (PST)
Message-ID: <5A263AA7.7040109@deltatee.com>
Date: Mon, 04 Dec 2017 23:20:23 -0700
From: Logan Gunthorpe <logang@deltatee.com>
MIME-Version: 1.0
References: <20171204175721.10322-1-logang@deltatee.com> <CAJQW-Q6DXi4ipyc_cKfa=HYAqcu1sstJXU1mJmqvWH1c1aGePA@mail.gmail.com> <0f0a4d34-ed0b-99cf-8f7d-d47e62235a3b@deltatee.com> <CAJQW-Q733PvoghsDMiRwp7w34h+oXVwxr_g45Z-_Wu4=NQCMuA@mail.gmail.com> <b02bdb42-d7fe-32dd-a591-bff7d882b97c@deltatee.com> <CAJQW-Q5p2aY2Bahx49MG24HeYvGVmW-dDBJ_aHLAqjVKGS-zpQ@mail.gmail.com>
In-Reply-To: <CAJQW-Q5p2aY2Bahx49MG24HeYvGVmW-dDBJ_aHLAqjVKGS-zpQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] ntb_hw_switchtec: Force down the link before initializing
To: Jon Mason <jdmason@kudzu.us>
Cc: ThanhTuThai <cruisethai@gmail.com>, linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>



On 2017-12-04 10:12 PM, ThanhTuThai wrote:
> Dear Logan,
>
> The log message I mentioned on the previous mail is dmesg.
> But I believe that it has nothing to do with the some early mail I sent,
> I already described the issue.
>
> I saw your solution for soft-reset work perfectly. So I think we can
> merge it.

@Jon, can you please merge v1 of my original patch as it seems to fix 
most of the problem. Let me know if you need me to resend it. It's 
probably worth pushing upstream before 4.15 is released too.

Thanks,

Logan
