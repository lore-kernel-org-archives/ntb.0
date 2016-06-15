Return-Path: <dave.jiang@intel.com>
Received: from mga09.intel.com (mga09.intel.com. [134.134.136.24])
        by gmr-mx.google.com with ESMTP id tp10si4456312pac.2.2016.06.15.15.24.37
        for <linux-ntb@googlegroups.com>;
        Wed, 15 Jun 2016 15:24:37 -0700 (PDT)
From: "Jiang, Dave" <dave.jiang@intel.com>
Subject: Re: [PATCH v3 10/10] ntb_perf: clear link_is_up flag when the link
 goes down.
Date: Wed, 15 Jun 2016 22:24:36 +0000
Message-ID: <1466029459.16234.263.camel@intel.com>
References: <cover.1466025130.git.logang@deltatee.com>
	 <b1aa9e9977b992621452812f744ff7827ca4f28c.1466025130.git.logang@deltatee.com>
	 <1466026416.16234.262.camel@intel.com> <5761D4C5.8090208@deltatee.com>
In-Reply-To: <5761D4C5.8090208@deltatee.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <89D7955BD9F78645919C3AA15900F551@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Return-Path: dave.jiang@intel.com
To: "Allen.Hubbe@emc.com" <Allen.Hubbe@emc.com>, "logang@deltatee.com" <logang@deltatee.com>, "jdmason@kudzu.us" <jdmason@kudzu.us>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "shuahkh@osg.samsung.com" <shuahkh@osg.samsung.com>, "sudipm.mukherjee@gmail.com" <sudipm.mukherjee@gmail.com>, "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

T24gV2VkLCAyMDE2LTA2LTE1IGF0IDE2OjIwIC0wNjAwLCBMb2dhbiBHdW50aG9ycGUgd3JvdGU6
DQo+IEhleSwNCj4gDQo+IEFjdHVhbGx5LCBJIGhhdmUgdG8gcmV0cmFjdCB0aGlzIHBhdGNoLiBB
ZnRlciBzb21lIG1vcmUgdGhvcm91Z2gNCj4gdGVzdGluZw0KPiBJJ20gZmluZGluZyBhbiBpc3N1
ZToNCj4gDQo+IFdoZW4geW91IHJlbW92ZSBhbmQgcmUtaW5zdGFsbCB0aGUgbnRiX3BlcmYgbW9k
dWxlIHZlcnkgcXVpY2tseSwNCj4gbnRiX3BlcmYgd2lsbCBvY2Nhc2lvbmFsbHkgbWlzcyB0aGUg
bGluayB1cCBldmVudC4gVGhpcyBpcyBiZWNhdXNlDQo+IHRoZQ0KPiBsaW5rX2NsZWFudXAgd29y
ayBnZXRzIGRlbGF5ZWQgbG9uZyBlbm91Z2ggdGhhdCBpdCBnZXRzIHNjaGVkdWxlZA0KPiBhZnRl
cg0KPiB0aGUgbGluayB1cCBldmVudCBnZXRzIHNlbnQuIEl0IHRoZW4gY2FuY2VscyB0aGUgbGlu
ayB3b3JrIHRoYXQNCj4gc2hvdWxkDQo+IGhhdmUgb2NjdXJyZWQuIFdpdGhvdXQgdGhpcyBwYXRj
aCwgaXQgbmV2ZXIgaGFwcGVucyBiZWNhdXNlDQo+IGxpbmtfaXNfdXANCj4gbmV2ZXIgcmV0dXJu
cyB0byBmYWxzZS4NCj4gDQo+IEkgdGhpbmsgdGhlIGNvcnJlY3Qgc29sdXRpb24gaXMgdG8ganVz
dCByZW1vdmUgdGhlIGxpbmtfY2xlYW51cCB3b3JrDQo+IGFuZA0KPiBkbyB0aG9zZSBhY3Rpb25z
IGltbWVkaWF0ZWx5IG9uIHJlY2VpcHQgb2YgdGhlIGV2ZW50LiBJZiB0aGVyZSdzDQo+IGFncmVl
bWVudCBvbiB0aGlzIEkgY2FuIHJlLXNwaW4gaXQgYWdhaW4uDQoNCkknbSBvayB3aXRoIHRoYXQu
IFRoaXMgaXMgbm90IGFuIGlzc3VlIHdpdGggbnRiX3RyYW5zcG9ydD8NCg0KPiANCj4gVGhhbmtz
LA0KPiANCj4gTG9nYW4NCj4gDQo+IA0KPiBPbiAxNS8wNi8xNiAwMzozMyBQTSwgSmlhbmcsIERh
dmUgd3JvdGU6DQo+ID4gDQo+ID4gT24gV2VkLCAyMDE2LTA2LTE1IGF0IDE1OjI2IC0wNjAwLCBM
b2dhbiBHdW50aG9ycGUgd3JvdGU6DQo+ID4gPiANCj4gPiA+IFdoZW4gdGhlIGxpbmsgZ29lcyBk
b3duLCB0aGUgbGlua19pc191cCBmbGFnIGRpZCBub3QgcmV0dXJuIHRvDQo+ID4gPiBmYWxzZS4g
VGhpcyBjb3VsZCBoYXZlIGNhdXNlZCBzb21lIHN1YnRsZSBjb3JuZXIgY2FzZSBidWdzDQo+ID4g
PiB3aGVuIHRoZSBsaW5rIGdvZXMgdXAgYW5kIGRvd24gcXVpY2tseS4NCj4gPiA+IA0KPiA+ID4g
U2lnbmVkLW9mZi1ieTogTG9nYW4gR3VudGhvcnBlIDxsb2dhbmdAZGVsdGF0ZWUuY29tPg0KPiA+
IEFja2VkLWJ5OiBEYXZlIEppYW5nIDxkYXZlLmppYW5nQGludGVsLmNvbT4NCj4gPiANCj4gPiBB
bmQgYWxsIHRoZSBvdGhlciBudGJfcGVyZiBwYXRjaGVzIHNpbmNlIHRoZXJlIHdlcmUgbm8gYWRk
aXRpb25hbA0KPiA+IGNoYW5nZXMuwqANCj4gPiANCj4gPiA+IA0KPiA+ID4gLS0tDQo+ID4gPiDC
oGRyaXZlcnMvbnRiL3Rlc3QvbnRiX3BlcmYuYyB8IDIgKysNCj4gPiA+IMKgMSBmaWxlIGNoYW5n
ZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9u
dGIvdGVzdC9udGJfcGVyZi5jDQo+ID4gPiBiL2RyaXZlcnMvbnRiL3Rlc3QvbnRiX3BlcmYuYw0K
PiA+ID4gaW5kZXggZjA3ODRlNS4uYWU5ZDFiMiAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMv
bnRiL3Rlc3QvbnRiX3BlcmYuYw0KPiA+ID4gKysrIGIvZHJpdmVycy9udGIvdGVzdC9udGJfcGVy
Zi5jDQo+ID4gPiBAQCAtNTU3LDYgKzU1Nyw4IEBAIHN0YXRpYyB2b2lkIHBlcmZfbGlua19jbGVh
bnVwKHN0cnVjdA0KPiA+ID4gd29ya19zdHJ1Y3QNCj4gPiA+ICp3b3JrKQ0KPiA+ID4gwqANCj4g
PiA+IMKgCWlmICghcGVyZi0+bGlua19pc191cCkNCj4gPiA+IMKgCQljYW5jZWxfZGVsYXllZF93
b3JrX3N5bmMoJnBlcmYtPmxpbmtfd29yayk7DQo+ID4gPiArDQo+ID4gPiArCXBlcmYtPmxpbmtf
aXNfdXAgPSBmYWxzZTsNCj4gPiA+IMKgfQ0KPiA+ID4gwqANCj4gPiA+IMKgc3RhdGljIGludCBw
ZXJmX3NldHVwX213KHN0cnVjdCBudGJfZGV2ICpudGIsIHN0cnVjdCBwZXJmX2N0eA0KPiA+ID4g
KnBlcmYpDQo+ID4gPiAtLcKgDQo+ID4gPiAyLjEuNA==
