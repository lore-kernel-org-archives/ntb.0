Return-Path: <dave.jiang@intel.com>
Received: from mga01.intel.com (mga01.intel.com. [192.55.52.88])
        by gmr-mx.google.com with ESMTPS id 63si113554pfp.3.2017.05.09.11.03.45
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 May 2017 11:03:45 -0700 (PDT)
Subject: Re: [PATCH V3 0/3] Add/expose control features for the NTB perf test
 module
References: <20170509142856.12995.96207.stgit@taos.amd.com>
From: Dave Jiang <dave.jiang@intel.com>
Message-ID: <f45ed707-fcc9-5ff6-2bbb-eb21d098769d@intel.com>
Date: Tue, 9 May 2017 11:02:33 -0700
MIME-Version: 1.0
In-Reply-To: <20170509142856.12995.96207.stgit@taos.amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Gary R Hook <gary.hook@amd.com>, linux-ntb@googlegroups.com
Cc: Allen.Hubbe@emc.com, jdmason@kudzu.us
List-ID: <linux-ntb.googlegroups.com>



On 05/09/2017 07:33 AM, Gary R Hook wrote:
> The goal of this series is to add and expose some control mechanisms for the
> performance test module:
> 
>  - Provide a switch to allow memory and threads to be anywhere, as
>    opposed to only the NTB node.
>  - The debug filesystem entries do not need to be retained after they
>    are set up. Remove the variables from the context structure and make
>    them automatic,
>  - Create a debug-fs entry for every module parameter. This allows test
>    parameters to be changed, and additional tests to be run, without
>    unloading the ntb_perf module each time.
> 
> Changes since V2:
>  - Use on_node to decide if -anything- is required to be on the NTB node.
> 
> Changes since V1:
>  - Split patch into appropriate pieces.
> 
> ---
> 
> Gary R Hook (3):
>       ntb: Add a module option to control affinity of DMA channels
>       ntb: Remove debug-fs variables from the context structure
>       ntb: Add more debugfs support for ntb_perf testing options
> 
> 
>  drivers/ntb/test/ntb_perf.c |   72 ++++++++++++++++++++++++++++++++-----------
>  1 file changed, 54 insertions(+), 18 deletions(-)
> 

ack the series

Acked-by: Dave Jiang <dave.jiang@intel.com>
