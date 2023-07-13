Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DC31ED53
	for <ntb@lists.linux.dev>; Thu, 13 Jul 2023 20:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1689278732; x=1689883532; i=markus.elfring@web.de;
 bh=VnB9bGhnuurQ9PViXgYOM7SxnaHQ8oIB65FtnXktmKY=;
 h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:In-Reply-To;
 b=C4Px4PaUpD/WDYYlliLE5aNBG1P7asQ4e1Acil1AWqrnKMfgUSGypIF1tMempHGa/bJVt8h
 tQue1NEoAHokuDnVd4vszv8pnLPaqfrn1zf+9eaQohYzmhhUCzKZB/fWrCBjn9Ha8tiXb7fkm
 UNpY+4m+Dh9OwyODBJdFAWYsgEb1QhLnBtV7fJu4baHCNIszmiGNK3IqkqRPVA+D35PnADmql
 WpGOs3QjohhTkv60wyBOvm1Fij1k+T0ZcGqkUnk8F9fDlaU5VBzOdTwHXxU/J9NOR7aq/M2Av
 fpjrK+88lWOjPxX40imxMkZMcU9xSqO21GEGW2RcxBTMpHdkcXEg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MK574-1qfQ054ALm-00Lrwo; Thu, 13
 Jul 2023 22:05:32 +0200
Message-ID: <e93e7bb2-c254-06e2-87b7-1f59e52930f6@web.de>
Date: Thu, 13 Jul 2023 22:05:22 +0200
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
To: Wang Ming <machel@vivo.com>, opensource.kernel@vivo.com,
 kernel-janitors@vger.kernel.org, ntb@lists.linux.dev,
 Allen Hubbe <allenbh@gmail.com>, Dan Carpenter <error27@gmail.com>,
 Dave Jiang <dave.jiang@intel.com>, Jiasheng Jiang <jiasheng@iscas.ac.cn>,
 Jon Mason <jdmason@kudzu.us>, Serge Semin <fancer.lancer@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Minjie Du <duminjie@vivo.com>,
 Dan Carpenter <dan.carpenter@linaro.org>
References: <20230713085621.3380-1-machel@vivo.com>
Subject: Re: [PATCH v3] ntb: Remove error checking for debugfs_create_dir()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20230713085621.3380-1-machel@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iuhirCN7u8KfLiU9KNtUQkSUn8V/3VvRQ3wCDk3/Cat37egI1F7
 BKjBdpf/YW1YOYqZZJ9lAKZiBl7PUZiiZvum0Jq6Uym58nR+Lj09g3YQE5jo4vB7FVjc3pK
 uD7zZWPcpKfYFSzI8Oo1ANvULgRkNhP/BnC0YuQWNw6bnTJB+gxYSPLcCn4d5EzOEwtamnE
 KBRxQYzkXr46YrLd90QnA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rFA65eF5xds=;iBEw1fH/5jyoGIfSpM0vlxfPr1h
 p7m5JzTuJdWOZmfNSeEXVCPBDaI8aNcIngzG/aVGLKH+I5XBC3E1dMmls7loYV1feEAPw0ekH
 EOcaxNrdOFyj8hX7fl9quuZVdxrXFiJRZb4Wq2MseJOb1AMQ4usANJ56fpHq8BDRn1AqNzM+0
 m/RZN2/6kyTAc6ZYro1DRyoZhCukIHfyf5CJTDhmPzXpWVAZi5NYQmMFD35slzEeLfp7+mYqj
 YtO+5IsQR35oMvpKsiBOhOTSUwEH1b+MhcpFkiAsjxsXDiFjlxYePstZccVA8QZiCFygifOQ8
 3b/skocicZIdExpOeA20tB/+F1H+P2AD4zJ/jgmn7+tFXbRRj1tP8Qe5l2wkf2VMxe6+Kjrkw
 oIyXj/qx+kTKBikDNzbixXsrogJVbPXi7Lr8jE8aQSb7nGDu6ksEwJnsf6TsDl3WTlJu3QPjH
 cqZBt4jkNiTRXG2jTE6nodvqEv/TxFeCxzx0ppOu2FLA74mIOqQcXNViaqWX4LJyQ3j+vlZyy
 Y3gaX28GbhYWI1kdyJfIs3z1Wr0Y8nzLywARi/w6i3G6vG73ATB+4Jg0ip3pzA8YV38oTApLX
 rtqhW7j8Xj9WFG/xPWNC5eoRZWKj7mzqIeTGOjjK67pkPY8uusquy/XCtynoYeaNzGAov3PSm
 ZazRSeodLnp9DN8q3vRc4XwjRZ+M5vxvY0yZRrugCotRHY9im7cbnDL6Qg2rNWHvIkPFSvS7I
 Q5QviYplZqSBfZomz4stV7rIOov0eIz9vVhXzm65rvpn+oJ2nZnpdsSDJajlv4Uk4OnpWHTRL
 6VqGmAydXKYI1h9lVffd8l2JwNU6NV7O1z65+16m4a/oyPtam0PcBgGBNhEuQWWH8CGDGBxRE
 VDAhaq7KV0xbcKGDcx+pMcN2syHvsgvGToK/W4buPODjtfkORE6kXxwHAzMdSTmZWVHqULDEI
 Tdia5vLK9fASLBTYT+/ML4AR618=

> It is expected that most callers should _ignore_ the errors
> return by debugfs_create_dir() in tool_setup_dbgfs()

Please choose a corresponding imperative change suggestion.

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.5-rc1#n94


How do you think about to add the tag =E2=80=9CFixes=E2=80=9D because of a=
n omitted error detection?


Would a subject like =E2=80=9C[PATCH v4] NTB: ntb_tool: Remove an error ch=
eck in tool_setup_dbgfs()=E2=80=9D
be more appropriate?

Regards,
Markus
