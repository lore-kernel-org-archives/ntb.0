Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id f15si412437plr.1.2017.11.30.14.37.16
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Nov 2017 14:37:16 -0800 (PST)
References: <20171130214300.21298-1-fancer.lancer@gmail.com>
 <20171130214300.21298-2-fancer.lancer@gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <5f9198e4-24d4-88f5-89d2-d36c5afa76ef@deltatee.com>
Date: Thu, 30 Nov 2017 15:37:13 -0700
MIME-Version: 1.0
In-Reply-To: <20171130214300.21298-2-fancer.lancer@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 02/08] NTB: ntb_test: Add ntb_tool port tests
To: Serge Semin <fancer.lancer@gmail.com>, jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, Shyam-sundar.S-k@amd.com, Xiangliang.Yu@amd.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>


On 30/11/17 02:42 PM, Serge Semin wrote:
> +function find_pidx()
> +{
> +	PORT=$1
> +	PPATH=$2
> +
> +	for ((i = 0; i < 64; i++)); do
> +		PEER_DIR="$PPATH/peer$i"
> +
> +		check_file ${PEER_DIR} || break
> +
> +		PEER_PORT=$(read_file "${PEER_DIR}/port")
> +		if [[ ${PORT} -eq $PEER_PORT ]]; then
> +			echo $i
> +			return 0
> +		fi
> +	done
> +
> +	return 1
> +}

Actually, per my earlier comments on other messages. I think it would be 
best if each of the patches in this series also included the relevant 
changes to ntb_tool. Then just ditch the ntb_tool patch. For example, 
this patch would include adding the "port" file to ntb_tool and the 
relevant test to ntb_test.

Otherwise, when the ntb_tool patch is committed, the ntb_test breaks and 
then is fixed in subsequent patches. In an ideal world, this would be 
avoided in case we ever want to do a bisect involving ntb_test.

Logan
