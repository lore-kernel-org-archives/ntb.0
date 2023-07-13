Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2097.outbound.protection.outlook.com [40.107.215.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5365F101E8
	for <ntb@lists.linux.dev>; Thu, 13 Jul 2023 10:23:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bmboq126jaZhbGrWPeWc3nT5Jr6kQTFqK1eOxThrxr9pbTDanTA0qdOz1uvej/u/7lIn3IWZqeSCuRMVtkO2r4P0A7WljHoR7r2K3lo9r/+TWKdGaji3cPPZlMZimjq6ehZpfg7kRwcPDXME15ps4Sxf6WuxDWU/8P7HKpWmaRKKSjtqreigiSQTUl+Q//cHBPCTfjf3xqFMO4YwcB65E544bBDCmOWuXCkZMypxJf9TXLgL8grvNGs86XiBJWLdQGgDer3nDqH/4FyiK9VBEM+Sj4SbB6HHvhJKwwrzh0TSuNGE5rBddlaGWmKs+dueLz6dMUFOPc3hpcWClT/sRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=papuCVJ1KhLkpA/mEk0sL1zm4jRWH+ZJKhLH2565vmI=;
 b=WS1aTdjflte4Phn4YRE30O/XHk+i1IKte8hH6fQe12Nif24YQWqByy+7O6L1o4MRg41I74ftOVJhQzDGPsOYwRCOBUvPZylubLEqRB++kRUmeKVgV92nWj4YNs2p5s8IItom4G6xAeIA8iFnkN6q6vID46uh7ayZxB/Arzva30D4e6XHRQuh4wrNXc3scJvlUv1Zf3NI6M5IwMqArEeEgGEt/j3t0viygHiZM6dl43dDskTscyYQ4KhPvNhzCFfWcK/EqrU9xXVoWSCCzXsaNMQ7QRwrLQZCkTo13ox1n/i0x1b716efaUQcif0Jscygyai+lz0VfoJsQ0yTA1QUMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=papuCVJ1KhLkpA/mEk0sL1zm4jRWH+ZJKhLH2565vmI=;
 b=AYy4g110p12XM6mlMEjwzhp3YdkTyGXG9htzEUOzJPbdkg2WOrNuKqF2vmpGWSPe0sqQ3R8FO+WWyXX4eCWsGkuHKtwHhleIkIX4BEdSY31Xa0/DUyQefWM5qcWbFCBASul8vtoHmH2nM46OYjQRIE0Yal3HPwTTy7lzB5CeXr+1Z/VpKVBbJZT+t8+o1EMgtmk6TmgUa4hOHaxij+kmRacOqzN+/K+uyqNIixVs3eEnhAKJHehtfuaRLRmFeqFKMSEGqzJYae2Y7S2ZN3Nvc1V3Uvg1OVhdqSzb+BarXEsKp7piY94VBsLnMiZ0JG2NAYJJXCjD84HhiATCiD6itw==
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 SEZPR06MB6207.apcprd06.prod.outlook.com (2603:1096:101:e8::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.20; Thu, 13 Jul 2023 10:23:02 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c%4]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 10:23:02 +0000
From: =?utf-8?B?546L5piOLei9r+S7tuW6leWxguaKgOacr+mDqA==?= <machel@vivo.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen
 Hubbe <allenbh@gmail.com>, Serge Semin <fancer.lancer@gmail.com>, Dan
 Carpenter <error27@gmail.com>, Jiasheng Jiang <jiasheng@iscas.ac.cn>,
	"ntb@lists.linux.dev" <ntb@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, opensource.kernel
	<opensource.kernel@vivo.com>, opensource.kernel <opensource.kernel@vivo.com>
Subject:
 =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtQQVRDSCB2M10gIG50YjogUmVtb3ZlIGVycm9y?=
 =?utf-8?B?IGNoZWNraW5nIGZvciBkZWJ1Z2ZzX2NyZWF0ZV9kaXIoKQ==?=
Thread-Topic:
 =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjNdICBudGI6IFJlbW92ZSBlcnJvciBjaGVja2lu?=
 =?utf-8?B?ZyBmb3IgZGVidWdmc19jcmVhdGVfZGlyKCk=?=
Thread-Index: AQHZtWhImOK7AC8uvkKN3qJLUEWTCK+3bYkAgAAKhTCAAAK6gIAAAfew
Date: Thu, 13 Jul 2023 10:23:02 +0000
Message-ID:
 <SG2PR06MB37438D680466D2EA7F5ECDE9BD37A@SG2PR06MB3743.apcprd06.prod.outlook.com>
References: <20230713085621.3380-1-machel@vivo.com>
 <2676117e-cbaf-4c4b-9197-91c796682859@kadam.mountain>
 <SG2PR06MB3743648B9D54AF2D6CB4229ABD37A@SG2PR06MB3743.apcprd06.prod.outlook.com>
 <090a0dd4-cbe4-4a9d-8074-7148d69ea72b@kadam.mountain>
In-Reply-To: <090a0dd4-cbe4-4a9d-8074-7148d69ea72b@kadam.mountain>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR06MB3743:EE_|SEZPR06MB6207:EE_
x-ms-office365-filtering-correlation-id: 993b644b-075c-4f4c-d79e-08db838b2399
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 OaEca8YlYTmA+79BZRUWC1pmXFR1QgCvCM1Clu2NuoJePUc0dqXLOHjE7T0dPtFCcvBZjNaxC8Nw2XEjcwz0+NONfYN5JDKFxpQ17eNjaeERliE+JtCbPRutTPCjxQyhAn52y5kzs32uzjrEVPDNrgF/54sMcPsOtAMVgYXheX9Bb7E98Ow2hOAhFNPcSMjbp8myNWyE9gcFc3aZ/x6HqI5mePT351H1f8y5OZpwsJ6O+jh+mYCTF3RXZbEkzr055nv4Noq0slsx5j+3h87xpIIy/pMTLJH5hQfQDDt1AhdvewxwGEIt8V9HEUgSo7CnHXQkyuxUWiUHc5XmUQsZOVVMdfxobq+Qa5CCug00Nz0x2Avb0vbyTAoa0VLdjYF0UU/NMaPpH+tJTVIfcHoItX8DYoxweEOYeJ+3baBUKhRUhhsQrE/A7Xs+x5xWqaQKTmJCtvQEErYB07upxVLrqMdgzSz92BPGS/TXNxHYqhS8p/334ug6mmDQhGvtIMrpn6FNrRlxG0+eFV2PoG3a1AUP1Z8KmUd0y0GCU+WXNF19rP6DE/ywNDNq8rFC+WcGmURcOb5uz6anM7YntYClUwMlHRbU2kSE93CK+V14qD1Fic69pJBJDWTQzBd/ZKo5
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(451199021)(85182001)(224303003)(55016003)(186003)(4744005)(26005)(2906002)(52536014)(5660300002)(6506007)(107886003)(71200400001)(478600001)(54906003)(41300700001)(316002)(9686003)(8936002)(66476007)(66446008)(66946007)(76116006)(66556008)(64756008)(6916009)(7696005)(4326008)(38070700005)(33656002)(86362001)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aWlybldSWXZ1dWNYbkxNNUY1TTdSdWZwZHdKYjNoRmdXK0JCMmlzS0Z6ZjZv?=
 =?utf-8?B?RnpXREVhME5xZ0hjejgyaDhIUGNmdlU3aEowNEcvWXBxOStiWHRKaXJnQnMx?=
 =?utf-8?B?RlZDMG16dzFKclR1NzREd1p3djc2UmgvakVMSlhFSjh1RWJQSTNDc3NObUNy?=
 =?utf-8?B?N3I4MkJONzNLQWt2V3BmN24zVlJRZldRTE41TVFUamtKWnFvbFoyMDROLzVU?=
 =?utf-8?B?TVd0R3lYdTlmTkR3aWhUUG5zM1NZSldpT2N0RUV2MDNxZUl2NWtHL1Z0MHJF?=
 =?utf-8?B?eVRuVUowQnNtczdqNENNc3BvQmxwMXpVK1luYUw2dks0ZmtXeHBzZVRrZThZ?=
 =?utf-8?B?QmpWWEVjOEJrY0libHM1L1lkVkVzTytrZjh3VUpiYVBFUXJ3bG9LWnVTNkkz?=
 =?utf-8?B?eXBPbS9rc3gxd1lndXQyNzBaZ2Fsbnlkd2UwOGRjUjFyVHltN0VYTjE3WTBi?=
 =?utf-8?B?NTloMXBUZlZyK1lIQWdPUVpoM0l1RWpsSzNaUU4rUFIwTTg1RmFaVEIxMlZM?=
 =?utf-8?B?VGdlMldNSUZhWk9SSEpaMDdBTE5uM3BxbE81YjF3eXA5WUFwWkdvc2lVRXJm?=
 =?utf-8?B?bklaemRLOWJMa0FTUXFGVEIvK0dmaGNVVFVOeXB2emlrVnE5SmlTbFFIRUUz?=
 =?utf-8?B?VTR4MGhwMXR2WFFHZ0w5MEpGTTlqS1RBNG9LYy9sTFVSTzdBK0Q3VmJ3bkhP?=
 =?utf-8?B?enMrZHdUVndyUk03VEdpWHZlUEErUnhGTVMvbXI0US9KS0o1Y2hYMEJwUHRF?=
 =?utf-8?B?cUFaWENDYzgraVE0ZnFDbWN3RVFnNzk2YU5qUkU1MDVCTTZQazZMalM2QTcw?=
 =?utf-8?B?VGFUdEFnSVQwcHNCY0xEU212Zjh3VVVNOU5rdDJ5ZkNqNjZsVGtrd2Vyb3JI?=
 =?utf-8?B?UmdRUUdJL3BvNmZwUGphNUNBN3VuL2x5QUNaTlFITk5pam5OcVRxWjhEeEkv?=
 =?utf-8?B?MFhGbVdzY0c2UnZFaGFDRXVJQWQrcHRhVUlkWjNkVGtmK05xTFRMOXF6aEpE?=
 =?utf-8?B?YWFvb1RYOEpmNGMreE1sdnZVOEE4MTNJaldldHJoTWNHWUs1WUlGemZwSmRq?=
 =?utf-8?B?Vi8xY0JpSFNzR3FzWlRPbEo0dWVVSFFpaWJWdk16UVU1VTk5Z3BRd0plcFpU?=
 =?utf-8?B?VTg4bXhmczIxeEI0ZXJldlFxd0Irb210NVlGYlh5WFdoQ0VFVmJEbk12SXph?=
 =?utf-8?B?N0hHbEl3aXZaaWFtdHNLQllDby9jYyt0SitXR0F1OUNZbDdzWkp4MGw0QWxv?=
 =?utf-8?B?SldNM0xBQzBaRThrNU1keHZLb3dWaFJXVkQ1Yk9FV3VoTlpYYm1LL1RKUG9X?=
 =?utf-8?B?WmdsZCtSMnJIdFpHSEJaTytlUVNSRTVzdFJEVTVPV1BoUURnMStzNVZQaTVm?=
 =?utf-8?B?UEYzMHBPR1J1UmJmRGt3S01ld2ptaTB5bjhUY0xybVJNSnA3YXpicDJ4Zm1a?=
 =?utf-8?B?OWJpa0M2R0orVUtqNUhBR0hVdzZvc3NVT2REZUVKdVlYYW5YM3B6c2E5aTVY?=
 =?utf-8?B?dkFTQjFLWVFCMElnTnRGS1gySkhvcXluUnZQcXhJbTRESWM5c0g5ZnNBdjBL?=
 =?utf-8?B?S3hyejFLU2V5K1VvditoV2M1b094VGVDL1llbmI3OFZJYjJKOGRmdFZLK1kz?=
 =?utf-8?B?VXQvaWVUWFFRbWk5b3docHo0M3hUSi9QVDJnSGpLNW90elNaT0N1NFRTank3?=
 =?utf-8?B?VXY0ekZPSldhUTFFVkhObFJXN0syRnZEQlF2TFlybXk2TjZINjBwV3RxRU1D?=
 =?utf-8?B?YTVNbW9oRWtldmxzZUQyR1BjcXVUbTQ0cFhCYUtRUmUrTDlsUkZ2ZzI1S3BB?=
 =?utf-8?B?WWY3UFpFOVlmOW41Tk9sUkdyTTlpK0lQaS9jMU95V3VXeFZ4WEtFQXpyZDBI?=
 =?utf-8?B?Y0I0VXkra0ZXNUFmUkhJQmFiS09EVHVzKzBOc2FuSWNLbFJWM3hwdFl5azFx?=
 =?utf-8?B?Ni9HMjNmL3I0bFB3Qy92TnRuWmhGdW90QVRNdHdVclRsUldvYjk5WUNkbU0x?=
 =?utf-8?B?bm1QTWNMZjZwbFRLMGgwTmlHdzYzczNpdENITFZqanNlOWJnRFJKWUZnVDAx?=
 =?utf-8?B?bmZQU1ZlOGM1eEJmWVppcjRKaVkzdUo4R25YVGpMV210ZGdWK1BBZ0k3d05R?=
 =?utf-8?Q?Fp3s=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 993b644b-075c-4f4c-d79e-08db838b2399
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2023 10:23:02.3852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4OS3cknMKcs6sgGiBr+iMw3jTgnnSiZUFO10BuLLgH22jBMWhjMxSSdt+qjOovytytbbt0DwMAAi2s1m8fu6Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6207

T2ssIHRoYW5rIHlvdSDwn5iKDQpyZWdhcmRzLA0KTWluZw0KDQotLS0tLemCruS7tuWOn+S7ti0t
LS0tDQrlj5Hku7bkuro6IERhbiBDYXJwZW50ZXIgPGRhbi5jYXJwZW50ZXJAbGluYXJvLm9yZz4g
DQrlj5HpgIHml7bpl7Q6IDIwMjPlubQ35pyIMTPml6UgMTg6MTQNCuaUtuS7tuS6ujog546L5piO
Lei9r+S7tuW6leWxguaKgOacr+mDqCA8bWFjaGVsQHZpdm8uY29tPg0K5oqE6YCBOiBKb24gTWFz
b24gPGpkbWFzb25Aa3VkenUudXM+OyBEYXZlIEppYW5nIDxkYXZlLmppYW5nQGludGVsLmNvbT47
IEFsbGVuIEh1YmJlIDxhbGxlbmJoQGdtYWlsLmNvbT47IFNlcmdlIFNlbWluIDxmYW5jZXIubGFu
Y2VyQGdtYWlsLmNvbT47IERhbiBDYXJwZW50ZXIgPGVycm9yMjdAZ21haWwuY29tPjsgSmlhc2hl
bmcgSmlhbmcgPGppYXNoZW5nQGlzY2FzLmFjLmNuPjsgbnRiQGxpc3RzLmxpbnV4LmRldjsgbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgb3BlbnNvdXJjZS5rZXJuZWwgPG9wZW5zb3VyY2Uu
a2VybmVsQHZpdm8uY29tPg0K5Li76aKYOiBSZTog5Zue5aSNOiBbUEFUQ0ggdjNdIG50YjogUmVt
b3ZlIGVycm9yIGNoZWNraW5nIGZvciBkZWJ1Z2ZzX2NyZWF0ZV9kaXIoKQ0KDQpPbiBUaHUsIEp1
bCAxMywgMjAyMyBhdCAxMDowNzo0NUFNICswMDAwLCDnjovmmI4t6L2v5Lu25bqV5bGC5oqA5pyv
6YOoIHdyb3RlOg0KPiBIaSBkYW4gY2FycGVudGVyDQo+IFNvcnJ5IHRvIGJvdGhlciB5b3UgYWdh
aW4sIElzIHRoZXJlIGFueXRoaW5nIHdyb25nIHdpdGggbXkgcGF0Y2g/IENhbiB0aGlzIHBhdGNo
IGJlIGFwcGxpZWQ/DQo+IA0KDQpJJ20gbm90IHRoZSBOVEIgbWFpbnRhaW5lci4gIEkgZG9uJ3Qg
c2VlIGEgcmVhc29uIHdoeSBpdCBjYW4ndCBiZSBhcHBsaWVkIGJ1dCwgcGxlYXNlLCB3YWl0IGZv
ciB0d28gd2Vla3MgZm9yIG1haW50YWluZXIgZmVlZGJhY2suDQoNCnJlZ2FyZHMsDQpkYW4gY2Fy
cGVudGVyDQoNCg==
