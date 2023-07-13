Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2111.outbound.protection.outlook.com [40.107.255.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B7C6117
	for <ntb@lists.linux.dev>; Thu, 13 Jul 2023 07:23:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CAEKu4yJL1NS1p/oT04hVm0WchasuVULmTOxGeZ8JoJuSlvhOMP/7JlWdMsXQ9iva7gDhLzHqmbgK3mjEasSKRZ+U/tpopJT2+Lf97WmYItO/QXUQbDlMCUWMv/S2pAO7fcSq3TkafqW2HonKWl3ZFmLJlXSwZEPJ+2TW59F5eSATnXDTk7ZemeOcKkRi+53qVIm/upKcRII6Z8RZ0OgdQvxozIktVh8eHGJQq50PBTCVEfVP5sZmG42pOaXemBHZBEiNJrdHAEmU4ppPEYWwXHgL2Q9ie9TH4dzzqItx6HL+ksaZ/d5kFUHgRPWNt4vr2Z/Wjm5HG53a7DFDhHkrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kcwPfOi354SF9BzhSZx/EdFUOR8owm+7KmG1rH0qOjM=;
 b=QvI6Fbn+bsMPJAjPD/ylp4J8YCGEOTfMmmFkKg9XjfEy3ElkQI1t2NWBa/ixSWJOQAKxxAfcMbYv1SfWJO9UzasvPjWdRJCBMnwXM5Xkwx2cbK2hiI8unY53Vk/hl5AB6cJBNqW+gGgKC9LFvep/P6nIpkT2ssxmHiQhLA8Uu8D+rugxG3QxL+divyoGnX9Q7rV50nicyk6bFgA82SyTbbuRvqNn7KWK6gckSAmbY6bzcS+ZPytATA+RH8+c9qkEArK6rd4/uIdqZ/1Ti2MKxfqXOTd0vQoN3POwGNz8yzxJ9zokWLutgOSVhWlN8i6/WPnokcwJKZO+Aqawjzfh9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcwPfOi354SF9BzhSZx/EdFUOR8owm+7KmG1rH0qOjM=;
 b=cxnIrdry2fabp5OfJiOfEx/6laPnBnICzbMR3DXt24Rm+MQgfI1eQ4ltn3+ioMb9lcaSgWLsoaiJKcifUFXUM8HAOyDOvBDw30JkDYzDl708OYWpZLlsvDqKIXp7Z7qoHk8+TRqu24gvlCR4IV21NzGP5n0fw0gnlqu2RHmJYUzQas52ys6cXgbtP1gdxd+wP584YeSkmG7e/VJdbbrsOKwVHLnFoMIrA6f/JFdMxfuDBZpRCfTVD4sY8S6R4Jtb8gNIF4rCB7f8FVOEF5NE+EXE3ehfx4wS3D1bnx5Z/z1SqWETRd97uvRRN2VAGQsNC/Izx1pTFi8wFT7MEg30+w==
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 TYSPR06MB6503.apcprd06.prod.outlook.com (2603:1096:400:474::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Thu, 13 Jul
 2023 07:23:30 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c%4]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 07:23:30 +0000
From: =?utf-8?B?546L5piOLei9r+S7tuW6leWxguaKgOacr+mDqA==?= <machel@vivo.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen
 Hubbe <allenbh@gmail.com>, Serge Semin <fancer.lancer@gmail.com>, Dan
 Carpenter <error27@gmail.com>, Jiasheng Jiang <jiasheng@iscas.ac.cn>,
	"ntb@lists.linux.dev" <ntb@lists.linux.dev>, LKML
	<linux-kernel@vger.kernel.org>, opensource.kernel
	<opensource.kernel@vivo.com>
Subject:
 =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtQQVRDSCB2Ml0gbnRiOkZpeCBhbiBOVUxMIHZz?=
 =?utf-8?B?IElTX0VSUigpIGJ1ZyBmb3IgZGVidWdmc19jcmVhdGVfZGlyKCkgaW4gdG9v?=
 =?utf-8?B?bF9zZXR1cF9kYmdmcygp?=
Thread-Topic:
 =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjJdIG50YjpGaXggYW4gTlVMTCB2cyBJU19FUlIo?=
 =?utf-8?B?KSBidWcgZm9yIGRlYnVnZnNfY3JlYXRlX2RpcigpIGluIHRvb2xfc2V0dXBf?=
 =?utf-8?Q?dbgfs()?=
Thread-Index: AQHZtL4dMS6BpVxUPEicb8lfnJmazK+2JiwAgADO/iCAAD/1AIAAAFbw
Date: Thu, 13 Jul 2023 07:23:29 +0000
Message-ID:
 <SG2PR06MB3743FE0EB3FE1D3FE2D2FD44BD37A@SG2PR06MB3743.apcprd06.prod.outlook.com>
References: <20230712124035.7981-1-machel@vivo.com>
 <138ab604-27de-4ac6-88fb-0886ee8f6b6d@kadam.mountain>
 <SG2PR06MB3743C36C711A4801F4CE2304BD37A@SG2PR06MB3743.apcprd06.prod.outlook.com>
 <bc1efd80-a490-4037-9e83-e0bb5cc0cb47@kadam.mountain>
In-Reply-To: <bc1efd80-a490-4037-9e83-e0bb5cc0cb47@kadam.mountain>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR06MB3743:EE_|TYSPR06MB6503:EE_
x-ms-office365-filtering-correlation-id: 33dc32c2-b73b-4a98-d1a0-08db83720eac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 AFRXERSD9JVyDbyvuHXPjJE2RgG4dQLdCW/SSSZM5lhCRzJPKtl6te1hjjx15u0biuIUDOy6l8Wxdv4RzbibsWS9slFsJ/U/dju/mC/YWbDWiu/jrvS2lXdC3UzlZf2JT9131PvnNN6Z+y/w1YladXo3QKzavhuiF0gw3aOZOLQdKE//rYJh7uuVinX8Iydm7gNyvw1DNI3q7QY/5gvWQ2lYc3puhMNa1YqlwSYdcnNhGmwF5wO9brYWHliL8lJhu7c4f4zib40jmahR5rxQd9srj21zAofXbDbKItHWVPEq6UkAX6kz1axhnhe7DyS+Ex+25R9aAtziV61ddfPlJYfOM/EwGcLm7g7vzazC6Y5j7JPO6vZrbbNLXcEsE1vuCyAaSqHEN2PAGkcyqYaNeIi+t72uDQMrhJQTlfk87k7AZhVHVyq+XELBGjn5MfMUBt9smpLx6jQQBzHbwCWRU+VNIrpL12x1ux8QRqRxEoeXxmiNXrNvKQmAtD7YnHIWHWuC5d6XYM7EcNG7fcWgvbvqlhIEkUTKL1FTjabjOaN9+MYaoWFnhiJnJVxuuwlO02YeaV9V8f8hpyid0AF/27lowexZt0E7JVJHEAGGlmSgSXRtTCS3dFELtU8UopCk
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(451199021)(9686003)(41300700001)(52536014)(122000001)(38100700002)(55016003)(26005)(186003)(107886003)(2906002)(33656002)(5660300002)(8936002)(478600001)(224303003)(66556008)(85182001)(66476007)(71200400001)(6916009)(7696005)(64756008)(38070700005)(4326008)(66446008)(76116006)(66946007)(86362001)(54906003)(316002)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U1JIR3Z5NlJLak1lVVd1eVBmbnFDTlFsUXQxa1dESVZoUzc2em1jTjBURTlC?=
 =?utf-8?B?U08rQWRTcDN6aSttMzVuVWV0WWV1TXJmTEIzdVJBckxTc2I2ZW5NRkwydUcy?=
 =?utf-8?B?R0UxWmRNc0dNWUlwbE1aNHUzSW5zZk1tMW8rUlE3VGFaQS9kODJTUFJwTlpu?=
 =?utf-8?B?cGdoVHkvMHlNMlJiNUxQRk8vY2NncFlLNjZYaHNUQTJWczc1Zm41cnlsTDQv?=
 =?utf-8?B?Yyt6QzZENUROMlZqVjJKdTRnWDYyNjFzOVFQa1VWa0FoSURNOTVnbzhZNlE0?=
 =?utf-8?B?anFXdnBLQjZ3elVqR2JSdHo3Y3V1VFdUdmVqYy9CcjlLSkhCRDMyRnlwdDdr?=
 =?utf-8?B?cTVUZ1pZQnV0S1ZhRGgwcE1UZDVhbVdyRk1BalVLTEpCcE9uREY4Y1dPQW40?=
 =?utf-8?B?ZFdsUXFpNWtBNmRRdDhqMEI0akVDTklrdjAzdlhkcXVDY3FDaWxPZmpjckJM?=
 =?utf-8?B?QkNhRFRIZkRrVXNEREtRTkh2emJvMTRWc2RWNUFKRmFoVUNKR0lGZ24vYjZS?=
 =?utf-8?B?NStzeE5UVXNoZSt4SWFDK1pMMTFDN2ZsRFJLdzZZRkRDdDcxZ2JFYzdFa2tu?=
 =?utf-8?B?WlZEQUliMzVzUFcweGF3OHUvOWhPdlkveGtVZTNUZ1VOTW04Znd4dEVXNWRM?=
 =?utf-8?B?QWMvTWRtYzYvd0xKbmdZWVYzbDJrWmZTN0QxdERpWk5IRGp4M1hqajB2Z3Np?=
 =?utf-8?B?cnk3WnoreDRyVEJZcW51QkRtVjV5N0tuY0ZzUTc4d2wzL3ZUQVhKQnlJWGg0?=
 =?utf-8?B?eERCUTFIOTFNSzRCU3lURVNNRFZvZ3NTODJZRXE3RStpNUs5TWtQQmpjL3V0?=
 =?utf-8?B?NzY2eFFHQzNhcGxRSEZyUnE4U2pjRHREanYxQWlueWpVU3pxYTMranlnVWVE?=
 =?utf-8?B?bloxSzRmYnVodXRvUTJSMjJxS2dXWmNmZ0lGWkQ5RnViaHdwazB1aCs0Y3ow?=
 =?utf-8?B?NktrNzFZTnB2M3BTTEpvL0cweURYbkUwNEM0WitVYkhJNHBWc1NoRndpYmhD?=
 =?utf-8?B?RWNSUkFKN01YTFNLb1RiMWVGVXlaMU9GWHgrdEhnZmx5VGZ4WG5HeUlieUg1?=
 =?utf-8?B?M3BBajFKZFlTcHZ3eWtZaWtoZGFuSEkyY0I2QXpPREpvcTZDTlJaYlU4U0pr?=
 =?utf-8?B?dThhM3E1OVJJQVhoMUlrdjJ4REJWWTN3Q0srZy9iSkpGSk1xNXE2bTlRQTJy?=
 =?utf-8?B?cG5wdXNMUDJtczhBaE53SzZYc0FEanZXQ3VrNlp5Y0tjNTJoNDFQbGcrOVVa?=
 =?utf-8?B?amovVnhIRlpYazBBYWE3d3pNWEtVekVMd002enNwb0duTmxoUS9hdU9zOUVn?=
 =?utf-8?B?dW1ubGF6ZUltYU5KeWpzRVl3MndKSUl0azVvM0xvc1Q1RDNHNFJsR1JqK09J?=
 =?utf-8?B?b1hxakNzcWFKTkUwK1hJT2dxbUxSeThlbjZ6ZFpXWmsrcjR0Qm9sTHhWM3g5?=
 =?utf-8?B?S01qdlFBYjdhNnFjQU9GaHFWRU9Ma05LOW5oVitvZHN4N2Vzak5xRnl2UU05?=
 =?utf-8?B?MHd6QllwcFFqOGh3VDVWQmNxZkZ5eEMzbTI3YlBRb0JmZmF6RXg5RFAyWWts?=
 =?utf-8?B?MkJPbmZVenNLV0Y5OGFtQTltbjJzb0lrU1NWOE11K3R3NE5VdmFsZS9aMXcx?=
 =?utf-8?B?WkUxTnlyWWhxSDFKQlUvc3pBVHhBT0QzOGNhU3hVdTE2U0RaVDlOOGVDd21v?=
 =?utf-8?B?aCtMZHhNQ3k1MzZFUDJvSVhGT3VuTjVVVks0Vy80emwvMEJ3LzdaRGZIVkNH?=
 =?utf-8?B?ZlBFdWx5eWVLNlExZGZQVnUrK2w1OEszR3VLZDJIYlovUHhEdFkySGo2QmRX?=
 =?utf-8?B?SEpiazNwaUJocXdOV3hhQlpzdURwS0hLcUFGQ2VvakYxTHRCMFlaUC9RY1Nh?=
 =?utf-8?B?dW9KejRCaW9OZE9NWGpLSXNPUnkwYUI3WndBK2N3TUdNdkR6SE4rdThjWXln?=
 =?utf-8?B?M0J5N21Nb1dwRzZVNSs4bHhmWDFnQUN0cWpsZlpBSzF6Y25UandPLzVOM2tz?=
 =?utf-8?B?cFJnUFd2UGVqZWJGV1ZvU3VvZDZMTmlIMW5YR0RLWlR3TjQwVVkvT3hiMWpG?=
 =?utf-8?B?Z2NKMG5KUzc1bzZZc3VndWwwaFR0WlhWMk00MnZwc01nUWxwN2kxbWRUZHc0?=
 =?utf-8?Q?9fGE=3D?=
Content-Type: text/plain; charset="utf-8"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 33dc32c2-b73b-4a98-d1a0-08db83720eac
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2023 07:23:29.8413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kw/aoBes6SiZ5vmrf/BKrAtTATUQEZMtptqgGosxl8WsloszsjYJW7KKiWYOtpimpqUSqz7RPvwB0IA1jCWRBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6503

SGkgRGFuIENhcnBlbnRlcg0KDQpUaGFuayB5b3UgZm9yIHlvdXIgZ3VpZGFuY2UgdG8gbWUgZXZl
cnkgdGltZS4gSSB3aWxsIHN1Ym1pdCBpdCBhZ2Fpbi4gVGhhbmsgeW91IHZlcnkgbXVjaA0KDQpy
ZWdhcmRzLA0KTWluZw0KDQotLS0tLemCruS7tuWOn+S7ti0tLS0tDQrlj5Hku7bkuro6IERhbiBD
YXJwZW50ZXIgPGRhbi5jYXJwZW50ZXJAbGluYXJvLm9yZz4gDQrlj5HpgIHml7bpl7Q6IDIwMjPl
ubQ35pyIMTPml6UgMTQ6MDANCuaUtuS7tuS6ujog546L5piOLei9r+S7tuW6leWxguaKgOacr+mD
qCA8bWFjaGVsQHZpdm8uY29tPg0K5oqE6YCBOiBKb24gTWFzb24gPGpkbWFzb25Aa3VkenUudXM+
OyBEYXZlIEppYW5nIDxkYXZlLmppYW5nQGludGVsLmNvbT47IEFsbGVuIEh1YmJlIDxhbGxlbmJo
QGdtYWlsLmNvbT47IFNlcmdlIFNlbWluIDxmYW5jZXIubGFuY2VyQGdtYWlsLmNvbT47IERhbiBD
YXJwZW50ZXIgPGVycm9yMjdAZ21haWwuY29tPjsgSmlhc2hlbmcgSmlhbmcgPGppYXNoZW5nQGlz
Y2FzLmFjLmNuPjsgbnRiQGxpc3RzLmxpbnV4LmRldjsgTEtNTCA8bGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZz47IG9wZW5zb3VyY2Uua2VybmVsIDxvcGVuc291cmNlLmtlcm5lbEB2aXZvLmNv
bT4NCuS4u+mimDogUmU6IOWbnuWkjTogW1BBVENIIHYyXSBudGI6Rml4IGFuIE5VTEwgdnMgSVNf
RVJSKCkgYnVnIGZvciBkZWJ1Z2ZzX2NyZWF0ZV9kaXIoKSBpbiB0b29sX3NldHVwX2RiZ2ZzKCkN
Cg0KT24gVGh1LCBKdWwgMTMsIDIwMjMgYXQgMDI6MTM6MzJBTSArMDAwMCwg546L5piOLei9r+S7
tuW6leWxguaKgOacr+mDqCB3cm90ZToNCj4gSGkgZGFuIGNhcnBlbnRlcg0KPiBZb3UgbWVhbiB0
aGF0IHRoaXMgbW9kaWZpY2F0aW9uIGlzIGNvcnJlY3QsIGJ1dCB0aGVyZSBpcyBubyBuZWVkIHRv
IGRvIA0KPiBzbywgaXMgdGhhdCB0aGUgdW5kZXJzdGFuZGluZz8NCg0KTm8sIHRoaXMgcGF0Y2gg
aXMgd3JvbmcuICBQb3NzaWJseSBoYXJtbGVzcywgcG9zc2libHkgaGFybWZ1bCBidXQgZWl0aGVy
IHdheSBpdCBpcyB3cm9uZy4gIFRoZSBjb3JyZWN0IHdheSBpczoNCg0KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbnRiL3Rlc3QvbnRiX3Rvb2wuYyBiL2RyaXZlcnMvbnRiL3Rlc3QvbnRiX3Rvb2wuYyBp
bmRleCBlZWViNGIxYzk3ZDIuLmUwYWNjMTFkMjliYSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbnRi
L3Rlc3QvbnRiX3Rvb2wuYw0KKysrIGIvZHJpdmVycy9udGIvdGVzdC9udGJfdG9vbC5jDQpAQCAt
MTQ5NSw4ICsxNDk1LDYgQEAgc3RhdGljIHZvaWQgdG9vbF9zZXR1cF9kYmdmcyhzdHJ1Y3QgdG9v
bF9jdHggKnRjKQ0KIA0KIAl0Yy0+ZGJnZnNfZGlyID0gZGVidWdmc19jcmVhdGVfZGlyKGRldl9u
YW1lKCZ0Yy0+bnRiLT5kZXYpLA0KIAkJCQkJICAgdG9vbF9kYmdmc190b3BkaXIpOw0KLQlpZiAo
IXRjLT5kYmdmc19kaXIpDQotCQlyZXR1cm47DQogDQogCWRlYnVnZnNfY3JlYXRlX2ZpbGUoInBv
cnQiLCAwNjAwLCB0Yy0+ZGJnZnNfZGlyLA0KIAkJCSAgICB0YywgJnRvb2xfcG9ydF9mb3BzKTsN
Cg==
