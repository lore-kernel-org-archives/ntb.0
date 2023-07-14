Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5A51371C
	for <ntb@lists.linux.dev>; Fri, 14 Jul 2023 16:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1689353802; x=1689958602; i=markus.elfring@web.de;
 bh=QCiwSyb0TzLQSWgJIhjOMjaQ5YSX/3zOKPMbqyU5KIE=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=XgoDKOF8yG1bLGax+WFKN9z18YAHuduQmfBjf+vDyBppg6orqHtPzNHMUWT9egLltxkvOuG
 SG4TpZUZeu2hsOnmnpdQQxAUZR26fUbYwcg0hW+1VR6MH/HJPf0IPfaUQoAeohE7BDsPvYGFK
 qhJn47N+2/7Dw6NmtmrRkmMVWl2E2XNGD2B7p8al62O4NKvrq4K/N8Bw6jX0PhJX+/d+l3waQ
 VV7zrWP8lgns7k50oICVcBt+rAdmWHJU63eYe6eERdBQzlr61AV5PXkbHQjCALmseShPMODVg
 oDCAkHupTy83Vmpwv1iAjnMqmT4BOVz+27WS8J8JIgh6rznF8flQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MKdHE-1qfAjV3beW-00LDLO; Fri, 14
 Jul 2023 18:56:41 +0200
Message-ID: <764736f8-9d1a-fb8d-108f-5fa856b7ac64@web.de>
Date: Fri, 14 Jul 2023 18:56:39 +0200
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [v3] ntb: Remove error checking for debugfs_create_dir()
Content-Language: en-GB
To: Serge Semin <fancer.lancer@gmail.com>, Wang Ming <machel@vivo.com>,
 opensource.kernel@vivo.com, kernel-janitors@vger.kernel.org,
 ntb@lists.linux.dev, Allen Hubbe <allenbh@gmail.com>,
 Dan Carpenter <error27@gmail.com>, Dave Jiang <dave.jiang@intel.com>,
 Jiasheng Jiang <jiasheng@iscas.ac.cn>, Jon Mason <jdmason@kudzu.us>
Cc: LKML <linux-kernel@vger.kernel.org>, Minjie Du <duminjie@vivo.com>,
 Dan Carpenter <dan.carpenter@linaro.org>
References: <ag2uziaj2mbsqryo6ss25w5s3ryenshoylraejtgp46gxce6hh@qcggqjnqheb5>
 <b5139e22-cf5e-e95c-fd33-7e1b9b4d665b@web.de>
 <gkiohfwsrxclkgkrlvfu37kvbv72tahc6c4kvz34uh6hhwrunk@surqby5talzt>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <gkiohfwsrxclkgkrlvfu37kvbv72tahc6c4kvz34uh6hhwrunk@surqby5talzt>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qwfT00pv8Okxa0ECtW66ATjuYdPrpyDk2eA8iMBtin/b2yX1ZjP
 otdgcW8wXvEqytycxUkFfR8LHvl7Raj7iLKB3sdJe7jZDmbfzq0p1lHVr+bi0qQU4wkO4uP
 WWlPyIvioFiZgNAG8rnp9nWuu08BjYCskrivjFE/EBmVebrzATISUqCHrfi4ph5srwx8QBY
 e9+8zHy+u08o4orNv6kig==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZoOAbF4nRB4=;O4lR6DJUlGEtDBkO3XRFUROsNIi
 5xu4iH2TDbkNu07Ak7c5VE6+WluwOKpsQ39RaeB8qmldDqvhm6S4wiELW3+jBoPu59M42bKSb
 8YE+mIAwh2XpD0KbxuvZz7x1W+82wAHXcPn89rrk7l66oPvTCx4tPiGK7qc6kEHIbxd7/hUyr
 RDen3uNWwwMtKQtMDDYf82jLHYr2S6YDH1/g/+I/zZYAbkkVUDZotqaJ6m8pGjVYiZ2n1/HVi
 D8zORV15Dzkn2gCzhh3NxNv+Y6lJ6Nnvcf7SiSzT5QedScMvY6oDJQRLo70NNQ1y9AA9PpjV5
 g+YiMFED8on50c3Na822Uj9NMOhiyxWICWKtf2pZC02HzzI0LP4q7gKoUXm42DWPjNDL4vbxB
 axa8zkNXMQB2YNvvuvL4uHKlKGTk+RfA/3vBlw7H4cRPKb4N+nWPP/3zUM+ARiSFut/aSPRYb
 YAS9/n2adXIQOFHHnxoDnQtGnV/OtpNA0SEXMBwOzBFDGJjBX/aUAOpspHfy2gw6j6KIpeL11
 DaxxzKQh/qkP3tgGEKBz5Bs9f0YzVmQsaDr0IXHjMdN1/0gqGQocxLK0C/uIl58k73JAcoPXa
 Ndjn8psGXio0rXW0UzNEWfX8RFxuN1ya0adv2YZsoC2/zzhVjvzhZ80yY9sDmjIsKt9PlWby3
 M7e683ScIaTlYaCxq7dDoINpERN6XOMp/ojhiJTNQVQtFxQrY4wdQXWphxh3+/yKG5V3/1MPM
 1qoB7hRjQXVkHU3vP9R529q9Oz9pl0s14buRWRNEcNafSBKkeC0dNAnmNGh6uEWjwfwahoYmV
 ub2+0WelQDQtpMStJ3wpZleWsI3ZtBhZcaeqFRrM39HZO17snfkpb474xTkqFyblV6NzDu9rx
 0D0JJXAvcDl3ZoxV6VoidkWxme8hbsAEAWI9u/Yo+h9sag6XZ5TFndHcT5DVRYj2MeBuxGSvB
 1lOPKkBthKdGwUnhfB/ISddZatg=

>>>> It is expected that most callers should _ignore_ the errors
>>>> return by debugfs_create_dir() in tool_setup_dbgfs()
>> =E2=80=A6
>>> The patch itself is correct for sure:
>>> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
>>
>
>> How does such information fit to the Linux development requirement
>> for imperative change descriptions?
>>
>> See also:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/submitting-patches.rst?h=3Dv6.5-rc1#n94
>
> Well, the patch author does follow that rule in the subject.

Yes.

Would any other subsystem specification variant or patch title become pref=
erred?


>                                                              Regarding t=
he
> patch log body it is impossible to use the "imperative mood" always in t=
he
> entire text.

This is usual.


>              In this case the explanation is pretty much clear

A terse hint is provided.

I interpret the referenced Linux development documentation in the way
that further imperative actions should be specified also in the =E2=80=9Cc=
hangelog=E2=80=9D.


>                                                                and doesn=
't
> use the patterns like "This patch",

Such a wording occurred also in a few other patches by Vivo developers.


>                                   , or any personal pronouns

This detail seems to be fine (in just one sentence here).


>                                                              so IMO it's
> fine to have the log as is.

I find the change description still improvable.


>> How do you think about to add the tag =E2=80=9CFixes=E2=80=9D because o=
f the deletion
>> of an inappropriate error detection?
>
> It doesn't fix any real bug. So there is no need in the tag.

Do you care if the previously used null pointer check was wrong
(for the variable =E2=80=9Ctool_dbgfs_topdir=E2=80=9D)?
https://elixir.bootlin.com/linux/v6.5-rc1/source/drivers/ntb/test/ntb_tool=
.c#L1485

Will the source code comment =E2=80=9CThis modules is useless without dbgf=
s...=E2=80=9D
be reconsidered any more?

Regards,
Markus
