Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B98E6469
	for <ntb@lists.linux.dev>; Wed,  9 Mar 2022 18:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=FPLOB6FTGoGu96mr3xM/jtQ0qDy2WNtJcKy/sGEN/Ik=; b=dY6tvPnVFCNrBpJ6GTR5BSUhXg
	B7pQ0/UCaWFLSTPaLdRMULn7NYcbRmXpTfv3KhGb3L03ycv5xv3ylt38r+YbGERhIlVPwOWvjb8zG
	i2cYXjM68SHzHT5zEiqrROzxGyOFDt6btOr2GrcTbCWvdJxcjnK8YoAHKzOQ2++P6Oggv1nxUk4La
	OoLVpkXqbKWMs34E9WCZWw3TtFq6Ymg7esFudGkmxc7o7zynGCXA79x/6VAmESRjW+7gqaF0CbmF1
	0qkA0EFEEPQdgMK1foWHY8ovNhsZbbVTe+/syKSgA5mTCiQBmwYA9dj0XsTm9SZXxcnjQzmGdAhOc
	RQrmon/A==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <logang@deltatee.com>)
	id 1nS15w-000u6L-Pq; Wed, 09 Mar 2022 11:31:34 -0700
Message-ID: <bec56b4f-1eb5-506b-2cca-7bd8bc8cbe37@deltatee.com>
Date: Wed, 9 Mar 2022 11:31:32 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-CA
To: Marc Smith <msmith626@gmail.com>
Cc: ntb@lists.linux.dev, Kelvin Cao <kelvin.cao@microchip.com>,
 kelvincao@outlook.com
References: <CAH6h+hfwRFMW47ONT+zC8Z1Y-30gb4dPEwTOtatN86EMeUajpA@mail.gmail.com>
 <1d53b232-dc0a-c7d3-69a1-8cb17ff83601@deltatee.com>
 <CAH6h+hdbOEjpU5tn+MwDm-h=47b4kzMHDZhSc51hA0VOZLp_8g@mail.gmail.com>
 <48234e72-3458-f90b-234d-f1ffccef996f@deltatee.com>
 <CAH6h+hd7o7fWFVmPSn86SrgnHC5X_jfdRtn1=dAF=8w8knJK1g@mail.gmail.com>
 <0c3b408a-80b2-992d-0a75-f76977dcb4e9@deltatee.com>
 <CAH6h+hfNWgXCguK7xtKCQOm9F_Xc-XCSwRyfrS5nQZGoh7PKFQ@mail.gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <CAH6h+hfNWgXCguK7xtKCQOm9F_Xc-XCSwRyfrS5nQZGoh7PKFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: msmith626@gmail.com, ntb@lists.linux.dev, kelvin.cao@microchip.com, kelvincao@outlook.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
	NICE_REPLY_A,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
Subject: Re: ntb_netdev Communication Failure Issue
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2022-03-09 11:26, Marc Smith wrote:
> On Wed, Mar 9, 2022 at 11:52 AM Logan Gunthorpe <logang@deltatee.com> wrote:
>>
>>
>>
>> On 2022-03-09 07:35, Marc Smith wrote:
>>> No difference between the two above, and actually, comparing the
>>> entire 4 MiB of GAS dump taken while working/functional versus broken
>>> state shows no differences:
>>> # cmp switchtec0_gas_dump_after_ifup_working.1 switchtec0_gas_dump_broken.1
>>
>> Well I'm stumped. It looks like the receive side is getting the
>> doorbell, but when it reads the memory window the done flag is not set,
>> so it doesn't process any packets. The transmit side then fills up the
>> memory window and breaks.
>>
>> So it sounds like the read side is not reading the correct data from the
>> memory window. Like it's cache or something (which it shouldn't be). But
>> I have no idea what could cause that.
> 
> Anything possibly to blame in the PCIe switch firmware that could
> cause this? Working with the vendor to ensure we're at the least, but
> still TBD at the moment.

I can't say anything for certain. It certainly worth getting the latest
firmware. But as far as I understand the memory windows (if that is
indeed the problem) are mostly hardware related so if they are setup
correctly by the firmware they shouldn't stop working if the firmware is
right.

So I'm skeptical a firmware fix would solve the issue, but I could
definitely be wrong about that.

Logan
