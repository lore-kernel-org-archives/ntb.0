Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CBE19343C;
	Mon, 23 Sep 2024 09:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727082931; cv=none; b=kTi/Fi1KUy+Gh8LX2T4f1RlVYQL7sHkYbQHJ7H7hifXALjkipm4yZZNQ9rNLzIW+EUXIUPNWRnDYOot9faUTTH/IS16wW3+T7eaK8limWIDUcoboJ6Oq2xPdtSXiyaLEzB52KwZl5wQpTz+rWk37+Te4yrT6ZPH/Y4vBvCEkMP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727082931; c=relaxed/simple;
	bh=qr2Qarh6ebtOtLWTNiRJuASl4IN4UHhqMXUsPGMwFSM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=VDdqL+j5jWbRIv8yleLbxkNHHK7oNlC3o3QID2TTYUdoUg/GADs/GvZjmQwFsgM7pFySY5rqCmlXgSTmMaH54L6lxfIMvVAkabZCGDAmeighmzynOyzatDITbPxMKGZCQsA2scbwp7uQN6uq0yvSBxP62vybwGXkwG/VGLju1lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=mhQoxNHG; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="mhQoxNHG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727082916; x=1727687716; i=markus.elfring@web.de;
	bh=dOYAeuhmauXIik/5QB/QhShrC/pfpiZ63Bf7v/99LDs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mhQoxNHGGha0a5h2a8oX83C3YHAOETSYC3iPSkZNRcmHxatBZOZogKfV9ic7I3Ky
	 RsUTySs7Flxk6Xc8eCifgcCwDFKXMAOHauJzlkBpHEeuJyiILjQ+jKDr7BPzwW+yQ
	 CZdakY5/uoGEdnQCAtJnglhbNLSDqyr8BpqxnVsiDlHN6sPSK5oQTZf2AcfPjcfzk
	 c52X6SmLDyq3m4lOk2cZxu32lr01iADxqN9blVb1MxQZHhlNJIbhOUpEmIZRhpWq6
	 q+OERPg8IXb5g40BPilsq8N0xK7NvfEDdBFbB+A8e+WzebP+UAs7VDeQeFDNrQip2
	 P7bipLpf4lfjb9EI7A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MKMA7-1seioV3NfT-00VAeV; Mon, 23
 Sep 2024 11:15:16 +0200
Message-ID: <a58d6585-4573-44bd-b315-770ca3a54af6@web.de>
Date: Mon, 23 Sep 2024 11:15:15 +0200
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/2] ntb_perf: Delete duplicate dmaengine_unmap_put() call in
 perf_copy_chunk()
From: Markus Elfring <Markus.Elfring@web.de>
To: ntb@lists.linux.dev, kernel-janitors@vger.kernel.org,
 Allen Hubbe <allenbh@gmail.com>, Dave Jiang <dave.jiang@intel.com>,
 Jon Mason <jdmason@kudzu.us>, Max Hawking <maxahawking@sonnenkinder.org>,
 Serge Semin <fancer.lancer@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <c7654504-a455-4972-9861-39800732d0df@web.de>
Content-Language: en-GB
In-Reply-To: <c7654504-a455-4972-9861-39800732d0df@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:40hUvF8fY+XsiElP2ObNoDh/4F0E6+Ag2AaFzpPdT3noA0pimay
 qmZVuYdqrTLrTmwhlKyVh8Vw/7Djk5Q0ekfOmlQ1jJAOJnqqp+N9lCRoh7oY2NWi/JxMmK6
 cjcERqxf+FR6xLm1IOYF2yNUP5RHpumzqtRDdSsLPxE1pVHpJKDj6Uv66sEmZF7S9B5MXsw
 zrkLUvdfPkJSSztWHDJLw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:M8cxhBhZBa8=;ZVAh/HXKdq9BRm+oMLu1GFOlX4s
 Vib4KSg0VjUSl/8CWhvCJzPrqa2pjlQDjY3nuyRLwGXuS12G60rrAuUHCJWmnTNgxUagzy+8/
 myLZaCe88U7RqTUDk89E77ZctDUdJQFcQVKuS/gil1OMxNomkvgYbBIn+IHQIlZ2ahQEIWhqY
 9aOQclvzgsb2Y77L2nikAK2ao7kBpWnR4FSj6izTW7Z4mszfn1//B1Hy3G8OvAJMWfQk37qmY
 R+H1BjqTLLGSUuP1WkBZc/B09/sRNIToAOKskpNASSQo9+7rxRUGMc7HEJEucHzXfaXySnVct
 cUR7wehjZ0/tqth0ZRUkFIUYL4D/uZTI3cMCNYUc2Xvdx2ekGBn/av+immIMSzjPbSti5i++a
 4KMoXh5kfgoMk1JR7Qv77DuAGW7YlhWoaxlgwej0VIIZEMiMnvC4F8IdoIXM57XVW1pB4xU+9
 zyLYV0VyeJZoM+d8oBacVmilupPp+9vHjxD4U7CAWIpMExV+t3K6aNzWUNdaUsuSGQiGNYaWj
 wE7bItLXy7uh3lKydxB0gXlEomla09nzolmEgkq5QEQLKIchz4ewKWv9HAnydcwLFDr2+axOW
 cG391JnucQTCcKPnUFCOYzwMsjHGkHqj/OWB2Y2Iy3V5dE2KlWmAxpqWeqKaxsZu2wQlfmScu
 CvVx0Pfo7V9xxSErYWpSvNU377G+WPlaHywauFMaVG2LU4mevcx0AlYkoNivwSt/e4i6oTFfC
 eDwEHy5qeDVB3jKYn1IIb3V0c+jlfKUmAcxvNDzIpaeyp0RYha/+t7+Ph7l6r3On4FdRldbm8
 13B3jaM1/ef3xlpjDEKAvHIg==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 23 Sep 2024 10:38:11 +0200

The function call =E2=80=9Cdmaengine_unmap_put(unmap)=E2=80=9D was used in=
 an if branch.
The same call was immediately triggered by a subsequent goto statement.
Thus avoid such a call repetition.

This issue was detected by using the Coccinelle software.

Fixes: 5648e56d03fa ("NTB: ntb_perf: Add full multi-port NTB API support")
Cc: stable@vger.kernel.org

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--

I imagine that a single function call =E2=80=9Cdmaengine_unmap_put(unmap)=
=E2=80=9D
can be sufficient for this use case.
https://elixir.bootlin.com/linux/v6.11/source/drivers/dma/dmaengine.c#L137=
7

How do you think about to improve resource management any further?


 drivers/ntb/test/ntb_perf.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index 72bc1d017a46..dfd175f79e8f 100644
=2D-- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -839,10 +839,8 @@ static int perf_copy_chunk(struct perf_thread *pthr,
 	dma_set_unmap(tx, unmap);

 	ret =3D dma_submit_error(dmaengine_submit(tx));
-	if (ret) {
-		dmaengine_unmap_put(unmap);
+	if (ret)
 		goto err_free_resource;
-	}

 	dmaengine_unmap_put(unmap);

=2D-
2.46.1

