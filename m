Date: Fri, 10 Nov 2017 18:52:40 -0800 (PST)
From: lsgunthorpe@gmail.com
Message-Id: <c75244eb-e9fe-4a18-ac89-b2cc6bd02221@googlegroups.com>
In-Reply-To: <c182eb3e-a866-4510-b344-de249734f15a@googlegroups.com>
References: <20170718160409.6493-1-logang@deltatee.com>
 <c182eb3e-a866-4510-b344-de249734f15a@googlegroups.com>
Subject: Re: [PATCH v2 00/16] Switchtec NTB Support
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_673_1140598270.1510368760255"
To: linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

------=_Part_673_1140598270.1510368760255
Content-Type: multipart/alternative; 
	boundary="----=_Part_674_1700211078.1510368760255"

------=_Part_674_1700211078.1510368760255
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On Friday, November 10, 2017 at 4:27:25 AM UTC-7, cruis...@gmail.com wrote:
>
> I am working with Switchtec-NTB from Microsemi.
> The driver is working fine, but if one side computer recovers from a crash 
> due to another reason, they will lost connection, and the other side need 
> to reload the drivers in order to reconnect to the other side.
>
> Have you ever gotten this problem before ?
>

Hmm, I'm just guessing here, but it's possible that in a crash scenario the 
side that didn't crash never receives a link down event and therefore 
ignores the subsequent link up event. Thus it doesn't re-initialise 
anything when the link comes up. Next time I have time I'll take a look at 
it.

Thanks,

Logan

------=_Part_674_1700211078.1510368760255
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<div dir="ltr"><br><br>On Friday, November 10, 2017 at 4:27:25 AM UTC-7, cruis...@gmail.com wrote:<blockquote class="gmail_quote" style="margin: 0;margin-left: 0.8ex;border-left: 1px #ccc solid;padding-left: 1ex;"><div dir="ltr"><div>I am working with Switchtec-NTB from Microsemi.</div><div>The driver is working fine, but if one side computer recovers from a crash due to another reason, they will lost connection, and the other side need to reload the drivers in order to reconnect to the other side.<br><br>Have you ever gotten this problem before ?</div></div></blockquote><div><br></div><div>Hmm, I&#39;m just guessing here, but it&#39;s possible that in a crash scenario the side that didn&#39;t crash never receives a link down event and therefore ignores the subsequent link up event. Thus it doesn&#39;t re-initialise anything when the link comes up. Next time I have time I&#39;ll take a look at it.</div><div><br></div><div>Thanks,</div><div><br></div><div>Logan</div></div>
------=_Part_674_1700211078.1510368760255--

------=_Part_673_1140598270.1510368760255--
