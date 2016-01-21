Return-Path: <Xiangliang.Yu@amd.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com (mail-bl2on0077.outbound.protection.outlook.com. [65.55.169.77])
        by gmr-mx.google.com with ESMTPS id y199si3410018ywd.5.2016.01.20.20.21.34
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Jan 2016 20:21:34 -0800 (PST)
From: "Yu, Xiangliang" <Xiangliang.Yu@amd.com>
Subject: RE: [PATCH V5 1/1] NTB: Add support for AMD PCI-Express
 Non-Transparent Bridge
Date: Thu, 21 Jan 2016 04:21:30 +0000
Message-ID: <BLUPR12MB0420FE127B3F3035FF465D95EBC30@BLUPR12MB0420.namprd12.prod.outlook.com>
References: <1453365583-9823-1-git-send-email-Xiangliang.Yu@amd.com>
 <40F65EF2B5E2254199711F58E3ACB84D99F2A613@MX104CL02.corp.emc.com>
In-Reply-To: <40F65EF2B5E2254199711F58E3ACB84D99F2A613@MX104CL02.corp.emc.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
To: "Hubbe, Allen" <Allen.Hubbe@emc.com>, "jdmason@kudzu.us" <jdmason@kudzu.us>, "dave.jiang@intel.com" <dave.jiang@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>
Cc: SPG_Linux_Kernel <SPG_Linux_Kernel@amd.com>
List-ID: <linux-ntb.googlegroups.com>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIdWJiZSwgQWxsZW4gW21haWx0
bzpBbGxlbi5IdWJiZUBlbWMuY29tXQ0KPiBTZW50OiBUaHVyc2RheSwgSmFudWFyeSAyMSwgMjAx
NiAxMTo1NCBBTQ0KPiBUbzogWXUsIFhpYW5nbGlhbmc7IGpkbWFzb25Aa3VkenUudXM7IGRhdmUu
amlhbmdAaW50ZWwuY29tOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgt
bnRiQGdvb2dsZWdyb3Vwcy5jb20NCj4gQ2M6IFNQR19MaW51eF9LZXJuZWwNCj4gU3ViamVjdDog
UkU6IFtQQVRDSCBWNSAxLzFdIE5UQjogQWRkIHN1cHBvcnQgZm9yIEFNRCBQQ0ktRXhwcmVzcyBO
b24tDQo+IFRyYW5zcGFyZW50IEJyaWRnZQ0KPiANCj4gRnJvbTogWGlhbmdsaWFuZyBZdSBbbWFp
bHRvOlhpYW5nbGlhbmcuWXVAYW1kLmNvbV0NCj4gPiBUaGlzIGFkZHMgc3VwcG9ydCBmb3IgQU1E
J3MgUENJLUV4cHJlc3MgTm9uLVRyYW5zcGFyZW50IEJyaWRnZQ0KPiA+IChOVEIpIGRldmljZSBv
biB0aGUgWmVwcGVsaW4gcGxhdGZvcm0uIFRoZSBkcml2ZXIgY29ubm5lY3RzIHRvIHRoZQ0KPiA+
IHN0YW5kYXJkIE5UQiBzdWItc3lzdGVtIGludGVyZmFjZSwgd2l0aCBtb2RpZmljYXRpb24gdG8g
YWRkIGhvb2tzIGZvcg0KPiA+IHBvd2VyIG1hbmFnZW1lbnQgaW4gYSBzZXBhcmF0ZSBwYXRjaC4g
VGhlIEFNRCBOVEIgZGV2aWNlIGhhcyAzDQo+IG1lbW9yeQ0KPiA+IHdpbmRvd3MsIDE2IGRvb3Ji
ZWxsLCAxNiBzY3JhdGNoLXBhZCByZWdpc3RlcnMsIGFuZCBzdXBwb3J0cyB1cCB0byAxNg0KPiA+
IFBDSWUgbGFuZXMgcnVubmluZyBhIEdlbjMgc3BlZWRzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1i
eTogWGlhbmdsaWFuZyBZdSA8WGlhbmdsaWFuZy5ZdUBhbWQuY29tPg0KPiANCj4gDQo+ID4gU2ln
bmVkLW9mZi1ieTogSm9uIE1hc29uIDxqZG1hc29uQGt1ZHp1LnVzPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IEFsbGVuIEh1YmJlIDxBbGxlbi5IdWJiZUBlbWMuY29tPg0KPiANCj4gSG9sZCBvbiBhIHNl
Yy4uLiB3aGF0PyAgV2hvPyAgSSBkb24ndCByZW1lbWJlciBzaWduaW5nIG9mZiBvbiB0aGlzLg0K
PiANCj4gU2lnbmVkLW9mZi1ieSBoYXMgbGVnYWwgaW1wbGljYXRpb25zIHdpdGggcmVnYXJkcyB0
byB0aGUgZGV2ZWxvcGVyIGNlcnRpZmljYXRlDQo+IG9mIG9yaWdpbi4gIFBsZWFzZSBkb24ndCBq
dXN0IHB1dCBuYW1lcyBvbiBzdHVmZiEgIEl0J3MgZm9yZ2VyeSENCg0KUGxlYXNlIGhlbHAgY2hh
bmdlIGl0IHRvIHJldmlld2VyLWJ5IHdoZW4gYXBwbHlpbmcgaXQuIFRoYW5rcyENCg==
