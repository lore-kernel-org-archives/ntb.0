Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDD57F
	for <ntb@lists.linux.dev>; Tue,  2 Aug 2022 21:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659474116; x=1691010116;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=D4kvEWMRMvyP6HvFfJKxNdfexfG2+NLXCpspNAaUioM=;
  b=X8J4EAtfur+8wjLNz/698ZN5gGMxUzZZZL7VxHx1eFLVJc/bi2uZUttI
   ToOaxJQVClepwXoaZQrWRRVuUqgPKZrBRu7VtIccSAtqIIeg1VGXs5yGr
   qxWSQo+B0aPFlp1XdNaNReH/T320noiOLRxi6z9W577hWnWWs0Y+8/coY
   4w5YDTb+OIEKGc9gOEoNxiCGwFy7puLLG0hbElAPufUyivYyehao4Enc6
   lrtIttRh5ShXGBMkT+SksFa9/KWBXspvOEoStpwGFhtkxvdoMV1Lzbngv
   lwnVu1/Sb4NotEu01x3NCQA/Rt/hNTiwHApW6r58QcJXIxGBUQzARtvhO
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="290734136"
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="290734136"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 14:01:56 -0700
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="728970603"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.30.74]) ([10.212.30.74])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 14:01:56 -0700
Message-ID: <781b9161-a6cc-a8cc-af20-a4eebcdbca6e@intel.com>
Date: Tue, 2 Aug 2022 14:01:55 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v2] ntb: intel: add GNR support for Intel PCIe gen5 NTB
Content-Language: en-US
To: Allen Hubbe <allenbh@gmail.com>
Cc: Jon Mason <jdmason@kudzu.us>, ntb@lists.linux.dev
References: <165938663353.3660206.14823522095818743981.stgit@djiang5-desk3.ch.intel.com>
 <CAJ80savTwSK49YPdLDTgXsUqOF3+P5vcU6_sjc4Kaz_3_dF0ng@mail.gmail.com>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <CAJ80savTwSK49YPdLDTgXsUqOF3+P5vcU6_sjc4Kaz_3_dF0ng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/2/2022 12:52 PM, Allen Hubbe wrote:
> On Mon, Aug 1, 2022 at 4:53 PM Dave Jiang <dave.jiang@intel.com> wrote:
>> @@ -2047,6 +2047,8 @@ static const struct pci_device_id intel_ntb_pci_tbl[] = {
>>
>>          /* GEN4 */
>>          {PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_NTB_B2B_ICX)},
>> +       /* SPR has same dev id has ICX but different revision id */
>> +       {PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_NTB_B2B_GNR)},
> comment says SPR but the id is GNR ?
The comment is in place of the SPR ID because it's the same as ICX. It's 
not the comment for the following GNR id line. The only difference 
between ICX and SPR is dev revision ID.
>
>> @@ -70,6 +70,8 @@
>>   #define PCI_DEVICE_ID_INTEL_NTB_SS_BDX 0x6F0F
>>   #define PCI_DEVICE_ID_INTEL_NTB_B2B_SKX        0x201C
>>   #define PCI_DEVICE_ID_INTEL_NTB_B2B_ICX        0x347e
>> +#define PCI_DEVICE_ID_INTEL_NTB_B2B_SPR        0x347e
> PCI_DEVICE_ID_INTEL_NTB_B2B_SPR is added here, but not used?
>
> pdev_is_SPR(pdev) already exists.
> Should that use PCI_DEVICE_ID_INTEL_NTB_B2B_SPR?

Probably, but not for this patch.


>
>> @@ -225,7 +227,14 @@ static inline int pdev_is_gen4(struct pci_dev *pdev)
>>   {
>>          if (pdev->device == PCI_DEVICE_ID_INTEL_NTB_B2B_ICX)
>>                  return 1;
>> +       return 0;
> return pdev->device == PCI_DEVICE_ID_INTEL_NTB_B2B_ICX;
Not a change for this patch. but I'll fix the gen5 function.
>
>> +}
>>
>> +static inline int pdev_is_gen5(struct pci_dev *pdev)
>> +{
>> +       if (pdev->device == PCI_DEVICE_ID_INTEL_NTB_B2B_GNR)
>> +               return 1;
>>          return 0;
> return pdev->device == PCI_DEVICE_ID_INTEL_NTB_B2B_GNR;
>
