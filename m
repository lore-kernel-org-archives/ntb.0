Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF9C37AA9C;
	Tue, 18 Aug 2026 16:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787070581; cv=none; b=ZDv9dFa4g2WNs/YhYGvqz5KuUshvbWlB2MsnsZFLT3qLhJMnTVlR4H5BjkMHJlRWiTMIxGdaASJfmLIUY70R4P2Oy4HPWnH2wR18OrJJF+RLaMDiMa62251oYiksqrw6KatgbwgXr55Kp2a4/mHz4XJXxLuRqcJZt5yE0BARhQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787070581; c=relaxed/simple;
	bh=UZptl13hasY/1o2+WZvjXVGb0Nf3xEdxVlbdx22mvc0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ujf7swVewwCmUGEqgTw/5kXGTJqPMmYxo9He/39yjXdPJJHv++bt9CNEhpOV/FkdagEsmEo+LzZFTk0LhUotGMhu9PKBBNn0md/l+wd8IW7tDSagDjDKIktBMdrW+Tl8UEdSdMulPYusy0p7Yef9mQrUS0MOFfqIih9exsqNOCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XsPGKYMJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XsPGKYMJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C42E1F000E9;
	Tue, 18 Aug 2026 16:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787070579;
	bh=gvhfqSzMPTHnXsOQF6Nle3+qnXP4JYuArvD4cUB4mAw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XsPGKYMJ5I5xR1LFH+Gu1FFzTaAxcBQ8Dk8qllukWwE8Cwf2vOaB4fBnw+80XFaVL
	 Ztjjo0rr8/MQNUdUPjH2Aqgkc25EySbuGzWgCB6TyY9dnK3YKiWJhMFyCQ+033rBj5
	 +Izte+mOZvSKNGxMZ8Vd+RiaVaIz02TaHTsSQq5EizF+egg9oNXITXDDL8bgUgOIpO
	 6kWBXsv1pjkJvE005vqji13sT/FS8aSiPgwdsTOY57KapHIlOwOb/C8mYtP7I6e1Lc
	 CgqQrixBPXLFHVQMpxRJcdDAmqV0RXPE3wckHb803WRYlbwbU5NlOeg+pbxNwT+m03
	 OF8m4eriSTdwQ==
Date: Tue, 18 Aug 2026 09:29:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen
 Hubbe <allenbh@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, ntb@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: ntb_netdev: Preserve CHECKSUM_PARTIAL
 across NTB
Message-ID: <20260818092938.4121c220@kernel.org>
In-Reply-To: <20260814032913.3558500-3-den@valinux.co.jp>
References: <20260814032913.3558500-1-den@valinux.co.jp>
	<20260814032913.3558500-3-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Aug 2026 12:29:13 +0900 Koichiro Den wrote:
> +rx_drop:
> +	ndev->stats.rx_errors++;
> +	ndev->stats.rx_dropped++;

Error implies that the packet was dropped. Could you first
iron out the double counting this driver is doing?
Please see the kdoc on struct rtnl_link_stats64
