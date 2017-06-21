Date: Wed, 21 Jun 2017 00:22:34 -0700 (PDT)
From: kpriyambada48@gmail.com
Message-Id: <b8292e52-bb7c-43e1-8c28-60112a436e00@googlegroups.com>
In-Reply-To: <20170605161324.11696-1-logang@deltatee.com>
References: <20170605161324.11696-1-logang@deltatee.com>
Subject: Re: [PATCH] NTB: ntb_test: fix bug printing ntb_perf results
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_4767_820472415.1498029754376"
To: linux-ntb <linux-ntb@googlegroups.com>
Cc: logang@deltatee.com, jdmason@kudzu.us, Allen.Hubbe@dell.com
List-ID: <linux-ntb.googlegroups.com>

------=_Part_4767_820472415.1498029754376
Content-Type: multipart/alternative; 
	boundary="----=_Part_4768_634902726.1498029754376"

------=_Part_4768_634902726.1498029754376
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On Monday, June 5, 2017 at 9:43:34 PM UTC+5:30, Logan Gunthorpe wrote:
>
> The code mistakenly prints the local perf results for the remote test 
> so the script reports identical results for both directions. Fix this 
> by ensuring we print the remote result. 
>
> Signed-off-by: Logan Gunthorpe <log...@deltatee.com <javascript:>> 
> Cc: Jon Mason <jdm...@kudzu.us <javascript:>> 
> Cc: Allen Hubbe <Allen...@dell.com <javascript:>> 
> --- 
>
>  Oops, this was my own bug. 
>
>  tools/testing/selftests/ntb/ntb_test.sh | 2 +- 
>  1 file changed, 1 insertion(+), 1 deletion(-) 
>
> diff --git a/tools/testing/selftests/ntb/ntb_test.sh 
> b/tools/testing/selftests/ntb/ntb_test.sh 
> index a676d3eefefb..13f5198ba0ee 100755 
> --- a/tools/testing/selftests/ntb/ntb_test.sh 
> +++ b/tools/testing/selftests/ntb/ntb_test.sh 
> @@ -305,7 +305,7 @@ function perf_test() 
>          echo "Running remote perf test $WITH DMA" 
>          write_file "" $REMOTE_PERF/run 
>          echo -n "  " 
> -        read_file $LOCAL_PERF/run 
> +        read_file $REMOTE_PERF/run 
>          echo "  Passed" 
>
>          _modprobe -r ntb_perf 
> -- 
> 2.11.0 
>

------=_Part_4768_634902726.1498029754376
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Monday, June 5, 2017 at 9:43:34 PM UTC+5:30, Lo=
gan Gunthorpe wrote:<blockquote class=3D"gmail_quote" style=3D"margin: 0;ma=
rgin-left: 0.8ex;border-left: 1px #ccc solid;padding-left: 1ex;">The code m=
istakenly prints the local perf results for the remote test
<br>so the script reports identical results for both directions. Fix this
<br>by ensuring we print the remote result.
<br>
<br>Signed-off-by: Logan Gunthorpe &lt;<a href=3D"javascript:" target=3D"_b=
lank" gdf-obfuscated-mailto=3D"iuJREI6oAAAJ" rel=3D"nofollow" onmousedown=
=3D"this.href=3D&#39;javascript:&#39;;return true;" onclick=3D"this.href=3D=
&#39;javascript:&#39;;return true;">log...@deltatee.com</a>&gt;
<br>Cc: Jon Mason &lt;<a href=3D"javascript:" target=3D"_blank" gdf-obfusca=
ted-mailto=3D"iuJREI6oAAAJ" rel=3D"nofollow" onmousedown=3D"this.href=3D&#3=
9;javascript:&#39;;return true;" onclick=3D"this.href=3D&#39;javascript:&#3=
9;;return true;">jdm...@kudzu.us</a>&gt;
<br>Cc: Allen Hubbe &lt;<a href=3D"javascript:" target=3D"_blank" gdf-obfus=
cated-mailto=3D"iuJREI6oAAAJ" rel=3D"nofollow" onmousedown=3D"this.href=3D&=
#39;javascript:&#39;;return true;" onclick=3D"this.href=3D&#39;javascript:&=
#39;;return true;">Allen...@dell.com</a>&gt;
<br>---
<br>
<br>=C2=A0Oops, this was my own bug.
<br>
<br>=C2=A0tools/testing/selftests/ntb/<wbr>ntb_test.sh | 2 +-
<br>=C2=A01 file changed, 1 insertion(+), 1 deletion(-)
<br>
<br>diff --git a/tools/testing/selftests/ntb/<wbr>ntb_test.sh b/tools/testi=
ng/selftests/ntb/<wbr>ntb_test.sh
<br>index a676d3eefefb..13f5198ba0ee 100755
<br>--- a/tools/testing/selftests/ntb/<wbr>ntb_test.sh
<br>+++ b/tools/testing/selftests/ntb/<wbr>ntb_test.sh
<br>@@ -305,7 +305,7 @@ function perf_test()
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0echo &quot;Runnin=
g remote perf test $WITH DMA&quot;
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0write_file &quot;=
&quot; $REMOTE_PERF/run
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0echo -n &quot; =
=C2=A0&quot;
<br>-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0read_file $LOCAL_PERF/=
run
<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0read_file $REMOTE_PERF=
/run
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0echo &quot; =C2=
=A0Passed&quot;
<br>
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0_modprobe -r ntb_=
perf
<br>--
<br>2.11.0
<br></blockquote></div>
------=_Part_4768_634902726.1498029754376--

------=_Part_4767_820472415.1498029754376--
