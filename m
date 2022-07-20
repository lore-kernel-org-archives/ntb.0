Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6636D17
	for <ntb@lists.linux.dev>; Wed, 20 Jul 2022 18:28:41 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26KGd4XA003962;
	Wed, 20 Jul 2022 18:28:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=/G8aYNx7HvqQM2hAP6Ve8lTBGl3zMqw4oSRNyUH0INg=;
 b=G5mRD2FC4R6Sh1b2mV8+B2g6yHZGonrCMmO1EZIB+wfhR+lwgL7PuiRxzPr72kWtFXY6
 ee0j6BIcOVt/FJbCXgz/TPbOnvOkaNbogg7JBFO/mpEK+l+a2cIxGC4IkHIlIue1sB0x
 vghqBgOwX3LyT8wpk8ME0+Eh7kxKqKS7UBrK4yloXvJWqKBoYkwzc0Jp9k1UTxcoZ2M/
 igB7GcnrCQWAtOccJ2jHptffMpYBp/zV4FKJ0jSKFtVaavvhZuyfVfq59buREhlL23nO
 uQtBmLtKBp8940bAAsPgLHv6/lFOZ4h74Yg98TmPfmKOmN2ZwQJkK0WBF2TmmurtEQXt 9A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkx12gme-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Jul 2022 18:28:31 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26KGX5YX002792;
	Wed, 20 Jul 2022 18:28:29 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1mc9qyp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Jul 2022 18:28:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3DyGZLnYTmz0aSbM7NWubYdfu94dky9JjVLSgKREmoxU8zxnLhOX7zcW7d2r3u09VYTV8qj/TarhixRsPz+CUX5We0RBWF+dFSFrjGhGLCEAqBQ14vOC7DSQRILsA502CKLAGCTJ2uINjs/aKHn7gj+Eqs/3JDfCu4T8xNmFWe9pQHC26n6F+XoEqY9tcHBWiJwyV2c5YOhR3wRdImKcT7P545hqocNNIimTV3OTRZ3usIEY9dhKA/SsyWt4UjMBWVuBDln0/Wqu/kYX12D9Hmin+59VZ5c3CRdwRDYTVzFJ7C7v5whoc8oA3NyanqiOu8i9gkga61cTIBi5rr1EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/G8aYNx7HvqQM2hAP6Ve8lTBGl3zMqw4oSRNyUH0INg=;
 b=jsceVqJdbSWnRYBcvNn1A+JMXnDSWwjOopzK/uw0VlY0tmycnOvg2jziFfuF6yCITuROkrAzJGSLSQKYl2qQrRXVNdtqrqqwa3nR9MWI1UXDvxQrHQLRVGyakGJ0FH+auiii+0ljR4BR7f+BddIQpzVnIWy9zm9Sugbtv1VJu9m/h2gEiaM3ZJ7s55Fe7blZYPonEL1+vX+SOtQ02PLDBwrwepIaFQ9Gyt0SPywe1+YGZ7WDolbhDzRC0Uc4/dOWqLMANN3HUMUqGkqBNCZTFpPjMyVt/fZGJN6I5mtMQaiZaUVKauyPDbBuThsCgrc5mUfTni0fBLkoEsu4tsbmTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/G8aYNx7HvqQM2hAP6Ve8lTBGl3zMqw4oSRNyUH0INg=;
 b=owCGol155pm5WDSkwyKQVsTwqw/WN1a4xezkVI9Ay+/CpPDft/KZ4qboNMlO5H4LMWbS2sLptBbVlbqq8T8RX9TyN2jOIQy7fSoq+gmu5JkMhkgBNXlcgSb3nDvKs3KEHHWZvADyS+jrVKJfY5aNyzwPStS+iSj5g0fzS8w0e+M=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SJ0PR10MB4526.namprd10.prod.outlook.com
 (2603:10b6:a03:2d6::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Wed, 20 Jul
 2022 18:28:27 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::24dc:9f9a:c139:5c97%4]) with mapi id 15.20.5458.018; Wed, 20 Jul 2022
 18:28:27 +0000
Date: Wed, 20 Jul 2022 21:28:18 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>
Cc: Dave Jiang <dave.jiang@intel.com>, ntb@lists.linux.dev,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] NTB: ntb_tool: uninitialized heap data in tool_fn_write()
Message-ID: <YthJQqfMCb47jHbG@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0033.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::20) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ea9b53d-6014-4b97-90f5-08da6a7da384
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4526:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	rAG5cZBVIDZR7wGhtUrsdmEx7YW7yzTBsD9xwTaIjcgnyoDTCuEu/2DTf1oT5qPobQuTLsJ1iOeadZYMo1tBN89zWMOu6KnqHkTa+AULq7XOS4hyInNxKKe2OtCAOfQTV9RN5jD/+eAm9gmqXsp22gvB2eyL0wStGdvcciAz/aTB4BfWXiuJhDdT9k9FmS1n3wVeclCB1Ze2KmdbbMuss3UfEGgUz5H9WLTcUnebIIjcaLVf3np6F15pa4bKSFYpBYyPisSF11mPFBShlJe3R/hmhXxsW8aoNSn3TW8yRFsHobqyO+Cfj3Y/kgM5Aj4rs9eFZiQ3m1DsRocgBjyzL5YCa6XvezZEokqxz/b0w9jR9gIl15secMuv2M3yvBTzoODsDeahQlPtMLCaJ9XWvStVw2ZOQHzwCFk3ICkfioFJJk2JaeQul3YqqOfma/+36uOFMXr+DwhrXluM6wtCgjny/HthG9DOvCFkfukyjvDEMCuR9YEf9jtMCz7HFsqxLwojo0HX91Dqrh0tWTkFmPyGEvX2yzmj8hKGuMrowGvL/qWh+byxei12TShLdBlHCkhlgpoPxwdS4fmw/bElVGYLT32cTMCWSuefJX5VwlNBpRBHg2MkCEzwpbodswX5U9CBM8GKUh9eRq9cW4nMg7MENxrKwdCLavvHmaaVukYLcgco33CP9zft5pK6dhMfl8sY0ni6mTuYWECnGt48dQ9857QwrXj1BQwukYXM/D5Hz/LpOk+74Lf9ScDQeeBd+uo3Sm/bvb5IG3CyIvBRqREFf0hINYRizh2MdBuhh9A=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(396003)(376002)(346002)(136003)(366004)(38100700002)(5660300002)(8936002)(38350700002)(6512007)(26005)(6666004)(9686003)(316002)(110136005)(6506007)(6486002)(478600001)(52116002)(41300700001)(83380400001)(8676002)(186003)(2906002)(33716001)(66946007)(66476007)(44832011)(86362001)(66556008)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?BvOux+9vZg8dP4Kwt62NaBW5xFilpLozAaw5o3rvevQBNYT4QSecIYUD1zyP?=
 =?us-ascii?Q?WSAu1NnZnk29ZTp00REMtMNsW0qxn8pYOInQO02g8oOgmk9EzHE1nIejIN9+?=
 =?us-ascii?Q?S5Tj27enim/oh7gOlt36Xs5BQ0m52VV8RqDLKOXCHcgBSEfOa9aFzpjlyrq/?=
 =?us-ascii?Q?zMFOLr1+WZ1XCdIvCHdGPEkKDzXO2vWu1d1tLhWLs8USRGvVjmaOmBsZnMys?=
 =?us-ascii?Q?pNmr99ppaElHaqvWvU8Lv6a9Z78zO6SkKr5yfK+S0FhwX9pBqVopK6KBrDQI?=
 =?us-ascii?Q?ySTujf/+TscB1Qp1PfptF99+MQCHFth3VwIjjujwyBhhTkUhSpzC3EhiB5Rw?=
 =?us-ascii?Q?5q8Edvqmm1MGFfY2wBaLNHPS5DF1NGu/b40RAsdNhajjpvz6RIasd5aThnCx?=
 =?us-ascii?Q?TvH6veTkE4mJQoQwRueQE2rrZ/jlgO873DLV+kvvMY+vVvzMl2V3ncvASGN5?=
 =?us-ascii?Q?kmsV+ndLk7rVDz30OOonjNdCBRKd5197eVqXC2ZZiG69VHC/NoZp8p2+BRnp?=
 =?us-ascii?Q?LrtfmsTIveTr290ighBO8EIENv+oGjnclFGplke5dlv9fde0dO60KG7LfHnC?=
 =?us-ascii?Q?eV3OFWoEJN9NPwlS9JY8DjrZyZKPYGP8DbeSFbiZVmjQhzG4D6fKhUtBuNvB?=
 =?us-ascii?Q?bOBWZXvoAqezwfMIX/81m7piuE00LiLRfax7Lxb6VtqJc9VGOJ9rF91UAbel?=
 =?us-ascii?Q?qMhF2Kof8opAuVB5tvoNQpuRL+osU9bTdfueX/nJ8hAHDL+BHqB/9k0E8Xb8?=
 =?us-ascii?Q?aM/IMQtye81h06GOs4oAEAQjv3IA2sEZgV1kwZbdYB3794jHQawEVhhm1+og?=
 =?us-ascii?Q?8J1OhcEmfoBnhJvK5kGDE3UAHohoJpqkzWBOJ/L2y0ETTzNC5U9Ul1CJgHyt?=
 =?us-ascii?Q?2W5JxWimQd85i/1ttNfzSgY5Q/QvP6abnH/OeB0ffFSbNsxcCEanq+bcVr/Z?=
 =?us-ascii?Q?ZFywfB2uAH77kgygohVMjd2rI/TF5bvjz7RAMYVHviiH10BKsj/ehc9IvCZy?=
 =?us-ascii?Q?RWe2RCkhoeV6E9xy+yrGyYbhz7eIsBUL0Tjno0Y9QpRfWn4DKgXHHCozN2eP?=
 =?us-ascii?Q?H6yZ+OI+pxMlXp2JbRW61SfKAIlRvV4acAKDqJ3wsQwNU9u/i++qGK9vT8VC?=
 =?us-ascii?Q?5iyDX06aZdB7zvp/Ku5u6ZblpmpQOUnOxGqPjY76nZw44YteXQzoMOMjLdH1?=
 =?us-ascii?Q?NoIGEnX/V3PSJOQoIPocGFzcJiNVyfGzoGrVLllgE0FY9GiMmmt7SCSwIA7Q?=
 =?us-ascii?Q?e5t9MUgsDo8VuWr0JuPlLZ26eMfgkWd63FP0jMYK/cUXOnEW+D70EhruuHCB?=
 =?us-ascii?Q?BHZzLlhAZXmLK206sEYdbbRkWJerzirXTYbXtOIL7V/ZcyZrXOW3j9LPt2fo?=
 =?us-ascii?Q?Uns7nc0eOI3avOGPhMLdoewaTbFdcGaa2mbQ+exrg1GGkyiz8HABjZKpcjCa?=
 =?us-ascii?Q?gRhHQVVG3jU+CF2KFNwgZw9q67wgGC++6ex5NDCIryEXepP3Iu9LCmArLpIb?=
 =?us-ascii?Q?sx8Bx+097UXPPQCRnF3/cB8ZFjItREUsLRL0Taua9kb/yxEqaxMsbGzsmNAa?=
 =?us-ascii?Q?puwO810Jypav6ZU5pH9Y8j4cWJOSsVICB68KJhPr1xtjS6plxj7jxkWzfN+8?=
 =?us-ascii?Q?Cw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ea9b53d-6014-4b97-90f5-08da6a7da384
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 18:28:27.6301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B8bzwCBOo6fHyuyscGY8OgNHbar/Kdx7jVaslBMm8rFzb/b5xmeesRbJQhkcqbTEfm3+MomIb7m9HHDt1aSzt+BXaZQ/+Wi1f1OwrmfAHc4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4526
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-20_12,2022-07-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200075
X-Proofpoint-GUID: wCZhuwVDrJMyjtnNY6Ayap0TtwbaJ_w-
X-Proofpoint-ORIG-GUID: wCZhuwVDrJMyjtnNY6Ayap0TtwbaJ_w-

The call to:

	ret = simple_write_to_buffer(buf, size, offp, ubuf, size);

will return success if it is able to write even one byte to "buf".
The value of "*offp" controls which byte.  This could result in
reading uninitialized data when we do the sscanf() on the next line.

This code is not really desigined to handle partial writes where
*offp is non-zero and the "buf" is preserved and re-used between writes.
Just ban partial writes and replace the simple_write_to_buffer() with
copy_from_user().

Fixes: 578b881ba9c4 ("NTB: Add tool test client")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/ntb/test/ntb_tool.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
index b7bf3f863d79..5ee0afa621a9 100644
--- a/drivers/ntb/test/ntb_tool.c
+++ b/drivers/ntb/test/ntb_tool.c
@@ -367,14 +367,16 @@ static ssize_t tool_fn_write(struct tool_ctx *tc,
 	u64 bits;
 	int n;
 
+	if (*offp)
+		return 0;
+
 	buf = kmalloc(size + 1, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
-	ret = simple_write_to_buffer(buf, size, offp, ubuf, size);
-	if (ret < 0) {
+	if (copy_from_user(buf, ubuf, size)) {
 		kfree(buf);
-		return ret;
+		return -EFAULT;
 	}
 
 	buf[size] = 0;
-- 
2.35.1

