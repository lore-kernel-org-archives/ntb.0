Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id 125si119940itx.5.2017.06.29.13.17.18
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Jun 2017 13:17:18 -0700 (PDT)
References: <20170629032648.3073-1-logang@deltatee.com>
 <20170629032648.3073-7-logang@deltatee.com>
 <000301d2f103$3310ca60$99325f20$@dell.com>
 <079047c1-6612-2814-e147-844fabd56b75@deltatee.com>
 <000401d2f114$3499f2b0$9dcdd810$@dell.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <63c4b0fa-2f03-6313-2d60-c6dab53bc3a5@deltatee.com>
Date: Thu, 29 Jun 2017 14:17:02 -0600
MIME-Version: 1.0
In-Reply-To: <000401d2f114$3499f2b0$9dcdd810$@dell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 06/16] ntb: add check and comment for link up to mw_count
 and mw_get_align
To: Allen Hubbe <Allen.Hubbe@dell.com>, linux-ntb@googlegroups.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: 'Jon Mason' <jdmason@kudzu.us>, 'Dave Jiang' <dave.jiang@intel.com>, 'Bjorn Helgaas' <bhelgaas@google.com>, 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>, 'Kurt Schwemmer' <kurt.schwemmer@microsemi.com>, 'Stephen Bates' <sbates@raithlin.com>, 'Serge Semin' <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

On 6/29/2017 2:13 PM, Allen Hubbe wrote:
> Unfortunately, it is to work around hardware errata.  That is not so trivial to fix.

Can you describe more what the work around is doing? Can you share the 
code? It seems odd that a workaround is based on the alignment 
restrictions of the mws.

Logan
