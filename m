Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793542368;
	b=gFnQ8Pdjp3bsFEYwNgl21jUgeI29DsXrOQswW5cUPEwQ2/SZHsvW7ziVUNuCz+WOCyXN
	 Jzr5lsYY6Z/96lh05BCvSU+cMglMzK2gYJ0JH/7KAn8XPqjpPD3o+vN1h+hCXWZv0iQJF
	 pnBmsgERL1FpOx6m6QfUbS3pGGu62lQMyEwMCvTV3I8Tm7rEMqAlwln64mA0v24yCiTMf
	 wu4vKddarJEf0andSOpCo/jVyAbk0p+kVHQ/xBKfMBv5rBpP7gFHJasssQ0hz3fzWlMg+
	 hkVo1+3sRIVZzZVe238LOFhRn7sQurIR+bpAnVEnA8yygCUBGXLXFMJqIXwwvflkUKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793542368;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=u4ver/p5TX7t+NpAoKgx0ZoQqyTUzsJLiDgd3fcHgWk=;
	b=M7UyUwMN1KD9u6qGfn9tbQ+reLQfO8cvq4o31rQTFp3hflQuVnjO9Owzq0nthc49zui+
	 x7HnnSAMIWU5ENAydDbqyE4cMtASxXQLArT1UFIqdupT/zGQVUObMUU0QD0c6D7JLM+2A
	 g8mQETv8CeSPl/azoqZHLO9v4hbEq7BHeA/v1psglwIYFDqo0g0+/CFdFNNAO+a0V332P
	 5zF6CorRneixJdNh0QxEC0l21CVb9nqh2boPKsM2epRJWA4E/tOXU26algeqWaK7e3Ca+
	 oX6dUEwOol4JyJ/B3dA9W5ISDjN3P5mAjaKhp8iaMMYVbTrFmLkeoT78t4eb/eeOV/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dRcKcLa6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4332606A324
	for <ntb@lists.linux.dev>; Sun,  1 Nov 2026 14:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dRcKcLa6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30EDB1F000C1;
	Sun,  1 Nov 2026 14:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793542367;
	bh=u4ver/p5TX7t+NpAoKgx0ZoQqyTUzsJLiDgd3fcHgWk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dRcKcLa6BNA1WIEDQd4g2Y8NlRnKvxIeFwgao7d3BLPGtyt9alV3G3asTMRtT2SPI
	 ejjPYB9Cr9Np+o/kiTCLjWzuVz3iklsc7OqxJEkM2z5He6YseIsq7MoevOXvT2r6Ia
	 7R6wXwlzdnNyAdEaOVT67IwjkAHx9D6y7xMHKUtff20n5oYfF3gmqP0CfYTzDlzrqv
	 MW1LLd2jcW2h1yDNB3riKrbKsN8JaepTXWMPYjLYxjMP8yKx5Rzx4R3juoXSB8tE+A
	 vN1mKnPeDcxIYHpQ4CZ+YTJr/S9mtIp0yZJQ54XC4wOhTWE1ZKPM3b2U7978pkPDp+
	 pUoi0mYYXUzLQ==
Message-ID: <sashiko-outbox-192437@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] NTB: epf: propagate MW command errors while
 status is reliable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Avi Weiss" <thnkslprpt@gmail.com>
Cc: ntb@lists.linux.dev
In-Reply-To: <62334fd3b8d69fdfdeed268d71f473df45f34556.1793540847.git.thnkslprpt@gmail.com>
References: <cover.1793540847.git.thnkslprpt@gmail.com>
 <62334fd3b8d69fdfdeed268d71f473df45f34556.1793540847.git.thnkslprpt@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 14:12:46 +0000
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Post: <mailto:ntb@lists.linux.dev>
List-Help: <mailto:ntb+help@lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
List-Owner: <mailto:ntb+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] NTB: epf: ntb_epf_send_command_locked() masks MW timeouts and erro=
rs
- [Medium] ntb: epf: dead error handling for CMD_TEARDOWN_MW in ntb_epf_mw_=
clear_trans()
--

commit ac4b0e780171195c4ee0fe212bcbbbd97ae600ff
Author: Avi Weiss <thnkslprpt@gmail.com>

NTB: epf: propagate MW command errors while status is reliable

This commit propagates command errors from ntb_epf_mw_set_trans() and
ntb_epf_mw_clear_trans() while tracking command timeouts in
ndev->cmd_status_unreliable so that memory window operations continue to
return 0 once a timeout has occurred.

> diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_=
epf.c
> index da7fbe1800656..455bcefc7c13e 100644
> --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> @@ -102,6 +102,7 @@ struct ntb_epf_dev {
>  	struct device *dev;
>  	/* Mutex to protect providing commands to NTB EPF */
>  	struct mutex cmd_lock;
> +	bool cmd_status_unreliable;
> =20
>  	const enum pci_barno *barno_map;
> =20
> @@ -148,6 +149,7 @@ static int ntb_epf_send_command_locked(struct ntb_epf=
_dev *ndev, u32 command,
>  			break;
> =20
>  		if (WARN_ON(timedout)) {
> +			ndev->cmd_status_unreliable =3D true;
>  			ret =3D -ETIMEDOUT;
>  			break;
>  		}
> @@ -156,6 +158,13 @@ static int ntb_epf_send_command_locked(struct ntb_ep=
f_dev *ndev, u32 command,
>  	}
> =20
>  	writew(0, ndev->ctrl_reg + NTB_EPF_CMD_STATUS);
> +	/*
> +	 * After a timeout, a status may refer to an earlier command.
> +	 * MW callers may free buffers on error, so retain old semantics.
> +	 */
> +	if (ndev->cmd_status_unreliable &&
> +	    (command =3D=3D CMD_CONFIGURE_MW || command =3D=3D CMD_TEARDOWN_MW))
> +		ret =3D 0;
> =20
>  	return ret;
>  }

[Severity: High]
When CMD_CONFIGURE_MW itself times out in ntb_epf_send_command_locked() in
drivers/ntb/hw/epf/ntb_hw_epf.c, setting ndev->cmd_status_unreliable =3D tr=
ue
causes the check right after the loop to immediately overwrite ret =3D
-ETIMEDOUT with 0.

In ntb_epf_mw_set_trans(), doesn't returning 0 on a CMD_CONFIGURE_MW timeout
release ndev->cmd_lock while the timed-out command is still pending in
ndev->ctrl_reg, allowing multi-window setup loops such as
ntb_transport_link_work() -> ntb_set_mw() -> ntb_mw_set_trans() and
ntb_msi_setup_mws() -> ntb_mw_set_trans() to immediately advance to the next
memory window and overwrite NTB_EPF_LOWER_ADDR, NTB_EPF_UPPER_ADDR,
NTB_EPF_LOWER_SIZE, NTB_EPF_UPPER_SIZE, NTB_EPF_ARGUMENT, and
NTB_EPF_COMMAND?

Callers such as ntb_set_mw(), perf_setup_inbuf(), tool_setup_mw(), and
ntb_msi_setup_mws() also treat the 0 return value as a valid mapping and
bring up the NTB link with an unconfigured inbound BAR window. In addition,
because ndev->cmd_status_unreliable is never cleared once any command times
out (including CMD_LINK_UP or CMD_LINK_DOWN), won't all subsequent
ntb_epf_mw_set_trans() calls permanently mask explicit COMMAND_STATUS_ERROR
(-EINVAL) rejections from the endpoint as well?

> @@ -485,7 +494,7 @@ static int ntb_epf_mw_set_trans(struct ntb_dev *ntb, =
int pidx, int idx,
>  	struct ntb_epf_dev *ndev =3D ntb_ndev(ntb);
>  	struct device *dev =3D ndev->dev;
>  	resource_size_t mw_size;
> -	int bar;
> +	int bar, ret;
> =20
>  	if (pidx !=3D NTB_DEF_PEER_IDX) {
>  		dev_err(dev, "Unsupported Peer ID %d\n", pidx);
> @@ -509,19 +518,19 @@ static int ntb_epf_mw_set_trans(struct ntb_dev *ntb=
, int pidx, int idx,
>  	writel(upper_32_bits(addr), ndev->ctrl_reg + NTB_EPF_UPPER_ADDR);
>  	writel(lower_32_bits(size), ndev->ctrl_reg + NTB_EPF_LOWER_SIZE);
>  	writel(upper_32_bits(size), ndev->ctrl_reg + NTB_EPF_UPPER_SIZE);
> -	ntb_epf_send_command_locked(ndev, CMD_CONFIGURE_MW, idx);
> +	ret =3D ntb_epf_send_command_locked(ndev, CMD_CONFIGURE_MW, idx);
>  	mutex_unlock(&ndev->cmd_lock);
> =20
> -	return 0;
> +	return ret;
>  }
> =20
>  static int ntb_epf_mw_clear_trans(struct ntb_dev *ntb, int pidx, int idx)
>  {
>  	struct ntb_epf_dev *ndev =3D ntb_ndev(ntb);
>  	struct device *dev =3D ndev->dev;
> -	int ret =3D 0;
> +	int ret;
> =20
> -	ntb_epf_send_command(ndev, CMD_TEARDOWN_MW, idx);
> +	ret =3D ntb_epf_send_command(ndev, CMD_TEARDOWN_MW, idx);
>  	if (ret)
>  		dev_err(dev, "Failed to teardown memory window\n");

[Severity: Medium]
Can this error path in ntb_epf_mw_clear_trans() ever be reached?

In both endpoint handlers (drivers/pci/endpoint/functions/pci-epf-ntb.c and
drivers/pci/endpoint/functions/pci-epf-vntb.c), epf_ntb_cmd_handler()
handles COMMAND_TEARDOWN_MW by unconditionally setting:

	case COMMAND_TEARDOWN_MW:
		epf_ntb_teardown_mw(ntb, ...);
		ctrl->command_status =3D COMMAND_STATUS_OK;
		break;

Because the endpoint never sets COMMAND_STATUS_ERROR for CMD_TEARDOWN_MW,
the only way CMD_TEARDOWN_MW can fail is via a timeout (which sets
ndev->cmd_status_unreliable =3D true) or by reading a late status after an
earlier command already timed out (when ndev->cmd_status_unreliable is
already true).

Since ntb_epf_send_command_locked() resets ret =3D 0 for CMD_TEARDOWN_MW
whenever ndev->cmd_status_unreliable is true, won't ntb_epf_send_command()
always return 0 here, leaving the dev_err() unreachable and silently masking
teardown timeouts when callers such as ntb_free_mw(), perf_free_inbuf(), and
tool_free_mw() are tearing down the window before freeing their DMA buffers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793540847.gi=
t.thnkslprpt@gmail.com?part=3D2
