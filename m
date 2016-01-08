Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwdur.emc.com (mailuogwdur.emc.com. [128.221.224.79])
        by gmr-mx.google.com with ESMTPS id w126si923969ywe.6.2016.01.08.06.57.48
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jan 2016 06:57:48 -0800 (PST)
From: "Allen Hubbe" <Allen.Hubbe@emc.com>
References: <20160107231454.49862.22907.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <20160107231454.49862.22907.stgit@djiang5-desk3.ch.intel.com>
Subject: RE: [PATCH] NTB: Address out of DMA descriptor issue with NTB
Date: Fri, 8 Jan 2016 09:57:30 -0500
Message-ID: <000c01d14a24$e6514960$b2f3dc20$@emc.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
To: 'Dave Jiang' <dave.jiang@intel.com>, jdmason@kudzu.us
Cc: linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

From: Dave Jiang <dave.jiang@intel.com>
> The transport right now does not handle the case where we run out of DMA
> descriptors. We just fail when we do not succeed. Adding code to retry
> for
> a bit attempting to use the DMA engine instead of instantly fail to CPU
> copy.

> @@ -1263,11 +1276,20 @@ static void ntb_async_rx(struct ntb_queue_entry
> *entry, void *offset)

> +	do {
> +		txd = device->device_prep_dma_memcpy(chan, unmap->addr[1],
> +						     unmap->addr[0], len,
> +						     DMA_PREP_INTERRUPT);
> +		if (!txd) {
> +			set_current_state(TASK_INTERRUPTIBLE);
> +			schedule_timeout(DMA_OUT_RESOURCE_TO);
> +		}
> +	} while (!txd && (++retries < DMA_RETRIES));

!txd is tested twice per loop.

How about:

for (retries = 0; retries < DMA_RETRIES; ++retries) {
    txd = prep_dma_memcpy();
    if (txd)
        break;
    set_current_state();
    schedule_timeout();
}

> @@ -1494,10 +1517,19 @@ static void ntb_async_tx(struct ntb_transport_qp

Also here.

Allen

