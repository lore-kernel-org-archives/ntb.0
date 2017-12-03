Return-Path: <fengguang.wu@intel.com>
Received: from mga14.intel.com (mga14.intel.com. [192.55.52.115])
        by gmr-mx.google.com with ESMTPS id g129si356643itd.1.2017.12.03.09.56.41
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Dec 2017 09:56:42 -0800 (PST)
Date: Mon, 4 Dec 2017 01:55:58 +0800
From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v2] NTB: ntb_perf: Add full multi-port NTB API support
Message-ID: <201712040124.tuJQTbll%fengguang.wu@intel.com>
References: <20171130213809.20984-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
In-Reply-To: <20171130213809.20984-1-fancer.lancer@gmail.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: kbuild-all@01.org, jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, Shyam-sundar.S-k@amd.com, Xiangliang.Yu@amd.com, Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Serge,

I love your patch! Yet something to improve:

[auto build test ERROR on v4.15-rc1]
[cannot apply to ntb/ntb-next next-20171201]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Serge-Semin/NTB-ntb_perf-Add-full-multi-port-NTB-API-support/20171204-011126
config: x86_64-randconfig-x017-201749 (attached as .config)
compiler: gcc-7 (Debian 7.2.0-12) 7.2.1 20171025
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All error/warnings (new ones prefixed by >>):

   drivers/ntb//test/ntb_perf.c: In function 'perf_msg_cmd_send':
>> drivers/ntb//test/ntb_perf.c:375:3: error: implicit declaration of function 'ntb_peer_msg_write'; did you mean 'ntb_peer_spad_write'? [-Werror=implicit-function-declaration]
      ntb_peer_msg_write(perf->ntb, peer->pidx, PERF_MSG_LDATA,
      ^~~~~~~~~~~~~~~~~~
      ntb_peer_spad_write
   drivers/ntb//test/ntb_perf.c: In function 'perf_msg_cmd_recv':
>> drivers/ntb//test/ntb_perf.c:408:32: warning: passing argument 2 of 'ntb_msg_read' makes integer from pointer without a cast [-Wint-conversion]
     val = ntb_msg_read(perf->ntb, pidx, PERF_MSG_CMD);
                                   ^~~~
   In file included from drivers/ntb//test/ntb_perf.c:89:0:
   include/linux/ntb.h:1473:19: note: expected 'int' but argument is of type 'int *'
    static inline int ntb_msg_read(struct ntb_dev *ntb, int midx, int *pidx,
                      ^~~~~~~~~~~~
>> drivers/ntb//test/ntb_perf.c:408:8: error: too few arguments to function 'ntb_msg_read'
     val = ntb_msg_read(perf->ntb, pidx, PERF_MSG_CMD);
           ^~~~~~~~~~~~
   In file included from drivers/ntb//test/ntb_perf.c:89:0:
   include/linux/ntb.h:1473:19: note: declared here
    static inline int ntb_msg_read(struct ntb_dev *ntb, int midx, int *pidx,
                      ^~~~~~~~~~~~
   drivers/ntb//test/ntb_perf.c:411:32: warning: passing argument 2 of 'ntb_msg_read' makes integer from pointer without a cast [-Wint-conversion]
     val = ntb_msg_read(perf->ntb, pidx, PERF_MSG_LDATA);
                                   ^~~~
   In file included from drivers/ntb//test/ntb_perf.c:89:0:
   include/linux/ntb.h:1473:19: note: expected 'int' but argument is of type 'int *'
    static inline int ntb_msg_read(struct ntb_dev *ntb, int midx, int *pidx,
                      ^~~~~~~~~~~~
>> drivers/ntb//test/ntb_perf.c:229:25: warning: passing argument 3 of 'ntb_msg_read' makes pointer from integer without a cast [-Wint-conversion]
    #define PERF_MSG_LDATA  1
                            ^
>> drivers/ntb//test/ntb_perf.c:411:38: note: in expansion of macro 'PERF_MSG_LDATA'
     val = ntb_msg_read(perf->ntb, pidx, PERF_MSG_LDATA);
                                         ^~~~~~~~~~~~~~
   In file included from drivers/ntb//test/ntb_perf.c:89:0:
   include/linux/ntb.h:1473:19: note: expected 'int *' but argument is of type 'int'
    static inline int ntb_msg_read(struct ntb_dev *ntb, int midx, int *pidx,
                      ^~~~~~~~~~~~
   drivers/ntb//test/ntb_perf.c:411:8: error: too few arguments to function 'ntb_msg_read'
     val = ntb_msg_read(perf->ntb, pidx, PERF_MSG_LDATA);
           ^~~~~~~~~~~~
   In file included from drivers/ntb//test/ntb_perf.c:89:0:
   include/linux/ntb.h:1473:19: note: declared here
    static inline int ntb_msg_read(struct ntb_dev *ntb, int midx, int *pidx,
                      ^~~~~~~~~~~~
   drivers/ntb//test/ntb_perf.c:414:32: warning: passing argument 2 of 'ntb_msg_read' makes integer from pointer without a cast [-Wint-conversion]
     val = ntb_msg_read(perf->ntb, pidx, PERF_MSG_HDATA);
                                   ^~~~
   In file included from drivers/ntb//test/ntb_perf.c:89:0:
   include/linux/ntb.h:1473:19: note: expected 'int' but argument is of type 'int *'
    static inline int ntb_msg_read(struct ntb_dev *ntb, int midx, int *pidx,
                      ^~~~~~~~~~~~
   drivers/ntb//test/ntb_perf.c:230:25: warning: passing argument 3 of 'ntb_msg_read' makes pointer from integer without a cast [-Wint-conversion]
    #define PERF_MSG_HDATA  2
                            ^
>> drivers/ntb//test/ntb_perf.c:414:38: note: in expansion of macro 'PERF_MSG_HDATA'
     val = ntb_msg_read(perf->ntb, pidx, PERF_MSG_HDATA);
                                         ^~~~~~~~~~~~~~
   In file included from drivers/ntb//test/ntb_perf.c:89:0:
   include/linux/ntb.h:1473:19: note: expected 'int *' but argument is of type 'int'
    static inline int ntb_msg_read(struct ntb_dev *ntb, int midx, int *pidx,
                      ^~~~~~~~~~~~
   drivers/ntb//test/ntb_perf.c:414:8: error: too few arguments to function 'ntb_msg_read'
     val = ntb_msg_read(perf->ntb, pidx, PERF_MSG_HDATA);
           ^~~~~~~~~~~~
   In file included from drivers/ntb//test/ntb_perf.c:89:0:
   include/linux/ntb.h:1473:19: note: declared here
    static inline int ntb_msg_read(struct ntb_dev *ntb, int midx, int *pidx,
                      ^~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +375 drivers/ntb//test/ntb_perf.c

   209	
   210	/*
   211	 * Scratchpads-base commands interface
   212	 */
   213	#define PERF_SPAD_CNT(_pcnt) \
   214		(3*((_pcnt) + 1))
   215	#define PERF_SPAD_CMD(_gidx) \
   216		(3*(_gidx))
   217	#define PERF_SPAD_LDATA(_gidx) \
   218		(3*(_gidx) + 1)
   219	#define PERF_SPAD_HDATA(_gidx) \
   220		(3*(_gidx) + 2)
   221	#define PERF_SPAD_NOTIFY(_gidx) \
   222		(BIT_ULL(_gidx))
   223	
   224	/*
   225	 * Messages-base commands interface
   226	 */
   227	#define PERF_MSG_CNT		3
   228	#define PERF_MSG_CMD		0
 > 229	#define PERF_MSG_LDATA		1
   230	#define PERF_MSG_HDATA		2
   231	
   232	/*==============================================================================
   233	 *                           Static data declarations
   234	 *==============================================================================
   235	 */
   236	
   237	static struct dentry *perf_dbgfs_topdir;
   238	
   239	static struct workqueue_struct *perf_wq __read_mostly;
   240	
   241	/*==============================================================================
   242	 *                  NTB cross-link commands execution service
   243	 *==============================================================================
   244	 */
   245	
   246	static void perf_terminate_test(struct perf_ctx *perf);
   247	
   248	static inline bool perf_link_is_up(struct perf_peer *peer)
   249	{
   250		u64 link;
   251	
   252		link = ntb_link_is_up(peer->perf->ntb, NULL, NULL);
   253		return !!(link & BIT_ULL_MASK(peer->pidx));
   254	}
   255	
   256	static int perf_spad_cmd_send(struct perf_peer *peer, enum perf_cmd cmd,
   257				      u64 data)
   258	{
   259		struct perf_ctx *perf = peer->perf;
   260		int try;
   261		u32 sts;
   262	
   263		dev_dbg(&perf->ntb->dev, "CMD send: %d 0x%llx\n", cmd, data);
   264	
   265		/*
   266		 * Perform predefined number of attempts before give up.
   267		 * We are sending the data to the port specific scratchpad, so
   268		 * to prevent a multi-port access race-condition. Additionally
   269		 * there is no need in local locking since only thread-safe
   270		 * service work is using this method.
   271		 */
   272		for (try = 0; try < MSG_TRIES; try++) {
   273			if (!perf_link_is_up(peer))
   274				return -ENOLINK;
   275	
   276			sts = ntb_peer_spad_read(perf->ntb, peer->pidx,
   277						 PERF_SPAD_CMD(perf->gidx));
   278			if (le32_to_cpu(sts) != PERF_CMD_INVAL) {
   279				usleep_range(MSG_UDELAY_LOW, MSG_UDELAY_HIGH);
   280				continue;
   281			}
   282	
   283			ntb_peer_spad_write(perf->ntb, peer->pidx,
   284					    PERF_SPAD_LDATA(perf->gidx),
   285					    cpu_to_le32(lower_32_bits(data)));
   286			ntb_peer_spad_write(perf->ntb, peer->pidx,
   287					    PERF_SPAD_HDATA(perf->gidx),
   288					    cpu_to_le32(upper_32_bits(data)));
   289			mmiowb();
   290			ntb_peer_spad_write(perf->ntb, peer->pidx,
   291					    PERF_SPAD_CMD(perf->gidx),
   292					    cpu_to_le32(cmd));
   293			mmiowb();
   294			ntb_peer_db_set(perf->ntb, PERF_SPAD_NOTIFY(peer->gidx));
   295	
   296			dev_dbg(&perf->ntb->dev, "DB ring peer %#llx\n",
   297				PERF_SPAD_NOTIFY(peer->gidx));
   298	
   299			break;
   300		}
   301	
   302		return try < MSG_TRIES ? 0 : -EAGAIN;
   303	}
   304	
   305	static int perf_spad_cmd_recv(struct perf_ctx *perf, int *pidx,
   306				      enum perf_cmd *cmd, u64 *data)
   307	{
   308		struct perf_peer *peer;
   309		u32 val;
   310	
   311		ntb_db_clear(perf->ntb, PERF_SPAD_NOTIFY(perf->gidx));
   312	
   313		/*
   314		 * We start scanning all over, since cleared DB may have been set
   315		 * by any peer. Yes, it makes peer with smaller index being
   316		 * serviced with greater priority, but it's convenient for spad
   317		 * and message code unification and simplicity.
   318		 */
   319		for (*pidx = 0; *pidx < perf->pcnt; (*pidx)++) {
   320			peer = &perf->peers[*pidx];
   321	
   322			if (!perf_link_is_up(peer))
   323				continue;
   324	
   325			val = ntb_spad_read(perf->ntb, PERF_SPAD_CMD(peer->gidx));
   326			val = le32_to_cpu(val);
   327			if (val == PERF_CMD_INVAL)
   328				continue;
   329	
   330			*cmd = val;
   331	
   332			val = ntb_spad_read(perf->ntb, PERF_SPAD_LDATA(peer->gidx));
   333			*data = le32_to_cpu(val);
   334	
   335			val = ntb_spad_read(perf->ntb, PERF_SPAD_HDATA(peer->gidx));
   336			*data |= (u64)le32_to_cpu(val) << 32;
   337	
   338			/* Next command can be retrieved from now */
   339			ntb_spad_write(perf->ntb, PERF_SPAD_CMD(peer->gidx),
   340				       cpu_to_le32(PERF_CMD_INVAL));
   341	
   342			dev_dbg(&perf->ntb->dev, "CMD recv: %d 0x%llx\n", *cmd, *data);
   343	
   344			return 0;
   345		}
   346	
   347		return -ENODATA;
   348	}
   349	
   350	static int perf_msg_cmd_send(struct perf_peer *peer, enum perf_cmd cmd,
   351				     u64 data)
   352	{
   353		struct perf_ctx *perf = peer->perf;
   354		int try, ret;
   355		u64 outbits;
   356	
   357		dev_dbg(&perf->ntb->dev, "CMD send: %d 0x%llx\n", cmd, data);
   358	
   359		/*
   360		 * Perform predefined number of attempts before give up. Message
   361		 * registers are free of race-condition problem when accessed
   362		 * from different ports, so we don't need splitting registers
   363		 * by global device index. We also won't have local locking,
   364		 * since the method is used from service work only.
   365		 */
   366		outbits = ntb_msg_outbits(perf->ntb);
   367		for (try = 0; try < MSG_TRIES; try++) {
   368			if (!perf_link_is_up(peer))
   369				return -ENOLINK;
   370	
   371			ret = ntb_msg_clear_sts(perf->ntb, outbits);
   372			if (ret)
   373				return ret;
   374	
 > 375			ntb_peer_msg_write(perf->ntb, peer->pidx, PERF_MSG_LDATA,
   376				      cpu_to_le32(lower_32_bits(data)));
   377	
   378			if (ntb_msg_read_sts(perf->ntb) & outbits) {
   379				usleep_range(MSG_UDELAY_LOW, MSG_UDELAY_HIGH);
   380				continue;
   381			}
   382	
   383			ntb_peer_msg_write(perf->ntb, peer->pidx, PERF_MSG_HDATA,
   384				      cpu_to_le32(upper_32_bits(data)));
   385			mmiowb();
   386	
   387			/* This call shall trigger peer message event */
   388			ntb_peer_msg_write(perf->ntb, peer->pidx, PERF_MSG_CMD,
   389				      cpu_to_le32(cmd));
   390	
   391			break;
   392		}
   393	
   394		return try < MSG_TRIES ? 0 : -EAGAIN;
   395	}
   396	
   397	static int perf_msg_cmd_recv(struct perf_ctx *perf, int *pidx,
   398				     enum perf_cmd *cmd, u64 *data)
   399	{
   400		u64 inbits;
   401		u32 val;
   402	
   403		inbits = ntb_msg_inbits(perf->ntb);
   404	
   405		if (hweight64(ntb_msg_read_sts(perf->ntb) & inbits) < 3)
   406			return -ENODATA;
   407	
 > 408		val = ntb_msg_read(perf->ntb, pidx, PERF_MSG_CMD);
   409		*cmd = le32_to_cpu(val);
   410	
 > 411		val = ntb_msg_read(perf->ntb, pidx, PERF_MSG_LDATA);
   412		*data = le32_to_cpu(val);
   413	
 > 414		val = ntb_msg_read(perf->ntb, pidx, PERF_MSG_HDATA);
   415		*data |= (u64)le32_to_cpu(val) << 32;
   416	
   417		/* Next command can be retrieved from now */
   418		ntb_msg_clear_sts(perf->ntb, inbits);
   419	
   420		dev_dbg(&perf->ntb->dev, "CMD recv: %d 0x%llx\n", *cmd, *data);
   421	
   422		return 0;
   423	}
   424	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--5vNYLRcllDrimb99
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
SOD/Azpxkxr6OAEA

--5vNYLRcllDrimb99--
