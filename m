Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3417407D
	for <ntb@lists.linux.dev>; Mon, 10 Jun 2024 09:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718012026; cv=none; b=i0ifmXQ9eLNRoRyHELXetnQltaxgd80Iv2HzF9g38gGsIraLFadlICX8p4dYBsAt/dis14iHs8lZYau64AjKGuzMRzJ2Ir9DyC0XFyq0WmaWM6mFHShvQuR4iGcP2pWAyK20kqM9Nzud31XAArr+m8YgVfc+JDE0mjXVs9fKqNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718012026; c=relaxed/simple;
	bh=tLOcVSiD6Eqw6Yy+f53eqMdy4+lsxuB3aeWvrhbUWPM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=SoyDd4nl46uX5BggpwdmL7IOR7jJNpnYLjtCOXGxVr+tipTiKslZsxcdJ6Fu9bEx/Jr9xQkfGi03BiTXNzLzN/by6laG8OdSAD3xVIKFOEdQvRk6Avn8KUFijBN5VP3qZQJm0ySICrPNlBgnIu1baaW5pX67UXMDJHvfSJL0KR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tR0twZjB; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tR0twZjB"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52bc1261e8fso2736836e87.0
        for <ntb@lists.linux.dev>; Mon, 10 Jun 2024 02:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718012023; x=1718616823; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pzVEamgsK8pIhsebOuX84FJsT0b+I1ivveKg0N5OLWc=;
        b=tR0twZjBKF9o67BMCc3u8mXo5Twnrw4AIzQxTaQ75H7C4Ao0bObZVhcQRN8qStPq/O
         o1eeBR9XliewMhgX65pfkZXkT6qLxalXatm2mWRpIrGzqxNJ6pYstswHmrYlD1gnF/2O
         OvXM2loOVGJax+ZtLKARk16TBOEQatR3v7PXSY7F4HlzSM68p1uaF2IYgm2Fiuwf51sP
         IfshnFnTwhWu36j9mb39OWU3zviCj4h7Z/+sxbdE7KKIWfrW6XAOodbz3jorY94+FUdo
         KWEZDh+yb7axiPIgEX2hZCq3j/k/bIjpkQZlzj2OXlcTL/2pPUu2bidsTHw/dlM7c2Jr
         bPMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718012023; x=1718616823;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pzVEamgsK8pIhsebOuX84FJsT0b+I1ivveKg0N5OLWc=;
        b=T0pl+qggLz1C8HxDwR2XIUBKtiGEP6TUiCrf4wov/VjfNcl7BgdPqf3j1ZLiyLAy9P
         WmOuFogqLDWHz38aYZ0UyDF5U1NqFRXG/H1IGvVHyXBp2AEl3zbbRjGarvOByy4LH/QZ
         BEi8OAax0Zmz4aG0tHf8Ju4YcisN3T38WsQhR3n0uFfZCaYoeU/VY3HvCxagM5/vBvQS
         s6tgsXEnxZR96r8vMeBcALOveTLZrBXKiZnDOHMVt+ClQSLvotBHJaukHvlqcBpPeMo9
         G6dgYY7slTfrqrAEX0M1Tl/dJF9KXHxnYTTy5+QYyFM6uisVDGMX0JWbZa92GLcE+KS5
         6gCA==
X-Forwarded-Encrypted: i=1; AJvYcCU9bysamElLZsU749BcjPAp7OioiVxsGsSFIiS9dRR8om5/Rz0n8apgSvwQdj/SYbXR2rrcSSfwQEv118VkZ9nK5NG3
X-Gm-Message-State: AOJu0Yw19RsIwg0g+C0XjWpRkosCxUUHfS/LhEs/glUe/GEndM+EuZud
	649eX5r2BNUqXhIwj2z8/x5Yu1v5XNaoPlIjpJhO34ixjVzE6wo5RABTffQJT2U=
X-Google-Smtp-Source: AGHT+IEjZLgV6Wy1oAxIIdW1ddfOocWe7sK0ReqlNbZA+bPWxFoLzpJukeMXV37eZ5OiEJagfcMF0A==
X-Received: by 2002:a05:6512:61b:b0:52c:7fc3:601 with SMTP id 2adb3069b0e04-52c7fc306f4mr2851793e87.61.1718012023012;
        Mon, 10 Jun 2024 02:33:43 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f0d512556sm7087985f8f.29.2024.06.10.02.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 02:33:42 -0700 (PDT)
Date: Mon, 10 Jun 2024 12:33:39 +0300
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
Subject: [PATCH 1/2] PCI: endpoint: Clean up error handling in vpci_scan_bus()
Message-ID: <68e0f6a4-fd57-45d0-945b-0876f2c8cb86@moroto.mountain>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6eacdf8e-bb07-4e01-8726-c53a9a508945@moroto.mountain>
X-Mailer: git-send-email haha only kidding

Smatch complains about inconsistent NULL checking in vpci_scan_bus():

    drivers/pci/endpoint/functions/pci-epf-vntb.c:1024 vpci_scan_bus()
    error: we previously assumed 'vpci_bus' could be null (see line 1021)

Instead of printing an error message and then crashing we should return
an error code and clean up.  Also the NULL check is reversed so it
prints an error for success instead of failure.

Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 8e779eecd62d..7f05a44e9a9f 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -1018,8 +1018,10 @@ static int vpci_scan_bus(void *sysdata)
 	struct epf_ntb *ndev = sysdata;
 
 	vpci_bus = pci_scan_bus(ndev->vbus_number, &vpci_ops, sysdata);
-	if (vpci_bus)
-		pr_err("create pci bus\n");
+	if (!vpci_bus) {
+		pr_err("create pci bus failed\n");
+		return -EINVAL;
+	}
 
 	pci_bus_add_devices(vpci_bus);
 
@@ -1338,10 +1340,14 @@ static int epf_ntb_bind(struct pci_epf *epf)
 		goto err_bar_alloc;
 	}
 
-	vpci_scan_bus(ntb);
+	ret = vpci_scan_bus(ntb);
+	if (ret)
+		goto err_unregister;
 
 	return 0;
 
+err_unregister:
+	pci_unregister_driver(&vntb_pci_driver);
 err_bar_alloc:
 	epf_ntb_config_spad_bar_free(ntb);
 
-- 
2.43.0

