Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id d207si280799itb.0.2017.06.16.12.17.41
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Jun 2017 12:17:41 -0700 (PDT)
References: <20170615203729.9009-1-logang@deltatee.com>
 <000001d2e6a7$dfc719a0$9f554ce0$@dell.com>
 <daa95888-a786-b6d4-5e56-b9ac5b38a181@deltatee.com>
 <000101d2e6b6$0fcc2880$2f647980$@dell.com>
 <6c2b819d-d000-38e2-29ee-d532f92909d2@deltatee.com>
 <000201d2e6cb$9f4f4e50$ddedeaf0$@dell.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <15f31689-bc66-81b3-9880-a8eeb9b1e9e7@deltatee.com>
Date: Fri, 16 Jun 2017 13:17:14 -0600
MIME-Version: 1.0
In-Reply-To: <000201d2e6cb$9f4f4e50$ddedeaf0$@dell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [RFC PATCH 00/13] Switchtec NTB Support
To: Allen Hubbe <Allen.Hubbe@dell.com>, linux-ntb@googlegroups.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: 'Jon Mason' <jdmason@kudzu.us>, 'Dave Jiang' <dave.jiang@intel.com>, 'Bjorn Helgaas' <bhelgaas@google.com>, 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>, 'Kurt Schwemmer' <kurt.schwemmer@microsemi.com>, 'Stephen Bates' <sbates@raithlin.com>, 'Serge Semin' <fancer.lancer@gmail.com>, Sergey.Semin@t-platforms.ru
List-ID: <linux-ntb.googlegroups.com>



On 16/06/17 12:08 PM, Allen Hubbe wrote:
> Alright.  I'll leave it to you to find and reconcile common functionalities of the drivers.  What about making spad emulation optional?

Ok.

I don't see the point of making spad emulation optional. Who would want
to disable it and what would be the benefit?

Logan
