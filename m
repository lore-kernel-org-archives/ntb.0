Return-Path: <dave.jiang@intel.com>
Received: from mga05.intel.com (mga05.intel.com. [192.55.52.43])
        by gmr-mx.google.com with ESMTPS id f20si476984oth.2.2017.11.18.18.02.56
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Nov 2017 18:02:56 -0800 (PST)
From: "Jiang, Dave" <dave.jiang@intel.com>
Subject: Re: [PATCH] ntb: remove Intel Atom NTB driver support
Date: Sun, 19 Nov 2017 02:02:53 +0000
Message-ID: <C2279C74-DD3A-4334-87CA-0791D4BAE6B0@intel.com>
References: <151035618716.31660.7327782780368336511.stgit@djiang5-desk3.ch.intel.com>
 <000101d35c88$9430f360$bc92da20$@dell.com>,<CAPoiz9wn3f5x-aCJTMx7S6xS=uiG2ZYOJHxiAk2Unrqc58EbiQ@mail.gmail.com>
In-Reply-To: <CAPoiz9wn3f5x-aCJTMx7S6xS=uiG2ZYOJHxiAk2Unrqc58EbiQ@mail.gmail.com>
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_C2279C74DD3A433487CA0791D4BAE6B0intelcom_"
MIME-Version: 1.0
Return-Path: dave.jiang@intel.com
To: Jon Mason <jdmason@kudzu.us>
Cc: Allen Hubbe <Allen.Hubbe@dell.com>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

--_000_C2279C74DD3A433487CA0791D4BAE6B0intelcom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I think you need the other patch first maybe?

On Nov 18, 2017, at 6:56 PM, Jon Mason <jdmason@kudzu.us<mailto:jdmason@kud=
zu.us>> wrote:

This patch didn't apply.  Can you rebase and resend?

Thanks,
Jon

On Mon, Nov 13, 2017 at 9:06 AM, Allen Hubbe <Allen.Hubbe@dell.com<mailto:A=
llen.Hubbe@dell.com>> wrote:
From: Dave Jiang
Removing dead code since this is not being used.

Signed-off-by: Dave Jiang <dave.jiang@intel.com<mailto:dave.jiang@intel.com=
>>

Acked-by: Allen Hubbe <Allen.Hubbe@dell.com<mailto:Allen.Hubbe@dell.com>>

---
drivers/ntb/hw/intel/ntb_hw_intel.c |  309 --------------------------------=
---
drivers/ntb/hw/intel/ntb_hw_intel.h |   58 -------
2 files changed, 4 insertions(+), 363 deletions(-)

diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.c b/drivers/ntb/hw/intel/ntb=
_hw_intel.c
index c1d2f85..94c0737 100644
--- a/drivers/ntb/hw/intel/ntb_hw_intel.c
+++ b/drivers/ntb/hw/intel/ntb_hw_intel.c
@@ -74,12 +74,6 @@ MODULE_AUTHOR("Intel Corporation");
#define bar0_off(base, bar) ((base) + ((bar) << 2))
#define bar2_off(base, bar) bar0_off(base, (bar) - 2)

-static const struct intel_ntb_reg atom_reg;
-static const struct intel_ntb_alt_reg atom_pri_reg;
-static const struct intel_ntb_alt_reg atom_sec_reg;
-static const struct intel_ntb_alt_reg atom_b2b_reg;
-static const struct intel_ntb_xlat_reg atom_pri_xlat;
-static const struct intel_ntb_xlat_reg atom_sec_xlat;
static const struct intel_ntb_reg xeon_reg;
static const struct intel_ntb_alt_reg xeon_pri_reg;
static const struct intel_ntb_alt_reg xeon_sec_reg;
@@ -184,15 +178,6 @@ static inline void _iowrite64(u64 val, void __iomem *m=
mio)
#endif
#endif

-static inline int pdev_is_atom(struct pci_dev *pdev)
-{
-     switch (pdev->device) {
-     case PCI_DEVICE_ID_INTEL_NTB_B2B_BWD:
-             return 1;
-     }
-     return 0;
-}
-
static inline int pdev_is_xeon(struct pci_dev *pdev)
{
     switch (pdev->device) {
@@ -1015,8 +1000,7 @@ static ssize_t ndev_debugfs_read(struct file *filp, c=
har __user *ubuf,
{
     struct intel_ntb_dev *ndev =3D filp->private_data;

-     if (pdev_is_xeon(ndev->ntb.pdev) ||
-         pdev_is_atom(ndev->ntb.pdev))
+     if (pdev_is_xeon(ndev->ntb.pdev))
             return ndev_ntb_debugfs_read(filp, ubuf, count, offp);
     else if (pdev_is_xeon_ntb3(ndev->ntb.pdev))
             return ndev_ntb3_debugfs_read(filp, ubuf, count, offp);
@@ -1448,242 +1432,6 @@ static int intel_ntb_peer_spad_write(struct ntb_dev=
 *ntb, int pidx,
                            ndev->peer_reg->spad);
}

-/* ATOM */
-
-static u64 atom_db_ioread(void __iomem *mmio)
-{
-     return ioread64(mmio);
-}
-
-static void atom_db_iowrite(u64 bits, void __iomem *mmio)
-{
-     iowrite64(bits, mmio);
-}
-
-static int atom_poll_link(struct intel_ntb_dev *ndev)
-{
-     u32 ntb_ctl;
-
-     ntb_ctl =3D ioread32(ndev->self_mmio + ATOM_NTBCNTL_OFFSET);
-
-     if (ntb_ctl =3D=3D ndev->ntb_ctl)
-             return 0;
-
-     ndev->ntb_ctl =3D ntb_ctl;
-
-     ndev->lnk_sta =3D ioread32(ndev->self_mmio + ATOM_LINK_STATUS_OFFSET)=
;
-
-     return 1;
-}
-
-static int atom_link_is_up(struct intel_ntb_dev *ndev)
-{
-     return ATOM_NTB_CTL_ACTIVE(ndev->ntb_ctl);
-}
-
-static int atom_link_is_err(struct intel_ntb_dev *ndev)
-{
-     if (ioread32(ndev->self_mmio + ATOM_LTSSMSTATEJMP_OFFSET)
-         & ATOM_LTSSMSTATEJMP_FORCEDETECT)
-             return 1;
-
-     if (ioread32(ndev->self_mmio + ATOM_IBSTERRRCRVSTS0_OFFSET)
-         & ATOM_IBIST_ERR_OFLOW)
-             return 1;
-
-     return 0;
-}
-
-static inline enum ntb_topo atom_ppd_topo(struct intel_ntb_dev *ndev, u32 =
ppd)
-{
-     struct device *dev =3D &ndev->ntb.pdev->dev;
-
-     switch (ppd & ATOM_PPD_TOPO_MASK) {
-     case ATOM_PPD_TOPO_B2B_USD:
-             dev_dbg(dev, "PPD %d B2B USD\n", ppd);
-             return NTB_TOPO_B2B_USD;
-
-     case ATOM_PPD_TOPO_B2B_DSD:
-             dev_dbg(dev, "PPD %d B2B DSD\n", ppd);
-             return NTB_TOPO_B2B_DSD;
-
-     case ATOM_PPD_TOPO_PRI_USD:
-     case ATOM_PPD_TOPO_PRI_DSD: /* accept bogus PRI_DSD */
-     case ATOM_PPD_TOPO_SEC_USD:
-     case ATOM_PPD_TOPO_SEC_DSD: /* accept bogus SEC_DSD */
-             dev_dbg(dev, "PPD %d non B2B disabled\n", ppd);
-             return NTB_TOPO_NONE;
-     }
-
-     dev_dbg(dev, "PPD %d invalid\n", ppd);
-     return NTB_TOPO_NONE;
-}
-
-static void atom_link_hb(struct work_struct *work)
-{
-     struct intel_ntb_dev *ndev =3D hb_ndev(work);
-     struct device *dev =3D &ndev->ntb.pdev->dev;
-     unsigned long poll_ts;
-     void __iomem *mmio;
-     u32 status32;
-
-     poll_ts =3D ndev->last_ts + ATOM_LINK_HB_TIMEOUT;
-
-     /* Delay polling the link status if an interrupt was received,
-      * unless the cached link status says the link is down.
-      */
-     if (time_after(poll_ts, jiffies) && atom_link_is_up(ndev)) {
-             schedule_delayed_work(&ndev->hb_timer, poll_ts - jiffies);
-             return;
-     }
-
-     if (atom_poll_link(ndev))
-             ntb_link_event(&ndev->ntb);
-
-     if (atom_link_is_up(ndev) || !atom_link_is_err(ndev)) {
-             schedule_delayed_work(&ndev->hb_timer, ATOM_LINK_HB_TIMEOUT);
-             return;
-     }
-
-     /* Link is down with error: recover the link! */
-
-     mmio =3D ndev->self_mmio;
-
-     /* Driver resets the NTB ModPhy lanes - magic! */
-     iowrite8(0xe0, mmio + ATOM_MODPHY_PCSREG6);
-     iowrite8(0x40, mmio + ATOM_MODPHY_PCSREG4);
-     iowrite8(0x60, mmio + ATOM_MODPHY_PCSREG4);
-     iowrite8(0x60, mmio + ATOM_MODPHY_PCSREG6);
-
-     /* Driver waits 100ms to allow the NTB ModPhy to settle */
-     msleep(100);
-
-     /* Clear AER Errors, write to clear */
-     status32 =3D ioread32(mmio + ATOM_ERRCORSTS_OFFSET);
-     dev_dbg(dev, "ERRCORSTS =3D %x\n", status32);
-     status32 &=3D PCI_ERR_COR_REP_ROLL;
-     iowrite32(status32, mmio + ATOM_ERRCORSTS_OFFSET);
-
-     /* Clear unexpected electrical idle event in LTSSM, write to clear */
-     status32 =3D ioread32(mmio + ATOM_LTSSMERRSTS0_OFFSET);
-     dev_dbg(dev, "LTSSMERRSTS0 =3D %x\n", status32);
-     status32 |=3D ATOM_LTSSMERRSTS0_UNEXPECTEDEI;
-     iowrite32(status32, mmio + ATOM_LTSSMERRSTS0_OFFSET);
-
-     /* Clear DeSkew Buffer error, write to clear */
-     status32 =3D ioread32(mmio + ATOM_DESKEWSTS_OFFSET);
-     dev_dbg(dev, "DESKEWSTS =3D %x\n", status32);
-     status32 |=3D ATOM_DESKEWSTS_DBERR;
-     iowrite32(status32, mmio + ATOM_DESKEWSTS_OFFSET);
-
-     status32 =3D ioread32(mmio + ATOM_IBSTERRRCRVSTS0_OFFSET);
-     dev_dbg(dev, "IBSTERRRCRVSTS0 =3D %x\n", status32);
-     status32 &=3D ATOM_IBIST_ERR_OFLOW;
-     iowrite32(status32, mmio + ATOM_IBSTERRRCRVSTS0_OFFSET);
-
-     /* Releases the NTB state machine to allow the link to retrain */
-     status32 =3D ioread32(mmio + ATOM_LTSSMSTATEJMP_OFFSET);
-     dev_dbg(dev, "LTSSMSTATEJMP =3D %x\n", status32);
-     status32 &=3D ~ATOM_LTSSMSTATEJMP_FORCEDETECT;
-     iowrite32(status32, mmio + ATOM_LTSSMSTATEJMP_OFFSET);
-
-     /* There is a potential race between the 2 NTB devices recovering at =
the
-      * same time.  If the times are the same, the link will not recover a=
nd
-      * the driver will be stuck in this loop forever.  Add a random inter=
val
-      * to the recovery time to prevent this race.
-      */
-     schedule_delayed_work(&ndev->hb_timer, ATOM_LINK_RECOVERY_TIME
-                           + prandom_u32() % ATOM_LINK_RECOVERY_TIME);
-}
-
-static int atom_init_isr(struct intel_ntb_dev *ndev)
-{
-     int rc;
-
-     rc =3D ndev_init_isr(ndev, 1, ATOM_DB_MSIX_VECTOR_COUNT,
-                        ATOM_DB_MSIX_VECTOR_SHIFT, ATOM_DB_TOTAL_SHIFT);
-     if (rc)
-             return rc;
-
-     /* ATOM doesn't have link status interrupt, poll on that platform */
-     ndev->last_ts =3D jiffies;
-     INIT_DELAYED_WORK(&ndev->hb_timer, atom_link_hb);
-     schedule_delayed_work(&ndev->hb_timer, ATOM_LINK_HB_TIMEOUT);
-
-     return 0;
-}
-
-static void atom_deinit_isr(struct intel_ntb_dev *ndev)
-{
-     cancel_delayed_work_sync(&ndev->hb_timer);
-     ndev_deinit_isr(ndev);
-}
-
-static int atom_init_ntb(struct intel_ntb_dev *ndev)
-{
-     ndev->mw_count =3D ATOM_MW_COUNT;
-     ndev->spad_count =3D ATOM_SPAD_COUNT;
-     ndev->db_count =3D ATOM_DB_COUNT;
-
-     switch (ndev->ntb.topo) {
-     case NTB_TOPO_B2B_USD:
-     case NTB_TOPO_B2B_DSD:
-             ndev->self_reg =3D &atom_pri_reg;
-             ndev->peer_reg =3D &atom_b2b_reg;
-             ndev->xlat_reg =3D &atom_sec_xlat;
-
-             /* Enable Bus Master and Memory Space on the secondary side *=
/
-             iowrite16(PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER,
-                       ndev->self_mmio + ATOM_SPCICMD_OFFSET);
-
-             break;
-
-     default:
-             return -EINVAL;
-     }
-
-     ndev->db_valid_mask =3D BIT_ULL(ndev->db_count) - 1;
-
-     return 0;
-}
-
-static int atom_init_dev(struct intel_ntb_dev *ndev)
-{
-     u32 ppd;
-     int rc;
-
-     rc =3D pci_read_config_dword(ndev->ntb.pdev, ATOM_PPD_OFFSET, &ppd);
-     if (rc)
-             return -EIO;
-
-     ndev->ntb.topo =3D atom_ppd_topo(ndev, ppd);
-     if (ndev->ntb.topo =3D=3D NTB_TOPO_NONE)
-             return -EINVAL;
-
-     rc =3D atom_init_ntb(ndev);
-     if (rc)
-             return rc;
-
-     rc =3D atom_init_isr(ndev);
-     if (rc)
-             return rc;
-
-     if (ndev->ntb.topo !=3D NTB_TOPO_SEC) {
-             /* Initiate PCI-E link training */
-             rc =3D pci_write_config_dword(ndev->ntb.pdev, ATOM_PPD_OFFSET=
,
-                                         ppd | ATOM_PPD_INIT_LINK);
-             if (rc)
-                     return rc;
-     }
-
-     return 0;
-}
-
-static void atom_deinit_dev(struct intel_ntb_dev *ndev)
-{
-     atom_deinit_isr(ndev);
-}
-
/* Skylake Xeon NTB */

static int skx_poll_link(struct intel_ntb_dev *ndev)
@@ -2738,24 +2486,7 @@ static int intel_ntb_pci_probe(struct pci_dev *pdev,

     node =3D dev_to_node(&pdev->dev);

-     if (pdev_is_atom(pdev)) {
-             ndev =3D kzalloc_node(sizeof(*ndev), GFP_KERNEL, node);
-             if (!ndev) {
-                     rc =3D -ENOMEM;
-                     goto err_ndev;
-             }
-
-             ndev_init_struct(ndev, pdev);
-
-             rc =3D intel_ntb_init_pci(ndev, pdev);
-             if (rc)
-                     goto err_init_pci;
-
-             rc =3D atom_init_dev(ndev);
-             if (rc)
-                     goto err_init_dev;
-
-     } else if (pdev_is_xeon(pdev)) {
+     if (pdev_is_xeon(pdev)) {
             ndev =3D kzalloc_node(sizeof(*ndev), GFP_KERNEL, node);
             if (!ndev) {
                     rc =3D -ENOMEM;
@@ -2811,9 +2542,7 @@ static int intel_ntb_pci_probe(struct pci_dev *pdev,

err_register:
     ndev_deinit_debugfs(ndev);
-     if (pdev_is_atom(pdev))
-             atom_deinit_dev(ndev);
-     else if (pdev_is_xeon(pdev) || pdev_is_xeon_ntb3(pdev))
+     if (pdev_is_xeon(pdev) || pdev_is_xeon_ntb3(pdev))
             xeon_deinit_dev(ndev);
err_init_dev:
     intel_ntb_deinit_pci(ndev);
@@ -2829,41 +2558,12 @@ static void intel_ntb_pci_remove(struct pci_dev *pd=
ev)

     ntb_unregister_device(&ndev->ntb);
     ndev_deinit_debugfs(ndev);
-     if (pdev_is_atom(pdev))
-             atom_deinit_dev(ndev);
-     else if (pdev_is_xeon(pdev) || pdev_is_xeon_ntb3(pdev))
+     if (pdev_is_xeon(pdev) || pdev_is_xeon_ntb3(pdev))
             xeon_deinit_dev(ndev);
     intel_ntb_deinit_pci(ndev);
     kfree(ndev);
}

-static const struct intel_ntb_reg atom_reg =3D {
-     .poll_link              =3D atom_poll_link,
-     .link_is_up             =3D atom_link_is_up,
-     .db_ioread              =3D atom_db_ioread,
-     .db_iowrite             =3D atom_db_iowrite,
-     .db_size                =3D sizeof(u64),
-     .ntb_ctl                =3D ATOM_NTBCNTL_OFFSET,
-     .mw_bar                 =3D {2, 4},
-};
-
-static const struct intel_ntb_alt_reg atom_pri_reg =3D {
-     .db_bell                =3D ATOM_PDOORBELL_OFFSET,
-     .db_mask                =3D ATOM_PDBMSK_OFFSET,
-     .spad                   =3D ATOM_SPAD_OFFSET,
-};
-
-static const struct intel_ntb_alt_reg atom_b2b_reg =3D {
-     .db_bell                =3D ATOM_B2B_DOORBELL_OFFSET,
-     .spad                   =3D ATOM_B2B_SPAD_OFFSET,
-};
-
-static const struct intel_ntb_xlat_reg atom_sec_xlat =3D {
-     /* FIXME : .bar0_base   =3D ATOM_SBAR0BASE_OFFSET, */
-     /* FIXME : .bar2_limit  =3D ATOM_SBAR2LMT_OFFSET, */
-     .bar2_xlat              =3D ATOM_SBAR2XLAT_OFFSET,
-};
-
static const struct intel_ntb_reg xeon_reg =3D {
     .poll_link              =3D xeon_poll_link,
     .link_is_up             =3D xeon_link_is_up,
@@ -3020,7 +2720,6 @@ static const struct file_operations intel_ntb_debugfs=
_info =3D {
};

static const struct pci_device_id intel_ntb_pci_tbl[] =3D {
-     {PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_NTB_B2B_BWD)},
     {PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_NTB_B2B_JSF)},
     {PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_NTB_B2B_SNB)},
     {PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_NTB_B2B_IVT)},
diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.h b/drivers/ntb/hw/intel/ntb=
_hw_intel.h
index a8b17f3..9d2c6b6 100644
--- a/drivers/ntb/hw/intel/ntb_hw_intel.h
+++ b/drivers/ntb/hw/intel/ntb_hw_intel.h
@@ -66,7 +66,6 @@
#define PCI_DEVICE_ID_INTEL_NTB_B2B_HSX      0x2F0D
#define PCI_DEVICE_ID_INTEL_NTB_PS_HSX       0x2F0E
#define PCI_DEVICE_ID_INTEL_NTB_SS_HSX       0x2F0F
-#define PCI_DEVICE_ID_INTEL_NTB_B2B_BWD      0x0C4E
#define PCI_DEVICE_ID_INTEL_NTB_B2B_BDX      0x6F0D
#define PCI_DEVICE_ID_INTEL_NTB_PS_BDX       0x6F0E
#define PCI_DEVICE_ID_INTEL_NTB_SS_BDX       0x6F0F
@@ -197,63 +196,6 @@
#define SKX_DB_TOTAL_SHIFT           33
#define SKX_SPAD_COUNT                       16

-/* Intel Atom hardware */
-
-#define ATOM_SBAR2XLAT_OFFSET                0x0008
-#define ATOM_PDOORBELL_OFFSET                0x0020
-#define ATOM_PDBMSK_OFFSET           0x0028
-#define ATOM_NTBCNTL_OFFSET          0x0060
-#define ATOM_SPAD_OFFSET                     0x0080
-#define ATOM_PPD_OFFSET                      0x00d4
-#define ATOM_PBAR2XLAT_OFFSET                0x8008
-#define ATOM_B2B_DOORBELL_OFFSET             0x8020
-#define ATOM_B2B_SPAD_OFFSET         0x8080
-#define ATOM_SPCICMD_OFFSET          0xb004
-#define ATOM_LINK_STATUS_OFFSET              0xb052
-#define ATOM_ERRCORSTS_OFFSET                0xb110
-#define ATOM_IP_BASE                 0xc000
-#define ATOM_DESKEWSTS_OFFSET                (ATOM_IP_BASE + 0x3024)
-#define ATOM_LTSSMERRSTS0_OFFSET             (ATOM_IP_BASE + 0x3180)
-#define ATOM_LTSSMSTATEJMP_OFFSET    (ATOM_IP_BASE + 0x3040)
-#define ATOM_IBSTERRRCRVSTS0_OFFSET  (ATOM_IP_BASE + 0x3324)
-#define ATOM_MODPHY_PCSREG4          0x1c004
-#define ATOM_MODPHY_PCSREG6          0x1c006
-
-#define ATOM_PPD_INIT_LINK           0x0008
-#define ATOM_PPD_CONN_MASK           0x0300
-#define ATOM_PPD_CONN_TRANSPARENT    0x0000
-#define ATOM_PPD_CONN_B2B            0x0100
-#define ATOM_PPD_CONN_RP                     0x0200
-#define ATOM_PPD_DEV_MASK            0x1000
-#define ATOM_PPD_DEV_USD                     0x0000
-#define ATOM_PPD_DEV_DSD                     0x1000
-#define ATOM_PPD_TOPO_MASK   (ATOM_PPD_CONN_MASK | ATOM_PPD_DEV_MASK)
-#define ATOM_PPD_TOPO_PRI_USD        (ATOM_PPD_CONN_TRANSPARENT | ATOM_PPD=
_DEV_USD)
-#define ATOM_PPD_TOPO_PRI_DSD        (ATOM_PPD_CONN_TRANSPARENT | ATOM_PPD=
_DEV_DSD)
-#define ATOM_PPD_TOPO_SEC_USD        (ATOM_PPD_CONN_RP | ATOM_PPD_DEV_USD)
-#define ATOM_PPD_TOPO_SEC_DSD        (ATOM_PPD_CONN_RP | ATOM_PPD_DEV_DSD)
-#define ATOM_PPD_TOPO_B2B_USD        (ATOM_PPD_CONN_B2B | ATOM_PPD_DEV_USD=
)
-#define ATOM_PPD_TOPO_B2B_DSD        (ATOM_PPD_CONN_B2B | ATOM_PPD_DEV_DSD=
)
-
-#define ATOM_MW_COUNT                        2
-#define ATOM_DB_COUNT                        34
-#define ATOM_DB_VALID_MASK           (BIT_ULL(ATOM_DB_COUNT) - 1)
-#define ATOM_DB_MSIX_VECTOR_COUNT    34
-#define ATOM_DB_MSIX_VECTOR_SHIFT    1
-#define ATOM_DB_TOTAL_SHIFT          34
-#define ATOM_SPAD_COUNT                      16
-
-#define ATOM_NTB_CTL_DOWN_BIT                BIT(16)
-#define ATOM_NTB_CTL_ACTIVE(x)               !(x & ATOM_NTB_CTL_DOWN_BIT)
-
-#define ATOM_DESKEWSTS_DBERR         BIT(15)
-#define ATOM_LTSSMERRSTS0_UNEXPECTEDEI       BIT(20)
-#define ATOM_LTSSMSTATEJMP_FORCEDETECT       BIT(2)
-#define ATOM_IBIST_ERR_OFLOW         0x7FFF7FFF
-
-#define ATOM_LINK_HB_TIMEOUT         msecs_to_jiffies(1000)
-#define ATOM_LINK_RECOVERY_TIME              msecs_to_jiffies(500)
-
/* Ntb control and link status */

#define NTB_CTL_CFG_LOCK             BIT(0)



--
You received this message because you are subscribed to the Google Groups "=
linux-ntb" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-ntb+unsubscribe@googlegroups.com<mailto:linux-ntb+unsubscribe=
@googlegroups.com>.
To post to this group, send email to linux-ntb@googlegroups.com<mailto:linu=
x-ntb@googlegroups.com>.
To view this discussion on the web visit https://groups.google.com/d/msgid/=
linux-ntb/CAPoiz9wn3f5x-aCJTMx7S6xS%3DuiG2ZYOJHxiAk2Unrqc58EbiQ%40mail.gmai=
l.com.
For more options, visit https://groups.google.com/d/optout.

--_000_C2279C74DD3A433487CA0791D4BAE6B0intelcom_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body dir=3D"auto">
<div></div>
<div>I think you need the other patch first maybe?</div>
<div><br>
On Nov 18, 2017, at 6:56 PM, Jon Mason &lt;<a href=3D"mailto:jdmason@kudzu.=
us">jdmason@kudzu.us</a>&gt; wrote:<br>
<br>
</div>
<blockquote type=3D"cite">
<div><span>This patch didn't apply. &nbsp;Can you rebase and resend?</span>=
<br>
<span></span><br>
<span>Thanks,</span><br>
<span>Jon</span><br>
<span></span><br>
<span>On Mon, Nov 13, 2017 at 9:06 AM, Allen Hubbe &lt;<a href=3D"mailto:Al=
len.Hubbe@dell.com">Allen.Hubbe@dell.com</a>&gt; wrote:</span><br>
<blockquote type=3D"cite"><span>From: Dave Jiang</span><br>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>Removing dead code since this is not being =
used.</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span></span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>Signed-off-by: Dave Jiang &lt;<a href=3D"ma=
ilto:dave.jiang@intel.com">dave.jiang@intel.com</a>&gt;</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite"><span></span><br>
</blockquote>
<blockquote type=3D"cite"><span>Acked-by: Allen Hubbe &lt;<a href=3D"mailto=
:Allen.Hubbe@dell.com">Allen.Hubbe@dell.com</a>&gt;</span><br>
</blockquote>
<blockquote type=3D"cite"><span></span><br>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>---</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>drivers/ntb/hw/intel/ntb_hw_intel.c | &nbsp=
;309 -----------------------------------</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>drivers/ntb/hw/intel/ntb_hw_intel.h | &nbsp=
;&nbsp;58 -------</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>2 files changed, 4 insertions(&#43;), 363 d=
eletions(-)</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span></span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>diff --git a/drivers/ntb/hw/intel/ntb_hw_in=
tel.c b/drivers/ntb/hw/intel/ntb_hw_intel.c</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>index c1d2f85..94c0737 100644</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>--- a/drivers/ntb/hw/intel/ntb_hw_intel.c</=
span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>&#43;&#43;&#43; b/drivers/ntb/hw/intel/ntb_=
hw_intel.c</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>@@ -74,12 &#43;74,6 @@ MODULE_AUTHOR(&quot;=
Intel Corporation&quot;);</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>#define bar0_off(base, bar) ((base) &#43; (=
(bar) &lt;&lt; 2))</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>#define bar2_off(base, bar) bar0_off(base, =
(bar) - 2)</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span></span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-static const struct intel_ntb_reg atom_reg=
;</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-static const struct intel_ntb_alt_reg atom=
_pri_reg;</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-static const struct intel_ntb_alt_reg atom=
_sec_reg;</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-static const struct intel_ntb_alt_reg atom=
_b2b_reg;</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-static const struct intel_ntb_xlat_reg ato=
m_pri_xlat;</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-static const struct intel_ntb_xlat_reg ato=
m_sec_xlat;</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>static const struct intel_ntb_reg xeon_reg;=
</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>static const struct intel_ntb_alt_reg xeon_=
pri_reg;</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>static const struct intel_ntb_alt_reg xeon_=
sec_reg;</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>@@ -184,15 &#43;178,6 @@ static inline void=
 _iowrite64(u64 val, void __iomem *mmio)</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>#endif</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>#endif</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span></span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-static inline int pdev_is_atom(struct pci_=
dev *pdev)</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-{</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;switch (pdev-&gt;=
device) {</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;case PCI_DEVICE_I=
D_INTEL_NTB_B2B_BWD:</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return 1;</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;}</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;return 0;</span><=
br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-}</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>static inline int pdev_is_xeon(struct pci_d=
ev *pdev)</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>{</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;switch (pdev-=
&gt;device) {</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>@@ -1015,8 &#43;1000,7 @@ static ssize_t nd=
ev_debugfs_read(struct file *filp, char __user *ubuf,</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>{</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;struct intel_=
ntb_dev *ndev =3D filp-&gt;private_data;</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span></span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;if (pdev_is_xeon(=
ndev-&gt;ntb.pdev) ||</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;pdev_is_atom(ndev-&gt;ntb.pdev))</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>&#43; &nbsp;&nbsp;&nbsp;&nbsp;if (pdev_is_x=
eon(ndev-&gt;ntb.pdev))</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return ndev_ntb_debugfs_read(filp, ubuf,=
 count, offp);</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;else if (pdev=
_is_xeon_ntb3(ndev-&gt;ntb.pdev))</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return ndev_ntb3_debugfs_read(filp, ubuf=
, count, offp);</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>@@ -1448,242 &#43;1432,6 @@ static int inte=
l_ntb_peer_spad_write(struct ntb_dev *ntb, int pidx,</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ndev-&gt;peer_reg-&gt;spa=
d);</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>}</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span></span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-/* ATOM */</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-static u64 atom_db_ioread(void __iomem *mm=
io)</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-{</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;return ioread64(m=
mio);</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-}</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-static void atom_db_iowrite(u64 bits, void=
 __iomem *mmio)</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-{</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;iowrite64(bits, m=
mio);</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-}</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-static int atom_poll_link(struct intel_ntb=
_dev *ndev)</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-{</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;u32 ntb_ctl;</spa=
n><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;ntb_ctl =3D iorea=
d32(ndev-&gt;self_mmio &#43; ATOM_NTBCNTL_OFFSET);</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;if (ntb_ctl =3D=
=3D ndev-&gt;ntb_ctl)</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return 0;</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;ndev-&gt;ntb_ctl =
=3D ntb_ctl;</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;ndev-&gt;lnk_sta =
=3D ioread32(ndev-&gt;self_mmio &#43; ATOM_LINK_STATUS_OFFSET);</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;return 1;</span><=
br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-}</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-static int atom_link_is_up(struct intel_nt=
b_dev *ndev)</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-{</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;return ATOM_NTB_C=
TL_ACTIVE(ndev-&gt;ntb_ctl);</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-}</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-static int atom_link_is_err(struct intel_n=
tb_dev *ndev)</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-{</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;if (ioread32(ndev=
-&gt;self_mmio &#43; ATOM_LTSSMSTATEJMP_OFFSET)</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&amp; ATOM_LTSSMSTATEJMP_FORCEDETECT)</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return 1;</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;if (ioread32(ndev=
-&gt;self_mmio &#43; ATOM_IBSTERRRCRVSTS0_OFFSET)</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&amp; ATOM_IBIST_ERR_OFLOW)</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return 1;</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;return 0;</span><=
br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-}</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-static inline enum ntb_topo atom_ppd_topo(=
struct intel_ntb_dev *ndev, u32 ppd)</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-{</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;struct device *de=
v =3D &amp;ndev-&gt;ntb.pdev-&gt;dev;</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;switch (ppd &amp;=
 ATOM_PPD_TOPO_MASK) {</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;case ATOM_PPD_TOP=
O_B2B_USD:</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;dev_dbg(dev, &quot;PPD %d B2B USD\n&quot;, p=
pd);</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return NTB_TOPO_B2B_USD;</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;case ATOM_PPD_TOP=
O_B2B_DSD:</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;dev_dbg(dev, &quot;PPD %d B2B DSD\n&quot;, p=
pd);</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return NTB_TOPO_B2B_DSD;</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;case ATOM_PPD_TOP=
O_PRI_USD:</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;case ATOM_PPD_TOP=
O_PRI_DSD: /* accept bogus PRI_DSD */</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;case ATOM_PPD_TOP=
O_SEC_USD:</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;case ATOM_PPD_TOP=
O_SEC_DSD: /* accept bogus SEC_DSD */</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;dev_dbg(dev, &quot;PPD %d non B2B disabled\n=
&quot;, ppd);</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return NTB_TOPO_NONE;</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;}</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;dev_dbg(dev, &quo=
t;PPD %d invalid\n&quot;, ppd);</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;return NTB_TOPO_N=
ONE;</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-}</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-static void atom_link_hb(struct work_struc=
t *work)</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-{</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;struct intel_ntb_=
dev *ndev =3D hb_ndev(work);</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;struct device *de=
v =3D &amp;ndev-&gt;ntb.pdev-&gt;dev;</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;unsigned long pol=
l_ts;</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;void __iomem *mmi=
o;</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;u32 status32;</sp=
an><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;poll_ts =3D ndev-=
&gt;last_ts &#43; ATOM_LINK_HB_TIMEOUT;</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;/* Delay polling =
the link status if an interrupt was received,</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* unless th=
e cached link status says the link is down.</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*/</span><b=
r>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;if (time_after(po=
ll_ts, jiffies) &amp;&amp; atom_link_is_up(ndev)) {</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;schedule_delayed_work(&amp;ndev-&gt;hb_timer=
, poll_ts - jiffies);</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return;</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;}</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;if (atom_poll_lin=
k(ndev))</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ntb_link_event(&amp;ndev-&gt;ntb);</span><br=
>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;if (atom_link_is_=
up(ndev) || !atom_link_is_err(ndev)) {</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;schedule_delayed_work(&amp;ndev-&gt;hb_timer=
, ATOM_LINK_HB_TIMEOUT);</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return;</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;}</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;/* Link is down w=
ith error: recover the link! */</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;mmio =3D ndev-&gt=
;self_mmio;</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;/* Driver resets =
the NTB ModPhy lanes - magic! */</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;iowrite8(0xe0, mm=
io &#43; ATOM_MODPHY_PCSREG6);</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;iowrite8(0x40, mm=
io &#43; ATOM_MODPHY_PCSREG4);</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;iowrite8(0x60, mm=
io &#43; ATOM_MODPHY_PCSREG4);</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;iowrite8(0x60, mm=
io &#43; ATOM_MODPHY_PCSREG6);</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;/* Driver waits 1=
00ms to allow the NTB ModPhy to settle */</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;msleep(100);</spa=
n><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;/* Clear AER Erro=
rs, write to clear */</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;status32 =3D iore=
ad32(mmio &#43; ATOM_ERRCORSTS_OFFSET);</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;dev_dbg(dev, &quo=
t;ERRCORSTS =3D %x\n&quot;, status32);</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;status32 &amp;=3D=
 PCI_ERR_COR_REP_ROLL;</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;iowrite32(status3=
2, mmio &#43; ATOM_ERRCORSTS_OFFSET);</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;/* Clear unexpect=
ed electrical idle event in LTSSM, write to clear */</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;status32 =3D iore=
ad32(mmio &#43; ATOM_LTSSMERRSTS0_OFFSET);</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;dev_dbg(dev, &quo=
t;LTSSMERRSTS0 =3D %x\n&quot;, status32);</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;status32 |=3D ATO=
M_LTSSMERRSTS0_UNEXPECTEDEI;</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;iowrite32(status3=
2, mmio &#43; ATOM_LTSSMERRSTS0_OFFSET);</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;/* Clear DeSkew B=
uffer error, write to clear */</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;status32 =3D iore=
ad32(mmio &#43; ATOM_DESKEWSTS_OFFSET);</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;dev_dbg(dev, &quo=
t;DESKEWSTS =3D %x\n&quot;, status32);</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;status32 |=3D ATO=
M_DESKEWSTS_DBERR;</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;iowrite32(status3=
2, mmio &#43; ATOM_DESKEWSTS_OFFSET);</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;status32 =3D iore=
ad32(mmio &#43; ATOM_IBSTERRRCRVSTS0_OFFSET);</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;dev_dbg(dev, &quo=
t;IBSTERRRCRVSTS0 =3D %x\n&quot;, status32);</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;status32 &amp;=3D=
 ATOM_IBIST_ERR_OFLOW;</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;iowrite32(status3=
2, mmio &#43; ATOM_IBSTERRRCRVSTS0_OFFSET);</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;/* Releases the N=
TB state machine to allow the link to retrain */</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;status32 =3D iore=
ad32(mmio &#43; ATOM_LTSSMSTATEJMP_OFFSET);</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;dev_dbg(dev, &quo=
t;LTSSMSTATEJMP =3D %x\n&quot;, status32);</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;status32 &amp;=3D=
 ~ATOM_LTSSMSTATEJMP_FORCEDETECT;</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;iowrite32(status3=
2, mmio &#43; ATOM_LTSSMSTATEJMP_OFFSET);</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;/* There is a pot=
ential race between the 2 NTB devices recovering at the</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* same time=
. &nbsp;If the times are the same, the link will not recover and</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* the drive=
r will be stuck in this loop forever. &nbsp;Add a random interval</span><br=
>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* to the re=
covery time to prevent this race.</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*/</span><b=
r>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;schedule_delayed_=
work(&amp;ndev-&gt;hb_timer, ATOM_LINK_RECOVERY_TIME</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#43; prandom_u32() % ATOM_LINK_REC=
OVERY_TIME);</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-}</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-static int atom_init_isr(struct intel_ntb_=
dev *ndev)</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-{</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;int rc;</span><br=
>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;rc =3D ndev_init_=
isr(ndev, 1, ATOM_DB_MSIX_VECTOR_COUNT,</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;ATOM_DB_MSIX_VECTOR_SHIFT, ATOM_DB_TOTAL_SHIFT);</spa=
n><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;if (rc)</span><br=
>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return rc;</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;/* ATOM doesn't h=
ave link status interrupt, poll on that platform */</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;ndev-&gt;last_ts =
=3D jiffies;</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;INIT_DELAYED_WORK=
(&amp;ndev-&gt;hb_timer, atom_link_hb);</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;schedule_delayed_=
work(&amp;ndev-&gt;hb_timer, ATOM_LINK_HB_TIMEOUT);</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;return 0;</span><=
br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-}</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-static void atom_deinit_isr(struct intel_n=
tb_dev *ndev)</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-{</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;cancel_delayed_wo=
rk_sync(&amp;ndev-&gt;hb_timer);</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;ndev_deinit_isr(n=
dev);</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-}</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-static int atom_init_ntb(struct intel_ntb_=
dev *ndev)</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-{</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;ndev-&gt;mw_count=
 =3D ATOM_MW_COUNT;</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;ndev-&gt;spad_cou=
nt =3D ATOM_SPAD_COUNT;</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;ndev-&gt;db_count=
 =3D ATOM_DB_COUNT;</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;switch (ndev-&gt;=
ntb.topo) {</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;case NTB_TOPO_B2B=
_USD:</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;case NTB_TOPO_B2B=
_DSD:</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ndev-&gt;self_reg =3D &amp;atom_pri_reg;</sp=
an><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ndev-&gt;peer_reg =3D &amp;atom_b2b_reg;</sp=
an><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ndev-&gt;xlat_reg =3D &amp;atom_sec_xlat;</s=
pan><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/* Enable Bus Master and Memory Space on the=
 secondary side */</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;iowrite16(PCI_COMMAND_MEMORY | PCI_COMMAND_M=
ASTER,</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;ndev-&gt;self_mmio &#43; ATOM_SPCICMD_OFFSET);</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;break;</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;default:</span><b=
r>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return -EINVAL;</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;}</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;ndev-&gt;db_valid=
_mask =3D BIT_ULL(ndev-&gt;db_count) - 1;</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;return 0;</span><=
br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-}</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-static int atom_init_dev(struct intel_ntb_=
dev *ndev)</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-{</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;u32 ppd;</span><b=
r>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;int rc;</span><br=
>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;rc =3D pci_read_c=
onfig_dword(ndev-&gt;ntb.pdev, ATOM_PPD_OFFSET, &amp;ppd);</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;if (rc)</span><br=
>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return -EIO;</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;ndev-&gt;ntb.topo=
 =3D atom_ppd_topo(ndev, ppd);</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;if (ndev-&gt;ntb.=
topo =3D=3D NTB_TOPO_NONE)</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return -EINVAL;</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;rc =3D atom_init_=
ntb(ndev);</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;if (rc)</span><br=
>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return rc;</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;rc =3D atom_init_=
isr(ndev);</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;if (rc)</span><br=
>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return rc;</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;if (ndev-&gt;ntb.=
topo !=3D NTB_TOPO_SEC) {</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/* Initiate PCI-E link training */</span><br=
>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rc =3D pci_write_config_dword(ndev-&gt;ntb.p=
dev, ATOM_PPD_OFFSET,</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ppd | ATOM_PPD_INIT_LINK);=
</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (rc)</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;return rc;</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;}</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;return 0;</span><=
br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-}</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-static void atom_deinit_dev(struct intel_n=
tb_dev *ndev)</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-{</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;atom_deinit_isr(n=
dev);</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-}</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>/* Skylake Xeon NTB */</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span></span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>static int skx_poll_link(struct intel_ntb_d=
ev *ndev)</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>@@ -2738,24 &#43;2486,7 @@ static int intel=
_ntb_pci_probe(struct pci_dev *pdev,</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span></span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;node =3D dev_=
to_node(&amp;pdev-&gt;dev);</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span></span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;if (pdev_is_atom(=
pdev)) {</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ndev =3D kzalloc_node(sizeof(*ndev), GFP_KER=
NEL, node);</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (!ndev) {</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;rc =3D -ENOMEM;</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;goto err_ndev;</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ndev_init_struct(ndev, pdev);</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rc =3D intel_ntb_init_pci(ndev, pdev);</span=
><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (rc)</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;goto err_init_pci;</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rc =3D atom_init_dev(ndev);</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (rc)</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;goto err_init_dev;</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;} else if (pdev_i=
s_xeon(pdev)) {</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>&#43; &nbsp;&nbsp;&nbsp;&nbsp;if (pdev_is_x=
eon(pdev)) {</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ndev =3D kzalloc_node(sizeof(*ndev), GFP=
_KERNEL, node);</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if (!ndev) {</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;rc =3D -ENOMEM;</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>@@ -2811,9 &#43;2542,7 @@ static int intel_=
ntb_pci_probe(struct pci_dev *pdev,</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span></span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>err_register:</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ndev_deinit_d=
ebugfs(ndev);</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;if (pdev_is_atom(=
pdev))</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;atom_deinit_dev(ndev);</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;else if (pdev_is_=
xeon(pdev) || pdev_is_xeon_ntb3(pdev))</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>&#43; &nbsp;&nbsp;&nbsp;&nbsp;if (pdev_is_x=
eon(pdev) || pdev_is_xeon_ntb3(pdev))</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;xeon_deinit_dev(ndev);</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>err_init_dev:</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;intel_ntb_dei=
nit_pci(ndev);</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>@@ -2829,41 &#43;2558,12 @@ static void int=
el_ntb_pci_remove(struct pci_dev *pdev)</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span></span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ntb_unregiste=
r_device(&amp;ndev-&gt;ntb);</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ndev_deinit_d=
ebugfs(ndev);</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;if (pdev_is_atom(=
pdev))</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;atom_deinit_dev(ndev);</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;else if (pdev_is_=
xeon(pdev) || pdev_is_xeon_ntb3(pdev))</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>&#43; &nbsp;&nbsp;&nbsp;&nbsp;if (pdev_is_x=
eon(pdev) || pdev_is_xeon_ntb3(pdev))</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;xeon_deinit_dev(ndev);</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;intel_ntb_dei=
nit_pci(ndev);</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;kfree(ndev);<=
/span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>}</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span></span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-static const struct intel_ntb_reg atom_reg=
 =3D {</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;.poll_link &nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=3D=
 atom_poll_link,</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;.link_is_up &nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=3D atom=
_link_is_up,</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;.db_ioread &nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=3D=
 atom_db_ioread,</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;.db_iowrite &nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=3D atom=
_db_iowrite,</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;.db_size &nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;=3D sizeof(u64),</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;.ntb_ctl &nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;=3D ATOM_NTBCNTL_OFFSET,</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;.mw_bar &nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;=3D {2, 4},</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-};</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-static const struct intel_ntb_alt_reg atom=
_pri_reg =3D {</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;.db_bell &nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;=3D ATOM_PDOORBELL_OFFSET,</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;.db_mask &nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;=3D ATOM_PDBMSK_OFFSET,</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;.spad &nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=3D ATOM_SPAD_OFFSET,</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-};</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-static const struct intel_ntb_alt_reg atom=
_b2b_reg =3D {</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;.db_bell &nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;=3D ATOM_B2B_DOORBELL_OFFSET,</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;.spad &nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;=3D ATOM_B2B_SPAD_OFFSET,</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-};</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-static const struct intel_ntb_xlat_reg ato=
m_sec_xlat =3D {</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;/* FIXME : .bar0_=
base &nbsp;&nbsp;=3D ATOM_SBAR0BASE_OFFSET, */</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;/* FIXME : .bar2_=
limit &nbsp;=3D ATOM_SBAR2LMT_OFFSET, */</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;.bar2_xlat &nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=3D=
 ATOM_SBAR2XLAT_OFFSET,</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-};</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>static const struct intel_ntb_reg xeon_reg =
=3D {</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.poll_link &n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;=3D xeon_poll_link,</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.link_is_up &=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=3D =
xeon_link_is_up,</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>@@ -3020,7 &#43;2720,6 @@ static const stru=
ct file_operations intel_ntb_debugfs_info =3D {</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>};</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span></span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>static const struct pci_device_id intel_ntb=
_pci_tbl[] =3D {</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>- &nbsp;&nbsp;&nbsp;&nbsp;{PCI_VDEVICE(INTE=
L, PCI_DEVICE_ID_INTEL_NTB_B2B_BWD)},</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{PCI_VDEVICE(=
INTEL, PCI_DEVICE_ID_INTEL_NTB_B2B_JSF)},</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{PCI_VDEVICE(=
INTEL, PCI_DEVICE_ID_INTEL_NTB_B2B_SNB)},</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{PCI_VDEVICE(=
INTEL, PCI_DEVICE_ID_INTEL_NTB_B2B_IVT)},</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>diff --git a/drivers/ntb/hw/intel/ntb_hw_in=
tel.h b/drivers/ntb/hw/intel/ntb_hw_intel.h</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>index a8b17f3..9d2c6b6 100644</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>--- a/drivers/ntb/hw/intel/ntb_hw_intel.h</=
span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>&#43;&#43;&#43; b/drivers/ntb/hw/intel/ntb_=
hw_intel.h</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>@@ -66,7 &#43;66,6 @@</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>#define PCI_DEVICE_ID_INTEL_NTB_B2B_HSX &nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;0x2F0D</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>#define PCI_DEVICE_ID_INTEL_NTB_PS_HSX &nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0x2F0E</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>#define PCI_DEVICE_ID_INTEL_NTB_SS_HSX &nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0x2F0F</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-#define PCI_DEVICE_ID_INTEL_NTB_B2B_BWD &n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;0x0C4E</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>#define PCI_DEVICE_ID_INTEL_NTB_B2B_BDX &nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;0x6F0D</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>#define PCI_DEVICE_ID_INTEL_NTB_PS_BDX &nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0x6F0E</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>#define PCI_DEVICE_ID_INTEL_NTB_SS_BDX &nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0x6F0F</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>@@ -197,63 &#43;196,6 @@</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>#define SKX_DB_TOTAL_SHIFT &nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;33</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>#define SKX_SPAD_COUNT &nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;16</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span></span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-/* Intel Atom hardware */</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-#define ATOM_SBAR2XLAT_OFFSET &nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;0x0008</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-#define ATOM_PDOORBELL_OFFSET &nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;0x0020</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-#define ATOM_PDBMSK_OFFSET &nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0x0028</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-#define ATOM_NTBCNTL_OFFSET &nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0x0060</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-#define ATOM_SPAD_OFFSET &nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;0x0080</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-#define ATOM_PPD_OFFSET &nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0x00d4</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-#define ATOM_PBAR2XLAT_OFFSET &nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;0x8008</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-#define ATOM_B2B_DOORBELL_OFFSET &nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0x8020</span=
><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-#define ATOM_B2B_SPAD_OFFSET &nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0x8080</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-#define ATOM_SPCICMD_OFFSET &nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0xb004</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-#define ATOM_LINK_STATUS_OFFSET &nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0xb052<=
/span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-#define ATOM_ERRCORSTS_OFFSET &nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;0xb110</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-#define ATOM_IP_BASE &nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
0xc000</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-#define ATOM_DESKEWSTS_OFFSET &nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;(ATOM_IP_BASE &#43; 0x3024)</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-#define ATOM_LTSSMERRSTS0_OFFSET &nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(ATOM_IP_BAS=
E &#43; 0x3180)</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-#define ATOM_LTSSMSTATEJMP_OFFSET &nbsp;&n=
bsp;&nbsp;(ATOM_IP_BASE &#43; 0x3040)</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-#define ATOM_IBSTERRRCRVSTS0_OFFSET &nbsp;=
(ATOM_IP_BASE &#43; 0x3324)</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-#define ATOM_MODPHY_PCSREG4 &nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0x1c004</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-#define ATOM_MODPHY_PCSREG6 &nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0x1c006</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-#define ATOM_PPD_INIT_LINK &nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0x0008</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-#define ATOM_PPD_CONN_MASK &nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0x0300</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-#define ATOM_PPD_CONN_TRANSPARENT &nbsp;&n=
bsp;&nbsp;0x0000</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-#define ATOM_PPD_CONN_B2B &nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0x0100</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-#define ATOM_PPD_CONN_RP &nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;0x0200</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-#define ATOM_PPD_DEV_MASK &nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0x1000</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-#define ATOM_PPD_DEV_USD &nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;0x0000</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-#define ATOM_PPD_DEV_DSD &nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;0x1000</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-#define ATOM_PPD_TOPO_MASK &nbsp;&nbsp;(AT=
OM_PPD_CONN_MASK | ATOM_PPD_DEV_MASK)</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-#define ATOM_PPD_TOPO_PRI_USD &nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(ATOM_PPD_CONN_TRANSPARENT | ATOM_PPD_DEV_USD=
)</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-#define ATOM_PPD_TOPO_PRI_DSD &nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(ATOM_PPD_CONN_TRANSPARENT | ATOM_PPD_DEV_DSD=
)</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-#define ATOM_PPD_TOPO_SEC_USD &nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(ATOM_PPD_CONN_RP | ATOM_PPD_DEV_USD)</span><=
br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-#define ATOM_PPD_TOPO_SEC_DSD &nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(ATOM_PPD_CONN_RP | ATOM_PPD_DEV_DSD)</span><=
br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-#define ATOM_PPD_TOPO_B2B_USD &nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(ATOM_PPD_CONN_B2B | ATOM_PPD_DEV_USD)</span>=
<br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-#define ATOM_PPD_TOPO_B2B_DSD &nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(ATOM_PPD_CONN_B2B | ATOM_PPD_DEV_DSD)</span>=
<br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-#define ATOM_MW_COUNT &nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-#define ATOM_DB_COUNT &nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;34</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-#define ATOM_DB_VALID_MASK &nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(BIT_ULL(ATOM_DB_COUNT) - 1)</=
span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-#define ATOM_DB_MSIX_VECTOR_COUNT &nbsp;&n=
bsp;&nbsp;34</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-#define ATOM_DB_MSIX_VECTOR_SHIFT &nbsp;&n=
bsp;&nbsp;1</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-#define ATOM_DB_TOTAL_SHIFT &nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;34</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-#define ATOM_SPAD_COUNT &nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;16</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-#define ATOM_NTB_CTL_DOWN_BIT &nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;BIT(16)</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-#define ATOM_NTB_CTL_ACTIVE(x) &nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;!(=
x &amp; ATOM_NTB_CTL_DOWN_BIT)</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-#define ATOM_DESKEWSTS_DBERR &nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;BIT(15)</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-#define ATOM_LTSSMERRSTS0_UNEXPECTEDEI &nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;BIT(20)</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-#define ATOM_LTSSMSTATEJMP_FORCEDETECT &nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;BIT(2)</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-#define ATOM_IBIST_ERR_OFLOW &nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0x7FFF7FFF</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-#define ATOM_LINK_HB_TIMEOUT &nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;msecs_to_jiffies(1000)</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-#define ATOM_LINK_RECOVERY_TIME &nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;msecs_t=
o_jiffies(500)</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>-</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>/* Ntb control and link status */</span><br=
>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span></span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite">
<blockquote type=3D"cite"><span>#define NTB_CTL_CFG_LOCK &nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;BIT(0)</span><br>
</blockquote>
</blockquote>
<blockquote type=3D"cite"><span></span><br>
</blockquote>
<blockquote type=3D"cite"><span></span><br>
</blockquote>
<span></span><br>
<span>-- </span><br>
<span>You received this message because you are subscribed to the Google Gr=
oups &quot;linux-ntb&quot; group.</span><br>
<span>To unsubscribe from this group and stop receiving emails from it, sen=
d an email to
<a href=3D"mailto:linux-ntb&#43;unsubscribe@googlegroups.com">linux-ntb&#43=
;unsubscribe@googlegroups.com</a>.</span><br>
<span>To post to this group, send email to <a href=3D"mailto:linux-ntb@goog=
legroups.com">
linux-ntb@googlegroups.com</a>.</span><br>
<span>To view this discussion on the web visit <a href=3D"https://groups.go=
ogle.com/d/msgid/linux-ntb/CAPoiz9wn3f5x-aCJTMx7S6xS%3DuiG2ZYOJHxiAk2Unrqc5=
8EbiQ%40mail.gmail.com">
https://groups.google.com/d/msgid/linux-ntb/CAPoiz9wn3f5x-aCJTMx7S6xS%3DuiG=
2ZYOJHxiAk2Unrqc58EbiQ%40mail.gmail.com</a>.</span><br>
<span>For more options, visit <a href=3D"https://groups.google.com/d/optout=
">https://groups.google.com/d/optout</a>.</span><br>
</div>
</blockquote>
</body>
</html>

--_000_C2279C74DD3A433487CA0791D4BAE6B0intelcom_--
