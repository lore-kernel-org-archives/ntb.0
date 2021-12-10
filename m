Return-Path: <kevin.tian@intel.com>
Received: from mga07.intel.com (mga07.intel.com. [134.134.136.100])
        by gmr-mx.google.com with ESMTPS id h12si150849lfv.4.2021.12.09.23.38.01
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Dec 2021 23:38:02 -0800 (PST)
From: "Tian, Kevin" <kevin.tian@intel.com>
Subject: RE: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Date: Fri, 10 Dec 2021 07:37:41 +0000
Message-ID: <BN9PR11MB5276B9A8D0C4D824999F81508C719@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <87y2548byw.ffs@tglx> <20211201181406.GM4670@nvidia.com>
 <87mtlk84ae.ffs@tglx> <87r1av7u3d.ffs@tglx>
 <20211202135502.GP4670@nvidia.com> <87wnkm6c77.ffs@tglx>
 <20211202200017.GS4670@nvidia.com> <87o85y63m8.ffs@tglx>
 <20211203003749.GT4670@nvidia.com> <877dcl681d.ffs@tglx>
 <20211203164104.GX4670@nvidia.com>
 <BN9PR11MB52766CC46D3D4865308F61D98C709@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87pmq6ywu3.ffs@tglx>
 <BN9PR11MB5276BDE2AC58ADA7A66CAFBA8C709@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87mtl9zs7e.ffs@tglx>
In-Reply-To: <87mtl9zs7e.ffs@tglx>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Return-Path: kevin.tian@intel.com
To: Thomas Gleixner <tglx@linutronix.de>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Logan Gunthorpe <logang@deltatee.com>, LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Marc
 Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, "Dey, Megha" <megha.dey@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Mason <jdmason@kudzu.us>, "Jiang, Dave" <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "x86@kernel.org" <x86@kernel.org>, Joerg Roedel <jroedel@suse.de>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-ID: <linux-ntb.googlegroups.com>

PiBGcm9tOiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4NCj4gU2VudDogVGh1
cnNkYXksIERlY2VtYmVyIDksIDIwMjEgMTE6NTggUE0NCj4gDQo+IE9uIFRodSwgRGVjIDA5IDIw
MjEgYXQgMTI6MTcsIEtldmluIFRpYW4gd3JvdGU6DQo+ID4+IEZyb206IFRob21hcyBHbGVpeG5l
ciA8dGdseEBsaW51dHJvbml4LmRlPg0KPiA+PiBJIHRoaW5rIHlvdSBhcmUgbG9va2luZyBhdCB0
aGF0IGZyb20gdGhlIGludGVybmFsIGltcGxlbWVudGF0aW9uIGRldGFpbHMNCj4gPj4gb2YgSURY
RC4gQnV0IHlvdSBjYW4ganVzdCBtb2RlbCBpdCBpbiBhbiBJRFhEIGltcGxlbWVudGF0aW9uIGFn
bm9zdGljDQo+ID4+IHdheToNCj4gPj4NCj4gPj4gICAgICBFTlFDTUQoUEFTSUQsIElNUy1FTlRS
WSwuLi4uLikNCj4gPg0KPiA+IE5vdCBleGFjdGx5IElNUy1FTlRSWS4gTVNJLUVOVFJZIGFsc28g
d29ya3MuDQo+IA0KPiBTdXJlLg0KPiANCj4gPj4NCj4gPj4gaW1wbGllcyBhbiBvbiBkZW1hbmQg
YWxsb2NhdGlvbiBvZiBhIHZpcnR1YWwgcXVldWUsIHdoaWNoIGlzIGRlYWxsb2NhdGVkDQo+ID4+
IHdoZW4gdGhlIGNvbW1hbmQgY29tcGxldGVzLiBUaGUgUEFTSUQgYW5kIElNUy1FTlRSWSBhY3Qg
YXMgdGhlDQo+ICdxdWV1ZScNCj4gPj4gaWRlbnRpZmllci4NCj4gPj4NCj4gPj4gVGhlIGltcGxl
bWVudGF0aW9uIGRldGFpbCBvZiBJRFhEIHRoYXQgaXQgZXhlY3V0ZXMgdGhlc2UgY29tcHV0YXRp
b25zIG9uDQo+ID4+IGFuIGludGVybmFsIHNoYXJlZCB3b3JrcXVldWUgZG9lcyBub3QgY2hhbmdl
IHRoYXQuDQo+ID4+DQo+ID4+IFN1Y2ggYSB3b3JrcXVldWUgY2FuIG9ubHkgZXhlY3V0ZSBvbmUg
ZW5xdWV1ZWQgY29tbWFuZCBhdCBhIHRpbWUsDQo+ID4+IHdoaWNoDQo+ID4+IG1lYW5zIHRoYXQg
ZHVyaW5nIHRoZSBleGVjdXRpb24gb2YgYSBwYXJ0aWN1bGFyIGNvbW1hbmQgdGhhdCBJRFhEDQo+
ID4+IGludGVybmFsIHdvcmtxdWV1ZSByZXByZXNlbnRzIHRoZSAndmlydHVhbCBxdWV1ZScgd2hp
Y2ggaXMgaWRlbnRpZmllZCBieQ0KPiA+PiB0aGUgdW5pcXVlIFBBU0lEL0lNUy1FTlRSWSBwYWly
Lg0KPiA+DQo+ID4gV2hpbGUgaXQncyBvbmUgd2F5IG9mIGxvb2tpbmcgYXQgdGhpcyBtb2RlbCBk
byB3ZSB3YW50IHRvIGFjdHVhbGx5DQo+ID4gY3JlYXRlIHNvbWUgb2JqZWN0cyB0byByZXByZXNl
bnQgdGhpcyAndmlydHVhbCBxdWV1ZScgY29uY2VwdD8gdGhhdA0KPiA+IGltcGxpZXMgZWFjaCBF
TlFDTUQgbXVzdCBiZSBtb2RlcmF0ZWQgdG8gY3JlYXRlIHN1Y2ggc2hvcnQtbGlmZXNwYW4NCj4g
PiBvYmplY3RzIGFuZCBJJ20gbm90IHN1cmUgdGhlIGJlbmVmaXQgb2YgZG9pbmcgc28uDQo+IA0K
PiBZb3UgZG9uJ3QgaGF2ZSB0byBjcmVhdGUgYW55dGhpbmcuIFRoZSBQQVNJRC9FTlRSWSBwYWly
IHJlcHJlc2VudHMgdGhhdA0KPiAndmlydHVhbCBxdWV1ZScsIHJpZ2h0Pw0KDQpZZXMNCg0KPiAN
Cj4gPiBJZiBub3QgdGhlbiBmcm9tIGRyaXZlciBwLm8udiBpdCdzIHN0aWxsIG9uZSBxdWV1ZSBy
ZXNvdXJjZSBhbmQgZHJpdmVyDQo+ID4gbmVlZHMgdG8gbWFuYWdlIGl0cyBhc3NvY2lhdGlvbiB3
aXRoIG11bHRpcGxlIGludGVycnVwdCBlbnRyaWVzIGFuZA0KPiA+IFBBU0lEcyB3aGVuIGl0J3Mg
Y29ubmVjdGVkIHRvIG11bHRpcGxlIGNsaWVudHMuDQo+IA0KPiBUaGF0J3MgY29ycmVjdCwgYnV0
IHRoZXJlIGlzIG5vdGhpbmcgcHJvYmxlbWF0aWMgd2l0aCBpdC4gSXQncyBsaWtlDQo+IGFsbG9j
YXRpbmcgbXVsdGlwbGUgaW50ZXJydXB0cyBmb3IgYW55IG90aGVyIGhhcmR3YXJlIGRldmljZSBv
cg0KPiBzdWJkZXZpY2UsIHJpZ2h0Pw0KDQpObyBxdWVzdGlvbiBvbiB0aGlzLiBKdXN0IHdhbnQg
dG8gcG9pbnQgb3V0IHN1Y2ggdXNhZ2UgZXhhbXBsZSANCnNpbmNlIEphc29uIG1lbnRpb25lZCBp
dC4g8J+Yig0KDQo+IA0KPiBXaGF0J3MgcHJvYmFibHkgbW9yZSBpbnRlcnJlc3RpbmcgaXMgaG93
IHRoZSBQQVNJRC9pbnRlcnJ1cHQvUklEDQo+IHJlbGF0aW9ucyBhcmUgbWFuYWdlZC4NCj4gDQoN
CnllcywgdGhhdCdzIHNvbWV0aGluZyB3ZSBuZWVkIGZ1cnRoZXIgdGhpbmsgb2YuDQoNClRoYW5r
cw0KS2V2aW4NCg==
