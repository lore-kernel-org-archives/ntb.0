Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id b19si127174vkf.3.2019.03.06.13.36.05
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 13:36:05 -0800 (PST)
References: <20190213175454.7506-1-logang@deltatee.com>
 <20190213175454.7506-10-logang@deltatee.com>
 <20190306202631.3vc3b64e45ackcna@mobilestation>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <5b420eb7-5010-aae3-e9bd-1c612af409ae@deltatee.com>
Date: Wed, 6 Mar 2019 14:35:53 -0700
MIME-Version: 1.0
In-Reply-To: <20190306202631.3vc3b64e45ackcna@mobilestation>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 09/12] NTB: Introduce MSI library
To: Serge Semin <fancer.lancer@gmail.com>, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Bjorn Helgaas <bhelgaas@google.com>, Joerg Roedel <joro@8bytes.org>, Allen Hubbe <allenbh@gmail.com>, Dave Jiang <dave.jiang@intel.com>, Eric Pilmore <epilmore@gigaio.com>
List-ID: <linux-ntb.googlegroups.com>



On 2019-03-06 1:26 p.m., Serge Semin wrote:
> First of all, It might be unsafe to have some resources consumed by NTB
> MSI or some other library without a simple way to warn NTB client drivers
> about their attempts to access that resources, since it might lead to random
> errors. When I thought about implementing a transport library based on the
> Message/Spad+Doorbell registers, I had in mind to create an internal bits-field
> array with the resources busy-flags. If, for instance, some message or
> scratchpad register is occupied by the library (MSI, transport or some else),
> then it would be impossible to access these resources directly through NTB API
> methods. So NTB client driver shall retrieve an error in an attempt to
> write/read data to/from busy message or scratchpad register, or in an attempt
> to set some occupied doorbell bit. The same thing can be done for memory windows.

Yes, it would be nice to have a generic library to manage all the
resources, but right now we don't and it's unfair to expect us to take
on this work to get the features we care about merged. Right now, it's
not at all unsafe as the client is quite capable of ensuring it has the
resources for the MSI library. The changes for ntb_transport to ensure
this are quite reasonable.

> Second tiny concern is about documentation. Since there is a special file for
> all NTB-related doc, it would be good to have some description about the
> NTB MSI library there as well:
> Documentation/ntb.txt

Sure, I'll add a short blurb for v3. Though, I noticed it's quite out of
date since your changes. Especially in the ntb_tool section...

>> +	u32 *peer_mws[];
> 
> Shouldn't we use the __iomem attribute here since later the devm_ioremap() is
> used to map MWs at these pointers?

Yes, will change for v3.


> Simpler and faster cleanup-code would be:

> + unroll:
> + 	for (--i; i >= 0; --i)
> + 		devm_iounmap(&ntb->dev, ntb->msi->peer_mws[i]);

Faster, maybe, but I would not consider this simpler. It's much more
complicated to reason about and ensure it's correct. I prefer my way
because I don't care about speed, but I do care about readability.


> Alas calling the ntb_mw_set_trans() method isn't enough to fully initialize
> NTB Memory Windows. Yes, the library will work for Intel/AMD/Switchtec
> (two-ports legacy configuration), but will fail for IDT due to being based on
> the outbound MW xlat interface. So the library at this stage isn't portable
> across all NTB hardware. In order to make it working the translation address is
> supposed to be transferred to the peer side, where a peer code should call
> ntb_peer_mw_set_trans() method with the retrieved xlat address.
> See documentation for details:

> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/Documentation/ntb.txt
> 
> ntb_perf driver can be also used as a reference of the portable NTB MWs setup.

Gross. Well, given that ntb_transport doesn't even support this and we
don't really have a sensible library to transfer this information, I'm
going to leave it as is for now. Someone can update ntb_msi when they
update ntb_transport, preferably after we have a nice library to handle
the transfers for us seeing I absolutely do not want to replicate the
mess in ntb_perf.

Actually, if we had a generic spad/msg communication library, it would
probably be better to have a common ntb_mw_set_trans() function that
uses the communications library to send the data and automatically call
ntb_peer_mw_set_trans() on the peer. That way we don't have to push this
mess into the clients.

> The same cleanup pattern can be utilized here:
> +error_out:
> +	for (--peer; peer >= 0; --peer) {
> +		peer_widx = ntb_peer_highest_mw_idx(ntb, peer);
> +		ntb_mw_clear_trans(ntb, i, peer_widx);
> +	}
> 
> So you won't need "i" variable here anymore. You also don't need to check the
> return value of ntb_peer_highest_mw_idx() in the cleanup loop because it
> was already checked in the main algo code.

See above.

>> +EXPORT_SYMBOL(ntb_msi_clear_mws);
>> +
> 
> Similarly something like ntb_msi_peer_clear_mws() should be added to
> unset a translation address on the peer side.

Well, we can table that for when ntb_msi supports the peer MW setting
functions.
>> +int ntb_msi_peer_trigger(struct ntb_dev *ntb, int peer,
>> +			 struct ntb_msi_desc *desc)
>> +{
>> +	int idx;
>> +
>> +	if (!ntb->msi)
>> +		return -EINVAL;
>> +
>> +	idx = desc->addr_offset / sizeof(*ntb->msi->peer_mws[peer]);
>> +
>> +	ntb->msi->peer_mws[peer][idx] = desc->data;
>> +
> 
> Shouldn't we use iowrite32() here instead of direct access to the IO-memory?

Yes, as above I'll fix it for v3.

>> @@ -425,6 +427,10 @@ struct ntb_dev {
>>  	spinlock_t			ctx_lock;
>>  	/* block unregister until device is fully released */
>>  	struct completion		released;
>> +
>> +	#ifdef CONFIG_NTB_MSI
>> +	struct ntb_msi *msi;
>> +	#endif
> 
> I'd align the macro-condition to the most left position:
> +#ifdef CONFIG_NTB_MSI
> +	struct ntb_msi *msi;
> +#endif

Fixed for v3.


Logan
