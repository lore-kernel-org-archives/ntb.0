Return-Path: <Shyam-sundar.S-k@amd.com>
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (mail-by2nam03on0050.outbound.protection.outlook.com. [104.47.42.50])
        by gmr-mx.google.com with ESMTPS id m13si1670072itb.3.2016.12.01.10.57.31
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Dec 2016 10:57:31 -0800 (PST)
Subject: Re: [PATCH] NTB: Register and offset values fix for memory window
References: <c44465a3-780b-3dbd-22dc-4be241009e3c@amd.com>
 <000001d23e84$5720d3a0$05627ae0$@emc.com>
 <ca26d2ef-f3ab-3713-eacb-cb2d05d61547@amd.com>
 <CAPoiz9xo8TJeLpS6Ft77CHhM=6Yi+ukSek7qfQTxBORnyZDupQ@mail.gmail.com>
 <550c9e3a-c499-ecee-310f-1bd53f381650@amd.com>
 <000001d244cb$7a767880$6f636980$@dell.com>
 <631ba7a7-3c3e-3c7c-d164-b53c52d81753@amd.com>
 <000001d24a5a$2dcbaac0$89630040$@dell.com>
From: Shyam Sundar S K <ssundark@amd.com>
Message-ID: <54771613-1e98-687d-ee72-5772a6f85898@amd.com>
Date: Fri, 2 Dec 2016 00:27:05 +0530
MIME-Version: 1.0
In-Reply-To: <000001d24a5a$2dcbaac0$89630040$@dell.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-Path: ssundark@amd.com
To: Allen Hubbe <Allen.Hubbe@dell.com>, 'Jon Mason' <jdmason@kudzu.us>
Cc: "'Yu, Xiangliang'" <Xiangliang.Yu@amd.com>, 'Dave Jiang' <dave.jiang@intel.com>, linux-ntb@googlegroups.com, "'Sen, Pankaj'" <Pankaj.Sen@amd.com>, "'Shah, Nehal-bakulchandra'" <Nehal-bakulchandra.Shah@amd.com>, "'Agrawal, Nitesh-kumar'" <Nitesh-kumar.Agrawal@amd.com>, "'Subramaniyan, Ramkumar'" <ramkumar.ks@amd.com>, Richard1.Su@amd.com
List-ID: <linux-ntb.googlegroups.com>



On 11/29/2016 9:33 PM, Allen Hubbe wrote:
> From: Shyam Sundar S K
>> On 11/22/2016 7:49 PM, Allen Hubbe wrote:
>>> Instead, limit the number of memory windows actually used by ntb_transport, such that
>> ntb_transport can configure those memory windows using only the available scratchpads.  If
>> there are not enough scratchpads to exchange values for all of the memory windows, then
>> ntb_transport should limit itself to use fewer memory windows.
>>>
>>
>> Allen, I get your point. So, you are asking to limit the number of memory windows we
>> advertise in our driver since there are less number of scratchpads available when we have
>> to configure the 3rd
>> window. I believe you are asking me to do
>>
>> -       ndev->mw_count = AMD_MW_CNT;
>> +       ndev->mw_count = AMD_MW_CNT - 1;
>>
>> in amd_init_ntb(). Is this understanding correct ?
> 
> That would work, but it would limit other transport drivers from using all the memory windows of your device.
>  
> This is the change I meant to describe, in ntb_transport:
> 
> static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
> {
> ...
> 	mw_count = ntb_mw_count(ndev);
> 
> Instead of this:
> 
> 	nt->mw_count = mw_count;
> 
> Limit the mw count like this:
> 
> 	spad_count = ntb_spad_count(ndev);
> 
> 	max_mw_count_for_spads = some_arithmetic(spad_count);
> 
> 	nt->mw_count = min(mw_count, max_mw_count_for_spads);
> 
> 
Ok. Got it. Submitting two separate patches now. One has the change in AMD and another in transport driver.
