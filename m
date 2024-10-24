Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158E3158A31
	for <ntb@lists.linux.dev>; Thu, 24 Oct 2024 15:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729784537; cv=none; b=Rl0TNCgwDv4pQkk4etvRs2/Cw7iUD2S/4xP5SXL49IRKjl6HPehEtGU0SuN0N0ududn+IpctiUPq8omtYY0a6dLPe1Estqr2TMob9lQZhw2tCZJ4i57+kGgaHzYl40czKmr7OClLqknUz0vdG/LpYmNQ+K7pJpKeUU4qq2Y++3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729784537; c=relaxed/simple;
	bh=fyCVM0H3wBChDlsqqMqAVhOen98CNN27wwnpuqoJWHs=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UICB50y05Bf4dBnIy2/hRLwhMUcwLqY+FrVpQOalwYIfsSHAsc6lIoFxXoEolgl53oTychpaAqM2C2vWn1OmhTnNq/zmLv67rmTV4jxeQTLYPYcLR3LRwYaKKVv98FaRh88UzRgWJIuUBZU/Tm5ggA+R66I6Q6XtXpXtB6xVLo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nf7+XH/L; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bUCNy+kH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nf7+XH/L; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bUCNy+kH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nf7+XH/L";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bUCNy+kH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nf7+XH/L";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bUCNy+kH"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 27CC922125;
	Thu, 24 Oct 2024 15:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729784533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e/3cTOJeo8U10J73FzqEOoczI8O2ncrtc0XB23zkv5s=;
	b=nf7+XH/LuqrxkP91/yVelJSCFw67hxyf6AXFWk3zyABwq4t50EjV4OpunUzQwKh4O0X2HJ
	4nMIH+IkWiV+OyB9+2lpXXEkxEb6F9xe7EmRT51s93pHP7VGseNAqLpWkAnTMF4e/9a33H
	jIwPZWttZWt/MbrLD+5eKYCd75VNgto=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729784533;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e/3cTOJeo8U10J73FzqEOoczI8O2ncrtc0XB23zkv5s=;
	b=bUCNy+kHeragGzzLpfz4PtWaPc3dFKTrYqlZNmv+RbyR7CQspcjxEUACIPOU4RaAWi7ash
	i5YJ2tGAyzT1zcBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="nf7+XH/L";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=bUCNy+kH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729784533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e/3cTOJeo8U10J73FzqEOoczI8O2ncrtc0XB23zkv5s=;
	b=nf7+XH/LuqrxkP91/yVelJSCFw67hxyf6AXFWk3zyABwq4t50EjV4OpunUzQwKh4O0X2HJ
	4nMIH+IkWiV+OyB9+2lpXXEkxEb6F9xe7EmRT51s93pHP7VGseNAqLpWkAnTMF4e/9a33H
	jIwPZWttZWt/MbrLD+5eKYCd75VNgto=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729784533;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e/3cTOJeo8U10J73FzqEOoczI8O2ncrtc0XB23zkv5s=;
	b=bUCNy+kHeragGzzLpfz4PtWaPc3dFKTrYqlZNmv+RbyR7CQspcjxEUACIPOU4RaAWi7ash
	i5YJ2tGAyzT1zcBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A023D1368E;
	Thu, 24 Oct 2024 15:42:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id g9J2JdNqGmebSAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 24 Oct 2024 15:42:11 +0000
Date: Thu, 24 Oct 2024 17:43:12 +0200
Message-ID: <875xphzeun.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Takashi Iwai <tiwai@suse.de>,	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Basavaraj Natikar <basavaraj.natikar@amd.com>,	Jiri Kosina
 <jikos@kernel.org>,	Benjamin Tissoires <bentiss@kernel.org>,	Arnd Bergmann
 <arnd@arndb.de>,	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,	Alex
 Dubov <oakad@yahoo.com>,	Sudarsana Kalluru <skalluru@marvell.com>,	Manish
 Chopra <manishc@marvell.com>,	"David S. Miller" <davem@davemloft.net>,	Eric
 Dumazet <edumazet@google.com>,	Jakub Kicinski <kuba@kernel.org>,	Paolo
 Abeni <pabeni@redhat.com>,	Rasesh Mody <rmody@marvell.com>,
	GR-Linux-NIC-Dev@marvell.com,	Igor Mitsyanko <imitsyanko@quantenna.com>,
	Sergey Matyukevich <geomatsi@gmail.com>,	Kalle Valo <kvalo@kernel.org>,
	Sanjay R Mehta <sanju.mehta@amd.com>,	Shyam Sundar S K
 <Shyam-sundar.S-k@amd.com>,	Jon Mason <jdmason@kudzu.us>,	Dave Jiang
 <dave.jiang@intel.com>,	Allen Hubbe <allenbh@gmail.com>,	Bjorn Helgaas
 <bhelgaas@google.com>,	Alex Williamson <alex.williamson@redhat.com>,
	Juergen Gross <jgross@suse.com>,	Stefano Stabellini
 <sstabellini@kernel.org>,	Oleksandr Tyshchenko
 <oleksandr_tyshchenko@epam.com>,	Jaroslav Kysela <perex@perex.cz>,	Takashi
 Iwai <tiwai@suse.com>,	Chen Ni <nichen@iscas.ac.cn>,	Mario Limonciello
 <mario.limonciello@amd.com>,	Ricky Wu <ricky_wu@realtek.com>,	Al Viro
 <viro@zeniv.linux.org.uk>,	Breno Leitao <leitao@debian.org>,	Kevin Tian
 <kevin.tian@intel.com>,	Thomas Gleixner <tglx@linutronix.de>,	Ilpo
 =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,	Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>,	Mostafa Saleh
 <smostafa@google.com>,	Jason Gunthorpe <jgg@ziepe.ca>,	Yi Liu
 <yi.l.liu@intel.com>,	Christian Brauner <brauner@kernel.org>,	Ankit Agrawal
 <ankita@nvidia.com>,	Eric Auger <eric.auger@redhat.com>,	Reinette Chatre
 <reinette.chatre@intel.com>,	Ye Bin <yebin10@huawei.com>,	Marek
 =?ISO-8859-1?Q?Marczykowski-G=F3recki?= <marmarek@invisiblethingslab.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,	Peter Ujfalusi
 <peter.ujfalusi@linux.intel.com>,	Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,	Kai Vehmanen
 <kai.vehmanen@linux.intel.com>,	Rui Salvaterra <rsalvaterra@gmail.com>,
	linux-ide@vger.kernel.org,	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,	ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,	kvm@vger.kernel.org,
	xen-devel@lists.xenproject.org,	linux-sound@vger.kernel.org
Subject: Re: [PATCH 02/13] ALSA: hda_intel: Use always-managed version of pcim_intx()
In-Reply-To: <aec23bb79b9ff7dd7f13eb67460e0605eac22912.camel@redhat.com>
References: <20241015185124.64726-1-pstanner@redhat.com>
	<20241015185124.64726-3-pstanner@redhat.com>
	<87v7xk2ps5.wl-tiwai@suse.de>
	<6f3db65fe9a5dcd1a7a8d9bd5352ecb248ef57b1.camel@redhat.com>
	<87ttd2276j.wl-tiwai@suse.de>
	<aec23bb79b9ff7dd7f13eb67460e0605eac22912.camel@redhat.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 27CC922125
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,kernel.org,omp.ru,amd.com,arndb.de,linuxfoundation.org,yahoo.com,marvell.com,davemloft.net,google.com,redhat.com,quantenna.com,gmail.com,kudzu.us,intel.com,suse.com,epam.com,perex.cz,iscas.ac.cn,realtek.com,zeniv.linux.org.uk,debian.org,linutronix.de,linux.intel.com,ziepe.ca,nvidia.com,huawei.com,invisiblethingslab.com,linux.dev,vger.kernel.org,lists.linux.dev,lists.xenproject.org];
	R_RATELIMIT(0.00)[to_ip_from(RLrrkwc4rnabsqsjbq9gcqj97h)];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[67];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51
X-Spam-Flag: NO

On Thu, 24 Oct 2024 10:02:59 +0200,
Philipp Stanner wrote:
> 
> On Wed, 2024-10-23 at 17:03 +0200, Takashi Iwai wrote:
> > On Wed, 23 Oct 2024 15:50:09 +0200,
> > Philipp Stanner wrote:
> > > 
> > > On Tue, 2024-10-22 at 16:08 +0200, Takashi Iwai wrote:
> > > > On Tue, 15 Oct 2024 20:51:12 +0200,
> > > > Philipp Stanner wrote:
> > > > > 
> > > > > pci_intx() is a hybrid function which can sometimes be managed
> > > > > through
> > > > > devres. To remove this hybrid nature from pci_intx(), it is
> > > > > necessary to
> > > > > port users to either an always-managed or a never-managed
> > > > > version.
> > > > > 
> > > > > hda_intel enables its PCI-Device with pcim_enable_device().
> > > > > Thus,
> > > > > it needs
> > > > > the always-managed version.
> > > > > 
> > > > > Replace pci_intx() with pcim_intx().
> > > > > 
> > > > > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> > > > > ---
> > > > >  sound/pci/hda/hda_intel.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/sound/pci/hda/hda_intel.c
> > > > > b/sound/pci/hda/hda_intel.c
> > > > > index b4540c5cd2a6..b44ca7b6e54f 100644
> > > > > --- a/sound/pci/hda/hda_intel.c
> > > > > +++ b/sound/pci/hda/hda_intel.c
> > > > > @@ -786,7 +786,7 @@ static int azx_acquire_irq(struct azx
> > > > > *chip,
> > > > > int do_disconnect)
> > > > >  	}
> > > > >  	bus->irq = chip->pci->irq;
> > > > >  	chip->card->sync_irq = bus->irq;
> > > > > -	pci_intx(chip->pci, !chip->msi);
> > > > > +	pcim_intx(chip->pci, !chip->msi);
> > > > >  	return 0;
> > > > >  }
> > > > >  
> > > > 
> > > > Hm, it's OK-ish to do this as it's practically same as what
> > > > pci_intx()
> > > > currently does.  But, the current code can be a bit inconsistent
> > > > about
> > > > the original intx value.  pcim_intx() always stores !enable to
> > > > res->orig_intx unconditionally, and it means that the orig_intx
> > > > value
> > > > gets overridden at each time pcim_intx() gets called.
> > > 
> > > Yes.
> > > 
> > > > 
> > > > Meanwhile, HD-audio driver does release and re-acquire the
> > > > interrupt
> > > > after disabling MSI when something goes wrong, and pci_intx()
> > > > call
> > > > above is a part of that procedure.  So, it can rewrite the
> > > > res->orig_intx to another value by retry without MSI.  And after
> > > > the
> > > > driver removal, it'll lead to another state.
> > > 
> > > I'm not sure that I understand this paragraph completely. Still,
> > > could
> > > a solution for the driver on the long-term just be to use
> > > pci_intx()?
> > 
> > pci_intx() misses the restore of the original value, so it's no
> > long-term solution, either.
> 
> Sure that is missing – I was basically asking whether the driver could
> live without that feature.
> 
> Consider that point obsolete, see below
> 
> > 
> > What I meant is that pcim_intx() blindly assumes the negative of the
> > passed argument as the original state, which isn't always true.  e.g.
> > when the driver calls it twice with different values, a wrong value
> > may be remembered.
> 
> Ah, I see – thoguh the issue is when it's called several times with the
> *same* value, isn't it?
> 
> E.g.
> 
> pcim_intx(pdev, 1); // 0 is remembered as the old value
> pcim_intx(pdev, 1); // 0 is falsely remembered as the old value
> 
> Also, it would seem that calling the function for the first time like
> that:
> 
> pcim_intx(pdev, 0); // old value: 1
> 
> is at least incorrect, because INTx should be 0 per default, shouldn't
> it? Could then even be a 1st class bug, because INTx would end up being
> enabled despite having been disabled all the time.

Yeah, and the unexpected restore can happen even with a single call of
pcim_intx(), if the driver calls it unnecessarily.

> > That said, I thought of something like below.
> 
> At first glance that looks like a good idea to me, thanks for working
> this out!
> 
> IMO you can submit that as a patch so we can discuss it separately.

Sure, I'm going to submit later.


thanks,

Takashi
