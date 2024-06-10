Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DEB76035
	for <ntb@lists.linux.dev>; Mon, 10 Jun 2024 09:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718011957; cv=none; b=NSywXmPsokab6ag5ikJaiLA5zpH6kebR+WY9ZfY+Ln3oDrvvxv/q6L/ujcOYRcLKauJ1dU+jH4y0bTs4zXK3yybaMNCZ3VZyCehb+kng3RYf9VC4tLMAsbxTNG1auC871vMvlejVNslNgXijrpdsM8Q3tJ3ufHTTpAtS5xtnMqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718011957; c=relaxed/simple;
	bh=gbarn8HvvnKQ5tWS5o+S1lhLH3zU4Z9+rsEl0g5E/NI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=k+soCoOFmb6b569Mipc7Sjq+zGE4/E2nsJrF1ZzbkXm2hGPxxPV+clwFxTjWSe6X+ZIdDWaoiC/xrEXehIKae+NQHIQGl9sKb7TXCJtWwa4azVn0gEkUupkqA20594Wadrwx0E4kQrbnMwgEsrQODRSJRtW5Z+1ESRwTG+UDxZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i7hAiJQB; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i7hAiJQB"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ebdfe261f9so16263101fa.1
        for <ntb@lists.linux.dev>; Mon, 10 Jun 2024 02:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718011954; x=1718616754; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J9eIh8+vSpsfiOQcMG0kVL21E4MR+EadTAvkQJKGVpE=;
        b=i7hAiJQBI2Sx0OJMULlYEdhl1qPGPqT4UhuiEvntjLx9Sgnyywh5v35rMhCn+Vpraw
         vsYbS4z7q4qXPVVGSBZ1E7sTByB5BbVjWDyWZjY+fdyxk7o9+6nwZgn3YLnpw2yaL7XI
         SGtTXTTONcp4v+uDD7F2jjJZ2qzAEf0zVoBZitcDWbuRpOiAriWTmEM2kNQkW+gGlEaY
         q6Ehw/DiK2Rm0/Hkl0SYnxmoCzG7AmbVzGW29L2oqv2iVkGH0eeNDhjZa2lHZA5I232J
         f1pWpntwF03fO+OgTbrFJ+CksffVSCa7ql0ilSIj/aI+cnTbgUOT1lo1RS/mr857GjTS
         Yb7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718011954; x=1718616754;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J9eIh8+vSpsfiOQcMG0kVL21E4MR+EadTAvkQJKGVpE=;
        b=I1mhUTANKddGlkDdX/0VSH/Zeo/fsQcCoudI/AMrY1nvbG/Sr33mHS3XdJiGMmG0Cp
         pY4lKMCPwcSDe8a/MiydWcs2NoOXCHplFKdV5bf/dxAHKdrvFbJn56u9RyD/kc2KafL9
         f9D5o6uPF72B7+mMlqp6rloiXjjfHdOUGk+/W9XnVRjWPCTULp9pUecyTMOS7mlAGalI
         ySgiaQGlhi1HNoHGDU3c3IzXfNlg+Lf65qT8O3fSgbFxnEEwc2loVL1gFVPEXNw7FVp6
         gjVHFrHHBG/xoL/FVGpR2n1XVUPmmKaO5Y5m/wvLQUYi2qfZL7XD0/T2zUUeDSakI2ew
         jWBA==
X-Forwarded-Encrypted: i=1; AJvYcCVT/PuJ6SXJrI8A1EMsmhEIPptNurTsTxth/adxtiQxvyc3xlHOP39VsMjvx85aWd6B0nO7drDMkIHG1H4fdBq/r5hl
X-Gm-Message-State: AOJu0Yx4tMOQ4Hh6Vm9UGYENosM64ZL5BFUdgFpcDsrZUdu8jP1XpQrw
	y5FOWaNliPiBPzZJeUooVlOVc1Q0vuPqbnyHl/37wM869Qu0iQd+3sxjpd8GKvQ=
X-Google-Smtp-Source: AGHT+IH6M+gGoxYti68PgMyxeGCDfRspot0JaT6qtD4HXBifKh7SeFc6+v8ZzBU+UfXGDa7EEFw0CA==
X-Received: by 2002:a2e:82c6:0:b0:2ea:9194:ab2d with SMTP id 38308e7fff4ca-2eadce38257mr70167731fa.18.1718011953919;
        Mon, 10 Jun 2024 02:32:33 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c364bcdsm134759405e9.19.2024.06.10.02.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 02:32:33 -0700 (PDT)
Date: Mon, 10 Jun 2024 12:32:29 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, ntb@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH 0/2] PCI: endpoint: fix a couple error handling bugs
Message-ID: <6eacdf8e-bb07-4e01-8726-c53a9a508945@moroto.mountain>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Two small error error handling and cleanup patches.  The first one fixes
an incorrect error message printed on success.  The other one fixes some
cleanup.  Which is probably not required because PCI code is generally
required for a functioning system...

From static analysis.  Untested.
