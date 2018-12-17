Return-Path: <dave.jiang@intel.com>
Received: from mga18.intel.com (mga18.intel.com. [134.134.136.126])
        by gmr-mx.google.com with ESMTPS id j26si606396uag.1.2018.12.17.08.25.30
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 08:25:30 -0800 (PST)
Subject: Re: NTB - Intel Cache Flush Mechanism
References: <8C51E45097385D46B526390C84E223A34EEA68A6@MX202CL01.corp.emc.com>
From: Dave Jiang <dave.jiang@intel.com>
Message-ID: <868a7307-bd96-112d-f190-8622cf9df9c1@intel.com>
Date: Mon, 17 Dec 2018 09:25:28 -0700
MIME-Version: 1.0
In-Reply-To: <8C51E45097385D46B526390C84E223A34EEA68A6@MX202CL01.corp.emc.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
To: "Margolin, Omer" <Omer.Margolin@dell.com>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>
Cc: "Zekri, Ishay" <Ishay.Zekri@dell.com>, "Glimcher, Boris" <Boris.Glimcher@dell.com>
List-ID: <linux-ntb.googlegroups.com>

I don't believe that exists any longer since C5500 generation of the
processor.

On 12/17/18 12:45 AM, Margolin, Omer wrote:
> Hi Dave,
> 
>  
> 
> We would like to use Intel’s cache flush mechanism on Skylake processor.
> 
> The WCCNTRL is only found in ntb
> <https://github.com/torvalds/linux/tree/6f0d349d922ba44e4348a17a78ea51b7135965b1/drivers/ntb>/hw
> <https://github.com/torvalds/linux/tree/6f0d349d922ba44e4348a17a78ea51b7135965b1/drivers/ntb/hw>/intel
> <https://github.com/torvalds/linux/tree/6f0d349d922ba44e4348a17a78ea51b7135965b1/drivers/ntb/hw/intel>/*ntb_hw_gen1.h*: 
> #define XEON_WCCNTRL_OFFSET                             0x00e0
> 
> Is this register and mechanism implemented on gen3?
> 
>  
> 
> From Intel® Xeon® Processor C5500/C3500 Series Non-Transparent Bridge
> (Document Number: 323328-001):
> 
>  
> 
> Thanks,
> 
>  
> 
> *Omer Margolin | Hardware Engineer | XtremIO/EMC²*
> 
> *Mobile: +972 54 4660539 | Office: +972 72 2563334*
> 
> *Address: Kibbutz Glil-Yam, Herzelia 4690500, Israel*
> 
> *Email: omer.margolin@emc.com <mailto:omer.margolin@emc.com>*
> 
> XtremIO_EMC
> 
>  
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
> https://groups.google.com/d/msgid/linux-ntb/8C51E45097385D46B526390C84E223A34EEA68A6%40MX202CL01.corp.emc.com
> <https://groups.google.com/d/msgid/linux-ntb/8C51E45097385D46B526390C84E223A34EEA68A6%40MX202CL01.corp.emc.com?utm_medium=email&utm_source=footer>.
> For more options, visit https://groups.google.com/d/optout.
