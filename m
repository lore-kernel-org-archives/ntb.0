Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64177330D50
	for <ntb@lists.linux.dev>; Mon, 16 Mar 2026 16:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773677491; cv=none; b=aIYNwihij7UFfMqxmKQWp8hMZjiLXktnviy9oskMuXSStUcng28pRhGTxw5LukY/tpumZ1EEwzFolY3Xmh1pTBXeLGpk/1sY7DPlOTxtxEmyP3g9DfA6g0aqTZsZ8hq1kQx7YYC/ucXt1IWkR/ZIYRA3O0poxSZiJ9d53v13/RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773677491; c=relaxed/simple;
	bh=h383HKe73xPD5BfbROE+FJ0gKDZgGVTPazyVd10gOrM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EjrVyED2QQbSU59r/qE5c+TEk4ktiQxK1eldT39DfJb3nR/ayf0mXo4kV8vrIpl9kCxmEB+IP3aCtC4W/wU8G5L5Eme7bLGW2TnJ9nD4yh2CsOw9bO2gXVrEnS4mGWbv2QOrKwBFfdCiogRN1NdOBueyTlrpIK1Jc0mf4krRFug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=DE8UyxRl; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="DE8UyxRl"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-128b9b7e3edso5159c88.0
        for <ntb@lists.linux.dev>; Mon, 16 Mar 2026 09:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773677489; x=1774282289; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/uUDNZw2WektSMX1w3e/CjBfHG1BTi7Ha9qQji9wag=;
        b=DE8UyxRlemIAAkkbnlK/Pd62tgivoc1fWb+lxdN9FXJuXCt/6nY8QpgTis8gSozsAM
         2yI70Bu1qli5d7gdf63hWReMBvAhLczHJjgYbYYkKg1WuTD9nIRcsY10esEzHQatJtOu
         cBv1l8xrmsqxWCU5MhUgXcvMuIfn0yOic0Qna5QELoMMgWPKVB/1ZdffKPBkZLZbKaph
         gO3GRZPuKLrznjg6jqU8P66r3H8BumQXwdVbmI8WpvXfE80KQlukB2CISDRoSyGJO2CG
         zLwBjXhsmmwx1zQIjuDmwtA/Jfb21n/LozC61iHz1iYbB32GGHJOlMJpgRs1LYUceAHD
         39IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773677489; x=1774282289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U/uUDNZw2WektSMX1w3e/CjBfHG1BTi7Ha9qQji9wag=;
        b=nPi3GIaabAd/fwiCaX5LJ6XugN/cL9nYYvBZGFDGJGnAF4pwG51Ip4aNSwUismBGS5
         j1WG4MUPXhU031nVy40d2/iSgPk6H6EnWE9BCPJCbymumBmbYA/Sgiyt0vHfEjxogse1
         KmgCoq5+A/OmSRm8EKsmLNdqi5Q/ctglQ7zqMdH5450nReDA1y3BrG01mpcRwxqkSin+
         Ml3W29dQVP9sPX08oQP+OlMy+/AbZ5OZ7XRRXFR2S/vJ4asKAngUGEKrvG1+2zEHGG4M
         O1EPa9ny0kYISMn+lpQygC5WEtP1PAObw9DEf992JgyOTpmH1Lx4QAodV+EIrjdHjoH5
         YaNg==
X-Forwarded-Encrypted: i=1; AJvYcCXdsjXiWyhbOM541fXwlvf11FdHfpya1nv3FvCH2gKLBDdKcRz19KsGeJ1Qjb2ByEnRhTc=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy6/L5n0RWwyjOHBSU2uRJOoY5qXyddMvrimtx4fd+mjHWEnxkE
	aDvBPhoQxJE4tmM3bNsuzNizhOLedlnb6FOCdAeRGJLbTuRLf8IyKiRA4rf0fnSa4bA=
X-Gm-Gg: ATEYQzzJSWkWBbt/Ul35W1qTHavbEoZbVHngkEodJ5jLRaMQR5ANFF/lgjvL6LtcMx7
	QWSxMSfoATjclxv68lAFZl/Cih7UaHOZj50GyzbWhZN/D5z1Ns2YUAEaUyjKY+4j8kVGtq00YD4
	fzL8uUFVItb3yhz2qnxYCHyb8L4G7HEWFhEDHA2cOpNVqWHKqW9iTc4usPd1cZPnB2gs0a/Fu/g
	F7got7xbvQ9x6ClccRnz2YncEhog81ezIkzxcVpSyTbNGZQejI/Td/JBWQKRQnXUYn4xXX5WDHW
	32Mz7I9rW2kMeX9mcePp6yT7SxhMT7Ol+XBuf0oFFryGbocG5UowqOKcwC8smX8L2oBZryRwGVA
	6i/scSZc0j93cShxE+W+KNW8mikTxtiKY7SUw0RzdT1K2B+wvFOhUvZ8jqRMvnD7d0FU7Dg36Jb
	ASkzz9/Lj/NZd3RrgLMuC1Erxo5q+I8wpBML8=
X-Received: by 2002:a05:7022:4397:b0:123:2c98:f6af with SMTP id a92af1059eb24-128f3d3a77dmr7478509c88.14.1773677489206;
        Mon, 16 Mar 2026 09:11:29 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128f6283873sm12779009c88.1.2026.03.16.09.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 09:11:29 -0700 (PDT)
Date: Mon, 16 Mar 2026 09:11:25 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Oskar Ray-Frayssinet <rayfraytech@gmail.com>
Cc: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
 davem@davemloft.net, kuba@kernel.org, ntb@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ntb_netdev: add SPDX-License-Identifier tag
Message-ID: <20260316091125.640cb6b5@phoenix.local>
In-Reply-To: <20260315203345.13657-1-rayfraytech@gmail.com>
References: <20260315203345.13657-1-rayfraytech@gmail.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 15 Mar 2026 21:33:45 +0100
Oskar Ray-Frayssinet <rayfraytech@gmail.com> wrote:

> Add missing SPDX-License-Identifier tag to reflect the dual
> GPL-2.0-only/BSD-3-Clause license of this file.
> 
> Signed-off-by: Oskar Ray-Frayssinet <rayfraytech@gmail.com>
> ---

You could take off the boiler plate text if file has SPDX license tag
