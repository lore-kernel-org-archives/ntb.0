Return-Path: <araut@codeaurora.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org. [198.145.29.96])
        by gmr-mx.google.com with ESMTPS id s193-v6si1474456oih.4.2018.05.04.19.48.31
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 May 2018 19:48:31 -0700 (PDT)
Subject: [PATCH 2/4] NTB : Add message library NTB API
References: <20180410004822.GA6040@codeaurora.org>
 <CAJ80sauVAeFLfMMQxqnCThUZnYJ1A7Kvy=UogPMe_kWCu_Dw9w@mail.gmail.com>
 <c4d81c97-71f3-a832-2b6b-52c84b9854ac@codeaurora.org>
 <3dbf0543-8a0c-5493-54d3-116514a55a1b@intel.com>
From: Atul Raut <araut@codeaurora.org>
Message-ID: <9e5b999d-c98a-14ea-28ab-478bfd225ea9@codeaurora.org>
Date: Fri, 4 May 2018 19:48:29 -0700
MIME-Version: 1.0
In-Reply-To: <3dbf0543-8a0c-5493-54d3-116514a55a1b@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
Cc: linux-ntb@googlegroups.com, jdmason@kudzu.us, fancer.lancer@gmail.com, fancer.lancer@gmail.com, Jon Mason <jdmason@kudzu.us>, atulraut17@gmail.com, rauji.raut@gmail.com
List-ID: <linux-ntb.googlegroups.com>

Hi all,

This second patch out of four patches.
This patch has function definition for NTB api library
based on scratchpad and message registers.

Regards,
Atul

From 57bb5656479770b83fdfebd731fa161bd0903dab Mon Sep 17 00:00:00 2001
From: Atul Raut <araut@codeaurora.org>
Date: Fri, 4 May 2018 19:26:18 -0700
Subject: [PATCH 2/4] NTB :  Add message library NTB API

This patch brings in function definations for
the NTB library API.

Signed-off-by: Atul Raut <araut@codeaurora.org>
---
 drivers/ntb/ntb.c | 222 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 222 insertions(+)

diff --git a/drivers/ntb/ntb.c b/drivers/ntb/ntb.c
index 2581ab7..c025e03 100644
--- a/drivers/ntb/ntb.c
+++ b/drivers/ntb/ntb.c
@@ -258,6 +258,228 @@ int ntb_default_peer_port_idx(struct ntb_dev *ntb, int port)
 }
 EXPORT_SYMBOL(ntb_default_peer_port_idx);
 
+int nt_spad_cmd_send(struct ntb_dev *ntb, int pidx, enum nt_cmd cmd,
+			    int cmd_gidx, u64 data)
+{
+	int try;
+	u32 sts;
+	int gidx = ntb_port_number(ntb);
+
+	for (try = 0; try < MSG_TRIES; try++) {
+		if (!ntb_link_is_up(ntb, NULL, NULL))
+			return -ENOLINK;
+
+		sts = ntb_peer_spad_read(ntb, pidx,
+					 NT_SPAD_CMD(gidx));
+		if (sts != NT_CMD_INVAL) {
+			usleep_range(MSG_UDELAY_LOW, MSG_UDELAY_HIGH);
+			continue;
+		}
+
+		ntb_peer_spad_write(ntb, pidx,
+				    NT_SPAD_LDATA(gidx),
+				    lower_32_bits(data));
+		ntb_peer_spad_write(ntb, pidx,
+				    NT_SPAD_HDATA(gidx),
+				    upper_32_bits(data));
+		mmiowb();
+		ntb_peer_spad_write(ntb, pidx,
+				    NT_SPAD_CMD(gidx),
+				    cmd);
+
+		ntb_peer_db_set(ntb, NT_SPAD_NOTIFY(cmd_gidx));
+
+		break;
+	}
+
+	return try < MSG_TRIES ? 0 : -EAGAIN;
+}
+EXPORT_SYMBOL(nt_spad_cmd_send);
+
+int nt_spad_cmd_recv(struct ntb_dev *ntb, int *pidx,
+			enum nt_cmd *cmd, int *cmd_wid, u64 *data)
+{
+	u32 val;
+	int gidx = 0;
+	int key = ntb_port_number(ntb);
+
+	ntb_db_clear(ntb, NT_SPAD_NOTIFY(key));
+
+	for (*pidx = 0; *pidx < ntb_peer_port_count(ntb); (*pidx)++, gidx++) {
+		if ((*pidx) == key)
+			++gidx;
+
+		if (!ntb_link_is_up(ntb, NULL, NULL))
+			continue;
+
+		val = ntb_spad_read(ntb, NT_SPAD_CMD(gidx));
+		if (val == NT_CMD_INVAL)
+			continue;
+
+		*cmd = val;
+
+		val = ntb_spad_read(ntb, NT_SPAD_LDATA(gidx));
+		*data = val;
+
+		val = ntb_spad_read(ntb, NT_SPAD_HDATA(gidx));
+		*data |= (u64)val << 32;
+
+		/* Next command can be retrieved from now */
+		ntb_spad_write(ntb, NT_SPAD_CMD(gidx),
+			NT_CMD_INVAL);
+
+		return 0;
+	}
+
+	return -ENODATA;
+}
+EXPORT_SYMBOL(nt_spad_cmd_recv);
+
+int nt_msg_cmd_send(struct ntb_dev *nt, int pidx, enum nt_cmd cmd,
+int cmd_wid, u64 data)
+{
+	int try, ret;
+	u64 outbits;
+
+	outbits = ntb_msg_outbits(nt);
+	for (try = 0; try < MSG_TRIES; try++) {
+		if (!ntb_link_is_up(nt, NULL, NULL))
+			return -ENOLINK;
+
+		ret = ntb_msg_clear_sts(nt, outbits);
+		if (ret)
+			return ret;
+
+		ntb_peer_msg_write(nt, pidx, NT_MSG_LDATA,
+			cpu_to_le32(lower_32_bits(data)));
+
+		if (ntb_msg_read_sts(nt) & outbits) {
+			usleep_range(MSG_UDELAY_LOW, MSG_UDELAY_HIGH);
+			continue;
+		}
+
+		ntb_peer_msg_write(nt, pidx, NT_MSG_HDATA,
+			cpu_to_le32(upper_32_bits(data)));
+		mmiowb();
+
+		ntb_peer_msg_write(nt, pidx, NT_MSG_CMD_WID,
+			cpu_to_le32(cmd_wid));
+
+		/* This call shall trigger peer message event */
+		ntb_peer_msg_write(nt, pidx, NT_MSG_CMD,
+			cpu_to_le32(cmd));
+
+		break;
+	}
+
+	return try < MSG_TRIES ? 0 : -EAGAIN;
+}
+EXPORT_SYMBOL(nt_msg_cmd_send);
+
+int nt_msg_cmd_recv(struct ntb_dev *nt, int *pidx,
+			enum nt_cmd *cmd, int *cmd_wid, u64 *data)
+{
+	u64 inbits;
+	u32 val;
+
+	inbits = ntb_msg_inbits(nt);
+
+	if (hweight64(ntb_msg_read_sts(nt) & inbits) < 4)
+		return -ENODATA;
+
+	val = ntb_msg_read(nt, pidx, NT_MSG_CMD);
+	*cmd = le32_to_cpu(val);
+
+	val = ntb_msg_read(nt, pidx, NT_MSG_CMD_WID);
+	*cmd_wid = le32_to_cpu(val);
+
+	val = ntb_msg_read(nt, pidx, NT_MSG_LDATA);
+	*data = le32_to_cpu(val);
+
+	val = ntb_msg_read(nt, pidx, NT_MSG_HDATA);
+	*data |= (u64)le32_to_cpu(val) << 32;
+
+	/* Next command can be retrieved from now */
+	ntb_msg_clear_sts(nt, inbits);
+
+	return 0;
+}
+EXPORT_SYMBOL(nt_msg_cmd_recv);
+
+int nt_enable_messaging(struct ntb_dev *ndev, int gidx)
+{
+	u64 mask, incmd_bit;
+	int ret, sidx, scnt;
+
+	mask = ntb_db_valid_mask(ndev);
+	(void)ntb_db_set_mask(ndev, mask);
+
+	if (ntb_msg_count(ndev) >= NT_MSG_CNT) {
+		u64 inbits, outbits;
+
+		inbits = ntb_msg_inbits(ndev);
+		outbits = ntb_msg_outbits(ndev);
+		(void)ntb_msg_set_mask(ndev, inbits | outbits);
+
+		incmd_bit = BIT_ULL(__ffs64(inbits));
+		ret = ntb_msg_clear_mask(ndev, incmd_bit);
+	} else {
+		scnt = ntb_spad_count(ndev);
+		for (sidx = 0; sidx < scnt; sidx++)
+			ntb_spad_write(ndev, sidx, NT_CMD_INVAL);
+		incmd_bit = NT_SPAD_NOTIFY(gidx);
+		ret = ntb_db_clear_mask(ndev, incmd_bit);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(nt_enable_messaging);
+
+void nt_disable_messaging(struct ntb_dev *ndev, int gidx)
+{
+	if (ntb_msg_count(ndev) >= NT_MSG_CNT) {
+		u64 inbits;
+
+		inbits = ntb_msg_inbits(ndev);
+		(void)ntb_msg_set_mask(ndev, inbits);
+	} else {
+		(void)ntb_db_set_mask(ndev, NT_SPAD_NOTIFY(gidx));
+	}
+
+}
+EXPORT_SYMBOL(nt_disable_messaging);
+
+int nt_init_messaging(struct ntb_dev *ndev, struct msg_type *msg_ptr)
+{
+	u64 mask;
+	int pcnt = ntb_peer_port_count(ndev);
+
+	if (ntb_peer_mw_count(ndev) < (pcnt + 1)) {
+		dev_err(&ndev->dev, "Not enough memory windows\n");
+		return -EINVAL;
+	}
+
+	if (ntb_msg_count(ndev) >= NT_MSG_CNT) {
+		msg_ptr->cmd_send = nt_msg_cmd_send;
+		msg_ptr->cmd_recv = nt_msg_cmd_recv;
+
+		return 0;
+	}
+
+	mask = GENMASK_ULL(pcnt, 0);
+	if (ntb_spad_count(ndev) >= NT_SPAD_CNT(pcnt) &&
+	    (ntb_db_valid_mask(ndev) & mask) == mask) {
+		msg_ptr->cmd_send = nt_spad_cmd_send;
+		msg_ptr->cmd_recv = nt_spad_cmd_recv;
+
+		return 0;
+	}
+	dev_err(&ndev->dev, "Command services unsupported\n");
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL(nt_init_messaging);
+
 static int ntb_probe(struct device *dev)
 {
 	struct ntb_dev *ntb;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

