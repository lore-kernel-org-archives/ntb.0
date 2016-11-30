Return-Path: <fengguang.wu@intel.com>
Received: from mga07.intel.com (mga07.intel.com. [134.134.136.100])
        by gmr-mx.google.com with ESMTPS id m13si1064104itb.3.2016.11.30.12.04.22
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Nov 2016 12:04:23 -0800 (PST)
Date: Thu, 1 Dec 2016 04:04:01 +0800
From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH 02/22] NTB: Add peer indexed ports NTB API
Message-ID: <201612010452.NVdsoBnY%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1480439777-1080-3-git-send-email-fancer.lancer@gmail.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: kbuild-all@01.org, jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, Xiangliang.Yu@amd.com, Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

Hi Serge,

[auto build test WARNING on ntb/ntb-next]
[also build test WARNING on v4.9-rc7 next-20161130]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Serge-Semin/NTB-Alter-kernel-API-to-support-multi-port-devices/20161201-014939
base:   https://github.com/jonmason/ntb ntb-next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   include/linux/compiler.h:253:8: sparse: attribute 'no_sanitize_address': unknown attribute
   drivers/ntb/hw/intel/ntb_hw_intel.c:664:13: sparse: undefined identifier 'ntb_topo_is_b2b'
   drivers/ntb/hw/intel/ntb_hw_intel.c:895:21: sparse: undefined identifier 'ntb_topo_is_b2b'
   drivers/ntb/hw/intel/ntb_hw_intel.c:1206:31: sparse: undefined identifier 'NTB_TOPO_SEC'
   drivers/ntb/hw/intel/ntb_hw_intel.c:1235:31: sparse: undefined identifier 'NTB_TOPO_SEC'
   drivers/ntb/hw/intel/ntb_hw_intel.c:1572:14: sparse: undefined identifier 'NTB_TOPO_B2B_USD'
   drivers/ntb/hw/intel/ntb_hw_intel.c:1573:14: sparse: undefined identifier 'NTB_TOPO_B2B_DSD'
>> drivers/ntb/hw/intel/ntb_hw_intel.c:1572:14: sparse: incompatible types for 'case' statement
   drivers/ntb/hw/intel/ntb_hw_intel.c:1573:14: sparse: incompatible types for 'case' statement
   drivers/ntb/hw/intel/ntb_hw_intel.c:1448:24: sparse: undefined identifier 'NTB_TOPO_B2B_USD'
   drivers/ntb/hw/intel/ntb_hw_intel.c:1452:24: sparse: undefined identifier 'NTB_TOPO_B2B_DSD'
   drivers/ntb/hw/intel/ntb_hw_intel.c:1614:31: sparse: undefined identifier 'NTB_TOPO_SEC'
   drivers/ntb/hw/intel/ntb_hw_intel.c:1789:14: sparse: undefined identifier 'NTB_TOPO_B2B_USD'
   drivers/ntb/hw/intel/ntb_hw_intel.c:1790:14: sparse: undefined identifier 'NTB_TOPO_B2B_DSD'
   drivers/ntb/hw/intel/ntb_hw_intel.c:1795:39: sparse: undefined identifier 'NTB_TOPO_B2B_USD'
   drivers/ntb/hw/intel/ntb_hw_intel.c:1789:14: sparse: incompatible types for 'case' statement
   drivers/ntb/hw/intel/ntb_hw_intel.c:1790:14: sparse: incompatible types for 'case' statement
   drivers/ntb/hw/intel/ntb_hw_intel.c:2053:24: sparse: undefined identifier 'NTB_TOPO_B2B_USD'
   drivers/ntb/hw/intel/ntb_hw_intel.c:2056:24: sparse: undefined identifier 'NTB_TOPO_B2B_DSD'
   drivers/ntb/hw/intel/ntb_hw_intel.c:2060:24: sparse: undefined identifier 'NTB_TOPO_PRI'
   drivers/ntb/hw/intel/ntb_hw_intel.c:2064:24: sparse: undefined identifier 'NTB_TOPO_SEC'
   drivers/ntb/hw/intel/ntb_hw_intel.c:2043:31: sparse: undefined identifier 'NTB_TOPO_SEC'
   drivers/ntb/hw/intel/ntb_hw_intel.c:2356:14: sparse: undefined identifier 'NTB_TOPO_PRI'
   drivers/ntb/hw/intel/ntb_hw_intel.c:2374:14: sparse: undefined identifier 'NTB_TOPO_SEC'
   drivers/ntb/hw/intel/ntb_hw_intel.c:2386:14: sparse: undefined identifier 'NTB_TOPO_B2B_USD'
   drivers/ntb/hw/intel/ntb_hw_intel.c:2387:14: sparse: undefined identifier 'NTB_TOPO_B2B_DSD'
   drivers/ntb/hw/intel/ntb_hw_intel.c:2416:39: sparse: undefined identifier 'NTB_TOPO_B2B_USD'
   drivers/ntb/hw/intel/ntb_hw_intel.c:2356:14: sparse: incompatible types for 'case' statement
   drivers/ntb/hw/intel/ntb_hw_intel.c:2374:14: sparse: incompatible types for 'case' statement
   drivers/ntb/hw/intel/ntb_hw_intel.c:2386:14: sparse: incompatible types for 'case' statement
   drivers/ntb/hw/intel/ntb_hw_intel.c:2387:14: sparse: incompatible types for 'case' statement
   drivers/ntb/hw/intel/ntb_hw_intel.c:2534:31: sparse: undefined identifier 'NTB_TOPO_SEC'
   drivers/ntb/hw/intel/ntb_hw_intel.c:232:22: sparse: undefined identifier 'ntb_topo_is_b2b'
   drivers/ntb/hw/intel/ntb_hw_intel.c:1572:14: sparse: Expected constant expression in case statement
   drivers/ntb/hw/intel/ntb_hw_intel.c:1573:14: sparse: Expected constant expression in case statement
   drivers/ntb/hw/intel/ntb_hw_intel.c:1789:14: sparse: Expected constant expression in case statement
   drivers/ntb/hw/intel/ntb_hw_intel.c:1790:14: sparse: Expected constant expression in case statement
   drivers/ntb/hw/intel/ntb_hw_intel.c:2356:14: sparse: Expected constant expression in case statement
   drivers/ntb/hw/intel/ntb_hw_intel.c:2374:14: sparse: Expected constant expression in case statement
   drivers/ntb/hw/intel/ntb_hw_intel.c:2386:14: sparse: Expected constant expression in case statement
   drivers/ntb/hw/intel/ntb_hw_intel.c:2387:14: sparse: Expected constant expression in case statement
   drivers/ntb/hw/intel/ntb_hw_intel.c: In function 'ndev_reset_unsafe_flags':
   drivers/ntb/hw/intel/ntb_hw_intel.c:232:8: error: implicit declaration of function 'ntb_topo_is_b2b' [-Werror=implicit-function-declaration]
      if (!ntb_topo_is_b2b(ndev->ntb.topo))
           ^~~~~~~~~~~~~~~
   drivers/ntb/hw/intel/ntb_hw_intel.c: In function 'intel_ntb_link_enable':
   drivers/ntb/hw/intel/ntb_hw_intel.c:1206:24: error: 'NTB_TOPO_SEC' undeclared (first use in this function)
     if (ndev->ntb.topo == NTB_TOPO_SEC)
                           ^~~~~~~~~~~~
   drivers/ntb/hw/intel/ntb_hw_intel.c:1206:24: note: each undeclared identifier is reported only once for each function it appears in
   drivers/ntb/hw/intel/ntb_hw_intel.c: In function 'intel_ntb_link_disable':
   drivers/ntb/hw/intel/ntb_hw_intel.c:1235:24: error: 'NTB_TOPO_SEC' undeclared (first use in this function)
     if (ndev->ntb.topo == NTB_TOPO_SEC)
                           ^~~~~~~~~~~~
   drivers/ntb/hw/intel/ntb_hw_intel.c: In function 'atom_ppd_topo':
   drivers/ntb/hw/intel/ntb_hw_intel.c:1448:10: error: 'NTB_TOPO_B2B_USD' undeclared (first use in this function)
      return NTB_TOPO_B2B_USD;
             ^~~~~~~~~~~~~~~~
   drivers/ntb/hw/intel/ntb_hw_intel.c:1452:10: error: 'NTB_TOPO_B2B_DSD' undeclared (first use in this function)
      return NTB_TOPO_B2B_DSD;
             ^~~~~~~~~~~~~~~~
   drivers/ntb/hw/intel/ntb_hw_intel.c: In function 'atom_init_ntb':
   drivers/ntb/hw/intel/ntb_hw_intel.c:1572:7: error: 'NTB_TOPO_B2B_USD' undeclared (first use in this function)
     case NTB_TOPO_B2B_USD:
          ^~~~~~~~~~~~~~~~
   drivers/ntb/hw/intel/ntb_hw_intel.c:1573:7: error: 'NTB_TOPO_B2B_DSD' undeclared (first use in this function)
     case NTB_TOPO_B2B_DSD:
          ^~~~~~~~~~~~~~~~
   drivers/ntb/hw/intel/ntb_hw_intel.c: In function 'atom_init_dev':
   drivers/ntb/hw/intel/ntb_hw_intel.c:1614:24: error: 'NTB_TOPO_SEC' undeclared (first use in this function)
     if (ndev->ntb.topo != NTB_TOPO_SEC) {
                           ^~~~~~~~~~~~
   drivers/ntb/hw/intel/ntb_hw_intel.c: In function 'skx_init_ntb':
   drivers/ntb/hw/intel/ntb_hw_intel.c:1789:7: error: 'NTB_TOPO_B2B_USD' undeclared (first use in this function)
     case NTB_TOPO_B2B_USD:
          ^~~~~~~~~~~~~~~~
   drivers/ntb/hw/intel/ntb_hw_intel.c:1790:7: error: 'NTB_TOPO_B2B_DSD' undeclared (first use in this function)
     case NTB_TOPO_B2B_DSD:
          ^~~~~~~~~~~~~~~~
   drivers/ntb/hw/intel/ntb_hw_intel.c: In function 'xeon_link_is_up':
   drivers/ntb/hw/intel/ntb_hw_intel.c:2043:24: error: 'NTB_TOPO_SEC' undeclared (first use in this function)
     if (ndev->ntb.topo == NTB_TOPO_SEC)
                           ^~~~~~~~~~~~
   drivers/ntb/hw/intel/ntb_hw_intel.c: In function 'xeon_ppd_topo':
   drivers/ntb/hw/intel/ntb_hw_intel.c:2053:10: error: 'NTB_TOPO_B2B_USD' undeclared (first use in this function)
      return NTB_TOPO_B2B_USD;
             ^~~~~~~~~~~~~~~~
   drivers/ntb/hw/intel/ntb_hw_intel.c:2056:10: error: 'NTB_TOPO_B2B_DSD' undeclared (first use in this function)
      return NTB_TOPO_B2B_DSD;
             ^~~~~~~~~~~~~~~~
   drivers/ntb/hw/intel/ntb_hw_intel.c:2060:10: error: 'NTB_TOPO_PRI' undeclared (first use in this function)
      return NTB_TOPO_PRI;
             ^~~~~~~~~~~~
   drivers/ntb/hw/intel/ntb_hw_intel.c:2064:10: error: 'NTB_TOPO_SEC' undeclared (first use in this function)
      return NTB_TOPO_SEC;
             ^~~~~~~~~~~~
   drivers/ntb/hw/intel/ntb_hw_intel.c: In function 'xeon_init_ntb':
   drivers/ntb/hw/intel/ntb_hw_intel.c:2356:7: error: 'NTB_TOPO_PRI' undeclared (first use in this function)
     case NTB_TOPO_PRI:
          ^~~~~~~~~~~~
   drivers/ntb/hw/intel/ntb_hw_intel.c:2374:7: error: 'NTB_TOPO_SEC' undeclared (first use in this function)
     case NTB_TOPO_SEC:
          ^~~~~~~~~~~~
   drivers/ntb/hw/intel/ntb_hw_intel.c:2386:7: error: 'NTB_TOPO_B2B_USD' undeclared (first use in this function)
     case NTB_TOPO_B2B_USD:
          ^~~~~~~~~~~~~~~~
   drivers/ntb/hw/intel/ntb_hw_intel.c:2387:7: error: 'NTB_TOPO_B2B_DSD' undeclared (first use in this function)
     case NTB_TOPO_B2B_DSD:

vim +/case +1572 drivers/ntb/hw/intel/ntb_hw_intel.c

fce8a7bb drivers/ntb/ntb_hw.c                Jon Mason   2012-11-16  1556  	return 0;
fce8a7bb drivers/ntb/ntb_hw.c                Jon Mason   2012-11-16  1557  }
fce8a7bb drivers/ntb/ntb_hw.c                Jon Mason   2012-11-16  1558  
2f887b9a drivers/ntb/hw/intel/ntb_hw_intel.c Dave Jiang  2015-05-20  1559  static void atom_deinit_isr(struct intel_ntb_dev *ndev)
fce8a7bb drivers/ntb/ntb_hw.c                Jon Mason   2012-11-16  1560  {
e26a5843 drivers/ntb/hw/intel/ntb_hw_intel.c Allen Hubbe 2015-04-09  1561  	cancel_delayed_work_sync(&ndev->hb_timer);
e26a5843 drivers/ntb/hw/intel/ntb_hw_intel.c Allen Hubbe 2015-04-09  1562  	ndev_deinit_isr(ndev);
e26a5843 drivers/ntb/hw/intel/ntb_hw_intel.c Allen Hubbe 2015-04-09  1563  }
fce8a7bb drivers/ntb/ntb_hw.c                Jon Mason   2012-11-16  1564  
2f887b9a drivers/ntb/hw/intel/ntb_hw_intel.c Dave Jiang  2015-05-20  1565  static int atom_init_ntb(struct intel_ntb_dev *ndev)
e26a5843 drivers/ntb/hw/intel/ntb_hw_intel.c Allen Hubbe 2015-04-09  1566  {
2f887b9a drivers/ntb/hw/intel/ntb_hw_intel.c Dave Jiang  2015-05-20  1567  	ndev->mw_count = ATOM_MW_COUNT;
2f887b9a drivers/ntb/hw/intel/ntb_hw_intel.c Dave Jiang  2015-05-20  1568  	ndev->spad_count = ATOM_SPAD_COUNT;
2f887b9a drivers/ntb/hw/intel/ntb_hw_intel.c Dave Jiang  2015-05-20  1569  	ndev->db_count = ATOM_DB_COUNT;
fce8a7bb drivers/ntb/ntb_hw.c                Jon Mason   2012-11-16  1570  
e26a5843 drivers/ntb/hw/intel/ntb_hw_intel.c Allen Hubbe 2015-04-09  1571  	switch (ndev->ntb.topo) {
e26a5843 drivers/ntb/hw/intel/ntb_hw_intel.c Allen Hubbe 2015-04-09 @1572  	case NTB_TOPO_B2B_USD:
e26a5843 drivers/ntb/hw/intel/ntb_hw_intel.c Allen Hubbe 2015-04-09  1573  	case NTB_TOPO_B2B_DSD:
2f887b9a drivers/ntb/hw/intel/ntb_hw_intel.c Dave Jiang  2015-05-20  1574  		ndev->self_reg = &atom_pri_reg;
2f887b9a drivers/ntb/hw/intel/ntb_hw_intel.c Dave Jiang  2015-05-20  1575  		ndev->peer_reg = &atom_b2b_reg;
2f887b9a drivers/ntb/hw/intel/ntb_hw_intel.c Dave Jiang  2015-05-20  1576  		ndev->xlat_reg = &atom_sec_xlat;
e26a5843 drivers/ntb/hw/intel/ntb_hw_intel.c Allen Hubbe 2015-04-09  1577  
e26a5843 drivers/ntb/hw/intel/ntb_hw_intel.c Allen Hubbe 2015-04-09  1578  		/* Enable Bus Master and Memory Space on the secondary side */
e26a5843 drivers/ntb/hw/intel/ntb_hw_intel.c Allen Hubbe 2015-04-09  1579  		iowrite16(PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER,
2f887b9a drivers/ntb/hw/intel/ntb_hw_intel.c Dave Jiang  2015-05-20  1580  			  ndev->self_mmio + ATOM_SPCICMD_OFFSET);

:::::: The code at line 1572 was first introduced by commit
:::::: e26a5843f7f5014ae4460030ca4de029a3ac35d3 NTB: Split ntb_hw_intel and ntb_transport drivers

:::::: TO: Allen Hubbe <Allen.Hubbe@emc.com>
:::::: CC: Jon Mason <jdmason@kudzu.us>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
