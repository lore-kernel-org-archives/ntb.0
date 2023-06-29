Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03831FBF1
	for <ntb@lists.linux.dev>; Thu, 29 Jun 2023 22:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:To:
	MIME-Version:Date:Message-ID:cc:content-disposition;
	bh=OUoLPWXUItPWjkTyk1pZtOdxtvzs5ehAATROs3RBMWs=; b=T7GDfMaRddsnHLiJF8LXy63lfF
	3aH0TnDpD+GhZ9hMxQe3iKr7pXAHmS8HOaXmpONJGgb2H0p6Eqi5t4zVaYDndT+1sWpS5RAvPWhWu
	xZ079GzGr3VeiBX2v5FNTLPDP39mN0alpyB2QNbDQQJjvG+vFiy22tOLEu5fLd4q5v76yG7VXvOPD
	VZN7uCvV3E+SZgySFTNezNmwzv2IjIVd7K9iZ7tGnptxh6nZueqGbja7IPGpjSYSEaXc8Dfqykc1c
	7F4ocbPytE2Y/HzM9p4YuVmbg0LcoHh0NB0eN3HQHIlJiZflOW+TUYT8DTnSsp1np4b8ySU5bme6H
	mR1COQ9g==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <logang@deltatee.com>)
	id 1qEzGl-005dH7-1N; Thu, 29 Jun 2023 15:33:39 -0600
Message-ID: <c3a44437-e4e5-4453-2fe1-e86b589f5372@deltatee.com>
Date: Thu, 29 Jun 2023 15:33:37 -0600
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-CA
To: Geoff Levand <geoff@infradead.org>, ntb@lists.linux.dev,
 Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
 Allen Hubbe <allenbh@gmail.com>
References: <3102d6f5287c58ca417c616b5631a343b62dfe74.1688071716.git.geoff@infradead.org>
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <3102d6f5287c58ca417c616b5631a343b62dfe74.1688071716.git.geoff@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: geoff@infradead.org, ntb@lists.linux.dev, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=5.0 tests=ALL_TRUSTED,BAYES_00,
	NICE_REPLY_A,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
Subject: Re: [PATCH v1 1/1] ntb.rst: Fix copy and paste error
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2023-06-29 14:51, Geoff Levand wrote:
> It seems the text for the NTB MSI Test Client section was copied from the
> NTB Tool Test Client, but was not updated for the new section.  Corrects
> the NTB MSI Test Client section text.
> 
> Fixes: bec5545edef6 ("Merge tag 'ntb-5.3' of git://github.com/jonmason/ntb")
> Signed-off-by: Geoff Levand <geoff@infradead.org> for Sony Interactive Entertainment


Looks good to me, thanks.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Logan
