Return-Path: <dave.jiang@intel.com>
Received: from mga09.intel.com (mga09.intel.com. [134.134.136.24])
        by gmr-mx.google.com with ESMTP id f69si894248pfc.1.2016.06.03.14.03.51
        for <linux-ntb@googlegroups.com>;
        Fri, 03 Jun 2016 14:03:51 -0700 (PDT)
From: "Jiang, Dave" <dave.jiang@intel.com>
Subject: Re: [PATCH 1/3] ntb_perf: Allow limiting the size of the memory
 windows
Date: Fri, 3 Jun 2016 21:03:50 +0000
Message-ID: <1464987814.16234.148.camel@intel.com>
References: <cover.1464986161.git.logang@deltatee.com>
	 <9e9ca38bef468fc1dd3d135f5f3d3cfb6b61246d.1464986161.git.logang@deltatee.com>
In-Reply-To: <9e9ca38bef468fc1dd3d135f5f3d3cfb6b61246d.1464986161.git.logang@deltatee.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE8DA9FE6A4A674D9C686EDC17405729@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Return-Path: dave.jiang@intel.com
To: "Allen.Hubbe@emc.com" <Allen.Hubbe@emc.com>, "logang@deltatee.com" <logang@deltatee.com>, "jdmason@kudzu.us" <jdmason@kudzu.us>, "sudipm.mukherjee@gmail.com" <sudipm.mukherjee@gmail.com>, "arnd@arndb.de" <arnd@arndb.de>, "john.kading@gd-ms.com" <john.kading@gd-ms.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

T24gRnJpLCAyMDE2LTA2LTAzIGF0IDE0OjUwIC0wNjAwLCBMb2dhbiBHdW50aG9ycGUgd3JvdGU6
DQo+IE9uIG15IHN5c3RlbSwgZG1hX2FsbG9jX2NvaGVyZW50IHdvbid0IHByb2R1Y2UgbWVtb3J5
IGFueXdoZXJlDQo+IG5lYXIgdGhlIHNpemUgb2YgdGhlIEJBUi4gU28gSSBuZWVkZWQgYSB3YXkg
dG8gbGltaXQgdGhpcy4NCj4gDQo+IEl0J3MgcHJldHR5IG11Y2ggY29waWVkIHN0cmFpZ2h0IGZy
b20gbnRiX3RyYW5zcG9ydC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IExvZ2FuIEd1bnRob3JwZSA8
bG9nYW5nQGRlbHRhdGVlLmNvbT4NCkFja2VkLWJ5OiBEYXZlIEppYW5nIDxkYXZlLmppYW5nQGlu
dGVsLmNvbT4NCg0KPiAtLS0NCj4gwqBkcml2ZXJzL250Yi90ZXN0L250Yl9wZXJmLmMgfCA4ICsr
KysrKysrDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbnRiL3Rlc3QvbnRiX3BlcmYuYw0KPiBiL2RyaXZlcnMvbnRiL3Rlc3Qv
bnRiX3BlcmYuYw0KPiBpbmRleCA4ZGZjZTljLi4zMDYzNWM4IDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL250Yi90ZXN0L250Yl9wZXJmLmMNCj4gKysrIGIvZHJpdmVycy9udGIvdGVzdC9udGJfcGVy
Zi5jDQo+IEBAIC04Myw2ICs4MywxMCBAQCBNT0RVTEVfREVTQ1JJUFRJT04oRFJJVkVSX0RFU0NS
SVBUSU9OKTsNCj4gwqANCj4gwqBzdGF0aWMgc3RydWN0IGRlbnRyeSAqcGVyZl9kZWJ1Z2ZzX2Rp
cjsNCj4gwqANCj4gK3N0YXRpYyB1bnNpZ25lZCBsb25nIG1heF9td19zaXplOw0KPiArbW9kdWxl
X3BhcmFtKG1heF9td19zaXplLCB1bG9uZywgMDY0NCk7DQo+ICtNT0RVTEVfUEFSTV9ERVNDKG1h
eF9td19zaXplLCAiTGltaXQgc2l6ZSBvZiBsYXJnZSBtZW1vcnkgd2luZG93cyIpOw0KPiArDQo+
IMKgc3RhdGljIHVuc2lnbmVkIGludCBzZWdfb3JkZXIgPSAxOTsgLyogNTEySyAqLw0KPiDCoG1v
ZHVsZV9wYXJhbShzZWdfb3JkZXIsIHVpbnQsIDA2NDQpOw0KPiDCoE1PRFVMRV9QQVJNX0RFU0Mo
c2VnX29yZGVyLCAic2l6ZSBvcmRlciBbbl4yXSBvZiBidWZmZXIgc2VnbWVudCBmb3INCj4gdGVz
dGluZyIpOw0KPiBAQCAtNDcyLDYgKzQ3NiwxMCBAQCBzdGF0aWMgdm9pZCBwZXJmX2xpbmtfd29y
ayhzdHJ1Y3Qgd29ya19zdHJ1Y3QNCj4gKndvcmspDQo+IMKgCWRldl9kYmcoJnBlcmYtPm50Yi0+
cGRldi0+ZGV2LCAiJXMgY2FsbGVkXG4iLCBfX2Z1bmNfXyk7DQo+IMKgDQo+IMKgCXNpemUgPSBw
ZXJmLT5tdy5waHlzX3NpemU7DQo+ICsNCj4gKwlpZiAobWF4X213X3NpemUgJiYgc2l6ZSA+IG1h
eF9td19zaXplKQ0KPiArCQlzaXplID0gbWF4X213X3NpemU7DQo+ICsNCj4gwqAJbnRiX3BlZXJf
c3BhZF93cml0ZShuZGV2LCBNV19TWl9ISUdILCB1cHBlcl8zMl9iaXRzKHNpemUpKTsNCj4gwqAJ
bnRiX3BlZXJfc3BhZF93cml0ZShuZGV2LCBNV19TWl9MT1csIGxvd2VyXzMyX2JpdHMoc2l6ZSkp
Ow0KPiDCoAludGJfcGVlcl9zcGFkX3dyaXRlKG5kZXYsIFZFUlNJT04sIFBFUkZfVkVSU0lPTik7
DQo+IC0twqANCj4gMi4xLjQNCj4g
