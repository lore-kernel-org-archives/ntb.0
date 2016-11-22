Return-Path: <Shyam-sundar.S-k@amd.com>
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (mail-sn1nam01on0056.outbound.protection.outlook.com. [104.47.32.56])
        by gmr-mx.google.com with ESMTPS id 197si352305ita.0.2016.11.22.07.12.45
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Nov 2016 07:12:45 -0800 (PST)
Subject: Re: [PATCH] NTB: Register and offset values fix for memory window
References: <c44465a3-780b-3dbd-22dc-4be241009e3c@amd.com>
 <000001d23e84$5720d3a0$05627ae0$@emc.com>
 <ca26d2ef-f3ab-3713-eacb-cb2d05d61547@amd.com>
 <CAPoiz9xo8TJeLpS6Ft77CHhM=6Yi+ukSek7qfQTxBORnyZDupQ@mail.gmail.com>
 <550c9e3a-c499-ecee-310f-1bd53f381650@amd.com>
 <000001d244cb$7a767880$6f636980$@dell.com>
From: Shyam Sundar S K <ssundark@amd.com>
Message-ID: <dcf226a1-22a4-3a78-f959-264f92bf5412@amd.com>
Date: Tue, 22 Nov 2016 20:42:11 +0530
MIME-Version: 1.0
In-Reply-To: <000001d244cb$7a767880$6f636980$@dell.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-Path: ssundark@amd.com
To: Allen Hubbe <Allen.Hubbe@dell.com>, 'Jon Mason' <jdmason@kudzu.us>
Cc: "'Yu, Xiangliang'" <Xiangliang.Yu@amd.com>, 'Dave Jiang' <dave.jiang@intel.com>, linux-ntb@googlegroups.com, "'Sen, Pankaj'" <Pankaj.Sen@amd.com>, "'Shah, Nehal-bakulchandra'" <Nehal-bakulchandra.Shah@amd.com>, "'Agrawal, Nitesh-kumar'" <Nitesh-kumar.Agrawal@amd.com>, "'Subramaniyan, Ramkumar'" <ramkumar.ks@amd.com>, Richard1.Su@amd.com
List-ID: <linux-ntb.googlegroups.com>



On 11/22/2016 7:49 PM, Allen Hubbe wrote:
> From: Shyam Sundar S K
>> On 11/17/2016 9:09 PM, Jon Mason wrote:
>>> On Tue, Nov 15, 2016 at 2:04 AM, Shyam Sundar S K <ssundark@amd.com> wrote:
>>>> On 11/14/2016 8:05 PM, Allen Hubbe wrote:
>>>>> From: Shyam Sundar S K
>>>>>> Due to incorrect limit and translation register values, NTB link was
>>>>>> going down when the memory window translation was setup. Made appropriate
>>>>>> changes as per spec.
>>>>>>
>>>>>> Also, fixed the limit register values for BAR1, which was overlapping
>>>>>> with the BAR23 address.
>>>>>>
>>>>>> Reviewed-by: Sen, Pankaj <Pankaj.Sen@amd.com>
>>>>>> Reviewed-by: Shah, Nehal-bakulchandra <Nehal-bakulchandra.Shah@amd.com>
>>>>>> Acked-by: Xiangliang Yu <Xiangliang.Yu@amd.com>
>>>>>> Signed-off-by: S-k, Shyam-sundar <Shyam-sundar.S-k@amd.com>
>>>>>> ---
>>>>>
>>>>>> @@ -376,13 +371,11 @@ static u32 amd_ntb_spad_read(struct ntb_dev *ntb, int idx)
>>>>>>  {
>>>>>>      struct amd_ntb_dev *ndev = ntb_ndev(ntb);
>>>>>>      void __iomem *mmio = ndev->self_mmio;
>>>>>> -    u32 offset;
>>>>>>
>>>>>> -    if (idx < 0 || idx >= ndev->spad_count)
>>>>>> +    if (idx < 0 || idx >= (ndev->spad_count + 4))
>>>>>
>>>>> Why does this change add four to the upper end of the range check?  Does spad_count
>> have the wrong number of spads?
>>>>>
>>>>>>              return 0;
>>>>>>
>>>>>> -    offset = ndev->self_spad + (idx << 2);
>>>>>> -    return readl(mmio + AMD_SPAD_OFFSET + offset);
>>>>>> +    return readl(mmio + AMD_SPAD_OFFSET + (idx << 2));
>>>>>
>>>>> The self_spad is used for sharing the spads of a single ntb.  It is the offset of the
>> first or second half of the spads, and the peer self_spad is the other half.  From this
>> change, can we assume that a single-ntb topology will not be supported?
>>>>>
>>>> This patch has more to with the NTB driver becoming functional on AMD platforms.
>>>> We were reading from the incorrect offsets than the one mentioned in the AMD NTB HW
>> spec. So changed it accordingly.
>>>
>>> I believe the point Alan was making was that if the SPAD count is +4,
>>> then perhaps the value in spad_count should be +4.  Are there 16 or 20
>>> SPADs?
>>>
>>
>> There are 16 SPAD in our case, if I don't add that hack here eth link does not become
>> ready.
>>
>> meaning, in ntb_transport: this never gets set "nt->link_is_up = true;" reason being
>> ntb_spad_read(ndev, MW0_SZ_HIGH + (i * 2)); and ntb_spad_read(ndev, MW0_SZ_LOW + (i * 2));
>> so, calls to ntb_spad_read() will have idx more than the ndev->spad_count.
>>
> 
> In MW0_SZ_LOW + (i * 2), 'i' is in the range of the number of memory windows, which is greater on AMD.  The ntb_transport driver as currently written will require more scratchpads for initialization on AMD, because the AMD driver advertises more memory windows.
> 
> The changes here in ntb_hw_amd are incorrect, because they do allow read and write access out of bounds of the hardware scratchpad registers.  This only appears to work, because ntb_netdev only creates one queue in ntb_transport.  Because ntb_netdev only creates one queue, we don't observe any trouble with the misconfigured third memory window, which is configured with bogus values from non-scratchpad hardware registers.  If a driver allocated a third queue, I expect there would be trouble.
> 
>> Any suggestions ?
>>
> 
> Instead, limit the number of memory windows actually used by ntb_transport, such that ntb_transport can configure those memory windows using only the available scratchpads.  

Thank you for your valuable inputs. Can you please elaborate more on this point ? How to limit memory windows in ntb_transport ? We have 16 scratchpad, 8 shared across each NTB's and 3 memory windows.

If there are not enough scratchpads to exchange values for all of the memory windows, then ntb_transport should limit itself to use fewer memory windows.
> 
