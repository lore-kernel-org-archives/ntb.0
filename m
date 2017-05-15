Return-Path: <Gary.Hook@amd.com>
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (mail-co1nam03on0054.outbound.protection.outlook.com. [104.47.40.54])
        by gmr-mx.google.com with ESMTPS id r66si1689200pfb.7.2017.05.15.06.48.53
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 May 2017 06:48:53 -0700 (PDT)
Subject: Re: [PATCH V3 2/3] ntb: Remove debug-fs variables from the context
 structure
References: <20170509142856.12995.96207.stgit@taos.amd.com>
 <20170509143328.12995.19706.stgit@taos.amd.com>
 <20170514133206.GA6027@kudzu.us>
From: Gary R Hook <ghook@amd.com>
Message-ID: <d3647128-dd92-086b-405b-b816d5f3a9ed@amd.com>
Date: Mon, 15 May 2017 08:48:44 -0500
MIME-Version: 1.0
In-Reply-To: <20170514133206.GA6027@kudzu.us>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: ghook@amd.com
To: Jon Mason <jdmason@kudzu.us>, Gary R Hook <gary.hook@amd.com>
Cc: linux-ntb@googlegroups.com, Allen.Hubbe@emc.com, dave.jiang@intel.com
List-ID: <linux-ntb.googlegroups.com>

On 05/14/2017 08:32 AM, Jon Mason wrote:
> On Tue, May 09, 2017 at 09:33:28AM -0500, Gary R Hook wrote:
>> The Debug FS entries manage themselves; we don't need to hang onto
>> them in the context structure.
>>
>> Signed-off-by: Gary R Hook <gary.hook@amd.com>
>> ---

<snip>

>> +	debugfs_threads = debugfs_create_u8("threads", S_IRUSR | S_IWUSR,
>> +					    debugfs_node_dir,
>> +					    &perf->perf_threads);
>> +	if (!debugfs_threads)
>>  		return -ENODEV;
>
> I'm going to apply this, since it isn't that different then what
> exists now.  However, I would like to see this have an error path that
> unrolls the creation if one of them fails.

Yes, that would make sense. Will do.


-- 
Man, I love eighth notes.
