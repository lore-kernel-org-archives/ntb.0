Return-Path: <Sanju.Mehta@amd.com>
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (mail-eopbgr820071.outbound.protection.outlook.com. [40.107.82.71])
        by gmr-mx.google.com with ESMTPS id j129si1328718wmj.4.2019.05.20.05.17.31
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 05:17:31 -0700 (PDT)
From: Sanjay R Mehta <sanmehta@amd.com>
Subject: Re: [PATCH 1/4] NTB: ntb_perf: Increased the number of message
 retries to 1000
Date: Mon, 20 May 2019 12:17:28 +0000
Message-ID: <e67dce79-bd64-9dd2-927c-124a34fcdcfc@amd.com>
References: <1550222279-27216-1-git-send-email-Sanju.Mehta@amd.com>
 <20190320175011.GA27156@kudzu.us>
In-Reply-To: <20190320175011.GA27156@kudzu.us>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A37FF114949484F96A13A70D522105A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
To: Jon Mason <jdmason@kudzu.us>, "Mehta, Sanju" <Sanju.Mehta@amd.com>
Cc: "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>, "allenbh@gmail.com" <allenbh@gmail.com>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-ID: <linux-ntb.googlegroups.com>

DQpPbiAzLzIwLzIwMTkgMTE6MjAgUE0sIEpvbiBNYXNvbiB3cm90ZToNCj4gT24gRnJpLCBGZWIg
MTUsIDIwMTkgYXQgMDk6MjA6MDdBTSArMDAwMCwgTWVodGEsIFNhbmp1IHdyb3RlOg0KPj4gRnJv
bTogU2FuamF5IFIgTWVodGEgPHNhbmp1Lm1laHRhQGFtZC5jb20+DQo+Pg0KPj4gd2hpbGUgd2Fp
dGluZyBmb3IgdGhlIHBlZXIgbnRiX3BlcmYgdG8gaW5pdGlhbGl6ZSBzY3JhdGNocGFkDQo+PiBy
ZWdpc3RlcnMsIGxvY2FsIHNpZGUgbnRiX3BlcmYgIG1pZ2h0IGhhdmUgYWxyZWFkeSBleGhhdXN0
ZWQgdGhlDQo+PiBtYXhpbXVtIG51bWJlciBvZiByZXRyaWVzIHdoaWNoIGlzIGN1cnJlbnRseSBz
ZXQgdG8gNTAwLiBUbyBhdm9pZA0KPj4gdGhpcyBhbmQgdG8gZ2l2ZSBsaXR0bGUgbW9yZSB0aW1l
IHRvIHRoZSBwZWVyIG50Yl9wZXJmIGZvciBzY3JhdGNocGFkDQo+PiBpbml0aWFsaXphdGlvbiwg
aW5jcmVhc2VkIHRoZSBudW1iZXIgb2YgcmV0cmllcyB0byAxMDAwDQo+Pg0KPj4gU2lnbmVkLW9m
Zi1ieTogU2FuamF5IFIgTWVodGEgPHNhbmp1Lm1laHRhQGFtZC5jb20+DQo+IFNlcmllcyBhcHBs
aWVkIHRvIG15IG50YiBicmFuY2guDQoNCkhpIEpvbiwNCg0KVGhlIGFib3ZlIHBhdGNoIHNlcmll
cyBpcyBub3QgdmlzaWJsZSBpbiA1LjItcmMxIGJyYW5jaC4gUGxlYXNlIGxldCBtZSBrbm93IHdo
ZW4gSSBjYW4gZXhwZWN0IHRoZW0gaW4gdXBzdHJlYW0ga2VybmVsLg0KDQpUaGFua3MgJiBSZWdh
cmRzLA0KDQpTYW5qYXkgTWVodGENCg0KPg0KPiBUaGFua3MsDQo+IEpvbg0KPg0KPg0KPj4gLS0t
DQo+PiAgZHJpdmVycy9udGIvdGVzdC9udGJfcGVyZi5jIHwgMiArLQ0KPj4gIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL250Yi90ZXN0L250Yl9wZXJmLmMgYi9kcml2ZXJzL250Yi90ZXN0L250Yl9wZXJmLmMN
Cj4+IGluZGV4IDJhOWQ2YjAuLmE4MjhkMGUgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL250Yi90
ZXN0L250Yl9wZXJmLmMNCj4+ICsrKyBiL2RyaXZlcnMvbnRiL3Rlc3QvbnRiX3BlcmYuYw0KPj4g
QEAgLTEwMCw3ICsxMDAsNyBAQCBNT0RVTEVfREVTQ1JJUFRJT04oIlBDSWUgTlRCIFBlcmZvcm1h
bmNlIE1lYXN1cmVtZW50IFRvb2wiKTsNCj4+ICAjZGVmaW5lIERNQV9UUklFUwkJMTAwDQo+PiAg
I2RlZmluZSBETUFfTURFTEFZCQkxMA0KPj4gIA0KPj4gLSNkZWZpbmUgTVNHX1RSSUVTCQk1MDAN
Cj4+ICsjZGVmaW5lIE1TR19UUklFUwkJMTAwMA0KPj4gICNkZWZpbmUgTVNHX1VERUxBWV9MT1cJ
CTEwMDANCj4+ICAjZGVmaW5lIE1TR19VREVMQVlfSElHSAkJMjAwMA0KPj4gIA0KPj4gLS0gDQo+
PiAyLjcuNA0KPj4NCj4+IC0tIA0KPj4gWW91IHJlY2VpdmVkIHRoaXMgbWVzc2FnZSBiZWNhdXNl
IHlvdSBhcmUgc3Vic2NyaWJlZCB0byB0aGUgR29vZ2xlIEdyb3VwcyAibGludXgtbnRiIiBncm91
cC4NCj4+IFRvIHVuc3Vic2NyaWJlIGZyb20gdGhpcyBncm91cCBhbmQgc3RvcCByZWNlaXZpbmcg
ZW1haWxzIGZyb20gaXQsIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnRiK3Vuc3Vic2NyaWJlQGdv
b2dsZWdyb3Vwcy5jb20uDQo+PiBUbyBwb3N0IHRvIHRoaXMgZ3JvdXAsIHNlbmQgZW1haWwgdG8g
bGludXgtbnRiQGdvb2dsZWdyb3Vwcy5jb20uDQo+PiBUbyB2aWV3IHRoaXMgZGlzY3Vzc2lvbiBv
biB0aGUgd2ViIHZpc2l0IGh0dHBzOi8vZ3JvdXBzLmdvb2dsZS5jb20vZC9tc2dpZC9saW51eC1u
dGIvMTU1MDIyMjI3OS0yNzIxNi0xLWdpdC1zZW5kLWVtYWlsLVNhbmp1Lk1laHRhJTQwYW1kLmNv
bS4NCj4+IEZvciBtb3JlIG9wdGlvbnMsIHZpc2l0IGh0dHBzOi8vZ3JvdXBzLmdvb2dsZS5jb20v
ZC9vcHRvdXQuDQo=
