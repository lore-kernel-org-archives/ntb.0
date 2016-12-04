Return-Path: <Allen.Hubbe@dell.com>
Received: from esa4.dell-outbound.iphmx.com (esa4.dell-outbound.iphmx.com. [68.232.149.214])
        by gmr-mx.google.com with ESMTPS id x138si784163ywx.6.2016.12.03.16.07.33
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Dec 2016 16:07:33 -0800 (PST)
From: "Allen Hubbe" <Allen.Hubbe@dell.com>
Subject: RE: [PATCH 08/22] NTB: Add T-Platforms copyrights to NTB API
Date: Sat, 3 Dec 2016 19:07:13 -0500
Message-ID: <004301d24dc2$5e03d7b0$1a0b8710$@dell.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
To: 'Serge Semin' <fancer.lancer@gmail.com>, jdmason@kudzu.us, dave.jiang@intel.com, Xiangliang.Yu@amd.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

> From: Serge Semin
> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

This patch has no comment, but instead...

This can be squashed with your first commit of significant changes to each file.

> 
> ---
>  drivers/ntb/ntb.c   | 2 ++
>  include/linux/ntb.h | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/ntb/ntb.c b/drivers/ntb/ntb.c
> index 4b2cc60..06574f8 100644
> --- a/drivers/ntb/ntb.c
> +++ b/drivers/ntb/ntb.c
> @@ -5,6 +5,7 @@
>   *   GPL LICENSE SUMMARY
>   *
>   *   Copyright (C) 2015 EMC Corporation. All Rights Reserved.
> + *   Copyright (C) 2016 T-Platforms. All Rights Reserved.
>   *
>   *   This program is free software; you can redistribute it and/or modify
>   *   it under the terms of version 2 of the GNU General Public License as
> @@ -18,6 +19,7 @@
>   *   BSD LICENSE
>   *
>   *   Copyright (C) 2015 EMC Corporation. All Rights Reserved.
> + *   Copyright (C) 2016 T-Platforms. All Rights Reserved.
>   *
>   *   Redistribution and use in source and binary forms, with or without
>   *   modification, are permitted provided that the following conditions
> diff --git a/include/linux/ntb.h b/include/linux/ntb.h
> index 8b19327..9edd9dc 100644
> --- a/include/linux/ntb.h
> +++ b/include/linux/ntb.h
> @@ -5,6 +5,7 @@
>   *   GPL LICENSE SUMMARY
>   *
>   *   Copyright (C) 2015 EMC Corporation. All Rights Reserved.
> + *   Copyright (C) 2016 T-Platforms. All Rights Reserved.
>   *
>   *   This program is free software; you can redistribute it and/or modify
>   *   it under the terms of version 2 of the GNU General Public License as
> @@ -18,6 +19,7 @@
>   *   BSD LICENSE
>   *
>   *   Copyright (C) 2015 EMC Corporation. All Rights Reserved.
> + *   Copyright (C) 2016 T-Platforms. All Rights Reserved.
>   *
>   *   Redistribution and use in source and binary forms, with or without
>   *   modification, are permitted provided that the following conditions
> --
> 2.6.6


