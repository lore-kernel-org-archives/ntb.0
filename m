Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id 62si4117884pfx.1.2016.06.15.14.54.17
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jun 2016 14:54:17 -0700 (PDT)
References: <cover.1466025130.git.logang@deltatee.com>
 <a37e02139ad94ab322bfac087524a0394ec0383a.1466025130.git.logang@deltatee.com>
 <007901d1c74f$dcdab6c0$96902440$@emc.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <5761CE79.8090703@deltatee.com>
Date: Wed, 15 Jun 2016 15:54:01 -0600
MIME-Version: 1.0
In-Reply-To: <007901d1c74f$dcdab6c0$96902440$@emc.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 09/10] ntb_test: Add a selftest script for the NTB
 subsystem
To: Allen Hubbe <Allen.Hubbe@emc.com>, 'Jon Mason' <jdmason@kudzu.us>, 'Dave Jiang' <dave.jiang@intel.com>
Cc: 'Shuah Khan' <shuahkh@osg.samsung.com>, 'Sudip Mukherjee' <sudipm.mukherjee@gmail.com>, 'Arnd Bergmann' <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, linux-kselftest@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>



On 15/06/16 03:49 PM, Allen Hubbe wrote:
>> +function link_test()
>> +{
>> +	LOC=$1
>> +	REM=$2
>> +	EXP=0
>> +
>> +	echo "Running link tests on: $(basename $LOC) / $(basename $REM)"
>> +
>> +	write_file "N" "$LOC/link"
>> +	write_file "N" "$LOC/link_event"
> 
> If it fails to bring down the link, won't it just block waiting on link_event and never make it to the next step of the test?
> 
>> +	if [[ $(read_file "$REM/link") != "N" ]]; then
>> +		echo "Expected remote link to be down in $REM/link" >&2
>> +		exit -1
>> +	fi
>> +
>> +	write_file "Y" "$LOC/link"
>> +	write_file "Y" "$LOC/link_event"
>> +
>> +	echo "  Passed"
>> +}

Well, the test is really intended to ensure both sides of the link see
changes to the link status. If the driver is somehow buggy and the link
never goes down/up when requested there's little I can do here except
block forever. Unless we want to add a timeout to the link_event file
(which I'd rather not).

You'd have the same issue if, when bringing the link up for the first
time, the link does not come back.

Logan
