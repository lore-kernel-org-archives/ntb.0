Date: Wed, 29 Nov 2017 15:44:48 -0800 (PST)
From: Karl Kao <karl.kao@tintri.com>
Message-Id: <02a6fe08-c361-4189-82ed-84e76dd98e37@googlegroups.com>
In-Reply-To: <44261a1f-f203-4deb-bd71-ad7192dec7a2@googlegroups.com>
References: <CAJQW-Q4_hJ+23T0qhK9BRMbcfqdF7rnJkWWPmGKfN5WzyD-eJg@mail.gmail.com> <CAPoiz9zzL6jZeCa4o+AQN2j8J-5nMxQkojWdVEAb96==+v+awg@mail.gmail.com> <37fc41d9-5191-6f41-fd65-e175f0c661fa@deltatee.com> <0557295a-c60c-4aff-95ec-cb93296066ce@googlegroups.com> <87e0fa6c-025c-d5b6-b683-dbb6be9cb115@deltatee.com> <e663c6ad-64cc-407d-8c05-f4d62fa8ac9e@googlegroups.com>
 <5A1CD1A7.5040104@deltatee.com>
 <44261a1f-f203-4deb-bd71-ad7192dec7a2@googlegroups.com>
Subject: Re: Ntb Transport Driver Problem After Power-up
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_29743_1112160662.1511999089011"
To: linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

------=_Part_29743_1112160662.1511999089011
Content-Type: multipart/alternative; 
	boundary="----=_Part_29744_1778045038.1511999089011"

------=_Part_29744_1778045038.1511999089011
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Just realized the current driver supports two partitions in single 
MicroSemi chip, instead of crosslink. Sorry for the mess up.
In this sense, I am confused that the initial question is about sudden 
power loss to one system, and the other is alive. What's the configuration 
of the systems with regard to MicroSemi NTB, isn't it cross link?

Thanks,
Karl

On Monday, November 27, 2017 at 7:24:03 PM UTC-8, Karl Kao wrote:
>
> I don't get the point why one system went through a power cycle, and the 
> NTB chip in that system would not be reset.
>
> On Monday, November 27, 2017 at 7:02:36 PM UTC-8, Logan Gunthorpe wrote:
>>
>>
>>
>> On 2017-11-27 7:16 PM, Karl Kao wrote: 
>> > I meant to say the "peer" which was suddenly powered off. Once the 
>> > "peer" is being reset or power cycled, the peer's hardware chip is 
>> > supposed to be reset, correct 
>>
>> There's only one hardware chip in an NTB configuration. If you reset it, 
>> you reset all the peers (which you do not want to do). 
>>
>> Logan 
>>
>
------=_Part_29744_1778045038.1511999089011
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<div dir="ltr">Just realized the current driver supports two partitions in single MicroSemi chip, instead of crosslink. Sorry for the mess up.<div>In this sense, I am confused that the initial question is about sudden power loss to one system, and the other is alive. What&#39;s the configuration of the systems with regard to MicroSemi NTB, isn&#39;t it cross link?</div><div><br></div><div>Thanks,</div><div>Karl<br><br>On Monday, November 27, 2017 at 7:24:03 PM UTC-8, Karl Kao wrote:<blockquote class="gmail_quote" style="margin: 0;margin-left: 0.8ex;border-left: 1px #ccc solid;padding-left: 1ex;"><div dir="ltr">I don&#39;t get the point why one system went through a power cycle, and the NTB chip in that system would not be reset.<br><br>On Monday, November 27, 2017 at 7:02:36 PM UTC-8, Logan Gunthorpe wrote:<blockquote class="gmail_quote" style="margin:0;margin-left:0.8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
<br>On 2017-11-27 7:16 PM, Karl Kao wrote:
<br>&gt; I meant to say the &quot;peer&quot; which was suddenly powered off. Once the
<br>&gt; &quot;peer&quot; is being reset or power cycled, the peer&#39;s hardware chip is
<br>&gt; supposed to be reset, correct
<br>
<br>There&#39;s only one hardware chip in an NTB configuration. If you reset it, 
<br>you reset all the peers (which you do not want to do).
<br>
<br>Logan
<br></blockquote></div></blockquote></div></div>
------=_Part_29744_1778045038.1511999089011--

------=_Part_29743_1112160662.1511999089011--
