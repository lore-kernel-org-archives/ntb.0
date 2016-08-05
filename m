Return-Path: <jdmason@kudzu.us>
Received: from mail-ua0-x243.google.com (mail-ua0-x243.google.com. [2607:f8b0:400c:c08::243])
        by gmr-mx.google.com with ESMTPS id a132si96231vki.0.2016.08.05.07.35.30
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Aug 2016 07:35:30 -0700 (PDT)
Received: by mail-ua0-x243.google.com with SMTP id s7so5875278uas.1
        for <linux-ntb@googlegroups.com>; Fri, 05 Aug 2016 07:35:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1469204350.52273.3.camel@intel.com>
References: <6a5cd51b82d6d20bfbc129f4d83264d93adbf78c.1469194609.git.Allen.Hubbe@emc.com>
 <1469204350.52273.3.camel@intel.com>
From: Jon Mason <jdmason@kudzu.us>
Date: Fri, 5 Aug 2016 10:35:30 -0400
Message-ID: <CAPoiz9yqfyqZiuJCAF0j9w5rcvamghKd8mAaM1+hjnEwgaO6ew@mail.gmail.com>
Subject: Re: [PATCH 1/2] NTB: ntb_hw_intel: show BAR size in debugfs info
Content-Type: text/plain; charset=UTF-8
To: "Jiang, Dave" <dave.jiang@intel.com>
Cc: "Allen.Hubbe@emc.com" <Allen.Hubbe@emc.com>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

On Fri, Jul 22, 2016 at 12:19 PM, Jiang, Dave <dave.jiang@intel.com> wrote:
>
> On Fri, 2016-07-22 at 09:38 -0400, Allen Hubbe wrote:
>> It will be useful to know the hardware configured BAR size to
>> diagnose
>> issues with NTB memory windows.
>>
>> Signed-off-by: Allen Hubbe <Allen.Hubbe@emc.com>
> Acked-by: Dave Jiang <dave.jiang@intel.com>

Pulled into my ntb brach

>> ---
>>  drivers/ntb/hw/intel/ntb_hw_intel.c | 39
>> ++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 38 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.c
>> b/drivers/ntb/hw/intel/ntb_hw_intel.c
>> index 40d04ef5da9e..5efd03705e5c 100644
>> --- a/drivers/ntb/hw/intel/ntb_hw_intel.c
>> +++ b/drivers/ntb/hw/intel/ntb_hw_intel.c
>> @@ -551,13 +551,15 @@ static ssize_t ndev_debugfs_read(struct file
>> *filp, char __user *ubuf,
>>                                size_t count, loff_t *offp)
>>  {
>>       struct intel_ntb_dev *ndev;
>> +     struct pci_dev *pdev;
>>       void __iomem *mmio;
>>       char *buf;
>>       size_t buf_size;
>>       ssize_t ret, off;
>> -     union { u64 v64; u32 v32; u16 v16; } u;
>> +     union { u64 v64; u32 v32; u16 v16; u8 v8; } u;
>>
>>       ndev = filp->private_data;
>> +     pdev = ndev_pdev(ndev);
>>       mmio = ndev->self_mmio;
>>
>>       buf_size = min(count, 0x800ul);
>> @@ -632,6 +634,41 @@ static ssize_t ndev_debugfs_read(struct file
>> *filp, char __user *ubuf,
>>                        "Doorbell Bell -\t\t%#llx\n", u.v64);
>>
>>       off += scnprintf(buf + off, buf_size - off,
>> +                      "\nNTB Window Size:\n");
>> +
>> +     pci_read_config_byte(pdev, XEON_PBAR23SZ_OFFSET, &u.v8);
>> +     off += scnprintf(buf + off, buf_size - off,
>> +                      "PBAR23SZ %hhu\n", u.v8);
>> +     if (!ndev->bar4_split) {
>> +             pci_read_config_byte(pdev, XEON_PBAR45SZ_OFFSET,
>> &u.v8);
>> +             off += scnprintf(buf + off, buf_size - off,
>> +                              "PBAR45SZ %hhu\n", u.v8);
>> +     } else {
>> +             pci_read_config_byte(pdev, XEON_PBAR4SZ_OFFSET,
>> &u.v8);
>> +             off += scnprintf(buf + off, buf_size - off,
>> +                              "PBAR4SZ %hhu\n", u.v8);
>> +             pci_read_config_byte(pdev, XEON_PBAR5SZ_OFFSET,
>> &u.v8);
>> +             off += scnprintf(buf + off, buf_size - off,
>> +                              "PBAR5SZ %hhu\n", u.v8);
>> +     }
>> +
>> +     pci_read_config_byte(pdev, XEON_SBAR23SZ_OFFSET, &u.v8);
>> +     off += scnprintf(buf + off, buf_size - off,
>> +                      "SBAR23SZ %hhu\n", u.v8);
>> +     if (!ndev->bar4_split) {
>> +             pci_read_config_byte(pdev, XEON_SBAR45SZ_OFFSET,
>> &u.v8);
>> +             off += scnprintf(buf + off, buf_size - off,
>> +                              "SBAR45SZ %hhu\n", u.v8);
>> +     } else {
>> +             pci_read_config_byte(pdev, XEON_SBAR4SZ_OFFSET,
>> &u.v8);
>> +             off += scnprintf(buf + off, buf_size - off,
>> +                              "SBAR4SZ %hhu\n", u.v8);
>> +             pci_read_config_byte(pdev, XEON_SBAR5SZ_OFFSET,
>> &u.v8);
>> +             off += scnprintf(buf + off, buf_size - off,
>> +                              "SBAR5SZ %hhu\n", u.v8);
>> +     }
>> +
>> +     off += scnprintf(buf + off, buf_size - off,
>>                        "\nNTB Incoming XLAT:\n");
>>
>>       u.v64 = ioread64(mmio + bar2_off(ndev->xlat_reg->bar2_xlat,
>> 2));
