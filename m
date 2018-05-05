Return-Path: <araut@codeaurora.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org. [198.145.29.96])
        by gmr-mx.google.com with ESMTPS id d13-v6si911835iop.2.2018.05.04.19.42.49
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 May 2018 19:42:49 -0700 (PDT)
Subject: Re: [PATCH 1/4] NTB : Introduce message library
References: <20180410004822.GA6040@codeaurora.org>
 <CAJ80sauVAeFLfMMQxqnCThUZnYJ1A7Kvy=UogPMe_kWCu_Dw9w@mail.gmail.com>
 <c4d81c97-71f3-a832-2b6b-52c84b9854ac@codeaurora.org>
 <3dbf0543-8a0c-5493-54d3-116514a55a1b@intel.com>
From: Atul Raut <araut@codeaurora.org>
Message-ID: <7815b9ce-a445-bf49-dd3c-c84c6879ed1d@codeaurora.org>
Date: Fri, 4 May 2018 19:42:46 -0700
MIME-Version: 1.0
In-Reply-To: <3dbf0543-8a0c-5493-54d3-116514a55a1b@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
Cc: "linux-ntb@googlegroups.com; fancer.lancer@gmail.com;jdmason"@kudzu.us, fancer.lancer@gmail.com, Jon Mason <jdmason@kudzu.us>, atulraut17@gmail.com, rauji.raut@gmail.com
List-ID: <linux-ntb.googlegroups.com>

Hi all,

Have split up the patches & sharing again for review.
This is first patch out of four patches.
This is header file patch where function prototypes defined.
 
Regards,
Atul    

From 4bbcffda753806afd7da021ed6a0c52f058a9c7c Mon Sep 17 00:00:00 2001
From: Atul Raut <araut@codeaurora.org>
Date: Fri, 4 May 2018 19:12:53 -0700
Subject: [PATCH 1/4] NTB : Introduce message library

Library created by refactoring common code from
ntb_perf module so that all client can make use
of it.
The library is based on scratchpad and message registers
based apis.

Signed-off-by: Atul Raut <araut@codeaurora.org>
---
 include/linux/ntb.h | 163 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 163 insertions(+)

diff --git a/include/linux/ntb.h b/include/linux/ntb.h
index 181d166..19fe973 100644
--- a/include/linux/ntb.h
+++ b/include/linux/ntb.h
@@ -58,6 +58,8 @@
 
 #include <linux/completion.h>
 #include <linux/device.h>
+#include <linux/delay.h>
+#include <linux/io.h>
 
 struct ntb_client;
 struct ntb_dev;
@@ -163,6 +165,56 @@ enum ntb_default_port {
 #define NTB_DEF_PEER_CNT	(1)
 #define NTB_DEF_PEER_IDX	(0)
 
+enum nt_cmd {
+	NT_CMD_INVAL = -1,/* invalid spad command */
+	NT_CMD_SSIZE = 0, /* send out buffer size */
+	NT_CMD_RSIZE = 1, /* recv in  buffer size */
+	NT_CMD_SXLAT = 2, /* send in  buffer xlat */
+	NT_CMD_RXLAT = 3, /* recv out buffer xlat */
+	NT_CMD_CLEAR = 4, /* clear allocated memory */
+	NT_STS_DONE  = 5, /* init is done */
+	NT_STS_LNKUP = 6, /* link up state flag */
+	NT_QP_LINKS        = 7, /* available QP link */
+	NT_CMD_NUM_MWS        = 8, /* number of memory windows */
+	NT_CMD_NUM_QPS        = 9, /* number of QP */
+	NT_CMD_NTB_VERSION    = 10, /* ntb version */
+};
+
+struct msg_type {
+/* Scratchpad/Message IO operations */
+	int (*cmd_send)(struct ntb_dev *nt, int pidx, enum nt_cmd cmd,
+			int cmd_wid, u64 data);
+	int (*cmd_recv)(struct ntb_dev *nt, int *pidx, enum nt_cmd *cmd,
+			int *cmd_wid, u64 *data);
+};
+
+#define MSG_TRIES		50
+#define MSG_UDELAY_LOW		1000
+#define MSG_UDELAY_HIGH		2000
+
+/**
+ * Scratchpads-base commands interface
+ */
+#define NT_SPAD_CNT(_pcnt) \
+	(3*((_pcnt) + 1))
+#define NT_SPAD_CMD(_gidx) \
+	(3*(_gidx))
+#define NT_SPAD_LDATA(_gidx) \
+	(3*(_gidx) + 1)
+#define NT_SPAD_HDATA(_gidx) \
+	(3*(_gidx) + 2)
+#define NT_SPAD_NOTIFY(_gidx) \
+	(BIT_ULL(_gidx))
+
+/**
+ * Messages-base commands interface
+ */
+#define NT_MSG_CMD		0
+#define NT_MSG_CMD_WID	        1
+#define NT_MSG_LDATA		2
+#define NT_MSG_HDATA		3
+#define NT_MSG_CNT		4
+
 /**
  * struct ntb_client_ops - ntb client operations
  * @probe:		Notify client of a new device.
@@ -1502,4 +1554,115 @@ static inline int ntb_peer_msg_write(struct ntb_dev *ntb, int pidx, int midx,
 	return ntb->ops->peer_msg_write(ntb, pidx, midx, msg);
 }
 
+/**
+ * nt_spad_cmd_send() - send messages to peer using spad register.
+ * @ntb:	NTB device context.
+ * @pidx:	Port index of peer device.
+ * @cmd:	ntb commands.
+ * @cmd_gidx:	Global device index.
+ * @data:	message data.
+ *
+ * Send data to the port specific scratchpad
+ *
+ * Perform predefined number of attempts before give up.
+ * We are sending the data to the port specific scratchpad, so
+ * to prevent a multi-port access race-condition. Additionally
+ * there is no need in local locking since only thread-safe
+ * service work is using this method.
+ *
+ * Set peer db to inform data is ready.
+ *
+ * Return: Zero on success, otherwise an error number.
+ */
+int nt_spad_cmd_send(struct ntb_dev *ntb, int pidx, enum nt_cmd cmd,
+		     int cmd_gidx, u64 data);
+
+/**
+ * nt_spad_cmd_recv() - Receive the messages using spad register.
+ * @ntb:	NTB device context.
+ * @pidx:	Port index of peer device a message being receive
+ * @cmd:	NTB command
+ * @cmd_wid:	Gloable device Index
+ * @data:	Received data
+ *
+ * Clear bits in the peer doorbell register, arming the bits for the next
+ * doorbell.
+ *
+ * We start scanning all over, since cleared DB may have been set
+ * by any peer. Yes, it makes peer with smaller index being
+ * serviced with greater priority, but it's convenient for spad
+ * and message code unification and simplicity.
+ *
+ * Return: Zero on success, otherwise an error number.
+ */
+int nt_spad_cmd_recv(struct ntb_dev *ntb, int *pidx,
+		     enum nt_cmd *cmd, int *cmd_wid, u64 *data);
+
+/**
+ * nt_msg_cmd_send() - send messages to peer using message register.
+ * @ntb:	NTB device context.
+ * @pidx:	Port index of peer device.
+ * @cmd:	ntb commands.
+ * @cmd_gidx:	Memory window index.
+ * @data:	message data.
+ *
+ * Perform predefined number of attempts before give up. Message
+ * registers are free of race-condition problem when accessed
+ * from different ports, so we don't need splitting registers
+ * by global device index. We also won't have local locking,
+ * since the method is used from service work only.
+ *
+ * Return: Zero on success, otherwise an error number.
+ */
+int nt_msg_cmd_send(struct ntb_dev *nt, int pidx, enum nt_cmd cmd,
+		    int cmd_wid, u64 data);
+
+/**
+ * nt_msg_cmd_recv() - Receive the messages using message register.
+ * @ntb:	NTB device context.
+ * @pidx:	Port index of peer device a message being receive
+ * @cmd:	NT command
+ * @cmd_wid:	Memory window Index
+ * @data:	Received data
+ *
+ * Get memory window index and data.
+ *
+ * Return: Zero on success, otherwise an error number.
+ */
+int nt_msg_cmd_recv(struct ntb_dev *nt, int *pidx,
+		    enum nt_cmd *cmd, int *cmd_wid, u64 *data);
+
+/**
+ * nt_enable_messaging() - Enable messaging support.
+ * @ntb:	NTB device context.
+ * @gitx:	Global device Index.
+ *
+ * Check which messaging support to enable
+ *
+ * Return: Zero on success, otherwise an error number.
+ */
+int nt_enable_messaging(struct ntb_dev *ndev, int gidx);
+
+/**
+ * nt_disable_messaging() - Disable messaging support.
+ * @ntb:	NTB device context.
+ * @gidx:	Global device Index
+ *
+ * Check message type(spad/message) and disable messaging support.
+ *
+ */
+void nt_disable_messaging(struct ntb_dev *ndev, int gidx);
+
+/**
+ * nt_init_messaging() - Enable Messaging
+ * @ntb:	NTB device context.
+ * @msg_ptr:	Handle to function pointers Scratchpad or Message.
+ *
+ *
+ * Enable Scratchpad/Message IO operations.
+ *
+ * Return: Zero on success, otherwise an error number.
+ */
+int nt_init_messaging(struct ntb_dev *ndev, struct msg_type *msg_ptr);
+
 #endif
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

