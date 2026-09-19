Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021094.outbound.protection.outlook.com [52.101.125.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29781DED5C
	for <ntb@lists.linux.dev>; Sat, 19 Sep 2026 12:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789821470; cv=fail; b=CQ84OU/F7r9L/Pd1TvVZlUw/2bWHdhWHhLgS8rBs5WgnO77nXrTUyIojDgLkRUrdI45Uw73EgCUYP6M1SfRs6jg8NaeHmvFPVN8OGMdP/rC+8xsvFQ24Y2fX3pQKCXQjCylWagMHmx2C/yBIzF8aHjZAljofRK3AG9XiQG9OX3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789821470; c=relaxed/simple;
	bh=5ib429JjPMBouAFgSJFftFOu2ax4YCjwNtY3gjBbboI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p9nYXEUdXOiWDS5MyBrmPCJgh/WDmX4E/mZzH8fwnKXyCcNA5/UxYjoLjj8Ux9VVHdnTSK7mZxmGBerKeJKCFHvmRTDe69XjOZppJ5oUrusbwGZhiKNWan7dBfTGclhCwQh1M2Xl88JumLHr60/+wrb8ymBmXXTqvCgL6TIUnKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=gPK3Q/WA; arc=fail smtp.client-ip=52.101.125.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="gPK3Q/WA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dsF4Q4lXGA+yEgIrO7Ln20Q00FbTe2y0axOH+eyg8PUS8sdVM86Pyue4RK0//ZUTKrWl6YU+ZqAI607/+F5noqVvmKJDanCdt+7h1n3MS0rE+vMG4E/tY4dVmuot5lBFUdSKZ4XHaMUJ4AOuS4Mbo7Bc2Svqq8xzJAWdx4wNt3KpCVzvKjJC+YcMSERmpF2xS5rt2g2dPM3Y6nCtBLoW2ylDD5NhMDilKoixoYc/mYeVgQXz/PydQOwuAcODtKTbZOQCSPYHhyME45yqvETJOgv5r0AyTrVpemvvtbRoLcYFu3qKv1RyomvdL+kcpajWSEL9x8R0l7NHDMz8Njk5gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N2UCp8neR70EFIprSQSbBJwVWoFHYtaw0LaYNUx6oGA=;
 b=jFizeOo4h61/D5ouWEUaQulIOYD7VvG9AF9eGwJSPeEAFk0TpgCqpB1W2quPuvhH3sROQ0v7PWEkmp9aeqNfBZBuePgCjdT6OLxPV/ZtZvs2vYjP5iNDbSf8zK1IcE2ULBT6hFoL8GZcor6PPjLMjc/LM0D9I776dXB1I/oLsXDyNavVIFoXDnIBT8m9ZND4et3WntnG5u68Z98vj/y6xcptUkqd+3E4eLITW3qQqfpH/mN2prRj066kvK5PKMkUwNJ7In/cOOr+9aPe50UaJZCgRbrS3Z9YfedDbCrVw97sx1SW8g6K3XSOdc0A2zUN6fjmiREsCFzrYtv77eAd1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2UCp8neR70EFIprSQSbBJwVWoFHYtaw0LaYNUx6oGA=;
 b=gPK3Q/WAKyPFS4WrdEvQF7qi2lYmZCn+GT8+HNYINexyQUpDeU7nalV0BJY/KL+JRCASw6EgjkFhprPrAWWLgS1HkUvHFdn96M/e82odMRcZf0x2h7855oVtRSRRd2llJJHWo11QuyXIQS7k/J9IhRVeyI0SdvvPp6C7GGgzBl4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:248::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Sat, 19 Sep
 2026 12:37:44 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0428.014; Sat, 19 Sep 2026
 12:37:44 +0000
Date: Sat, 19 Sep 2026 21:37:43 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Joe Damato <joe@dama.to>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, ntb@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 01/10] NTB: ntb_transport: Order RX
 descriptor reads after completion
Message-ID: <zr76ct7tmugvmnpisjqd5szxw4cbm7iza354ijnzb5n2bn46hu@24ij5ubx56yg>
References: <20260914084838.2158249-1-den@valinux.co.jp>
 <20260914084838.2158249-2-den@valinux.co.jp>
 <aq3ZG222WqEDp1Je@devvm20253.cco0.facebook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aq3ZG222WqEDp1Je@devvm20253.cco0.facebook.com>
X-ClientProxiedBy: TYCP286CA0139.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::7) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYWP286MB2601:EE_
X-MS-Office365-Filtering-Correlation-Id: 972b4ea8-acb5-496e-7f4d-08df164acda7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|7416014|10070799003|1800799024|4143699003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	BH5hk22lOjDzFsyqfaa953BFnw67WRtkqjc1CjQu7i1lCOi+skeMsUclv3/S2rhBD7KoFN/srXQYk02jh+GAiWRQ0TzvZL5NTaK1D0Qr1oNbICRMUO18RlbXqPcq9w5qzAnXteftCDDqOckhCEYF+Y2M7uDLf/dvQHub3kp8Lfvz7ThLCMGnkFLh3MhF5BSmWb3RNoZeIguBCYvzOudyQ5j/SA2NJUHeMjFB+6VaJO8a5ijzodjENrKr2vo3j/eOdjfrsEoiYVJRW1wbVO0heW9VoQ/1h5NN9BJybA0uxWqco1EYm0C4MMafsc7HjWPV31qLjEwo3WDXq48ImgTe5aP3EZISRpu1dVSSZCL6PBRtperxEsbH+tGIfQ7X8CgiVjPpsWWfzYkORLiCehfkoz/Cf98hZwVykNH8vPzWC68TG2Y+I84zQuoqI46r+Yzyf98Fy2/0EXDajPCv9oRTg1ZBQbPt/qFelXIcixfQOleo4jpuFhmiEmXruaMX9NKcQTBDP1hRvcRHWgftYJkFrmicfOTyJq7IjPl1XYXnw0alr4XOPcE0x+sU+mA8z6yzYDGiTUHGv+ZyziHvIG9lxtb76uMzqOblyEi+uO7stw+9GAfAe9rjzqyOcqebbNfU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(7416014)(10070799003)(1800799024)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2GIkx/lytUo0YBoFCH8PJQZH5MzHi5jSwREjKbMD4eUJHvGRR5FHi7oxxplP?=
 =?us-ascii?Q?vsI1dRBeE5Tdyyay3s3S6w0QAzXRc7RHbLs8mXpi8nMA1b1+yz0W9RGp+OBG?=
 =?us-ascii?Q?ncgmoybkQMY3WA+puqW9MQiFmbMvZ1WCjMosTKfXCPzMYSU9AXXpImKUQahQ?=
 =?us-ascii?Q?uX72V/F9k2N46E69Gn1RXghC9BARKjLRwX1Pe0+IYMU4G55iPB0Q1SyL4H1o?=
 =?us-ascii?Q?cC1Hvv485GypYkYLIWCDzwWSW236oQ0si8d53OiBFF04u9lRnQgCW15whEWQ?=
 =?us-ascii?Q?KrrYIy0SojYU2AH5Pmgjz9gjOC1OnOOveTGB+DURG440ifzk9XoYIPIYaAEG?=
 =?us-ascii?Q?otz9MXR2dh6/j5e0dduXRCvX5HKrAuVbW6Gl0bHk1MaGhZ/vsTH+2mg50fJh?=
 =?us-ascii?Q?+4UoN5+ThWMrIyxuIiqn7W2yHeyqg4toyqvIqLUccOQ6eQh0zb5AqQHZYNn0?=
 =?us-ascii?Q?NWoi1as69DpX7O/ChjSdFYmwnE7VmaqyKUirtmcbNDo3sMZp1cbrNI0rXvg2?=
 =?us-ascii?Q?QPRxptv4qr8Xd0+Z7bsh00hZC+YuYHYgUFM6EvHghQm6Kxl9A7rDGtZpc6FV?=
 =?us-ascii?Q?drE2jewbQGhkY/cE43gV9H23NoT6UKukk7eaFx80AqchZ1QCmI4zHuwXbx0J?=
 =?us-ascii?Q?9PRsr/zZxagOCGWWyjyk8tVDED+cfkN9rbI18Z4PuyAcL51vcZIST27Byrc8?=
 =?us-ascii?Q?+154preogniwuW90QN24martizLOsyfYqGCaX9pSGDV5CuVHbzUskSEPbYZC?=
 =?us-ascii?Q?RPkXIhMvWutInrLGn+FHCbo9j9DahS+55tRQcVzhWyUjsq48RI4/HEazpfV4?=
 =?us-ascii?Q?Byf6MY4YP0X6DaRZgX/r+SKv7pB6XMq7qi7/Fnjlzy+PJiolrOtqqgt+29Qg?=
 =?us-ascii?Q?Hgv+mQUpdbgtnbNUS8NMAXsVdeMSJD0YfIAWEjLUK7As1Cw/swa1ML3MqwV+?=
 =?us-ascii?Q?Jjxa+/PEZq07d5aIjTiqUksFVSC8Cfz/t/MmAiEc8YmkzjrKfRNYlPKW6ijc?=
 =?us-ascii?Q?n4+qxpvdIhn+tU5YCJGrxByi7IEAbqEu2xHrULimAmn5s8th0H8yGImuD19D?=
 =?us-ascii?Q?p53zbQBHdQPBxVxWW0hNHzc0dHSUsRH1rj5dtqYsBY9yho2U5aM3S3yA8WQz?=
 =?us-ascii?Q?K7jXFfhl64jfs2lgQVs+amNBrR45NRpfxhH+71TEu4bR+YzdJ+EDreovv7QG?=
 =?us-ascii?Q?zNfKxFR5Dl1qiByCugaWn3UYmKkBzs/MkgBVAcVqEB4A7yt6CVklRoXK/Ch8?=
 =?us-ascii?Q?maV5TwV+pP2biivCmEAKEmjxdgyuVnxksV3LTTFKoAZ1G3debU3mkD1wGL0J?=
 =?us-ascii?Q?54JFlDytM098J5ySaMR/HXX1xa9MBGJVlfPG28K3PNyLA1HoT0XO1mGm0Qht?=
 =?us-ascii?Q?JEcKz1WHSwSxAsptfaBpg2lO85EnHOwjAp/mSOnocK0cqUrMHA+ALWWs+Rso?=
 =?us-ascii?Q?IcPZFd8RoOvTmnaLQNDLi3kh7irw2iCOHqfUO19TMoHLwCxkpCO6UNtYaBXE?=
 =?us-ascii?Q?Qekcz3E5W6gVRbvzV8khbWhCoPZXJ46IDuJQr3bJKe5XhL3mkT+CmNIcNIwj?=
 =?us-ascii?Q?7VFtMoJtoRyzMSTQ2tvwC195y8SwUirA3FfD1F1W1xqhZczkQI9FbX+f36Eq?=
 =?us-ascii?Q?5vqQrQ0NGVSWoWCF0HOb9DFm17q9DTgMdElnVtWGk4A31ySxTvkQBU78zXNo?=
 =?us-ascii?Q?A5BVsBjoYNCjnBC6ufDvMMHzF+eqCwYC13AdaY00+thNuH8Fa9rS5cuJrPue?=
 =?us-ascii?Q?l3HYwcNFoDjZqTnipLjMyQtrpH2+pEojtki8E2QTY/3zIJTkJSxR?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 972b4ea8-acb5-496e-7f4d-08df164acda7
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2026 12:37:44.5049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E4Cv0AjfqC4ogrgXTDVmrQmvm3fqQOmH0s6ml2s7IrGcHwFM4B8NCmXDYtMfJuDjfDytu42P3/ixwrofs3Fiyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2601

On Fri, Sep 18, 2026 at 05:36:43PM -0700, Joe Damato wrote:
> On Mon, Sep 14, 2026 at 05:48:29PM +0900, Koichiro Den wrote:
> > The peer writes payloads and descriptors into a DMA-coherent memory
> > window. ntb_process_rxc() checks DESC_DONE_FLAG before consuming the
> > descriptor and payload, but coherent memory alone does not order those
> > reads on weakly ordered CPUs.
> > 
> > Read the completion word once and issue dma_rmb() after DONE is observed.
> > Use the saved word for subsequent transport flag checks.
> > 
> > Fixes: fce8a7bb5b4b ("PCI-Express Non-Transparent Bridge Support")
> > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > Link: https://lore.kernel.org/r/20260815032932.151F11F000E9@smtp.kernel.org/
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> > Changes in v4:
> >   - No changes.
> > 
> >  drivers/ntb/ntb_transport.c | 14 +++++++++-----
> >  1 file changed, 9 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> > index f9caa1a653c5..74f4f8c1c7be 100644
> > --- a/drivers/ntb/ntb_transport.c
> > +++ b/drivers/ntb/ntb_transport.c
> > @@ -1609,21 +1609,25 @@ static int ntb_process_rxc(struct ntb_transport_qp *qp)
> >  {
> >  	struct ntb_payload_header *hdr;
> >  	struct ntb_queue_entry *entry;
> > +	unsigned int flags;
> >  	void *offset;
> >  
> >  	offset = qp->rx_buff + qp->rx_max_frame * qp->rx_index;
> >  	hdr = offset + qp->rx_max_frame - sizeof(struct ntb_payload_header);
> >  
> > -	dev_dbg(&qp->ndev->pdev->dev, "qp %d: RX ver %u len %d flags %x\n",
> > -		qp->qp_num, hdr->ver, hdr->len, hdr->flags);
> > -
> > -	if (!(hdr->flags & DESC_DONE_FLAG)) {
> > +	flags = READ_ONCE(hdr->flags);
> > +	if (!(flags & DESC_DONE_FLAG)) {
> >  		dev_dbg(&qp->ndev->pdev->dev, "done flag not set\n");

Hi Joe, thank you for taking the time to review this series.

> 
> I get why the dev_dbg line above was moved down, but i feel like if this case
> is hit, you lose some of the debugability that the debug line intended?
> 
> idk maybe this dev_dbg should be something like
> 
> dev_dbg(blah->dev, "qp %d: done flag not set, flags %x\n", qp->qp_num, flags)
> 
> so that some of the debuggability is still preserved when this case is hit ?

That makes sense. I'll follow your suggestion in the next revision. I think I
need to respin anyway.

Best regards,
Koichiro

> 
> >  		qp->rx_ring_empty++;
> >  		return -EAGAIN;
> >  	}
> >  
> > -	if (hdr->flags & LINK_DOWN_FLAG) {
> > +	dma_rmb();
> > +
> > +	dev_dbg(&qp->ndev->pdev->dev, "qp %d: RX ver %u len %d flags %x\n",
> > +		qp->qp_num, hdr->ver, hdr->len, flags);
> 
> I guess the above is a nit, so 
> 
> Reviewed-by: Joe Damato <joe@dama.to>
