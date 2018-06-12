Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id l15-v6si66874otk.3.2018.06.12.14.44.43
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 14:44:44 -0700 (PDT)
References: <20180611203926.2666-1-jdmason@kudzu.us>
 <ab8d44fc-6cd6-724e-0429-e7b3a1afb8d6@deltatee.com>
 <CAPoiz9z=sgNccCt2ui7FroNrWFjTZhMcEZ+UjVAJA2E-Y+RJPw@mail.gmail.com>
 <d51b4fbc-3d56-2802-11f3-401876373b4c@deltatee.com>
 <CAOQPn8uFa6iCcP0rVNKV9Mvm7LpWr=jpNOGOopgHJvzX+kTQCw@mail.gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <9261d4bc-f5a5-8b54-2227-57e5a3cf9d5c@deltatee.com>
Date: Tue, 12 Jun 2018 15:44:37 -0600
MIME-Version: 1.0
In-Reply-To: <CAOQPn8uFa6iCcP0rVNKV9Mvm7LpWr=jpNOGOopgHJvzX+kTQCw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ntb_netdev: fix sleep time mismatch
To: Eric Pilmore <epilmore@gigaio.com>
Cc: Jon Mason <jdmason@kudzu.us>, linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

On 6/12/2018 3:33 PM, Eric Pilmore wrote:
> How many entries are in your TX queue (tx_max_entry)?
> I assume the tx_stop in ntb_netdev was still set to its default, 5.
> 
> If the TX queue is large then it may be difficult to go below the
> tx_stop threshold.

That makes sense. I didn't really dig into it too much. All I know is
the performance of ntb_netdev has always been slower than I wanted it to
be (almost an order of magnitude slower than ntb_perf) and I was hoping
this would help that.

Logan
