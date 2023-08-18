Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3C61AA8A
	for <ntb@lists.linux.dev>; Fri, 18 Aug 2023 18:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=vDSJRNpNnS7N5ZQbCKJsuXiMKKbdfYD4dQkej2dk2NA=; b=W3C6LHUC9vMCcgg0CrMENEvhnf
	UnXbmRl0VccvHrsZTWyPiI8lGta4WdXYzMzR8ipRhQmqaSBPq4ecAmps1vFd2xZQ9QJqRxKaCHfsn
	iQiiJAD1XhyO5kHa5Vaik4Nd1vf05FjENxfWXe42DA1/1fxIbl4YBhLFwMBrr24r/FrMIAHBE+Mfr
	fd7rA5XJCkvttIPCUsQXz9XoObqNOdPd/7h9spJfS40YNUDYaf1+1Hgmaz/PEaid+/xP5JfwRZcLn
	YlT0+D/+C5fMdfA6q8RQWqDIAJBOOFPTWAWfY59+5flKFGpCXuVRLz3Ic5xyj7FgUz4DHL/j/RCqq
	J4RgF6jA==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <logang@deltatee.com>)
	id 1qX3wg-00Ezkf-2S; Fri, 18 Aug 2023 12:11:38 -0600
Message-ID: <0dee7234-6a4c-751c-01fb-db9b6427bd01@deltatee.com>
Date: Fri, 18 Aug 2023 12:11:35 -0600
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-CA
To: Dave Jiang <dave.jiang@intel.com>, jdmason@kudzu.us, allenbh@gmail.com
Cc: renlonglong <ren.longlong@h3c.com>, Yuan Y Lu <yuan.y.lu@intel.com>,
 ntb@lists.linux.dev
References: <169238013566.3961033.4879718723608456809.stgit@djiang5-mobl3>
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <169238013566.3961033.4879718723608456809.stgit@djiang5-mobl3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: dave.jiang@intel.com, jdmason@kudzu.us, allenbh@gmail.com, ren.longlong@h3c.com, yuan.y.lu@intel.com, ntb@lists.linux.dev
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=5.0 tests=ALL_TRUSTED,BAYES_00,
	MYRULES_FREE,NICE_REPLY_A autolearn=ham autolearn_force=no
	version=3.4.6
Subject: Re: [PATCH 0/4] ntb: ntb_transport fixes from link up/down testing
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2023-08-18 11:37, Dave Jiang wrote:
> Several ntb_transport fixes after doing long term continous netdev up/down
> testing.
> 
> ---
> 
> Dave Jiang (4):
>       ntb: Clean up tx tail index on link down
>       ntb: Drop packets when qp link is down
>       ntb: Fix calculation ntb_transport_tx_free_entry()
>       ntb: Check tx descriptors outstanding instead of head/tail for tx queue
> 

All four patches look good to me, thanks.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Logan
