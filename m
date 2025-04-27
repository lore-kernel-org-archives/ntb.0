Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0159F1A76D0
	for <ntb@lists.linux.dev>; Sun, 27 Apr 2025 17:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745774293; cv=none; b=nKCSazmEgU5TQxI1Yu1i2ZkO01OQZSzM/iFcipmqssrLlS9tqIoNL48Fu/Wvsk6mmC0FpJhp7HI1+zh+v/tY9onCgoGJ58XTDHt3ptVRdA5kImWFUhS+d7jPntoLL7/gEg4Tsz34V8aNGNl2H+XTvXlxFJhpKuhwYhWwL9b7ffg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745774293; c=relaxed/simple;
	bh=Gnuhvv4KUPpANGsE/eqvgSDbJAwmlBusMJ3GevX5lOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xpn9K4tvyXdyaO6iX9Ycpn5ydJUj4DegISwt8o+dZAX2xqTg7JugEtwfkzoRNOB6CT8hjtPUwKFUeKBKgFjydkmlMne2tDOexMl3fVT5xQjKh4IJv8wEL1jsMpZpDqMBl4aixVdFfnnLdXGvWohhjGbU+k4j0hafzJUz/nPgs/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bP1mOTkP; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bP1mOTkP"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3081f72c271so3717428a91.0
        for <ntb@lists.linux.dev>; Sun, 27 Apr 2025 10:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745774291; x=1746379091; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KGfvwG0lJjJnssDIjMncK4zxO5Uxbjv3u3y95m4bzb0=;
        b=bP1mOTkPKHlZjKNx92r7VIWjeMOtTgYya8R0K/IIebX1A7hNhqNKYjm1zeVAFcrXKw
         +P4ESLnLm+7pVk+SRwC8Uv9Jmo2BQdwEiHKRUa2Q6UTtn1AQheeRHHKQjdDSfuY10OIB
         zucSWDlzujv6c+62C11qxOB6sFhg8qw1YaL5CpjnnD4g44mSJG+q2QHMJl2l100NwNr7
         jgPNgX1DDx9mXkuZBovhU/RqdrSxh1LCUFqphthI2ZHp6ebhpSfbeQSg1DwBIa/mPCvB
         2qhBIVGzlNmZ7uWMgR6U+6mENNX0XDLSF0uU7ajKAEJilpov73hMcIpsg2esCTqqfF8Z
         jxdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745774291; x=1746379091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KGfvwG0lJjJnssDIjMncK4zxO5Uxbjv3u3y95m4bzb0=;
        b=Vsk6VPtmEPxdivKCaOUgZawOoYHUyfcgks/m0feu9DhJnirNb5r3i88wg+bXtn+KSM
         9Yhbnr5gU2+MR2acrZbdpICxMhTbUgQ4tM62Vne1BTnC7A0WNI3vfS2iQdCwlF9uNtf2
         wEqk0HAbzGUhGNndyvWgjBA+QhCBYjdM4vACLu7jJIIrAX8l5WlYdMHe8DTNRcqujefa
         GF7HwLz1mWUVSCEetdWYH1mLqpzi78ww8Uf2rzRo1hI4a3TJ/6BEqY7IT/3lM1HrabW3
         +BEOHOFueljLOOAwtgLGb/LYn7QkWGIeENk2ba9UD3djstaWy4Q5kLc+229tsfve4zig
         tVKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUP5Hw7nuNyZeyWh0UrJJuL2Zwe4SaBvozavepiO0qIyZnCyNyH/8F2K/ndDyRrZeFTAzg=@lists.linux.dev
X-Gm-Message-State: AOJu0YzXOvtG16Zc3GJEpVJdsvkh+fNh4I0LbsGqQkK336lbOTA3RGXz
	K5kGkvsipFuet276VoASY77Bx9hF55st8VeewfWTW6u+tQwWIvDjbCOizyyFrQ==
X-Gm-Gg: ASbGnctG4UjRBPkFL728KHFc/tD5h0HTYIYMgyAczr+LDb6riTMZv5uJYWvmRRMjX7G
	7nq6vjKBEVznSqYKWge2Py1XAFXIYctNm8gHL0fefvmOnveGSOZRCvuA0nZKC1oDLkHQQrBK88U
	SqO3nNpqsuNy0zsrhq3HaUynNhCzBimLJBXuUsdMFdfPgbxPXiQOhaQ9G9QYx5yPxZ7R2GbEbVF
	kxS9JNsQBQ0NVzMFswC1ILf/tq3nFtOIBu+4Wvd0gqBWXPcCaUETxafLBaUz6b2uJqWBIkaqoVH
	eNG18GbdNEa3g31cEba+VDTdakCHPSpbYdwKrXgMc0IUiriQzxP1
X-Google-Smtp-Source: AGHT+IGEJGjOrAHuRlC8FW7W5k8PqHO+m0uDpo2VUIDPeTQamnBsMG6rTDTesDmrV+/O1+7KTWI9/w==
X-Received: by 2002:a17:90b:1f84:b0:2ee:f677:aa14 with SMTP id 98e67ed59e1d1-30a013075b4mr8795318a91.13.1745774291083;
        Sun, 27 Apr 2025 10:18:11 -0700 (PDT)
Received: from thinkpad.. ([120.60.52.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db50e7741sm66038245ad.156.2025.04.27.10.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 10:18:10 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jerome Brunet <jbrunet@baylibre.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v5 0/2] PCI: endpoint: space allocation fixups
Date: Sun, 27 Apr 2025 22:47:55 +0530
Message-ID: <174577426298.86106.8309026357756060948.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424-pci-ep-size-alignment-v5-0-2d4ec2af23f5@baylibre.com>
References: <20250424-pci-ep-size-alignment-v5-0-2d4ec2af23f5@baylibre.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 24 Apr 2025 10:34:03 +0200, Jerome Brunet wrote:
> This patchset fixes problems while trying to allocate space for PCI
> endpoint function.
> 
> The problems, and related fixups, have been found while trying to link two
> renesas rcar-gen4 r8a779f0-spider devices with the vNTB endpoint
> function. This platform has 2 configurable BAR0 and BAR2, with an alignment
> of 1MB, and fairly small fixed BAR4 of 256B.
> 
> [...]

Applied, thanks!

[1/2] PCI: endpoint: improve fixed_size bar handling when allocating space
      commit: df4b24b510c9ceac32aeb3ed5904fd93b06a51b8
[2/2] PCI: endpoint: pci-epf-vntb: simplify ctrl/spad space allocation
      commit: b47493ff0d43608257a24d65f5b26a4a6376ff9b

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
