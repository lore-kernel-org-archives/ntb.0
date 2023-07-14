Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3D220E8
	for <ntb@lists.linux.dev>; Fri, 14 Jul 2023 12:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1689338662; x=1689943462; i=markus.elfring@web.de;
 bh=8gWY33wTzpzUxmAl88qoZIIP4htyJjzGqb0HZleyQWY=;
 h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:In-Reply-To;
 b=KNn6jsMpvJZ/uoqR7o1m3PQNGB1ZzKXx3I4kyXYuH/WLRO6Bbwk685HyB5grq3Q/KjKqxtj
 y+TWm8fX9j2o5PYiuy7wWGjOLgpWta3YoIWG481V+VAwz+LSdK2oBY805fb/cAC7/26J4NSdO
 0S35Ll/lpGBFwA+wMB7kER1V1jPntNNYb79fp5VZZyTVBPrqtCnGYr+cgNJ8F6JxsQr/LNhQD
 Im3YpnxpSc1VHz1xjiFgbyBePez/QSD6XlDBaYKGxkR2ZirH96qdGicpeAfNqzkIhRbwQ/dp4
 EBeaIGj9KzHH/n/cNqmozpIHrHxfTaBWYjlm4L9eN2qgbzOwxmkQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M5Qm1-1qL7VA3jtN-001Jsp; Fri, 14
 Jul 2023 14:44:21 +0200
Message-ID: <b5139e22-cf5e-e95c-fd33-7e1b9b4d665b@web.de>
Date: Fri, 14 Jul 2023 14:44:11 +0200
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
To: Serge Semin <fancer.lancer@gmail.com>, Wang Ming <machel@vivo.com>,
 opensource.kernel@vivo.com, kernel-janitors@vger.kernel.org,
 ntb@lists.linux.dev, Allen Hubbe <allenbh@gmail.com>,
 Dan Carpenter <error27@gmail.com>, Dave Jiang <dave.jiang@intel.com>,
 Jiasheng Jiang <jiasheng@iscas.ac.cn>, Jon Mason <jdmason@kudzu.us>
Cc: LKML <linux-kernel@vger.kernel.org>, Minjie Du <duminjie@vivo.com>,
 Dan Carpenter <dan.carpenter@linaro.org>
References: <ag2uziaj2mbsqryo6ss25w5s3ryenshoylraejtgp46gxce6hh@qcggqjnqheb5>
Subject: Re: [PATCH v3] ntb: Remove error checking for debugfs_create_dir()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ag2uziaj2mbsqryo6ss25w5s3ryenshoylraejtgp46gxce6hh@qcggqjnqheb5>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MXSIAuuDjH0PApKvbFtevHq8clJhmCHccqjpM3BRQ3tT0yhmxbI
 kaCbftFJQf7QZot/fi8Q9BiPbT5TbQ1xNa0Weu8Xs0UdTyqhJI698y+YhJ7M6JGYnenQl3v
 h9J3/dfQ5xJcJmCA/ioTh05D1+XvMOj22ALdWuuPL68P3vR4Si6hApzodMJVOxENaUdp9UP
 OAF512MM2veON4UC4rTag==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:eodHyXCFKDo=;WjEeY8MoyeA3/pGAmedDKDo8cVi
 AGEjU0iRS98PD82JITRUuSv/1heDbh6eYkUPTWvS45E6tFWkC3Zy2+JIqObVAkx9QwAB9B6OO
 kyKvg9PVLhYwGsmgWC/avW3hl919TdFVcV+x969H1VJ5nNjMYwma7gcUXAri0uUlEb8w+Amae
 dML9YOP6xMzKeRVWnUzn96+Irt2jbgm6wCIQ0C7NobvZo46aqU8q8RNby7PQdppqGeGD/KgFS
 Ls+YAqySskHhhKQV1GdoY1+yr0uZRCliTL+trU7GIDes33tsFTugtS8DezOOYaXc9H2+hKK1d
 dBd/En9OspsqUHHCd9QzmB/D3sZ+9xxpiKypKwy8xphoqy2Kt0M6I0lItEoMdZnGqkXv+mUNF
 VZd63SMFu5GGu4vCoySD3cum/3wtyUpYqO8t5nm4iK8JE/xb9HPs91KUX2tjFgv7JSI5FQD0d
 7TjbdrF6ZU0jqiXB9q5+8GKN0TSWTdlTepsfmNp5ChY1snNhlRCEoswpMbzti/M5X3mir21sd
 GR1zQmz4pOwCL+1Lny/x/kK9pC97cTJrLaqAKy5+Zmmy7xmnTUJAp8mQD1dhfvrjpNi0cR7oV
 VIeJYNWyI4Q1BslvQ3lpvRmdpwF20MHamZT9a6yNywpbhvJIr724YHGXj2LUpjhQNtQ9D7R4n
 TU6XQsYyeypmAE158wMjdQsMb8kIbC2duVokx/ATSW7Hi2VG4l9sKcobT4tvEE9HVSG2eRpCs
 qjtsXqFkq71/eDzT/HrBiroDqPfdl8R5oA9RcLm4PAqkx1zlW3oEZz3Me/e9LtUwyu72lR8ud
 ybZxgg5IPPcJ6/Sftbql3o2ydhzlwf99joOj/dv2kfBuC6bUbdc2Y4AzF4BRMCpCiGuSwt1V+
 XJhzsajUPxAQDRYjuTj+xNs+x+/l9GUmCCzpmhJoaY0HOZDJIlDg6gLaWenA6YaeA2aFg7Hm7
 DT4NTA==

> > It is expected that most callers should _ignore_ the errors
> > return by debugfs_create_dir() in tool_setup_dbgfs()
=E2=80=A6
> The patch itself is correct for sure:
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

How does such information fit to the Linux development requirement
for imperative change descriptions?

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.5-rc1#n94


How do you think about to add the tag =E2=80=9CFixes=E2=80=9D because of t=
he deletion
of an inappropriate error detection?

Regards,
Markus
