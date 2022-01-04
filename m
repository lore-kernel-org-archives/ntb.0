Return-Path: <Kelvin.Cao@microchip.com>
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com. [68.232.153.233])
        by gmr-mx.google.com with ESMTPS id q2si2136206pfu.5.2022.01.04.13.28.41
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jan 2022 13:28:41 -0800 (PST)
From: <Kelvin.Cao@microchip.com>
Subject: Re: [PATCH 0/6] Switchtec NTB Fixes and Improvements
Date: Tue, 4 Jan 2022 21:28:30 +0000
Message-ID: <41ea955218bb9fa42e59e106b7ee4e2c9c69cb3d.camel@microchip.com>
References: <20211224012334.89173-1-kelvin.cao@microchip.com>
	 <91ece4bb-5ab3-4ec9-acb0-0b054d4ec435@deltatee.com>
In-Reply-To: <91ece4bb-5ab3-4ec9-acb0-0b054d4ec435@deltatee.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <4DBE65673B8B79429C11FB6484DD176A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Return-Path: Kelvin.Cao@microchip.com
To: linux-ntb@googlegroups.com, kurt.schwemmer@microsemi.com, dave.jiang@intel.com, allenbh@gmail.com, linux-kernel@vger.kernel.org, logang@deltatee.com, linux-pci@vger.kernel.org, jdmason@kudzu.us
Cc: kelvincao@outlook.com, jmpallotta@gmail.com
List-ID: <linux-ntb.googlegroups.com>

T24gVHVlLCAyMDIyLTAxLTA0IGF0IDA5OjU1IC0wNzAwLCBMb2dhbiBHdW50aG9ycGUgd3JvdGU6
DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50
cyB1bmxlc3MgeW91DQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gMjAyMS0x
Mi0yMyA2OjIzIHAubS4sIEtlbHZpbiBDYW8gd3JvdGU6DQo+ID4gSGksDQo+ID4gDQo+ID4gUGxl
YXNlIGZpbmQgYSBidW5jaCBvZiBwYXRjaGVzIGZvciB0aGUgU3dpdGNodGVjIE5UQiBkcml2ZXIu
DQo+ID4gDQo+ID4gUGF0Y2hlIDEsIDIgYW5kIDYgZml4IHRocmVlIG1pbm9yIGJ1Z3MuIFBhdGNo
IDMgd29ya3MgYXJvdW5kIGENCj4gPiBtaW5vcg0KPiA+IGZpcm13YXJlIGlzc3VlLiBQYXRjaCA0
IHVwZGF0ZXMgdGhlIG1ldGhvZCBvZiBnZXR0aW5nIG1hbmFnZW1lbnQNCj4gPiBWRVANCj4gPiBp
bnN0YW5jZSBJRCBiYXNlZCBvbiBhIG5ldyBmaXJtd2FyZSBjaGFuZ2UuIFBhdGNoIDUgcmVtb3Zl
cyBjb2RlDQo+ID4gdGhhdA0KPiA+IGRpc2FibGVzIElEIHByb3RlY3Rpb24gdG8gYXZvaWQgY29u
ZmxpY3Qgd2l0aCBzdGF0aWMgU3dpdGNodGVjDQo+ID4gY29uZmlnDQo+ID4gc2V0dGluZ3MuDQo+
ID4gDQo+ID4gVGhpcyBwYXRjaHNldCBpcyBiYXNlZCBvbiA1LjE2LjAtcmM1Lg0KPiA+IA0KPiA+
IFRoYW5rcywNCj4gPiBLZWx2aW4NCj4gPiANCj4gPiBKZXJlbXkgUGFsbG90dGEgKDIpOg0KPiA+
ICAgbnRiX2h3X3N3aXRjaHRlYzogRml4IHBmZiBpb3JlYWQgdG8gcmVhZCBpbnRvIG1taW9fcGFy
dF9jZmdfYWxsDQo+ID4gICBudGJfaHdfc3dpdGNodGVjOiBBTkQgd2l0aCB0aGUgcGFydF9tYXAg
Zm9yIGEgdmFsaWQgdHBhcnRfdmVjDQo+ID4gDQo+ID4gS2VsdmluIENhbyAoMyk6DQo+ID4gICBu
dGJfaHdfc3dpdGNodGVjOiBVcGRhdGUgdGhlIHdheSBvZiBnZXR0aW5nIFZFUCBpbnN0YW5jZSBJ
RA0KPiA+ICAgbnRiX2h3X3N3aXRjaHRlYzogUmVtb3ZlIGNvZGUgZm9yIGRpc2FibGluZyBJRCBw
cm90ZWN0aW9uDQo+ID4gICBudGJfaHdfc3dpdGNodGVjOiBGaXggYSBtaW5vciBpc3N1ZSBpbiBj
b25maWdfcmVxX2lkX3RhYmxlKCkNCj4gPiANCj4gPiBXZXNsZXkgU2hlbmcgKDEpOg0KPiA+ICAg
bnRiX2h3X3N3aXRjaHRlYzogRml4IGJ1ZyB3aXRoIG1vcmUgdGhhbiAzMiBwYXJ0aXRpb25zDQo+
IA0KPiBJJ3ZlIHJldmlld2VkIGFsbCB0aGVzZSBwYXRjaGVzIGFuZCB0aGV5IGxvb2sgZ29vZCB0
byBtZS4NCj4gDQo+IFJldmlld2VkLWJ5OiBMb2dhbiBHdW50aG9ycGUgPGxvZ2FuZ0BkZWx0YXRl
ZS5jb20+DQo+IA0KVGhhbmtzIExvZ2FuIQ0KDQpLZWx2aW4NCg0KPiBUaGFua3MsDQo+IA0KPiBM
b2dhbg0K
