Return-Path: <Xiangliang.Yu@amd.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com (mail-bl2on0066.outbound.protection.outlook.com. [65.55.169.66])
        by gmr-mx.google.com with ESMTPS id w126si413882ywe.6.2016.01.06.18.53.59
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Jan 2016 18:53:59 -0800 (PST)
From: "Yu, Xiangliang" <Xiangliang.Yu@amd.com>
Subject: RE: [PATCH V2 1/3] NTB: Add AMD PCI-Express NTB driver
Date: Thu, 7 Jan 2016 02:53:55 +0000
Message-ID: <BLUPR12MB0420CA022C20D8EDA7D8F563EBF50@BLUPR12MB0420.namprd12.prod.outlook.com>
References: <1450878175-9300-1-git-send-email-Xiangliang.Yu@amd.com>
	<CAPoiz9znO1QT9Fphtmf4Wp2Tkvm1H-thy2=SrPi_dT9uQ4HoMQ@mail.gmail.com>
	<40F65EF2B5E2254199711F58E3ACB84D99EF72E1@MX104CL02.corp.emc.com>
 <CAPoiz9y3j8=kMzZzRVrBy+0txpLgRYeq5Es51KPPau6vKv1pxA@mail.gmail.com>
In-Reply-To: <CAPoiz9y3j8=kMzZzRVrBy+0txpLgRYeq5Es51KPPau6vKv1pxA@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
To: Jon Mason <jdmason@kudzu.us>, "Hubbe, Allen" <Allen.Hubbe@emc.com>
Cc: Dave Jiang <dave.jiang@intel.com>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>, linux-kernel <linux-kernel@vger.kernel.org>, SPG_Linux_Kernel <SPG_Linux_Kernel@amd.com>
List-ID: <linux-ntb.googlegroups.com>

PiA+DQo+ID4+ID4gKyNkZWZpbmUgbmRldl9wZGV2KG5kZXYpICgobmRldiktPm50Yi5wZGV2KSAj
ZGVmaW5lDQo+IG5kZXZfbmFtZShuZGV2KQ0KPiA+PiA+ICtwY2lfbmFtZShuZGV2X3BkZXYobmRl
dikpICNkZWZpbmUgbmRldl9kZXYobmRldikNCj4gPj4gPiArKCZuZGV2X3BkZXYobmRldiktPmRl
dikgI2RlZmluZSBudGJfbmRldihudGIpIGNvbnRhaW5lcl9vZihudGIsDQo+ID4+ID4gK3N0cnVj
dCBhbWRfbnRiX2RldiwgbnRiKSAjZGVmaW5lIGhiX25kZXYod29yaykgY29udGFpbmVyX29mKHdv
cmssDQo+ID4+ID4gK3N0cnVjdCBhbWRfbnRiX2RldiwNCj4gPj4gaGJfdGltZXIud29yaykNCj4g
Pj4gPiArI2RlZmluZSBudGJfaG90cGx1Z19uZGV2KGNvbnRleHQpIChjb250YWluZXJfb2YoKGNv
bnRleHQpLCAgICAgXA0KPiA+PiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBudGJf
YWNwaV9ob3RwbHVnX2NvbnRleHQsIGhwKS0+bmRldikNCj4gPj4NCj4gPj4gU2VlbXMgbGlrZSB0
aGVzZSBhcmUgaGlkaW5nIHRoaW5ncyB0b28uICBQbGVhc2UgdXNlIHRoZW0gZGlyZWN0bHkgKG9y
DQo+ID4+IGF0IGxlYXN0IHB1dCB0aGVtIGluIHRoZSBDIGZpbGUgYW5kIG5vdCB0aGUgaGVhZGVy
IGZpbGUpLg0KPiA+DQo+ID4gSSBsaWtlIHRoZXNlIG1hY3JvcyBmb3IgdXAvZG93biBjYXN0aW5n
LiAgUHV0dGluZyB0aGVtIGNsb3NlIHRvIHRoZQ0KPiBzdHJ1Y3R1cmUgZGVmaW5pdGlvbiBzZWVt
cyBhcHByb3ByaWF0ZSB0byBtZSwgdG9vLiAgSSB3b3VsZCByYXRoZXIgc2VlIHRoZW0NCj4gbW92
ZWQgdG8gcmlnaHQgYmVsb3cgdGhlIGRlZmluaXRpb24gb2Ygc3RydWN0IGFtZF9udGJfZGV2LCBp
bnN0ZWFkIG9mIHRvIHRoZQ0KPiBjIGZpbGUuICBUaGF0IGlzIG15IG9waW5pb24sIGJ1dCBKb24g
Y2FuIG1ha2UgdGhlIGZpbmFsIGRlY2lzaW9uIG9uIGl0Lg0KPiANCj4gTXkgb3BpbmlvbiB3YXNu
J3Qgc3VwZXIgc3Ryb25nIG9uIHRoZXNlLiAgSWYgQWxsZW4gaXMgZmluZSB3aXRoIHRoZW0sIHRo
ZW4NCj4gZ29vZCBlbm91Z2ggZm9yIG1lIDopDQoNCkFncmVlIHdpdGggQWxsZW4ncyBvcGluaW9u
Lg0KDQo+IA0KPiA+IEhvd2V2ZXIsIHRoZXNlIGluIHBhcnRpY3VsYXIgYXJlIGJ1Z2d5Og0KPiA+
DQo+ID4+ID4gKyNkZWZpbmUgbnRiX25kZXYobnRiKSBjb250YWluZXJfb2YobnRiLCBzdHJ1Y3Qg
YW1kX250Yl9kZXYsIG50YikNCj4gPj4gPiArI2RlZmluZSBoYl9uZGV2KHdvcmspIGNvbnRhaW5l
cl9vZih3b3JrLCBzdHJ1Y3QgYW1kX250Yl9kZXYsDQo+ID4+IGhiX3RpbWVyLndvcmspDQo+ID4N
Cj4gPiBOb3RlOiAibnRiIiB3aWxsIGJlIHJlcGxhY2VkIGluIGFsbCBvY2N1cnJlbmNlcyB0byB0
aGUgcmlnaHQuICBUaGlzIG9ubHkgd29ya3MNCj4gaWYgdGhlIG5hbWUgIm50YiIgaXMgcGFzc2Vk
IGFzIHRoZSBhcmd1bWVudC4gIElmIHRoZSBhcmd1bWVudCBpcyBuYW1lZCAiZm9vIiwNCj4gaXQg
d2lsbCBlaXRoZXIgZmFpbCBhdCBjb21waWxlIHRpbWUgdG8gZmluZCB0aGUgbWVtYmVyICJmb28i
IGluIHN0cnVjdA0KPiBhbWRfbnRiX2Rldiwgb3Igd29yc2UsIGl0IHdpbGwgaGlkZSBhIGJ1ZyBh
Y2Nlc3NpbmcgdGhlIHdyb25nIG1lbWJlciBvZg0KPiB0aGUgc3RydWN0Lg0KPiA+DQo+ID4gUmVu
YW1lIHRoZSBtYWNybyBwYXJhbWV0ZXIgX19udGIuDQo+IA0KPiBHb29kIGNhbGwuICBQbGVhc2Ug
bWFrZSB0aGUgbmVjZXNzYXJ5IG1vZHMgWGlhbmdsaWFuZy4NCg0KT2sNCg==
