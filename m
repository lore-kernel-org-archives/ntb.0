Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwhop.emc.com (mailuogwhop.emc.com. [168.159.213.141])
        by gmr-mx.google.com with ESMTPS id f4si493960wmg.0.2016.06.15.15.18.05
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jun 2016 15:18:06 -0700 (PDT)
From: "Allen Hubbe" <Allen.Hubbe@emc.com>
References: <cover.1466025130.git.logang@deltatee.com> <a37e02139ad94ab322bfac087524a0394ec0383a.1466025130.git.logang@deltatee.com> <007901d1c74f$dcdab6c0$96902440$@emc.com> <5761CE79.8090703@deltatee.com>
In-Reply-To: <5761CE79.8090703@deltatee.com>
Subject: RE: [PATCH v3 09/10] ntb_test: Add a selftest script for the NTB subsystem
Date: Wed, 15 Jun 2016 18:17:36 -0400
Message-ID: <007b01d1c753$b9b6e840$2d24b8c0$@emc.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
To: 'Logan Gunthorpe' <logang@deltatee.com>, 'Jon Mason' <jdmason@kudzu.us>, 'Dave Jiang' <dave.jiang@intel.com>
Cc: 'Shuah Khan' <shuahkh@osg.samsung.com>, 'Sudip Mukherjee' <sudipm.mukherjee@gmail.com>, 'Arnd Bergmann' <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, linux-kselftest@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

From: Logan Gunthorpe
> On 15/06/16 03:49 PM, Allen Hubbe wrote:
> >> +function link_test()
> >> +{
> >> +	LOC=$1
> >> +	REM=$2
> >> +	EXP=0
> >> +
> >> +	echo "Running link tests on: $(basename $LOC) / $(basename $REM)"
> >> +
> >> +	write_file "N" "$LOC/link"
> >> +	write_file "N" "$LOC/link_event"
> >
> > If it fails to bring down the link, won't it just block waiting on link_event and never
> make it to the next step of the test?
> >
> >> +	if [[ $(read_file "$REM/link") != "N" ]]; then
> >> +		echo "Expected remote link to be down in $REM/link" >&2
> >> +		exit -1
> >> +	fi
> >> +
> >> +	write_file "Y" "$LOC/link"
> >> +	write_file "Y" "$LOC/link_event"
> >> +
> >> +	echo "  Passed"
> >> +}
> 
> Well, the test is really intended to ensure both sides of the link see
> changes to the link status. If the driver is somehow buggy and the link
> never goes down/up when requested there's little I can do here except
> block forever. Unless we want to add a timeout to the link_event file
> (which I'd rather not).
> 
> You'd have the same issue if, when bringing the link up for the first
> time, the link does not come back.

The link might come up, but this test checks if the link can be forced down.

This test should fail on Intel RP/TB topology (two cpu sharing one ntb).  The link state is the link state of the secondary side pcie bus connected to the secondary side cpu.  The link must be up in order for the secondary side cpu to discover the ntb device, so the driver does not allow the link to be disabled in such topology.

A simple thing to do here might be:

write_file "N" "$LOC/link"
sleep 1
read_file "$REM/link"

You already have my Ack.  This minor issue can be fixed later if anyone cares.  I don't think it is a big deal, just worth pointing out that the script will hang here instead of report a failure.  If it is worth fixing later, at that point we might also want to change this script to continue with other tests instead of exit on the first failure.

