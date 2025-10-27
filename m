Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010004.outbound.protection.outlook.com [52.101.229.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B63F30E82B
	for <ntb@lists.linux.dev>; Mon, 27 Oct 2025 00:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761525825; cv=fail; b=ELDP5hv+m3iVxRj7N9trEdOm/fFi2IqqBkHK8ZVWgL8rkkVns+eFbPOgqc9W2698n6zLvga/TupYFX2USMiaPKH5a4XimrzW7Yb94/MwXCt0LYJ3rEd8TA92zgF+IEzLSsyd+ksib2oY5FRU253V4gYFdKsZkonugnHd55f7XSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761525825; c=relaxed/simple;
	bh=W38PhgoS7uPLwVb/qcb4qzJ5B9MH7l8ib7uACT3AQWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=smeCt1rp1DbYKaiVeUR14Yr3Trxw0GFNtU84c+ktWC1HhAR2Miw7tOZGEDy0kOwhr9ppBzVFWn2P+DoW1RDTjAblm2DV5YE5nmxS8vwQnR03dyU2iI7rirheeQI+aIQqpgXM4r+o02zV/B/bkKee33DjBf864hPOHdQv7IQtvMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=r5yGRWay; arc=fail smtp.client-ip=52.101.229.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="r5yGRWay"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fmGbq1J+STjSseDDtePIf4GR89Rlccs7vaI2pa4OPVphLq4diDaOqx3RS2vMQd+yds/M5j0L5lwHpxJZAjbFZ5U8n1cZQ6N/t9wOqdfwZOqKoCx/7Nc4Nf+FS3JeITukhnkWfzEiK8dn3lb6EaFjFVJh8Qwnsd6HERPzuPALnOFc0nPhd4/fd21Do+Rqb+eJIUVfEw96F22Byzg2npswD0Eq74FrHHJXCyggWoSXBQg3Cd9Oy/VNnpjjKRbmtIPkmLMJYQRtMGLxzuJhgLELE5zEm+cyxFDUDtTBAXXiALbQ95P8Rsq0cbmfUTEI0KBpQbO/ouEdrLB4FJ+p29wP8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8aP1OkHraJPd9pyLmS5msj0JExDdKyzQ0ug2My4kKA=;
 b=LQlNt9vjGtVjwDpxhJYqqRTpJ+Y9BrXIQma9x2Hv2KYbQAVdazeCYf9UIYDIoxVhYtt47477iNQCTr4Hx63HEQRN6K8gkffGmVp3GGuF2GO1/osHtTAPYeKXGhUCkTUBbLFQMYhgypOU1oZho0pIQAaLk/BXG9z5a9B9tKz6iKsTINLlaqJTxwhyLfgNhrCnffc06VZVeQeO/+AlKm/PuCErMlFZpmyRJdieEpWkO0QKZiZ7gTr3FquvEGia8c60ITmCggDyQQzAki4LluyHOwmb17goNGzRqN165Uc5DX4cQTJS6Qqx+V9ix3rgluuqI8KB63V0kv04MJtubT4O3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8aP1OkHraJPd9pyLmS5msj0JExDdKyzQ0ug2My4kKA=;
 b=r5yGRWaya+yS7+TOtJ9iLdAith1cpzHcUoYLKombLUyUMjE20kEEC46/zKGMQPZP4KZDVQ2tdb+mS/CRtbFcJRYXZ0j5Zl9F5zBsDA69+dwfo1Y9Fk+nl2DpUHw9xRrKfTIdr+PDdzjMFOoYSoF6ySefPgnJRcDKjXyNh3gbHR0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10d::7)
 by TYTP286MB3461.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:39f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 00:43:38 +0000
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a]) by OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a%5]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 00:43:38 +0000
From: Koichiro Den <den@valinux.co.jp>
To: ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com
Subject: [PATCH 2/4] NTB: ntb_transport: Ack DMA memcpy descriptors to avoid wait-list growth
Date: Mon, 27 Oct 2025 09:43:29 +0900
Message-ID: <20251027004331.562345-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251027004331.562345-1-den@valinux.co.jp>
References: <20251027004331.562345-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0080.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36d::12) To OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:10d::7)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0979:EE_|TYTP286MB3461:EE_
X-MS-Office365-Filtering-Correlation-Id: 33186b7b-60cf-4736-1a43-08de14f1de83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SPLQsJohazRkh2E4PkNANrn2HfGwXOsDmke4azDeqPxJQa2nvywjcntgbt57?=
 =?us-ascii?Q?QaX4VmiB+ocSOKMKnEu9lQTyFw2tzpLvg8v5H1tA/yZTVeYLnNO8+xv5ZSIU?=
 =?us-ascii?Q?tqDWo+uLPtRaIXPmrCk8SVvLboPyoN1/0XN+gIbsyTGUa7Z2pfsso08lDbxR?=
 =?us-ascii?Q?xNGvYqtzGue7RbA7T/5tV34l0inHJ+crlSK370PL1c1YfCl+FqOb++iNot+u?=
 =?us-ascii?Q?PE9xhYFXkVTm/gu2CNmXojPW3zHTNvrEO9BxTi+rA12dvqu9APvk/WtrZb5p?=
 =?us-ascii?Q?K5cpHNHOQi+H11dPNDrpWCRU6bO1qNBzBTKmvE3+JPVatNdPFZoQg3/xnEAW?=
 =?us-ascii?Q?HNs4YoF2NR6cDoCLUgvxQ5hGhy0wVx5kHoWlZUwFzjAWlK0QzzuXuEv6XPW2?=
 =?us-ascii?Q?1DRtiazcndCFY3NpWkHRQIDalKoDEo7NQ4mYZuTdlA+Gk/pG0O8fHgAoi5m8?=
 =?us-ascii?Q?ZBjO0bCvD7C8Iw4pEsObQyze1fXggAuXH9daGUGYTUkR2htMaFMmJi0ixgIg?=
 =?us-ascii?Q?3l6UentgL8NXrsmHWNOV+MCh/UPWzaoPv0oCYbuqHCmW5BbNUzpXTsckwL4g?=
 =?us-ascii?Q?mY4s2dkFbpS18SoaILzawQWBBJL1YkwDoy43zX7zY9qXUC6ju3/5BXXactyF?=
 =?us-ascii?Q?XxJS8htiYRAZbP7loDdvNUhdtlxJz4STfHO3oyFc8ka9ThqVzcJokqjr31Ir?=
 =?us-ascii?Q?Rsr1yuQqNginEbkPzDsl3J7D1w4nUpQ9aVpui44MED2wVly0EWRYdf91CasT?=
 =?us-ascii?Q?elfeLcKosdqrie4ri3e2t6xRK2g/uF0lVKX+fy/AbnnHX/ZXsWyslXgT6pjf?=
 =?us-ascii?Q?gFnD2wDat/oQ6nvsqvABRPjJ2p4r8poc50Ps4OmSDy7JVkZYrM+/yRCwifAh?=
 =?us-ascii?Q?5K44nGJtO2UYxpQhJ/URNncnXnmzFGRi5HPSa/zIBHQt35Xq+N4bqNzOAOF/?=
 =?us-ascii?Q?BlRrsy33dUbk4mHwWOMsRHoq1LAcqMqnyRR87Zpzk1K/pvE7hpgYKOvYkIJV?=
 =?us-ascii?Q?t8XF9cBP0MsuwObUiSBbTS7JX3rTdyV6YtSvQJ8zcp8XLA7rwCyH4Sv1BSCq?=
 =?us-ascii?Q?V1j0MSTeGAj0TUETlkWBJRIj/ZuC2OuHcEGbOKjhtjD6lBXLQPtVSjYDKehG?=
 =?us-ascii?Q?tkP2j7cR0AH45AEMAdG/Ugxw+PVsKErL40KW2BZIKQsUMx4levf1wKXxPDGT?=
 =?us-ascii?Q?11d+b/4V11iSPOxWmL6aMQJM3V5tbONMIhWDMa8OWZ9S5ZMgksfGNxLhUlpd?=
 =?us-ascii?Q?ElFs+t1tjQAG9bmqP+umNERhrRwK0mO018k3i20ldVkQonNfS47GPFXXL+Jv?=
 =?us-ascii?Q?FVMBwj0HlP6XNanVg1ylhgZrNWeTXcgZ9oKfrxEEVjH7X9kr6SBPRT/1hVRB?=
 =?us-ascii?Q?DPjrBrFO97s9sFa3yx8ikg2xqZfgb5T72Os/5JiJR8GJPqxwfom4p7kmowE8?=
 =?us-ascii?Q?3W4beJYh+9I4udmpyFhuRFxud5kZuy4j?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jVRlPT0kEvc7YkITr5/AwArPVurZhvBPIeRMmN7J8HOV26h9/0sRqm00smwh?=
 =?us-ascii?Q?PSrgTD/sXgZZlLPBJHk4j8wfSoL4Ild7inF6WRAOaMNeO6yxkp98k0Y9m8iy?=
 =?us-ascii?Q?8AMGpZuz24Ex/4lIrvqNHGxOXmlzuEwJ80DCnKGi8SxJLVTGWa9yqgdmBdLz?=
 =?us-ascii?Q?r0SAOHDvW1HhxJOK5ZxOBlY/yiPLyMVfGgQ7sQCIJk0Y/9SOSHtlqRQj4jx1?=
 =?us-ascii?Q?5xj5YjS+lQQieouU5xHtdlWi0TEGna/frL4r/4Fe+Oz6YdH92mestT6V2h5o?=
 =?us-ascii?Q?cEfJs3bIPyQVav4VT5PmVsImjblUvTZ38qkHJJpOJa56Ahfi+IqLNd7TnwMe?=
 =?us-ascii?Q?r0Pnd4p0I3kAbeV5mPnic5pfneyfqf9VB92FNIawBia4J5rHWhVQO6IN0IUI?=
 =?us-ascii?Q?t345piqK8sgUu5kM2oSNf2IFRrNNEoObTsDXD1lk304alRG+tRR7P8nmKkqP?=
 =?us-ascii?Q?YCqMmvEeb/n/UV+kZ5cOCvo8PrgLaBZ6tdbth7o/keo61zstqwTG56ulel0a?=
 =?us-ascii?Q?UaQdJI1BVCg2xWTlYp8LWCFezNHXTug+dt652iROTr8bYKWU5afxbnn/hURq?=
 =?us-ascii?Q?el0AESKy3fwZTvT2+Ml1Co+fXOlWzj3Wx+ug4guUz1YCCZbnRU476Ak3ZBb2?=
 =?us-ascii?Q?s5Y4NkPFfD8mmFy4ZnoWGhltsejda5nvQWpXYg+7hbXMO4XIt/AgyMqbmEQk?=
 =?us-ascii?Q?VWJu0iUA+0dh0SNPBHTMkwtJK4gaCtOZnabAuZcCKy1qQZm2OSaHr1v6ja6r?=
 =?us-ascii?Q?mDHnN0CW/j6xVxUoq1P276ztrkjv91+Uv3lyNaAQ3+cMD0Nve6YGh2FFFGUQ?=
 =?us-ascii?Q?Bk23ZpQC5vDeWOQ+kpZ4HormQ2hGj7gthkmpZX6c62L7i30FZwISllYG0i/y?=
 =?us-ascii?Q?LRw3AgTispfSYjw6czL4dnY1mvKD4cFg5df5aiLHoFf84LKQ6xZhYTvXEfIO?=
 =?us-ascii?Q?R+LycNv4LCcTrPs1V3chIH9OkgpxVPU2E3pQTCIn3ddoZVuym9Iwz20tvaGG?=
 =?us-ascii?Q?E5f7LFBNLNI6rZxNnSyzv8HElpguVX3bx8tvjpxtCJnVJo8mtenXgsMD+Qs6?=
 =?us-ascii?Q?WMy3qCTrRF5nEiLjXO+bvzGOZqKa2pPX9JkVmnGjCRlFdq2c3GnxmY91DUUb?=
 =?us-ascii?Q?oePDobRxG00ZT9B6emj3cDGgNBYoZbyBBmd+CcfVzfCrZEvIStYpF+AUTSyd?=
 =?us-ascii?Q?wXu7EOkIrO0vIhOzJ78BV1z+5ye01t3uffNaNQjK8QRbiIBm+SbrkacN909t?=
 =?us-ascii?Q?/PGsmuA3vsgXzVGcFOXrZ2MXKoaPIGVrvLeVQhrCVFegNGZ1gbnjSfRvbLpq?=
 =?us-ascii?Q?CfefVUB1G8SJQfZD2ldQk3GQpWYgaJr4cVslssvayzoI8iH5U6WvtZ1sjTNh?=
 =?us-ascii?Q?OfhvNwdVZvG2bKKNQ3ul5KyNCrfVwqsIHHH3ak5YY0W14IShlM+oa6gl4EuQ?=
 =?us-ascii?Q?gfpSzUcjEHdlxkl0Hmkdv5U07DGEFl9EYQu4woi4oBfNzI410om1tSH4mVHU?=
 =?us-ascii?Q?Bxwf/rBQwPq2e3+8Nvbl12X6r3lzVaUxsgC5S4zMF0AvRVycI2KylNGI085Z?=
 =?us-ascii?Q?rvwOikezhklTbvw9RbkXHlHKeOIOX/bPHDYv+neM+jUOpQuKrg1TFhzCt1Q8?=
 =?us-ascii?Q?rPN00/JiD8LxZsTTsz3lSR0=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 33186b7b-60cf-4736-1a43-08de14f1de83
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 00:43:38.7076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W3p5wI0fKIFWZRPeJd/YCkNdJbh6/WbAaRbiUQ79lIsok2BQsRo4U1MwDKhahZTLGerC6XIb/UCtFvqimwx1aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTP286MB3461

ntb_transport prepares DMA memcpy transactions but never acks the
descriptors afterwards. On dmaengines that honor the ACK semantics
(e.g. rcar-dmac), completed descriptors are moved to the 'wait' list
and only recycled once they are ACK-ed. Since ntb_transport does not
chain, inspect residue, or retain transaction descriptors after
completion, we can mark them as ACK-ed at prep time.

Set DMA_CTRL_ACK when preparing RX/TX memcpy transfers so that the
engine can immediately recycle descriptors after completion. This
prevents unbounded growth of the wait list, which was observed on R-Car
S4 (rcar-dmac). Engines that ignore ACK or auto-recycle descriptors are
unaffected.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/ntb_transport.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index b9f9d2e0feb3..a447eca27d0f 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1591,7 +1591,7 @@ static int ntb_async_rx_submit(struct ntb_queue_entry *entry, void *offset)
 
 	txd = device->device_prep_dma_memcpy(chan, unmap->addr[1],
 					     unmap->addr[0], len,
-					     DMA_PREP_INTERRUPT);
+					     DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!txd)
 		goto err_get_unmap;
 
@@ -1864,7 +1864,7 @@ static int ntb_async_tx_submit(struct ntb_transport_qp *qp,
 	unmap->to_cnt = 1;
 
 	txd = device->device_prep_dma_memcpy(chan, dest, unmap->addr[0], len,
-					     DMA_PREP_INTERRUPT);
+					     DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!txd)
 		goto err_get_unmap;
 
-- 
2.48.1

