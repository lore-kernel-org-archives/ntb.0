Return-Path: <Boris.Glimcher@dell.com>
Received: from esa1.dell-outbound.iphmx.com (esa1.dell-outbound.iphmx.com. [68.232.153.90])
        by gmr-mx.google.com with ESMTPS id k15-v6si509877ybm.1.2018.05.01.09.21.06
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 09:21:06 -0700 (PDT)
From: "Glimcher, Boris" <Boris.Glimcher@dell.com>
Subject: RE: memcpy over NTB
Date: Tue, 1 May 2018 16:20:53 +0000
Message-ID: <8A1F3ACA2F40C04FBF91985D6F491D7C01744B65@MX302CL01.corp.emc.com>
References: <8A1F3ACA2F40C04FBF91985D6F491D7C017448F2@MX302CL01.corp.emc.com>
 <ab9e8b5c-3494-34f5-2112-3d69ad67ff1c@deltatee.com>
 <8A1F3ACA2F40C04FBF91985D6F491D7C01744B4B@MX302CL01.corp.emc.com>
 <e97625c6-657c-e635-ade8-b1501b09d141@deltatee.com>
In-Reply-To: <e97625c6-657c-e635-ade8-b1501b09d141@deltatee.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
To: Logan Gunthorpe <logang@deltatee.com>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

SXMgaXQgYWxzbyBwb3NzaWJsZSB3aXRoIHRoaXMgaW4ta2VybmVsIE5UQiBjbGllbnQgd2l0aCBh
IGNoYXIgZGV2aWNlIHRvIE1NQVAgc29tZWhvdyBNVyB0byB1c2VyPyANCg0KU28gdGhlIGtlcm5l
bCBjb2RlIHdpbGwgYmUgbGltaXRlZCBqdXN0IHRvIHNldHVwIHRoZSBjb25uZWN0aW9uIHNlY3Rp
b24gYW5kIHdpbGwgbm90IHRha2UgcGFydCBkdXJpbmcgZGF0YSB0cmFuc2ZlciBhdCBhbGw/DQpD
YXVzZSBJIHNlZSB0aGF0IGV2ZW50dWFsbHkga2VybmVsIGRyaXZlciBqdXN0IGRvZXMgIm1lbWNw
eV90b2lvIi4uLg0KDQpBbSBJIG1pc3NpbmcgYW55dGhpbmc/DQoNCi0tDQpCZXN0IHJlZ2FyZHMs
IEJvcmlzDQpMZXQgbWUgZ29vZ2xlIHRoYXQgZm9yIHlvdQ0KDQoNCi0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQpGcm9tOiBMb2dhbiBHdW50aG9ycGUgW21haWx0bzpsb2dhbmdAZGVsdGF0ZWUu
Y29tXSANClNlbnQ6IFR1ZXNkYXksIE1heSAxLCAyMDE4IDE5OjE1DQpUbzogR2xpbWNoZXIsIEJv
cmlzOyBsaW51eC1udGJAZ29vZ2xlZ3JvdXBzLmNvbQ0KU3ViamVjdDogUmU6IG1lbWNweSBvdmVy
IE5UQg0KDQpPbiA1LzEvMjAxOCAxMDowOSBBTSwgR2xpbWNoZXIsIEJvcmlzIHdyb3RlOg0KPiBT
byBvbmUgYXBwcm9hY2ggY291bGQgYmUgdG8gbW9kaWZ5IGtlcm5lbCBkcml2ZXIgYW5kIHVzZSBp
b2N0bCBmcm9tIHVzZXIgc3BhY2UgdG8gc3VibWl0IGJ1ZmZlcnMgZm9yIHRyYW5zZmVyIGFuZCBr
ZXJuZWwgZHJpdmVyIHdpbGwgY29weSBvciB1c2UgZG1hIHRvIGNvcHkgdGhlIGJ1ZmZlciB0byB0
aGUgb3RoZXIgc2lkZT8NCj4gV2hhdCBkbyB5b3UgdGhpbms/IFZhbGlkPw0KDQpZZXMsIEkgdGhp
bmsgdGhhdCdkIGJlIGEgZ29vZCBjaG9pY2UuIENyZWF0ZSBhbiBpbi1rZXJuZWwgTlRCIGNsaWVu
dCB3aXRoIGEgY2hhciBkZXZpY2Ugd2hpY2ggaGFzIGFuIElPQ1RMIG9yIHJlYWQvd3JpdGUgaW50
ZXJmYWNlIGZvciBzdWJtaXR0aW5nIGJ1ZmZlcnMuIFRoaXMga2VlcHMgTVcgc2V0dXAgYW5kIERN
QSBvcGVyYXRpb25zIGluc2lkZSB0aGUga2VybmVsLg0KDQpMb2dhbg0K
