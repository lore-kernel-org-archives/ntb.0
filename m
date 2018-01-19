Return-Path: <fengguang.wu@intel.com>
Received: from mga02.intel.com (mga02.intel.com. [134.134.136.20])
        by gmr-mx.google.com with ESMTPS id g129si139268itd.1.2018.01.18.16.55.52
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jan 2018 16:55:53 -0800 (PST)
Date: Fri, 19 Jan 2018 08:55:37 +0800
From: kbuild test robot <fengguang.wu@intel.com>
Subject: [ntb:ntb-next 23/32] drivers/ntb/test/ntb_perf.c:276:21: sparse:
 cast to restricted __le32
Message-ID: <201801190836.f49m5DGQ%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Serge Semin <fancer.lancer@gmail.com>
Cc: kbuild-all@01.org, linux-ntb@googlegroups.com, Jon Mason <jdmason@kudzu.us>
List-ID: <linux-ntb.googlegroups.com>

tree:   https://github.com/jonmason/ntb ntb-next
head:   0f79bddeeb1de33fc5b504db2837635ece4dce3a
commit: b83003b3fdc1bf64e50676426a2dd0f48d28ba61 [23/32] NTB: ntb_perf: Add full multi-port NTB API support
reproduce:
        # apt-get install sparse
        git checkout b83003b3fdc1bf64e50676426a2dd0f48d28ba61
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/ntb/test/ntb_perf.c:276:21: sparse: cast to restricted __le32
>> drivers/ntb/test/ntb_perf.c:283:37: sparse: incorrect type in argument 4 (different base types) @@ expected unsigned int val @@ got ed int val @@
   drivers/ntb/test/ntb_perf.c:283:37: expected unsigned int val
   drivers/ntb/test/ntb_perf.c:283:37: got restricted __le32 <noident>
   drivers/ntb/test/ntb_perf.c:286:37: sparse: incorrect type in argument 4 (different base types) @@ expected unsigned int val @@ got ed int val @@
   drivers/ntb/test/ntb_perf.c:286:37: expected unsigned int val
   drivers/ntb/test/ntb_perf.c:286:37: got restricted __le32 <noident>
   drivers/ntb/test/ntb_perf.c:290:37: sparse: incorrect type in argument 4 (different base types) @@ expected unsigned int val @@ got ed int val @@
   drivers/ntb/test/ntb_perf.c:290:37: expected unsigned int val
   drivers/ntb/test/ntb_perf.c:290:37: got restricted __le32 <noident>
   drivers/ntb/test/ntb_perf.c:324:23: sparse: cast to restricted __le32
   drivers/ntb/test/ntb_perf.c:331:25: sparse: cast to restricted __le32
   drivers/ntb/test/ntb_perf.c:334:31: sparse: cast to restricted __le32
   drivers/ntb/test/ntb_perf.c:338:32: sparse: incorrect type in argument 3 (different base types) @@ expected unsigned int val @@ got ed int val @@
   drivers/ntb/test/ntb_perf.c:338:32: expected unsigned int val
   drivers/ntb/test/ntb_perf.c:338:32: got restricted __le32 <noident>
>> drivers/ntb/test/ntb_perf.c:374:31: sparse: incorrect type in argument 4 (different base types) @@ expected unsigned int msg @@ got ed int msg @@
   drivers/ntb/test/ntb_perf.c:374:31: expected unsigned int msg
   drivers/ntb/test/ntb_perf.c:374:31: got restricted __le32 <noident>
   drivers/ntb/test/ntb_perf.c:382:31: sparse: incorrect type in argument 4 (different base types) @@ expected unsigned int msg @@ got ed int msg @@
   drivers/ntb/test/ntb_perf.c:382:31: expected unsigned int msg
   drivers/ntb/test/ntb_perf.c:382:31: got restricted __le32 <noident>
   drivers/ntb/test/ntb_perf.c:387:31: sparse: incorrect type in argument 4 (different base types) @@ expected unsigned int msg @@ got ed int msg @@
   drivers/ntb/test/ntb_perf.c:387:31: expected unsigned int msg
   drivers/ntb/test/ntb_perf.c:387:31: got restricted __le32 <noident>
   drivers/ntb/test/ntb_perf.c:407:16: sparse: cast to restricted __le32
   drivers/ntb/test/ntb_perf.c:410:17: sparse: cast to restricted __le32
   drivers/ntb/test/ntb_perf.c:413:23: sparse: cast to restricted __le32

vim +276 drivers/ntb/test/ntb_perf.c

   253	
   254	static int perf_spad_cmd_send(struct perf_peer *peer, enum perf_cmd cmd,
   255				      u64 data)
   256	{
   257		struct perf_ctx *perf = peer->perf;
   258		int try;
   259		u32 sts;
   260	
   261		dev_dbg(&perf->ntb->dev, "CMD send: %d 0x%llx\n", cmd, data);
   262	
   263		/*
   264		 * Perform predefined number of attempts before give up.
   265		 * We are sending the data to the port specific scratchpad, so
   266		 * to prevent a multi-port access race-condition. Additionally
   267		 * there is no need in local locking since only thread-safe
   268		 * service work is using this method.
   269		 */
   270		for (try = 0; try < MSG_TRIES; try++) {
   271			if (!perf_link_is_up(peer))
   272				return -ENOLINK;
   273	
   274			sts = ntb_peer_spad_read(perf->ntb, peer->pidx,
   275						 PERF_SPAD_CMD(perf->gidx));
 > 276			if (le32_to_cpu(sts) != PERF_CMD_INVAL) {
   277				usleep_range(MSG_UDELAY_LOW, MSG_UDELAY_HIGH);
   278				continue;
   279			}
   280	
   281			ntb_peer_spad_write(perf->ntb, peer->pidx,
   282					    PERF_SPAD_LDATA(perf->gidx),
 > 283					    cpu_to_le32(lower_32_bits(data)));
   284			ntb_peer_spad_write(perf->ntb, peer->pidx,
   285					    PERF_SPAD_HDATA(perf->gidx),
   286					    cpu_to_le32(upper_32_bits(data)));
   287			mmiowb();
   288			ntb_peer_spad_write(perf->ntb, peer->pidx,
   289					    PERF_SPAD_CMD(perf->gidx),
 > 290					    cpu_to_le32(cmd));
   291			mmiowb();
   292			ntb_peer_db_set(perf->ntb, PERF_SPAD_NOTIFY(peer->gidx));
   293	
   294			dev_dbg(&perf->ntb->dev, "DB ring peer %#llx\n",
   295				PERF_SPAD_NOTIFY(peer->gidx));
   296	
   297			break;
   298		}
   299	
   300		return try < MSG_TRIES ? 0 : -EAGAIN;
   301	}
   302	
   303	static int perf_spad_cmd_recv(struct perf_ctx *perf, int *pidx,
   304				      enum perf_cmd *cmd, u64 *data)
   305	{
   306		struct perf_peer *peer;
   307		u32 val;
   308	
   309		ntb_db_clear(perf->ntb, PERF_SPAD_NOTIFY(perf->gidx));
   310	
   311		/*
   312		 * We start scanning all over, since cleared DB may have been set
   313		 * by any peer. Yes, it makes peer with smaller index being
   314		 * serviced with greater priority, but it's convenient for spad
   315		 * and message code unification and simplicity.
   316		 */
   317		for (*pidx = 0; *pidx < perf->pcnt; (*pidx)++) {
   318			peer = &perf->peers[*pidx];
   319	
   320			if (!perf_link_is_up(peer))
   321				continue;
   322	
   323			val = ntb_spad_read(perf->ntb, PERF_SPAD_CMD(peer->gidx));
   324			val = le32_to_cpu(val);
   325			if (val == PERF_CMD_INVAL)
   326				continue;
   327	
   328			*cmd = val;
   329	
   330			val = ntb_spad_read(perf->ntb, PERF_SPAD_LDATA(peer->gidx));
   331			*data = le32_to_cpu(val);
   332	
   333			val = ntb_spad_read(perf->ntb, PERF_SPAD_HDATA(peer->gidx));
   334			*data |= (u64)le32_to_cpu(val) << 32;
   335	
   336			/* Next command can be retrieved from now */
   337			ntb_spad_write(perf->ntb, PERF_SPAD_CMD(peer->gidx),
   338				       cpu_to_le32(PERF_CMD_INVAL));
   339	
   340			dev_dbg(&perf->ntb->dev, "CMD recv: %d 0x%llx\n", *cmd, *data);
   341	
   342			return 0;
   343		}
   344	
   345		return -ENODATA;
   346	}
   347	
   348	static int perf_msg_cmd_send(struct perf_peer *peer, enum perf_cmd cmd,
   349				     u64 data)
   350	{
   351		struct perf_ctx *perf = peer->perf;
   352		int try, ret;
   353		u64 outbits;
   354	
   355		dev_dbg(&perf->ntb->dev, "CMD send: %d 0x%llx\n", cmd, data);
   356	
   357		/*
   358		 * Perform predefined number of attempts before give up. Message
   359		 * registers are free of race-condition problem when accessed
   360		 * from different ports, so we don't need splitting registers
   361		 * by global device index. We also won't have local locking,
   362		 * since the method is used from service work only.
   363		 */
   364		outbits = ntb_msg_outbits(perf->ntb);
   365		for (try = 0; try < MSG_TRIES; try++) {
   366			if (!perf_link_is_up(peer))
   367				return -ENOLINK;
   368	
   369			ret = ntb_msg_clear_sts(perf->ntb, outbits);
   370			if (ret)
   371				return ret;
   372	
   373			ntb_peer_msg_write(perf->ntb, peer->pidx, PERF_MSG_LDATA,
 > 374				      cpu_to_le32(lower_32_bits(data)));
   375	
   376			if (ntb_msg_read_sts(perf->ntb) & outbits) {
   377				usleep_range(MSG_UDELAY_LOW, MSG_UDELAY_HIGH);
   378				continue;
   379			}
   380	
   381			ntb_peer_msg_write(perf->ntb, peer->pidx, PERF_MSG_HDATA,
   382				      cpu_to_le32(upper_32_bits(data)));
   383			mmiowb();
   384	
   385			/* This call shall trigger peer message event */
   386			ntb_peer_msg_write(perf->ntb, peer->pidx, PERF_MSG_CMD,
   387				      cpu_to_le32(cmd));
   388	
   389			break;
   390		}
   391	
   392		return try < MSG_TRIES ? 0 : -EAGAIN;
   393	}
   394	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
