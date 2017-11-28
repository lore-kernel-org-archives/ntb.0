Date: Mon, 27 Nov 2017 18:16:55 -0800 (PST)
From: Karl Kao <karl.kao@tintri.com>
Message-Id: <e663c6ad-64cc-407d-8c05-f4d62fa8ac9e@googlegroups.com>
In-Reply-To: <87e0fa6c-025c-d5b6-b683-dbb6be9cb115@deltatee.com>
References: <CAJQW-Q4_hJ+23T0qhK9BRMbcfqdF7rnJkWWPmGKfN5WzyD-eJg@mail.gmail.com>
 <CAPoiz9zzL6jZeCa4o+AQN2j8J-5nMxQkojWdVEAb96==+v+awg@mail.gmail.com>
 <37fc41d9-5191-6f41-fd65-e175f0c661fa@deltatee.com>
 <0557295a-c60c-4aff-95ec-cb93296066ce@googlegroups.com>
 <87e0fa6c-025c-d5b6-b683-dbb6be9cb115@deltatee.com>
Subject: Re: Ntb Transport Driver Problem After Power-up
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_26372_251384155.1511835415760"
To: linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

------=_Part_26372_251384155.1511835415760
Content-Type: multipart/alternative; 
	boundary="----=_Part_26373_942392741.1511835415760"

------=_Part_26373_942392741.1511835415760
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

I meant to say the "peer" which was suddenly powered off. Once the "peer" 
is being reset or power cycled, the peer's hardware chip is supposed to be 
reset, correct?

On Monday, November 27, 2017 at 5:42:52 PM UTC-8, Logan Gunthorpe wrote:
>
>
>
> On 27/11/17 05:14 PM, Karl Kao wrote: 
> > Would Microsemi turn off the NTB pcie link once the hardware chip is 
> > being through a reset? 
> > We can have the chip by default disable NTB link until hardware driver 
> > is loaded to make sure either reset or power cycle that the NTB link 
> > will be down. 
>
> The hardware chip won't be reset in this situation. That would kill the 
> other host. The "NTB link" is tracked in the driver as hardware only has 
> support for link events on each of the ports. 
>
> Logan 
>

------=_Part_26373_942392741.1511835415760
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<div dir="ltr">I meant to say the &quot;peer&quot; which was suddenly powered off. Once the &quot;peer&quot; is being reset or power cycled, the peer&#39;s hardware chip is supposed to be reset, correct?<br><br>On Monday, November 27, 2017 at 5:42:52 PM UTC-8, Logan Gunthorpe wrote:<blockquote class="gmail_quote" style="margin: 0;margin-left: 0.8ex;border-left: 1px #ccc solid;padding-left: 1ex;">
<br>
<br>On 27/11/17 05:14 PM, Karl Kao wrote:
<br>&gt; Would Microsemi turn off the NTB pcie link once the hardware chip is
<br>&gt; being through a reset?
<br>&gt; We can have the chip by default disable NTB link until hardware driver
<br>&gt; is loaded to make sure either reset or power cycle that the NTB link
<br>&gt; will be down.
<br>
<br>The hardware chip won&#39;t be reset in this situation. That would kill the
<br>other host. The &quot;NTB link&quot; is tracked in the driver as hardware only has
<br>support for link events on each of the ports.
<br>
<br>Logan
<br></blockquote></div>
------=_Part_26373_942392741.1511835415760--

------=_Part_26372_251384155.1511835415760--
