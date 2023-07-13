Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2110.outbound.protection.outlook.com [40.107.255.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55F110782
	for <ntb@lists.linux.dev>; Thu, 13 Jul 2023 10:07:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ge4hNoxXIHpVqqZ2fu8w6BM90KzdG17ustf6AJaw71hEYE5VGv9PxBjtdTUtVystzLBUuJrnOMozHtSS5qjXrNgg4eii+lUbHdmjchP3kMfHojmEcULMAWGvdetGtvMcIePY1CEHbnfrMcuQQ0YJ4/HlaBbIQ1sl3j6qkE8mSL1w4YDJUoeXtd3L9ZFQHXVmcdrLa6sj5kIsbhkGtyd4GS/0YX6maCQW/6pk7KC2aa+uJ7PssuyXiCV6N3NACG+BxHa2AgBzIGMm0IGOQs/IhoMXFq9IidNvK9rH5HHUJaqULFW1PqWlJHPfUl6x2MV+KD09K/+gmV0BguplSRd0kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d63QznjshA3+d7Cy7q4Gpwz1n+0sfT7EMr7oW1nHoTo=;
 b=bB8AhOlUEfYtCNJJK6HVTFfR+c6l/9Vhh08wujj7M/guYSD1fQXe6So9bdKraUt8feUhupiDgOLplfGdv9Sw1ZMvOjUbrN5zl6sJovChqHfXoog2XDSOHGKfhKPKMwI28ucgZsthvHDdK8lzguFa4nxHF3LtAApiBT1+5EqYgi1NUpiEHD8PmA6kl0DvDv1PDLMGe3iWu2UHsDOftbpecbjKRd2qfVrvZh5wQXtGx7UWVYlHKy7cZvZrpIfLjn4LPAoNkN2MPl1NOuUAxz67n9LmGYuMQFlKkhvFx6ArjNEaA0rR9b44bJZbI8izOlVmSmv7CRIjA5snmqAs8uuSpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d63QznjshA3+d7Cy7q4Gpwz1n+0sfT7EMr7oW1nHoTo=;
 b=WIMr0JRC/cIDWUQFGe/0VbjRIYwp+Z+ZlV3bRi+PjASrVshSBLtB36i8R6OZ10SrZQazbHSHMG4LfddathS1DbJMNl6ZzXFIThfDV8GCD4vUXcWvT7l9nWtXcoyJjAFB2P3QvfptY9/g+bvztaWQY/v1Cx6GorZ641Ck3Tezo96jJBo1tGjnrdSQAU3hSNxY9X2gz5RndGmFXHSt0TBK7y8VQdKtUBgXV135IQX/Wp8ydw4wsFvd+ONEZXVLt8TqWk7ONHZ/48XeT6veuSUi/bGWmZNRAYoUUlu32ZlDfCrGh4VuUkQ5kzAmFN3sCVGL9vNpBO/glymVkvC8xNM9Dg==
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 SI2PR06MB4505.apcprd06.prod.outlook.com (2603:1096:4:157::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.20; Thu, 13 Jul 2023 10:07:45 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c%4]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 10:07:45 +0000
From: =?gb2312?B?zfXD9y3I7bz+tdey47y8yvWyvw==?= <machel@vivo.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen
 Hubbe <allenbh@gmail.com>, Serge Semin <fancer.lancer@gmail.com>, Dan
 Carpenter <error27@gmail.com>, Jiasheng Jiang <jiasheng@iscas.ac.cn>,
	"ntb@lists.linux.dev" <ntb@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, opensource.kernel
	<opensource.kernel@vivo.com>
Subject:
 =?gb2312?B?u9i4tDogW1BBVENIIHYzXSAgbnRiOiBSZW1vdmUgZXJyb3IgY2hlY2tpbmcg?=
 =?gb2312?B?Zm9yIGRlYnVnZnNfY3JlYXRlX2Rpcigp?=
Thread-Topic: [PATCH v3]  ntb: Remove error checking for debugfs_create_dir()
Thread-Index: AQHZtWhImOK7AC8uvkKN3qJLUEWTCK+3bYkAgAAKhTA=
Date: Thu, 13 Jul 2023 10:07:45 +0000
Message-ID:
 <SG2PR06MB3743648B9D54AF2D6CB4229ABD37A@SG2PR06MB3743.apcprd06.prod.outlook.com>
References: <20230713085621.3380-1-machel@vivo.com>
 <2676117e-cbaf-4c4b-9197-91c796682859@kadam.mountain>
In-Reply-To: <2676117e-cbaf-4c4b-9197-91c796682859@kadam.mountain>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR06MB3743:EE_|SI2PR06MB4505:EE_
x-ms-office365-filtering-correlation-id: a3d52dcd-1076-4072-3560-08db838900fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 7NdWXbhZVJn8mRveB/2uOG4ZaTcIGNxKABu+3+cML68eDqnD/APnpPbzvzlDLmEGVyxEX+UNLI6sAyPsKVyUGjvC8hYKJzLeDy41Rb1ovoNKP3zkTs+I3xOgI5TVS3NNqgjM/TJJyPMJbb+Cd/74yhdlBZzFRtVnFxG7anvUDqoPXLItHpQVIwMRg3U284p9//YKnw0QSAC5bc5x9Teiw4txc71d9jpojge05R88tu2h3kd6qDELc3Ephg6sq1S64VbXgjVUwFGozxbl4V859DnLnhUgZv1eMbq89ZmfLE9mMG1Mxfy00NqNjRLw3pikYQfURLbWKbcHkjpYWXDcO+sj32+YLtyMjXZSi4qV9MmqtUpEd34Ze3KbbM8wbI4pFdsz9UoRIuzH97Nr5kCpxj1MiHflZ6X5D9MIW9FtNf3h8g0sbgcu0Gpi5yG1eZiUrx3pO0KiVfb0p4ogtCVwe314TzwgNdWlT7BbsTiuGo2X9vva4+KcyfrR6EY6sjaptDAjOKbvliyBODnUSKCovqQ+fItILhBlg37hsYv1tL1EczuqCUAtKB4zD8cDBUpkkC1wLGHd3i6jvhNO22C4Rl3sFpSs+JQyUja0np00wtnxspTO+XLbxGAHPsGSaPdO
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199021)(2906002)(55016003)(122000001)(38100700002)(107886003)(26005)(186003)(6506007)(86362001)(5660300002)(33656002)(52536014)(38070700005)(9686003)(85182001)(224303003)(8936002)(4744005)(478600001)(54906003)(71200400001)(7696005)(66556008)(66946007)(41300700001)(4326008)(64756008)(76116006)(316002)(66476007)(6916009)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?YVhrNEdJWVk4QUVWa0xhTjF1TFBVUnl2ZTFlN2x5NHpYWkhNY3E1NUl2aGF2?=
 =?gb2312?B?YlYxVDZRZzgvZ2lZRU90NXd5cTlCdzh1RENINmxYQWhQNHYyU1lrVFIraGM2?=
 =?gb2312?B?R1VVNDR3Z09rVEZ5MGhWY3NieGZYTHpzTjVtUUxRdjZ0ZTR5aU4xRllEQ3Nj?=
 =?gb2312?B?TGJ3OUxSZE9HMHhFcGpCMHVtSU5sOGtNLzhibnI4U251V3VuOG1BbHJUbUh2?=
 =?gb2312?B?bGl3bG0yL1FVVGFOdTdLSzFXdDNZMWxmRmJodmR5NUJTd1hPeUdXUnlSTkdu?=
 =?gb2312?B?OHU5T3FoWE9jTC82WE1lVjM3bjdwNStlZVgxQzFsbzZxY29Hb0hEWlhwdHcy?=
 =?gb2312?B?SW42NTNKOXRQa0x1OGkyNDdUSGE3cWRYeHRTWjRQUkc4UE9UWFYxTnZ3ejhC?=
 =?gb2312?B?MEZhcUZVTWVLS0xaeEU4bmJKbGlYZ2tvR0NzSUdQUHB4cGhkYko2cm9yNk5n?=
 =?gb2312?B?Z0R2OEZ1cWZlNEgvb0U2NTVpT2RXeS8ybUlDcXFHUjlyNnU1aEdDUnFzd1JI?=
 =?gb2312?B?VFlXMm5CV2k1ZGVnL2JpNERoaXB3cHU4aUp2aXkxaTYxZll1Z3crKzVLOWUz?=
 =?gb2312?B?ZENwM0VqVnNwSnRpVDQ1TG1XT3BJb05LSUpFNWN1Ynl1TkJiMlZ5aThMN1k4?=
 =?gb2312?B?U3k5clkzaVdqdys0bzZSTUZNV0FNL1VvNzloQlI2dkJKNjlCdVZSMUI5NG1D?=
 =?gb2312?B?RHBheTIwaHZkQ3B2RWZKQmxWSDhsTnFqd0FwNFFjenYwZUE5c1BuckhhNEtX?=
 =?gb2312?B?ZzFabmVHalRWUFdwMWJndXNYUnoyRDZMNkhyN2RpaUxxeVNlOGJUTUxkSFhZ?=
 =?gb2312?B?M1ByOWQ3RG1EQWZ0ZnQ4STNPd25JYU56dTVwRkFxNVBRRnkyMFk2blhRTXhq?=
 =?gb2312?B?LzRyc0ppbll3MkJkWVFwQ0hDdmtQVWt3UW5EcjF2Y2YxWW5PcitKS1lzSDNv?=
 =?gb2312?B?aUp4Zm9lUkRnaHhVVFJuTERqSEdrTXpqa2tXMHlNVWVNK2c1UnlpVmx6ZmxR?=
 =?gb2312?B?SEVIUnZnU2IwT1RjQ044T1FCcVRjekkreUt2MXQvS3pWRTBlMHB6c2d2S3Nn?=
 =?gb2312?B?QjFMUForSC9tU2xSN3Qya2kyckQ2bTI5U2hoYVgzLzBQdVFKT2lpWGNNRnpk?=
 =?gb2312?B?QVh2UWxna2Y5ZDlrUWdhSTU5d1I0Qjd4ZzZBRWpsZ3JOdCtMSTRZUXFtbXlv?=
 =?gb2312?B?ZmRtNlAvSDl1VlRXTXR2aU5WcTFldjJFR0pvRXRWeEliQlVxakZGS0VTek0y?=
 =?gb2312?B?RlpydGQ4aXcyN2liakVhZldZKzA3V05KRFloRmc4UXdyWS9xYlZsaDRCUHRa?=
 =?gb2312?B?WnorUzJvS0EwRHVVT2MwdTVBMThrbXFsbTVIcXVIQWZHN0NMTWJWVlppbFZ4?=
 =?gb2312?B?YTNYUkhGQTFaWlhqUm1vdjdqTzkzL0hraU5QQlBtdm50TlkrQ3pFM1JUN3I1?=
 =?gb2312?B?OVVYVGZLaU9JYVBrWkd6bG1YdFFLTUdHbmNSaTRtU2F4Y1FZYlU1TjJ1bHdL?=
 =?gb2312?B?MW1sVzIvNzRkWlZaRkt5cXV3TDV2eldLTXRQUyt6RVRUODZTWkg3OWNZUXdq?=
 =?gb2312?B?TzNyRFcxdlhTZWMrM1dDU0Z2RW5wSTRkTCt1c0VYRXNwd2JaZVRoenJGQUNq?=
 =?gb2312?B?N0QzMWtwd3FWbm01ZERyak1TQjhIRVdTQXMza1FqNEFsYVNDZm9HaXlZaXIr?=
 =?gb2312?B?a3hla2JEQlZ5bG55dEtJQmVhVFBPNVkvWXRhNEx5eXVYWS9vODVwOWxkRlU0?=
 =?gb2312?B?ZEhRS2NQZFhzVWpaZmVqdExKK0dQRWx4eXdTenJ5YzlKMHF3MllJNW1PM3o3?=
 =?gb2312?B?SzB0dEVZRWxQMFptaFNkNE54M2t2ZlFKSHV3VlJoc0d3UFdtby9PVllXWk9a?=
 =?gb2312?B?cVV3Vm1yc0JUaExSb2JYWEk1RHdsSGdxSk1qRkpqQWdvbVZleUhtYVNKTXha?=
 =?gb2312?B?OXB2d1pQSE1nM2twcEFoaDJxWGwwODdaRHRGUG9vc1NwWG55NG9DY2lrY0ZX?=
 =?gb2312?B?Z2RHdmtzTndSWHI3K05TazBHYWp2bmpBdStFV3hKQUJDUnBiaU1xV0NuT2VL?=
 =?gb2312?B?YzY0ZFRwMjJ6bkljd0o5RjJFSUtieGg2ZDlzZ3VianRyK0IyLytvY2tJbjhm?=
 =?gb2312?Q?BR8I=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3743.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3d52dcd-1076-4072-3560-08db838900fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2023 10:07:45.2779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bqo1vwpqzoJ10TCqjOC0L3TbN2i0VCxXCUkSrLJI6Iv9URAQlF92WrDV3fX9reGuoJexavU8pSNdfxu/mzhRww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4505

SGkgZGFuIGNhcnBlbnRlcg0KU29ycnkgdG8gYm90aGVyIHlvdSBhZ2FpbiwgSXMgdGhlcmUgYW55
dGhpbmcgd3Jvbmcgd2l0aCBteSBwYXRjaD8gQ2FuIHRoaXMgcGF0Y2ggYmUgYXBwbGllZD8NCg0K
U2luY2VyZSB0aGFua3MgdG8geW91LA0KV2FuZyBNaW5nDQoNCi0tLS0t08q8/tStvP4tLS0tLQ0K
t6K8/sjLOiBEYW4gQ2FycGVudGVyIDxkYW4uY2FycGVudGVyQGxpbmFyby5vcmc+IA0Kt6LLzcqx
vOQ6IDIwMjPE6jfUwjEzyNUgMTc6MjcNCsrVvP7IyzogzfXD9y3I7bz+tdey47y8yvWyvyA8bWFj
aGVsQHZpdm8uY29tPg0Ks63LzTogSm9uIE1hc29uIDxqZG1hc29uQGt1ZHp1LnVzPjsgRGF2ZSBK
aWFuZyA8ZGF2ZS5qaWFuZ0BpbnRlbC5jb20+OyBBbGxlbiBIdWJiZSA8YWxsZW5iaEBnbWFpbC5j
b20+OyBTZXJnZSBTZW1pbiA8ZmFuY2VyLmxhbmNlckBnbWFpbC5jb20+OyBEYW4gQ2FycGVudGVy
IDxlcnJvcjI3QGdtYWlsLmNvbT47IEppYXNoZW5nIEppYW5nIDxqaWFzaGVuZ0Bpc2Nhcy5hYy5j
bj47IG50YkBsaXN0cy5saW51eC5kZXY7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IG9w
ZW5zb3VyY2Uua2VybmVsIDxvcGVuc291cmNlLmtlcm5lbEB2aXZvLmNvbT4NCtb3zOI6IFJlOiBb
UEFUQ0ggdjNdIG50YjogUmVtb3ZlIGVycm9yIGNoZWNraW5nIGZvciBkZWJ1Z2ZzX2NyZWF0ZV9k
aXIoKQ0KDQpPbiBUaHUsIEp1bCAxMywgMjAyMyBhdCAwNDo1NjowNlBNICswODAwLCBXYW5nIE1p
bmcgd3JvdGU6DQo+IEl0IGlzIGV4cGVjdGVkIHRoYXQgbW9zdCBjYWxsZXJzIHNob3VsZCBfaWdu
b3JlXyB0aGUgZXJyb3JzIHJldHVybiBieSANCj4gZGVidWdmc19jcmVhdGVfZGlyKCkgaW4gdG9v
bF9zZXR1cF9kYmdmcygpDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBXYW5nIE1pbmcgPG1hY2hlbEB2
aXZvLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IERhbiBDYXJwZW50ZXIgPGRhbi5jYXJwZW50ZXJAbGlu
YXJvLm9yZz4NCg0KcmVnYXJkcywNCmRhbiBjYXJwZW50ZXINCg0K
