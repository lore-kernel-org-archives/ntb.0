Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A63E1D5CC7
	for <ntb@lists.linux.dev>; Sun,  2 Mar 2025 17:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740935936; cv=none; b=qWCLxviAoXmtJYcDb2Rd2VDPcrPuWcUVrVeOWsEhv21l4by/E5GTsLHaGpk4QN+4qdoD1sId0oCq3BwNAljdy698pXh5VRowLHOPMXQoDK1+RVjjQ0An42WwEXdLbA8NE1wzBsxCOBaUxW6Ordb2eQEBLwGxvekAGSGjGnQRD1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740935936; c=relaxed/simple;
	bh=RANaFoBqTQ7kqs8IoOX1XJQ4k/DMn1lolcYnr5nmT2U=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=f4oC6ahi21GisHN2IeWLFXksT2Iv+9mUQWV4PdOUaZL83cytq+vtkb+Oe526rCTpkHMWDQrniKwX5KP2Gkk786baxJ6JhZbBnwOjb+EDK9rOQ+HMVAxdT0y9MOe0YiQHqHF3Cpf9XIdKGok0wA282pRHAElRkRQ9u2sFrscqI0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1tomxV-007SdA-0P;
	Sun, 02 Mar 2025 17:18:31 +0000
Received: from ben by deadeye with local (Exim 4.98)
	(envelope-from <ben@decadent.org.uk>)
	id 1tomxS-00000003r0l-1Yo2;
	Sun, 02 Mar 2025 18:18:30 +0100
Message-ID: <2a7a7b63272bb7e316560937c2398cff9d046ab7.camel@decadent.org.uk>
Subject: CVE-2023-52917: ntb: intel: Fix the NULL vs IS_ERR() bug for
 debugfs_create_dir()
From: Ben Hutchings <ben@decadent.org.uk>
To: Dave Jiang <dave.jiang@intel.com>, Jinjie Ruan <ruanjinjie@huawei.com>, 
	cve@kernel.org
Cc: ntb@lists.linux.dev
Date: Sun, 02 Mar 2025 18:18:21 +0100
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-f7a0z2ihnb0MoshLwrqP"
User-Agent: Evolution 3.54.1-1 
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:578:851f:1502:391e:c5f5:10e2:b9a3
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false


--=-f7a0z2ihnb0MoshLwrqP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

CVE-2023-52917 is supposed to be fixed by commit e229897d373a "ntb:
intel: Fix the NULL vs IS_ERR() bug for debugfs_create_dir()",=C2=A0but I
think this assignment should be rejected.

While it's usually a bug to use an error-pointer as a function argument,
and such bugs may be exploitable for denial-of-service, the debugfs file
creation functions are specifically intended to accept an error-pointer
as a parent pointer and they do nothing in that case.  Therefore there
was no security flaw to be fixed.

Ben.

--=20
Ben Hutchings
Any smoothly functioning technology is indistinguishable
from a rigged demo.


--=-f7a0z2ihnb0MoshLwrqP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmfEkt0ACgkQ57/I7JWG
EQm9YQ//dm+jCjiyryFuGJhMV5fc1pt/G8LvdqO8kUINLQhN90T+rXtVNc3ZNC3a
kg6995TumOvUJ5gsapcB9p/zliokP67HWNA79MbdQ3g9e4ZUdw/vbAS4/ql0fsGU
/IhHEByU/57k7A5Rw+l4SfqY3qHZb9QzFqZ7xM7YBzqSABquilWuuvDrSIoo8oKT
fCYnH7F5JLWncm6F7q1fabaXufFo7xp720+DPpeKGUwJXc3X26g2GWOXrPKhgLB2
gw1cJDOuHRr50mHDAGpjngnClWfTpalxtwLChRrz7XlzHAwDvmDOK2IOYXiJmWjV
an9R5wj4tCf5GpXYd5uTYF4DoGaz2NftOL6+eDvFRmL6VXOMT/ie3M8g/W88CjB+
F0e7JQCNi5c0QSZ7J26OOxi9QbiTHH+PoTG4uglGJXZSWLR9VytTvI+Ts4Dtpzfa
B8WU43OTtB71czuWyde9SCLIqklVo5jg60F2MYQm6fPHxqvC4HkcdbrqwWxYMFa3
l4swqIglUYTGnWNEaTJ1TMojyz/DPksrMnBVL84c5U9Si+PIIYPCRxYQcH7BeSP9
+iciE/6MtHVpdw1bl4lk8xASTfcjsAuSPfk7gTY5RzpuQuy16wMof0GlWjfFr9Cd
ImT7PS/I2s8eo5gMsNy00YT+puB8CEoWpBtYwfBLgMPOHC7v9zE=
=k0AL
-----END PGP SIGNATURE-----

--=-f7a0z2ihnb0MoshLwrqP--
