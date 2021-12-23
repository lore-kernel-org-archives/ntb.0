Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [204.191.154.188])
        by gmr-mx.google.com with ESMTPS id l22si246616ooe.0.2021.12.22.16.50.49
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 16:50:49 -0800 (PST)
References: <20211223004802.18184-1-rdunlap@infradead.org>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <db287ffb-0599-6d5a-bf03-fbaad19377ba@deltatee.com>
Date: Wed, 22 Dec 2021 17:50:45 -0700
MIME-Version: 1.0
In-Reply-To: <20211223004802.18184-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ntb_hw_switchtec: fix the spelling of "its"
To: Randy Dunlap <rdunlap@infradead.org>, linux-pci@vger.kernel.org
Cc: Kurt Schwemmer <kurt.schwemmer@microsemi.com>, linux-ntb <linux-ntb@googlegroups.com>, "jdmason@kudzu.us" <jdmason@kudzu.us>
List-ID: <linux-ntb.googlegroups.com>



On 2021-12-22 5:48 p.m., Randy Dunlap wrote:
> Use the possessive "its" instead of the contraction "it's" (it is)
> in user messages.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Kurt Schwemmer <kurt.schwemmer@microsemi.com>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> 

Oh, yup, thanks!

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Though this patch should have been sent to the NTB list as changes to
that file go through there. (I've cced that list and the maintainer Jon,
but the original patch might need a resend).

Logan

