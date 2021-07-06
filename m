X-GM-THRID: 6981749566085267456
X-Received: by 2002:a63:5059:: with SMTP id q25mr10150510pgl.9.1625571735913;
        Tue, 06 Jul 2021 04:42:15 -0700 (PDT)
X-BeenThere: linux-ntb@googlegroups.com
Received: by 2002:a17:902:968c:: with SMTP id n12ls10750175plp.8.gmail; Tue,
 06 Jul 2021 04:42:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyf4Q9EcXnFchcNvrHU7Iwph4Ga5L2n+hDJZULyDmFYcD9xdXRPX7ZcLPoC1WfleFHukkUv
X-Received: by 2002:a17:90a:9914:: with SMTP id b20mr5532954pjp.112.1625571735240;
        Tue, 06 Jul 2021 04:42:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1625571735; cv=none;
        d=google.com; s=arc-20160816;
        b=M5jyoX61MUv7ZhWJS6FHQ/vcY7L9Woidh/LmjIrWSChwjuMlLXD1e2QAb2DuFylw+U
         chskTg/CGccsmP3YyNyoJBLpzK0CtCXW9vwmg/u1JL7or11EOuVQKSK5pNxAXv87q96w
         R1TuI2JSfgTGBChqlqFu3+QeYoQWV134Zr9UdsTaP/VbYFAyPLBMUnAFVbJCZJee08Aq
         zUg2fwX/1PPl8U1vcRrjyFGyRWCO7L60qu1hXbHwPO2tF0aRDdiYvQE4sinMTBJf3h8w
         daYyEKjXhvWVtrgnoL7cSP6vpEZAiPQfsFQLkPa29jV4NGByDE4RUmWmv/pV/OmiDQ0d
         lIRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date;
        bh=V/RGub/1UxFQNrHXKd+7o8uYVkmOmP9DJ2TlidSApMc=;
        b=gH66UTaUjAy9C82eXI0JrB3HD7Rb17k24UtILF+JR23/CIvv/0W4sHecYQv2SZ7Ves
         wPf2+Wy5nuokQ45Ncs1vHf1eQKR3l1JhCqp5EswHluxra2J4IfQrk+IuVlLhTuCFwIwx
         KmX63RFbzS7jZF2RH6HbwZwj/bGDJRLA956WyEIkBko0E4eD4yxnZAD+ark5MY9k6g6v
         a6w1LB1UzJ7V6kIV+qLuLMQ5kgZS9ddWC+fgcFUb6+98BW9wlRQ5xgxqhYeeuAR4obSw
         Tm58NBHZFS5WxNafKwcxytQxiyZOilwBEbcTKP0n22mTIwbVfAjvfWW8OI/QN7kl+lN6
         XImg==
ARC-Authentication-Results: i=1; gmr-mx.google.com;
       spf=pass (google.com: best guess record for domain of heikki.krogerus@linux.intel.com designates 192.55.52.43 as permitted sender) smtp.mailfrom=heikki.krogerus@linux.intel.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=intel.com
Return-Path: <heikki.krogerus@linux.intel.com>
Received: from mga05.intel.com (mga05.intel.com. [192.55.52.43])
        by gmr-mx.google.com with ESMTPS id o20si1960307pgv.1.2021.07.06.04.42.15
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Jul 2021 04:42:15 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of heikki.krogerus@linux.intel.com designates 192.55.52.43 as permitted sender) client-ip=192.55.52.43;
Authentication-Results: gmr-mx.google.com;
       spf=pass (google.com: best guess record for domain of heikki.krogerus@linux.intel.com designates 192.55.52.43 as permitted sender) smtp.mailfrom=heikki.krogerus@linux.intel.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=intel.com
X-IronPort-AV: E=McAfee;i="6200,9189,10036"; a="294739854"
X-IronPort-AV: E=Sophos;i="5.83,328,1616482800";
   d="scan'208";a="294739854"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2021 04:42:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,328,1616482800";
   d="scan'208";a="562991774"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 06 Jul 2021 04:41:40 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 06 Jul 2021 14:41:39 +0300
Date: Tue, 6 Jul 2021 14:41:39 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, Geoff Levand <geoff@infradead.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>,
	William Breathitt Gray <vilhelm.gray@gmail.com>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Ben Widawsky <ben.widawsky@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
	Stefan Richter <stefanr@s5r6.in-berlin.de>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Stephen Hemminger <sthemmin@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Wolfram Sang <wsa@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
	Jens Taprogge <jens.taprogge@taprogge.org>,
	Johannes Thumshirn <morbidrsa@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Maxim Levitsky <maximlevitsky@gmail.com>,
	Alex Dubov <oakad@ya
Subject: Re: [PATCH] bus: Make remove callback return void
Message-ID: <YORBc384OjIBC/Yj@kuha.fi.intel.com>
References: <20210706095037.1425211-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210706095037.1425211-1-u.kleine-koenig@pengutronix.de>
X-Import-Rejected-Reason: No matching List-ID

On Tue, Jul 06, 2021 at 11:50:37AM +0200, Uwe Kleine-K�nig wrote:
> The driver core ignores the return value of this callback because there
> is only little it can do when a device disappears.
> 
> This is the final bit of a long lasting cleanup quest where several
> buses were converted to also return void from their remove callback.
> Additionally some resource leaks were fixed that were caused by drivers
> returning an error code in the expectation that the driver won't go
> away.
> 
> With struct bus_type::remove returning void it's prevented that newly
> implemented buses return an ignored error code and so don't anticipate
> wrong expectations for driver authors.
> 
> Signed-off-by: Uwe Kleine-K�nig <u.kleine-koenig@pengutronix.de>

For ulpi and typec:

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

thanks,

-- 
heikki
