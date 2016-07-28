Return-Path: <Allen.Hubbe@emc.com>
Received: from esa6.dell-outbound.iphmx.com (esa6.dell-outbound.iphmx.com. [68.232.149.229])
        by gmr-mx.google.com with ESMTPS id m82si95190ywm.2.2016.07.28.07.42.55
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jul 2016 07:42:55 -0700 (PDT)
From: "Allen Hubbe" <Allen.Hubbe@emc.com>
Subject: RE: [PATCH v2 0/3] ntb: Asynchronous NTB devices support
Date: Thu, 28 Jul 2016 10:42:30 -0400
Message-ID: <000001d1e8de$463b4c10$d2b1e430$@emc.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
To: 'Serge Semin' <fancer.lancer@gmail.com>, jdmason@kudzu.us
Cc: dave.jiang@intel.com, Xiangliang.Yu@amd.com, Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

From: Serge Semin
> Please, find the general patchset description in the cover letter of the first
> patchset (see the very first message in thread).
> 
> Changes in v2:
>  - Fix sparc64 compilation warning in drivers/ntb/hw/idt/ntb_hw_idt.c :
>    warning: right shift count >= width of type
>  - Fix sparc64 compilation warnings in drivers/ntb/test/ntb_mw_test.c :
>    warning: right shift count >= width of type
>    warning: cast to pointer from integer of different size

Thanks for reacting to the test robot so quickly.  Since nobody else has responded yet, I would like to assure you that the patches are not being ignored.  Please be patient.  The IDT driver will be a valuable contribution to the ntb subsystem.  I am working carefully through patch 1/3 first, since it affects existing drivers and interface.

A word of caution regarding your statement, "There are a some types of checkpatch warnings I left unfixed."  Coding style can be a touchy subject, leading to some recent rants^H^H^H^H^Hdiscussion on some of the same topics that are included in that list of unfixed warnings.  Be prepared to adhere to the style guide, even if it is inconvenient and against your own logic, because that is almost always the easier and more practical approach than asking for changes or exceptions, and better for your mental health not to be on the To: list of something like https://lkml.org/lkml/2016/7/8/625.

"Of course all of these warnings are discussable, except the last one."  Be prepared, even if it will require significant changes to the code.  For really inconvenient changes, we can talk about other more readily acceptable approaches to keep the code short and elegant, as is obviously your intent.  Please be patient with the review.

