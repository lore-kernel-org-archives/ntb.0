Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id x22-v6si51953otk.5.2018.06.12.17.05.02
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 17:05:02 -0700 (PDT)
References: <20180611203926.2666-1-jdmason@kudzu.us>
 <ab8d44fc-6cd6-724e-0429-e7b3a1afb8d6@deltatee.com>
 <CAPoiz9z=sgNccCt2ui7FroNrWFjTZhMcEZ+UjVAJA2E-Y+RJPw@mail.gmail.com>
 <d51b4fbc-3d56-2802-11f3-401876373b4c@deltatee.com>
 <CAOQPn8uFa6iCcP0rVNKV9Mvm7LpWr=jpNOGOopgHJvzX+kTQCw@mail.gmail.com>
 <9261d4bc-f5a5-8b54-2227-57e5a3cf9d5c@deltatee.com>
 <CAOQPn8s9khirf+2cgz2zLQrsx+gdkxtB-EiDwVmRyy7witLbzw@mail.gmail.com>
 <7f0e1c57-696f-44be-17f6-815fa5090774@deltatee.com>
 <c8284602-9001-7daf-083b-53a1a794c838@intel.com>
 <9f354d1f-af37-b378-b4f8-a8286adfe5ee@deltatee.com>
 <CAOQPn8vSB1zLO56fRWopKhLr97q9qXnAsy2-v+E7vUw5t1JLdQ@mail.gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <648470a7-647b-ae65-2d95-4997f00e65a5@deltatee.com>
Date: Tue, 12 Jun 2018 18:04:59 -0600
MIME-Version: 1.0
In-Reply-To: <CAOQPn8vSB1zLO56fRWopKhLr97q9qXnAsy2-v+E7vUw5t1JLdQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ntb_netdev: fix sleep time mismatch
To: Eric Pilmore <epilmore@gigaio.com>
Cc: Dave Jiang <dave.jiang@intel.com>, Jon Mason <jdmason@kudzu.us>, linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>



On 12/06/18 04:55 PM, Eric Pilmore wrote:
> I'm not quite seeing how a DMA in the switch would eliminate the security
> risk of a wide open memory. Are you suggesting that the driver for the DMA
> would have more control over filtering what source/dest addresses are
> allowed and you wouldn't advertise the entire address space via a BAR?

Well imagine a DMA engine designed similar to how RDMA is designed in RNICs:

Side A programs the DMA engine with an available local buffer (DMA
address and length) as well as a random key. The key is sent to side B
via some side channel (message/scratchpad/etc).

Side B then programs the DMA engine with another local buffer, plus the
direction and the key. The DMA engine uses the key to lookup the remote
address and partition ID or fails if the key is invalid. Once this is
done the DMA engine copies the data between Side B's buffer and Side A's
buffer; then triggers an interrupt back to software. Assuming the
hardware supports enough keys this could be used to great effect. Much
simpler than managing a limited set of memory windows (though you
wouldn't want to get rid of MWs as they'd be useful for other things).

Also, in addition to the key, you might want permission flags (eg. maybe
a buffer can be read but not written or vice-versa).

Logan


