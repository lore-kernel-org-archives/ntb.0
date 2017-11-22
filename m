Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0037.hostedemail.com. [216.40.44.37])
        by gmr-mx.google.com with ESMTPS id q34si1050283qtg.2.2017.11.22.11.21.28
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Nov 2017 11:21:28 -0800 (PST)
Message-ID: <1511378484.6989.104.camel@perches.com>
Subject: Re: [PATCH] NTB: switchtec_ntb: fix spelling mistake: "peforming"
 -> "performing"
From: Joe Perches <joe@perches.com>
Date: Wed, 22 Nov 2017 11:21:24 -0800
In-Reply-To: <b499bccf-fbac-cab6-f9d2-2edecfac2330@deltatee.com>
References: <20171121225945.29377-1-colin.king@canonical.com>
	 <1511320389.6989.44.camel@perches.com>
	 <b499bccf-fbac-cab6-f9d2-2edecfac2330@deltatee.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: Logan Gunthorpe <logang@deltatee.com>, Colin King <colin.king@canonical.com>, Kurt Schwemmer <kurt.schwemmer@microsemi.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>, linux-pci@vger.kernel.org, linux-ntb@googlegroups.com
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

On Wed, 2017-11-22 at 11:53 -0700, Logan Gunthorpe wrote:
> 
> On 21/11/17 08:13 PM, Joe Perches wrote:
> > probably nicer to add the missing newlines too.
> 
> Oh, my mistake.
> 
> I was never sure what was correct so I think I've been pretty lax about 
> that. I'll clean that up.
> 
> Seems like something that should be added to checkpatch. I may attempt a 
> patch for that.

Good luck but I think that's fairly difficult to do
well without too high a ratio of false-positives.

