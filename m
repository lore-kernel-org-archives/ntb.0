Return-Path: <Boris.Glimcher@dell.com>
Received: from esa6.dell-outbound.iphmx.com (esa6.dell-outbound.iphmx.com. [68.232.149.229])
        by gmr-mx.google.com with ESMTPS id s193-v6si940994oih.4.2018.05.02.01.06.28
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 May 2018 01:06:28 -0700 (PDT)
From: "Glimcher, Boris" <Boris.Glimcher@dell.com>
Subject: RE: memcpy over NTB
Date: Wed, 2 May 2018 08:06:16 +0000
Message-ID: <8A1F3ACA2F40C04FBF91985D6F491D7C01744DA0@MX302CL01.corp.emc.com>
References: <8A1F3ACA2F40C04FBF91985D6F491D7C017448F2@MX302CL01.corp.emc.com>
 <ab9e8b5c-3494-34f5-2112-3d69ad67ff1c@deltatee.com>
 <8A1F3ACA2F40C04FBF91985D6F491D7C01744B4B@MX302CL01.corp.emc.com>
 <e97625c6-657c-e635-ade8-b1501b09d141@deltatee.com>
 <8A1F3ACA2F40C04FBF91985D6F491D7C01744B65@MX302CL01.corp.emc.com>
 <b8ce2095-98d4-81ff-ebfa-00d69deee8eb@deltatee.com>
In-Reply-To: <b8ce2095-98d4-81ff-ebfa-00d69deee8eb@deltatee.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
To: Logan Gunthorpe <logang@deltatee.com>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

VGhlIHN5bmNocm9uaXphdGlvbiBpcyBub3QgYW4gaXNzdWUsIEkgYmVsaWV2ZSwgYXMgSSdtIGxv
b2tpbmcganVzdCB0byBtaXJyb3IgbGFyZ2UgbWVtb3J5IGFyZWEgZnJvbSBvbmUgc2lkZSB0byBh
bm90aGVyDQoNCi0tDQpCZXN0IHJlZ2FyZHMsIEJvcmlzDQpMZXQgbWUgZ29vZ2xlIHRoYXQgZm9y
IHlvdQ0KDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBMb2dhbiBHdW50aG9y
cGUgW21haWx0bzpsb2dhbmdAZGVsdGF0ZWUuY29tXSANClNlbnQ6IFR1ZXNkYXksIE1heSAxLCAy
MDE4IDE5OjI2DQpUbzogR2xpbWNoZXIsIEJvcmlzOyBsaW51eC1udGJAZ29vZ2xlZ3JvdXBzLmNv
bQ0KU3ViamVjdDogUmU6IG1lbWNweSBvdmVyIE5UQg0KDQpPbiA1LzEvMjAxOCAxMDoyMCBBTSwg
R2xpbWNoZXIsIEJvcmlzIHdyb3RlOg0KPiBJcyBpdCBhbHNvIHBvc3NpYmxlIHdpdGggdGhpcyBp
bi1rZXJuZWwgTlRCIGNsaWVudCB3aXRoIGEgY2hhciBkZXZpY2UgdG8gTU1BUCBzb21laG93IE1X
IHRvIHVzZXI/DQoNClllcywgdGhpcyBpcyBwb3NzaWJsZSBidXQgZ2VuZXJhbGx5IGRpc2NvdXJh
Z2VkIGZvciBkcml2ZXJzLg0KDQpJZiB5b3UgYXJlIGF0dGVtcHRpbmcgdG8gb3B0aW1pemUgZm9y
IHBlcmZvcm1hbmNlIHRoZW4gaXQncyBtdWNoIGJldHRlciB0byBzdWJtaXQgbGFyZ2UgYnVmZmVy
cyB0byBhIERNQSBlbmdpbmUuDQoNCklmIHlvdSBhcmUgdHJ5aW5nIHRvIGhhdmUgcmFuZG9tIGFj
Y2VzcyB0byB0aGUgTVcgeW91J2xsIGhhdmUgdG8gYmUgdmVyeSBjYXJlZnVsIGFib3V0IHN5bmNo
cm9uaXphdGlvbiB3aXRoIHRoZSBvcHBvc2l0ZSBzaWRlLg0KDQpMb2dhbg0K
