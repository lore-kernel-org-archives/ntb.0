Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021100.outbound.protection.outlook.com [52.101.125.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C752857CD
	for <ntb@lists.linux.dev>; Wed, 28 Jan 2026 15:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615603; cv=fail; b=YGx2+k07Edm+Wu5aZJ3qzjvLZ+4M5uZC1to+Jo88mbT33N7ber8W25l7Wx9Xca7Wy3E/2CGHlkdv4Qxi6GUvcONkvw1qAN0jAdjWUqkOGxUEicVuQoO4ojuxPB7lMY89L48AsPwj/HCMDs3uUSJJlZGIRL9P4ifQaihP5LOs9l8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615603; c=relaxed/simple;
	bh=LWQZlz4f5sSGzT0spyV/Rk/PvZxGy/MPSOBZbd9ADrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GwCSF9ntpESg0NCXmWuLKp3eG8otYMtVtC9QstbGp01u7zA/MA/vXhs1KPwqN9WM7lBl+AyFOBKpAPzCaCoWeHNBXwCLZmKxoj6boKPe6TnFcd2BeEItSle5VX/qAuIpIcbl9OJV/MKigVKA/HsoBaRbE2hzsGSjPEu9F3Zx+2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=UZ5QDm+f; arc=fail smtp.client-ip=52.101.125.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="UZ5QDm+f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jG+zDPAdY480rhurZaJGnw2SzMU73VjPTE+eNAaSNmOQ1Lsox78y11LXvOhPcTHbaRbFUk00Dd33U9IwY/QYnQ4PN0+pALJaZQ/FycKgRI7Ey2z+uWB18IWTlhKle2OXjpAm8fH7FsU5z6GWVlurPDPyVkqicHN+RZRPKb5fDzwQwzW+6tibM9gyOXVm5fhn6G+Xmn+Kt83cFIWFG87wRLLzcbsLm30alW64wx9A3cpRxJWEyaI8+R3oUxF9bxcG26QEZDPrfeHL/iiXcjqan4kQkWbC9ZdKsXuCEeZgkP1IgvXI8YxCDY7ae2XLatgfE9RWAVaui3ru8eQ4Pe+SYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3Q/dY4bJQIIfkTQGskJPdeMioJiKrx0e5S75pTOnkc=;
 b=AQCGd5r+C8ijYjjCYOx/U3E1EkRyfD4PUa1amqFE4DWCcEAasI0I0ITS8T7sji81e8r4OW6GsjKHgpSTX3f47GNGTKCdG8K2LC2LVVBEP0FiY7Zwjgx0sSQom+rJLSTs9phqNAf6ELSsUzCySTS7SMMdYotDBdTJaGE/cRSvmpr8jYHNhpDmBd2K10MM68ulNOeKIk3W3CK2JkIkk5tLuGuvXjJewjQigsZ2HlpQChGIFmaODLP6KmksjF4/6SA+JSEoTvAs5JcUyNqnxdQw0RMCV7EBYPUgbb74eh5GQ+N5qXC25/dA0hdXePym9iQmqAY+uhAISAE/Z5ijoSrGjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3Q/dY4bJQIIfkTQGskJPdeMioJiKrx0e5S75pTOnkc=;
 b=UZ5QDm+fFwKOHHErNU7cFmDrSh+4VQlFXkEMF2GTBigWaQjR21SY3PsFzCtRckglwXVpZW3WTWOmjxP/8lv4Jp1aHgy9Y4loObzei1TAtOxWt7HjNIT211B6j9tbxsoNEHBHDHjY8r/74lS2mPBffeUUDnptTGU7gD+RIAWHWCI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY3P286MB2627.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:252::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 15:53:16 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9542.010; Wed, 28 Jan 2026
 15:53:15 +0000
Date: Thu, 29 Jan 2026 00:53:14 +0900
From: Koichiro Den <den@valinux.co.jp>
To: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com
Cc: ntb@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/7] PCI: endpoint/NTB: Harden vNTB resource management
Message-ID: <pmacrk4of5662qejkisvonwvga3vqti7cfhhokpsfkvdz34d6p@v7wyrgg5h2bz>
References: <20251202072348.2752371-1-den@valinux.co.jp>
 <aqxjlfdqincb4yszn3ngjzvyiuybeoo2pyno4t2iz6ant337n4@bz37hl5nofzy>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqxjlfdqincb4yszn3ngjzvyiuybeoo2pyno4t2iz6ant337n4@bz37hl5nofzy>
X-ClientProxiedBy: TYCP286CA0209.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::12) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY3P286MB2627:EE_
X-MS-Office365-Filtering-Correlation-Id: 8adfb41b-2fd9-412b-9954-08de5e855951
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8Q3H+y5n8M2qBWDdT5SgrfTZND0RuveKQi1mZl/o9oxNDDojUnW3uD3uYqEk?=
 =?us-ascii?Q?V0tKeuppZcfLBWlDj7yhuFwW2ui2ia9tuZ5lOGWlI0gpZg0URZa+A9eNyX14?=
 =?us-ascii?Q?eSf58xf+OlDRw+qpN9pFcst/pNTy5UXxFsVS+GU7Yyl05MMtiUo8SldgGAbw?=
 =?us-ascii?Q?vfc1wGgwDVf9w5LZjPszs+tumVuiBtcNSzCOk7dO6jDJokuYP2ZMztUFjdyI?=
 =?us-ascii?Q?nAZobHyyqqwbFEa8nPg5cjSdxXU1llAFbEHrzFacN7sJHyGYCIAfdAd5kS7Y?=
 =?us-ascii?Q?U8MLIN4sneliXu0NpUni5sWUYbezmtjNUzI+W29UevAf69iFJ0cjaxCwKaL1?=
 =?us-ascii?Q?pN3m9jPQmPuicmYyJWf0SFM5AuXzmospvtkRz5jr8H8MCG5PbOM/9Tpiy44P?=
 =?us-ascii?Q?D1ENeRteK8WbVOYBjU8J3jnDsMWD16Ew7z6BH3KxXZOaN9oA3T7GFodalQck?=
 =?us-ascii?Q?gwX/LKV8PSN12jaBuePaSdqwiHjOyV0amI3lc3kICsi5IG4cqK4bXk80iQd2?=
 =?us-ascii?Q?d6hcOLSCcWUuz9KA6sYhUZoDr2uXjOZmt3ux8yKMxwuDjXpR+VnVhDpjECF4?=
 =?us-ascii?Q?xFpy48kGES18P4SoSFFFSiwhXuQ2Lcbv/9yM7RcQMQq33KzsaM5+H+1gJGbQ?=
 =?us-ascii?Q?vPYSQrsEiCXNj9eTFNVYBMsfZan9YSLsJxe2rD3vvz24DzrXcRwDMRDub95c?=
 =?us-ascii?Q?VlFYu1ixLt3u3Dq5ShXjW0FYCnepNHlOa/MtkI8sAU6QHe1HHg87ZwJr3tZl?=
 =?us-ascii?Q?C12reBf8OGIv0GztBjXhuw8VS/1JY4p5BXiOn9L2TQy9R4tD0n9WfsbhOTms?=
 =?us-ascii?Q?8DA6defdEg0mEHQ7Pxi62CB8u8IHQUTifGnzG7ssxa6Js+STVoChFO3shjUB?=
 =?us-ascii?Q?txvLyVZ9z2FRP3/XsO5L6lO50IIQO/mxTD9+VI1kYFtJ4KJkGDZA4JSPAn1L?=
 =?us-ascii?Q?BrETODpkf3Rx0ON6igsOztks6DeNUTJou7gjYi2hrvwETrH/m1vpAQl6NKSd?=
 =?us-ascii?Q?GLMkQ3IrXot8qMU38WLsvCQD0a+BtDJyrIONiGgBPGDGTyX36lscVY3SR6Oy?=
 =?us-ascii?Q?9wrdBnt6q9m+TLRwF98ekYoRwH8P73PFoMbhEZB5uprTb5CT1sFz2WK/DKxX?=
 =?us-ascii?Q?R2m2d9bd6vGBKyfMw7IGPAM/ZET+LGIsOtLJ4P4Hkijt0mzLzzcH/Nfdvl9Q?=
 =?us-ascii?Q?msK9QH4m5F/U/cm9wtcv/JAMZO3gIT9N7fX8CI7jOfMainLqN4ty+1KhlSaG?=
 =?us-ascii?Q?amCQLDsCd5fg3BFI/AkHKN3Qw01z2kpGotTStTxVnSung81dRm8GusFbdBHj?=
 =?us-ascii?Q?N/qSoQl2Wd0pGwVShnOxzoUw6hyUsik9+9ZyDUK4XtLlo/kBo0uwtupOWFf9?=
 =?us-ascii?Q?jboOlkyiMqW+eQJXvmd2gulkvKZuF+N+EOZFIeo3iyWf30eHt6JiFfK5PTKM?=
 =?us-ascii?Q?Aqb52G1NYXCdg8yFwfYWbD3bjUkm43AHvmi37Ms1abNlZdEQ8YR40sqV6cfk?=
 =?us-ascii?Q?e3fWGRDupSHpHUbbB6dtjrw3PTqtUcAVLWV5xeSoDzZYOLi13UqzXi7Ip6rv?=
 =?us-ascii?Q?TEaYHQHTkjxV7z4VbZI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MnARHf1nS1czQko91pD92T4SebW5+tAIVh4Oqy3ASUUYVWVnJSAyOH9L/QN4?=
 =?us-ascii?Q?IYEL5+ahSZSG4agOYP0K1sOK7lPPSpwE6In5F/b93FXkUYwfXgiXauwn41nW?=
 =?us-ascii?Q?XlNWsCsU+GaYtxZ39vNFqWoUSzotF6sjzVDL+YK52Vr1C9XIZJ0KjZ00srJD?=
 =?us-ascii?Q?hCgBIPjNgA739DS12RZ+4cY0kDs8aB8bqbHSV81NVV2ZcI95OttnVxXfNwi8?=
 =?us-ascii?Q?OGo5VoC8XH8DAHXDihZHwARFmNuGgM5/11oQGksQL0phEXLdfRAkLsOVRzzr?=
 =?us-ascii?Q?okZJ88zeUWEDYLczoeaRoyf5mh8mD2V5DDXtVifhgdoL22NiSRk/pc93aANN?=
 =?us-ascii?Q?CLH4Mh75OKNDnYlTroCpH4iIapnV6G4BzBGjo2YOWiEOuf/0HgNO9bWjU9AL?=
 =?us-ascii?Q?Ok6dCdAMEEi/6SSyNJUM42T7ne+hNwjKwovwgIDlSaJak29475HbrsOyCAUY?=
 =?us-ascii?Q?iO4tsBpcYhcWFtrB9FEWJxysNldBKmzdZZdltFW0G/0Xd7XFzFhZD7+5WNUQ?=
 =?us-ascii?Q?aKmq0Tu/KrBuq/kwDEEMFQJZszDdDjqrP5Y+HUfMHKixS+U6X1jfGlrtMjeA?=
 =?us-ascii?Q?n+93z/kBLSXbBU3GY/FScySWuZoQCs4lSYoCqWUbsMU580Li0aU288cP98km?=
 =?us-ascii?Q?TnnuVOnfZkPPhPIvqux1zgDLLWWyQ1pBnE88mUcdeOx+csbP0DEtvhhwEk0Y?=
 =?us-ascii?Q?ictDMEpdz2bCqtZKwDOptUQ6QzSy7e8cwZxUC9i6JSDu4e8XX4u2WU3EGIor?=
 =?us-ascii?Q?AdIlFcvLW1DStde7F9qbTlZuWecJZIsErJRPpcwu1zcOQZRbZKZMV00eadjT?=
 =?us-ascii?Q?mPMNnOmnn+gHQe6J0nwAV9CGtF/We+O3zLnyTznO8VoMv36jxKKriPekjqCx?=
 =?us-ascii?Q?nigEYh3spm7WUMNbjk0bGt2Kjfk+cAedTZvRolHIof3sRtuibLkZ+QVGNKMb?=
 =?us-ascii?Q?413T626WgVUguB6cWXUnlBpq0gyMl1y/C4p+weJ5AOUHGpKG07NLc5Hu+u6X?=
 =?us-ascii?Q?E+/QRbQzc1EsAhwRaZ2HRq9oH4QdhFBYoMKYKfefUkKahGwvLDhQ3qVYuzg9?=
 =?us-ascii?Q?Xlu5mi6NTdhny8N4b1tqra3v1WNykjpTXVq5WKDmrAPwoVrwr99K7UrrSsOj?=
 =?us-ascii?Q?dTAU/PniCcADKwiyYhjOok5Ea7Dd5Wk17gAsoUV82FViNQEKXB7bbQjz68Vj?=
 =?us-ascii?Q?e5aak5dBgqISS5DWsGhyLlhWEIodyiCvqkj7BbuDz6B92GncHSr7J7hJrFRV?=
 =?us-ascii?Q?oR7JkZjjNlwJ0HpMoRg506/cr5E9XQkc6hZhLOj5COBlj4P4Eh4b18EvXniY?=
 =?us-ascii?Q?2fryotyYqQokZ5FEhkGerdh+zg0wntEbt9ZPPhjiHGP8LyKIEpodxwmNkIKW?=
 =?us-ascii?Q?XIFRAKGU+zAZ6mg8F0pmBiI7HfI1mMBrAo65l7412YYIS+wYHgy4srvx6ZNq?=
 =?us-ascii?Q?n4cK0OpNRblqUZcF5DHUoUL0HtfyVWgufryBdnA3QiblPX1q9yJsSCd0RfYr?=
 =?us-ascii?Q?fIHvmpM4yWpgkAR3TA0hWqUs0jwhU2Tq7napdhm2IU/Md/Xa9MSNfuJce6Ah?=
 =?us-ascii?Q?lGa1fghs3l2gb8Q8TvE/chgygwWa0XhFEzRf5JjKbw1PXFUDHdHzmJr6ojM9?=
 =?us-ascii?Q?T0C+S9KHg6pa6gy8keOSgqOUt7mLrrFmRfBZkKz9tgR4oWG2/LrEZkERMkk4?=
 =?us-ascii?Q?hosFzZPu00Kdb8T4MScLR2UHu8sJLldEro4LwgucJ3Htc/BwOnQKKpgKZA1a?=
 =?us-ascii?Q?rf9UV+OiZclbvo7FlqmgPU+i3X4OihvUpNkKBF+zZJkd7TkBDjJ5?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 8adfb41b-2fd9-412b-9954-08de5e855951
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 15:53:15.6495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lppdKXMEmAyJRvBlpi4E0GWAuWA35cuQAfQxylcb5Ld2khiY46dQsxmvDt632A8uCI+3CxDqqjW3Ii8Yixh4gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2627

On Thu, Jan 08, 2026 at 03:57:30PM +0900, Koichiro Den wrote:
> On Tue, Dec 02, 2025 at 04:23:41PM +0900, Koichiro Den wrote:
> > The vNTB endpoint function (pci-epf-vntb) can be configured and reconfigured
> > through configfs (link/unlink functions, start/stop the controller, update
> > parameters). In practice, several pitfalls present: double-unmapping when two
> > windows share a BAR, wrong parameter order in .drop_link leading to wrong
> > object lookups, duplicate EPC teardown that leads to oopses, a work item
> > running after resources were torn down, and inability to re-link/restart
> > fundamentally because ntb_dev was embedded and the vPCI bus teardown was
> > incomplete.
> > 
> > This series addresses those issues and hardens resource management across NTB
> > EPF and PCI EP core:
> > 
> > - Avoid double iounmap when PEER_SPAD and CONFIG share the same BAR.
> > - Fix configfs .drop_link parameter order so the correct groups are used during
> >   unlink.
> > - Remove duplicate EPC resource teardown in both pci-epf-vntb and pci-epf-ntb,
> >   avoiding crashes on .allow_link failures and during .drop_link.
> > - Stop the delayed cmd_handler work before clearing BARs/doorbells.
> > - Manage ntb_dev as a devm-managed allocation and implement .remove() in the
> >   vNTB PCI driver. Switch to pci_scan_root_bus().
> > 
> > With these changes, the controller can now be stopped, a function unlinked,
> > configfs settings updated, and the controller re-linked and restarted
> > without rebooting the endpoint, as long as the underlying pci_epc_ops
> > .stop() is non-destructive and .start() restores normal operation.
> > 
> > Patches 1-5 carry Fixes tags and are candidates for stable.
> > Patch 6 is a preparatory one for Patch 7.
> > Patch 7 is a behavioral improvement that completes lifetime management for
> > relink/restart scenarios.
> > 
> > 
> > v3->v4 changes:
> >   - Added Reviewed-by tag for [PATCH v3 6/6].
> >   - Corrected patch split by moving the blank-line cleanup,
> >     based on the feedback from Frank.
> >   (No code changes overall.)
> > v2->v3 changes:
> >   - Added Reviewed-by tag for [PATCH v2 4/6].
> >   - Split [PATCH v2 6/6] into two, based on the feedback from Frank.
> >   (No code changes overall.)
> > v1->v2 changes:
> >   - Incorporated feedback from Frank.
> >   - Added Reviewed-by tags (except for patches #4 and #6).
> >   - Fixed a typo in patch #5 title.
> >   (No code changes overall.)
> > 
> > v3: https://lore.kernel.org/all/20251130151100.2591822-1-den@valinux.co.jp/
> > v2: https://lore.kernel.org/all/20251029080321.807943-1-den@valinux.co.jp/
> > v1: https://lore.kernel.org/all/20251023071757.901181-1-den@valinux.co.jp/
> > 
> > 
> > Koichiro Den (7):
> >   NTB: epf: Avoid pci_iounmap() with offset when PEER_SPAD and CONFIG
> >     share BAR
> >   PCI: endpoint: Fix parameter order for .drop_link
> >   PCI: endpoint: pci-epf-vntb: Remove duplicate resource teardown
> >   PCI: endpoint: pci-epf-ntb: Remove duplicate resource teardown
> >   NTB: epf: vntb: Stop cmd_handler work in epf_ntb_epc_cleanup
> >   PCI: endpoint: pci-epf-vntb: Switch vpci_scan_bus() to use
> >     pci_scan_root_bus()
> >   PCI: endpoint: pci-epf-vntb: manage ntb_dev lifetime and fix vpci bus
> >     teardown
> > 
> >  drivers/ntb/hw/epf/ntb_hw_epf.c               |  3 +-
> >  drivers/pci/endpoint/functions/pci-epf-ntb.c  | 56 +-----------
> >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 86 ++++++++++++-------
> >  drivers/pci/endpoint/pci-ep-cfs.c             |  8 +-
> >  4 files changed, 62 insertions(+), 91 deletions(-)
> 
> Dear NTB and PCI endpoint maintainers,
> 
> I suspect this series may have been confusing because it mixed patches
> targeting both NTB and PCI endpoint subsystems.
> 
> Should I re-submit [PATCH v4 2/7], which touches
> drivers/pci/endpoint/pci-ep-cfs.c separately to the linux-pci mailing
> list, and re-submit the rest of the patches to the NTB mailing list?
> 
> Any guidance would be appreciated.

Hi Jon, Dave, Allen,

Sorry for the ping.

Regarding the earlier question about splitting the series, [PATCH v4 2/7]
is no longer needed, as an identical fix has already been merged recently:
https://lore.kernel.org/linux-pci/20260108062747.1870669-1-mmaddireddy@nvidia.com/

That leaves the remaining patches as NTB-focused changes.

Could you please take a look at the rest of the series when you have a
chance? Any feedback would be much appreciated.

Kind regards,
Koichiro

> 
> Thanks,
> Koichiro
> 
> > 
> > -- 
> > 2.48.1
> > 
