Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021112.outbound.protection.outlook.com [40.107.74.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1930639EF20
	for <ntb@lists.linux.dev>; Mon,  7 Sep 2026 14:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788791089; cv=fail; b=UmzZ2g/9j+SivQ08L2eUQBoXvxJenKZvR1nLECZyOfu+C8r3ZMuyqMk9JJpM3ZyANBUaN48hKXPMQhd3rhypisNNkZSOI+nD74JiAdFcaSYDHsV+YA7KvFqDooXinhPnfXQJCI6dxCtRekqUubWFS9EUg9LCJXv+TLHChRnvD0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788791089; c=relaxed/simple;
	bh=a1yoYUjDU86ggTIZNRjqtMjm3gRqZ0MyyIVA6j5DDpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n2Z4B/61rVwOazO0kO3FjRdrMHyuUIK1pyEDXIM4nEeV6Qikz2mtgNFkLaqJuDgRzHdytGvwoLhx8WN2WTIqZHDhYBj5RsbhkJRt2HDd3/2YwBU1DY2K97LfE+4C2xZMtetadNS40uXnKR+MLLCA0mXMvcg/G0FQRClOkIdFfcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=tvqA1GJU; arc=fail smtp.client-ip=40.107.74.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="tvqA1GJU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uacp1xiO1Qs4pWJSi+YNRau/eWL2pK1XKAjsZmMCE+hi80ta6KLBnMI+P2aN9G5xDt5HsZ5RQg4+zyU8nKOZfgV0Rng8i1ntOUSOPX9WDwAYIKykdleWy+V3i6G01ZXydaZ0gXoM2KF09zEudfqVeGCm+ieOp+TURe2m2PJ7ASKN5nHGDQfQpr7A9i70o6hPihxETwid0qqa5toRV97n7EVYc1QtYoiVHqwXIMO/9yNp1PiXTFmCpsGaN0admruCeQHf8HdnoLvPGdfrkEJRuNFp20IfY43tKi/53vCAb+yqA/OfhtVWWuatz3q6TNVb0PrVRgSHY9qmt/9VhOb+yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tWQyI3C8GWdLz3kHXqT7hPuKG0xH1fhOOA/oUwnsl/4=;
 b=dx0SDveWdP0gAr5F2rSfRXitf1hnllnoziADHJ9bnOPckODdFjb/M2rVUBoSArBWSCj4tot5SkilW2JxZusEDX1QdXIYmNOp4o9cJD7nnErzx5SMCVSs92YyeTTdl2aXe91Ef399SfxquJ8PS3ePG2lXALpyKeAmB2T+2aohAqWuNpTj5jtdXA4CMeyIZxb5TLXTRFxojh8SccGx+2L4vi05fmaXpyq5VNoRYpu5vas2zfwbPZCMT1jI0iyY0VCvb8yDebrqxFmrbRrZa+gkZQwotemkgUCo8n5ag36Rf5tyO/FxhC+Kl6JcjoVwIaUuZPTcxblRnUQrCryAG3Oy9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWQyI3C8GWdLz3kHXqT7hPuKG0xH1fhOOA/oUwnsl/4=;
 b=tvqA1GJUYat86x/Swj3jnkAt6hn74qc/keuWKlMZxvelQy6Sddb6QE+mRkvr9TbALHUxJ4DmDLUVsOumFshlMgUEShRc9iIORKEsKVW/RG6P/WXfGpPgBRv8BEthInILGj7G3HE4XXWy4R9AMQCHy7iQW7c/E4gl9ogszeMoUow=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY4P286MB7581.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:34e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 14:24:43 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 14:24:43 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>
Cc: Frank Li <Frank.Li@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	fuyuanli <fuyuanli0722@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nicholas Bellinger <nab@linux-iscsi.org>,
	Joey Zhang <joey.zhang@microchip.com>,
	ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] NTB: ntb_transport: Remove the device debugfs directory
Date: Mon,  7 Sep 2026 23:24:19 +0900
Message-ID: <20260907142429.951930-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260907142429.951930-1-den@valinux.co.jp>
References: <20260907142429.951930-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0122.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::11) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY4P286MB7581:EE_
X-MS-Office365-Filtering-Correlation-Id: 690525d9-087d-4e68-b24b-08df0cebc2a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|10070799003|10067099003|56012099006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rZ2tjUvMCb1uLSUYxBV2MggNBScsG5FeUYwkfACKtelsCgmx+Om2XXwUvB7kiw4wX4SmdPO4aPRKv7NsXLEm09ddHTzIe580dR1ElzdN+Dxxjmq+8fVMPpvsnbJ1QttrOKjp8zjNvIEfOUF+Hz7JPs314o3wgG7RzHA50se+k+WMGq8lIOoDLWgN3MjwvE9N2o5xYefYlIgH1p4K+wZYzhw75DyXktrtoXr0ffbECK1+xFT4O+8atzY8XvFSulf65UYxItSLqXURt2m0c/IL0rIbbk94NzABkzyybDuEsl2qq1enfpSlzIwDqwKaIRhgSrlcZwqGkwFSWqUyi/MZRyiZX/Z3EHtntYWuO1eUsBPbnFX0JVAG3GXQydbU+CN1lme1/y9NZCLUUsKMUPyHffZtJMoD0ZKJm2Lx4tROmTQ9C+TYOdSkK9yJbD7KVNSj8ZbLn29irSGoTtrKOtMfiPaAkjmzjv8Rv5W36jq9XsCs0QhPHCn9a7ATTELyP4YitG6IODzcVYTFpc7NDOsnAeOKl3nfr0DgVlXzuXbTucSYmiNV6IDESNYTFhP6tIj6IoR2UBV4ne6S99EssBC5j46H9Zo0RxeHVdQw3eeBBnnyMJbbs3OqKxKo1pYxC466J2HlupFBTjzBn5iZSSQDIvGv3EO4It/C2y1gEkieRUY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(10070799003)(10067099003)(56012099006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8XrzE8vCEo4YFJwjDKkp1KauhDLwnVFaXTxx9san65wQhpGb/FhGJGuNl2eB?=
 =?us-ascii?Q?edbwYZ5cDXQGOFfpzaJBY244OM2HrqFh64i/UcjIxnKxMj/J+08YViHUmxJg?=
 =?us-ascii?Q?MNxATp3uJeo0PNEZBIfwodsBW6xd5m7635yUCKxpXpmDlzGJ8yuEabbk3ukg?=
 =?us-ascii?Q?20wlmX4Pg08jd7rZgjd4+8V/nYEtXwHqNW9HFa9kzGKdsc30LWTsTa1iQrl9?=
 =?us-ascii?Q?NQzup60ywKniOLmPQPnOmFjjlGeBt0SmPoD/8DSQLv34uXcj/fmgUzOto7go?=
 =?us-ascii?Q?nt02Ha9rq+pYDx5VYcCwi6eW0qfZ438CZv21RyyxaaW/5gHMRZXrjeqpZk4s?=
 =?us-ascii?Q?FBW3QQ1tIMebf2PBeARq8qmq5Eg0/deBUxaw3s69LZIyKG4+jH61DOGjW8Op?=
 =?us-ascii?Q?g3IggA3fA7qe0/a3uryZuJS0RJbzIFmqeV+PYNccXwKgJVu92EslU0Tsu/rW?=
 =?us-ascii?Q?ED0XARz54Qo9p9z0/Xyj5cxe2zuKWRAtpAYEABxhcetsGUJ0NjGCEDjfDXjp?=
 =?us-ascii?Q?hvoaNGJgSH5uxDurfSsiEu+AdwEU4mdYUD8KsXLupke94LL5lL2qSnx+yyPY?=
 =?us-ascii?Q?obvj48056qZNFovPWB/qj9gJo3kP1YKLEG/pV6YKWpdSuSnAPAR9q23Uhicl?=
 =?us-ascii?Q?SMGatVwristxpuhE32mA1aUFaQCI6mvofcisB14ywRqeG19OQakfW1tRPSGP?=
 =?us-ascii?Q?JXvUbYV5XHEtFWVGnGmntnztHkzbpaA+EDtppx+x/dTsZw43DS8FgYjVTUCo?=
 =?us-ascii?Q?F3zmVvLoR4j/paDL5s+PguT7QMqHZqo67Ra4md0HSzy/kjmBgup7dNdVZLO5?=
 =?us-ascii?Q?gK6haGW2Oy+SZMXmB5u6L8JUXk9bNPDrIdSVffPlwxRqOq7mRZIj+Pmcc8r/?=
 =?us-ascii?Q?vJ74M9sJAD9DFoO1L++2TW8qkuN/sJIZ9/kkhtWh+0/TL9cjVvt1NCIJpgrP?=
 =?us-ascii?Q?dOjHQL+BNKW6ffYBPa55EZ2wrSOFGkAb28mXAMHTrP3EvZOeDSqMoBauS5YL?=
 =?us-ascii?Q?4IzDj57Qo8k/6WVi5PFFroiR5P68avA2Nlbn/Sk0hoJBkFYMTcDAd1yz1nu1?=
 =?us-ascii?Q?xSoCX3u10+4+QoOnYfZAncJadRm8XAqimFxbDc6q20z2Kz3tLTULv/BxPY9l?=
 =?us-ascii?Q?TXj4z6LfTTM8QUWqdMlxjOt3tT6h1iNukSq+bbCI/gb11wuydF3nw4y7NXqW?=
 =?us-ascii?Q?WY8uh70o+gyrWUJzre//HcDjwspaJ2UFfijg4R55QIzOTubUfdAU/AsWsuPV?=
 =?us-ascii?Q?ZvXXpq/wyUIKRsu56YryiZ2ahMMLVmttmM6WYwU7vIbUgWvLKd9mubgVwKRC?=
 =?us-ascii?Q?N+QhE9WyLh9m6xfafytE5Ae4WjBVCYulogfsDhq2EgFlULIaDcmW/Mv1vsAk?=
 =?us-ascii?Q?A7p3m57NK6tGRb2MHWGV2wSTMnLt6G0DCDwMuyhmLkcbizxKpYshpVRlKr2l?=
 =?us-ascii?Q?LNYX1yhPEf4dO24hU1ZEa1q7tIcBeXw78k9rufMpB6N7aoNkUpd5w7vR8b6D?=
 =?us-ascii?Q?JJhRhdY+cd3klCdjpkJyijoVr6U78wzuV5bsgUZGyvspUy6VAj6DLy84OqvG?=
 =?us-ascii?Q?O0Rj9lKY268FBWHzZyJweDiPNYdBro7A76L1JitZhHsXgS4mFpYtx9ijvNTD?=
 =?us-ascii?Q?UkpvCNItgl4DDEGx/yDU0vIrLnT5kPNEriukWC/srVFr5E6LbQgD+xjzfZUM?=
 =?us-ascii?Q?+9SUs+OrIHUTwEH6Q83HGm0cwa5809qdc6bFxSFkKcU7TKSewZSke/CP3gQw?=
 =?us-ascii?Q?Z1j+tJ0h5Vwku9ngU/SdidWl5JFFt6YHM2q5zDV/uj8QAfAJPH1N?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 690525d9-087d-4e68-b24b-08df0cebc2a7
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 14:24:43.3037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bLLB/uOSedKGT+lfn0yoHsDxPCe/NzpNfYQHAyyY9TYfsNmA3praB2s9tCqOeNpRdIXuJEgd1CDAZyEdEZuDrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB7581

ntb_transport_free() removes QP debugfs directories but leaves the
device directory. On rebind, debugfs_create_dir() fails with -EEXIST
and QP statistics files are not recreated. Module unload masks this
by removing the entire debugfs tree.

To reproduce:

  # ls /sys/kernel/debug/ntb_transport/0001:10:00.0/
  qp0
  # echo 0001:10:00.0 > /sys/bus/ntb/drivers/ntb_transport/unbind
  # ls /sys/kernel/debug/ntb_transport/
  0001:10:00.0   <-- should not remain
  # echo 0001:10:00.0 > /sys/bus/ntb/drivers/ntb_transport/bind

  .. and then dmesg shows:
  debugfs: '0001:10:00.0' already exists in 'ntb_transport'

  # ls /sys/kernel/debug/ntb_transport/0001:10:00.0/
  (nothing)      <-- should be 'qp0'

Remove the device debugfs tree on teardown and probe failure.

Verified that unbind removes the directory and rebind recreates qp0.

Fixes: c8650fd03d32 ("NTB: Fix transport stats for multiple devices")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/ntb_transport.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index f9caa1a653c5..3389d6ca9ebd 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1382,6 +1382,7 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 err3:
 	ntb_clear_ctx(ndev);
 err2:
+	debugfs_remove_recursive(nt->debugfs_node_dir);
 	kfree(nt->qp_vec);
 err1:
 	while (i--) {
@@ -1401,6 +1402,8 @@ static void ntb_transport_free(struct ntb_client *self, struct ntb_dev *ndev)
 	u64 qp_bitmap_alloc;
 	int i;
 
+	debugfs_remove_recursive(nt->debugfs_node_dir);
+
 	ntb_transport_link_cleanup(nt);
 	cancel_work_sync(&nt->link_cleanup);
 	cancel_delayed_work_sync(&nt->link_work);
@@ -1412,7 +1415,6 @@ static void ntb_transport_free(struct ntb_client *self, struct ntb_dev *ndev)
 		qp = &nt->qp_vec[i];
 		if (qp_bitmap_alloc & BIT_ULL(i))
 			ntb_transport_free_queue(qp);
-		debugfs_remove_recursive(qp->debugfs_dir);
 	}
 
 	ntb_link_disable(ndev);
-- 
2.51.0

