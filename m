Return-Path: <dave.jiang@intel.com>
Received: from mga11.intel.com (mga11.intel.com. [192.55.52.93])
        by gmr-mx.google.com with ESMTP id 12si656268pfb.1.2016.03.10.08.24.29
        for <linux-ntb@googlegroups.com>;
        Thu, 10 Mar 2016 08:24:29 -0800 (PST)
From: "Jiang, Dave" <dave.jiang@intel.com>
Subject: Re: [PATCH] ntb: fix possible NULL dereference
Date: Thu, 10 Mar 2016 16:24:28 +0000
Message-ID: <1457627059.3577.34.camel@intel.com>
References: <1457612471-26128-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1457612471-26128-1-git-send-email-sudipm.mukherjee@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <F59984587ED6824C809878F1A754E800@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Return-Path: dave.jiang@intel.com
To: "Allen.Hubbe@emc.com" <Allen.Hubbe@emc.com>, "sudipm.mukherjee@gmail.com" <sudipm.mukherjee@gmail.com>, "jdmason@kudzu.us" <jdmason@kudzu.us>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

T24gVGh1LCAyMDE2LTAzLTEwIGF0IDE3OjUxICswNTMwLCBTdWRpcCBNdWtoZXJqZWUgd3JvdGU6
DQo+IGttYWxsb2MgY2FuIGZhaWwgYW5kIHdlIHNob3VsZCBjaGVjayBmb3IgTlVMTCBiZWZvcmUg
dXNpbmcgdGhlDQo+IHBvaW50ZXINCj4gcmV0dXJuZWQgYnkga21hbGxvYy4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IFN1ZGlwIE11a2hlcmplZSA8c3VkaXAubXVraGVyamVlQGNvZGV0aGluay5jby51
az4NCkFja2VkLWJ5OiBEYXZlIEppYW5nIDxkYXZlLmppYW5nQGludGVsLmNvbT4NCg0KVGhhbmtz
IQ0KDQo+IC0tLQ0KPiDCoGRyaXZlcnMvbnRiL3Rlc3QvbnRiX3BlcmYuYyB8IDIgKysNCj4gwqAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9udGIvdGVzdC9udGJfcGVyZi5jDQo+IGIvZHJpdmVycy9udGIvdGVzdC9udGJfcGVyZi5jDQo+
IGluZGV4IGM4YTM3YmEuLmIyMWU2NDcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbnRiL3Rlc3Qv
bnRiX3BlcmYuYw0KPiArKysgYi9kcml2ZXJzL250Yi90ZXN0L250Yl9wZXJmLmMNCj4gQEAgLTU0
MSw2ICs1NDEsOCBAQCBzdGF0aWMgc3NpemVfdCBkZWJ1Z2ZzX3J1bl9yZWFkKHN0cnVjdCBmaWxl
DQo+ICpmaWxwLCBjaGFyIF9fdXNlciAqdWJ1ZiwNCj4gwqAJCXJldHVybiAwOw0KPiDCoA0KPiDC
oAlidWYgPSBrbWFsbG9jKDY0LCBHRlBfS0VSTkVMKTsNCj4gKwlpZiAoIWJ1ZikNCj4gKwkJcmV0
dXJuIC1FTk9NRU07DQo+IMKgCW91dF9vZmZzZXQgPSBzbnByaW50ZihidWYsIDY0LCAiJWRcbiIs
IHBlcmYtPnJ1bik7DQo+IMKgCXJldCA9IHNpbXBsZV9yZWFkX2Zyb21fYnVmZmVyKHVidWYsIGNv
dW50LCBvZmZwLCBidWYsDQo+IG91dF9vZmZzZXQpOw0KPiDCoAlrZnJlZShidWYpOw==
