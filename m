Return-Path: <dan.carpenter@oracle.com>
Received: from aserp2130.oracle.com (aserp2130.oracle.com. [141.146.126.79])
        by gmr-mx.google.com with ESMTPS id mt17si1515572pjb.0.2021.01.04.00.31.00
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Jan 2021 00:31:01 -0800 (PST)
Date: Mon, 4 Jan 2021 11:29:48 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [GIT PULL] NTB bug fixes for v5.11
Message-ID: <20210104082948.GR2831@kadam>
References: <20201227141638.GA11393@athena.kudzu.us>
 <CAHk-=wjxQzF3eWank1r7F6+EqSRsO+kvibPqDbzxjHv3wzZt0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjxQzF3eWank1r7F6+EqSRsO+kvibPqDbzxjHv3wzZt0A@mail.gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jon Mason <jdmason@kudzu.us>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Sun, Dec 27, 2020 at 09:38:23AM -0800, Linus Torvalds wrote:
> On Sun, Dec 27, 2020 at 6:16 AM Jon Mason <jdmason@kudzu.us> wrote:
> >
> > Wang Qing (1):
> >       ntb: idt: fix error check in ntb_hw_idt.c
> 
> So this patch seems to be at least partially triggered by a smatch
> warning that is a bit questionable.
> 
> This part:
> 
>      if (IS_ERR_OR_NULL(dbgfs_topdir)) {
>          dev_info(&ndev->ntb.pdev->dev, "Top DebugFS directory absent");
> -        return PTR_ERR(dbgfs_topdir);
> +        return PTR_ERR_OR_ZERO(dbgfs_topdir);
>      }
> 
> works, but is very non-optimal and unnecessary.
> 
> The thing is, "PTR_ERR()" works just fine on a IS_ERR_OR_NULL pointer.
> It doesn't work on a _regular_ non-NULL and non-ERR pointer, and will
> return random garbage for those. But if you've tested for
> IS_ERR_OR_NULL(), then a regular PTR_ERR() is already fine.
> 
> And PTR_ERR_OR_ZERO() potentially generates an extraneous pointless
> tests against zero (to check for the ERR case).
> 
> A compiler may be able to notice that the PTR_ERR_OR_ZERO() is
> unnecessary and remove it (because of the IS_ERR_OR_NULL() checks),
> but in general we should assume compilers are "not stupid" rather than
> "really smart".
> 
> So while this patch isn't _wrong_, and I've already pulled it, the
> fact that apparently some smatch test triggers these pointless and
> potentially expensive patches is not a good idea.
> 
> I'm not sure what the smatch tests should be (NULL turns to 0, which
> may be confusing), but I'm cc'ing Dan in case he has ideas.
>

The most common bug that this check finds is the other part of that same
commit 91b8246de859 ("ntb: idt: fix error check in ntb_hw_idt.c"):

 	/* Allocate the memory for IDT NTB device data */
 	ndev = idt_create_dev(pdev, id);
-	if (IS_ERR_OR_NULL(ndev))
+	if (IS_ERR(ndev))
 		return PTR_ERR(ndev);

idt_create_dev() never returns NULL, but if it did then we don't want
to return success.

For the debugfs stuff, the caller doesn't check the return value anyway.
Just make it a void function.  A lot of this debugfs code could be
simplified.  It's not a bug to pass an error pointer or a NULL dbgfs_topdir
pointer to debugfs_create_file().  There isn't any benefit in checking
debugfs_initialized().

diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
index e7a4c2aa8baa..710c17b2a923 100644
--- a/drivers/ntb/hw/idt/ntb_hw_idt.c
+++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
@@ -2504,28 +2504,14 @@ static ssize_t idt_dbgfs_info_read(struct file *filp, char __user *ubuf,
  *
  * Return: zero on success, otherwise a negative error number.
  */
-static int idt_init_dbgfs(struct idt_ntb_dev *ndev)
+static void idt_init_dbgfs(struct idt_ntb_dev *ndev)
 {
 	char devname[64];
 
-	/* If the top directory is not created then do nothing */
-	if (IS_ERR_OR_NULL(dbgfs_topdir)) {
-		dev_info(&ndev->ntb.pdev->dev, "Top DebugFS directory absent");
-		return PTR_ERR_OR_ZERO(dbgfs_topdir);
-	}
-
 	/* Create the info file node */
 	snprintf(devname, 64, "info:%s", pci_name(ndev->ntb.pdev));
 	ndev->dbgfs_info = debugfs_create_file(devname, 0400, dbgfs_topdir,
-		ndev, &idt_dbgfs_info_ops);
-	if (IS_ERR(ndev->dbgfs_info)) {
-		dev_dbg(&ndev->ntb.pdev->dev, "Failed to create DebugFS node");
-		return PTR_ERR(ndev->dbgfs_info);
-	}
-
-	dev_dbg(&ndev->ntb.pdev->dev, "NTB device DebugFS node created");
-
-	return 0;
+					       ndev, &idt_dbgfs_info_ops);
 }
 
 /*
@@ -2792,7 +2778,7 @@ static int idt_pci_probe(struct pci_dev *pdev,
 		goto err_deinit_isr;
 
 	/* Initialize DebugFS info node */
-	(void)idt_init_dbgfs(ndev);
+	idt_init_dbgfs(ndev);
 
 	/* IDT PCIe-switch NTB driver is finally initialized */
 	dev_info(&pdev->dev, "IDT NTB device is ready");
@@ -2904,9 +2890,7 @@ static int __init idt_pci_driver_init(void)
 {
 	pr_info("%s %s\n", NTB_DESC, NTB_VER);
 
-	/* Create the top DebugFS directory if the FS is initialized */
-	if (debugfs_initialized())
-		dbgfs_topdir = debugfs_create_dir(KBUILD_MODNAME, NULL);
+	dbgfs_topdir = debugfs_create_dir(KBUILD_MODNAME, NULL);
 
 	/* Register the NTB hardware driver to handle the PCI device */
 	return pci_register_driver(&idt_pci_driver);
-- 
2.29.2


