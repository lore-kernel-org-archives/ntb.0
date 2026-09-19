Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021109.outbound.protection.outlook.com [52.101.125.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C8937757D
	for <ntb@lists.linux.dev>; Sat, 19 Sep 2026 13:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789823300; cv=fail; b=RXWVNA3HrkK1CgL82dWSTKsytFymgWBbpFnUvvuM0czvW4qiG9PDRgqyaFBUZAEyXq2FHIeBohZh34aDFcNvn/Dg5pD5pEEz8t8MSg+XZ9rWBDDNDak4NHb2qqBlGFljnQrepRfvJEcCT0tjCU+elvV02xd7WhpxBxxr6egIEfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789823300; c=relaxed/simple;
	bh=KwEAzyzL0GGXWGk2kbNiqLxDmlz7aDAwRH8bY/ZNsAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QVg1HaGmy+pwgr/GPuNCpXclzUv1PePiAm3m2Hfb0ANvl13Ps/Y1q7mxiMPRSHDgKKpwdIibB0qDEa+Slq9J3cZ7jQFp0dfUq+Tq/NXKHbaIVjG97vWZGr5QOkuh6IFN/zdc6IXgCFVQe3rn2nJXlBqJLY/6XdK3qOHCVYzhjvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=LJICrlOi; arc=fail smtp.client-ip=52.101.125.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="LJICrlOi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sj7m39ac5rZ/QTQUWknsHe3GtmmdzsfqLrGXRUlwBvzsFWCzhg1/Dry6PgP4MZTIaCqV0gXwKqk4MsvyeXseaeUsIyNMnNXtOHQvSMydElLaTRIdyBQFKORQFmLkt1DPOktbdBwKQHGCW9R4npj0txH4ZflKHyWkvL/HUaZzl9DTcGLKdDdFSvOVc/vK27lhZN/256ECo0mQqu7ZHxmEsLuLLdQ4qZeSQRu0oQ4nTIEnT9dKtniPkYQ/V1H1vSENQ6UYv03EZYjRXxA7I+mkY/bCi7wk6Q4i1QpUKI8yWKdSDWZuId1LEpu4NocS6HOU5q6Y29awnb1ZQwTZO9pw6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Qr4ASLx9qHkrzz6rwJMaCEeBOIaBUEBZeIojM/zzQM=;
 b=xY/iQF7gJOZwg7Rq7mPP9OSxQ6wU8jdQaXXOmB7uwT7409SmEgkCyT8DttDBgsU9Orhu70Zp9c6I0aensaWpnTKq2lKJrlwYf6jJceCP1IF/rh1qiQhJMxeqcdqPAV8lNn9bffJVeDjYP8YRHzfPRAjL+oG7pSGzYTDpdRyJvYOZDplMG/HXfdvD8OhG8nYvrIoHmMKo5iQ37sEfj9DLchIUXPih7VDqyrTfq0x8P9CEPbHfCbDVbZnlKh8zy8MekKmvtPwFBF4RHKBfjg3xghuUtBbs2QSVwDDqQt82fCTpeJxFDsgCVdVSBbOhJrPtUraG1BoHqK+1ncpCGxAD5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Qr4ASLx9qHkrzz6rwJMaCEeBOIaBUEBZeIojM/zzQM=;
 b=LJICrlOiVXuxRdeeIL2FYhs8Cu9I6f+UESYoMC6750AU8LamsNcWFb+eVdvMkMQErJqC5BFuM3dsRk5EgzhDN277xYEhWDrwnr5xXcKHrqrtTuXqgT7U//EWFJD0B4OZTNfPv8YsjGq6+aeKcavs/bniZOZgKsPsyvdh4byQvv4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by OS3P286MB2405.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:156::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Sat, 19 Sep
 2026 13:08:16 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0428.014; Sat, 19 Sep 2026
 13:08:16 +0000
Date: Sat, 19 Sep 2026 22:08:15 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Frank Li <Frank.li@oss.nxp.com>, Jon Mason <jdmason@kudzu.us>, 
	Allen Hubbe <allenbh@gmail.com>, Frank Li <Frank.Li@kernel.org>, 
	Logan Gunthorpe <logang@deltatee.com>, fuyuanli <fuyuanli0722@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nicholas Bellinger <nab@linux-iscsi.org>, 
	Joey Zhang <joey.zhang@microchip.com>, ntb@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/14] NTB: ntb_transport: Avoid losing QP link-up
 requests
Message-ID: <dnx4sr5pnlxnq6yivlii3un7eeky2lu7tgzvud5ll2lk43p2tl@kdb633hchvju>
References: <20260910040836.3792333-1-den@valinux.co.jp>
 <20260910040836.3792333-6-den@valinux.co.jp>
 <aqQyEbLbABhhvFTO@SMW015318>
 <ciucjqvb7qbendlxqdya2wigyivgj4bvqbxtc4cidulr4knq6j@xbwucjdsiayy>
 <l5xf2iuwxgfa4xmtm2l3wn6nce5onfjxxkzfsj627k5xp3snmp@er6fkwlb3sgs>
 <aqTFAi8uo4LwzSj0@SMW015318>
 <i3b4kyeuwyjssav2kne5uhxmltwl2bmug2weyfaujxtrwlkuox@ms6ozb55tmz5>
 <a135b068-e7ee-40f9-8ae7-ca5c44db2dac@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a135b068-e7ee-40f9-8ae7-ca5c44db2dac@intel.com>
X-ClientProxiedBy: TYCP301CA0013.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::16) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|OS3P286MB2405:EE_
X-MS-Office365-Filtering-Correlation-Id: 42a9b71e-7707-43b4-baee-08df164f116b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|23010399003|7416014|376014|1800799024|56012099006|4143699003|10067099003|22082099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	imH2D2rzxcyik2bh53VXcYih+XWPIE9Zu/45QBvSc6oAsvMuzXmBXHHGzDK3F7DBAK0yu+nfY99GSG1X7U0FhEeWRrkMt7c8lyFETgfx2+3EBYsED9fVn7PfnvGzvwZGX2DAHPXj76sq1QLOnGjvr4Q/ddjHj75nWBBo8sdrID5PasE2rV7YDlIL+jSjsMwnmU7GwYCgPtTvkIIUiHVd5uleRQQdIXABvkys1DFMtpBvojz3yxo1YUhd119N01MUNgLAdL9rUxTkSbAXXMyriVyXK0fuQ+rIhkOBubrlkOCt39+i2IpLSXwv0JKK3/rWkseeABuSYnp6KWQ4e7yuDisFU3gqAog0dw592lB/lMSG6iy6OhRCwlEi1rRuqpUPdPzjiW+TKLo+ACSmSfdbuXf5t5x5nurV3cZuW8wnEmybcJXC4LLPMVk7J5Xh9KHjiey0lIkG+woROAmYFUL9xCwjCawqWoKvnZwYiMYXeHORI257FFskIVx8GvbZ+KQYdmIgOvpRIVpepJ8U6NaN9OR1u8W9bwvP7EFgB9Ll2X91tiL4V7ts29CU0a0MuIn7x+MlaS/NBVYuIvFtZNPEJG/kU/+Ry9vdh3Z+GbD3QXztFd2iOwJP+rrPa4bS6HOj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(23010399003)(7416014)(376014)(1800799024)(56012099006)(4143699003)(10067099003)(22082099003)(6133799003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f9Levpd4Bd2Dz/bgH4UnCJBZ1ZhuQjVyGy6gDgrGNxgbGUWdpVEC/rCvXPiI?=
 =?us-ascii?Q?HbudgWnx4rQ1LTVOFLY8d+r79w3/WGiblp1/Sxn37yWOeCrrMh8YUDZRsuxZ?=
 =?us-ascii?Q?B+Q242LyJfVL/3RPl9VpLnBwxU8WEWJPYPrvBs/Mw4UtZX92ttKevzrwPsnA?=
 =?us-ascii?Q?hcL1bYPzUmyXjfFD9DGxFR/1Ni+WvAs5xj+oO+HaN3aHs7OqrL8H1cOB1uMJ?=
 =?us-ascii?Q?fpVDQ5aHFiqQ9piMF2ipWWQaijwpWF1xpCq2nI1kcHa5ugbT0eqvaEHwES7C?=
 =?us-ascii?Q?OlpB65wn2ChBGBfu8WrCvZzCUSPKdBu28OLM+FCitBxOcCZ1yebbpNCmExa4?=
 =?us-ascii?Q?eidyBVf0skknE1OpWZcrkz/FkHBchA18CfpVZQYmCZnkcgLGvdrBrj27uzae?=
 =?us-ascii?Q?/UYiFQfPmrKU8fjDGoq7dSR8NsxzAUrqFV3Gh+3dmeJ6fYVM1SngCO8c+sDH?=
 =?us-ascii?Q?209U/DhnJC58dQ11ZZGRUKOsAZyFGxj8tq969SPz2P0H/cDDn8Uh4uX2iYFe?=
 =?us-ascii?Q?hwCzSqOVvAM9bMwp+YvfQ6bemSrYAEbYAKQcESeNLd7TJAq3ofrbKKddJHXY?=
 =?us-ascii?Q?Fae1rTvlgTperKMCwKaYDsbrk/2L5Q9tSpN1a2D2z2r5/wwN2/xRFA2pH1Z3?=
 =?us-ascii?Q?TSIPp6Wouk/q05Q76WHASIIkLXdXhRoIjNQ/Im7NOWgkmFd0Xn/0PKH6mFS6?=
 =?us-ascii?Q?rlPchsK3dcfQHFCUgYqiheQm9x/ORxIFzLpB4ZDlPr929BdovRDhvIf6/VcZ?=
 =?us-ascii?Q?9kauOJVT0Y5weOCIhiIQL9rE08i4JQUVfgDkfivFIOPGfWj8Ce7tyyg7GNv+?=
 =?us-ascii?Q?5pIX30/ZddPYsUN+UEq/F7bAZ78t3hH3sIOGGtNNv3mRJtgvwozQ5PrQ2YAx?=
 =?us-ascii?Q?z1V7B2zvsR7BBq3teSXk9sYdsG9+SFFQ4ys+lArtdv3qxG3TTKsGziDlGobJ?=
 =?us-ascii?Q?79PA+eItbx5a/23qbwxyQ/+2A/C6OXIhLwU4mzerAoTsUSlRTlYxmkKSuNQx?=
 =?us-ascii?Q?RLk6I4HEmmUjXJNr4JHRrD+cnNl6InXupUXie5DFXzAFhwO2SBBD39b2HAbm?=
 =?us-ascii?Q?QJru9IwO7WMDKra/uw/aUMJgmqzAG+z3u5qerWaupuERVOvs7DsuZMFxXsk6?=
 =?us-ascii?Q?rqwmbKkysfR7gAESvKEynwRLMVfj6bwbTFfekZdTFLK6GAIFtYXH8zJS3OUN?=
 =?us-ascii?Q?ACEml1W0rRAVjIhulXITA42XCsjILvRrhbUqIVUG1HR8Ol93d+pVGQL/NyYQ?=
 =?us-ascii?Q?yq3SRiYfj+bU3P+apA1UAj2W3+Ip5M/j09EEIi8GnsawU14kUp9++1NEjZp0?=
 =?us-ascii?Q?BKrDiAgsnicvimtpsys+V/PSUnap95tZ+qnV8svigXU25K71lRPOljw8eD/z?=
 =?us-ascii?Q?/ni1QhQchEWqj82ExrzuT7NgoTM+axqhFfCXLcHNhkzMwXmeBQ8TT8Kuj/Tg?=
 =?us-ascii?Q?6bd/5o0RHjphKY6e4ev4ITp5Vj5B7trbQTOCuHpU5LDptruHG8SOzUtkstIO?=
 =?us-ascii?Q?Opav50roKgt5/tD5btzdXSCWjuUba15BdDTqXfxPGktC8eXZY/RLqv9mukL7?=
 =?us-ascii?Q?R/xOjxTGofGXIRczf6j8IvbQFmj0hJF2CaqoXowk4OqbyWtX9G90/qvIms0Y?=
 =?us-ascii?Q?2MkSvFCTjcZOLzU1H+ul3nrrLPJ97tCox2exgJCDpwt4Lr5Xqdd1l3XMkcVM?=
 =?us-ascii?Q?RxIBLX/bJqCzJV1cglrUBIIpaAmyPSlNlF+AuMZ8+jI5gAGZ6QEc9AFio7bd?=
 =?us-ascii?Q?XTzcdMFq+j+g67Mx3UT8uo7JIOGD7Q1JMAEqtTjT6Qruf8FhO7Vw?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 42a9b71e-7707-43b4-baee-08df164f116b
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2026 13:08:16.1219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rZmrUYTFxTWRHdOedlMJpgmWIZe4DvsM+xthsS5m6LGW8kTP5JQ1M1MyE1O+76IBxod1bZRcUiydugySPjNTNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2405

On Fri, Sep 18, 2026 at 07:43:26AM -0700, Dave Jiang wrote:
> 
> 
> On 9/12/26 7:52 AM, Koichiro Den wrote:
> > On Fri, Sep 11, 2026 at 10:20:34PM -0500, Frank Li wrote:
> >> On Sat, Sep 12, 2026 at 03:21:08AM +0900, Koichiro Den wrote:
> >>> On Sat, Sep 12, 2026 at 03:04:21AM +0900, Koichiro Den wrote:
> >>>> On Fri, Sep 11, 2026 at 11:53:37AM -0500, Frank Li wrote:
> >>>>> On Thu, Sep 10, 2026 at 01:08:27PM +0900, Koichiro Den wrote:
> >>>>>> ntb_netdev_open() can call ntb_transport_link_up() while the transport
> >>>>>> worker is completing setup on another CPU. Concurrent transport setup
> >>>>>> and a client link-up request can both read the other's flag as false and
> >>>>>> leave QP link work unqueued. The QP then stays down until another link
> >>>>>> event or client link-up request.
> >>>>>>
> >>>>>> This is the store-buffering pattern described in
> >>>>>> tools/memory-model/Documentation/recipes.txt ("Store buffering").
> >>>>>>
> >>>>>> Add a full barrier between the store and load on each side, and
> >>>>>> mark the client_ready accesses with READ_ONCE()/WRITE_ONCE().
> >>>>>>
> >>>>>> Fixes: fce8a7bb5b4b ("PCI-Express Non-Transparent Bridge Support")
> >>>>>> Cc: stable@vger.kernel.org
> >>>>>> Reported-by: Sashiko <sashiko-bot@kernel.org>
> >>>>>> Link: https://lore.kernel.org/r/20260907144701.702E41F00A3A@smtp.kernel.org/
> >>>>>> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> >>>>>> ---
> >>>>>> Changes in v2:
> >>>>>>   - New patch (Sashiko)
> >>>>>>
> >>>>>>  drivers/ntb/ntb_transport.c | 13 +++++++++++--
> >>>>>>  1 file changed, 11 insertions(+), 2 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> >>>>>> index 75d4a2e021f4..1332d53bcfe7 100644
> >>>>>> --- a/drivers/ntb/ntb_transport.c
> >>>>>> +++ b/drivers/ntb/ntb_transport.c
> >>>>>> @@ -1104,10 +1104,16 @@ static void ntb_transport_link_work(struct work_struct *work)
> >>>>>>  	/* Publish the link only after every QP has been set up. */
> >>>>>>  	smp_store_release(&nt->link_is_up, true);
> >>>>>>
> >>>>>> +	/*
> >>>>>> +	 * Prevent both sides from missing each other's flag. Pairs with
> >>>>>> +	 * the barrier in ntb_transport_link_up().
> >>>>>> +	 */
> >>>>>> +	smp_mb();
> >>>>>> +
> >>>>>>  	for (i = 0; i < nt->qp_count; i++) {
> >>>>>>  		struct ntb_transport_qp *qp = &nt->qp_vec[i];
> >>>>>>
> >>>>>> -		if (qp->client_ready)
> >>>>>> +		if (READ_ONCE(qp->client_ready))
> >>>>>
> >>>>> I think it'd better change to use atomic variable for client_ready to avoid
> >>>>> manual handle smp sync.
> >>>>
> >>>> AFAICT converting client_ready to atomic_t and using atomic_set()/atomic_read()
> >>>> instead of WRITE_ONCE()/READ_ONCE() would not free us from the smp sync, as
> >>>> those operations are unordered.
> >>
> >> there are acquire version for atomic
> >>
> >> atomic_set_release()
> >>
> >> atomic_read_acquire()
> >>
> >> My key point is use existing higher level sync APIs to avoid consider
> >> barrier problem, which need more brain cell to think it.
> >>
> >> this is just sync state, which don't impact performance.
> > 
> > I agree with the idea of changing both flags to atomic_t for cleaner code, but
> > I'm not sure if it frees us from "the smp sync" or the "barrier problem". We'd
> > still need both smp_mb()s and still have to think about *_release/*_acquire when
> > revisiting the code and maybe scratching our heads, right?
> > 
> > BTW, I once wondered whether it might be worth consolidating
> > link_work/link_cleanup into a single state machine worker per transport or QP.
> > That could simplify synchronization between setup and cleanup, which aren't
> > really performance-critical, as you say. However, that would possibly require a
> > larger rework, so for now I've put together this fix series as a small step. I
> > would be interested to hear what NTB maintainers think about the possibility of
> > such a rework.
> 
> I'm fine with it if it doesn't break any existing code and reduces complexity with simpler code.

Alright, I'll look into it when I have some bandwidth to see if it's really
worth doing for mainline.

Thanks for the review!
And thanks to Logan and Frank as well for taking the time to look at this.
(Saying it here to save ML traffic :))

Best regards,
Koichiro

> 
> DJ
> 
> 
> > 
> > Best regards,
> > Koichiro
> > 
> >>
> >> Frank
> >>
> >>>> So to illustrate this in litmus test like form:
> >>>>
> >>>>    # L = nt->link_is_up
> >>>>    # R = qp->client_ready
> >>>>    # Both initially false
> >>>>
> >>>>    Transport setup                  Client link-up
> >>>>    ---------------                  --------------
> >>>>     smp_store_release(&L, true);     WRITE_ONCE(R, true);
> >>>>     smp_mb(); /* added */            smp_mb(); /* added */
> >>>>     r0 = READ_ONCE(R);               r1 = smp_load_acquire(&L);
> >>>>
> >>>>    Both reads return false?
> >>>>     Before: allowed
> >>>>     After:  forbidden
> >>>>
> >>>> I might be misunderstanding your suggestion though. If you have something
> >>>> different in mind, please let me know.
> >>>
> >>> Just for the record, smp_store_release/smp_load_acquire depicted above, instead
> >>> of WRITE_ONCE()/READ_ONCE(), is intentional. They are for MP ordering to publish
> >>> the QP setup, which is needed by an earlier patch:
> >>> https://lore.kernel.org/r/20260910040836.3792333-5-den@valinux.co.jp/
> >>>
> >>> Best regards,
> >>> Koichiro
> >>>
> >>>>
> >>>> Thanks for the review.
> >>>> Koichiro
> >>>>
> >>>>>
> >>>>> Frank
> >>>>>
> >>>>>>  			ntb_transport_schedule_qp_link(qp, 0);
> >>>>>>  	}
> >>>>>>
> >>>>>> @@ -2401,7 +2407,10 @@ void ntb_transport_link_up(struct ntb_transport_qp *qp)
> >>>>>>  	if (!qp)
> >>>>>>  		return;
> >>>>>>
> >>>>>> -	qp->client_ready = true;
> >>>>>> +	WRITE_ONCE(qp->client_ready, true);
> >>>>>> +
> >>>>>> +	/* Pairs with the barrier in ntb_transport_link_work(). */
> >>>>>> +	smp_mb();
> >>>>>>
> >>>>>>  	ntb_transport_schedule_qp_link(qp, 0);
> >>>>>>  }
> >>>>>> --
> >>>>>> 2.51.0
> >>>>>>
> 
