Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471381C35
	for <ntb@lists.linux.dev>; Fri, 14 Jul 2023 06:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1689317420; x=1689922220; i=markus.elfring@web.de;
 bh=IGA3t0EAbQSObJARETgoctYXvykvhOUGWA3vHwcx1Tg=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=hoyEyeMpR0Q59oAZ/DDk3FOfZ4KRs1LBmdvjSA3tMgQRqNtMLYUYlDJdQzKYGR4mXgqz8W5
 vDOEWzg5cj/cCjNBd7Yw/tPbqAd0jLMQQRrhqYvsg9JsRq9cSGFZ90ZC4NLmTh0XUZdAjqCn+
 RdcHelG8IruA7mpUffV4C3ZJuDvtq7Z2CLQtnG9UUzhHReJndC7i/G9Jcu6AAiqaYUdjwVpP6
 zzL8ekSikTRW9dePBrNKVkowq6AtWc/7fjl7P1vOmyDOSSjqt7m2bn13BplX1EiJhrvEdB4jP
 oMu2mGdw1Rv1oZ6DDaXPlwhtycPIsGYX7KBfxu3wdkQ08y7TwpAA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mw9x2-1q3VE02p8O-00sLw5; Fri, 14
 Jul 2023 08:50:20 +0200
Message-ID: <3230dad5-32da-f3b3-356d-a490456906c2@web.de>
Date: Fri, 14 Jul 2023 08:50:18 +0200
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] ntb: Remove error checking for debugfs_create_dir()
Content-Language: en-GB
To: Dan Carpenter <dan.carpenter@linaro.org>,
 kernel-janitors@vger.kernel.org, opensource.kernel@vivo.com,
 ntb@lists.linux.dev
Cc: Allen Hubbe <allenbh@gmail.com>, Dan Carpenter <error27@gmail.com>,
 Dave Jiang <dave.jiang@intel.com>, Jiasheng Jiang <jiasheng@iscas.ac.cn>,
 Jon Mason <jdmason@kudzu.us>, Serge Semin <fancer.lancer@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>, Minjie Du <duminjie@vivo.com>,
 Wang Ming <machel@vivo.com>
References: <20230713085621.3380-1-machel@vivo.com>
 <e93e7bb2-c254-06e2-87b7-1f59e52930f6@web.de>
 <791a3c06-47cd-450a-8c4e-24fe52fdaa4e@kadam.mountain>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <791a3c06-47cd-450a-8c4e-24fe52fdaa4e@kadam.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:1HrQuSpmaHM4U/kqx1EesLmfL4AxZivt91GoMVzdt/afBORn1RE
 va3x/tD/LpQbLUygnPaNuc0D9+h0ozUSelTTuYF7x60NCIcscpf2UoAva+htHemZ6aTCnw2
 hLdpeiEItuTyOQxike4/c2VsR84piAmlVAQus6El04Ju/3KphQJEEqNn99cqcXwvKPGkuXC
 GeB/yGek6X504YsmNtGVg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FUIzgEEdk0A=;YAAHtpeolCqwtjE5FNCLL6Yyafo
 R5/KyRcicT3d4jb0FNop/ocni0V/gSTvjjkoNUXrGdDwbUWBXf6CsiI3ZZy+txhgPkw73VKhk
 wuBZUKIHTd8m81LmCwuo1Odj8o/UckQYgXaoRYSwKIlN1Uq0pHj4sVRVoJgayb4vpb/brLDzm
 mJcBOgdvO+gQUXE+FkapSexyVMFfugC1HjbLY4HOOyk1aBIHhd2i2tgOyysuzMmxFAAXk7ycl
 RJGu71i3aMKzfzW73v/uGMO22hCsCoC7hd1t8lPvttl9o7MVa4/xSd5hXgEkXrxfrotn/6rku
 2WV2Ckw14Hw6kNDO3fSUXS4iPM+IFGUsjNkFjs1klmtk6WUQQ0LH2XD4XmtveHxyUXumMP6YK
 On382J/NOnKOpNJPpacWbwleH36NWd0Qk4EyjW/zPyU5PFKXQH1H9188aw+PHoKLsLs7FAUx1
 8mzhSmxFViWZy37uFar9/LQVxCIHowMIgRxrKSs3kW9Wk/FHkawdLCacJlNEtKej9KsTYgRFD
 JHDTHdYTluw/hU5yE2cZdmhQxCzP2uxAfhgNy3jFG+VE9v+GGzXrWrxxJcF8b+oDIkzgKJFV9
 9lAc2v/ZA4TW8sD97UYF3woFJdDKUZnLtABi577BxTzLkajab86bMT6JsgRkvSGybWyHvuasS
 1eiFKO4gkGKkQ502mlQp2OJKncARVHpHUCHxo2yOJsQ8tw4MbG/oz0Js2MSmizut5ui1gvHb/
 t0CnHKUReOEuuSGPkoKWhA57KyCN59/AMUsEcoX7O9V5HZFFIoPr8fJGCf1yPIBKaXFsIjfkp
 qqK8bk7Ay4AQQpfUruYI/D++0JxTl66dtI0fKXFan6QMctsZtMb4bMqIOnNChs5qiwn2sx0um
 RL86z0eChB40WlPyTvQGBueSjk/SEDutSTwKQjHnIubcTUl6KG7QRkQDgkto84j//i4euebXH
 rG+p/Q==

> Markus is banned from vger so only people who are on the CC list can
> see his email.

I hope that circumstances will evolve in ways which will help
to reconsider this setting.


>                 A number of maintainers have asked him to stop
> commenting on patches.

Can remaining development concerns and communication difficulties
be adjusted any further?

Regards,
Markus
