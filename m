Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED722F28
	for <ntb@lists.linux.dev>; Wed,  2 Feb 2022 21:10:40 +0000 (UTC)
Received: by mail-qk1-f178.google.com with SMTP id 71so838120qkf.4
        for <ntb@lists.linux.dev>; Wed, 02 Feb 2022 13:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=TJiHaenZuFuQ0gBBRp6+G0aYMDsUoYTGvU6NDOHtmM4=;
        b=Vv0fn27iIp6+aFkj/XQ51oPAVdmPYfop6QHJuEqK0SxN4kY9Bce++6RkGzjvlcfLFM
         z9XNFltdEr/oOd0DtpTZwk0i9kTIhmPEBzM1S9d8Rs3pYlj5iBbrV7Ir5lQnteZOISOv
         iMifghv/UUEDr14dMmYVDl2CTFljFgFD3MCLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=TJiHaenZuFuQ0gBBRp6+G0aYMDsUoYTGvU6NDOHtmM4=;
        b=EayckgT54yuFQ4Z62jRMcnxIK2597+nYRmrJLrD7x2Iph2P2z+bHd6oeaDBTen4try
         2p+j5PJpUh7gcc20clB95vx0ypShs88TIbulI3Ol90f9FgGMCm0BuWDy+Ga1BhTSi3qd
         Z3M/v/v8zhT/4o9PprVUGs3CLWHcxG3uRadqWTMN+XD/Rx+pLtkD326SXkl2guvTju1E
         DTq3EzpyLzC1/NSS5OtrQDbKasiXGQd87mndIMfYFHkFmHBjkc48pwcjivSkbtQr0Rwu
         pw/30oU9bYd5uU5oFpxEDJrls0QCobkikpXV4OUHjpPa58m6nT4gQUNo24zJfqK//z4z
         scig==
X-Gm-Message-State: AOAM530YI6cnptcufLOZp65v84NPM/IE3O/MJBKbQWCjXFdwGYz5jI95
	D35mgsyqhRadZpoxSMl71b2Wz4x9Bul7gw==
X-Google-Smtp-Source: ABdhPJyZwBk6moBL7hm05yEoSoWoDbdrsAENLybPrgc7wFTC8dxZuSmIVVZ9xMLo2kvOaWJXlwbdxQ==
X-Received: by 2002:a37:64d5:: with SMTP id y204mr22304448qkb.385.1643836239385;
        Wed, 02 Feb 2022 13:10:39 -0800 (PST)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-32-216-209-220-127.dsl.bell.ca. [216.209.220.127])
        by smtp.gmail.com with ESMTPSA id y15sm13231472qko.133.2022.02.02.13.10.38
        for <ntb@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 13:10:39 -0800 (PST)
Date: Wed, 2 Feb 2022 16:10:37 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: ntb@lists.linux.dev
Subject: Welcome to ntb@lists.linux.dev
Message-ID: <20220202211037.c76tpezi4ffmzuqr@meerkat.local>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello, all:

You are receiving this message because you've been automatically subscribed to
the new NTB list, hosted at ntb@lists.linux.dev. This is a test message to
ensure that the archive is properly working. You should receive further
messages about the list migration from project administrators.

Best regards,
Konstantin
