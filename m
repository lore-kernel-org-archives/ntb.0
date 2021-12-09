Return-Path: <kevin.tian@intel.com>
Received: from mga07.intel.com (mga07.intel.com. [134.134.136.100])
        by gmr-mx.google.com with ESMTPS id y8si264470lfj.0.2021.12.08.22.26.45
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Dec 2021 22:26:46 -0800 (PST)
From: "Tian, Kevin" <kevin.tian@intel.com>
Subject: RE: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Date: Thu, 9 Dec 2021 06:26:38 +0000
Message-ID: <BN9PR11MB52766CC46D3D4865308F61D98C709@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <87y2548byw.ffs@tglx> <20211201181406.GM4670@nvidia.com>
 <87mtlk84ae.ffs@tglx> <87r1av7u3d.ffs@tglx>
 <20211202135502.GP4670@nvidia.com> <87wnkm6c77.ffs@tglx>
 <20211202200017.GS4670@nvidia.com> <87o85y63m8.ffs@tglx>
 <20211203003749.GT4670@nvidia.com> <877dcl681d.ffs@tglx>
 <20211203164104.GX4670@nvidia.com>
In-Reply-To: <20211203164104.GX4670@nvidia.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Return-Path: kevin.tian@intel.com
To: Jason Gunthorpe <jgg@nvidia.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: Logan Gunthorpe <logang@deltatee.com>, LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Marc
 Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, "Dey, Megha" <megha.dey@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Mason <jdmason@kudzu.us>, "Jiang, Dave" <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "x86@kernel.org" <x86@kernel.org>, Joerg Roedel <jroedel@suse.de>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-ID: <linux-ntb.googlegroups.com>

PiBGcm9tOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPg0KPiBTZW50OiBTYXR1cmRh
eSwgRGVjZW1iZXIgNCwgMjAyMSAxMjo0MSBBTQ0KPiANCj4gPiBPciBoYXMgZWFjaCBxdWV1ZSBh
bmQgY29udHJvbGJsb2NrIGFuZCB3aGF0ZXZlciBhY2Nlc3MgdG8gYSBzaGFyZWQgbGFyZ2UNCj4g
PiBhcnJheSB3aGVyZSB0aGUgbWVzc2FnZXMgYXJlIHN0b3JlZCBhbmQgdGhlIGluZGljZXMgYXJl
IGhhbmRlZCBvdXQgdG8NCj4gPiB0aGUgcXVldWVzIGFuZCBjb250cm9sYmxvY2tzPw0KPiANCj4g
PiBJZiBlYWNoIG9mIHRoZW0gaGF2ZSB0aGVpciBvd24gc21hbGwgYXJyYXksIHRoZW4gcXVldWUg
cmVsYXRpdmUgaW5kZXhpbmcNCj4gPiBtYWtlcyBhIHRvbiBvZiBzZW5zZSwgbm8/DQo+IA0KPiBP
a2F5LCBJIHNlZS4NCj4gDQo+IEkgZG9uJ3Qga25vdyBvZiBhbnkgdXNlIGNhc2UgZm9yIG1vcmUg
dGhhbiBvbmUgaW50ZXJydXB0IG9uIGEgcXVldWUsDQo+IGFuZCBpZiBpdCBkaWQgY29tZSB1cCBJ
J2QgcHJvYmFibHkgYXBwcm9hY2ggaXQgYnkgbWFraW5nIHRoZSBxdWV1ZQ0KPiBoYW5kbGUgYWJv
dmUgYWxzbyBzcGVjaWZ5IHRoZSAncXVldWUgcmVsYXRpdmUgSFcgaW5kZXgnDQo+IA0KDQpXZSBo
YXZlIHN1Y2ggdXNlIGNhc2Ugd2l0aCBJRFhELg0KDQpCYXNpY2FsbHkgdGhlIElEWEQgcXVldWUg
YWxsb3dzIHNvZnR3YXJlIHRvIHB1dCBhbiBpbnRlcnJ1cHQgaGFuZGxlDQoodGhlIGluZGV4IG9m
IE1TSS1YIG9yIElNUyBlbnRyeSkgaW4gdGhlIHN1Ym1pdHRlZCBkZXNjcmlwdG9yLiBVcG9uDQpj
b21wbGV0aW9uIG9mIHRoZSBkZXNjcmlwdG9yIHRoZSBoYXJkd2FyZSBmaW5kcyB0aGUgc3BlY2lm
aWVkIGVudHJ5IA0KYW5kIHRoZW4gZ2VuZXJhdGUgaW50ZXJydXB0IHRvIG5vdGlmeSBzb2Z0d2Fy
ZS4NCg0KQ29uY2VwdHVhbGx5IGRlc2NyaXB0b3JzIHN1Ym1pdHRlZCB0byBhIHNhbWUgcXVldWUg
Y2FuIHVzZSBkaWZmZXJlbnQNCmhhbmRsZXMsIGltcGx5aW5nIG9uZSBxdWV1ZSBjYW4gYmUgYXNz
b2NpYXRlZCB0byBtdWx0aXBsZSBpbnRlcnJ1cHRzLg0KDQpPbmUgZXhhbXBsZSBpcyB0aGUgc2hh
cmVkIHdvcmsgcXVldWUgdXNhZ2Ugd2hpY2ggYWxsb3dzIG11bHRpcGxlIA0KY2xpZW50cyBkaXJl
Y3RseSBhbmQgc2ltdWx0YW5lb3VzbHkgc3VibWl0dGluZyBkZXNjcmlwdG9ycyB0byB0aGUgDQpz
YW1lIHF1ZXVlLCBieSB1c2luZyBFTlFDTUQocGFzaWQsIGRlc2NyaXB0b3IpIGluc3RydWN0aW9u
LiBJbiB0aGlzIA0KY2FzZSBlYWNoIGNsaWVudCBjYW4gYmUgYWxsb2NhdGVkIHdpdGggYW4gaW50
ZXJydXB0IGVudHJ5IChpbmNsdWRpbmcgdGhlDQppbmZvcm1hdGlvbiBhYm91dCB0aGUgY2xpZW50
J3MgcGFzaWQgZm9yIHBlcm1pc3Npb24gY2hlY2sgd2hlbiB0aGUNCkhXIGdlbmVyYXRlcyBjb21w
bGV0aW9uIGludGVycnVwdCkgYW5kIHRoZW4gdXNlIHRoaXMgZW50cnkgZm9yIA0KYWxsIGRlc2Ny
aXB0b3JzIHN1Ym1pdHRlZCBieSB0aGF0IGNsaWVudC4NCg0KSGF2ZW4ndCBjb21wbGV0ZWQgcmVh
ZGluZyBvZiB0aGlzIHRocmVhZCwgYnV0IHdvdWxkIGxpa2UgdG8gcG9pbnQgDQpvdXQgdGhpcyB1
c2FnZSBzbyBpdCBpcyBub3QgaWdub3JlZCBpbiB0aGUgZmluYWwgcmV3b3JrLiBJdCBiYXNpY2Fs
bHkNCm1lYW5zIG9uZSBxdWV1ZSBtaWdodCBiZSBhc3NvY2lhdGVkIHRvIG11bHRpcGxlIGludGVy
cnVwdCBlbnRyaWVzDQphbmQgbXVsdGlwbGUgcGFzaWRzLiDwn5iKDQoNClRoYW5rcw0KS2V2aW4N
Cg==
