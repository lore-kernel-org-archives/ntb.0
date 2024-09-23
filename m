Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0F640855;
	Mon, 23 Sep 2024 09:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727082713; cv=none; b=X7WdTBOHwbrFRuxaN410tsFkzVhjScPA2m4pwjU9C7AhCn8GCYjnUbV4mBbGwx+cvRdZyG4WYQvi+kAxOi5pZn8tbDvS9MGb3rhZQa9HLzoZYPpJaLBcNMFWlVHiGL4iI+1ltE8hryRoK0c8du+/mWEwAtlu0FcGwSva8A4ProQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727082713; c=relaxed/simple;
	bh=gBWers0ECLaN1Tpp4n0BsgXZB6TnnXdA1G+Tw1G+++8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=S+E8CNm5qANkGZrBPWcBk46Y+qP+zSe/+2jf7mAHjbjZihmuc/1OqFBvsMtYqJ4OVP4neHSRznfDUBYZl1Jr2EhEIF90VaFXrWn11K6vfDaZv6NuMusL8a+xOWvoSR6TBt+GL3XXIA7zKSI6tJfzB+F0t06m1v1GjTu49J08oOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=dVpPeh8V; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="dVpPeh8V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727082698; x=1727687498; i=markus.elfring@web.de;
	bh=CQk8PX6PSOJaguatjos6FNc2UVXPNPDpCg2VE5s7YPM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dVpPeh8V/npgHGhjEYTSr1Gokmbqgm1e13n7hfftDUUzmBWR4Hyc4NSLhxzjQw/J
	 ARgEQHsyjSXw0nacA+1RzmL5cmKqE+XcpeauM96ue5IXySBi8KRhKb1kShOXwnQlY
	 tO9jIFzLLf0L8nP9UiwQ7QELzp7NlUJ94CI8WNiz97ZKFv2Kif9BBiiiuRiFl1CxT
	 fstd79UfoqsviuW61lRYfMnDdIOiVi0lCdipVFSRrQXh8uuUTnLSatNMB/iN0mWHN
	 uhOuNtiSKDeQokACjzHqx001Y+yNIrC2LZ5KegfnTKpWhhtcdd7oJqNPOVCZsP9ru
	 pgmBFLbEHZBWywpgUA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MUCz1-1sSZmT0HXX-00PhVO; Mon, 23
 Sep 2024 11:11:38 +0200
Message-ID: <c7654504-a455-4972-9861-39800732d0df@web.de>
Date: Mon, 23 Sep 2024 11:11:19 +0200
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ntb@lists.linux.dev, kernel-janitors@vger.kernel.org,
 Allen Hubbe <allenbh@gmail.com>, Dave Jiang <dave.jiang@intel.com>,
 Jon Mason <jdmason@kudzu.us>, Max Hawking <maxahawking@sonnenkinder.org>,
 Serge Semin <fancer.lancer@gmail.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH 0/2] ntb_perf: Adjustments for perf_copy_chunk()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2iFzJ113ItDpOQFoSOCd53j7v7CtZhsPaoqrsxKHESuZ0EPAyXB
 O7vdFQH5LSWrSh+JiXd84NpM1YBr6uWFshTNApknj5wFwa/tFlERLbF52miGZ03gTcgzmKf
 MiciJDfh+L8/UoVCpcjxxsT+ztcpBqcAtRvQYqYGhx8W3/7kcKSowK2PmPr5duci4j2Yd/o
 3HGK78uxqO/xDN/1VnanQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Pbsu1iVKWfo=;5yWcn41CawU1fcs22dDqINIbaDd
 6Y9coIH1N2i1xUT+71T4HXG8Rk8HEKY/wkDpjjzdc7IAVoFroTxlfdtccBgG584ESTX1noF2t
 eWrlJrNa6apPCHoQ+x3yngsrKX6wgC+qtcUP7Qnd1vgEo5Em0jKSo63s9vKN5dNTcRi1RROW2
 vKv98xfL7EyWMBbMH+ae9SYeW4B41xqpn4XHcgwa2x2fK/i46lY+7wyzxzNfCoyS96G82AxuG
 A2zoiDhuSIROTaxMnJMk5SfdAWrIbPOazMmNr0hXVDUg7pC63JeT+4oUI2fW3jzYE5qctlt+7
 MLs7RcQkVTt3C9ncZYXBvq0z/0XkG0G2p3t/x5D+XjYR1JtsRV26KLnk1WwNqKUbVs7ZkKMg8
 j792uFHCk2zwLfCyvTQNW4UTGcQfx49u69EAGWNUQf8zJrSGJfpQGJ8Ag3NDxJD/1foJwhxUR
 4dNVSqeeCnTgUZr9qSsPPko6892kqndNNIobMXgfHeYV6nqsmAk8YGMKYnl6WBEaSE6e/cHwY
 pzrXKpvdexvu4mWb0L8BjpMWzOziTw7jAgnR6JwbTzPR/A41RHFPCX1fGPqOWJHTycTAs+L3Q
 FtCNRGaDjA3r2Cy+QITTPxU9LRmf0hUx32bG01Y91snZNIACykiyzjfyCERFes8Is2N+CXtwu
 C9GZMpjuDbydOoeB9CEYYOkDp3kY8qsNYwLd7NGpqGYFXVz+ADY3p1j5teQ9zU8ZwtS6p3vw+
 F9mzpeojW/V5TVpav3LhjlpfHazNipfrB2RJtrI9/N/JRq5/qw4c2e+uNJ+cyNI/6FR4GBrS3
 1E/AVYXgB5XQmsiIhu7kCmDA==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 23 Sep 2024 11:00:22 +0200

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Delete duplicate dmaengine_unmap_put() call
  Use common error handling code

 drivers/ntb/test/ntb_perf.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

=2D-
2.46.1

