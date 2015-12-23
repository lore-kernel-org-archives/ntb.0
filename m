Return-Path: <BATV+aaee6c6780d0c0bb5d73+4504+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org. [2001:1868:205::9])
        by gmr-mx.google.com with ESMTPS id q192si1757853pfq.2.2015.12.23.01.29.08
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Dec 2015 01:29:08 -0800 (PST)
Date: Wed, 23 Dec 2015 01:29:04 -0800
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH V2 1/3] NTB: Add AMD PCI-Express NTB driver
Message-ID: <20151223092904.GA31797@infradead.org>
References: <1450878175-9300-1-git-send-email-Xiangliang.Yu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1450878175-9300-1-git-send-email-Xiangliang.Yu@amd.com>
To: Xiangliang Yu <Xiangliang.Yu@amd.com>
Cc: jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, SPG_Linux_Kernel@amd.com
List-ID: <linux-ntb.googlegroups.com>

Just curious, what do you actually use NTB for?  Seems like we're
adding a giant subsystem without actual consumers, or did I miss
something?
