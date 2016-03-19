Return-Path: <allenbh@gmail.com>
Received: from mail-yw0-x242.google.com (mail-yw0-x242.google.com. [2607:f8b0:4002:c05::242])
        by gmr-mx.google.com with ESMTPS id k13si1069332ywe.1.2016.03.18.17.57.24
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Mar 2016 17:57:24 -0700 (PDT)
Received: by mail-yw0-x242.google.com with SMTP id p65so11577693ywb.3
        for <linux-ntb@googlegroups.com>; Fri, 18 Mar 2016 17:57:24 -0700 (PDT)
MIME-Version: 1.0
References: <20160318233941.4985.90146.stgit@djiang5-desk3.ch.intel.com> <20160318233946.4985.43257.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <20160318233946.4985.43257.stgit@djiang5-desk3.ch.intel.com>
From: Allen Hubbe <allenbh@gmail.com>
Date: Sat, 19 Mar 2016 00:57:15 +0000
Message-ID: <CAJ80satOuPjTYv+51wnGfK__PhZ5J4Ao_fUQZGo-0Nvpt6R0TA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] NTB: Fix incorrect clean up routine in ntb_perf
Content-Type: multipart/alternative; boundary=001a1142f0d0c2f229052e5c5806
To: Dave Jiang <dave.jiang@intel.com>
Cc: jdmason@kudzu.us, linux-ntb@googlegroups.com, dan.carpenter@oracle.com
List-ID: <linux-ntb.googlegroups.com>

--001a1142f0d0c2f229052e5c5806
Content-Type: text/plain; charset=UTF-8

On Fri, Mar 18, 2016 at 7:39 PM, Dave Jiang <dave.jiang@intel.com> wrote:
> The clean up routine when we failed to allocate kthread is not cleaning
> up all the threads, only the same one over and over again.
>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Acked-by: Allen Hubbe <Allen.Hubbe@emc.com>

> ---
>  drivers/ntb/test/ntb_perf.c |   42
++++++++++++++++++++++++------------------
>  1 file changed, 24 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
> index 245a34c..842ecca 100644
> --- a/drivers/ntb/test/ntb_perf.c
> +++ b/drivers/ntb/test/ntb_perf.c
> @@ -548,6 +548,21 @@ static ssize_t debugfs_run_read(struct file *filp,
char __user *ubuf,
>         return ret;
>  }
>
> +static void threads_cleanup(struct perf_ctx *perf)
> +{
> +       struct pthr_ctx *pctx;
> +       int i;
> +
> +       perf->run = false;
> +       for (i = 0; i < MAX_THREADS; i++) {
> +               pctx = &perf->pthr_ctx[i];
> +               if (pctx->thread) {
> +                       kthread_stop(pctx->thread);
> +                       pctx->thread = NULL;
> +               }
> +       }
> +}
> +
>  static ssize_t debugfs_run_write(struct file *filp, const char __user
*ubuf,
>                                  size_t count, loff_t *offp)
>  {
> @@ -563,17 +578,9 @@ static ssize_t debugfs_run_write(struct file *filp,
const char __user *ubuf,
>         if (atomic_read(&perf->tsync) == 0)
>                 perf->run = false;
>
> -       if (perf->run) {
> -               /* lets stop the threads */
> -               perf->run = false;
> -               for (i = 0; i < MAX_THREADS; i++) {
> -                       if (perf->pthr_ctx[i].thread) {
> -                               kthread_stop(perf->pthr_ctx[i].thread);
> -                               perf->pthr_ctx[i].thread = NULL;
> -                       } else
> -                               break;
> -               }
> -       } else {
> +       if (perf->run)
> +               threads_cleanup(perf);
> +       else {

Checkpatch would complain about { }'s here.  Maybe no big deal since this
style is already used throughout the file.

>                 perf->run = true;
>
>                 if (perf->perf_threads > MAX_THREADS) {
> @@ -605,13 +612,8 @@ static ssize_t debugfs_run_write(struct file *filp,
const char __user *ubuf,
>                                                        (void *)pctx,
>                                                        node, "ntb_perf
%d", i);
>                         if (IS_ERR(pctx->thread)) {
> -                               perf->run = false;
> -                               for (i = 0; i < MAX_THREADS; i++) {
> -                                       if (pctx->thread) {
> -
 kthread_stop(pctx->thread);
> -                                               pctx->thread = NULL;
> -                                       }
> -                               }
> +                               pctx->thread = NULL;
> +                               goto err;

Goto was suggested to make clear the scope and use of i and pctx, since
they were assigned in both the inner and outer loops.  Since you factored
out the inner loop as threads_cleanup, that is an even cleaner solution,
and the goto is no longer necessary.  No harm with the goto here as well,
and I think this is fine now as written.

>                         } else
>                                 wake_up_process(pctx->thread);
>
> @@ -622,6 +624,10 @@ static ssize_t debugfs_run_write(struct file *filp,
const char __user *ubuf,
>         }
>
>         return count;
> +
> +err:
> +       threads_cleanup(perf);
> +       return -ENXIO;
>  }
>
>  static const struct file_operations ntb_perf_debugfs_run = {
>

--001a1142f0d0c2f229052e5c5806
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+T24gRnJpLCBNYXIgMTgsIDIwMTYgYXQgNzozOSBQTSwgRGF2ZSBKaWFu
ZyAmbHQ7PGEgaHJlZj0ibWFpbHRvOmRhdmUuamlhbmdAaW50ZWwuY29tIiB0YXJnZXQ9Il9ibGFu
ayI+ZGF2ZS5qaWFuZ0BpbnRlbC5jb208L2E+Jmd0OyB3cm90ZTo8YnI+DQomZ3Q7IFRoZSBjbGVh
biB1cCByb3V0aW5lIHdoZW4gd2UgZmFpbGVkIHRvIGFsbG9jYXRlIGt0aHJlYWQgaXMgbm90IGNs
ZWFuaW5nPGJyPg0KJmd0OyB1cCBhbGwgdGhlIHRocmVhZHMsIG9ubHkgdGhlIHNhbWUgb25lIG92
ZXIgYW5kIG92ZXIgYWdhaW4uPGJyPg0KJmd0Ozxicj4NCiZndDsgUmVwb3J0ZWQtYnk6IERhbiBD
YXJwZW50ZXIgJmx0OzxhIGhyZWY9Im1haWx0bzpkYW4uY2FycGVudGVyQG9yYWNsZS5jb20iIHRh
cmdldD0iX2JsYW5rIj5kYW4uY2FycGVudGVyQG9yYWNsZS5jb208L2E+Jmd0Ozxicj4NCiZndDsg
U2lnbmVkLW9mZi1ieTogRGF2ZSBKaWFuZyAmbHQ7PGEgaHJlZj0ibWFpbHRvOmRhdmUuamlhbmdA
aW50ZWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+ZGF2ZS5qaWFuZ0BpbnRlbC5jb208L2E+Jmd0Ozxi
cj4NCjxicj4NCkFja2VkLWJ5OiBBbGxlbiBIdWJiZSAmbHQ7PGEgaHJlZj0ibWFpbHRvOkFsbGVu
Lkh1YmJlQGVtYy5jb20iPkFsbGVuLkh1YmJlQGVtYy5jb208L2E+Jmd0Ozxicj48YnI+DQomZ3Q7
IC0tLTxicj4NCiZndDvCoCBkcml2ZXJzL250Yi90ZXN0L250Yl9wZXJmLmMgfMKgIMKgNDIgKysr
KysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tPGJyPg0KJmd0O8KgIDEgZmls
ZSBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspLCAxOCBkZWxldGlvbnMoLSk8YnI+DQomZ3Q7PGJy
Pg0KJmd0OyBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udGIvdGVzdC9udGJfcGVyZi5jIGIvZHJpdmVy
cy9udGIvdGVzdC9udGJfcGVyZi5jPGJyPg0KJmd0OyBpbmRleCAyNDVhMzRjLi44NDJlY2NhIDEw
MDY0NDxicj4NCiZndDsgLS0tIGEvZHJpdmVycy9udGIvdGVzdC9udGJfcGVyZi5jPGJyPg0KJmd0
OyArKysgYi9kcml2ZXJzL250Yi90ZXN0L250Yl9wZXJmLmM8YnI+DQomZ3Q7IEBAIC01NDgsNiAr
NTQ4LDIxIEBAIHN0YXRpYyBzc2l6ZV90IGRlYnVnZnNfcnVuX3JlYWQoc3RydWN0IGZpbGUgKmZp
bHAsIGNoYXIgX191c2VyICp1YnVmLDxicj4NCiZndDvCoCDCoCDCoCDCoCDCoHJldHVybiByZXQ7
PGJyPg0KJmd0O8KgIH08YnI+DQomZ3Q7PGJyPg0KJmd0OyArc3RhdGljIHZvaWQgdGhyZWFkc19j
bGVhbnVwKHN0cnVjdCBwZXJmX2N0eCAqcGVyZik8YnI+DQomZ3Q7ICt7PGJyPg0KJmd0OyArwqAg
wqAgwqAgwqBzdHJ1Y3QgcHRocl9jdHggKnBjdHg7PGJyPg0KJmd0OyArwqAgwqAgwqAgwqBpbnQg
aTs8YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoHBlcmYtJmd0O3J1biA9IGZhbHNl
Ozxicj4NCiZndDsgK8KgIMKgIMKgIMKgZm9yIChpID0gMDsgaSAmbHQ7IE1BWF9USFJFQURTOyBp
KyspIHs8YnI+DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHBjdHggPSAmYW1wO3BlcmYt
Jmd0O3B0aHJfY3R4W2ldOzxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKHBj
dHgtJmd0O3RocmVhZCkgezxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKga3RocmVhZF9zdG9wKHBjdHgtJmd0O3RocmVhZCk7PGJyPg0KJmd0OyArwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBwY3R4LSZndDt0aHJlYWQgPSBOVUxMOzxicj4NCiZn
dDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4NCiZndDsgK8KgIMKgIMKgIMKgfTxicj4N
CiZndDsgK308YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7wqAgc3RhdGljIHNzaXplX3QgZGVidWdmc19y
dW5fd3JpdGUoc3RydWN0IGZpbGUgKmZpbHAsIGNvbnN0IGNoYXIgX191c2VyICp1YnVmLDxicj4N
CiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBz
aXplX3QgY291bnQsIGxvZmZfdCAqb2ZmcCk8YnI+DQomZ3Q7wqAgezxicj4NCiZndDsgQEAgLTU2
MywxNyArNTc4LDkgQEAgc3RhdGljIHNzaXplX3QgZGVidWdmc19ydW5fd3JpdGUoc3RydWN0IGZp
bGUgKmZpbHAsIGNvbnN0IGNoYXIgX191c2VyICp1YnVmLDxicj4NCiZndDvCoCDCoCDCoCDCoCDC
oGlmIChhdG9taWNfcmVhZCgmYW1wO3BlcmYtJmd0O3RzeW5jKSA9PSAwKTxicj4NCiZndDvCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoHBlcmYtJmd0O3J1biA9IGZhbHNlOzxicj4NCiZndDs8YnI+
DQomZ3Q7IC3CoCDCoCDCoCDCoGlmIChwZXJmLSZndDtydW4pIHs8YnI+DQomZ3Q7IC3CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoC8qIGxldHMgc3RvcCB0aGUgdGhyZWFkcyAqLzxicj4NCiZndDsgLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgcGVyZi0mZ3Q7cnVuID0gZmFsc2U7PGJyPg0KJmd0OyAtwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBmb3IgKGkgPSAwOyBpICZsdDsgTUFYX1RIUkVBRFM7IGkrKykg
ezxicj4NCiZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKHBlcmYt
Jmd0O3B0aHJfY3R4W2ldLnRocmVhZCkgezxicj4NCiZndDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKga3RocmVhZF9zdG9wKHBlcmYtJmd0O3B0aHJfY3R4
W2ldLnRocmVhZCk7PGJyPg0KJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBwZXJmLSZndDtwdGhyX2N0eFtpXS50aHJlYWQgPSBOVUxMOzxicj4NCiZn
dDsgLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfSBlbHNlPGJyPg0KJmd0OyAt
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBicmVhazs8YnI+
DQomZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH08YnI+DQomZ3Q7IC3CoCDCoCDCoCDCoH0g
ZWxzZSB7PGJyPg0KJmd0OyArwqAgwqAgwqAgwqBpZiAocGVyZi0mZ3Q7cnVuKTxicj4NCiZndDsg
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdGhyZWFkc19jbGVhbnVwKHBlcmYpOzxicj4NCiZndDsg
K8KgIMKgIMKgIMKgZWxzZSB7PGJyPjxicj5DaGVja3BhdGNoIHdvdWxkIGNvbXBsYWluIGFib3V0
IHsgfSYjMzk7cyBoZXJlLsKgIE1heWJlIG5vIGJpZyBkZWFsIHNpbmNlIHRoaXMgc3R5bGUgaXMg
YWxyZWFkeSB1c2VkIHRocm91Z2hvdXQgdGhlIGZpbGUuPGJyPjxkaXY+PGJyPjwvZGl2PjxkaXY+
DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBwZXJmLSZndDtydW4gPSB0cnVlOzxicj4N
CiZndDs8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAocGVyZi0mZ3Q7cGVy
Zl90aHJlYWRzICZndDsgTUFYX1RIUkVBRFMpIHs8YnI+DQomZ3Q7IEBAIC02MDUsMTMgKzYxMiw4
IEBAIHN0YXRpYyBzc2l6ZV90IGRlYnVnZnNfcnVuX3dyaXRlKHN0cnVjdCBmaWxlICpmaWxwLCBj
b25zdCBjaGFyIF9fdXNlciAqdWJ1Ziw8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgKHZvaWQgKilwY3R4LDxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBub2Rl
LCAmcXVvdDtudGJfcGVyZiAlZCZxdW90OywgaSk7PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKElTX0VSUihwY3R4LSZndDt0aHJlYWQpKSB7PGJyPg0K
Jmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBwZXJm
LSZndDtydW4gPSBmYWxzZTs8YnI+DQomZ3Q7IC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoGZvciAoaSA9IDA7IGkgJmx0OyBNQVhfVEhSRUFEUzsgaSsrKSB7
PGJyPg0KJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBpZiAocGN0eC0mZ3Q7dGhyZWFkKSB7PGJyPg0KJmd0OyAtwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBrdGhyZWFkX3N0b3AocGN0eC0mZ3Q7dGhyZWFkKTs8YnI+DQomZ3Q7IC3CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoHBjdHgtJmd0O3RocmVhZCA9IE5VTEw7PGJyPg0KJmd0OyAtwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9PGJyPg0KJmd0OyAtwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9PGJyPg0KJmd0OyAr
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBwY3R4LSZndDt0
aHJlYWQgPSBOVUxMOzxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgZ290byBlcnI7PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5Hb3RvIHdh
cyBzdWdnZXN0ZWQgdG8gbWFrZSBjbGVhciB0aGUgc2NvcGUgYW5kIHVzZSBvZiBpIGFuZCBwY3R4
LCBzaW5jZSB0aGV5IHdlcmUgYXNzaWduZWQgaW4gYm90aCB0aGUgaW5uZXIgYW5kIG91dGVyIGxv
b3BzLsKgIFNpbmNlIHlvdSBmYWN0b3JlZCBvdXQgdGhlIGlubmVyIGxvb3AgYXMgdGhyZWFkc19j
bGVhbnVwLCB0aGF0IGlzIGFuIGV2ZW4gY2xlYW5lciBzb2x1dGlvbiwgYW5kIHRoZSBnb3RvIGlz
IG5vIGxvbmdlciBuZWNlc3NhcnkuwqAgTm8gaGFybSB3aXRoIHRoZSBnb3RvIGhlcmUgYXMgd2Vs
bCwgYW5kIEkgdGhpbmsgdGhpcyBpcyBmaW5lIG5vdyBhcyB3cml0dGVuLjwvZGl2PjxkaXY+PGJy
PjwvZGl2PjxkaXY+Jmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfSBl
bHNlPGJyPjwvZGl2PjxkaXY+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqB3YWtlX3VwX3Byb2Nlc3MocGN0eC0mZ3Q7dGhyZWFkKTs8YnI+DQom
Z3Q7PGJyPg0KJmd0OyBAQCAtNjIyLDYgKzYyNCwxMCBAQCBzdGF0aWMgc3NpemVfdCBkZWJ1Z2Zz
X3J1bl93cml0ZShzdHJ1Y3QgZmlsZSAqZmlscCwgY29uc3QgY2hhciBfX3VzZXIgKnVidWYsPGJy
Pg0KJmd0O8KgIMKgIMKgIMKgIMKgfTxicj4NCiZndDs8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqBy
ZXR1cm4gY291bnQ7PGJyPg0KJmd0OyArPGJyPg0KJmd0OyArZXJyOjxicj4NCiZndDsgK8KgIMKg
IMKgIMKgdGhyZWFkc19jbGVhbnVwKHBlcmYpOzxicj4NCiZndDsgK8KgIMKgIMKgIMKgcmV0dXJu
IC1FTlhJTzs8YnI+DQomZ3Q7wqAgfTxicj4NCiZndDs8YnI+DQomZ3Q7wqAgc3RhdGljIGNvbnN0
IHN0cnVjdCBmaWxlX29wZXJhdGlvbnMgbnRiX3BlcmZfZGVidWdmc19ydW4gPSB7PGJyPg0KJmd0
Ozxicj4NCjwvZGl2PjwvZGl2Pg0K
--001a1142f0d0c2f229052e5c5806--
