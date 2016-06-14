Return-Path: <shuahkh@osg.samsung.com>
Received: from lists.s-osg.org (lists.s-osg.org. [54.187.51.154])
        by gmr-mx.google.com with ESMTP id 62si3151814pfx.1.2016.06.14.07.16.31
        for <linux-ntb@googlegroups.com>;
        Tue, 14 Jun 2016 07:16:31 -0700 (PDT)
Subject: Re: [PATCH 8/8] ntb_test: Add a selftest script for the NTB subsystem
References: <cover.1465598632.git.logang@deltatee.com>
 <773161e84a4447a0a91edb42fe18171819ef2319.1465598632.git.logang@deltatee.com>
 <CAPoiz9wNM4esrdpyyMYgL4p_P-p1ke1tapmzita-5ijnHX--5w@mail.gmail.com>
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <576011B5.1090807@osg.samsung.com>
Date: Tue, 14 Jun 2016 08:16:21 -0600
MIME-Version: 1.0
In-Reply-To: <CAPoiz9wNM4esrdpyyMYgL4p_P-p1ke1tapmzita-5ijnHX--5w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Jon Mason <jdmason@kudzu.us>, Logan Gunthorpe <logang@deltatee.com>
Cc: Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-kernel <linux-kernel@vger.kernel.org>, linux-ntb@googlegroups.com, linux-kselftest@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>
List-ID: <linux-ntb.googlegroups.com>

On 06/14/2016 08:06 AM, Jon Mason wrote:
> On Fri, Jun 10, 2016 at 6:54 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
>> This script automates testing doorbells, scratchpads and memory windows
>> for an NTB device. It can be run locally, with the NTB looped
>> back to the same host or use SSH to remotely control the second host.
>>
>> In the single host case, the script just needs to be passed two
>> arguments: a PCI ID for each side of the link. In the two host case
>> the -r option must be used to specify the remote hostname (which must
>> be SSH accessible and should probably have ssh-keys exchanged).
> 
> I appreciate the work that you are putting in here, but test shell
> scripts are not accepted into the kernel source.

I don't see any reason for this script to be not part of kernel selftests.
I think it will be a good addition. We probably don't want to include it in
the auto run of the selftest suite.

Jon! I you would like to take this script through your ntb tree, here is
my ack for the script for kselftest part.

Acked-by: Shuah Khan <shuahkh@osg.samsung.com>

thanks,
-- Shuah

> 
> I think a better place for this to be shared would be on the github
> account wiki, https://github.com/jonmason/ntb/wiki
> In fact, I'd really like for someone to add some pages there on using
> the ntb tools and testing.  If you are willing, I'd be most
> appreciative.
> 
> Thanks,
> Jon
> 
>>
>> A sample run looks like this:
>>
>> $ sudo ./ntb_test.sh 0000:03:00.1 0000:83:00.1 -p 29
>> Starting ntb_tool tests...
>> Running db tests on: 0000:03:00.1 / 0000:83:00.1
>>   Passed
>> Running db tests on: 0000:83:00.1 / 0000:03:00.1
>>   Passed
>> Running spad tests on: 0000:03:00.1 / 0000:83:00.1
>>   Passed
>> Running spad tests on: 0000:83:00.1 / 0000:03:00.1
>>   Passed
>> Running mw0 tests on: 0000:03:00.1 / 0000:83:00.1
>>   Passed
>> Running mw0 tests on: 0000:83:00.1 / 0000:03:00.1
>>   Passed
>> Running mw1 tests on: 0000:03:00.1 / 0000:83:00.1
>>   Passed
>> Running mw1 tests on: 0000:83:00.1 / 0000:03:00.1
>>   Passed
>>
>> Starting ntb_pingpong tests...
>> Running ping pong tests on: 0000:03:00.1 / 0000:83:00.1
>>   Passed
>>
>> Starting ntb_perf tests...
>> Running local perf test without DMA
>>   0: copied 536870912 bytes in 238205 usecs, 2253 MBytes/s
>>   Passed
>> Running remote perf test without DMA
>>   0: copied 536870912 bytes in 238205 usecs, 2253 MBytes/s
>>   Passed
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> ---
>>  MAINTAINERS                             |   1 +
>>  tools/testing/selftests/ntb/ntb_test.sh | 386 ++++++++++++++++++++++++++++++++
>>  2 files changed, 387 insertions(+)
>>  create mode 100755 tools/testing/selftests/ntb/ntb_test.sh
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 9c567a4..f178e7e 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -7846,6 +7846,7 @@ F:        drivers/ntb/
>>  F:     drivers/net/ntb_netdev.c
>>  F:     include/linux/ntb.h
>>  F:     include/linux/ntb_transport.h
>> +F:     tools/testing/selftests/ntb/
>>
>>  NTB INTEL DRIVER
>>  M:     Jon Mason <jdmason@kudzu.us>
>> diff --git a/tools/testing/selftests/ntb/ntb_test.sh b/tools/testing/selftests/ntb/ntb_test.sh
>> new file mode 100755
>> index 0000000..e4a89e9
>> --- /dev/null
>> +++ b/tools/testing/selftests/ntb/ntb_test.sh
>> @@ -0,0 +1,386 @@
>> +#!/bin/bash
>> +# Copyright (c) 2016 Microsemi. All Rights Reserved.
>> +#
>> +# This program is free software; you can redistribute it and/or
>> +# modify it under the terms of the GNU General Public License as
>> +# published by the Free Software Foundation; either version 2 of
>> +# the License, or (at your option) any later version.
>> +#
>> +# This program is distributed in the hope that it would be useful,
>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> +# GNU General Public License for more details.
>> +#
>> +# Author: Logan Gunthorpe <logang@deltatee.com>
>> +
>> +REMOTE_HOST=
>> +LIST_DEVS=FALSE
>> +
>> +DEBUGFS=${DEBUGFS-/sys/kernel/debug}
>> +
>> +PERF_RUN_ORDER=32
>> +MAX_MW_SIZE=0
>> +RUN_DMA_TESTS=
>> +DONT_CLEANUP=
>> +
>> +function show_help()
>> +{
>> +       echo "Usage: $0 [OPTIONS] LOCAL_DEV REMOTE_DEV"
>> +       echo "Run tests on a pair of NTB endpoints."
>> +       echo
>> +       echo "If the NTB device loops back to the same host then,"
>> +       echo "just specifying the two PCI ids on the command line is"
>> +       echo "sufficient. Otherwise, if the NTB link spans two hosts"
>> +       echo "use the -r option to specify the hostname for the remote"
>> +       echo "device. SSH will then be used to test the remote side."
>> +       echo "An SSH key between the root users of the host would then"
>> +       echo "be highly recommended."
>> +       echo
>> +       echo "Options:"
>> +       echo "  -C              don't cleanup ntb modules on exit"
>> +       echo "  -d              run dma tests"
>> +       echo "  -h              show this help message"
>> +       echo "  -l              list available local and remote PCI ids"
>> +       echo "  -r REMOTE_HOST  specify the remote's hostname to connect"
>> +        echo "                  to for the test (using ssh)"
>> +       echo "  -p NUM          ntb_perf run order (default: $PERF_RUN_ORDER)"
>> +       echo "  -w max_mw_size  maxmium memory window size"
>> +       echo
>> +}
>> +
>> +function parse_args()
>> +{
>> +       OPTIND=0
>> +       while getopts "Cdhlr:p:w:" opt; do
>> +               case "$opt" in
>> +               C)  DONT_CLEANUP=1 ;;
>> +               d)  RUN_DMA_TESTS=1 ;;
>> +               h)  show_help; exit 0 ;;
>> +               l)  LIST_DEVS=TRUE ;;
>> +               r)  REMOTE_HOST=${OPTARG} ;;
>> +               p)  PERF_RUN_ORDER=${OPTARG} ;;
>> +               w)  MAX_MW_SIZE=${OPTARG} ;;
>> +               \?)
>> +                   echo "Invalid option: -$OPTARG" >&2
>> +                   exit 1
>> +                   ;;
>> +               esac
>> +       done
>> +}
>> +
>> +parse_args "$@"
>> +shift $((OPTIND-1))
>> +LOCAL_DEV=$1
>> +shift
>> +parse_args "$@"
>> +shift $((OPTIND-1))
>> +REMOTE_DEV=$1
>> +shift
>> +parse_args "$@"
>> +
>> +set -e
>> +
>> +function _modprobe()
>> +{
>> +        modprobe "$@"
>> +}
>> +
>> +function split_remote()
>> +{
>> +       VPATH=$1
>> +       REMOTE=
>> +
>> +       if [[ "$VPATH" == *":/"* ]]; then
>> +               REMOTE=${VPATH%%:*}
>> +               VPATH=${VPATH#*:}
>> +       fi
>> +}
>> +
>> +function read_file()
>> +{
>> +       split_remote $1
>> +       if [[ "$REMOTE" != "" ]]; then
>> +               ssh "$REMOTE" cat "$VPATH"
>> +       else
>> +               cat "$VPATH"
>> +       fi
>> +}
>> +
>> +function write_file()
>> +{
>> +       split_remote $2
>> +       VALUE=$1
>> +
>> +       if [[ "$REMOTE" != "" ]]; then
>> +               ssh "$REMOTE" "echo \"$VALUE\" > \"$VPATH\""
>> +       else
>> +               echo "$VALUE" > "$VPATH"
>> +       fi
>> +}
>> +
>> +function doorbell_test()
>> +{
>> +       LOC=$1
>> +       REM=$2
>> +       EXP=0
>> +
>> +       echo "Running db tests on: $(basename $LOC) / $(basename $REM)"
>> +
>> +       write_file "c 0xFFFFFFFF" "$REM/db"
>> +
>> +       for ((i=1; i <= 8; i++)); do
>> +               let DB=$(read_file "$REM/db") || true
>> +               if [[ "$DB" != "$EXP" ]]; then
>> +                       echo "Doorbell doesn't match expected value $EXP " \
>> +                            "in $REM/db" >&2
>> +                       exit -1
>> +               fi
>> +
>> +               let "MASK=1 << ($i-1)" || true
>> +               let "EXP=$EXP | $MASK" || true
>> +               write_file "s $MASK" "$LOC/peer_db"
>> +       done
>> +
>> +       echo "  Passed"
>> +}
>> +
>> +function read_spad()
>> +{
>> +       VPATH=$1
>> +       IDX=$2
>> +
>> +       ROW=($(read_file "$VPATH" | grep -e "^$IDX"))
>> +       let VAL=${ROW[1]} || true
>> +       echo $VAL
>> +}
>> +
>> +function scratchpad_test()
>> +{
>> +       LOC=$1
>> +       REM=$2
>> +       CNT=$(read_file "$LOC/spad" | wc -l)
>> +
>> +       echo "Running spad tests on: $(basename $LOC) / $(basename $REM)"
>> +
>> +       for ((i = 0; i < $CNT; i++)); do
>> +               VAL=$RANDOM
>> +               write_file "$i $VAL" "$LOC/peer_spad"
>> +               RVAL=$(read_spad "$REM/spad" $i)
>> +
>> +               if [[ "$VAL" != "$RVAL" ]]; then
>> +                       echo "Scratchpad doesn't match expected value $VAL " \
>> +                            "in $REM/spad, got $RVAL" >&2
>> +                       exit -1
>> +               fi
>> +
>> +       done
>> +
>> +       echo "  Passed"
>> +}
>> +
>> +function write_mw()
>> +{
>> +       split_remote $2
>> +
>> +       if [[ "$REMOTE" != "" ]]; then
>> +               ssh "$REMOTE" \
>> +                       dd if=/dev/urandom "of=$VPATH" 2> /dev/null || true
>> +       else
>> +               dd if=/dev/urandom "of=$VPATH" 2> /dev/null || true
>> +       fi
>> +}
>> +
>> +function mw_test()
>> +{
>> +       IDX=$1
>> +       LOC=$2
>> +       REM=$3
>> +
>> +       echo "Running $IDX tests on: $(basename $LOC) / $(basename $REM)"
>> +
>> +       write_mw "$LOC/$IDX"
>> +
>> +       split_remote "$LOC/$IDX"
>> +       if [[ "$REMOTE" == "" ]]; then
>> +               A=$VPATH
>> +       else
>> +               A=/tmp/ntb_test.$$.A
>> +               ssh "$REMOTE" cat "$VPATH" > "$A"
>> +       fi
>> +
>> +       split_remote "$REM/peer_$IDX"
>> +       if [[ "$REMOTE" == "" ]]; then
>> +               B=$VPATH
>> +       else
>> +               B=/tmp/ntb_test.$$.B
>> +               ssh "$REMOTE" cat "$VPATH" > "$B"
>> +       fi
>> +
>> +       cmp "$A" "$B"
>> +       if [[ $? != 0 ]]; then
>> +               echo "Memory window $MW did not match!" >&2
>> +       fi
>> +
>> +       if [[ "$A" == "/tmp/*" ]]; then
>> +               rm "$A"
>> +       fi
>> +
>> +       if [[ "$B" == "/tmp/*" ]]; then
>> +               rm "$B"
>> +       fi
>> +
>> +       echo "  Passed"
>> +}
>> +
>> +function pingpong_test()
>> +{
>> +       LOC=$1
>> +       REM=$2
>> +
>> +       echo "Running ping pong tests on: $(basename $LOC) / $(basename $REM)"
>> +
>> +       LOC_START=$(read_file $LOC/count)
>> +       REM_START=$(read_file $REM/count)
>> +
>> +       sleep 7
>> +
>> +       LOC_END=$(read_file $LOC/count)
>> +       REM_END=$(read_file $REM/count)
>> +
>> +       if [[ $LOC_START == $LOC_END ]] || [[ $REM_START == $REM_END ]]; then
>> +               echo "Ping pong counter not incrementing!" >&2
>> +               exit 1
>> +       fi
>> +
>> +       echo "  Passed"
>> +}
>> +
>> +function perf_test()
>> +{
>> +       USE_DMA=$1
>> +
>> +       if [[ $USE_DMA == "1" ]]; then
>> +               WITH="with"
>> +       else
>> +               WITH="without"
>> +       fi
>> +
>> +       _modprobe ntb_perf run_order=$PERF_RUN_ORDER \
>> +               max_mw_size=$MAX_MW_SIZE use_dma=$USE_DMA
>> +
>> +       echo "Running local perf test $WITH DMA"
>> +       write_file "" $LOCAL_PERF/run
>> +       echo -n "  "
>> +       read_file $LOCAL_PERF/run
>> +       echo "  Passed"
>> +
>> +       echo "Running remote perf test $WITH DMA"
>> +       write_file "" $REMOTE_PERF/run
>> +       echo -n "  "
>> +       read_file $LOCAL_PERF/run
>> +       echo "  Passed"
>> +
>> +       _modprobe -r ntb_perf
>> +}
>> +
>> +function ntb_tool_tests()
>> +{
>> +       LOCAL_TOOL=$DEBUGFS/ntb_tool/$LOCAL_DEV
>> +       REMOTE_TOOL=$REMOTE_HOST:$DEBUGFS/ntb_tool/$REMOTE_DEV
>> +
>> +       echo "Starting ntb_tool tests..."
>> +
>> +       _modprobe ntb_tool
>> +
>> +       echo > $LOCAL_TOOL/link
>> +
>> +       doorbell_test $LOCAL_TOOL $REMOTE_TOOL
>> +       doorbell_test $REMOTE_TOOL $LOCAL_TOOL
>> +       scratchpad_test $LOCAL_TOOL $REMOTE_TOOL
>> +       scratchpad_test $REMOTE_TOOL $LOCAL_TOOL
>> +
>> +       for MW in $(ls $LOCAL_TOOL/mw*); do
>> +               MW=$(basename $MW)
>> +               mw_test $MW $LOCAL_TOOL $REMOTE_TOOL
>> +               mw_test $MW $REMOTE_TOOL $LOCAL_TOOL
>> +       done
>> +
>> +       _modprobe -r ntb_tool
>> +}
>> +
>> +function ntb_pingpong_tests()
>> +{
>> +       LOCAL_PP=$DEBUGFS/ntb_pingpong/$LOCAL_DEV
>> +       REMOTE_PP=$REMOTE_HOST:$DEBUGFS/ntb_pingpong/$REMOTE_DEV
>> +
>> +       echo "Starting ntb_pingpong tests..."
>> +
>> +       _modprobe ntb_pingpong
>> +
>> +       pingpong_test $LOCAL_PP $REMOTE_PP
>> +
>> +       _modprobe -r ntb_pingpong
>> +}
>> +
>> +function ntb_perf_tests()
>> +{
>> +       LOCAL_PERF=$DEBUGFS/ntb_perf/$LOCAL_DEV
>> +       REMOTE_PERF=$REMOTE_HOST:$DEBUGFS/ntb_perf/$REMOTE_DEV
>> +
>> +       echo "Starting ntb_perf tests..."
>> +
>> +       perf_test 0
>> +
>> +       if [[ $RUN_DMA_TESTS ]]; then
>> +               perf_test 1
>> +       fi
>> +}
>> +
>> +function cleanup()
>> +{
>> +       set +e
>> +       _modprobe -r ntb_tool 2> /dev/null
>> +       _modprobe -r ntb_perf 2> /dev/null
>> +       _modprobe -r ntb_pingpong 2> /dev/null
>> +       _modprobe -r ntb_transport 2> /dev/null
>> +       set -e
>> +}
>> +
>> +cleanup
>> +
>> +if ! [[ $$DONT_CLEANUP ]]; then
>> +       trap cleanup EXIT
>> +fi
>> +
>> +if [ "$(id -u)" != "0" ]; then
>> +       echo "This script must be run as root" 1>&2
>> +       exit 1
>> +fi
>> +
>> +if [[ "$LIST_DEVS" == TRUE ]]; then
>> +       _modprobe ntb_tool
>> +       echo "Local Devices:"
>> +       ls -1 /sys/kernel/debug/ntb_tool
>> +       echo
>> +
>> +       if [[ "$REMOTE_HOST" != "" ]]; then
>> +               echo "Remote Devices:"
>> +               ssh $REMOTE_HOST ls -1 /sys/kernel/debug/ntb_tool
>> +       fi
>> +
>> +       _modprobe -r ntb_tool
>> +
>> +       exit 0
>> +fi
>> +
>> +if [[ "$LOCAL_DEV" == $"" ]] || [[ "$REMOTE_DEV" == $"" ]]; then
>> +       show_help
>> +       exit 1
>> +fi
>> +
>> +ntb_tool_tests
>> +echo
>> +ntb_pingpong_tests
>> +echo
>> +ntb_perf_tests
>> +echo
>> --
>> 2.1.4
>>

