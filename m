Return-Path: <david.laight@aculab.com>
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com. [207.82.80.151])
        by gmr-mx.google.com with ESMTPS id d8si976727lji.0.2020.02.24.06.00.09
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Feb 2020 06:00:09 -0800 (PST)
From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [RESEND PATCH v2 9/9] ath5k: Constify ioreadX() iomem argument
 (as in generic implementation)
Date: Mon, 24 Feb 2020 14:00:06 +0000
Message-ID: <ef12bfd658504d928996681f8a9ee96f@AcuMS.aculab.com>
References: <20200219175007.13627-1-krzk@kernel.org>
 <20200219175007.13627-10-krzk@kernel.org>
 <518a9023-f802-17b3-fca5-582400bc34ae@gmail.com> <20200224124744.GA1949@pi3>
 <CAMuHMdVev0PLF=8bD3nHrhcU9UgM-DAgdQpXi09PgvAxdbt24A@mail.gmail.com>
In-Reply-To: <CAMuHMdVev0PLF=8bD3nHrhcU9UgM-DAgdQpXi09PgvAxdbt24A@mail.gmail.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
To: 'Geert Uytterhoeven' <geert@linux-m68k.org>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rich Felker <dalias@libc.org>, Jiri Slaby <jirislaby@gmail.com>, Geert
 Uytterhoeven <geert+renesas@glider.be>, "Michael S. Tsirkin" <mst@redhat.com>, David Airlie <airlied@linux.ie>, Jason Wang <jasowang@redhat.com>, DRI Development <dri-devel@lists.freedesktop.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, netdev <netdev@vger.kernel.org>, Paul Mackerras <paulus@samba.org>, Linux-Arch <linux-arch@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Helge Deller <deller@gmx.de>, Linux-sh list <linux-sh@vger.kernel.org>, Alexey Brodkin <abrodkin@synopsys.com>, Ben
 Skeggs <bskeggs@redhat.com>, "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, Dave Airlie <airlied@redhat.com>, Matt
 Turner <mattst88@gmail.com>, arcml <linux-snps-arc@lists.infradead.org>, Nick Kossifidis <mickflemm@gmail.com>, Allen Hubbe <allenbh@gmail.com>, Arnd Bergmann <arnd@arndb.de>, alpha <linux-alpha@vger.kernel.org>, Ivan
 Kokshaysky <ink@jurassic.park.msu.ru>, Thomas Gleixner <tglx@linutronix.de>, Mauro Carvalho Chehab <mchehab@kernel.org>, Kalle Valo <kvalo@codeaurora.org>, Richard Henderson <rth@twiddle.net>, Parisc List <linux-parisc@vger.kernel.org>, Vineet Gupta <vgupta@synopsys.com>, linux-wireless <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Daniel
 Vetter <daniel@ffwll.ch>, Jon Mason <jdmason@kudzu.us>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>, Andrew Morton <akpm@linux-foundation.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "David S. Miller" <davem@davemloft.net>
List-ID: <linux-ntb.googlegroups.com>

RnJvbTogR2VlcnQgVXl0dGVyaG9ldmVuDQo+IFNlbnQ6IDI0IEZlYnJ1YXJ5IDIwMjAgMTI6NTQN
Cj4gVG86IEtyenlzenRvZiBLb3psb3dza2kgPGtyemtAa2VybmVsLm9yZz4NCi4uLg0KPiA+ID4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvYXRoL2F0aDVrL2FoYi5jIGIvZHJp
dmVycy9uZXQvd2lyZWxlc3MvYXRoL2F0aDVrL2FoYi5jDQo+ID4gPiA+IGluZGV4IDJjOWNlYzhi
NTNkOS4uOGJkMDFkZjM2OWZiIDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9kcml2ZXJzL25ldC93aXJl
bGVzcy9hdGgvYXRoNWsvYWhiLmMNCj4gPiA+ID4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
YXRoL2F0aDVrL2FoYi5jDQo+ID4gPiA+IEBAIC0xMzgsMTggKzEzOCwxOCBAQCBzdGF0aWMgaW50
IGF0aF9haGJfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiA+ID4NCj4g
PiA+ID4gICAgIGlmIChiY2ZnLT5kZXZpZCA+PSBBUjVLX1NSRVZfQVIyMzE1X1I2KSB7DQo+ID4g
PiA+ICAgICAgICAgICAgIC8qIEVuYWJsZSBXTUFDIEFIQiBhcmJpdHJhdGlvbiAqLw0KPiA+ID4g
PiAtICAgICAgICAgICByZWcgPSBpb3JlYWQzMigodm9pZCBfX2lvbWVtICopIEFSNUtfQVIyMzE1
X0FIQl9BUkJfQ1RMKTsNCj4gPiA+ID4gKyAgICAgICAgICAgcmVnID0gaW9yZWFkMzIoKGNvbnN0
IHZvaWQgX19pb21lbSAqKSBBUjVLX0FSMjMxNV9BSEJfQVJCX0NUTCk7DQo+ID4gPg0KPiA+ID4g
V2hpbGUgSSB1bmRlcnN0YW5kIHdoeSB0aGUgcGFyYW1ldGVyIG9mIGlvcmVhZDMyIHNob3VsZCBi
ZSBjb25zdCwgSQ0KPiA+ID4gZG9uJ3Qgc2VlIGEgcmVhc29uIGZvciB0aGVzZSBjYXN0cyBvbiB0
aGUgdXNlcnMnIHNpZGUuIFdoYXQgZG9lcyBpdA0KPiA+ID4gYnJpbmcgZXhjZXB0IGxvbmdlciBj
b2RlIHRvIHJlYWQ/DQo+ID4NCj4gPiBCZWNhdXNlIHRoZSBhcmd1bWVudCBpcyBhbiBpbnQ6DQo+
ID4NCj4gPiBkcml2ZXJzL25ldC93aXJlbGVzcy9hdGgvYXRoNWsvYWhiLmM6IEluIGZ1bmN0aW9u
IOKAmGF0aF9haGJfcHJvYmXigJk6DQo+ID4gZHJpdmVycy9uZXQvd2lyZWxlc3MvYXRoL2F0aDVr
L2FoYi5jOjE0MToxODogd2FybmluZzogcGFzc2luZyBhcmd1bWVudCAxIG9mIOKAmGlvcmVhZDMy
4oCZIG1ha2VzIHBvaW50ZXINCj4gZnJvbSBpbnRlZ2VyIHdpdGhvdXQgYSBjYXN0IFstV2ludC1j
b252ZXJzaW9uXQ0KPiA+ICAgIHJlZyA9IGlvcmVhZDMyKEFSNUtfQVIyMzE1X0FIQl9BUkJfQ1RM
KTsNCj4gDQo+IFRoYXQncyBhbiBhcmd1bWVudCBmb3Iga2VlcGluZyB0aGUgY2FzdCB0byAidm9p
ZCBfX2lvbWVtICoiLCBub3QgZm9yDQo+IGFkZGluZyB0aGUgImNvbnN0IiwgcmlnaHQ/DQoNCk9y
IG1vcmUgbGlrZWx5IGNoYW5nZSB0aGUgZGVmaW5pdGlvbnMgdG8gdXNlIGEgc3RydWN0IGZvciB0
aGUgbGF5b3V0Lg0KVGhhdCBhbHNvIHN0b3BzIHRoZSBjb25zdGFudHMgYmVpbmcgdXNlZCBpbiB0
aGUgd3JvbmcgcGxhY2UuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNp
ZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsN
ClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

