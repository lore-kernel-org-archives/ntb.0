Return-Path: <kishon@ti.com>
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com. [198.47.19.142])
        by gmr-mx.google.com with ESMTPS id a16si1034430uas.1.2020.12.07.20.47.04
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2020 20:47:04 -0800 (PST)
Subject: Re: [PATCH v8 16/18] NTB: tool: Enable the NTB/PCIe link on the local
 or remote side of bridge
References: <20201111153559.19050-1-kishon@ti.com>
 <20201111153559.19050-17-kishon@ti.com>
 <f39cf769993541e2a46bfe4d777ccf46@intel.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <6a493055-eef0-5722-e24b-449a11cf8a36@ti.com>
Date: Tue, 8 Dec 2020 10:16:46 +0530
MIME-Version: 1.0
In-Reply-To: <f39cf769993541e2a46bfe4d777ccf46@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: "Jiang, Dave" <dave.jiang@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>, Tom Joseph <tjoseph@cadence.com>, Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

Hi Dave,

On 07/12/20 9:25 pm, Jiang, Dave wrote:
> 
> 
>> -----Original Message-----
>> From: Kishon Vijay Abraham I <kishon@ti.com>
>> Sent: Wednesday, November 11, 2020 8:36 AM
>> To: Bjorn Helgaas <bhelgaas@google.com>; Jonathan Corbet
>> <corbet@lwn.net>; Kishon Vijay Abraham I <kishon@ti.com>; Lorenzo
>> Pieralisi <lorenzo.pieralisi@arm.com>; Arnd Bergmann <arnd@arndb.de>;
>> Jon Mason <jdmason@kudzu.us>; Jiang, Dave <dave.jiang@intel.com>;
>> Allen Hubbe <allenbh@gmail.com>; Tom Joseph <tjoseph@cadence.com>;
>> Rob Herring <robh@kernel.org>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; linux-
>> pci@vger.kernel.org; linux-doc@vger.kernel.org; linux-
>> kernel@vger.kernel.org; linux-ntb@googlegroups.com
>> Subject: [PATCH v8 16/18] NTB: tool: Enable the NTB/PCIe link on the local or
>> remote side of bridge
>>
>> Invoke ntb_link_enable() to enable the NTB/PCIe link on the local or remote
>> side of the bridge.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  drivers/ntb/test/ntb_tool.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c index
>> b7bf3f863d79..8230ced503e3 100644
>> --- a/drivers/ntb/test/ntb_tool.c
>> +++ b/drivers/ntb/test/ntb_tool.c
>> @@ -1638,6 +1638,7 @@ static int tool_probe(struct ntb_client *self, struct
>> ntb_dev *ntb)
>>
>>  	tool_setup_dbgfs(tc);
>>
>> +	ntb_link_enable(ntb, NTB_SPEED_AUTO, NTB_WIDTH_AUTO);
> 
> The tool expects the user to enable the link via debugfs according to documentation. Is this necessary?

right, it can be enabled using debugfs. Will drop this patch.

Thank You,
Kishon
