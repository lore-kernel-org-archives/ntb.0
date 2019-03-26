Return-Path: <Shyam-sundar.S-k@amd.com>
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (mail-eopbgr780053.outbound.protection.outlook.com. [40.107.78.53])
        by gmr-mx.google.com with ESMTPS id e74si1232715ite.1.2019.03.25.22.46.45
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Mar 2019 22:46:45 -0700 (PDT)
From: "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH] NTB: amd: Silence shift wrapping warning in
 amd_ntb_db_vector_mask()
Date: Tue, 26 Mar 2019 05:46:44 +0000
Message-ID: <af8b8b48-ad5e-75c2-d3fe-674b14a0b9af@amd.com>
References: <20190325092326.GE16023@kadam>
In-Reply-To: <20190325092326.GE16023@kadam>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <E6CD28DDF8FFC5459B91B993E1C43EFE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
List-ID: <linux-ntb.googlegroups.com>

T24gMy8yNS8yMDE5IDI6NTMgUE0sIERhbiBDYXJwZW50ZXIgd3JvdGU6DQo+IFRoaXMgY29kZSB0
cmlnZ2VycyBhIFNtYXRjaCB3YXJuaW5nOg0KPg0KPiAgICAgZHJpdmVycy9udGIvaHcvYW1kL250
Yl9od19hbWQuYzozMzYgYW1kX250Yl9kYl92ZWN0b3JfbWFzaygpDQo+ICAgICB3YXJuOiBzaG91
bGQgJygxIDw8IGRiX3ZlY3RvciknIGJlIGEgNjQgYml0IHR5cGU/DQo+DQo+IEkgZG9uJ3QgdGhp
bmsgImRiX3ZlY3RvciIgY2FuIGJlIGhpZ2hlciB0aGFuIDE2IHNvIHRoaXMgZG9lc24ndCBhZmZl
Y3QNCj4gcnVudGltZSwgYnV0IGl0J3MgbmljZSB0byBzaWxlbmNlIHRoZSBzdGF0aWMgY2hlY2tl
ciB3YXJuaW5nIGFuZCB3ZQ0KPiBtaWdodCBpbmNyZWFzZSAibmRldi0+ZGJfY291bnQiIGluIHRo
ZSBmdXR1cmUuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IERhbiBDYXJwZW50ZXIgPGRhbi5jYXJwZW50
ZXJAb3JhY2xlLmNvbT4NCkFja2VkLWJ5OiBTaHlhbSBTdW5kYXIgUyBLIDxTaHlhbS1zdW5kYXIu
Uy1rQGFtZC5jb20+DQo=
