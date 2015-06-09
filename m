Return-Path: <bhelgaas@google.com>
Received: from mail-ie0-x22f.google.com (mail-ie0-x22f.google.com. [2607:f8b0:4001:c03::22f])
        by gmr-mx.google.com with ESMTPS id x12si219758igx.1.2015.06.09.09.16.41
        for <linux-ntb@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2015 09:16:41 -0700 (PDT)
Received: by mail-ie0-x22f.google.com with SMTP id gx4so17707108ieb.0
        for <linux-ntb@googlegroups.com>; Tue, 09 Jun 2015 09:16:41 -0700 (PDT)
Return-Path: <bhelgaas@google.com>
Date: Tue, 9 Jun 2015 11:16:37 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v3 01/18] NTB: Move files in preparation for NTB
 abstraction
Message-ID: <20150609161637.GB23119@google.com>
References: <cover.1433838377.git.Allen.Hubbe@emc.com>
 <8b1fb23f83098cf14b39a898a638394e52e91473.1433838377.git.Allen.Hubbe@emc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b1fb23f83098cf14b39a898a638394e52e91473.1433838377.git.Allen.Hubbe@emc.com>
To: Allen Hubbe <Allen.Hubbe@emc.com>
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>
List-ID: <linux-ntb.googlegroups.com>

On Tue, Jun 09, 2015 at 05:44:28AM -0400, Allen Hubbe wrote:
> This patch only serves the purpose to move files to their new locations,

s/only serves the purpose to move/moves/

> before applying the next patch adding the NTB Abstraction layer.
> Splitting this patch from the next is intended make distinct the which

s/the which/which/

> code is changed only due to moving the files, versus which are
> substantial code changes in adding the NTB Abstraction layer.
