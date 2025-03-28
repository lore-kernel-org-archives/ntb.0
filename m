Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4DB1C5D67
	for <ntb@lists.linux.dev>; Fri, 28 Mar 2025 14:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743173632; cv=none; b=k2NaAdbfjYSraOMBCuB6xzBQW0h5rizTlDmqPTHaD40Jr4VCFBxq2r9bQ0QNYaHvho4MB6tdyNkh6VpwLHuIWBloksaUVm+leJGG2L/Jq6Ed0+FEuNe5hgqZ2P9k4kj7erPWw+hNeOVuS4JNVZO+Pp/u1MS6btpMq1dNd32Gk9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743173632; c=relaxed/simple;
	bh=gUEdTnXFrxQFCubyzkt8h7MkbAD/T1O1BvGuN2YMSZk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mGbtP6ywropqm9/cV7emZ/uWNeKO+EeDZfwRXt+OnA4pImAAtGDK2XV0OM05s7O9SlnzAFaiG8PFAfqznIeSuxxdZMDi+xWAlSPvYDBpSCxE4wfsiq4woTXLxpapiv9uWMVrrjc1+2MDkKTCZuvfwBWc6BBah2sNbd9U5KwhAeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YQyaglg8; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YQyaglg8"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43d0359b1fcso14594805e9.0
        for <ntb@lists.linux.dev>; Fri, 28 Mar 2025 07:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743173629; x=1743778429; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hmbC5RFYydPYh642kyN0rQaa467lBDxTsawumsVo1Aw=;
        b=YQyaglg8X/hH/cGJPKFvJCN+62w68rXBZ78BK7Qxb2sG8Amq7i3RFAovijR9fC5jwI
         P9NLld0DO/Skh5xxg1W3Awzby0WN9TwYXiM8CQAVEvUhp8kmnvowdwvncRJWBjVRJ6zR
         +D7JU7xbt5+IgvDoeD+RLga5qJysndEuakZw2JRb4PKI70H+ocg8AcKvDL70Vf1esS3e
         l/t6sruvAhvaqMQGtLgHWQEg4dYabU0ZuaLHYQ0zDMRTmR6oi1Q1x35vlqP/IQbR1V2R
         heKyOUesTtBf+XmFJbyKr/VQv79LlK3c/Kz8JtQdjc97VPCjUks7k+k7d8WtS+yYwPPk
         CYZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743173629; x=1743778429;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hmbC5RFYydPYh642kyN0rQaa467lBDxTsawumsVo1Aw=;
        b=wNCCbTO91FgJ3pG2cDQQI6bF00Z3SVCTiGeoPsWmUWMtXglYXxcBx584aspEmlX1Bd
         YR1iB9zUS9cwLddzIcCqPv5AxfSkehAv0jZ8geAeJY/EKWh+w/wfIEj3iyCq/sp/rRS/
         mUFAV3sDORKPGneWCT91uLZlY+Gi8Npx9wp3we3t2YuTt4e/prNQN6Lu88TLyFIjRqov
         jmC6afk7agO0KoFGkKdNUsLX8NPz+P2hWTYEx4X/5sOUkam5GJfOK6CiMYoLQzElaB+V
         AuKvaJ3uei5MpZ8KYQi4G4lXGffVg3WWUxM3KeyQxgk+j4bHaQBpFjct+cQ+e+p0ZS3d
         DPiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhUl816s/ytgGwa52eWCga5fMR6QHKq+7Oz/QXXgUTk5aHz3ZHGUeKtjscNYlfS50rERo=@lists.linux.dev
X-Gm-Message-State: AOJu0YwsmUlMPi3i22/+GKzPj0gvHQTWox7/ZniO3JJwuZBDIdc7Bs1x
	kw0/d/kpaLDjWPq1kMdtJQkxqX37coK1YLx+a7b3PFHVOq2Fv48d0dBPYHKkmds=
X-Gm-Gg: ASbGncuS+6cnZwoe9vfWswdrjdpCHpE7/qGUTovAOM7Kx3iWznxRVBOr3mwS2mDkxI9
	ewwF3PGAreYatS85ReTRmkZh+gVKXZr/ySrVMPGXm2EnflZ7NxAG+jeRoi3WxvCAD2wWmjaWSGK
	UwRXVP9ER5jeqm/kQPb4oXNRKrDH++XgmxrJdZiSGdbOdUli0U8e/IlLyUJeSbruZiFtHxuH9Sp
	CxtqXUciMpw5O8JvFw0+IEUZ5BB3NPKxBU5qexSynvLmtGxTU4wGExnpOw4QV1ChTVmGl80I4H5
	vgJL+/cBMbIoECLz97/2+U74o3h1J8YInvNp9DEJejOoxFBUdsxgeoqZcgE=
X-Google-Smtp-Source: AGHT+IHEwb8loYtorvEBGaqWpt3wJlMaO1x80S4rv3p5SrimoSh4/TC2550uL3aEEWUnSViQo2QLzg==
X-Received: by 2002:a05:600c:1f14:b0:439:9737:675b with SMTP id 5b1f17b1804b1-43d9145bb08mr29097225e9.7.1743173628723;
        Fri, 28 Mar 2025 07:53:48 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:70c0:edf6:6897:a3f8])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43d8314e110sm75219615e9.39.2025.03.28.07.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 07:53:48 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Fri, 28 Mar 2025 15:53:42 +0100
Subject: [PATCH 1/2] PCI: endpoint: strictly apply bar fixed size to
 allocate space
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250328-pci-ep-size-alignment-v1-1-ee5b78b15a9a@baylibre.com>
References: <20250328-pci-ep-size-alignment-v1-0-ee5b78b15a9a@baylibre.com>
In-Reply-To: <20250328-pci-ep-size-alignment-v1-0-ee5b78b15a9a@baylibre.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Jon Mason <jdmason@kudzu.us>, 
 Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, ntb@lists.linux.dev, 
 Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1358; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=gUEdTnXFrxQFCubyzkt8h7MkbAD/T1O1BvGuN2YMSZk=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBn5rf42oi1rZDSM6XrbYRStOeGfWZi4bFla10nb
 K7qwiyD9t2JAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZ+a3+AAKCRDm/A8cN/La
 hQFGD/9VO5rQNfzw3OhspgPwCblFhKTlz8Qu/BP7+Qx/Qecie+/xT66l3wDwIyad6t73UH6EZh+
 NukWAUMUFVnsHzpetu6cHHxG7P4cJSiZraHpTxk71rJlqqtKNln1JZEetSZr3tzurykZtQn8IB1
 QIDGc2ZwKf+F4LCkZYdc+U8FpWGWnK19thptpoX90MTBDHL3p3IjNrIpl9dcMXta41/n7hKU0iM
 X3mKwqfDLJoAkCVksfneEjJG7SrhHsOSZqGgJ65uWAaRiWvKlffc7HPcI/efUA4mJcDOPmg5s7v
 XSmaI5ZBFx+gYypJ9WM7/NdvAc9lCboqY8NgqUOnMuQN2NmXXCDoGkKYtkcdKz2KMv/zpd5azU5
 3SLmLc91smK/m1+aMgcSSeklGogyj/hJwXSZD4lrExrqboOvYygPI2fzXuQTFojuggTLB6KuwSR
 U4T97kNYN3Xmmwq9uraABImbwJh923AmxWLWRGwy7Sl1zNZDNirHVLPEHoxR7pfgi9k9nwmc3+E
 p2oFQ1DElCClLIRexJtriHYKtLAnTXj74AXyHwfAL+tIrfRLUzflyGtgXYOPBgC3Zt2yXrhLMdZ
 4rJ0Py7yCIhPY6LJtTKWSTw5DNgzsnByz/UewoSMZbuG+3rfjWlIk4+XSlG2jCcyozAXCXODfHn
 W+2qbCqgSrz1bhg==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

When trying to allocate space for an endpoint function on a BAR with a
fixed size, that size should be used regardless of the alignment.

Some controller may have specified an alignment, but do have a BAR with a
fixed size smaller that alignment. In such case, pci_epf_alloc_space()
tries to allocate a space that matches the alignment and it won't work.

When the BAR size is fixed, pci_epf_alloc_space() should not deviate
from this fixed size.

Fixes: 2a9a801620ef ("PCI: endpoint: Add support to specify alignment for buffers allocated to BARs")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/pci/endpoint/pci-epf-core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 394395c7f8decfa2010469655a4bd58a002993fd..cb985b172ed041c6f319c083f412e51e25b0a157 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -285,12 +285,11 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 			return NULL;
 		}
 		size = bar_fixed_size;
-	}
-
-	if (align)
+	} else if (align) {
 		size = ALIGN(size, align);
-	else
+	} else {
 		size = roundup_pow_of_two(size);
+	}
 
 	if (type == PRIMARY_INTERFACE) {
 		epc = epf->epc;

-- 
2.47.2

