Return-Path: <jdmason@kudzu.us>
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com. [2607:f8b0:4864:20::d43])
        by gmr-mx.google.com with ESMTPS id q2si696161pgq.3.2019.09.23.15.11.34
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 15:11:34 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id u8so16115608iom.5
        for <linux-ntb@googlegroups.com>; Mon, 23 Sep 2019 15:11:34 -0700 (PDT)
MIME-Version: 1.0
References: <1568567293-26894-1-git-send-email-Sanju.Mehta@amd.com>
In-Reply-To: <1568567293-26894-1-git-send-email-Sanju.Mehta@amd.com>
From: Jon Mason <jdmason@kudzu.us>
Date: Mon, 23 Sep 2019 15:11:22 -0700
Message-ID: <CAPoiz9w5eFaw42SmMBoyNEACJ10QNdTL=jiduS8UbowrgwcdHg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ntb_hw_amd: Add memory window support for new AMD hardware
Content-Type: text/plain; charset="UTF-8"
To: "Mehta, Sanju" <Sanju.Mehta@amd.com>
Cc: "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>, "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>, "allenbh@gmail.com" <allenbh@gmail.com>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-ID: <linux-ntb.googlegroups.com>

On Sun, Sep 15, 2019 at 10:08 AM Mehta, Sanju <Sanju.Mehta@amd.com> wrote:
>
> From: Sanjay R Mehta <sanju.mehta@amd.com>
>
> The AMD new hardware uses BAR23 and BAR45 as memory windows
> as compared to previos where BAR1, BAR23 and BAR45 is used
> for memory windows.
>
> This patch add support for both AMD hardwares.

I pulled both of these patches into the ntb branch.  I am aiming for a
5.4 pull request this Wednesday.  So, please test if possible.

Thanks,
Jon

>
> Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
> ---
>  drivers/ntb/hw/amd/ntb_hw_amd.c | 23 ++++++++++++++++++-----
>  drivers/ntb/hw/amd/ntb_hw_amd.h |  7 ++++++-
>  2 files changed, 24 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
> index e9286cf..156c2a1 100644
> --- a/drivers/ntb/hw/amd/ntb_hw_amd.c
> +++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
> @@ -78,7 +78,7 @@ static int ndev_mw_to_bar(struct amd_ntb_dev *ndev, int idx)
>         if (idx < 0 || idx > ndev->mw_count)
>                 return -EINVAL;
>
> -       return 1 << idx;
> +       return ndev->dev_data->mw_idx << idx;
>  }
>
>  static int amd_ntb_mw_count(struct ntb_dev *ntb, int pidx)
> @@ -909,7 +909,7 @@ static int amd_init_ntb(struct amd_ntb_dev *ndev)
>  {
>         void __iomem *mmio = ndev->self_mmio;
>
> -       ndev->mw_count = AMD_MW_CNT;
> +       ndev->mw_count = ndev->dev_data->mw_count;
>         ndev->spad_count = AMD_SPADS_CNT;
>         ndev->db_count = AMD_DB_CNT;
>
> @@ -1069,6 +1069,8 @@ static int amd_ntb_pci_probe(struct pci_dev *pdev,
>                 goto err_ndev;
>         }
>
> +       ndev->dev_data = (struct ntb_dev_data *)id->driver_data;
> +
>         ndev_init_struct(ndev, pdev);
>
>         rc = amd_ntb_init_pci(ndev, pdev);
> @@ -1123,10 +1125,21 @@ static const struct file_operations amd_ntb_debugfs_info = {
>         .read = ndev_debugfs_read,
>  };
>
> +static const struct ntb_dev_data dev_data[] = {
> +       { /* for device 145b */
> +               .mw_count = 3,
> +               .mw_idx = 1,
> +       },
> +       { /* for device 148b */
> +               .mw_count = 2,
> +               .mw_idx = 2,
> +       },
> +};
> +
>  static const struct pci_device_id amd_ntb_pci_tbl[] = {
> -       {PCI_VDEVICE(AMD, 0x145b)},
> -       {PCI_VDEVICE(AMD, 0x148b)},
> -       {0}
> +       { PCI_VDEVICE(AMD, 0x145b), (kernel_ulong_t)&dev_data[0] },
> +       { PCI_VDEVICE(AMD, 0x148b), (kernel_ulong_t)&dev_data[1] },
> +       { 0, }
>  };
>  MODULE_DEVICE_TABLE(pci, amd_ntb_pci_tbl);
>
> diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.h b/drivers/ntb/hw/amd/ntb_hw_amd.h
> index 3aac994..139a307 100644
> --- a/drivers/ntb/hw/amd/ntb_hw_amd.h
> +++ b/drivers/ntb/hw/amd/ntb_hw_amd.h
> @@ -92,7 +92,6 @@ static inline void _write64(u64 val, void __iomem *mmio)
>
>  enum {
>         /* AMD NTB Capability */
> -       AMD_MW_CNT              = 3,
>         AMD_DB_CNT              = 16,
>         AMD_MSIX_VECTOR_CNT     = 24,
>         AMD_SPADS_CNT           = 16,
> @@ -169,6 +168,11 @@ enum {
>         AMD_PEER_OFFSET         = 0x400,
>  };
>
> +struct ntb_dev_data {
> +       const unsigned char mw_count;
> +       const unsigned int mw_idx;
> +};
> +
>  struct amd_ntb_dev;
>
>  struct amd_ntb_vec {
> @@ -184,6 +188,7 @@ struct amd_ntb_dev {
>         u32 cntl_sta;
>         u32 peer_sta;
>
> +       struct ntb_dev_data *dev_data;
>         unsigned char mw_count;
>         unsigned char spad_count;
>         unsigned char db_count;
> --
> 2.7.4
>
