Return-Path: <vermasachin09@gmail.com>
MIME-Version: 1.0
From: sachin verma <vermasachin09@gmail.com>
Date: Fri, 6 Dec 2019 21:51:36 +0530
Message-ID: <CA+YOsKJ-ejSNp8htq3+r2kmdW=9Q7UAsb0fLugyX_1VbzmaRfA@mail.gmail.com>
Subject: Flashed Kernel for Pixel2 but changes not appears
Content-Type: multipart/alternative; boundary="00000000000040faea05990b71d8"
To: kasan-dev@googlegroups.com, linux-kbuild@vger.kernel.org, linux-ntb@googlegroups.com, android-building@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

--00000000000040faea05990b71d8
Content-Type: text/plain; charset="UTF-8"

Hi,
I have flashed android10 kernel for Pixel 2 with some changes(additional
logs) but the logs are not appearing in kmsg or dmesg, *Even I have append
the existing log(the logs which are printing on original build) but could
not get modified logs only original's one printing.* It Seems modified code
(modified logs) not flashing in the system.


*Here are the steps I am doing:*

Downloaded AOSP10 and build for aosp_walleye-userdebug
Downloaded the kernel code from *repo branch android-msm-wahoo-4.4-*
*android10-qpr1*.
Compile the kernel by *build/build.sh *from kernel root directory.
Copy the Image.lz4-dtb file generated with build/build.sh to the AOSP
kernel folder of my device i.e /device/google/wahoo-kernel, substituting
the existing one.
run m bootimage to generate boot.img
adb reboot bootloader
fastboot flashall -w to flash the build
Now I can see the kernel build which shows the latest date of kernel build
in device Settings, means kernel flash is successful. But my changes are
not appearing means modified logs are not appearing.


Here are the files I have added/modified the logs
drivers/staging/qca-wifi-host-cmn/wmi/src/wmi_unified_tlv.c
drivers/staging/qcacld-3.0/Kbuild
drivers/staging/qcacld-3.0/core/hdd/src/wlan_hdd_cfg80211.c
drivers/staging/qcacld-3.0/core/hdd/src/wlan_hdd_main.c
drivers/staging/qcacld-3.0/core/wma/src/wma_dev_if.c
drivers/staging/qcacld-3.0/core/wma/src/wma_mgmt.c


*One example of my changes(append msg in existing log):*
-       hdd_info("Disabling queues, adapter device mode:
%s(%d)",hdd_device_mode_to_string(adapter->device_mode),
                 adapter->device_mode);   *---->*
+       hdd_info("*Modified* ...Disabling queues, adapter device mode:
%s(%d)",hdd_device_mode_to_string(adapter->device_mode),
                 adapter->device_mode);
So I am not getting modified versions. while I have checked in kernel
source there's no other place for this log.

Please let me know if any prebuilt binary are there in kernel source for
*staging* module or If I am missing some configuration during compilation.

Thanks,
Sachin

--00000000000040faea05990b71d8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div>I have flashed android10 kernel for Pix=
el 2 with some changes(additional logs) but the logs are not appearing in k=
msg or dmesg, <b>Even I have append the existing log(the logs which are pri=
nting on original build) but could not get modified logs only original&#39;=
s one printing.</b> It Seems modified code (modified logs) not flashing in =
the system.</div><div><b><br></b></div><div><b><br></b></div><div><b>Here a=
re the steps I am doing:</b></div><div><b><br></b></div><div>Downloaded AOS=
P10 and build for aosp_walleye-userdebug</div><div>Downloaded the kernel co=
de from <b>repo branch android-msm-wahoo-4.4-</b><b>android10-qpr1</b>.</di=
v><div>Compile the kernel by <b>build/build.sh </b>from kernel root directo=
ry.<b><br></b></div><div>Copy the Image.lz4-dtb file generated with build/b=
uild.sh to the
AOSP kernel folder of my device i.e /device/google/wahoo-kernel, substituti=
ng the existing one.</div><div>run m bootimage to generate boot.img <br></d=
iv><div>adb reboot bootloader</div><div>fastboot flashall -w to flash the b=
uild</div><div>Now I can see the kernel build which shows the latest date o=
f kernel build in device Settings, means kernel flash is successful. But my=
 changes are not appearing means modified logs are not appearing.</div><div=
><br></div><div><br></div><div>Here are the files I have added/modified the=
 logs</div><div>	drivers/staging/qca-wifi-host-cmn/wmi/src/wmi_unified_tlv.=
c<br>	drivers/staging/qcacld-3.0/Kbuild<br>drivers/staging/qcacld-3.0/core/=
hdd/src/wlan_hdd_cfg80211.c<br>drivers/staging/qcacld-3.0/core/hdd/src/wlan=
_hdd_main.c<br>	drivers/staging/qcacld-3.0/core/wma/src/wma_dev_if.c<br>	dr=
ivers/staging/qcacld-3.0/core/wma/src/wma_mgmt.c</div><div><br></div><div><=
br></div><div><b>One example of my changes(append msg in existing log):</b>=
<br></div><div>- =C2=A0 =C2=A0 =C2=A0 hdd_info(&quot;Disabling queues, adap=
ter device mode: %s(%d)&quot;,hdd_device_mode_to_string(adapter-&gt;device_=
mode),<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ada=
pter-&gt;device_mode);=C2=A0=C2=A0 <b>----&gt;</b><br>+ =C2=A0 =C2=A0 =C2=
=A0 hdd_info(&quot;<b>Modified</b> ...Disabling queues, adapter device mode=
: %s(%d)&quot;,hdd_device_mode_to_string(adapter-&gt;device_mode),<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adapter-&gt;devi=
ce_mode);</div><div>So I am not getting modified versions. while I have che=
cked in kernel source there&#39;s no other place for this log.</div><div><b=
r></div><div>Please let me know if any prebuilt binary are there in kernel =
source for <b>staging</b> module or If I am missing some configuration duri=
ng compilation.</div><div><br></div><div>Thanks,</div><div>Sachin<br></div>=
<div> <br></div><div><br></div><br>=C2=A0<br></div>

--00000000000040faea05990b71d8--
