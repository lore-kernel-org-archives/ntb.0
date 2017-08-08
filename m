Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id y126si73547itc.1.2017.08.08.11.26.25
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Aug 2017 11:26:26 -0700 (PDT)
References: <20170808101147.24625-1-fancer.lancer@gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <d1121616-a2f1-7d36-fdee-3076cb6e7db4@deltatee.com>
Date: Tue, 8 Aug 2017 12:26:23 -0600
MIME-Version: 1.0
In-Reply-To: <20170808101147.24625-1-fancer.lancer@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] NTB: ntb_tool: Add full multi-port NTB API support
To: Serge Semin <fancer.lancer@gmail.com>, jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, Shyam-sundar.S-k@amd.com, Xiangliang.Yu@amd.com, gary.hook@amd.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>



On 08/08/17 04:11 AM, Serge Semin wrote:
> +static ssize_t tool_db_event_write(struct file *filep,
> +				   const char __user *ubuf,
> +				   size_t size, loff_t *offp)
> +{
> +	struct tool_ctx *tc = filep->private_data;
> +	u64 val;
> +	int ret;
> +
> +	ret = kstrtou64_from_user(ubuf, size, 0, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (wait_event_interruptible(tc->db_wq, ntb_db_read(tc->ntb) == val))
> +		return -ERESTART;
> +
> +	return size;
> +}

Also, I like the fact that we are adding a db_event feature, however
this really needs to be a separate commit as it's a completely different
feature and not even mentioned in the commit message. There's a few of
these instances.

Logan
