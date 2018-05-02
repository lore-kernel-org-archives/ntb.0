Return-Path: <Boris.Glimcher@dell.com>
Received: from esa6.dell-outbound.iphmx.com (esa6.dell-outbound.iphmx.com. [68.232.149.229])
        by gmr-mx.google.com with ESMTPS id z21si1004116uae.1.2018.05.02.09.39.20
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 May 2018 09:39:20 -0700 (PDT)
From: "Glimcher, Boris" <Boris.Glimcher@dell.com>
Subject: RE: memcpy over NTB
Date: Wed, 2 May 2018 16:38:53 +0000
Message-ID: <8A1F3ACA2F40C04FBF91985D6F491D7C0174554A@MX302CL01.corp.emc.com>
References: <8A1F3ACA2F40C04FBF91985D6F491D7C017448F2@MX302CL01.corp.emc.com>
 <ab9e8b5c-3494-34f5-2112-3d69ad67ff1c@deltatee.com>
 <8A1F3ACA2F40C04FBF91985D6F491D7C01744B4B@MX302CL01.corp.emc.com>
 <e97625c6-657c-e635-ade8-b1501b09d141@deltatee.com>
 <8A1F3ACA2F40C04FBF91985D6F491D7C01744B65@MX302CL01.corp.emc.com>
 <b8ce2095-98d4-81ff-ebfa-00d69deee8eb@deltatee.com>
 <8A1F3ACA2F40C04FBF91985D6F491D7C01744DA0@MX302CL01.corp.emc.com>
 <4f05cc88-5ad6-e8f0-070c-0cc62d30d878@deltatee.com>
In-Reply-To: <4f05cc88-5ad6-e8f0-070c-0cc62d30d878@deltatee.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
To: Logan Gunthorpe <logang@deltatee.com>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

SW52YWxpZCBzaXR1YXRpb24uIE9uZSBzaWRlIGlzIGFsd2F5cyB3cml0aW5nLiBPdGhlciBzaWRl
IGlzIG5ldmVyIHJlYWRpbmcgdW50aWwgZmlyc3Qgc2lkZSBpcyBkb3duLiAoSGlnaCBBdmFpbGFi
aWxpdHkgc3R1ZmYpDQoNCi0tDQpCZXN0IHJlZ2FyZHMsIEJvcmlzDQpMZXQgbWUgZ29vZ2xlIHRo
YXQgZm9yIHlvdQ0KDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBsaW51eC1u
dGJAZ29vZ2xlZ3JvdXBzLmNvbSBbbWFpbHRvOmxpbnV4LW50YkBnb29nbGVncm91cHMuY29tXSBP
biBCZWhhbGYgT2YgTG9nYW4gR3VudGhvcnBlDQpTZW50OiBXZWRuZXNkYXksIE1heSAyLCAyMDE4
IDE4OjQzDQpUbzogR2xpbWNoZXIsIEJvcmlzOyBsaW51eC1udGJAZ29vZ2xlZ3JvdXBzLmNvbQ0K
U3ViamVjdDogUmU6IG1lbWNweSBvdmVyIE5UQg0KDQpPbiA1LzIvMjAxOCAyOjA2IEFNLCBHbGlt
Y2hlciwgQm9yaXMgd3JvdGU6DQo+IFRoZSBzeW5jaHJvbml6YXRpb24gaXMgbm90IGFuIGlzc3Vl
LCBJIGJlbGlldmUsIGFzIEknbSBsb29raW5nIGp1c3QgdG8gDQo+IG1pcnJvciBsYXJnZSBtZW1v
cnkgYXJlYSBmcm9tIG9uZSBzaWRlIHRvIGFub3RoZXINCg0KV2hhdCBoYXBwZW5zIGlmIG9uZSBz
aWRlIGlzIHJlYWRpbmcgd2hpbGUgdGhlIG90aGVyIHNpZGUgaXMgY2hhbmdpbmcgdGhlIG1lbW9y
eT8gVGhleSdkIHJlYWQgc29tZSBvZiB0aGUgZGF0YSBiZWZvcmUgdGhlIGNoYW5nZSBhbmQgc29t
ZSBvZiB0aGUgZGF0YSBhZnRlciB0aGUgY2hhbmdlIHJlc3VsdGluZyBpbiBpbmNvbnNpc3RlbnQg
ZGF0YS4gImp1c3QgbWlycm9yaW5nIiANCmRvZXNuJ3Qgc29sdmUgdGhvc2UgaXNzdWVzLg0KDQpM
b2dhbg0KDQotLQ0KWW91IHJlY2VpdmVkIHRoaXMgbWVzc2FnZSBiZWNhdXNlIHlvdSBhcmUgc3Vi
c2NyaWJlZCB0byB0aGUgR29vZ2xlIEdyb3VwcyAibGludXgtbnRiIiBncm91cC4NClRvIHVuc3Vi
c2NyaWJlIGZyb20gdGhpcyBncm91cCBhbmQgc3RvcCByZWNlaXZpbmcgZW1haWxzIGZyb20gaXQs
IHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnRiK3Vuc3Vic2NyaWJlQGdvb2dsZWdyb3Vwcy5jb20u
DQpUbyBwb3N0IHRvIHRoaXMgZ3JvdXAsIHNlbmQgZW1haWwgdG8gbGludXgtbnRiQGdvb2dsZWdy
b3Vwcy5jb20uDQpUbyB2aWV3IHRoaXMgZGlzY3Vzc2lvbiBvbiB0aGUgd2ViIHZpc2l0IGh0dHBz
Oi8vZ3JvdXBzLmdvb2dsZS5jb20vZC9tc2dpZC9saW51eC1udGIvNGYwNWNjODgtNWFkNi1lOGYw
LTA3MGMtMGNjNjJkMzBkODc4JTQwZGVsdGF0ZWUuY29tLg0KRm9yIG1vcmUgb3B0aW9ucywgdmlz
aXQgaHR0cHM6Ly9ncm91cHMuZ29vZ2xlLmNvbS9kL29wdG91dC4NCg==
