Return-Path: <jdmason@kudzu.us>
Received: from mail-wm0-x230.google.com (mail-wm0-x230.google.com. [2a00:1450:400c:c09::230])
        by gmr-mx.google.com with ESMTPS id b62si269891wmc.0.2016.01.06.09.45.20
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jan 2016 09:45:20 -0800 (PST)
Received: by mail-wm0-x230.google.com with SMTP id f206so68119713wmf.0
        for <linux-ntb@googlegroups.com>; Wed, 06 Jan 2016 09:45:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <000001d148a0$84a18480$8de48d80$@emc.com>
References: <20160105233732.148863.67802.stgit@djiang5-desk3.ch.intel.com>
	<CAPoiz9xsYBxFb1pLEYa4xtOF4roD2F_CwJMBsoQDg1ZCSVRBnA@mail.gmail.com>
	<000001d148a0$84a18480$8de48d80$@emc.com>
Date: Wed, 6 Jan 2016 12:45:20 -0500
Message-ID: <CAPoiz9wn3sz4-OEc++CpsxMUZ4nY4bgcwrugnmq68yKQ_k5nVA@mail.gmail.com>
Subject: Re: [PATCH] ntb: ntb perf tool
From: Jon Mason <jdmason@kudzu.us>
Content-Type: text/plain; charset=UTF-8
To: Allen Hubbe <Allen.Hubbe@emc.com>
Cc: Dave Jiang <dave.jiang@intel.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Wed, Jan 6, 2016 at 11:37 AM, Allen Hubbe <Allen.Hubbe@emc.com> wrote:
> Jon Mason <jdmason@kudzu.us>:
>> On Tue, Jan 5, 2016 at 6:37 PM, Dave Jiang <dave.jiang@intel.com> wrote:
>
>> > +static void perf_link_event(void *ctx)
>> > +{
>> > +       struct perf_ctx *perf = ctx;
>> > +
>> > +       if (ntb_link_is_up(perf->ntb, NULL, NULL) == 1)
>>
>> The comparison to one seems unnecessary
>>
>
> It api doc says it returns one, zero, or negative to indicate an error.  The Intel NTB driver does not return an error.  Would you prefer to change the api, to make the return simply a boolean, and have some other mechanism to query an error?

Naa, this is fine.  Sorry for the confusion.

>> > +       if (!perf->link_is_up)
>> > +               cancel_delayed_work_sync(&perf->link_work);
>> > +
>> > +       for (i = 0; i < MAX_SPAD; i++)
>>
>> Complete aside here, but we might need to add logic to the core NTB
>> code to query the number of available SPADs and error out of we try to
>> get more than that.
>
> Use ntb_spad_count(), and the count does vary.  For example, there are half the number of spads in RP/TB topology than B2B.

Well, I think this code is saying it only needs to count up to
MAX_SPAD here, but there needs to be a check in the probe function to
verify that MAX_SPAD isn't > ntb_spad_count() (if not already there).

>
> --
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/000001d148a0%2484a18480%248de48d80%24%40emc.com.
> For more options, visit https://groups.google.com/d/optout.
