Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id e3-v6si1174572qkm.1.2018.05.22.09.56.54
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 May 2018 09:56:55 -0700 (PDT)
References: <6717325ea580df9a0294db6f83fd72a5db3daad9.1520591515.git.arvind.yadav.cs@gmail.com>
 <20180522004846.GC3255@kudzu.us>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <dd99c6f7-1a3c-e8d5-6333-e8c9c062c073@deltatee.com>
Date: Tue, 22 May 2018 10:56:51 -0600
MIME-Version: 1.0
In-Reply-To: <20180522004846.GC3255@kudzu.us>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ntb_transport: use put_device() instead of kfree()
To: Jon Mason <jdmason@kudzu.us>, Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: dave.jiang@intel.com, allenbh@gmail.com, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>



On 21/05/18 06:48 PM, Jon Mason wrote:
> On Fri, Mar 09, 2018 at 04:03:24PM +0530, Arvind Yadav wrote:
>> Never directly free @dev after calling device_register(), even
>> if it returned an error! Always use put_device() to give up the
>> reference initialized.
>>
>> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
>> ---
>>  drivers/ntb/ntb_transport.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
>> index 9878c48..8182a3a 100644
>> --- a/drivers/ntb/ntb_transport.c
>> +++ b/drivers/ntb/ntb_transport.c
>> @@ -393,7 +393,7 @@ int ntb_transport_register_client_dev(char *device_name)
>>  
>>  		rc = device_register(dev);
>>  		if (rc) {
>> -			kfree(client_dev);
>> +			put_device(dev);
> 
> Now we are leaking client_dev, which is bigger than just dev.  I think
> we are going to need both now.

No, when put_device is called, ntb_transport_client_release() will be
called which then kfree's the structure there. This is the preferred way
of freeing anything that's reference counted (as all struct devices
are). See [1].

Though, if I remember correctly, the NTB tree breaks this rule a lot.
ie. the fact that ntb_dev_release() doesn't actually free the underlying
structure has always irked me a bit because it forces the calling
drivers to break this rule. This means the reference counting on the NTB
devices is broken so if someone ever uses get_device() on an struct
ntb_dev and doesn't put it back before the driver is unbound, there will
be a use after free bug. As far as I know though, at this time this
isn't done.

Logan


[1]
https://elixir.bootlin.com/linux/v4.17-rc6/source/drivers/base/core.c#L1931
