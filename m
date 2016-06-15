Return-Path: <dave.jiang@intel.com>
Received: from mga03.intel.com (mga03.intel.com. [134.134.136.65])
        by gmr-mx.google.com with ESMTP id 62si4107917pfx.1.2016.06.15.14.33.54
        for <linux-ntb@googlegroups.com>;
        Wed, 15 Jun 2016 14:33:54 -0700 (PDT)
From: "Jiang, Dave" <dave.jiang@intel.com>
Subject: Re: [PATCH v3 10/10] ntb_perf: clear link_is_up flag when the link
 goes down.
Date: Wed, 15 Jun 2016 21:33:52 +0000
Message-ID: <1466026416.16234.262.camel@intel.com>
References: <cover.1466025130.git.logang@deltatee.com>
	 <b1aa9e9977b992621452812f744ff7827ca4f28c.1466025130.git.logang@deltatee.com>
In-Reply-To: <b1aa9e9977b992621452812f744ff7827ca4f28c.1466025130.git.logang@deltatee.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <D989D56AC5302F458DF0116CABFD6D22@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Return-Path: dave.jiang@intel.com
To: "Allen.Hubbe@emc.com" <Allen.Hubbe@emc.com>, "logang@deltatee.com" <logang@deltatee.com>, "jdmason@kudzu.us" <jdmason@kudzu.us>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "shuahkh@osg.samsung.com" <shuahkh@osg.samsung.com>, "sudipm.mukherjee@gmail.com" <sudipm.mukherjee@gmail.com>, "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

T24gV2VkLCAyMDE2LTA2LTE1IGF0IDE1OjI2IC0wNjAwLCBMb2dhbiBHdW50aG9ycGUgd3JvdGU6
DQo+IFdoZW4gdGhlIGxpbmsgZ29lcyBkb3duLCB0aGUgbGlua19pc191cCBmbGFnIGRpZCBub3Qg
cmV0dXJuIHRvDQo+IGZhbHNlLiBUaGlzIGNvdWxkIGhhdmUgY2F1c2VkIHNvbWUgc3VidGxlIGNv
cm5lciBjYXNlIGJ1Z3MNCj4gd2hlbiB0aGUgbGluayBnb2VzIHVwIGFuZCBkb3duIHF1aWNrbHku
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBMb2dhbiBHdW50aG9ycGUgPGxvZ2FuZ0BkZWx0YXRlZS5j
b20+DQoNCkFja2VkLWJ5OiBEYXZlIEppYW5nIDxkYXZlLmppYW5nQGludGVsLmNvbT4NCg0KQW5k
IGFsbCB0aGUgb3RoZXIgbnRiX3BlcmYgcGF0Y2hlcyBzaW5jZSB0aGVyZSB3ZXJlIG5vIGFkZGl0
aW9uYWwNCmNoYW5nZXMuwqANCg0KPiAtLS0NCj4gwqBkcml2ZXJzL250Yi90ZXN0L250Yl9wZXJm
LmMgfCAyICsrDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbnRiL3Rlc3QvbnRiX3BlcmYuYw0KPiBiL2RyaXZlcnMvbnRiL3Rl
c3QvbnRiX3BlcmYuYw0KPiBpbmRleCBmMDc4NGU1Li5hZTlkMWIyIDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL250Yi90ZXN0L250Yl9wZXJmLmMNCj4gKysrIGIvZHJpdmVycy9udGIvdGVzdC9udGJf
cGVyZi5jDQo+IEBAIC01NTcsNiArNTU3LDggQEAgc3RhdGljIHZvaWQgcGVyZl9saW5rX2NsZWFu
dXAoc3RydWN0IHdvcmtfc3RydWN0DQo+ICp3b3JrKQ0KPiDCoA0KPiDCoAlpZiAoIXBlcmYtPmxp
bmtfaXNfdXApDQo+IMKgCQljYW5jZWxfZGVsYXllZF93b3JrX3N5bmMoJnBlcmYtPmxpbmtfd29y
ayk7DQo+ICsNCj4gKwlwZXJmLT5saW5rX2lzX3VwID0gZmFsc2U7DQo+IMKgfQ0KPiDCoA0KPiDC
oHN0YXRpYyBpbnQgcGVyZl9zZXR1cF9tdyhzdHJ1Y3QgbnRiX2RldiAqbnRiLCBzdHJ1Y3QgcGVy
Zl9jdHggKnBlcmYpDQo+IC0twqANCj4gMi4xLjQNCj4g
