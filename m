Return-Path: <jdmason@kudzu.us>
Received: from mail-vk0-x241.google.com (mail-vk0-x241.google.com. [2607:f8b0:400c:c05::241])
        by gmr-mx.google.com with ESMTPS id v193si46074vkv.2.2016.04.21.07.54.29
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Apr 2016 07:54:29 -0700 (PDT)
Received: by mail-vk0-x241.google.com with SMTP id x190so10280539vka.3
        for <linux-ntb@googlegroups.com>; Thu, 21 Apr 2016 07:54:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <000001d191c0$0ea3cfe0$2beb6fa0$@emc.com>
References: <146013774604.52030.5227558679570366112.stgit@djiang5-desk3.ch.intel.com>
	<000001d191c0$0ea3cfe0$2beb6fa0$@emc.com>
Date: Thu, 21 Apr 2016 10:54:29 -0400
Message-ID: <CAPoiz9zDzZimzs7QXoEKP6KiPqW5CYPXeApRmmKjrASvTCu2-g@mail.gmail.com>
Subject: Re: [PATCH v3] NTB: allocate number transport entries depending on
 size of ring size
From: Jon Mason <jdmason@kudzu.us>
Content-Type: text/plain; charset=UTF-8
To: Allen Hubbe <Allen.Hubbe@emc.com>
Cc: Dave Jiang <dave.jiang@intel.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Fri, Apr 8, 2016 at 1:57 PM, Allen Hubbe <Allen.Hubbe@emc.com> wrote:
>> From: Dave Jiang
>>
>> Currently we only allocate a fixed default number of descriptors for the tx
>> and rx side. We should dynamically resize it to the number of descriptors
>> resides in the transport rings. We should know the number of transmit
>> descriptors at initializaiton. We will allocate the default number of
>> descriptors for receive side and allocate additional ones when we know the
>> actual max entries for receive.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>
> Acked-by: Allen Hubbe <allen.hubbe@emc.com>

Applied to my ntb-next git branch

>> ---
>>  drivers/ntb/ntb_transport.c |   29 +++++++++++++++++++++++++++--
>>  1 file changed, 27 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
>> index 2ef9d913..6db8c85 100644
>> --- a/drivers/ntb/ntb_transport.c
>> +++ b/drivers/ntb/ntb_transport.c
>> @@ -153,6 +153,7 @@ struct ntb_transport_qp {
>>       unsigned int rx_index;
>>       unsigned int rx_max_entry;
>>       unsigned int rx_max_frame;
>> +     unsigned int rx_alloc_entry;
>>       dma_cookie_t last_cookie;
>>       struct tasklet_struct rxc_db_work;
>>
>> @@ -480,7 +481,9 @@ static ssize_t debugfs_read(struct file *filp, char __user *ubuf,
>> size_t count,
>>       out_offset += snprintf(buf + out_offset, out_count - out_offset,
>>                              "rx_index - \t%u\n", qp->rx_index);
>>       out_offset += snprintf(buf + out_offset, out_count - out_offset,
>> -                            "rx_max_entry - \t%u\n\n", qp->rx_max_entry);
>> +                            "rx_max_entry - \t%u\n", qp->rx_max_entry);
>> +     out_offset += snprintf(buf + out_offset, out_count - out_offset,
>> +                            "rx_alloc_entry - \t%u\n\n", qp->rx_alloc_entry);
>>
>>       out_offset += snprintf(buf + out_offset, out_count - out_offset,
>>                              "tx_bytes - \t%llu\n", qp->tx_bytes);
>> @@ -597,9 +600,12 @@ static int ntb_transport_setup_qp_mw(struct ntb_transport_ctx *nt,
>>  {
>>       struct ntb_transport_qp *qp = &nt->qp_vec[qp_num];
>>       struct ntb_transport_mw *mw;
>> +     struct ntb_dev *ndev = nt->ndev;
>> +     struct ntb_queue_entry *entry;
>>       unsigned int rx_size, num_qps_mw;
>>       unsigned int mw_num, mw_count, qp_count;
>>       unsigned int i;
>> +     int node;
>>
>>       mw_count = nt->mw_count;
>>       qp_count = nt->qp_count;
>> @@ -626,6 +632,23 @@ static int ntb_transport_setup_qp_mw(struct ntb_transport_ctx *nt,
>>       qp->rx_max_entry = rx_size / qp->rx_max_frame;
>>       qp->rx_index = 0;
>>
>> +     /*
>> +      * Checking to see if we have more entries than the default.
>> +      * We should add additional entries if that is the case so we
>> +      * can be in sync with the transport frames.
>> +      */
>> +     node = dev_to_node(&ndev->dev);
>> +     for (i = qp->rx_alloc_entry; i < qp->rx_max_entry; i++) {
>> +             entry = kzalloc_node(sizeof(*entry), GFP_ATOMIC, node);
>> +             if (!entry)
>> +                     return -ENOMEM;
>> +
>> +             entry->qp = qp;
>> +             ntb_list_add(&qp->ntb_rx_q_lock, &entry->entry,
>> +                          &qp->rx_free_q);
>> +             qp->rx_alloc_entry++;
>> +     }
>> +
>>       qp->remote_rx_info->entry = qp->rx_max_entry - 1;
>>
>>       /* setup the hdr offsets with 0's */
>> @@ -1722,8 +1745,9 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
>>               ntb_list_add(&qp->ntb_rx_q_lock, &entry->entry,
>>                            &qp->rx_free_q);
>>       }
>> +     qp->rx_alloc_entry = NTB_QP_DEF_NUM_ENTRIES;
>>
>> -     for (i = 0; i < NTB_QP_DEF_NUM_ENTRIES; i++) {
>> +     for (i = 0; i < qp->tx_max_entry; i++) {
>>               entry = kzalloc_node(sizeof(*entry), GFP_ATOMIC, node);
>>               if (!entry)
>>                       goto err2;
>> @@ -1744,6 +1768,7 @@ err2:
>>       while ((entry = ntb_list_rm(&qp->ntb_tx_free_q_lock, &qp->tx_free_q)))
>>               kfree(entry);
>>  err1:
>> +     qp->rx_alloc_entry = 0;
>>       while ((entry = ntb_list_rm(&qp->ntb_rx_q_lock, &qp->rx_free_q)))
>>               kfree(entry);
>>       if (qp->tx_dma_chan)
>
> --
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/000001d191c0%240ea3cfe0%242beb6fa0%24%40emc.com.
> For more options, visit https://groups.google.com/d/optout.
