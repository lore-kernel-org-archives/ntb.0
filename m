Return-Path: <dave.jiang@intel.com>
Received: from mga09.intel.com (mga09.intel.com. [134.134.136.24])
        by gmr-mx.google.com with ESMTP id tp10si3045512pac.2.2016.06.13.11.05.48
        for <linux-ntb@googlegroups.com>;
        Mon, 13 Jun 2016 11:05:48 -0700 (PDT)
From: "Jiang, Dave" <dave.jiang@intel.com>
Subject: Re: [PATCH 1/8] ntb_perf: Schedule based on time not on performance
Date: Mon, 13 Jun 2016 18:05:34 +0000
Message-ID: <1465841117.16234.248.camel@intel.com>
References: <cover.1465598632.git.logang@deltatee.com>
	 <03a622a20a667b17046fbd45bb952f8dbd235653.1465598632.git.logang@deltatee.com>
In-Reply-To: <03a622a20a667b17046fbd45bb952f8dbd235653.1465598632.git.logang@deltatee.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <8CE0DA850D248746AE50349D078B5D1D@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
To: "Allen.Hubbe@emc.com" <Allen.Hubbe@emc.com>, "logang@deltatee.com" <logang@deltatee.com>, "jdmason@kudzu.us" <jdmason@kudzu.us>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "shuahkh@osg.samsung.com" <shuahkh@osg.samsung.com>, "sudipm.mukherjee@gmail.com" <sudipm.mukherjee@gmail.com>, "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

T24gRnJpLCAyMDE2LTA2LTEwIGF0IDE2OjU0IC0wNjAwLCBMb2dhbiBHdW50aG9ycGUgd3JvdGU6
DQo+IFdoZW4gZGVidWdnaW5nIHBlcmZvcm1hbmNlIHByb2JsZW1zLCBpZiBzb21lIGlzc3VlIGNh
dXNlcyB0aGUgbnRiDQo+IGhhcmR3YXJlIHRvIGJlIHNpZ25pZmljYW50bHkgc2xvd2VyIHRoYW4g
ZXhwZWN0ZWQsIG50Yl9wZXJmIHdpbGwNCj4gaGFuZyByZXF1aXJpbmcgYSByZWJvb3QgYmVjYXVz
ZSBpdCBvbmx5IHNjaGVkdWxlcyBvbmNlIGV2ZXJ5IDRHQi4NCj4gDQo+IEluc3RlYWQsIHNjaGVk
dWxlIGJhc2VkIG9uIGppZmZpZXMgc28gaXQgd2lsbCBub3QgaGFuZyB0aGUgQ1BVIGlmDQo+IHRo
ZSB0cmFuc2ZlciBpcyBzbG93Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTG9nYW4gR3VudGhvcnBl
IDxsb2dhbmdAZGVsdGF0ZWUuY29tPg0KQWNrZWQtYnk6IERhdmUgSmlhbmcgPGRhdmUuamlhbmdA
aW50ZWwuY29tPg0KDQo+IC0tLQ0KPiDCoGRyaXZlcnMvbnRiL3Rlc3QvbnRiX3BlcmYuYyB8IDYg
KysrKy0tDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL250Yi90ZXN0L250Yl9wZXJmLmMNCj4gYi9k
cml2ZXJzL250Yi90ZXN0L250Yl9wZXJmLmMNCj4gaW5kZXggNDM2ODUxOS4uNTAwOGNjZiAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9udGIvdGVzdC9udGJfcGVyZi5jDQo+ICsrKyBiL2RyaXZlcnMv
bnRiL3Rlc3QvbnRiX3BlcmYuYw0KPiBAQCAtMjczLDYgKzI3Myw3IEBAIHN0YXRpYyBpbnQgcGVy
Zl9tb3ZlX2RhdGEoc3RydWN0IHB0aHJfY3R4ICpwY3R4LA0KPiBjaGFyIF9faW9tZW0gKmRzdCwg
Y2hhciAqc3JjLA0KPiDCoAljaGFyIF9faW9tZW0gKnRtcCA9IGRzdDsNCj4gwqAJdTY0IHBlcmYs
IGRpZmZfdXM7DQo+IMKgCWt0aW1lX3Qga3N0YXJ0LCBrc3RvcCwga2RpZmY7DQo+ICsJdW5zaWdu
ZWQgbG9uZyBsYXN0X3NsZWVwID0gamlmZmllczsNCj4gwqANCj4gwqAJY2h1bmtzID0gZGl2NjRf
dTY0KHdpbl9zaXplLCBidWZfc2l6ZSk7DQo+IMKgCXRvdGFsX2NodW5rcyA9IGRpdjY0X3U2NCh0
b3RhbCwgYnVmX3NpemUpOw0KPiBAQCAtMjg4LDggKzI4OSw5IEBAIHN0YXRpYyBpbnQgcGVyZl9t
b3ZlX2RhdGEoc3RydWN0IHB0aHJfY3R4ICpwY3R4LA0KPiBjaGFyIF9faW9tZW0gKmRzdCwgY2hh
ciAqc3JjLA0KPiDCoAkJfSBlbHNlDQo+IMKgCQkJdG1wICs9IGJ1Zl9zaXplOw0KPiDCoA0KPiAt
CQkvKiBQcm9iYWJseSBzaG91bGQgc2NoZWR1bGUgZXZlcnkgNEdCIHRvIHByZXZlbnQNCj4gc29m
dCBoYW5nLiAqLw0KPiAtCQlpZiAoKChjb3BpZWQgJSBTWl80RykgPT0gMCkgJiYgIXVzZV9kbWEp
IHsNCj4gKwkJLyogUHJvYmFibHkgc2hvdWxkIHNjaGVkdWxlIGV2ZXJ5IDVzIHRvIHByZXZlbnQg
c29mdA0KPiBoYW5nLiAqLw0KPiArCQlpZiAodW5saWtlbHkoKGppZmZpZXMgLSBsYXN0X3NsZWVw
KSA+IDUgKiBIWikpIHsNCj4gKwkJCWxhc3Rfc2xlZXAgPSBqaWZmaWVzOw0KPiDCoAkJCXNldF9j
dXJyZW50X3N0YXRlKFRBU0tfSU5URVJSVVBUSUJMRSk7DQo+IMKgCQkJc2NoZWR1bGVfdGltZW91
dCgxKTsNCj4gwqAJCX0NCj4gLS3CoA0KPiAyLjEuNA0KPiA=
