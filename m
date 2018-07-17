Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com. [2a00:1450:4864:20::22a])
        by gmr-mx.google.com with ESMTPS id q17-v6si15534lfc.4.2018.07.17.02.24.58
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 02:24:58 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id p6-v6so379551ljc.5
        for <linux-ntb@googlegroups.com>; Tue, 17 Jul 2018 02:24:58 -0700 (PDT)
Return-Path: <fancer.lancer@gmail.com>
From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH v2 2/4] ntb: idt: Add basic hwmon sysfs interface
Date: Tue, 17 Jul 2018 12:24:35 +0300
Message-Id: <20180717092437.18918-3-fancer.lancer@gmail.com>
In-Reply-To: <20180717092437.18918-1-fancer.lancer@gmail.com>
References: <20180714115834.3350-1-fancer.lancer@gmail.com>
 <20180717092437.18918-1-fancer.lancer@gmail.com>
To: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

IDT PCIe switches provide an embedded temperature sensor working
within [0; 127.5]C with resolution of 0.5C. They also can generate
a PCIe upstream interrupt in case if the temperature passes through
specified thresholds. Since this thresholds interface is very broken
the created hwmon-sysfs interface exposes only the next set of hwmon
nodes: current input temperature, lowest and highest values measured,
history resetting, value offset. HWmon alarm interface isn't provided.

IDT PCIe switch also've got an ADC/filter settings of the sensor.
This driver doesn't expose them to the hwmon-sysfs interface at the
moment, except the offset node.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---

Changelog v2:
- Add "select HWMON" to the NTB_IDT kconfig

 drivers/ntb/hw/idt/Kconfig      |   1 +
 drivers/ntb/hw/idt/ntb_hw_idt.c | 182 ++++++++++++++++++++++++++++++++++++++++
 drivers/ntb/hw/idt/ntb_hw_idt.h |  24 +++++-
 3 files changed, 206 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/hw/idt/Kconfig b/drivers/ntb/hw/idt/Kconfig
index b360e5613b9f..2ed147368fa8 100644
--- a/drivers/ntb/hw/idt/Kconfig
+++ b/drivers/ntb/hw/idt/Kconfig
@@ -1,6 +1,7 @@
 config NTB_IDT
 	tristate "IDT PCIe-switch Non-Transparent Bridge support"
 	depends on PCI
+	select HWMON
 	help
 	 This driver supports NTB of cappable IDT PCIe-switches.
 
diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
index c086ae5c601c..f12088c6a92d 100644
--- a/drivers/ntb/hw/idt/ntb_hw_idt.c
+++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
@@ -49,11 +49,14 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/spinlock.h>
+#include <linux/mutex.h>
 #include <linux/pci.h>
 #include <linux/aer.h>
 #include <linux/slab.h>
 #include <linux/list.h>
 #include <linux/debugfs.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
 #include <linux/ntb.h>
 
 #include "ntb_hw_idt.h"
@@ -1925,6 +1928,153 @@ static void idt_read_temp(struct idt_ntb_dev *ndev,
 }
 
 /*
+ * idt_write_temp() - write temperature to the chip sensor register
+ * @ntb:	NTB device context.
+ * @type:	IN - type of the temperature value to change
+ * @val:	IN - integer value of temperature in millidegree Celsius
+ */
+static void idt_write_temp(struct idt_ntb_dev *ndev,
+			   const enum idt_temp_val type, const long val)
+{
+	unsigned int reg;
+	u32 data;
+	u8 fmt;
+
+	/* Retrieve the properly formatted temperature value */
+	fmt = idt_temp_get_fmt(val);
+
+	mutex_lock(&ndev->hwmon_mtx);
+	switch (type) {
+	case IDT_TEMP_LOW:
+		reg = IDT_SW_TMPALARM;
+		data = SET_FIELD(TMPALARM_LTEMP, idt_sw_read(ndev, reg), fmt) &
+			~IDT_TMPALARM_IRQ_MASK;
+		break;
+	case IDT_TEMP_HIGH:
+		reg = IDT_SW_TMPALARM;
+		data = SET_FIELD(TMPALARM_HTEMP, idt_sw_read(ndev, reg), fmt) &
+			~IDT_TMPALARM_IRQ_MASK;
+		break;
+	case IDT_TEMP_OFFSET:
+		reg = IDT_SW_TMPADJ;
+		data = SET_FIELD(TMPADJ_OFFSET, idt_sw_read(ndev, reg), fmt);
+		break;
+	default:
+		goto inval_spin_unlock;
+	}
+
+	idt_sw_write(ndev, reg, data);
+
+inval_spin_unlock:
+	mutex_unlock(&ndev->hwmon_mtx);
+}
+
+/*
+ * idt_sysfs_show_temp() - printout corresponding temperature value
+ * @dev:	Pointer to the NTB device structure
+ * @da:		Sensor device attribute structure
+ * @buf:	Buffer to print temperature out
+ *
+ * Return: Number of written symbols or negative error
+ */
+static ssize_t idt_sysfs_show_temp(struct device *dev,
+				   struct device_attribute *da, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	struct idt_ntb_dev *ndev = dev_get_drvdata(dev);
+	enum idt_temp_val type = attr->index;
+	long mdeg;
+
+	idt_read_temp(ndev, type, &mdeg);
+	return sprintf(buf, "%ld\n", mdeg);
+}
+
+/*
+ * idt_sysfs_set_temp() - set corresponding temperature value
+ * @dev:	Pointer to the NTB device structure
+ * @da:		Sensor device attribute structure
+ * @buf:	Buffer to print temperature out
+ * @count:	Size of the passed buffer
+ *
+ * Return: Number of written symbols or negative error
+ */
+static ssize_t idt_sysfs_set_temp(struct device *dev,
+				  struct device_attribute *da, const char *buf,
+				  size_t count)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	struct idt_ntb_dev *ndev = dev_get_drvdata(dev);
+	enum idt_temp_val type = attr->index;
+	long mdeg;
+	int ret;
+
+	ret = kstrtol(buf, 10, &mdeg);
+	if (ret)
+		return ret;
+
+	/* Clamp the passed value in accordance with the type */
+	if (type == IDT_TEMP_OFFSET)
+		mdeg = clamp_val(mdeg, IDT_TEMP_MIN_OFFSET,
+				 IDT_TEMP_MAX_OFFSET);
+	else
+		mdeg = clamp_val(mdeg, IDT_TEMP_MIN_MDEG, IDT_TEMP_MAX_MDEG);
+
+	idt_write_temp(ndev, type, mdeg);
+
+	return count;
+}
+
+/*
+ * idt_sysfs_reset_hist() - reset temperature history
+ * @dev:	Pointer to the NTB device structure
+ * @da:		Sensor device attribute structure
+ * @buf:	Buffer to print temperature out
+ * @count:	Size of the passed buffer
+ *
+ * Return: Number of written symbols or negative error
+ */
+static ssize_t idt_sysfs_reset_hist(struct device *dev,
+				    struct device_attribute *da,
+				    const char *buf, size_t count)
+{
+	struct idt_ntb_dev *ndev = dev_get_drvdata(dev);
+
+	/* Just set the maximal value to the lowest temperature field and
+	 * minimal value to the highest temperature field
+	 */
+	idt_write_temp(ndev, IDT_TEMP_LOW, IDT_TEMP_MAX_MDEG);
+	idt_write_temp(ndev, IDT_TEMP_HIGH, IDT_TEMP_MIN_MDEG);
+
+	return count;
+}
+
+/*
+ * Hwmon IDT sysfs attributes
+ */
+static SENSOR_DEVICE_ATTR(temp1_input, 0444, idt_sysfs_show_temp, NULL,
+			  IDT_TEMP_CUR);
+static SENSOR_DEVICE_ATTR(temp1_lowest, 0444, idt_sysfs_show_temp, NULL,
+			  IDT_TEMP_LOW);
+static SENSOR_DEVICE_ATTR(temp1_highest, 0444, idt_sysfs_show_temp, NULL,
+			  IDT_TEMP_HIGH);
+static SENSOR_DEVICE_ATTR(temp1_offset, 0644, idt_sysfs_show_temp,
+			  idt_sysfs_set_temp, IDT_TEMP_OFFSET);
+static DEVICE_ATTR(temp1_reset_history, 0200, NULL, idt_sysfs_reset_hist);
+
+/*
+ * Hwmon IDT sysfs attributes group
+ */
+static struct attribute *idt_temp_attrs[] = {
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	&sensor_dev_attr_temp1_lowest.dev_attr.attr,
+	&sensor_dev_attr_temp1_highest.dev_attr.attr,
+	&sensor_dev_attr_temp1_offset.dev_attr.attr,
+	&dev_attr_temp1_reset_history.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(idt_temp);
+
+/*
  * idt_temp_isr() - temperature sensor alarm events ISR
  * @ndev:	IDT NTB hardware driver descriptor
  * @ntint_sts:	NT-function interrupt status
@@ -1956,6 +2106,35 @@ static void idt_temp_isr(struct idt_ntb_dev *ndev, u32 ntint_sts)
 		idt_get_deg(mdeg), idt_get_deg_frac(mdeg));
 }
 
+/*
+ * idt_init_temp() - initialize temperature sensor interface
+ * @ndev:	IDT NTB hardware driver descriptor
+ *
+ * Simple sensor initializarion method is responsible for device switching
+ * on and resource management based hwmon interface registration. Note, that
+ * since the device is shared we won't disable it on remove, but leave it
+ * working until the system is powered off.
+ */
+static void idt_init_temp(struct idt_ntb_dev *ndev)
+{
+	struct device *hwmon;
+
+	/* Enable sensor if it hasn't been already */
+	idt_sw_write(ndev, IDT_SW_TMPCTL, 0x0);
+
+	/* Initialize hwmon interface fields */
+	mutex_init(&ndev->hwmon_mtx);
+
+	hwmon = devm_hwmon_device_register_with_groups(&ndev->ntb.pdev->dev,
+		ndev->swcfg->name, ndev, idt_temp_groups);
+	if (IS_ERR(hwmon)) {
+		dev_err(&ndev->ntb.pdev->dev, "Couldn't create hwmon device");
+		return;
+	}
+
+	dev_dbg(&ndev->ntb.pdev->dev, "Temperature HWmon interface registered");
+}
+
 /*=============================================================================
  *                           8. ISRs related operations
  *
@@ -2650,6 +2829,9 @@ static int idt_pci_probe(struct pci_dev *pdev,
 	/* Initialize Messaging subsystem */
 	idt_init_msg(ndev);
 
+	/* Initialize hwmon interface */
+	idt_init_temp(ndev);
+
 	/* Initialize IDT interrupts handler */
 	ret = idt_init_isr(ndev);
 	if (ret != 0)
diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.h b/drivers/ntb/hw/idt/ntb_hw_idt.h
index 9dfd6b11a621..032f81cb4d44 100644
--- a/drivers/ntb/hw/idt/ntb_hw_idt.h
+++ b/drivers/ntb/hw/idt/ntb_hw_idt.h
@@ -47,9 +47,9 @@
 #include <linux/pci_ids.h>
 #include <linux/interrupt.h>
 #include <linux/spinlock.h>
+#include <linux/mutex.h>
 #include <linux/ntb.h>
 
-
 /*
  * Macro is used to create the struct pci_device_id that matches
  * the supported IDT PCIe-switches
@@ -907,6 +907,10 @@
  * TMPSTS register fields related constants
  * @IDT_TMPSTS_TEMP_MASK:	Current temperature field mask
  * @IDT_TMPSTS_TEMP_FLD:	Current temperature field offset
+ * @IDT_TMPSTS_LTEMP_MASK:	Lowest temperature field mask
+ * @IDT_TMPSTS_LTEMP_FLD:	Lowest temperature field offset
+ * @IDT_TMPSTS_HTEMP_MASK:	Highest temperature field mask
+ * @IDT_TMPSTS_HTEMP_FLD:	Highest temperature field offset
  */
 #define IDT_TMPSTS_TEMP_MASK		0x000000FFU
 #define IDT_TMPSTS_TEMP_FLD		0
@@ -916,6 +920,20 @@
 #define IDT_TMPSTS_HTEMP_FLD		16
 
 /*
+ * TMPALARM register fields related constants
+ * @IDT_TMPALARM_LTEMP_MASK:	Lowest temperature field mask
+ * @IDT_TMPALARM_LTEMP_FLD:	Lowest temperature field offset
+ * @IDT_TMPALARM_HTEMP_MASK:	Highest temperature field mask
+ * @IDT_TMPALARM_HTEMP_FLD:	Highest temperature field offset
+ * @IDT_TMPALARM_IRQ_MASK:	Alarm IRQ status mask
+ */
+#define IDT_TMPALARM_LTEMP_MASK		0x0000FF00U
+#define IDT_TMPALARM_LTEMP_FLD		8
+#define IDT_TMPALARM_HTEMP_MASK		0x00FF0000U
+#define IDT_TMPALARM_HTEMP_FLD		16
+#define IDT_TMPALARM_IRQ_MASK		0x3F000000U
+
+/*
  * TMPADJ register fields related constants
  * @IDT_TMPADJ_OFFSET_MASK:	Temperature value offset field mask
  * @IDT_TMPADJ_OFFSET_FLD:	Temperature value offset field offset
@@ -1100,6 +1118,8 @@ struct idt_ntb_peer {
  * @msg_mask_lock:	Message mask register lock
  * @gasa_lock:		GASA registers access lock
  *
+ * @hwmon_mtx:		Temperature sensor interface update mutex
+ *
  * @dbgfs_info:		DebugFS info node
  */
 struct idt_ntb_dev {
@@ -1127,6 +1147,8 @@ struct idt_ntb_dev {
 	spinlock_t msg_mask_lock;
 	spinlock_t gasa_lock;
 
+	struct mutex hwmon_mtx;
+
 	struct dentry *dbgfs_info;
 };
 #define to_ndev_ntb(__ntb) container_of(__ntb, struct idt_ntb_dev, ntb)
-- 
2.12.0

