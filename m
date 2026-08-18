Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0079342CB0
	for <ntb@lists.linux.dev>; Tue, 18 Aug 2026 06:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787035794; cv=none; b=Sv5M83ZvTatP89vd1hESB+kECwqlqIwHinkcQrP6jmAsFgmARCVYlZPVMBnLXORNaw50SoAFxfZTLC7IlqN07e8LiaHG1yh5xuze8ICPu/IDV4/VKQsv75OQg1mIRIvzpZYHubz0oe7Ei2L/YiUF+pXOUMx015JYBoG98DF0yng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787035794; c=relaxed/simple;
	bh=NOxeg0VA/Ehima/wvWUL93VNTy0HK370BfNlcWxK0ME=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jrhcWzbikbksjhurHdcg3rdde5SExMgS1t7F07LKIZ2HxArcnU9IsgKbylkQxk6ic9AY0+0OEnsdQXmMCEeJKwQDbSUizR4OaeaTST9VqP43vDTXLhf3NavjYbUF4JToY4ejYf2puTdVDWlsyddzxzmsHMoIdDKEH4sazmTi+W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZhBitr0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZhBitr0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A92D1F00A3D;
	Tue, 18 Aug 2026 06:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787035792;
	bh=NOxeg0VA/Ehima/wvWUL93VNTy0HK370BfNlcWxK0ME=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AZhBitr0uKa4eKVbmZLS99WQ+gQ4lCV8XKL5s+rFA27kOyjhhaQOH2b6BQ9owG7xS
	 S2x+RIYCsJEzSN0n1XNNZQGOREqzqGEX96hDGHLkj2chg+JUN1bkmNgeAdHEgE2PtM
	 CqsAr0r2A7fXwbhZ6plXaoi+Tkra6gfPTJbkrLs1/HDolpXfMOUB5nREBcTiJn8B+B
	 zbGq12MjXMY3clXVWL7+WJK36UOyh8Fx/CoYoWwubbD5yCK8zofAJlQGpxq9wGmKaY
	 mVbslc7MjviBnpRHeLhZsxAzq1qyMf8NHkXl0JGJl7R6xVD21xFyJaSBxnwDtAvRPR
	 D8IRqFkjT/UBA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 1/4] NTB: ntb_transport: Order RX descriptor
 reads after completion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev
In-Reply-To: <20260817064916.13278-2-den@valinux.co.jp>
References: <20260817064916.13278-1-den@valinux.co.jp>
 <20260817064916.13278-2-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 06:49:51 +0000
Message-Id: <20260818064952.1A92D1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Double-fetch vulnerability (TOCTOU) on `hdr->len` allowing ker=
nel heap buffer overflow.
- [Critical] Use-After-Free of memory windows during link teardown due to m=
issing tasklet and DMA synchronization.
- [Critical] Invalid use of `virt_to_phys()` on DMA coherent memory corrupt=
s DMA mappings.
- [High] Missing endianness conversion on memory-mapped payload headers bre=
aks big-endian systems.
- [High] RX DMA abort fallback copies data from the wrong ring index, causi=
ng data corruption.
- [High] Concurrent modification of `qp->rx_index` causes ring state corrup=
tion.
- [High] Missing bounds validation of `hdr->len` against frame size causes =
out-of-bounds read and information leak.
--

--- Patch [1]: [PATCH net-next v2 1/4] NTB: ntb_transport: Order RX descrip=
tor reads after completion ---
(Note: The format of this report has been altered due to recitation
restrictions. The original patch diff is not quoted, and findings are
provided as a free-form summary.)

Commit: 27d90886c93f5cd8fe8f9c93d5acf5cd83c90d55
Author: Koichiro Den <den@valinux.co.jp>
Subject: NTB: ntb_transport: Order RX descriptor reads after completion

This commit addresses an ordering issue on weakly ordered CPUs where the
descriptor and payload could be consumed before DESC_DONE_FLAG is fully
observed. It ensures the completion word is read once, followed by a
dma_rmb(), and uses the saved word for subsequent checks.

Link: https://lore.kernel.org/r/20260815032932.151F11F000E9@smtp.kernel.org/

[Severity: Critical]
This is a pre-existing issue, but in ntb_process_rxc(), could the double
fetch of hdr->len lead to a TOCTOU vulnerability?

The code reads hdr->len to validate it against entry->len. After this check,
operations like qp->rx_bytes +=3D hdr->len and entry->len =3D hdr->len read=
 the
length directly from DMA-coherent memory again.

Could a malicious peer concurrently swap a valid small length with a huge
value after the bounds check passes, causing the fallback CPU memcpy to
copy out-of-bounds into the local kernel buffer?

[Severity: High]
This isn't a bug introduced by this patch, but does the lack of endianness
conversion on memory-mapped payload headers break big-endian systems?

The TX side writes header fields using iowrite32(), which implicitly conver=
ts
to little-endian. However, the RX side in ntb_process_rxc() reads the
memory directly via READ_ONCE(hdr->flags) and evaluates flags against
DESC_DONE_FLAG without using le32_to_cpu().

Would this cause the receiver on big-endian hosts to misinterpret the bytes
and drop all received packets?

[Severity: Critical]
This is a pre-existing issue, but does ntb_transport_link_cleanup() safely
free memory windows if tasklets or DMA engines are still active?

When the link drops, it calls ntb_free_mw(), invoking dma_free_attrs().
However, it does not call tasklet_kill(&qp->rxc_db_work) or
dmaengine_terminate_all().

If the RX tasklet is actively processing doorbells or the DMA engine is
transferring data, will this result in a use-after-free or IOMMU DMA fault?

[Severity: High]
This isn't a bug introduced by this patch, but does ntb_rx_copy_callback()
use the correct index when falling back to a CPU copy?

If a DMA transaction aborts, it calculates the offset using the shared
qp->rx_index via qp->rx_buff + qp->rx_max_frame * qp->rx_index. Because the
callback is asynchronous, the tasklet may have already advanced
qp->rx_index.

Should it use the saved entry->rx_index instead to avoid copying data from
the wrong ring slot and corrupting the stream?

[Severity: High]
This is a pre-existing issue, but can ntb_qp_link_down_reset() safely reset
indices while traffic is flowing?

It forcefully zeroes qp->rx_index and qp->tx_index from a workqueue without
synchronizing with the rxc_db_work tasklet.

If the tasklet is running concurrently in ntb_process_rxc(), could the
unsynchronized writes corrupt the ring buffer state?

[Severity: High]
This isn't a bug introduced by this patch, but does ntb_process_rxc()
adequately validate hdr->len against the physical frame size?

The code verifies hdr->len against entry->len (the client buffer size) but
never against qp->rx_max_frame (the hardware memory window slice size).

If a client configures a large buffer, could a malicious remote peer set
hdr->len to a value exceeding the frame size, allowing an out-of-bounds
read that leaks adjacent kernel memory?

[Severity: Critical]
This is a pre-existing issue, but is it valid to use virt_to_phys() on
DMA coherent memory in ntb_async_rx_submit()?

The offset pointer is derived from qp->rx_buff, which is allocated via
dma_alloc_attrs(). On architectures where this returns a non-linear virtual
address in the vmalloc area, virt_to_phys() will return an incorrect
physical address.

Will this cause the DMA engine to write received data to arbitrary physical
memory locations, leading to silent memory corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817064916.1327=
8-1-den@valinux.co.jp?part=3D1
