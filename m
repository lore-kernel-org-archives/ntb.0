Return-Path: <Gary.Hook@amd.com>
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (mail-dm3nam05on0629.outbound.protection.outlook.com. [2a01:111:f400:fe51::629])
        by gmr-mx.google.com with ESMTPS id f188si670303wme.0.2019.05.09.13.03.22
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 09 May 2019 13:03:22 -0700 (PDT)
From: Gary R Hook <ghook@amd.com>
Subject: Re: Fwd: AMD IO_PAGE_FAULT w/NTB on Write ops?
Date: Thu, 9 May 2019 20:03:17 +0000
Message-ID: <8e4ccf44-9e4f-8007-ddcc-431440f9d533@amd.com>
References: 
 <CAOQPn8sX2G-Db-ZiFpP2SMKbkQnPyk63UZijAY0we+DoZsmDtQ@mail.gmail.com>
 <CAADLhr49ke_3s25gW11qZ+H-Jjje-E00WMHiMDbKU=mcCQtb3g@mail.gmail.com>
 <cdcd00e9-056b-3364-cfbc-5bcb5bcff91e@amd.com>
 <CAOQPn8sQ+B97UptHpxJgdmcMxBZrqGynQR8qTc3q77fAODRH-A@mail.gmail.com>
In-Reply-To: 
 <CAOQPn8sQ+B97UptHpxJgdmcMxBZrqGynQR8qTc3q77fAODRH-A@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB3AB0C78BEA1A4DA8BDB947B84C94B1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
To: Eric Pilmore <epilmore@gigaio.com>, "Mehta, Sanju" <Sanju.Mehta@amd.com>
Cc: S Taylor <staylor@gigaio.com>, D Meyer <dmeyer@gigaio.com>, linux-ntb <linux-ntb@googlegroups.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
List-ID: <linux-ntb.googlegroups.com>

T24gNC8yNC8xOSA1OjA0IFBNLCBFcmljIFBpbG1vcmUgd3JvdGU6DQo+IE9uIFR1ZSwgQXByIDIz
LCAyMDE5IGF0IDQ6MDAgQU0gU2FuamF5IFIgTWVodGEgPHNhbm1laHRhQGFtZC5jb20+IHdyb3Rl
Og0KPj4NCj4+DQo+Pj4gQU1ELVZpOiBFdmVudCBsb2dnZWQgW0lPX1BBR0VfRkFVTFQgZGV2aWNl
PTIzOjAxLjIgZG9tYWluPTB4MDAwMA0KPj4+IGFkZHJlc3M9MHgwMDAwMDAwMGZkZTFjMThjIGZs
YWdzPTB4MDA3MF0NCj4+DQo+PiB0aGUgYWRkcmVzcyBpbiB0aGUgYWJvdmUgbG9nIGxvb2tzIHRv
IGJlIHBoeXNpY2FsIGFkZHJlc3Mgb2YgbWVtb3J5IHdpbmRvdy4gQW0gSSBSaWdodD8NCj4+DQo+
PiBJZiB5ZXMgdGhlbiwgdGhlIGZpcnN0IHBhcmFtZXRlciBvZiBkbWFfYWxsb2NfY29oZXJlbnQo
KSB0byBiZSBwYXNzZWQgYXMgYmVsb3csDQo+Pg0KPj4gZG1hX2FsbG9jX2NvaGVyZW50KCZudGIt
PnBkZXYtPmRldiwgLi4uKWluc3RlYWQgb2YgZG1hX2FsbG9jX2NvaGVyZW50KCZudGItPmRldiwg
Li4uKS4NCj4+DQo+PiBIb3BlIHRoaXMgc2hvdWxkIHNvbHZlIHlvdXIgcHJvYmxlbS4NCj4gDQo+
IEhpIFNhbmpheSwNCj4gDQo+IFRoYW5rcyB0aGUgZm9yIHRoZSByZXNwb25zZS4gIFdlIGFyZSB1
c2luZyB0aGUgY29ycmVjdCBkZXZpY2UgZm9yIHRoZQ0KPiBkbWFfYWxsb2NfY29oZXJlbnQoKS4g
VXBvbiBmdXJ0aGVyIGludmVzdGlnYXRpb24gd2hhdCB3ZSBhcmUgZmluZGluZw0KPiBpcyB0aGF0
IGFwcGFyZW50bHkgdGhlIEFNRCBJT01NVSBzdXBwb3J0IGNhbiBvbmx5IG1hbmFnZSBvbmUgYWxp
YXMsIGFzDQo+IG9wcG9zZWQgdG8gSW50ZWwgSU9NTVUgc3VwcG9ydCB3aGljaCBjYW4gc3VwcG9y
dCBtdWx0aXBsZS4gTm90IGNsZWFyDQo+IGF0IHRoaXMgdGltZSBpZiBpdCdzIGEgc29mdHdhcmUg
bGltaXRhdGlvbiBpbiB0aGUgQU1EIElPTU1VIGtlcm5lbA0KPiBzdXBwb3J0IG9yIGFuIGltcG9z
ZWQgbGltaXRhdGlvbiBvZiB0aGUgaGFyZHdhcmUuIFN0aWxsIGludmVzdGlnYXRpbmcuDQoNClBs
ZWFzZSBkZWZpbmUgJ2FsaWFzJz8NCg0KVGhlIElPX1BBR0VfRkFVTFQgZXJyb3IgaXMgZGVzY3Jp
YmVkIG9uIHBhZ2UgMTQyIG9mIHRoZSBBTUQgSU9NTVUgc3BlYywgDQpkb2N1bWVudCAjNDg4ODIu
IEVhc2lseSBmb3VuZCB2aWEgYSBzZWFyY2guDQoNClRoZSBmbGFncyB2YWx1ZSBvZiAweDAwNzAg
dHJhbnNsYXRlcyB0byBQRSwgUlcsIFBSLiBUaGUgcGFnZSB3YXMgDQpwcmVzZW50LCB0aGUgdHJh
bnNhY3Rpb24gd2FzIGEgd3JpdGUsIGFuZCB0aGUgcGVyaXBoZXJhbCBkaWRuJ3QgaGF2ZSANCnBl
cm1pc3Npb24uIFRoYXQgaW1wbGllcyB0aGF0IG1hcHBpbmcgaGFkbid0IGJlZW4gZG9uZS4NCg0K
Tm90IGJlaW5nIHN1cmUgaG93IHRoYXQgZGV2aWNlIHByZXNlbnRzLCBvciB3aGF0IHlvdSdyZSBk
b2luZyB3aXRoIElWSEQgDQppbmZvLCBJIGNhbid0IGNvbW1lbnQgZnVydGhlci4gSSBjYW4gc2F5
IHRoYXQgdGhlIEFNRCBJT01NVSBwcm92aWRlcyBmb3IgDQphIHNpbmdsZSBleGNsdXNpb24gcmFu
Z2UsIGJ1dCBhcyBtYW55IHVuaXR5IHJhbmdlcyBhcyB5b3Ugd2lzaC4NCg0KSFRIDQoNCmdyaA0K
