Return-Path: <dave.jiang@intel.com>
Received: from mga05.intel.com (mga05.intel.com. [192.55.52.43])
        by gmr-mx.google.com with ESMTPS id ph9si2821597pac.1.2016.08.22.09.58.28
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Aug 2016 09:58:28 -0700 (PDT)
From: "Jiang, Dave" <dave.jiang@intel.com>
Subject: Re: [PATCH 2/2] ntb: make DMA_OUT_RESOURCE_TO HZ independent
Date: Mon, 22 Aug 2016 16:58:27 +0000
Message-ID: <1471885081.3770.129.camel@intel.com>
References: <1471884696-25558-1-git-send-email-hofrat@osadl.org>
	 <1471884696-25558-2-git-send-email-hofrat@osadl.org>
In-Reply-To: <1471884696-25558-2-git-send-email-hofrat@osadl.org>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <12260D3AE540CE4180F4182AB6ABB8F9@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
To: "hofrat@osadl.org" <hofrat@osadl.org>, "jdmason@kudzu.us" <jdmason@kudzu.us>
Cc: "Allen.Hubbe@emc.com" <Allen.Hubbe@emc.com>, "logang@deltatee.com" <logang@deltatee.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "sudipm.mukherjee@gmail.com" <sudipm.mukherjee@gmail.com>, "arnd@arndb.de" <arnd@arndb.de>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

DQpPbiBNb24sIDIwMTYtMDgtMjIgYXQgMTg6NTEgKzAyMDAsIE5pY2hvbGFzIE1jIEd1aXJlIHdy
b3RlOg0KPiBzY2hlZHVsZV90aW1lb3V0XyogdGFrZXMgYSB0aW1lb3V0IGluIGppZmZpZXMgYnV0
IHRoZSBjb2RlIGN1cnJlbnRseQ0KPiBpcw0KPiBwYXNzaW5nIGluIGEgY29uc3RhbnQgd2hpY2gg
bWFrZXMgdGhpcyB0aW1lb3V0IEhaIGRlcGVuZGVudCwgc28gcGFzcw0KPiBpdA0KPiB0aHJvdWdo
IG1zZWNzX3RvX2ppZmZpZXMoKSB0byBmaXggdGhpcyB1cC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IE5pY2hvbGFzIE1jIEd1aXJlIDxob2ZyYXRAb3NhZGwub3JnPg0KDQpBY2tlZC1ieTogRGF2ZSBK
aWFuZyA8ZGF2ZS5qaWFuZ0BpbnRlbC5jb20+DQoNCg0KPiAtLS0NCj4gDQo+IFByb2JsZW0gZm91
bmQgYnkgY29jY2luZWxsZSBzY3JpcHQNCj4gDQo+IFRoZSBiZWxvdyBwYXRjaCBzZXRzIHRoZSB0
aW1lb3V0IHRvIDUwbXMgLSBub3QgY2xlYXIgd2hhdCBIWiBzZXR0aW5nDQo+IHdhcw0KPiBhc3N1
bWVkIGR1cmluZyBkZXNpZ24vdGVzdGluZywgc28gdGhpcyBuZWVkcyBhbiBhY2sgYnkgc29tZW9u
ZSB3aG8NCj4ga25vd3MNCj4gdGhlIGRyaXZlciBhbmQgY2FuIGNvbmZpcm0gdGhhdCA1MG1zIGlz
IHJlYXNvbmFibGUgdG8gd2FpdCBvbiBETUENCj4gcmV0cmllcy4NCj4gDQo+IFBhdGNoIHdhcyBj
b21waWxlIHRlc3RlZCB3aXRoOiB4ODZfNjRfZGVmY29uZmlnICsgQ09ORklHX05UQj1tLA0KPiBD
T05GSUdfTlRCX1BFUkY9bQ0KPiANCj4gUGF0Y2ggaXMgYWdhaW5zdCA0LjguMC1yYzIgKGxvY2Fs
dmVyc2lvbi1uZXh0IGlzIC1uZXh0LTIwMTYwODIyKQ0KPiANCj4gwqBkcml2ZXJzL250Yi90ZXN0
L250Yl9wZXJmLmMgfCAyICstDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
IGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udGIvdGVzdC9udGJfcGVy
Zi5jDQo+IGIvZHJpdmVycy9udGIvdGVzdC9udGJfcGVyZi5jDQo+IGluZGV4IDZhNTBmMjAuLmUw
NjViNjkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbnRiL3Rlc3QvbnRiX3BlcmYuYw0KPiArKysg
Yi9kcml2ZXJzL250Yi90ZXN0L250Yl9wZXJmLmMNCj4gQEAgLTcyLDcgKzcyLDcgQEANCj4gwqAj
ZGVmaW5lIE1BWF9USFJFQURTCQkzMg0KPiDCoCNkZWZpbmUgTUFYX1RFU1RfU0laRQkJU1pfMU0N
Cj4gwqAjZGVmaW5lIE1BWF9TUkNTCQkzMg0KPiAtI2RlZmluZSBETUFfT1VUX1JFU09VUkNFX1RP
CTUwDQo+ICsjZGVmaW5lIERNQV9PVVRfUkVTT1VSQ0VfVE8JbXNlY3NfdG9famlmZmllcyg1MCkN
Cj4gwqAjZGVmaW5lIERNQV9SRVRSSUVTCQkyMA0KPiDCoCNkZWZpbmUgU1pfNEcJCQkoMVVMTCA8
PCAzMikNCj4gwqAjZGVmaW5lIE1BWF9TRUdfT1JERVIJCTIwIC8qIG5vIGxhcmdlciB0aGFuIDFN
IGZvcg0KPiBrbWFsbG9jIGJ1ZmZlciAqLw0KPiAtLcKgDQo+IDIuMS40DQo+IA==
