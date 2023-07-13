Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1225018B12
	for <ntb@lists.linux.dev>; Thu, 13 Jul 2023 15:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1689260733; x=1689865533; i=markus.elfring@web.de;
 bh=FI/QpXGXrEzkY6ULS5Xl6LEVLPmWRTnuucal6xvxcNY=;
 h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:In-Reply-To;
 b=CKGepTFQeye/4molF7h22Cvcz993NCNfTvMhNy/nwV/v56Ze4sGhBa9/aTagBXibxlG6vA3
 exFMHoIUecvFSydi1bhDWa4Fjw0dFfgx4VY8yaxNbff4oo3UQz5EAOutoRVyE6yPJwqgtkbCb
 f5CsnxtC9zgdFHDwvgsyjPZcw6lfk0y5id759liZ26EiFG+/31S1Cz+3mEQ8gB9HOVMJhKdTq
 ULLOEtvXGroIA2GVce3qBMnfOvZuJG/OUfjS5jXpTx9sD46pVdU7YsneKkqX4+4B5Kny/VW48
 OenW56Aeq5GE9gr3IhgG7bbZqq5FLQ/tp9kHedYpnJ/pYPqx1D1w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M28WT-1qMRvA1Yld-002J1h; Thu, 13
 Jul 2023 17:05:33 +0200
Message-ID: <59bae8c2-2a5e-19e8-1202-7228e0c277e5@web.de>
Date: Thu, 13 Jul 2023 17:05:31 +0200
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
To: Minjie Du <duminjie@vivo.com>, opensource.kernel@vivo.com,
 ntb@lists.linux.dev, kernel-janitors@vger.kernel.org,
 Allen Hubbe <allenbh@gmail.com>, Dave Jiang <dave.jiang@intel.com>,
 Jon Mason <jdmason@kudzu.us>, Stephen Rothwell <sfr@canb.auug.org.au>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20230713034728.2157-1-duminjie@vivo.com>
Subject: Re: [PATCH] drivers: ntb: fix parameter check in perf_setup_dbgfs()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20230713034728.2157-1-duminjie@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qgTYNqmlvR54TjKOJN5OVo+BHdeMaMgo9GWi3qJvZJat1jyyQJS
 oQfrzuVUtIBJ8IMcT9PvB7siD/P0PIGYPY0lF86oXefW9wSgrfK4KEg2TXRkBVnIYZOs0CT
 CrsvjErKIzTDNtMaZ0qXfI3WfZv9d9h6Y51r6HMoBj5Hk50b/1VCEcHz9KrHxFf1RH72XZe
 1+TAk6hlXDZtqUEyBkuhg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1CLJ9xly9ec=;X/fKwyLf9VcxW4rK4Bn6LHAwQPe
 nPgfqqxnjHQafuBz+P9fHFUxrtuVtGcrIwkpw5eoQRQ9v14BHXhWDO6Fc/9B4BWjTAONfSegk
 VuSYxdX1Vak8wS0zgm3xCTSG1SsyeU3NtgPrbOWL1xHgCVvVMOeJgZKSFBud7v9PC8USa2nEi
 JEh87xgvN9x3kBm1xS0DoazOYHxnxMdpUEdYrGWVHLNxEVeo6/D9stq88K+vQkgo3/ZQf96h9
 FntyV2u0jxF2vS60inRoX/YrQqX4RZvIk9nSaQpAobIvEQHQ2mqQG6bbNS3v36glnAs2wI1DQ
 6bnPj1jt+TYQDSdzKsQ3OcA2UcxWrOqBaIrqckakC8qwQE/nMwxG5FGGpqko/3yRRDH89p7eR
 9Z9g0jcfHkMboNoij/qejQkMUig1Wii+tA8unNS/Tu4mi9Lful2z5MGojN4hSF3LBJyD1+8/y
 oSt/HFAeFa65SQzNR2nyRirPcAuCrx0CkevYoRgR7dyyD+Ze++8CfUmOT8+iFFAt8oEeGjhtw
 75Un+1y3VwGG/hX2s6BuqrNs6BYq0bmeH1bFDVehf6VqjeqUxssnbf4BOThMhm5OyCAGf/JDy
 QfVTj3DHx3cYJwcbWvM4fSvz8g3/3coqjbyIlyObxgmXzYBKgDJCVLQdsrbRwi32Vd4ot7Yd6
 yhp+Vew2btarFsvYWtfVFpsYl4jvRWRGHHG44KURLmfPMbkI0xJWBwKRj8bZG7pv6YyQBZrw1
 sm6k657WkC2uO7ZTIsaIWiVA2c7f7TqNqFNdG0Bc7lADO1BEVQ6SLkLlSbuPXhzU75nJadQ7b
 2/DQ+mOfpo89yU4qImhRptlJe+/r9bLYvwPK4EiLnrnDNI86mi8J4VnMKcjU1LJlDFG0eMzYA
 u4h/JBM6beesexDiit2Fb1A11gEb94apKrWV0m7Lqcc/AkiR8nlkBC7WSKB+vEfl9VBYu4KuQ
 H1wwVQ==

> Make IS_ERR() judge the debugfs_create_dir() function return

Would the term =E2=80=9Creturn value=E2=80=9D be relevant here?

Would you like to improve this change description also according to
review comments from other patches?


How do you think about to add the tag =E2=80=9CFixes=E2=80=9D because of a=
 corrected
error detection?


Would a subject like =E2=80=9C[PATCH v2] NTB: perf: Fix an error check in =
perf_setup_dbgfs()
be more appropriate?

Regards,
Markus
