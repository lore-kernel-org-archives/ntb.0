Return-Path: <allenbh@gmail.com>
Received: from mail-wr0-x231.google.com (mail-wr0-x231.google.com. [2a00:1450:400c:c0c::231])
        by gmr-mx.google.com with ESMTPS id y2-v6si641755lfi.5.2018.06.09.18.56.48
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Jun 2018 18:56:48 -0700 (PDT)
Received: by mail-wr0-x231.google.com with SMTP id v13-v6so16856703wrp.13
        for <linux-ntb@googlegroups.com>; Sat, 09 Jun 2018 18:56:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5f6f69df-378d-4fd8-84b0-f0fff08c7575@googlegroups.com>
References: <e46a0926-7118-4009-886f-c1252cb93d62@googlegroups.com>
 <CAJ80sasPx7HFT2wgD7tMpmEVKPraHg+oQJ-zoUkNyRpnB8to+Q@mail.gmail.com>
 <62e8a338-e07b-4174-927c-f4f70a54949b@googlegroups.com> <CAJ80sauCYYOUak+1sQ=3kx_mK10pvL3pLCs_hEq-MPUaNgSD-g@mail.gmail.com>
 <32bfb787-223c-41c1-9df6-3cf57045f918@googlegroups.com> <1ed5452b-678e-4881-a82c-182413c12954@googlegroups.com>
 <CAJ80sav0RepYOu+C5-hzVdsKYpzrZuHP0M_Q=h+2P-L1LeUDbA@mail.gmail.com>
 <b05ac043-38ab-7439-1ede-7348f1b7e3bd@intel.com> <9058dedf-ec3a-42d4-9eaa-40d95740fcc0@googlegroups.com>
 <0fe77341-d309-479f-177c-c18b0193926e@intel.com> <b6723ca5-2f8b-4fcf-812e-20c4f40c73c2@googlegroups.com>
 <d87bda21-29a6-4ce2-678a-79d07220a089@intel.com> <5f6f69df-378d-4fd8-84b0-f0fff08c7575@googlegroups.com>
From: Allen Hubbe <allenbh@gmail.com>
Date: Sat, 9 Jun 2018 21:56:47 -0400
Message-ID: <CAJ80sasLr8z188sARgKTEnGZWVFdV3Khot12juh6JHyPTO4QSA@mail.gmail.com>
Subject: Re: Problem with the connection status (Link-status) after loading
 the driver ntb_hw_intel
Content-Type: text/plain; charset="UTF-8"
To: vk en <yato.iacs@gmail.com>
Cc: linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

On Fri, Jun 8, 2018 at 5:23 AM vk en <yato.iacs@gmail.com> wrote:
>
> Hey.
>
> 1. I changed the system to a new one
> it has 2 controllers with 2 processors each.  (before 2 controllers one processor each)
>
> 2. I successfully created ntrdma device, without any errors.
>
> Problems:
> 1. If only 1 controller works, then the Status link in ntb_hw_intel still shows UP.
> So it should not be, since I need to connect 2 controllers. (On the first system, this worked correctly, if I turned off one controller or switched off (ntb_transport), then the link had the status of DOWN)
> Why is this so?

What is meant by controller?

> 2. I successfully created the device, but I did not manage to connect the clusters with each other.
> NTRDMA also created an interface, but after their configuration, there is no ping between clusters.
>
> What have I done wrong? or can I be something I forgot to do?

More information would help.  Can you share the debugfs "info" files
for ntb_hw_intel, ntc, and ntrdma?
