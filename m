Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC911CEE82
	for <ntb@lists.linux.dev>; Fri, 15 Nov 2024 15:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731684917; cv=none; b=UUxyZJ1ujcV+yGobWaJ5BK03bttoIgSOLfVuXNzy3SiYnjay/UjCMW/jlt49ZS7g8Lt8TFENMBtDi51FEw9f8g4oguOyjwAL99i4MLEdk9WM0N4fyxf8SA/9evlx/P5EvPn7IwLXH8nM3rzepYlRHAS43CP35Hj5a6M4N4oIQPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731684917; c=relaxed/simple;
	bh=yU1G2hIrLcZlXd3LaebeyKYONXTnd34hSfRSQEHJ1yU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DK5v/Bq/9pzQATFxrmt5ipJdm0Q9GR9cFpXwqgCtxkBVaWeJ0nOb06q8udC5Inp/ixHQlJU+6WUQKjOrUqp10quJMa0Uq88oXYAp7k3WJGztnMlJ9N5BHPM6VNNtbb0Mvdl2BPZhEVJiq1LU1HMLUnx11OiZ0LNZoPTjLjykutQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IBWtp97m; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HbOShzA2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IBWtp97m";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HbOShzA2"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731684913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yU1G2hIrLcZlXd3LaebeyKYONXTnd34hSfRSQEHJ1yU=;
	b=IBWtp97mInpsavyNlaW7Wa7P9t1WIhdFZFGtmkYainZ6bfXDspevPRYpFW4pLoFiUdTJD4
	U5VvdoT1K3yOQRre+DBq0sQWHdk4rIynAWjUT2zmNpIj2n43BIKL0t0/Vf6l/rtvSO0Fi+
	gDrBIw99IdYG1uqRK3qErn9uAAGZz664d/tZZ8KcSi+2Phfl0Sz1omrERQ/lrAOES/7JlS
	yRewNvz7aEuvd8A4q0Bq1FSIlOgXPmu0k2lEr6yoDeEt0bajmGyelDX+RQ8ypFICvCudhA
	M17FF+uzSWHmHhP49+FBOqW8qbOWE/x/12QiHel/8b+KvHi6yusfYdMgsiBxnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731684913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yU1G2hIrLcZlXd3LaebeyKYONXTnd34hSfRSQEHJ1yU=;
	b=HbOShzA2dgF/rf/JxxHpay75yREzH698PUJ7XWVcQ8L3AwP4KqCVbfvEjEUE+BssSSuAzH
	UAxm3b5R+xtq6JDw==
To: Philipp Stanner <pstanner@redhat.com>, Damien Le Moal
 <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, Basavaraj Natikar
 <basavaraj.natikar@amd.com>, Jiri Kosina <jikos@kernel.org>, Benjamin
 Tissoires <bentiss@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Alex Dubov <oakad@yahoo.com>,
 Sudarsana Kalluru <skalluru@marvell.com>, Manish Chopra
 <manishc@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rasesh Mody
 <rmody@marvell.com>, GR-Linux-NIC-Dev@marvell.com, Igor Mitsyanko
 <imitsyanko@quantenna.com>, Sergey Matyukevich <geomatsi@gmail.com>, Kalle
 Valo <kvalo@kernel.org>, Sanjay R Mehta <sanju.mehta@amd.com>, Shyam
 Sundar S K <Shyam-sundar.S-k@amd.com>, Jon Mason <jdmason@kudzu.us>, Dave
 Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Bjorn
 Helgaas <bhelgaas@google.com>, Alex Williamson
 <alex.williamson@redhat.com>, Juergen Gross <jgross@suse.com>, Stefano
 Stabellini <sstabellini@kernel.org>, Oleksandr Tyshchenko
 <oleksandr_tyshchenko@epam.com>, Philipp Stanner <pstanner@redhat.com>,
 Mario Limonciello <mario.limonciello@amd.com>, Chen Ni
 <nichen@iscas.ac.cn>, Ricky Wu <ricky_wu@realtek.com>, Al Viro
 <viro@zeniv.linux.org.uk>, Breno Leitao <leitao@debian.org>, Kevin Tian
 <kevin.tian@intel.com>, Mostafa Saleh <smostafa@google.com>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Jason Gunthorpe
 <jgg@ziepe.ca>, Yi Liu <yi.l.liu@intel.com>, Kunwu Chan
 <chentao@kylinos.cn>, Ankit Agrawal <ankita@nvidia.com>, Christian Brauner
 <brauner@kernel.org>, Reinette Chatre <reinette.chatre@intel.com>, Eric
 Auger <eric.auger@redhat.com>, Ye Bin <yebin10@huawei.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, ntb@lists.linux.dev,
 linux-pci@vger.kernel.org, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org
Subject: Re: [PATCH v2 07/11] PCI: MSI: Use never-managed version of pci_intx()
In-Reply-To: <20241113124158.22863-9-pstanner@redhat.com>
References: <20241113124158.22863-2-pstanner@redhat.com>
 <20241113124158.22863-9-pstanner@redhat.com>
Date: Fri, 15 Nov 2024 16:35:22 +0100
Message-ID: <87y11kzf0l.ffs@tglx>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Nov 13 2024 at 13:41, Philipp Stanner wrote:
> pci_intx() is a hybrid function which can sometimes be managed through
> devres. To remove this hybrid nature from pci_intx(), it is necessary to
> port users to either an always-managed or a never-managed version.
>
> MSI sets up its own separate devres callback implicitly in
> pcim_setup_msi_release(). This callback ultimately uses pci_intx(),
> which is problematic since the callback of course runs on driver-detach.
>
> That problem has last been described here:
> https://lore.kernel.org/all/ee44ea7ac760e73edad3f20b30b4d2fff66c1a85.camel@redhat.com/
>
> Replace the call to pci_intx() with one to the never-managed version
> pci_intx_unmanaged().
>
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
