Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id v14si42682pfk.5.2017.12.05.11.38.31
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Dec 2017 11:38:31 -0800 (PST)
References: <20171203191736.3399-1-fancer.lancer@gmail.com>
 <20171203191736.3399-11-fancer.lancer@gmail.com>
 <CAPoiz9y9XE-sqK1n9PhD5R=wRQgEMZEeovh8yRN-_MAAyC08Tg@mail.gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <3fe534b5-cf62-4e7b-eb33-f19b4274156b@deltatee.com>
Date: Tue, 5 Dec 2017 12:38:28 -0700
MIME-Version: 1.0
In-Reply-To: <CAPoiz9y9XE-sqK1n9PhD5R=wRQgEMZEeovh8yRN-_MAAyC08Tg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 10/15] NTB: ntb_test: Update ntb_tool DB tests
To: Jon Mason <jdmason@kudzu.us>, Serge Semin <fancer.lancer@gmail.com>
Cc: Dave Jiang <dave.jiang@intel.com>, "Hubbe, Allen" <Allen.Hubbe@emc.com>, "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>, "Yu, Xiangliang" <Xiangliang.Yu@amd.com>, Gary R Hook <gary.hook@amd.com>, Sergey.Semin@t-platforms.ru, linux-ntb <linux-ntb@googlegroups.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-ntb.googlegroups.com>



On 05/12/17 11:27 AM, Jon Mason wrote:
>>          echo "Running db tests on: $(basename $LOC) / $(basename $REM)"
>>
>> -       write_file "c $DB_BITMASK" "$REM/db"
>> +       DB_VALID_MASK=$(read_file "$LOC/db_valid_mask")
>>
>> -       for ((i=1; i <= 8; i++)); do
>> -               let DB=$(read_file "$REM/db") || true
>> -               if [[ "$DB" != "$EXP" ]]; then
>> +       write_file "c $DB_VALID_MASK" "$REM/db"
>> +
>> +       for ((i = 0; i < 64; i++)); do
> 
> I'm guessing this should be a tunable variable, for those systems with
> a different number of doorbells.

That's actually the point of this patch. Serge is using db_valid_mask to 
test all possible doorbells instead of just the first 8. 64 is just the 
maximum number.

Looks like a nice improvement.

The only thing that's not clear to me is what this does:

> +	write_file "c $DB_VALID_MASK" "$REM/db_mask"
> +	write_file $DB_VALID_MASK "$REM/db_event"
> +	write_file "s $DB_VALID_MASK" "$REM/db_mask"
> +
> +	write_file "c $DB_VALID_MASK" "$REM/db"

It would be good to mention it in the commit message (then, as a rule of 
thumb, commits that do "A" and "B" should actually be two commits). 
Especially seeing db_event appears to be new and hasn't been discussed 
in any commit message.

Logan
