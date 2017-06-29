Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id c18si432157itb.2.2017.06.29.11.37.59
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Jun 2017 11:37:59 -0700 (PDT)
References: <20170629032648.3073-1-logang@deltatee.com>
 <20170629032648.3073-13-logang@deltatee.com>
 <000201d2f103$2f3d2d20$8db78760$@dell.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <9a280b29-4e1b-cf4a-54c2-25a522834879@deltatee.com>
Date: Thu, 29 Jun 2017 12:37:46 -0600
MIME-Version: 1.0
In-Reply-To: <000201d2f103$2f3d2d20$8db78760$@dell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 12/16] switchtec_ntb: add link management
To: Allen Hubbe <Allen.Hubbe@dell.com>, linux-ntb@googlegroups.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: 'Jon Mason' <jdmason@kudzu.us>, 'Dave Jiang' <dave.jiang@intel.com>, 'Bjorn Helgaas' <bhelgaas@google.com>, 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>, 'Kurt Schwemmer' <kurt.schwemmer@microsemi.com>, 'Stephen Bates' <sbates@raithlin.com>, 'Serge Semin' <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

On 6/29/2017 12:11 PM, Allen Hubbe wrote:

> Should we only set self_partition?  I think each peer should be able to set preferred speed, and negotiate down.  As written here, the last peer to set the speed overrides the setting on the peer, and even that is not atomic if they race.

This function isn't actually setting the link speed. (Though I can 
understand the confusion from the name.) It's just reporting the slowest 
speed on the link between the peers for the link_is_up function. (Each 
port will have negotiated it's own speed).

I don't think switchtec has the ability to actually change the port 
speed or width. (Seeing they are negotiated on boot).

Logan
