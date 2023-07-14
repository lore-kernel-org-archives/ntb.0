Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9791549B
	for <ntb@lists.linux.dev>; Fri, 14 Jul 2023 17:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1689355774; x=1689960574; i=markus.elfring@web.de;
 bh=ZO2GJGwtIPWS3VRBv2Q3BuLedQvTTif2EB23yS7oqy4=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=I0TAw2xS1GcgVzwkuqloy6zK5QWhzR8F+VwNOl1iWZNXkahGDIEYSkf13idrh/llcH51tQS
 8Mp+fIfRYzZopJQDelpZQPcfaoV1L7ItOhIDdKEz+IW778Ae2K4nAU5738fj3EjUQLqW3E1mq
 s7SxbG8cQQl/qYldB17+6pMVS88beanjEg75Bs0KMo2LOQouPtGvyPKGFnPKodrbwtoX8AWEO
 9CYjlOFKO8wzTjNpbtGbCLpLEI3O1zupmhn3AjxyAGYIqbMqBJs3yqww6GzmctJijnT6qm97J
 y4nwPWjZHi29hRgsqEzeDr1Nc+81wkutwItjA+/866Z5tPgvjbxw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M91Po-1qHcy20vTi-006FTh; Fri, 14
 Jul 2023 19:23:56 +0200
Message-ID: <e4a0a8a3-1699-83b9-d713-aa40866f1720@web.de>
Date: Fri, 14 Jul 2023 19:23:54 +0200
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
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Serge Semin <fancer.lancer@gmail.com>, Wang Ming <machel@vivo.com>,
 opensource.kernel@vivo.com, kernel-janitors@vger.kernel.org,
 ntb@lists.linux.dev
Cc: LKML <linux-kernel@vger.kernel.org>, Minjie Du <duminjie@vivo.com>,
 Allen Hubbe <allenbh@gmail.com>, Dan Carpenter <error27@gmail.com>,
 Dave Jiang <dave.jiang@intel.com>, Jiasheng Jiang <jiasheng@iscas.ac.cn>,
 Jon Mason <jdmason@kudzu.us>
References: <ag2uziaj2mbsqryo6ss25w5s3ryenshoylraejtgp46gxce6hh@qcggqjnqheb5>
 <b5139e22-cf5e-e95c-fd33-7e1b9b4d665b@web.de>
 <5d0cd0e0-d92e-42d3-a6d9-ec9fc3229b7b@kadam.mountain>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <5d0cd0e0-d92e-42d3-a6d9-ec9fc3229b7b@kadam.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jWh1JM/0Prj7Y1G5lXUZRyNfXoaxPXOgnGaPonUaL9A/QgkBJB/
 1GXcwtT/gMbWwhVceaLHQjSUEIUpUKdWE2Me5GrVui7EVR8yiwYpoIVUoLiMByGzhCI5K38
 wDWBVRCtQYdi16bLptbkbkpPr3aEN89lXPEDhOK1UFPopylylP0yML3XqCcmXqUlYsVSDA7
 3nwfTV8V31MrsiHy8qFMw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:iMCFS9/4PLw=;kOHfC8HDtS1I+AUN87gSKAVy68H
 xkVEpIlPK8Ic/DxsODNsh9PSq4TuZB+H0lMK/h0GtiwXDwguj6Ty6DQtyttGaIxs1WDcUwbN5
 cetw9V8yCYe3iZDGHn31aNSt5PaLvFAZXO8BXuWcfOHRKqYZxMhWLc7MH1CToGwxHCh8R+LM2
 PPoA4AodcCWiKt69hswJEDwG782j+DVnz5/y9fUrPixjyryCCYYB66xy2PsH95WSDrXo3L6Pd
 QSWeUVsuYZLDobjiytZQUg6I975ru31sj1NNsQRheIFlkPboxQbtMpAOQDMO7qZkgpmyTRlXY
 lkXIM8ouYZ1tzxfhz4taVUVeURE1dvA290GuK529YUeO73PCqk4Y4ovFX2ir8dXkiuaeSFygC
 lRUBj+ll/MKHdqTu7312ePQP5N0K+VJ17SlFus/eeYv0SFm+aWk5ascF7JNQeOxTH1sBps37F
 KouTVDYf6DdzTpp9tojBjHvZDyCaYq99dZ9ThJdYQ3laatmDryVIfJo1LVIDilqY/xwQMFadh
 hd+/x/OQhamD/RER6/Njn67bofjyrD3RDR2YXfUzX88PW06XH+pWzYlfBAJYrh2KN9w+1oIlr
 dzsXA/vH9xir63fUl6D03S9zDDCmjFz+keBuByUI7N4PaFBNFON6NaoY1w8oVRcBZufB8XjIU
 CvfPW7rWF3/x1mYyXfwKFpqNQXBUMzME1EKiDboEl6RYA/9SPdwp+sAdbFYSxr09WDGWe+yQZ
 GLyQQMJvismh27jJp66EjTZNyyDNz57qxhKF/LvtKI1Mq59a017P9J7QBTL5s67aSVftey7X9
 RXKF7nT4S0vEY87E0eLAenm9bUbzK9il2Ddz7pVIJPWQJAOtiaUM0zP/z4yEr+fP3e/4984j8
 ymSxjLzHK6bZd0CqwDCrLWVl2bagwrLTfsiWk5N5KcEzrk8oNlammeEAChvgZ/RWkHJlRA4Ql
 MbjZYg==

>>>> It is expected that most callers should _ignore_ the errors
>>>> return by debugfs_create_dir() in tool_setup_dbgfs()
>> =E2=80=A6
>>> The patch itself is correct for sure:
>>> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
>>
>> How does such information fit to the Linux development requirement
>> for imperative change descriptions?
>
> Markus, you already replied to this thread.

Yes.

Some patch versions were similarly affected.


> Greg, HCH, Matthew Wilcox and Krzysztof Kozlowski have all asked you to =
stop.

They responded in this way because of some communication factors
(which might be unclear to some degree).


> Those are respected kernel maintainers.

Yes, of course.


> You should listen to them.

This happens.

But several development discussions provide opportunities for different id=
eas
and corresponding advices.


> If you see a bug, that's useful.

The change acceptance can grow accordingly.


>                                   But if you're just nitpicking the
> commit message, that's not useful.

I dare to present additional patch review concerns.

It seems that further contributors occasionally dare also to support
such open issues.


>                                     We have explained this many times as
> clearly as we know how.

We came along recurring communication concerns
(for which a consensus is not directly achieved so far).


>> See also:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/submitting-patches.rst?h=3Dv6.5-rc1#n94
>>
>>
>> How do you think about to add the tag =E2=80=9CFixes=E2=80=9D because o=
f the deletion
>> of an inappropriate error detection?
>
> No.  It's not a bug fix so a Fixes tag is innappropriate.

Would you eventually prefer any other solution for the discussed patch app=
roach?

Regards,
Markus
