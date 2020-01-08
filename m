Return-Path: <david.laight@aculab.com>
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com. [207.82.80.151])
        by gmr-mx.google.com with ESMTPS id ba12si165640edb.3.2020.01.08.09.39.46
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jan 2020 09:39:46 -0800 (PST)
From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [RFT 00/13] iomap: Constify ioreadX() iomem argument
Date: Wed, 8 Jan 2020 17:39:42 +0000
Message-ID: <334434313e1642768995acc03a51214f@AcuMS.aculab.com>
References: <1578415992-24054-1-git-send-email-krzk@kernel.org>
 <CAMuHMdW4ek0OYQDrrbcpZjNUTTP04nSbwkmiZvBmKcU=PQM9qA@mail.gmail.com>
 <CAMuHMdUBmYtJKtSYzS_5u67hVZOqcKSgFY1rDGme6gLNRBJ_gA@mail.gmail.com>
 <CAJKOXPfq9vS4kSyx1jOPHBvi9_HjviRv0LU2A8ZwdmqgUuebHQ@mail.gmail.com>
 <2355489c-a207-1927-54cf-85c04b62f18f@c-s.fr>
 <CAMuHMdV=-m-eN4rOa=XQhk2oBDZZwgXXMU6RMVQRVsc6ALyeoA@mail.gmail.com>
 <00a43e5c-0708-d49a-9cc4-eb2ce8b4cf99@c-s.fr>
In-Reply-To: <00a43e5c-0708-d49a-9cc4-eb2ce8b4cf99@c-s.fr>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
To: 'Christophe Leroy' <christophe.leroy@c-s.fr>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rich Felker <dalias@libc.org>, Jiri Slaby <jirislaby@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, David Airlie <airlied@linux.ie>, Jason Wang <jasowang@redhat.com>, DRI Development <dri-devel@lists.freedesktop.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, netdev <netdev@vger.kernel.org>, Paul Mackerras <paulus@samba.org>, Linux-Arch <linux-arch@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Helge Deller <deller@gmx.de>, Linux-sh list <linux-sh@vger.kernel.org>, Alexey Brodkin <abrodkin@synopsys.com>, Ben
 Skeggs <bskeggs@redhat.com>, "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, Dave Airlie <airlied@redhat.com>, Matt
 Turner <mattst88@gmail.com>, arcml <linux-snps-arc@lists.infradead.org>, Nick Kossifidis <mickflemm@gmail.com>, Allen Hubbe <allenbh@gmail.com>, Arnd Bergmann <arnd@arndb.de>, alpha <linux-alpha@vger.kernel.org>, Ivan
 Kokshaysky <ink@jurassic.park.msu.ru>, Thomas Gleixner <tglx@linutronix.de>, Mauro Carvalho Chehab <mchehab@kernel.org>, Kalle Valo <kvalo@codeaurora.org>, Richard Henderson <rth@twiddle.net>, Parisc List <linux-parisc@vger.kernel.org>, Vineet Gupta <vgupta@synopsys.com>, linux-wireless <linux-wireless@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Daniel
 Vetter <daniel@ffwll.ch>, Jon Mason <jdmason@kudzu.us>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>, Andrew Morton <akpm@linux-foundation.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "David S. Miller" <davem@davemloft.net>
List-ID: <linux-ntb.googlegroups.com>

RnJvbTogQ2hyaXN0b3BoZSBMZXJveQ0KPiBTZW50OiAwOCBKYW51YXJ5IDIwMjAgMDg6NDkNCi4u
Lg0KPiBBbmQgYXMgcG9pbnRlZCBieSBBcm5kLCB0aGUgdm9sYXRpbGUgaXMgcmVhbGx5IG9ubHkg
bmVjZXNzYXJ5IGZvciB0aGUNCj4gZGVyZWZlcmVuY2UgaXRzZWxmLCBzaG91bGQgdGhlIGFyY2gg
dXNlIGRlcmVmZXJlbmNpbmcuDQoNCkkndmUgaGFkIHRyb3VibGUgd2l0aCBzb21lIHZlcnNpb25z
IG9mIGdjYyBhbmQgcmVhZGluZyBvZiAndm9sYXRpbGUgdW5zaWduZWQgY2hhciAqJy4NCkl0IHRl
bmRlZCB0byBmb2xsb3cgdGhlIG1lbW9yeSByZWFkIHdpdGggYW4gZXh0cmEgbWFzayB3aXRoIDB4
ZmYuDQooSSBzdXNwZWN0IHRoYXQgaW50ZXJuYWxseSB0aGUgdmFsdWUgbGFuZGVkIGludG8gYSB0
ZW1wb3JhcnkgJ2ludCcgdmFyaWFibGUuKQ0KDQpJIGdvdCBiZXR0ZXIgY29kZSB1c2luZyBtZW1v
cnkgYmFycmllcnMuDQpTbyBwdXR0aW5nIGFuIGFzbSBiYXJyaWVyIGZvciB0aGUgZXhhY3QgbG9j
YXRpb24gb2YgdGhlIG1lbW9yeSByZWFkDQplaXRoZXIgc2lkZSBvZiB0aGUgcmVhZCBzaG91bGQg
aGF2ZSB0aGUgZGVzaXJlZCBlZmZlY3Qgd2l0aG91dCBhZGRpbmcNCmV4dHJhIGluc3RydWN0aW9u
cy4NCihZb3UgbWlnaHQgdGhpbmsgJ3ZvbGF0aWxlJyB3b3VsZCBtZWFuIHRoYXQgLSBidXQgaXQg
ZG9lc24ndC4pDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJy
YW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lz
dHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

