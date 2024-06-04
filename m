Received: from forward206b.mail.yandex.net (forward206b.mail.yandex.net [178.154.239.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20667145FF6
	for <ntb@lists.linux.dev>; Tue,  4 Jun 2024 12:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717503897; cv=none; b=UQDpeoiS4BaEHFannR20CVpKVqTa0LoBhyCPCiuj/X+yZ/XeQarQi/E1KNh2ifOaAkcjtpQ+jJ/1L2A/QVsYpCOsKE/fie9tBw47/nrcQt/7LaOzNXlQYH+De+wwL8n+i0meZWVKfUqvaWm2iDAmu4/1tIjXK/ererQiyDhXx2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717503897; c=relaxed/simple;
	bh=1EYgD/DBV1IgO1JkLwEX2ZsAZvmCaAw2rZ+KPc0Aqfs=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=IakPAKcX5yGxkrlbF2y4x5mBrn01WHS6iVg99aXAJ/jMkZ8VQYy1esKPnvMMpo56/HUB1azF8FZRkCXUMxUvwoy59ePmuwh55N+TD0UauVEJUlnm5MzPO2Yc5Gi6Zrw6+9O8Q5BfeuPjvIed1T7X1avq9PzOM/OKbzP+q5cBv1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me; spf=pass smtp.mailfrom=maquefel.me; dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b=rXSNR6ck; arc=none smtp.client-ip=178.154.239.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maquefel.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b="rXSNR6ck"
Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d101])
	by forward206b.mail.yandex.net (Yandex) with ESMTPS id C64E96552A
	for <ntb@lists.linux.dev>; Tue,  4 Jun 2024 15:17:01 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-46.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-46.sas.yp-c.yandex.net [IPv6:2a02:6b8:c10:7a2:0:640:7461:0])
	by forward101b.mail.yandex.net (Yandex) with ESMTPS id 0127A60B47;
	Tue,  4 Jun 2024 15:16:54 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-46.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id pGWKXkH9TmI0-DWpcoFGU;
	Tue, 04 Jun 2024 15:16:53 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
	t=1717503413; bh=uqekmTIEOyuqP8543lAbYzUCCebo/wxhNleSBMaHZLM=;
	h=Date:Cc:To:From:Subject:Message-ID;
	b=rXSNR6ckexWbPxKnRAE7t7Tg7jAcXoZXftoqDGymxFkitgEeIOStGC5XgLiVrXgaJ
	 Gfzp+HvGfphWSTvnnrXQ2X1BNySTRUEUoFHDKWIrfaAqL4iS7t2pUoEy5d5rR0iJpc
	 Ni5osf/FdmiX+AuH9e/oq26MzqJMahX0n+3nxCTI=
Authentication-Results: mail-nwsmtp-smtp-production-main-46.sas.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <686c55cc658564e8f37147e0d6d5ab62bb8372af.camel@maquefel.me>
Subject: Question on ntb: Adding Skylake Xeon NTB support
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>, 
	ntb@lists.linux.dev, linux@yadro.com
Date: Tue, 04 Jun 2024 15:16:52 +0300
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hello Dave!

I have a question about NTB_HWERR_MSIX_VECTOR32_BAD, i hope you can
clarify a bit:

We are moving "link status down by one" indeed:

```
intel_ntb_intvec_write addr=3D0xef idx=3D31 value=3D0x1f size=3D1
intel_ntb_intvec_write addr=3D0xf0 idx=3D32 value=3D0x20 size=3D1
...
intel_ntb_intvec_write addr=3D0xf0 idx=3D32 value=3D0x1f size=3D1
```

So basically Link now shares interrupt with DB 31, however doesn't this
make 31 DB unusable, as we are clearing it with 0x180000000 in
gen3_poll_link() ?

May be we should avoid using it by providing correct db_valid_mask ?

Some thing like:

```
if (ndev->hwerr_flags & NTB_HWERR_MSIX_VECTOR32_BAD)
    ndev->db_valid_mask &=3D ~ndev->db_link_mask;
```

in gen3_init_ntb() ?
