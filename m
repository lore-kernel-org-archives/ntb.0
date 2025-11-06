Received: from mail.tkos.co.il (wiki.tkos.co.il [84.110.109.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A101C2BE03E
	for <ntb@lists.linux.dev>; Thu,  6 Nov 2025 06:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.110.109.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762408967; cv=none; b=YwjDJJoomNuw8qORimOtuhjnUuzh8d1Djp8Fq+I26Fu/qXJmayHNQMIqBVdtOLzW/PCeB9jE8CjOndbscFZEq970ZbmUzIVE7iv80y+5jYhwypNJ/zv9C/oVItw5GP6kg65nb+deHTvk2cfV7DNSAINSq+8NkPWOUeAj6q5fwCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762408967; c=relaxed/simple;
	bh=E5MdvMlO3IShRqOhyDQ8gs/OmWMOIWx6olGG+D7MP+Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XfMotmJ8oybqzsEjJikXjgwo1PsU/GuCW3hCZ7x+pUh0l8d8JTPhOr30R0/BK0gT+Y8uxRnNeq6tYRZN4iVQ375sgmMlPxWu9T4+ssemEsm5ZQv0v3TbFl/3j1mBnIu4cyTH9LFdGkP59smD78tJ8IusYEhGHDYdkeWjGmESV4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il; spf=pass smtp.mailfrom=tkos.co.il; dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b=GwAnkK7f; arc=none smtp.client-ip=84.110.109.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="GwAnkK7f"
Received: from localhost (unknown [10.0.8.3])
	by mail.tkos.co.il (Postfix) with ESMTP id 493DB440F34;
	Thu,  6 Nov 2025 08:00:59 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1762408859;
	bh=E5MdvMlO3IShRqOhyDQ8gs/OmWMOIWx6olGG+D7MP+Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=GwAnkK7fY8GwfivvtESRULdU25Ai+lZKJBHiiv7nQjIXLmMSFa9Y+3qIXVP1vheil
	 kijrsJYLDMx+etwR122427tWkcIKkocyYHEvxED5m5cPfnEc8bAFoYsQ1nSB+APztL
	 J395zbK2O8iE/5/JKATUVzQQTgOqfRLaEpLI6Kr5QVxXgA0VsyOmhNwRJAcKcNs8+X
	 3bhHTNA8GC2ipU9KPq47Nlr2CEckKGeqbVu0ZzGyEaSggjO0YGlHj452zf9S3z3ubr
	 UmOtbxx+3PrZW8Cd2Z0GnNV4vMpK2tBnpD6M0xpnB19P80p+tdIMxzto9EIHr44fdr
	 BsTzjcxPbLZQg==
From: Baruch Siach <baruch@tkos.co.il>
To: Koichiro Den <den@valinux.co.jp>
Cc: Jon Mason <jdmason@kudzu.us>,  Dave Jiang <dave.jiang@intel.com>,  Allen
 Hubbe <allenbh@gmail.com>,  ntb@lists.linux.dev
Subject: Re: [PATCH] NTB: ntb_transport: fix use after free
In-Reply-To: <6esry3tk3b5aslp2acp2qvnxcorzznza6ehdqmcyyqaoc4mm43@kgyhhva2mpkg>
	(Koichiro Den's message of "Thu, 6 Nov 2025 12:59:21 +0900")
References: <c4727cd0bdeb8385b893da59c5eb97a189bf4282.1762190599.git.baruch@tkos.co.il>
	<y23vpg5ynutkwck3w6wynsy47yovpqywil2jqk4omg63qdocjb@xkcvg6h3jy2d>
	<87v7jqs68y.fsf@tarshish>
	<6esry3tk3b5aslp2acp2qvnxcorzznza6ehdqmcyyqaoc4mm43@kgyhhva2mpkg>
User-Agent: mu4e 1.12.13; emacs 30.1
Date: Thu, 06 Nov 2025 08:02:34 +0200
Message-ID: <87zf8zr951.fsf@tarshish>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Hi Koichiro,

On Thu, Nov 06 2025, Koichiro Den wrote:
> On Tue, Nov 04, 2025 at 07:42:53AM +0200, Baruch Siach wrote:
>> Thanks for taking the time to review this.
>> 
>> On Tue, Nov 04 2025, Koichiro Den wrote:
>> > On Mon, Nov 03, 2025 at 07:23:19PM +0200, Baruch Siach wrote:
>> >> Don't call dmaengine_unmap_put() twice for the same pointer. This
>> >> results in mempool_free() being called on a freed element.
>> >
>> > While the second dmaengine_unmap_put() looks redundant at first glance, my
>> > understanding was that it compensates for the refcount decrement that would
>> > normally happen on the dmaengine completion path, which never occurs when
>> > dmaengine_submit() fails. Am I missing something?
>> 
>> I guess you are right. Now I see that dma_set_unmap() increments the
>> refcount. But I can't find the second refcount decrement in completion
>> path. I only see one call to dmaengine_unmap_put(). Can you enlighten
>> me?
>
> Apologies for the late response. The dma_descriptor_unmap() wrapper should
> handle that, shouldn't it?

Probably. The dmaengine driver I'm using is dw-axi-dmac, and I see no
call to dma_descriptor_unmap() there. Not sure where the bug is, but
it's definitely not in the NTB scope.

Thanks for your help. Sorry for the noise.

baruch

>> >> Fixes: 6f57fd0578df ("NTB: convert to dmaengine_unmap_data")
>> >> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
>> >> ---
>> >>  drivers/ntb/ntb_transport.c | 22 +++++++++-------------
>> >>  1 file changed, 9 insertions(+), 13 deletions(-)
>> >> 
>> >> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
>> >> index eb875e3db2e3..809fb09658b4 100644
>> >> --- a/drivers/ntb/ntb_transport.c
>> >> +++ b/drivers/ntb/ntb_transport.c
>> >> @@ -1573,14 +1573,14 @@ static int ntb_async_rx_submit(struct ntb_queue_entry *entry, void *offset)
>> >>  	unmap->addr[0] = dma_map_page(device->dev, virt_to_page(offset),
>> >>  				      pay_off, len, DMA_TO_DEVICE);
>> >>  	if (dma_mapping_error(device->dev, unmap->addr[0]))
>> >> -		goto err_get_unmap;
>> >> +		goto err_unmap;
>> >>  
>> >>  	unmap->to_cnt = 1;
>> >>  
>> >>  	unmap->addr[1] = dma_map_page(device->dev, virt_to_page(buf),
>> >>  				      buff_off, len, DMA_FROM_DEVICE);
>> >>  	if (dma_mapping_error(device->dev, unmap->addr[1]))
>> >> -		goto err_get_unmap;
>> >> +		goto err_unmap;
>> >>  
>> >>  	unmap->from_cnt = 1;
>> >>  
>> >> @@ -1588,7 +1588,7 @@ static int ntb_async_rx_submit(struct ntb_queue_entry *entry, void *offset)
>> >>  					     unmap->addr[0], len,
>> >>  					     DMA_PREP_INTERRUPT);
>> >>  	if (!txd)
>> >> -		goto err_get_unmap;
>> >> +		goto err_unmap;
>> >>  
>> >>  	txd->callback_result = ntb_rx_copy_callback;
>> >>  	txd->callback_param = entry;
>> >> @@ -1596,7 +1596,7 @@ static int ntb_async_rx_submit(struct ntb_queue_entry *entry, void *offset)
>> >>  
>> >>  	cookie = dmaengine_submit(txd);
>> >>  	if (dma_submit_error(cookie))
>> >> -		goto err_set_unmap;
>> >> +		goto err_unmap;
>> >>  
>> >>  	dmaengine_unmap_put(unmap);
>> >>  
>> >> @@ -1606,9 +1606,7 @@ static int ntb_async_rx_submit(struct ntb_queue_entry *entry, void *offset)
>> >>  
>> >>  	return 0;
>> >>  
>> >> -err_set_unmap:
>> >> -	dmaengine_unmap_put(unmap);
>> >> -err_get_unmap:
>> >> +err_unmap:
>> >>  	dmaengine_unmap_put(unmap);
>> >>  err:
>> >>  	return -ENXIO;
>> >> @@ -1854,14 +1852,14 @@ static int ntb_async_tx_submit(struct ntb_transport_qp *qp,
>> >>  	unmap->addr[0] = dma_map_page(device->dev, virt_to_page(buf),
>> >>  				      buff_off, len, DMA_TO_DEVICE);
>> >>  	if (dma_mapping_error(device->dev, unmap->addr[0]))
>> >> -		goto err_get_unmap;
>> >> +		goto err_unmap;
>> >>  
>> >>  	unmap->to_cnt = 1;
>> >>  
>> >>  	txd = device->device_prep_dma_memcpy(chan, dest, unmap->addr[0], len,
>> >>  					     DMA_PREP_INTERRUPT);
>> >>  	if (!txd)
>> >> -		goto err_get_unmap;
>> >> +		goto err_unmap;
>> >>  
>> >>  	txd->callback_result = ntb_tx_copy_callback;
>> >>  	txd->callback_param = entry;
>> >> @@ -1869,16 +1867,14 @@ static int ntb_async_tx_submit(struct ntb_transport_qp *qp,
>> >>  
>> >>  	cookie = dmaengine_submit(txd);
>> >>  	if (dma_submit_error(cookie))
>> >> -		goto err_set_unmap;
>> >> +		goto err_unmap;
>> >>  
>> >>  	dmaengine_unmap_put(unmap);
>> >>  
>> >>  	dma_async_issue_pending(chan);
>> >>  
>> >>  	return 0;
>> >> -err_set_unmap:
>> >> -	dmaengine_unmap_put(unmap);
>> >> -err_get_unmap:
>> >> +err_unmap:
>> >>  	dmaengine_unmap_put(unmap);
>> >>  err:
>> >>  	return -ENXIO;
>> >> -- 
>> >> 2.51.0
>> >> 
>> 
>> -- 
>>                                                      ~. .~   Tk Open Systems
>> =}------------------------------------------------ooO--U--Ooo------------{=
>>    - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
