Return-Path: <jdmason@kudzu.us>
Received: from mail-wm0-x236.google.com (mail-wm0-x236.google.com. [2a00:1450:400c:c09::236])
        by gmr-mx.google.com with ESMTPS id 185si114491wmn.0.2016.01.08.07.01.05
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jan 2016 07:01:05 -0800 (PST)
Received: by mail-wm0-x236.google.com with SMTP id f206so139070297wmf.0
        for <linux-ntb@googlegroups.com>; Fri, 08 Jan 2016 07:01:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <BLUPR12MB0420841C92C2D403A12EA4CFEBF50@BLUPR12MB0420.namprd12.prod.outlook.com>
References: <1450878175-9300-1-git-send-email-Xiangliang.Yu@amd.com>
	<CAPoiz9znO1QT9Fphtmf4Wp2Tkvm1H-thy2=SrPi_dT9uQ4HoMQ@mail.gmail.com>
	<BLUPR12MB0420841C92C2D403A12EA4CFEBF50@BLUPR12MB0420.namprd12.prod.outlook.com>
Date: Fri, 8 Jan 2016 10:01:05 -0500
Message-ID: <CAPoiz9zqbgTvTA7hgKEQQGAuCbodH3D3dwmvNwkzRQPM1GA=aw@mail.gmail.com>
Subject: Re: [PATCH V2 1/3] NTB: Add AMD PCI-Express NTB driver
From: Jon Mason <jdmason@kudzu.us>
Content-Type: text/plain; charset=UTF-8
To: "Yu, Xiangliang" <Xiangliang.Yu@amd.com>
Cc: Dave Jiang <dave.jiang@intel.com>, "Hubbe, Allen" <Allen.Hubbe@emc.com>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>, linux-kernel <linux-kernel@vger.kernel.org>, SPG_Linux_Kernel <SPG_Linux_Kernel@amd.com>
List-ID: <linux-ntb.googlegroups.com>

On Wed, Jan 6, 2016 at 9:50 PM, Yu, Xiangliang <Xiangliang.Yu@amd.com> wrote:
>> > +
>> > +#define        PCI_DEVICE_ID_AMD_NTB   0x145B
>>
>> This looks like a tab and not a space
>
> I'll update it.
>
>>
>> > +#define AMD_LINK_HB_TIMEOUT    msecs_to_jiffies(1000)
>> > +#define AMD_LINK_STATUS_OFFSET 0x68
>> > +#define NTB_LIN_STA_ACTIVE_BIT 0x00000002
>> > +#define NTB_LNK_STA_SPEED_MASK 0x000F0000
>> > +#define NTB_LNK_STA_WIDTH_MASK 0x03F00000
>> > +#define NTB_LNK_STA_ACTIVE(x)  (!!((x) & NTB_LIN_STA_ACTIVE_BIT))
>> > +#define NTB_LNK_STA_SPEED(x)   (((x) & NTB_LNK_STA_SPEED_MASK) >>
>> 16)
>> > +#define NTB_LNK_STA_WIDTH(x)   (((x) &
>> NTB_LNK_STA_WIDTH_MASK) >> 20)
>> > +
>> > +#ifndef ioread64
>> > +#ifdef readq
>> > +#define ioread64 readq
>> > +#else
>> > +#define ioread64 _ioread64
>> > +static inline u64 _ioread64(void __iomem *mmio)
>> > +{
>> > +       u64 low, high;
>> > +
>> > +       low = ioread32(mmio);
>> > +       high = ioread32(mmio + sizeof(u32));
>> > +       return low | (high << 32);
>> > +}
>> > +#endif
>> > +#endif
>> > +
>> > +#ifndef iowrite64
>> > +#ifdef writeq
>> > +#define iowrite64 writeq
>> > +#else
>> > +#define iowrite64 _iowrite64
>> > +static inline void _iowrite64(u64 val, void __iomem *mmio)
>> > +{
>> > +       iowrite32(val, mmio);
>> > +       iowrite32(val >> 32, mmio + sizeof(u32));
>> > +}
>> > +#endif
>> > +#endif
>> >
>
> How about put ioread64/iowrite64 macro into ntb.h file? So low level driver can avoid to define these macro.
>
>> > +#define NTB_READ_REG(base, r) (ioread32(base + AMD_ ## r ##
>> _OFFSET))
>> > +#define NTB_WRITE_REG(base, val, r) (iowrite32(val, base +     \
>> > +                                               AMD_ ## r ## _OFFSET))
>> > +#define NTB_READ_OFFSET(base, r, of) (ioread32(base + of +             \
>> > +                                               AMD_ ## r ## _OFFSET))
>> > +#define NTB_WRITE_OFFSET(base, val, r, of) (iowrite32(val, base +      \
>> > +                                               of + AMD_ ## r ## _OFFSET))
>>
>> Please do not use marcos to hide ioread/iowrite.  Call iorwad/iowrite directly.
>
> I don't see any wrong to hide ioread/iowrite, and I think the macros can make code readable and easy to maintain.

I disagree.  It is an unnecessary layer and can add to confusion.
Please make the change.
