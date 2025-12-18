Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8395512B143
	for <ntb@lists.linux.dev>; Thu, 18 Dec 2025 08:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766047624; cv=none; b=BnAN0JMuO9HmnAhbMp5JB0JoM7zNLpnqAE+HcoQHVt0NsZci/lcTcAPB8mmsNEGHVO9lLACyJx1rtsUo4PDP+9JJsMxTSbky4TL9fQrV6mPBPVPSJojT8pOaC069ZHkbIQGi2ShcTntEtMvKOsqUORfdDsJGzdc8cglpqgjXJJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766047624; c=relaxed/simple;
	bh=XHIG8ZaiOysBi+kEkRT/Pxsy785uIYxQ7rQWMGxxbFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V+L01rRGL7Of68YQllkAkRZtgAySGZVxOUV1ifUTdyeaTPaupvNGN7bSfqk4l3R1D8GgasJHlwyhCmMSUkEocgQV6bj6uobKzVkguVNCdBvikxgNpBa+237FvGIeobn2oT4vn9hw/QtmmPkjO8xcHydmFVlbO2rqfIOJ7qYCngw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OKQi2MMT; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OKQi2MMT"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-597d57d8bb3so291527e87.3
        for <ntb@lists.linux.dev>; Thu, 18 Dec 2025 00:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766047621; x=1766652421; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJdDFRzyg3Bx9X5Q0ILnJGPQ774/Ru3KkBZo5kSdGu0=;
        b=OKQi2MMTeo+qlwICsP2VRprP4ZcFDk1kYujUpVixnqX9rW1cLrUmbIybfuLUB1jyx5
         rV4D6H4IQ08OUGyDToBcQh6QUX0TyH5vpqD6lqcfGxf2ajv93R07dvm8UU6kwjQYcRPr
         OBAfTlJzSyuSSDgcSuw18AdhEr5hFcfZRPpiiEQ8yUd677Qx1S3eF7NYYn36k0AhXTCf
         koMAaNs5HnCjKThfojx4hayMbpB8a1Z7XtC1zdAR3/e8wFviNjahSHGuThIzQYHRnOlL
         3CJT3eWBVXUSlvjvIsG7bTctGx8sq1gEX/oqXP7lyHEHppyxsgYpDt7LcP7TOVAVfU5n
         yiUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766047621; x=1766652421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hJdDFRzyg3Bx9X5Q0ILnJGPQ774/Ru3KkBZo5kSdGu0=;
        b=J4Nbbig2ieRokFzQB7E9meYRC3VF6SpqZmNmwlXPpRmGPemFtdvr9ZLQGRfJ3IO+cQ
         5ai88YFr6rb548YzluMk/TthYZLnXToB1tiV/dkYSCsyCOEIpH1xmn55ss8hrfxws+Fx
         uCN07ZKEoz4EXEhxmhbukC2A2FoTFWObvyeRO26H9S2PQRVBIWM+8iDaQ/ZZtSXauGPh
         iaqAFTFeYpQdYCcMKpWFnvRpg9ZgZmKBrB+UZWJF8Lak2JpwacC1HDDmrG5TUFBxRmc4
         bW4XWrQFZljbTYsHH4H3PLybNrokyCc5O3+Gfbd2sJsMYkckyFu9OCZ8CYF7ZwK5prfZ
         ihHA==
X-Forwarded-Encrypted: i=1; AJvYcCVjTBUbEJGLAyyR9DvNvMcnIabi4662ZSLchB5GilyQsejH2H+hLpIL6hjF7n+bqxyJ/cU=@lists.linux.dev
X-Gm-Message-State: AOJu0YySiR+CXugxlCJLDYscKJFk1GsNGhk3wm5OTENHcWk/cZlTrC/B
	1N/mXTay3oKlug5INpb+l01foXE8Fcr482bADqDSasROg51n5DE5E3ixPvZCLbN6Et1THv32eNL
	p3V1J7CDzWlD5SLq+ZXnGln1kl2RM23t5aYUM2Br+Ig==
X-Gm-Gg: AY/fxX5rLnm5fSdcwuVOLahqnt25aqqdY3Ve9t/XzUFxRzVXYODVmGWE3zTKeZ9c79K
	wAKvoRFYbEbp7Q62OAzbYlbd38CjUG2uZ4tKdva64CFA7lF7GQnlww9+AwdYNMERUjsBZwzM8tl
	QK+dsiAHf6IyCliQ7FkS3Mtv+gxjY12rxvwyC3M8CU/ofMDbzMRePpHMjbcA9oRiT4Oqrkqi61F
	QAUHuy7szkxd3da3ee63RCPNHJnsw0iFerBJQbg8KuvwvgH7ss8aOGpTVsmj9qdrQxclA9SWXET
	CH+ve3gA7YFOHEYc+DcyMwZAMILUr+zgrOvQ8+8=
X-Google-Smtp-Source: AGHT+IEOJHh6KlM8XmllYHkFzlElpuWoiMgLSlLvOeYw6z4FQdZhiPAQhbyhnUNFcaiyy6WpqLbBRn5b10gTQ1dcwYg=
X-Received: by 2002:a05:6512:110d:b0:596:a540:c95f with SMTP id
 2adb3069b0e04-598faa23455mr7650148e87.19.1766047620636; Thu, 18 Dec 2025
 00:47:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251107142526.234685-1-marco.crivellari@suse.com> <176604166015.697128.10969426809262148398.b4-ty@kernel.org>
In-Reply-To: <176604166015.697128.10969426809262148398.b4-ty@kernel.org>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Thu, 18 Dec 2025 09:46:49 +0100
X-Gm-Features: AQt7F2pn0DSpi4qNVOhBmgyJZ8fRx9Z2BsfZRwMAzeFaKDHz7VR1gaavwqwGqL8
Message-ID: <CAAofZF67wxhkY2aurFXH5fMmadcDoFk5ARMzA=G6w-SSMRThbg@mail.gmail.com>
Subject: Re: [PATCH] PCI: endpoint: add WQ_PERCPU to alloc_workqueue users
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	ntb@lists.linux.dev, Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, Krzysztof Wilczynski <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 8:07=E2=80=AFAM Manivannan Sadhasivam
<manivannan.sadhasivam@oss.qualcomm.com> wrote:
> Applied, thanks!
>
> [1/1] PCI: endpoint: add WQ_PERCPU to alloc_workqueue users
>       commit: 8b2ff37c6b50cbe722ebd780aac40f92c4f8efd3

Many thanks!

--=20

Marco Crivellari

L3 Support Engineer
