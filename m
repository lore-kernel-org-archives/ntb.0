Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com. [2a00:1450:4864:20::243])
        by gmr-mx.google.com with ESMTPS id k15-v6si669290ljh.1.2018.07.14.04.59.00
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Jul 2018 04:59:00 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id p6-v6so26356148ljc.5
        for <linux-ntb@googlegroups.com>; Sat, 14 Jul 2018 04:59:00 -0700 (PDT)
Return-Path: <fancer.lancer@gmail.com>
From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 1/4] ntb: idt: Alter temperature read method
Date: Sat, 14 Jul 2018 14:58:31 +0300
Message-Id: <20180714115834.3350-2-fancer.lancer@gmail.com>
In-Reply-To: <20180714115834.3350-1-fancer.lancer@gmail.com>
References: <20180714115834.3350-1-fancer.lancer@gmail.com>
To: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

In order to create a hwmon interface for the IDT PCIe-switch temperature
sensor the already available reader method should be improved. Particularly
we need to redesign it so one would be able to read temperature/offset
values from registers of the passed types. Since IDT sensor interface
provides temperature in unsigned format 0:7:1 (7 bits for real value
and one for fraction) we also need to have helpers for the typical sysfs
temperature data type conversion to and from this format. Even though
the IDT PCIe-switch provided temperature offset got the same but signed
type it can be translated by these methods too.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/ntb/hw/idt/ntb_hw_idt.c | 113 ++++++++++++++++++++++++++++++++++------
 drivers/ntb/hw/idt/ntb_hw_idt.h |  56 ++++++++++++++++++++
 2 files changed, 152 insertions(+), 17 deletions(-)

diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
index c1d03f951b0d..928f37877790 100644
--- a/drivers/ntb/hw/idt/ntb_hw_idt.c
+++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
@@ -1830,22 +1830,99 @@ static int idt_ntb_peer_msg_write(struct ntb_dev *ntb, int pidx, int midx,
  */
 
 /*
+ * idt_get_deg() - convert millidegree Celsius value to just degree
+ * @mdegC:	IN - millidegree Celsius value
+ *
+ * Return: Degree corresponding to the passed millidegree value
+ */
+static inline s8 idt_get_deg(long mdegC)
+{
+	return mdegC / 1000;
+}
+
+/*
+ * idt_get_frac() - retrieve 0/0.5 fraction of the millidegree Celsius value
+ * @mdegC:	IN - millidegree Celsius value
+ *
+ * Return: 0/0.5 degree fraction of the passed millidegree value
+ */
+static inline u8 idt_get_deg_frac(long mdegC)
+{
+	return (mdegC % 1000) >= 500 ? 5 : 0;
+}
+
+/*
+ * idt_get_temp_fmt() - convert millidegree Celsius value to 0:7:1 format
+ * @mdegC:	IN - millidegree Celsius value
+ *
+ * Return: 0:7:1 format acceptable by the IDT temperature sensor
+ */
+static inline u8 idt_temp_get_fmt(long mdegC)
+{
+	return (idt_get_deg(mdegC) << 1) | (idt_get_deg_frac(mdegC) ? 1 : 0);
+}
+
+/*
+ * idt_get_temp_sval() - convert temp sample to signed millidegree Celsius
+ * @data:	IN - shifted to LSB 8-bits temperature sample
+ *
+ * Return: signed millidegree Celsius
+ */
+static inline long idt_get_temp_sval(u32 data)
+{
+	return ((s8)data / 2) * 1000 + (data & 0x1 ? 500 : 0);
+}
+
+/*
+ * idt_get_temp_sval() - convert temp sample to unsigned millidegree Celsius
+ * @data:	IN - shifted to LSB 8-bits temperature sample
+ *
+ * Return: unsigned millidegree Celsius
+ */
+static inline long idt_get_temp_uval(u32 data)
+{
+	return (data / 2) * 1000 + (data & 0x1 ? 500 : 0);
+}
+
+/*
  * idt_read_temp() - read temperature from chip sensor
  * @ntb:	NTB device context.
- * @val:	OUT - integer value of temperature
- * @frac:	OUT - fraction
+ * @type:	IN - type of the temperature value to read
+ * @val:	OUT - integer value of temperature in millidegree Celsius
  */
-static void idt_read_temp(struct idt_ntb_dev *ndev, unsigned char *val,
-			  unsigned char *frac)
+static void idt_read_temp(struct idt_ntb_dev *ndev,
+			  const enum idt_temp_val type, long *val)
 {
 	u32 data;
 
-	/* Read the data from TEMP field of the TMPSTS register */
-	data = idt_sw_read(ndev, IDT_SW_TMPSTS);
-	data = GET_FIELD(TMPSTS_TEMP, data);
-	/* TEMP field has one fractional bit and seven integer bits */
-	*val = data >> 1;
-	*frac = ((data & 0x1) ? 5 : 0);
+	/* Alter the temperature field in accordance with the passed type */
+	switch (type) {
+	case IDT_TEMP_CUR:
+		data = GET_FIELD(TMPSTS_TEMP,
+				 idt_sw_read(ndev, IDT_SW_TMPSTS));
+		break;
+	case IDT_TEMP_LOW:
+		data = GET_FIELD(TMPSTS_LTEMP,
+				 idt_sw_read(ndev, IDT_SW_TMPSTS));
+		break;
+	case IDT_TEMP_HIGH:
+		data = GET_FIELD(TMPSTS_HTEMP,
+				 idt_sw_read(ndev, IDT_SW_TMPSTS));
+		break;
+	case IDT_TEMP_OFFSET:
+		/* This is the only field with signed 0:7:1 format */
+		data = GET_FIELD(TMPADJ_OFFSET,
+				 idt_sw_read(ndev, IDT_SW_TMPADJ));
+		*val = idt_get_temp_sval(data);
+		return;
+	default:
+		data = GET_FIELD(TMPSTS_TEMP,
+				 idt_sw_read(ndev, IDT_SW_TMPSTS));
+		break;
+	}
+
+	/* The rest of the fields accept unsigned 0:7:1 format */
+	*val = idt_get_temp_uval(data);
 }
 
 /*
@@ -1861,10 +1938,10 @@ static void idt_read_temp(struct idt_ntb_dev *ndev, unsigned char *val,
  */
 static void idt_temp_isr(struct idt_ntb_dev *ndev, u32 ntint_sts)
 {
-	unsigned char val, frac;
+	unsigned long mdeg;
 
 	/* Read the current temperature value */
-	idt_read_temp(ndev, &val, &frac);
+	idt_read_temp(ndev, IDT_TEMP_CUR, &mdeg);
 
 	/* Read the temperature alarm to clean the alarm status out */
 	/*(void)idt_sw_read(ndev, IDT_SW_TMPALARM);*/
@@ -1876,7 +1953,8 @@ static void idt_temp_isr(struct idt_ntb_dev *ndev, u32 ntint_sts)
 		"Temp sensor IRQ detected %#08x", ntint_sts);
 
 	/* Print temperature value to log */
-	dev_warn(&ndev->ntb.pdev->dev, "Temperature %hhu.%hhu", val, frac);
+	dev_warn(&ndev->ntb.pdev->dev, "Temperature %hhd.%hhuC",
+		idt_get_deg(mdeg), idt_get_deg_frac(mdeg));
 }
 
 /*=============================================================================
@@ -2124,9 +2202,9 @@ static ssize_t idt_dbgfs_info_read(struct file *filp, char __user *ubuf,
 				   size_t count, loff_t *offp)
 {
 	struct idt_ntb_dev *ndev = filp->private_data;
-	unsigned char temp, frac, idx, pidx, cnt;
+	unsigned char idx, pidx, cnt;
+	unsigned long irqflags, mdeg;
 	ssize_t ret = 0, off = 0;
-	unsigned long irqflags;
 	enum ntb_speed speed;
 	enum ntb_width width;
 	char *strbuf;
@@ -2275,9 +2353,10 @@ static ssize_t idt_dbgfs_info_read(struct file *filp, char __user *ubuf,
 	off += scnprintf(strbuf + off, size - off, "\n");
 
 	/* Current temperature */
-	idt_read_temp(ndev, &temp, &frac);
+	idt_read_temp(ndev, IDT_TEMP_CUR, &mdeg);
 	off += scnprintf(strbuf + off, size - off,
-		"Switch temperature\t\t- %hhu.%hhuC\n", temp, frac);
+		"Switch temperature\t\t- %hhd.%hhuC\n",
+		idt_get_deg(mdeg), idt_get_deg_frac(mdeg));
 
 	/* Copy the buffer to the User Space */
 	ret = simple_read_from_buffer(ubuf, count, offp, strbuf, off);
diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.h b/drivers/ntb/hw/idt/ntb_hw_idt.h
index 856fd182f6f4..9dfd6b11a621 100644
--- a/drivers/ntb/hw/idt/ntb_hw_idt.h
+++ b/drivers/ntb/hw/idt/ntb_hw_idt.h
@@ -886,12 +886,42 @@
 #define IDT_SWPxMSGCTL_PART_FLD		4
 
 /*
+ * TMPCTL register fields related constants
+ * @IDT_TMPCTL_LTH_MASK:	Low temperature threshold field mask
+ * @IDT_TMPCTL_LTH_FLD:		Low temperature threshold field offset
+ * @IDT_TMPCTL_MTH_MASK:	Middle temperature threshold field mask
+ * @IDT_TMPCTL_MTH_FLD:		Middle temperature threshold field offset
+ * @IDT_TMPCTL_HTH_MASK:	High temperature threshold field mask
+ * @IDT_TMPCTL_HTH_FLD:		High temperature threshold field offset
+ * @IDT_TMPCTL_PDOWN:		Temperature sensor power down
+ */
+#define IDT_TMPCTL_LTH_MASK		0x000000FFU
+#define IDT_TMPCTL_LTH_FLD		0
+#define IDT_TMPCTL_MTH_MASK		0x0000FF00U
+#define IDT_TMPCTL_MTH_FLD		8
+#define IDT_TMPCTL_HTH_MASK		0x00FF0000U
+#define IDT_TMPCTL_HTH_FLD		16
+#define IDT_TMPCTL_PDOWN		0x80000000U
+
+/*
  * TMPSTS register fields related constants
  * @IDT_TMPSTS_TEMP_MASK:	Current temperature field mask
  * @IDT_TMPSTS_TEMP_FLD:	Current temperature field offset
  */
 #define IDT_TMPSTS_TEMP_MASK		0x000000FFU
 #define IDT_TMPSTS_TEMP_FLD		0
+#define IDT_TMPSTS_LTEMP_MASK		0x0000FF00U
+#define IDT_TMPSTS_LTEMP_FLD		8
+#define IDT_TMPSTS_HTEMP_MASK		0x00FF0000U
+#define IDT_TMPSTS_HTEMP_FLD		16
+
+/*
+ * TMPADJ register fields related constants
+ * @IDT_TMPADJ_OFFSET_MASK:	Temperature value offset field mask
+ * @IDT_TMPADJ_OFFSET_FLD:	Temperature value offset field offset
+ */
+#define IDT_TMPADJ_OFFSET_MASK		0x000000FFU
+#define IDT_TMPADJ_OFFSET_FLD		0
 
 /*
  * Helper macro to get/set the corresponding field value
@@ -951,6 +981,32 @@
 #define IDT_DIR_SIZE_ALIGN	1
 
 /*
+ * IDT PCIe-switch temperature sensor value limits
+ * @IDT_TEMP_MIN_MDEG:	Minimal integer value of temperature
+ * @IDT_TEMP_MAX_MDEG:	Maximal integer value of temperature
+ * @IDT_TEMP_MIN_OFFSET:Minimal integer value of temperature offset
+ * @IDT_TEMP_MAX_OFFSET:Maximal integer value of temperature offset
+ */
+#define IDT_TEMP_MIN_MDEG	0
+#define IDT_TEMP_MAX_MDEG	127500
+#define IDT_TEMP_MIN_OFFSET	-64000
+#define IDT_TEMP_MAX_OFFSET	63500
+
+/*
+ * Temperature sensor values enumeration
+ * @IDT_TEMP_CUR:	Current temperature
+ * @IDT_TEMP_LOW:	Lowest historical temperature
+ * @IDT_TEMP_HIGH:	Highest historical temperature
+ * @IDT_TEMP_OFFSET:	Current temperature offset
+ */
+enum idt_temp_val {
+	IDT_TEMP_CUR,
+	IDT_TEMP_LOW,
+	IDT_TEMP_HIGH,
+	IDT_TEMP_OFFSET
+};
+
+/*
  * IDT Memory Windows type. Depending on the device settings, IDT supports
  * Direct Address Translation MW registers and Lookup Table registers
  * @IDT_MW_DIR:		Direct address translation
-- 
2.12.0

