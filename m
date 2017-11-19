Return-Path: <jdmason@kudzu.us>
Received: from mail-vk0-x241.google.com (mail-vk0-x241.google.com. [2607:f8b0:400c:c05::241])
        by gmr-mx.google.com with ESMTPS id y25si485607uaa.2.2017.11.18.17.56.00
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Nov 2017 17:56:00 -0800 (PST)
Received: by mail-vk0-x241.google.com with SMTP id s197so3743877vkh.11
        for <linux-ntb@googlegroups.com>; Sat, 18 Nov 2017 17:56:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <000101d35c88$9430f360$bc92da20$@dell.com>
References: <151035618716.31660.7327782780368336511.stgit@djiang5-desk3.ch.intel.com>
 <000101d35c88$9430f360$bc92da20$@dell.com>
From: Jon Mason <jdmason@kudzu.us>
Date: Sat, 18 Nov 2017 20:55:59 -0500
Message-ID: <CAPoiz9wn3f5x-aCJTMx7S6xS=uiG2ZYOJHxiAk2Unrqc58EbiQ@mail.gmail.com>
Subject: Re: [PATCH] ntb: remove Intel Atom NTB driver support
Content-Type: text/plain; charset="UTF-8"
To: Allen Hubbe <Allen.Hubbe@dell.com>
Cc: Dave Jiang <dave.jiang@intel.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

This patch didn't apply.  Can you rebase and resend?

Thanks,
Jon

On Mon, Nov 13, 2017 at 9:06 AM, Allen Hubbe <Allen.Hubbe@dell.com> wrote:
> From: Dave Jiang
>> Removing dead code since this is not being used.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>
> Acked-by: Allen Hubbe <Allen.Hubbe@dell.com>
>
>> ---
>>  drivers/ntb/hw/intel/ntb_hw_intel.c |  309 -----------------------------------
>>  drivers/ntb/hw/intel/ntb_hw_intel.h |   58 -------
>>  2 files changed, 4 insertions(+), 363 deletions(-)
>>
>> diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.c b/drivers/ntb/hw/intel/ntb_hw_intel.c
>> index c1d2f85..94c0737 100644
>> --- a/drivers/ntb/hw/intel/ntb_hw_intel.c
>> +++ b/drivers/ntb/hw/intel/ntb_hw_intel.c
>> @@ -74,12 +74,6 @@ MODULE_AUTHOR("Intel Corporation");
>>  #define bar0_off(base, bar) ((base) + ((bar) << 2))
>>  #define bar2_off(base, bar) bar0_off(base, (bar) - 2)
>>
>> -static const struct intel_ntb_reg atom_reg;
>> -static const struct intel_ntb_alt_reg atom_pri_reg;
>> -static const struct intel_ntb_alt_reg atom_sec_reg;
>> -static const struct intel_ntb_alt_reg atom_b2b_reg;
>> -static const struct intel_ntb_xlat_reg atom_pri_xlat;
>> -static const struct intel_ntb_xlat_reg atom_sec_xlat;
>>  static const struct intel_ntb_reg xeon_reg;
>>  static const struct intel_ntb_alt_reg xeon_pri_reg;
>>  static const struct intel_ntb_alt_reg xeon_sec_reg;
>> @@ -184,15 +178,6 @@ static inline void _iowrite64(u64 val, void __iomem *mmio)
>>  #endif
>>  #endif
>>
>> -static inline int pdev_is_atom(struct pci_dev *pdev)
>> -{
>> -     switch (pdev->device) {
>> -     case PCI_DEVICE_ID_INTEL_NTB_B2B_BWD:
>> -             return 1;
>> -     }
>> -     return 0;
>> -}
>> -
>>  static inline int pdev_is_xeon(struct pci_dev *pdev)
>>  {
>>       switch (pdev->device) {
>> @@ -1015,8 +1000,7 @@ static ssize_t ndev_debugfs_read(struct file *filp, char __user *ubuf,
>>  {
>>       struct intel_ntb_dev *ndev = filp->private_data;
>>
>> -     if (pdev_is_xeon(ndev->ntb.pdev) ||
>> -         pdev_is_atom(ndev->ntb.pdev))
>> +     if (pdev_is_xeon(ndev->ntb.pdev))
>>               return ndev_ntb_debugfs_read(filp, ubuf, count, offp);
>>       else if (pdev_is_xeon_ntb3(ndev->ntb.pdev))
>>               return ndev_ntb3_debugfs_read(filp, ubuf, count, offp);
>> @@ -1448,242 +1432,6 @@ static int intel_ntb_peer_spad_write(struct ntb_dev *ntb, int pidx,
>>                              ndev->peer_reg->spad);
>>  }
>>
>> -/* ATOM */
>> -
>> -static u64 atom_db_ioread(void __iomem *mmio)
>> -{
>> -     return ioread64(mmio);
>> -}
>> -
>> -static void atom_db_iowrite(u64 bits, void __iomem *mmio)
>> -{
>> -     iowrite64(bits, mmio);
>> -}
>> -
>> -static int atom_poll_link(struct intel_ntb_dev *ndev)
>> -{
>> -     u32 ntb_ctl;
>> -
>> -     ntb_ctl = ioread32(ndev->self_mmio + ATOM_NTBCNTL_OFFSET);
>> -
>> -     if (ntb_ctl == ndev->ntb_ctl)
>> -             return 0;
>> -
>> -     ndev->ntb_ctl = ntb_ctl;
>> -
>> -     ndev->lnk_sta = ioread32(ndev->self_mmio + ATOM_LINK_STATUS_OFFSET);
>> -
>> -     return 1;
>> -}
>> -
>> -static int atom_link_is_up(struct intel_ntb_dev *ndev)
>> -{
>> -     return ATOM_NTB_CTL_ACTIVE(ndev->ntb_ctl);
>> -}
>> -
>> -static int atom_link_is_err(struct intel_ntb_dev *ndev)
>> -{
>> -     if (ioread32(ndev->self_mmio + ATOM_LTSSMSTATEJMP_OFFSET)
>> -         & ATOM_LTSSMSTATEJMP_FORCEDETECT)
>> -             return 1;
>> -
>> -     if (ioread32(ndev->self_mmio + ATOM_IBSTERRRCRVSTS0_OFFSET)
>> -         & ATOM_IBIST_ERR_OFLOW)
>> -             return 1;
>> -
>> -     return 0;
>> -}
>> -
>> -static inline enum ntb_topo atom_ppd_topo(struct intel_ntb_dev *ndev, u32 ppd)
>> -{
>> -     struct device *dev = &ndev->ntb.pdev->dev;
>> -
>> -     switch (ppd & ATOM_PPD_TOPO_MASK) {
>> -     case ATOM_PPD_TOPO_B2B_USD:
>> -             dev_dbg(dev, "PPD %d B2B USD\n", ppd);
>> -             return NTB_TOPO_B2B_USD;
>> -
>> -     case ATOM_PPD_TOPO_B2B_DSD:
>> -             dev_dbg(dev, "PPD %d B2B DSD\n", ppd);
>> -             return NTB_TOPO_B2B_DSD;
>> -
>> -     case ATOM_PPD_TOPO_PRI_USD:
>> -     case ATOM_PPD_TOPO_PRI_DSD: /* accept bogus PRI_DSD */
>> -     case ATOM_PPD_TOPO_SEC_USD:
>> -     case ATOM_PPD_TOPO_SEC_DSD: /* accept bogus SEC_DSD */
>> -             dev_dbg(dev, "PPD %d non B2B disabled\n", ppd);
>> -             return NTB_TOPO_NONE;
>> -     }
>> -
>> -     dev_dbg(dev, "PPD %d invalid\n", ppd);
>> -     return NTB_TOPO_NONE;
>> -}
>> -
>> -static void atom_link_hb(struct work_struct *work)
>> -{
>> -     struct intel_ntb_dev *ndev = hb_ndev(work);
>> -     struct device *dev = &ndev->ntb.pdev->dev;
>> -     unsigned long poll_ts;
>> -     void __iomem *mmio;
>> -     u32 status32;
>> -
>> -     poll_ts = ndev->last_ts + ATOM_LINK_HB_TIMEOUT;
>> -
>> -     /* Delay polling the link status if an interrupt was received,
>> -      * unless the cached link status says the link is down.
>> -      */
>> -     if (time_after(poll_ts, jiffies) && atom_link_is_up(ndev)) {
>> -             schedule_delayed_work(&ndev->hb_timer, poll_ts - jiffies);
>> -             return;
>> -     }
>> -
>> -     if (atom_poll_link(ndev))
>> -             ntb_link_event(&ndev->ntb);
>> -
>> -     if (atom_link_is_up(ndev) || !atom_link_is_err(ndev)) {
>> -             schedule_delayed_work(&ndev->hb_timer, ATOM_LINK_HB_TIMEOUT);
>> -             return;
>> -     }
>> -
>> -     /* Link is down with error: recover the link! */
>> -
>> -     mmio = ndev->self_mmio;
>> -
>> -     /* Driver resets the NTB ModPhy lanes - magic! */
>> -     iowrite8(0xe0, mmio + ATOM_MODPHY_PCSREG6);
>> -     iowrite8(0x40, mmio + ATOM_MODPHY_PCSREG4);
>> -     iowrite8(0x60, mmio + ATOM_MODPHY_PCSREG4);
>> -     iowrite8(0x60, mmio + ATOM_MODPHY_PCSREG6);
>> -
>> -     /* Driver waits 100ms to allow the NTB ModPhy to settle */
>> -     msleep(100);
>> -
>> -     /* Clear AER Errors, write to clear */
>> -     status32 = ioread32(mmio + ATOM_ERRCORSTS_OFFSET);
>> -     dev_dbg(dev, "ERRCORSTS = %x\n", status32);
>> -     status32 &= PCI_ERR_COR_REP_ROLL;
>> -     iowrite32(status32, mmio + ATOM_ERRCORSTS_OFFSET);
>> -
>> -     /* Clear unexpected electrical idle event in LTSSM, write to clear */
>> -     status32 = ioread32(mmio + ATOM_LTSSMERRSTS0_OFFSET);
>> -     dev_dbg(dev, "LTSSMERRSTS0 = %x\n", status32);
>> -     status32 |= ATOM_LTSSMERRSTS0_UNEXPECTEDEI;
>> -     iowrite32(status32, mmio + ATOM_LTSSMERRSTS0_OFFSET);
>> -
>> -     /* Clear DeSkew Buffer error, write to clear */
>> -     status32 = ioread32(mmio + ATOM_DESKEWSTS_OFFSET);
>> -     dev_dbg(dev, "DESKEWSTS = %x\n", status32);
>> -     status32 |= ATOM_DESKEWSTS_DBERR;
>> -     iowrite32(status32, mmio + ATOM_DESKEWSTS_OFFSET);
>> -
>> -     status32 = ioread32(mmio + ATOM_IBSTERRRCRVSTS0_OFFSET);
>> -     dev_dbg(dev, "IBSTERRRCRVSTS0 = %x\n", status32);
>> -     status32 &= ATOM_IBIST_ERR_OFLOW;
>> -     iowrite32(status32, mmio + ATOM_IBSTERRRCRVSTS0_OFFSET);
>> -
>> -     /* Releases the NTB state machine to allow the link to retrain */
>> -     status32 = ioread32(mmio + ATOM_LTSSMSTATEJMP_OFFSET);
>> -     dev_dbg(dev, "LTSSMSTATEJMP = %x\n", status32);
>> -     status32 &= ~ATOM_LTSSMSTATEJMP_FORCEDETECT;
>> -     iowrite32(status32, mmio + ATOM_LTSSMSTATEJMP_OFFSET);
>> -
>> -     /* There is a potential race between the 2 NTB devices recovering at the
>> -      * same time.  If the times are the same, the link will not recover and
>> -      * the driver will be stuck in this loop forever.  Add a random interval
>> -      * to the recovery time to prevent this race.
>> -      */
>> -     schedule_delayed_work(&ndev->hb_timer, ATOM_LINK_RECOVERY_TIME
>> -                           + prandom_u32() % ATOM_LINK_RECOVERY_TIME);
>> -}
>> -
>> -static int atom_init_isr(struct intel_ntb_dev *ndev)
>> -{
>> -     int rc;
>> -
>> -     rc = ndev_init_isr(ndev, 1, ATOM_DB_MSIX_VECTOR_COUNT,
>> -                        ATOM_DB_MSIX_VECTOR_SHIFT, ATOM_DB_TOTAL_SHIFT);
>> -     if (rc)
>> -             return rc;
>> -
>> -     /* ATOM doesn't have link status interrupt, poll on that platform */
>> -     ndev->last_ts = jiffies;
>> -     INIT_DELAYED_WORK(&ndev->hb_timer, atom_link_hb);
>> -     schedule_delayed_work(&ndev->hb_timer, ATOM_LINK_HB_TIMEOUT);
>> -
>> -     return 0;
>> -}
>> -
>> -static void atom_deinit_isr(struct intel_ntb_dev *ndev)
>> -{
>> -     cancel_delayed_work_sync(&ndev->hb_timer);
>> -     ndev_deinit_isr(ndev);
>> -}
>> -
>> -static int atom_init_ntb(struct intel_ntb_dev *ndev)
>> -{
>> -     ndev->mw_count = ATOM_MW_COUNT;
>> -     ndev->spad_count = ATOM_SPAD_COUNT;
>> -     ndev->db_count = ATOM_DB_COUNT;
>> -
>> -     switch (ndev->ntb.topo) {
>> -     case NTB_TOPO_B2B_USD:
>> -     case NTB_TOPO_B2B_DSD:
>> -             ndev->self_reg = &atom_pri_reg;
>> -             ndev->peer_reg = &atom_b2b_reg;
>> -             ndev->xlat_reg = &atom_sec_xlat;
>> -
>> -             /* Enable Bus Master and Memory Space on the secondary side */
>> -             iowrite16(PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER,
>> -                       ndev->self_mmio + ATOM_SPCICMD_OFFSET);
>> -
>> -             break;
>> -
>> -     default:
>> -             return -EINVAL;
>> -     }
>> -
>> -     ndev->db_valid_mask = BIT_ULL(ndev->db_count) - 1;
>> -
>> -     return 0;
>> -}
>> -
>> -static int atom_init_dev(struct intel_ntb_dev *ndev)
>> -{
>> -     u32 ppd;
>> -     int rc;
>> -
>> -     rc = pci_read_config_dword(ndev->ntb.pdev, ATOM_PPD_OFFSET, &ppd);
>> -     if (rc)
>> -             return -EIO;
>> -
>> -     ndev->ntb.topo = atom_ppd_topo(ndev, ppd);
>> -     if (ndev->ntb.topo == NTB_TOPO_NONE)
>> -             return -EINVAL;
>> -
>> -     rc = atom_init_ntb(ndev);
>> -     if (rc)
>> -             return rc;
>> -
>> -     rc = atom_init_isr(ndev);
>> -     if (rc)
>> -             return rc;
>> -
>> -     if (ndev->ntb.topo != NTB_TOPO_SEC) {
>> -             /* Initiate PCI-E link training */
>> -             rc = pci_write_config_dword(ndev->ntb.pdev, ATOM_PPD_OFFSET,
>> -                                         ppd | ATOM_PPD_INIT_LINK);
>> -             if (rc)
>> -                     return rc;
>> -     }
>> -
>> -     return 0;
>> -}
>> -
>> -static void atom_deinit_dev(struct intel_ntb_dev *ndev)
>> -{
>> -     atom_deinit_isr(ndev);
>> -}
>> -
>>  /* Skylake Xeon NTB */
>>
>>  static int skx_poll_link(struct intel_ntb_dev *ndev)
>> @@ -2738,24 +2486,7 @@ static int intel_ntb_pci_probe(struct pci_dev *pdev,
>>
>>       node = dev_to_node(&pdev->dev);
>>
>> -     if (pdev_is_atom(pdev)) {
>> -             ndev = kzalloc_node(sizeof(*ndev), GFP_KERNEL, node);
>> -             if (!ndev) {
>> -                     rc = -ENOMEM;
>> -                     goto err_ndev;
>> -             }
>> -
>> -             ndev_init_struct(ndev, pdev);
>> -
>> -             rc = intel_ntb_init_pci(ndev, pdev);
>> -             if (rc)
>> -                     goto err_init_pci;
>> -
>> -             rc = atom_init_dev(ndev);
>> -             if (rc)
>> -                     goto err_init_dev;
>> -
>> -     } else if (pdev_is_xeon(pdev)) {
>> +     if (pdev_is_xeon(pdev)) {
>>               ndev = kzalloc_node(sizeof(*ndev), GFP_KERNEL, node);
>>               if (!ndev) {
>>                       rc = -ENOMEM;
>> @@ -2811,9 +2542,7 @@ static int intel_ntb_pci_probe(struct pci_dev *pdev,
>>
>>  err_register:
>>       ndev_deinit_debugfs(ndev);
>> -     if (pdev_is_atom(pdev))
>> -             atom_deinit_dev(ndev);
>> -     else if (pdev_is_xeon(pdev) || pdev_is_xeon_ntb3(pdev))
>> +     if (pdev_is_xeon(pdev) || pdev_is_xeon_ntb3(pdev))
>>               xeon_deinit_dev(ndev);
>>  err_init_dev:
>>       intel_ntb_deinit_pci(ndev);
>> @@ -2829,41 +2558,12 @@ static void intel_ntb_pci_remove(struct pci_dev *pdev)
>>
>>       ntb_unregister_device(&ndev->ntb);
>>       ndev_deinit_debugfs(ndev);
>> -     if (pdev_is_atom(pdev))
>> -             atom_deinit_dev(ndev);
>> -     else if (pdev_is_xeon(pdev) || pdev_is_xeon_ntb3(pdev))
>> +     if (pdev_is_xeon(pdev) || pdev_is_xeon_ntb3(pdev))
>>               xeon_deinit_dev(ndev);
>>       intel_ntb_deinit_pci(ndev);
>>       kfree(ndev);
>>  }
>>
>> -static const struct intel_ntb_reg atom_reg = {
>> -     .poll_link              = atom_poll_link,
>> -     .link_is_up             = atom_link_is_up,
>> -     .db_ioread              = atom_db_ioread,
>> -     .db_iowrite             = atom_db_iowrite,
>> -     .db_size                = sizeof(u64),
>> -     .ntb_ctl                = ATOM_NTBCNTL_OFFSET,
>> -     .mw_bar                 = {2, 4},
>> -};
>> -
>> -static const struct intel_ntb_alt_reg atom_pri_reg = {
>> -     .db_bell                = ATOM_PDOORBELL_OFFSET,
>> -     .db_mask                = ATOM_PDBMSK_OFFSET,
>> -     .spad                   = ATOM_SPAD_OFFSET,
>> -};
>> -
>> -static const struct intel_ntb_alt_reg atom_b2b_reg = {
>> -     .db_bell                = ATOM_B2B_DOORBELL_OFFSET,
>> -     .spad                   = ATOM_B2B_SPAD_OFFSET,
>> -};
>> -
>> -static const struct intel_ntb_xlat_reg atom_sec_xlat = {
>> -     /* FIXME : .bar0_base   = ATOM_SBAR0BASE_OFFSET, */
>> -     /* FIXME : .bar2_limit  = ATOM_SBAR2LMT_OFFSET, */
>> -     .bar2_xlat              = ATOM_SBAR2XLAT_OFFSET,
>> -};
>> -
>>  static const struct intel_ntb_reg xeon_reg = {
>>       .poll_link              = xeon_poll_link,
>>       .link_is_up             = xeon_link_is_up,
>> @@ -3020,7 +2720,6 @@ static const struct file_operations intel_ntb_debugfs_info = {
>>  };
>>
>>  static const struct pci_device_id intel_ntb_pci_tbl[] = {
>> -     {PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_NTB_B2B_BWD)},
>>       {PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_NTB_B2B_JSF)},
>>       {PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_NTB_B2B_SNB)},
>>       {PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_NTB_B2B_IVT)},
>> diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.h b/drivers/ntb/hw/intel/ntb_hw_intel.h
>> index a8b17f3..9d2c6b6 100644
>> --- a/drivers/ntb/hw/intel/ntb_hw_intel.h
>> +++ b/drivers/ntb/hw/intel/ntb_hw_intel.h
>> @@ -66,7 +66,6 @@
>>  #define PCI_DEVICE_ID_INTEL_NTB_B2B_HSX      0x2F0D
>>  #define PCI_DEVICE_ID_INTEL_NTB_PS_HSX       0x2F0E
>>  #define PCI_DEVICE_ID_INTEL_NTB_SS_HSX       0x2F0F
>> -#define PCI_DEVICE_ID_INTEL_NTB_B2B_BWD      0x0C4E
>>  #define PCI_DEVICE_ID_INTEL_NTB_B2B_BDX      0x6F0D
>>  #define PCI_DEVICE_ID_INTEL_NTB_PS_BDX       0x6F0E
>>  #define PCI_DEVICE_ID_INTEL_NTB_SS_BDX       0x6F0F
>> @@ -197,63 +196,6 @@
>>  #define SKX_DB_TOTAL_SHIFT           33
>>  #define SKX_SPAD_COUNT                       16
>>
>> -/* Intel Atom hardware */
>> -
>> -#define ATOM_SBAR2XLAT_OFFSET                0x0008
>> -#define ATOM_PDOORBELL_OFFSET                0x0020
>> -#define ATOM_PDBMSK_OFFSET           0x0028
>> -#define ATOM_NTBCNTL_OFFSET          0x0060
>> -#define ATOM_SPAD_OFFSET                     0x0080
>> -#define ATOM_PPD_OFFSET                      0x00d4
>> -#define ATOM_PBAR2XLAT_OFFSET                0x8008
>> -#define ATOM_B2B_DOORBELL_OFFSET             0x8020
>> -#define ATOM_B2B_SPAD_OFFSET         0x8080
>> -#define ATOM_SPCICMD_OFFSET          0xb004
>> -#define ATOM_LINK_STATUS_OFFSET              0xb052
>> -#define ATOM_ERRCORSTS_OFFSET                0xb110
>> -#define ATOM_IP_BASE                 0xc000
>> -#define ATOM_DESKEWSTS_OFFSET                (ATOM_IP_BASE + 0x3024)
>> -#define ATOM_LTSSMERRSTS0_OFFSET             (ATOM_IP_BASE + 0x3180)
>> -#define ATOM_LTSSMSTATEJMP_OFFSET    (ATOM_IP_BASE + 0x3040)
>> -#define ATOM_IBSTERRRCRVSTS0_OFFSET  (ATOM_IP_BASE + 0x3324)
>> -#define ATOM_MODPHY_PCSREG4          0x1c004
>> -#define ATOM_MODPHY_PCSREG6          0x1c006
>> -
>> -#define ATOM_PPD_INIT_LINK           0x0008
>> -#define ATOM_PPD_CONN_MASK           0x0300
>> -#define ATOM_PPD_CONN_TRANSPARENT    0x0000
>> -#define ATOM_PPD_CONN_B2B            0x0100
>> -#define ATOM_PPD_CONN_RP                     0x0200
>> -#define ATOM_PPD_DEV_MASK            0x1000
>> -#define ATOM_PPD_DEV_USD                     0x0000
>> -#define ATOM_PPD_DEV_DSD                     0x1000
>> -#define ATOM_PPD_TOPO_MASK   (ATOM_PPD_CONN_MASK | ATOM_PPD_DEV_MASK)
>> -#define ATOM_PPD_TOPO_PRI_USD        (ATOM_PPD_CONN_TRANSPARENT | ATOM_PPD_DEV_USD)
>> -#define ATOM_PPD_TOPO_PRI_DSD        (ATOM_PPD_CONN_TRANSPARENT | ATOM_PPD_DEV_DSD)
>> -#define ATOM_PPD_TOPO_SEC_USD        (ATOM_PPD_CONN_RP | ATOM_PPD_DEV_USD)
>> -#define ATOM_PPD_TOPO_SEC_DSD        (ATOM_PPD_CONN_RP | ATOM_PPD_DEV_DSD)
>> -#define ATOM_PPD_TOPO_B2B_USD        (ATOM_PPD_CONN_B2B | ATOM_PPD_DEV_USD)
>> -#define ATOM_PPD_TOPO_B2B_DSD        (ATOM_PPD_CONN_B2B | ATOM_PPD_DEV_DSD)
>> -
>> -#define ATOM_MW_COUNT                        2
>> -#define ATOM_DB_COUNT                        34
>> -#define ATOM_DB_VALID_MASK           (BIT_ULL(ATOM_DB_COUNT) - 1)
>> -#define ATOM_DB_MSIX_VECTOR_COUNT    34
>> -#define ATOM_DB_MSIX_VECTOR_SHIFT    1
>> -#define ATOM_DB_TOTAL_SHIFT          34
>> -#define ATOM_SPAD_COUNT                      16
>> -
>> -#define ATOM_NTB_CTL_DOWN_BIT                BIT(16)
>> -#define ATOM_NTB_CTL_ACTIVE(x)               !(x & ATOM_NTB_CTL_DOWN_BIT)
>> -
>> -#define ATOM_DESKEWSTS_DBERR         BIT(15)
>> -#define ATOM_LTSSMERRSTS0_UNEXPECTEDEI       BIT(20)
>> -#define ATOM_LTSSMSTATEJMP_FORCEDETECT       BIT(2)
>> -#define ATOM_IBIST_ERR_OFLOW         0x7FFF7FFF
>> -
>> -#define ATOM_LINK_HB_TIMEOUT         msecs_to_jiffies(1000)
>> -#define ATOM_LINK_RECOVERY_TIME              msecs_to_jiffies(500)
>> -
>>  /* Ntb control and link status */
>>
>>  #define NTB_CTL_CFG_LOCK             BIT(0)
>
>
