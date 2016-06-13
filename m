Return-Path: <dave.jiang@intel.com>
Received: from mga04.intel.com (mga04.intel.com. [192.55.52.120])
        by gmr-mx.google.com with ESMTP id ci4si2835182pad.1.2016.06.13.13.14.03
        for <linux-ntb@googlegroups.com>;
        Mon, 13 Jun 2016 13:14:03 -0700 (PDT)
From: "Jiang, Dave" <dave.jiang@intel.com>
Subject: Re: [PATCH 4/8] ntb_perf: Wait for link before running test
Date: Mon, 13 Jun 2016 20:14:01 +0000
Message-ID: <1465848825.16234.251.camel@intel.com>
References: <cover.1465598632.git.logang@deltatee.com>
	 <71664260d670af5f24beb9c825791802659f3cd2.1465598632.git.logang@deltatee.com>
In-Reply-To: <71664260d670af5f24beb9c825791802659f3cd2.1465598632.git.logang@deltatee.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <338A24E7F24FB24AAEC8D7631A02CA58@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Return-Path: dave.jiang@intel.com
To: "Allen.Hubbe@emc.com" <Allen.Hubbe@emc.com>, "logang@deltatee.com" <logang@deltatee.com>, "jdmason@kudzu.us" <jdmason@kudzu.us>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "shuahkh@osg.samsung.com" <shuahkh@osg.samsung.com>, "sudipm.mukherjee@gmail.com" <sudipm.mukherjee@gmail.com>, "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

T24gRnJpLCAyMDE2LTA2LTEwIGF0IDE2OjU0IC0wNjAwLCBMb2dhbiBHdW50aG9ycGUgd3JvdGU6
DQo+IEluc3RlYWQgb2YgcmV0dXJuaW5nIGltbWVkaWF0ZWx5IHdpdGggYW4gZXJyb3Igd2hlbiB0
aGUgbGluayBpcw0KPiBkb3duLCB3YWl0IGZvciB0aGUgbGluayB0byBjb21lIHVwIChvciB0aGUg
dXNlciBzZW5kcyBhIFNJR0lOVCkuDQo+IA0KPiBUaGlzIGlzIHRvIG1ha2Ugc2NyaXB0aW5nIG50
Yl9wZXJmIGVhc2llci4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IExvZ2FuIEd1bnRob3JwZSA8bG9n
YW5nQGRlbHRhdGVlLmNvbT4NCkFja2VkLWJ5OiBEYXZlIEppYW5nIDxkYXZlLmppYW5nQGludGVs
LmNvbT4NCg0KPiAtLS0NCj4gwqBkcml2ZXJzL250Yi90ZXN0L250Yl9wZXJmLmMgfCA1ICsrKyst
DQo+IMKgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnRiL3Rlc3QvbnRiX3BlcmYuYw0KPiBiL2RyaXZlcnMv
bnRiL3Rlc3QvbnRiX3BlcmYuYw0KPiBpbmRleCAwNWE4NzA1Li5mMDc4NGU1IDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL250Yi90ZXN0L250Yl9wZXJmLmMNCj4gKysrIGIvZHJpdmVycy9udGIvdGVz
dC9udGJfcGVyZi5jDQo+IEBAIC0xMzUsNiArMTM1LDcgQEAgc3RydWN0IHBlcmZfY3R4IHsNCj4g
wqAJYm9vbAkJCWxpbmtfaXNfdXA7DQo+IMKgCXN0cnVjdCB3b3JrX3N0cnVjdAlsaW5rX2NsZWFu
dXA7DQo+IMKgCXN0cnVjdCBkZWxheWVkX3dvcmsJbGlua193b3JrOw0KPiArCXdhaXRfcXVldWVf
aGVhZF90CWxpbmtfd3E7DQo+IMKgCXN0cnVjdCBkZW50cnkJCSpkZWJ1Z2ZzX25vZGVfZGlyOw0K
PiDCoAlzdHJ1Y3QgZGVudHJ5CQkqZGVidWdmc19ydW47DQo+IMKgCXN0cnVjdCBkZW50cnkJCSpk
ZWJ1Z2ZzX3RocmVhZHM7DQo+IEBAIC01MzMsNiArNTM0LDcgQEAgc3RhdGljIHZvaWQgcGVyZl9s
aW5rX3dvcmsoc3RydWN0IHdvcmtfc3RydWN0DQo+ICp3b3JrKQ0KPiDCoAkJZ290byBvdXQxOw0K
PiDCoA0KPiDCoAlwZXJmLT5saW5rX2lzX3VwID0gdHJ1ZTsNCj4gKwl3YWtlX3VwKCZwZXJmLT5s
aW5rX3dxKTsNCj4gwqANCj4gwqAJcmV0dXJuOw0KPiDCoA0KPiBAQCAtNjUzLDcgKzY1NSw3IEBA
IHN0YXRpYyBzc2l6ZV90IGRlYnVnZnNfcnVuX3dyaXRlKHN0cnVjdCBmaWxlDQo+ICpmaWxwLCBj
b25zdCBjaGFyIF9fdXNlciAqdWJ1ZiwNCj4gwqAJaW50IG5vZGUsIGk7DQo+IMKgCURFQ0xBUkVf
V0FJVF9RVUVVRV9IRUFEKHdxKTsNCj4gwqANCj4gLQlpZiAoIXBlcmYtPmxpbmtfaXNfdXApDQo+
ICsJaWYgKHdhaXRfZXZlbnRfaW50ZXJydXB0aWJsZShwZXJmLT5saW5rX3dxLCBwZXJmLQ0KPiA+
bGlua19pc191cCkpDQo+IMKgCQlyZXR1cm4gLUVOT0xJTks7DQo+IMKgDQo+IMKgCWlmIChwZXJm
LT5wZXJmX3RocmVhZHMgPT0gMCkNCj4gQEAgLTc4Myw2ICs3ODUsNyBAQCBzdGF0aWMgaW50IHBl
cmZfcHJvYmUoc3RydWN0IG50Yl9jbGllbnQgKmNsaWVudCwNCj4gc3RydWN0IG50Yl9kZXYgKm50
YikNCj4gwqAJbXV0ZXhfaW5pdCgmcGVyZi0+cnVuX211dGV4KTsNCj4gwqAJc3Bpbl9sb2NrX2lu
aXQoJnBlcmYtPmRiX2xvY2spOw0KPiDCoAlwZXJmX3NldHVwX213KG50YiwgcGVyZik7DQo+ICsJ
aW5pdF93YWl0cXVldWVfaGVhZCgmcGVyZi0+bGlua193cSk7DQo+IMKgCUlOSVRfREVMQVlFRF9X
T1JLKCZwZXJmLT5saW5rX3dvcmssIHBlcmZfbGlua193b3JrKTsNCj4gwqAJSU5JVF9XT1JLKCZw
ZXJmLT5saW5rX2NsZWFudXAsIHBlcmZfbGlua19jbGVhbnVwKTsNCj4gwqANCj4gLS3CoA0KPiAy
LjEuNA0KPiA=
