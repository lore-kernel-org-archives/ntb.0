Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwdur.emc.com (mailuogwdur.emc.com. [128.221.224.79])
        by gmr-mx.google.com with ESMTPS id sg1si1769051pbb.1.2015.07.13.07.23.23
        for <linux-ntb@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jul 2015 07:23:24 -0700 (PDT)
From: "Hubbe, Allen" <Allen.Hubbe@emc.com>
Subject: RE: [PATCH] NTB: Fix dereference before check
Date: Mon, 13 Jul 2015 14:23:02 +0000
Message-ID: <40F65EF2B5E2254199711F58E3ACB84D8BD96CC3@MX104CL02.corp.emc.com>
References: <bb4dd048e673ff6a7ccb49610873f8b0b41cfc1d.1436201347.git.Allen.Hubbe@emc.com>
 <CAPoiz9ym5s7emxbBSAAZehe5y_fXrAY5DkC4Y8VzuD=s3XSahw@mail.gmail.com>
In-Reply-To: <CAPoiz9ym5s7emxbBSAAZehe5y_fXrAY5DkC4Y8VzuD=s3XSahw@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
To: Jon Mason <jdmason@kudzu.us>
Cc: "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>, Dave Jiang <dave.jiang@intel.com>
List-ID: <linux-ntb.googlegroups.com>

RnJvbTogSm9uIE1hc29uDQo+IE9uIE1vbiwgSnVsIDYsIDIwMTUgYXQgMTI6NTAgUE0sIEFsbGVu
IEh1YmJlIDxBbGxlbi5IdWJiZUBlbWMuY29tPg0KPiB3cm90ZToNCj4gPiBSZW1vdmUgZWFybHkg
ZGVyZWZlcmVuY2Ugb2YgYSBwb2ludGVyIHRoYXQgaXMgY2hlY2tlZCBsYXRlciBpbiB0aGUNCj4g
Y29kZS4NCj4gDQo+IExvb2tzIGdvb2QgdG8gbWUuICBJIGFzc3VtZSB0aGlzIGJ1ZyBmaXggc2hv
dWxkIGJlIHB1c2hlZCB0byBMaW51cywNCj4gYW5kIGFwcGxpZWQgcHJpb3IgdG8gYW55IG9mIHRo
ZSBvZiBvdGhlciBwYXRjaGVzIHlvdSBoYXZlIHNlbnQgb3V0Lg0KPiBZZXM/DQo+IA0KPiBUaGFu
a3MsDQo+IEpvbg0KDQpTdXJlLCB0aGlzIGNhbiBiZSBwbGFjZWQgYWhlYWQgb2YgdGhlIG90aGVy
IHBhdGNoZXMuDQo=
