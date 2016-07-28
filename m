Return-Path: <fancer.lancer@gmail.com>
Received: from mail-qk0-x22f.google.com (mail-qk0-x22f.google.com. [2607:f8b0:400d:c09::22f])
        by gmr-mx.google.com with ESMTPS id r127si911335ywh.0.2016.07.28.06.18.57
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jul 2016 06:18:57 -0700 (PDT)
Received: by mail-qk0-x22f.google.com with SMTP id x1so61793896qkb.3
        for <linux-ntb@googlegroups.com>; Thu, 28 Jul 2016 06:18:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201607282033.1nkvsKIc%fengguang.wu@intel.com>
References: <1469562619-21705-4-git-send-email-fancer.lancer@gmail.com> <201607282033.1nkvsKIc%fengguang.wu@intel.com>
From: "Fancer's opinion" <fancer.lancer@gmail.com>
Date: Thu, 28 Jul 2016 16:18:37 +0300
Message-ID: <CAMPMW8oTr+47aFeujOgOhcZ9pBeAs6itfvFUB3GRm5q1ahW9_A@mail.gmail.com>
Subject: Re: [PATCH 3/3] ntb: Test client drivers for asynchronous NTB devices
Content-Type: multipart/alternative; boundary=001a114e72e4e95bcd0538b1f95d
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, Xiangliang.Yu@amd.com, Serge Semin <Sergey.Semin@t-platforms.ru>, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

--001a114e72e4e95bcd0538b1f95d
Content-Type: text/plain; charset=UTF-8

Please, take a look at the next patchset. I've already fixed these issues
there.

Regards,
-Sergey

On Thu, Jul 28, 2016 at 3:58 PM, kbuild test robot <lkp@intel.com> wrote:

> Hi,
>
> [auto build test WARNING on ntb/ntb-next]
> [cannot apply to v4.7 next-20160728]
> [if your patch is applied to the wrong git tree, please drop us a note to
> help improve the system]
>
> url:
> https://github.com/0day-ci/linux/commits/Serge-Semin/ntb-Asynchronous-NTB-devices-support/20160727-082033
> base:   https://github.com/jonmason/ntb ntb-next
> config: sparc64-allyesconfig (attached as .config)
> compiler: sparc64-linux-gnu-gcc (Debian 5.4.0-6) 5.4.0 20160609
> reproduce:
>         wget
> https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross
> -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=sparc64
>
> All warnings (new ones prefixed by >>):
>
>    In file included from include/linux/swab.h:4:0,
>                     from include/uapi/linux/byteorder/big_endian.h:12,
>                     from include/linux/byteorder/big_endian.h:4,
>                     from arch/sparc/include/uapi/asm/byteorder.h:4,
>                     from arch/sparc/include/asm/bitops_64.h:15,
>                     from arch/sparc/include/asm/bitops.h:4,
>                     from include/linux/bitops.h:36,
>                     from include/linux/kernel.h:10,
>                     from drivers/ntb/test/ntb_mw_test.c:57:
>    drivers/ntb/test/ntb_mw_test.c: In function 'mw_send_inmw_addrs':
> >> drivers/ntb/test/ntb_mw_test.c:353:49: warning: right shift count >=
> width of type [-Wshift-count-overflow]
>       msg.payload[1] = to_sh32((u32)(inmw->dma_addr >> 32));
>                                                     ^
>    include/uapi/linux/swab.h:116:32: note: in definition of macro
> '__swab32'
>      (__builtin_constant_p((__u32)(x)) ? \
>                                    ^
>    include/linux/byteorder/generic.h:87:21: note: in expansion of macro
> '__cpu_to_le32'
>     #define cpu_to_le32 __cpu_to_le32
>                         ^
> >> drivers/ntb/test/ntb_mw_test.c:353:20: note: in expansion of macro
> 'to_sh32'
>       msg.payload[1] = to_sh32((u32)(inmw->dma_addr >> 32));
>                        ^
> >> drivers/ntb/test/ntb_mw_test.c:353:49: warning: right shift count >=
> width of type [-Wshift-count-overflow]
>       msg.payload[1] = to_sh32((u32)(inmw->dma_addr >> 32));
>                                                     ^
>    include/uapi/linux/swab.h:17:12: note: in definition of macro
> '___constant_swab32'
>      (((__u32)(x) & (__u32)0x000000ffUL) << 24) |  \
>                ^
>    include/uapi/linux/byteorder/big_endian.h:32:43: note: in expansion of
> macro '__swab32'
>     #define __cpu_to_le32(x) ((__force __le32)__swab32((x)))
>                                               ^
>    include/linux/byteorder/generic.h:87:21: note: in expansion of macro
> '__cpu_to_le32'
>     #define cpu_to_le32 __cpu_to_le32
>                         ^
> >> drivers/ntb/test/ntb_mw_test.c:353:20: note: in expansion of macro
> 'to_sh32'
>       msg.payload[1] = to_sh32((u32)(inmw->dma_addr >> 32));
>                        ^
> >> drivers/ntb/test/ntb_mw_test.c:353:49: warning: right shift count >=
> width of type [-Wshift-count-overflow]
>       msg.payload[1] = to_sh32((u32)(inmw->dma_addr >> 32));
>                                                     ^
>    include/uapi/linux/swab.h:18:12: note: in definition of macro
> '___constant_swab32'
>      (((__u32)(x) & (__u32)0x0000ff00UL) <<  8) |  \
>                ^
>    include/uapi/linux/byteorder/big_endian.h:32:43: note: in expansion of
> macro '__swab32'
>     #define __cpu_to_le32(x) ((__force __le32)__swab32((x)))
>                                               ^
>    include/linux/byteorder/generic.h:87:21: note: in expansion of macro
> '__cpu_to_le32'
>     #define cpu_to_le32 __cpu_to_le32
>                         ^
> >> drivers/ntb/test/ntb_mw_test.c:353:20: note: in expansion of macro
> 'to_sh32'
>       msg.payload[1] = to_sh32((u32)(inmw->dma_addr >> 32));
>                        ^
> >> drivers/ntb/test/ntb_mw_test.c:353:49: warning: right shift count >=
> width of type [-Wshift-count-overflow]
>       msg.payload[1] = to_sh32((u32)(inmw->dma_addr >> 32));
>                                                     ^
>    include/uapi/linux/swab.h:19:12: note: in definition of macro
> '___constant_swab32'
>      (((__u32)(x) & (__u32)0x00ff0000UL) >>  8) |  \
>                ^
>    include/uapi/linux/byteorder/big_endian.h:32:43: note: in expansion of
> macro '__swab32'
>     #define __cpu_to_le32(x) ((__force __le32)__swab32((x)))
>                                               ^
>    include/linux/byteorder/generic.h:87:21: note: in expansion of macro
> '__cpu_to_le32'
>     #define cpu_to_le32 __cpu_to_le32
>                         ^
> >> drivers/ntb/test/ntb_mw_test.c:353:20: note: in expansion of macro
> 'to_sh32'
>       msg.payload[1] = to_sh32((u32)(inmw->dma_addr >> 32));
>                        ^
> >> drivers/ntb/test/ntb_mw_test.c:353:49: warning: right shift count >=
> width of type [-Wshift-count-overflow]
>       msg.payload[1] = to_sh32((u32)(inmw->dma_addr >> 32));
>                                                     ^
>    include/uapi/linux/swab.h:20:12: note: in definition of macro
> '___constant_swab32'
>      (((__u32)(x) & (__u32)0xff000000UL) >> 24)))
>                ^
>    include/uapi/linux/byteorder/big_endian.h:32:43: note: in expansion of
> macro '__swab32'
>     #define __cpu_to_le32(x) ((__force __le32)__swab32((x)))
>                                               ^
>    include/linux/byteorder/generic.h:87:21: note: in expansion of macro
> '__cpu_to_le32'
>     #define cpu_to_le32 __cpu_to_le32
>                         ^
> >> drivers/ntb/test/ntb_mw_test.c:353:20: note: in expansion of macro
> 'to_sh32'
>       msg.payload[1] = to_sh32((u32)(inmw->dma_addr >> 32));
>                        ^
> >> drivers/ntb/test/ntb_mw_test.c:353:49: warning: right shift count >=
> width of type [-Wshift-count-overflow]
>       msg.payload[1] = to_sh32((u32)(inmw->dma_addr >> 32));
>                                                     ^
>    include/uapi/linux/swab.h:118:12: note: in definition of macro
> '__swab32'
>      __fswab32(x))
>                ^
>    include/linux/byteorder/generic.h:87:21: note: in expansion of macro
> '__cpu_to_le32'
>     #define cpu_to_le32 __cpu_to_le32
>                         ^
> >> drivers/ntb/test/ntb_mw_test.c:353:20: note: in expansion of macro
> 'to_sh32'
>       msg.payload[1] = to_sh32((u32)(inmw->dma_addr >> 32));
>                        ^
>    drivers/ntb/test/ntb_mw_test.c: In function 'mw_set_outmw_addr':
> >> drivers/ntb/test/ntb_mw_test.c:407:61: warning: left shift count >=
> width of type [-Wshift-count-overflow]
>      outmw->dma_addr |= ((dma_addr_t)from_sh32(msg->payload[1]) << 32);
>                                                                 ^
> >> drivers/ntb/test/ntb_mw_test.c:413:23: warning: cast to pointer from
> integer of different size [-Wint-to-pointer-cast]
>        "within %u bytes", (void *)outmw->dma_addr,
>                           ^
>    drivers/ntb/test/ntb_mw_test.c:189:29: note: in definition of macro
> 'dev_err_mw'
>      dev_err(&ctx->ntb->dev, ## args)
>                                 ^
>    drivers/ntb/test/ntb_mw_test.c:422:33: warning: cast to pointer from
> integer of different size [-Wint-to-pointer-cast]
>        "outbound memory window %d", (void *)outmw->dma_addr,
>                                     ^
>    drivers/ntb/test/ntb_mw_test.c:189:29: note: in definition of macro
> 'dev_err_mw'
>      dev_err(&ctx->ntb->dev, ## args)
>                                 ^
>    In file included from include/linux/printk.h:289:0,
>                     from include/linux/kernel.h:13,
>                     from drivers/ntb/test/ntb_mw_test.c:57:
>    drivers/ntb/test/ntb_mw_test.c:431:27: warning: cast to pointer from
> integer of different size [-Wint-to-pointer-cast]
>       "address 0x%p", mwindx, (void *)outmw->dma_addr);
>                               ^
>    include/linux/dynamic_debug.h:87:9: note: in definition of macro
> 'dynamic_dev_dbg'
>           ##__VA_ARGS__);  \
>             ^
> >> drivers/ntb/test/ntb_mw_test.c:195:2: note: in expansion of macro
> 'dev_dbg'
>      dev_dbg(&ctx->ntb->dev, ## args)
>      ^
> >> drivers/ntb/test/ntb_mw_test.c:430:2: note: in expansion of macro
> 'dev_dbg_mw'
>      dev_dbg_mw(ctx, "Outbound memory window %d is initialized with "
>      ^
>    drivers/ntb/test/ntb_mw_test.c: In function 'mw_dbgfs_outmw_cfg_read':
>    drivers/ntb/test/ntb_mw_test.c:766:30: warning: cast to pointer from
> integer of different size [-Wint-to-pointer-cast]
>       "DMA address\t\t- 0x%p\n", (void *)wrap->dma_addr);
>                                  ^
>    drivers/ntb/test/ntb_mw_test.c: In function 'mw_dbgfs_inmw_cfg_read':
>    drivers/ntb/test/ntb_mw_test.c:915:30: warning: cast to pointer from
> integer of different size [-Wint-to-pointer-cast]
>       "DMA address\t\t- 0x%p\n", (void *)wrap->dma_addr);
>                                  ^
>    drivers/ntb/test/ntb_mw_test.c: In function 'mw_create_inmws':
>    drivers/ntb/test/ntb_mw_test.c:1197:25: warning: cast to pointer from
> integer of different size [-Wint-to-pointer-cast]
>         "aligned with %lu", (void *)inmw->dma_addr, mwindx,
>                             ^
>    drivers/ntb/test/ntb_mw_test.c:189:29: note: in definition of macro
> 'dev_err_mw'
>      dev_err(&ctx->ntb->dev, ## args)
>                                 ^
>
> vim +353 drivers/ntb/test/ntb_mw_test.c
>
>    189          dev_err(&ctx->ntb->dev, ## args)
>    190  #define dev_warn_mw(ctx, args...) \
>    191          dev_warn(&ctx->ntb->dev, ## args)
>    192  #define dev_info_mw(ctx, args...) \
>    193          dev_info(&ctx->ntb->dev, ## args)
>    194  #define dev_dbg_mw(ctx, args...) \
>  > 195          dev_dbg(&ctx->ntb->dev, ## args)
>    196
>    197  /*
>    198   * Some common constant used in the driver for better readability:
>    199   * @ON: Enable something
>    200   * @OFF: Disable something
>    201   * @SUCCESS: Success of a function execution
>    202   * @MIN_MW_CNT: Minimum memory windows count
>    203   * @MAX_MW_CNT: Maximum memory windows count
>    204   */
>    205  #define ON ((u32)0x1)
>    206  #define OFF ((u32)0x0)
>    207  #define SUCCESS 0
>    208  #define MIN_MW_CNT ((unsigned char)1)
>    209  #define MAX_MW_CNT ((unsigned char)255)
>    210
>    211  /*
>    212   * Shared data converter to support the different CPU architectures
>    213   */
>    214  #define to_sh32(data) \
>    215          cpu_to_le32((data))
>    216  #define from_sh32(data) \
>    217          le32_to_cpu((data))
>    218
>    219  /*
>    220   * Module parameters:
>    221   * @inmw_cnt:   Number of inbound memory windows [1; 255]
>    222   * @outmw_cnt:  Number of outbound memory windows [1; 255]
>    223   * If the specified value exceeds the maximum possible valiue,
> then it is
>    224   * initialized with maximum one
>    225   */
>    226  static unsigned char inmws_cnt = MAX_MW_CNT;
>    227  module_param(inmws_cnt, byte, 0000);
>    228  MODULE_PARM_DESC(inmws_cnt,
>    229          "Inbound memory windows count. Those are the memory
> windows, which are "
>    230          "locally allocated. Their address is sent to the remote
> host."
>    231          " - Parameter can be set within [1; 255], where 255 means
> maximum possible"
>    232          "   number of windows");
>    233
>    234
> /*===========================================================================
>    235   *                               Helper methods
>    236
>  *===========================================================================*/
>    237
>    238  /*
>    239   * Alter the passed driver paremeters
>    240   */
>    241  static void mw_alter_params(struct mw_ctx *ctx)
>    242  {
>    243          unsigned char inmws_cnt_bak = ctx->inmws_cnt;
>    244
>    245          /* Clamp the inbound memory windows parameter */
>    246          ctx->inmws_cnt = clamp(inmws_cnt,
>    247                  MIN_MW_CNT, (unsigned char)ctx->inmws_cnt);
>    248          if (inmws_cnt_bak != ctx->inmws_cnt) {
>    249                  dev_warn_mw(ctx,
>    250                          "Inbound memory windows count is altered
> from "
>    251                          "%hhu to %hhu", inmws_cnt_bak,
> ctx->inmws_cnt);
>    252          }
>    253
>    254          dev_dbg_mw(ctx, "Memory windows test driver parameter is
> verified");
>    255  }
>    256
>    257  /*
>    258   * Memory block IO write method
>    259   */
>    260  static void iomem_write(void __iomem *dst, const void *src, size_t
> cnt)
>    261  {
>    262          while (cnt--) {
>    263                  iowrite8(*(u8 *)src, dst);
>    264                  dst++;
>    265                  src++;
>    266          }
>    267  }
>    268
>    269  /*
>    270   * Memory block IO read method
>    271   */
>    272  static void iomem_read(void __iomem *src, void *dst, size_t cnt)
>    273  {
>    274          while (cnt--) {
>    275                  *(u8 *)dst = ioread8(src);
>    276                  dst++;
>    277                  src++;
>    278          }
>    279  }
>    280
>    281
> /*===========================================================================
>    282   *                          Message command handlers
>    283
>  *===========================================================================*/
>    284
>    285  /*
>    286   * Send MW_GETADDRS command method
>    287   */
>    288  static void mw_send_getaddrs_cmd(struct mw_ctx *ctx)
>    289  {
>    290          struct ntb_msg msg;
>    291          int sts;
>    292
>    293          /* Clear the message structure */
>    294          memset(&msg, 0, sizeof(msg));
>    295
>    296          /* Set the message type only */
>    297          msg.type = to_sh32(MW_GETADDRS);
>    298
>    299          /* Send the message */
>    300          sts = ntb_msg_post(ctx->ntb, &msg);
>    301          if (SUCCESS != sts) {
>    302                  dev_err_mw(ctx, "Failed to send message to get
> outbound window "
>    303                          "addresses");
>    304          }
>    305  }
>    306
>    307  /*
>    308   * Send MW_FREEADDRS command method
>    309   */
>    310  static void mw_send_freeaddrs_cmd(struct mw_ctx *ctx)
>    311  {
>    312          struct ntb_msg msg;
>    313          int sts;
>    314
>    315          /* Clear the message structure */
>    316          memset(&msg, 0, sizeof(msg));
>    317
>    318          /* Set the message type only */
>    319          msg.type = to_sh32(MW_FREEADDRS);
>    320
>    321          /* Send the message */
>    322          sts = ntb_msg_post(ctx->ntb, &msg);
>    323          if (SUCCESS != sts) {
>    324                  dev_err_mw(ctx, "Failed to send a message to
> disable the peer "
>    325                          "outbound windows");
>    326          }
>    327  }
>    328
>    329  /*
>    330   * Callback method for response on the command MW_GETADDRS
>    331   */
>    332  static void mw_send_inmw_addrs(struct mw_ctx *ctx)
>    333  {
>    334          struct ntb_msg msg;
>    335          struct inmw_wrap *inmw;
>    336          int mwindx, sts;
>    337
>    338          /* Clear the message structure */
>    339          memset(&msg, 0, sizeof(msg));
>    340
>    341          /* Walk through all the inbound memory windows and send the
>    342           * corresponding DMA address of the window */
>    343          for (mwindx = 0; mwindx < ctx->inmws_cnt; mwindx++) {
>    344                  inmw = &ctx->inmws[mwindx];
>    345                  /* Set the type and the memory window index */
>    346                  msg.type = to_sh32(MW_DMAADDR | ((u32)mwindx <<
> 16));
>    347
>    348                  /* First set the size of the memory window */
>    349                  msg.payload[0] = to_sh32(inmw->size);
>    350
>    351                  /* Set the Upper part of the memory window address
> */
>    352  #ifdef CONFIG_64BIT
>  > 353                  msg.payload[1] = to_sh32((u32)(inmw->dma_addr >>
> 32));
>    354  #else
>    355                  /* WARNING! NTB entpoints must either have the
> same architecture
>    356                   * (x32 or x64) or use lower 4Gb for memory
> windows */
>    357                  msg.payload[1] = 0;
>    358  #endif /* !CONFIG_64BIT */
>    359                  /* Set the Lower part of the memory window address
> */
>    360                  msg.payload[2] = to_sh32((u32)(inmw->dma_addr));
>    361
>    362                  /* Send the message */
>    363                  sts = ntb_msg_post(ctx->ntb, &msg);
>    364                  if (SUCCESS != sts) {
>    365                          dev_err_mw(ctx,
>    366                                  "Failed to send a message with
> window %d "
>    367                                  "address", mwindx);
>    368                  }
>    369          }
>    370  }
>    371
>    372  /*
>    373   * Method to set the corresponding memory window and enable it
>    374   */
>    375  static void mw_set_outmw_addr(struct mw_ctx *ctx, const struct
> ntb_msg *msg)
>    376  {
>    377          struct outmw_wrap *outmw;
>    378          int mwindx, sts;
>    379
>    380          /* Read the memory windows index (it's the part of the
> message type) */
>    381          mwindx = from_sh32(msg->type) >> 16;
>    382          if (ctx->outmws_cnt <= mwindx) {
>    383                  dev_err_mw(ctx,
>    384                          "Retrieved invalid outbound memory window
> index %d",
>    385                          mwindx);
>    386                  return;
>    387          }
>    388          outmw = &ctx->outmws[mwindx];
>    389
>    390          /* Read the memory window size and check whether it has
> proper size and
>    391           * alignment */
>    392          outmw->size = from_sh32(msg->payload[0]);
>    393          if (!IS_ALIGNED(outmw->size, outmw->size_align) ||
>    394              outmw->size_max < outmw->size) {
>    395                  dev_err_mw(ctx,
>    396                          "Retrieved invalid memory window %d size
> %u "
>    397                          "(max: %u, align: %u)", mwindx, (unsigned
> int)outmw->size,
>    398                          (unsigned int)outmw->size_max,
>    399                          (unsigned int)outmw->size_align);
>    400                  return;
>    401          }
>    402
>    403          /* Read the DMA address, where the second DWORD is the
> upper part and
>    404           * the third DWORD - lower */
>    405          outmw->dma_addr = from_sh32(msg->payload[2]);
>    406  #ifdef CONFIG_64BIT
>  > 407          outmw->dma_addr |= ((dma_addr_t)from_sh32(msg->payload[1])
> << 32);
>    408  #endif /* CONFIG_64BIT */
>    409          /* Check whether the retrieved address is properly aligned
> */
>    410          if (!IS_ALIGNED(outmw->dma_addr, outmw->addr_align)) {
>    411                  dev_err_mw(ctx,
>    412                          "Outbound memory window address %p is not
> aligned "
>  > 413                          "within %u bytes", (void *)outmw->dma_addr,
>    414                          (unsigned int)outmw->addr_align);
>    415                  return;
>    416          }
>    417
>    418          /* Set the translation address of the outbound memory
> window */
>    419          sts = ntb_mw_set_trans(ctx->ntb, mwindx, outmw->dma_addr,
> outmw->size);
>    420          if (SUCCESS != sts) {
>    421                  dev_err_mw(ctx, "Failed to set the translated
> address %p of "
>    422                          "outbound memory window %d", (void
> *)outmw->dma_addr,
>    423                          mwindx);
>    424                  return;
>    425          }
>    426
>    427          /* Enable the memory window */
>    428          outmw->enabled = true;
>    429
>  > 430          dev_dbg_mw(ctx, "Outbound memory window %d is initialized
> with "
>  > 431                  "address 0x%p", mwindx, (void *)outmw->dma_addr);
>    432  }
>    433
>    434  /*
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology
> Center
> https://lists.01.org/pipermail/kbuild-all                   Intel
> Corporation
>

--001a114e72e4e95bcd0538b1f95d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+UGxlYXNlLCB0YWtlIGEgbG9vayBhdCB0aGUgbmV4dCBwYXRjaHNldC4g
SSYjMzk7dmUgYWxyZWFkeSBmaXhlZCB0aGVzZSBpc3N1ZXMgdGhlcmUuPGRpdj48YnI+PC9kaXY+
PGRpdj5SZWdhcmRzLDwvZGl2PjxkaXY+LVNlcmdleTwvZGl2PjwvZGl2PjxkaXYgY2xhc3M9Imdt
YWlsX2V4dHJhIj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPk9uIFRodSwgSnVsIDI4LCAy
MDE2IGF0IDM6NTggUE0sIGtidWlsZCB0ZXN0IHJvYm90IDxzcGFuIGRpcj0ibHRyIj4mbHQ7PGEg
aHJlZj0ibWFpbHRvOmxrcEBpbnRlbC5jb20iIHRhcmdldD0iX2JsYW5rIj5sa3BAaW50ZWwuY29t
PC9hPiZndDs8L3NwYW4+IHdyb3RlOjxicj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUi
IHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRk
aW5nLWxlZnQ6MWV4Ij5IaSw8YnI+DQo8YnI+DQpbYXV0byBidWlsZCB0ZXN0IFdBUk5JTkcgb24g
bnRiL250Yi1uZXh0XTxicj4NCltjYW5ub3QgYXBwbHkgdG8gdjQuNyBuZXh0LTIwMTYwNzI4XTxi
cj4NCltpZiB5b3VyIHBhdGNoIGlzIGFwcGxpZWQgdG8gdGhlIHdyb25nIGdpdCB0cmVlLCBwbGVh
c2UgZHJvcCB1cyBhIG5vdGUgdG8gaGVscCBpbXByb3ZlIHRoZSBzeXN0ZW1dPGJyPg0KPGJyPg0K
dXJsOsKgIMKgIDxhIGhyZWY9Imh0dHBzOi8vZ2l0aHViLmNvbS8wZGF5LWNpL2xpbnV4L2NvbW1p
dHMvU2VyZ2UtU2VtaW4vbnRiLUFzeW5jaHJvbm91cy1OVEItZGV2aWNlcy1zdXBwb3J0LzIwMTYw
NzI3LTA4MjAzMyIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly9naXRo
dWIuY29tLzBkYXktY2kvbGludXgvY29tbWl0cy9TZXJnZS1TZW1pbi9udGItQXN5bmNocm9ub3Vz
LU5UQi1kZXZpY2VzLXN1cHBvcnQvMjAxNjA3MjctMDgyMDMzPC9hPjxicj4NCmJhc2U6wqAgwqA8
YSBocmVmPSJodHRwczovL2dpdGh1Yi5jb20vam9ubWFzb24vbnRiIiByZWw9Im5vcmVmZXJyZXIi
IHRhcmdldD0iX2JsYW5rIj5odHRwczovL2dpdGh1Yi5jb20vam9ubWFzb24vbnRiPC9hPiBudGIt
bmV4dDxicj4NCmNvbmZpZzogc3BhcmM2NC1hbGx5ZXNjb25maWcgKGF0dGFjaGVkIGFzIC5jb25m
aWcpPGJyPg0KY29tcGlsZXI6IHNwYXJjNjQtbGludXgtZ251LWdjYyAoRGViaWFuIDUuNC4wLTYp
IDUuNC4wIDIwMTYwNjA5PGJyPg0KcmVwcm9kdWNlOjxicj4NCsKgIMKgIMKgIMKgIHdnZXQgPGEg
aHJlZj0iaHR0cHM6Ly9naXQua2VybmVsLm9yZy9jZ2l0L2xpbnV4L2tlcm5lbC9naXQvd2ZnL2xr
cC10ZXN0cy5naXQvcGxhaW4vc2Jpbi9tYWtlLmNyb3NzIiByZWw9Im5vcmVmZXJyZXIiIHRhcmdl
dD0iX2JsYW5rIj5odHRwczovL2dpdC5rZXJuZWwub3JnL2NnaXQvbGludXgva2VybmVsL2dpdC93
ZmcvbGtwLXRlc3RzLmdpdC9wbGFpbi9zYmluL21ha2UuY3Jvc3M8L2E+IC1PIH4vYmluL21ha2Uu
Y3Jvc3M8YnI+DQrCoCDCoCDCoCDCoCBjaG1vZCAreCB+L2Jpbi9tYWtlLmNyb3NzPGJyPg0KwqAg
wqAgwqAgwqAgIyBzYXZlIHRoZSBhdHRhY2hlZCAuY29uZmlnIHRvIGxpbnV4IGJ1aWxkIHRyZWU8
YnI+DQrCoCDCoCDCoCDCoCBtYWtlLmNyb3NzIEFSQ0g9c3BhcmM2NDxicj4NCjxicj4NCkFsbCB3
YXJuaW5ncyAobmV3IG9uZXMgcHJlZml4ZWQgYnkgJmd0OyZndDspOjxicj4NCjxicj4NCsKgIMKg
SW4gZmlsZSBpbmNsdWRlZCBmcm9tIGluY2x1ZGUvbGludXgvc3dhYi5oOjQ6MCw8YnI+DQrCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBmcm9tIGluY2x1ZGUvdWFwaS9saW51eC9ieXRlb3Jk
ZXIvYmlnX2VuZGlhbi5oOjEyLDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGZy
b20gaW5jbHVkZS9saW51eC9ieXRlb3JkZXIvYmlnX2VuZGlhbi5oOjQsPGJyPg0KwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgZnJvbSBhcmNoL3NwYXJjL2luY2x1ZGUvdWFwaS9hc20vYnl0
ZW9yZGVyLmg6NCw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBmcm9tIGFyY2gv
c3BhcmMvaW5jbHVkZS9hc20vYml0b3BzXzY0Lmg6MTUsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgZnJvbSBhcmNoL3NwYXJjL2luY2x1ZGUvYXNtL2JpdG9wcy5oOjQsPGJyPg0K
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZnJvbSBpbmNsdWRlL2xpbnV4L2JpdG9wcy5o
OjM2LDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGZyb20gaW5jbHVkZS9saW51
eC9rZXJuZWwuaDoxMCw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBmcm9tIGRy
aXZlcnMvbnRiL3Rlc3QvbnRiX213X3Rlc3QuYzo1Nzo8YnI+DQrCoCDCoGRyaXZlcnMvbnRiL3Rl
c3QvbnRiX213X3Rlc3QuYzogSW4gZnVuY3Rpb24gJiMzOTttd19zZW5kX2lubXdfYWRkcnMmIzM5
Ozo8YnI+DQomZ3Q7Jmd0OyBkcml2ZXJzL250Yi90ZXN0L250Yl9td190ZXN0LmM6MzUzOjQ5OiB3
YXJuaW5nOiByaWdodCBzaGlmdCBjb3VudCAmZ3Q7PSB3aWR0aCBvZiB0eXBlIFstV3NoaWZ0LWNv
dW50LW92ZXJmbG93XTxicj4NCjxzcGFuIGNsYXNzPSIiPsKgIMKgIMKgIG1zZy5wYXlsb2FkWzFd
ID0gdG9fc2gzMigodTMyKShpbm13LSZndDtkbWFfYWRkciAmZ3Q7Jmd0OyAzMikpOzxicj4NCjwv
c3Bhbj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBePGJyPg0KwqAgwqBpbmNsdWRlL3VhcGkvbGludXgv
c3dhYi5oOjExNjozMjogbm90ZTogaW4gZGVmaW5pdGlvbiBvZiBtYWNybyAmIzM5O19fc3dhYjMy
JiMzOTs8YnI+DQrCoCDCoCDCoChfX2J1aWx0aW5fY29uc3RhbnRfcCgoX191MzIpKHgpKSA/IFw8
YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oF48YnI+DQrCoCDCoGluY2x1ZGUvbGludXgvYnl0ZW9yZGVyL2dlbmVyaWMuaDo4NzoyMTogbm90
ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvICYjMzk7X19jcHVfdG9fbGUzMiYjMzk7PGJyPg0KwqAg
wqAgI2RlZmluZSBjcHVfdG9fbGUzMiBfX2NwdV90b19sZTMyPGJyPg0KwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgXjxicj4NCiZndDsmZ3Q7IGRyaXZlcnMvbnRiL3Rlc3QvbnRi
X213X3Rlc3QuYzozNTM6MjA6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyAmIzM5O3RvX3No
MzImIzM5Ozxicj4NCjxzcGFuIGNsYXNzPSIiPsKgIMKgIMKgIG1zZy5wYXlsb2FkWzFdID0gdG9f
c2gzMigodTMyKShpbm13LSZndDtkbWFfYWRkciAmZ3Q7Jmd0OyAzMikpOzxicj4NCjwvc3Bhbj7C
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoF48YnI+DQomZ3Q7Jmd0OyBkcml2ZXJz
L250Yi90ZXN0L250Yl9td190ZXN0LmM6MzUzOjQ5OiB3YXJuaW5nOiByaWdodCBzaGlmdCBjb3Vu
dCAmZ3Q7PSB3aWR0aCBvZiB0eXBlIFstV3NoaWZ0LWNvdW50LW92ZXJmbG93XTxicj4NCjxzcGFu
IGNsYXNzPSIiPsKgIMKgIMKgIG1zZy5wYXlsb2FkWzFdID0gdG9fc2gzMigodTMyKShpbm13LSZn
dDtkbWFfYWRkciAmZ3Q7Jmd0OyAzMikpOzxicj4NCjwvc3Bhbj7CoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCBePGJyPg0KwqAgwqBpbmNsdWRlL3VhcGkvbGludXgvc3dhYi5oOjE3OjEyOiBub3RlOiBpbiBk
ZWZpbml0aW9uIG9mIG1hY3JvICYjMzk7X19fY29uc3RhbnRfc3dhYjMyJiMzOTs8YnI+DQrCoCDC
oCDCoCgoKF9fdTMyKSh4KSAmYW1wOyAoX191MzIpMHgwMDAwMDBmZlVMKSAmbHQ7Jmx0OyAyNCkg
fMKgIFw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoF48YnI+DQrCoCDCoGluY2x1ZGUvdWFw
aS9saW51eC9ieXRlb3JkZXIvYmlnX2VuZGlhbi5oOjMyOjQzOiBub3RlOiBpbiBleHBhbnNpb24g
b2YgbWFjcm8gJiMzOTtfX3N3YWIzMiYjMzk7PGJyPg0KwqAgwqAgI2RlZmluZSBfX2NwdV90b19s
ZTMyKHgpICgoX19mb3JjZSBfX2xlMzIpX19zd2FiMzIoKHgpKSk8YnI+DQrCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBe
PGJyPg0KwqAgwqBpbmNsdWRlL2xpbnV4L2J5dGVvcmRlci9nZW5lcmljLmg6ODc6MjE6IG5vdGU6
IGluIGV4cGFuc2lvbiBvZiBtYWNybyAmIzM5O19fY3B1X3RvX2xlMzImIzM5Ozxicj4NCsKgIMKg
ICNkZWZpbmUgY3B1X3RvX2xlMzIgX19jcHVfdG9fbGUzMjxicj4NCsKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIF48YnI+DQomZ3Q7Jmd0OyBkcml2ZXJzL250Yi90ZXN0L250Yl9t
d190ZXN0LmM6MzUzOjIwOiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8gJiMzOTt0b19zaDMy
JiMzOTs8YnI+DQo8c3BhbiBjbGFzcz0iIj7CoCDCoCDCoCBtc2cucGF5bG9hZFsxXSA9IHRvX3No
MzIoKHUzMikoaW5tdy0mZ3Q7ZG1hX2FkZHIgJmd0OyZndDsgMzIpKTs8YnI+DQo8L3NwYW4+wqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBePGJyPg0KJmd0OyZndDsgZHJpdmVycy9u
dGIvdGVzdC9udGJfbXdfdGVzdC5jOjM1Mzo0OTogd2FybmluZzogcmlnaHQgc2hpZnQgY291bnQg
Jmd0Oz0gd2lkdGggb2YgdHlwZSBbLVdzaGlmdC1jb3VudC1vdmVyZmxvd108YnI+DQo8c3BhbiBj
bGFzcz0iIj7CoCDCoCDCoCBtc2cucGF5bG9hZFsxXSA9IHRvX3NoMzIoKHUzMikoaW5tdy0mZ3Q7
ZG1hX2FkZHIgJmd0OyZndDsgMzIpKTs8YnI+DQo8L3NwYW4+wqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
Xjxicj4NCsKgIMKgaW5jbHVkZS91YXBpL2xpbnV4L3N3YWIuaDoxODoxMjogbm90ZTogaW4gZGVm
aW5pdGlvbiBvZiBtYWNybyAmIzM5O19fX2NvbnN0YW50X3N3YWIzMiYjMzk7PGJyPg0KwqAgwqAg
wqAoKChfX3UzMikoeCkgJmFtcDsgKF9fdTMyKTB4MDAwMGZmMDBVTCkgJmx0OyZsdDvCoCA4KSB8
wqAgXDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXjxicj4NCsKgIMKgaW5jbHVkZS91YXBp
L2xpbnV4L2J5dGVvcmRlci9iaWdfZW5kaWFuLmg6MzI6NDM6IG5vdGU6IGluIGV4cGFuc2lvbiBv
ZiBtYWNybyAmIzM5O19fc3dhYjMyJiMzOTs8YnI+DQrCoCDCoCAjZGVmaW5lIF9fY3B1X3RvX2xl
MzIoeCkgKChfX2ZvcmNlIF9fbGUzMilfX3N3YWIzMigoeCkpKTxicj4NCsKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIF48
YnI+DQrCoCDCoGluY2x1ZGUvbGludXgvYnl0ZW9yZGVyL2dlbmVyaWMuaDo4NzoyMTogbm90ZTog
aW4gZXhwYW5zaW9uIG9mIG1hY3JvICYjMzk7X19jcHVfdG9fbGUzMiYjMzk7PGJyPg0KwqAgwqAg
I2RlZmluZSBjcHVfdG9fbGUzMiBfX2NwdV90b19sZTMyPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgXjxicj4NCiZndDsmZ3Q7IGRyaXZlcnMvbnRiL3Rlc3QvbnRiX213
X3Rlc3QuYzozNTM6MjA6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyAmIzM5O3RvX3NoMzIm
IzM5Ozxicj4NCjxzcGFuIGNsYXNzPSIiPsKgIMKgIMKgIG1zZy5wYXlsb2FkWzFdID0gdG9fc2gz
MigodTMyKShpbm13LSZndDtkbWFfYWRkciAmZ3Q7Jmd0OyAzMikpOzxicj4NCjwvc3Bhbj7CoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoF48YnI+DQomZ3Q7Jmd0OyBkcml2ZXJzL250
Yi90ZXN0L250Yl9td190ZXN0LmM6MzUzOjQ5OiB3YXJuaW5nOiByaWdodCBzaGlmdCBjb3VudCAm
Z3Q7PSB3aWR0aCBvZiB0eXBlIFstV3NoaWZ0LWNvdW50LW92ZXJmbG93XTxicj4NCjxzcGFuIGNs
YXNzPSIiPsKgIMKgIMKgIG1zZy5wYXlsb2FkWzFdID0gdG9fc2gzMigodTMyKShpbm13LSZndDtk
bWFfYWRkciAmZ3Q7Jmd0OyAzMikpOzxicj4NCjwvc3Bhbj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBe
PGJyPg0KwqAgwqBpbmNsdWRlL3VhcGkvbGludXgvc3dhYi5oOjE5OjEyOiBub3RlOiBpbiBkZWZp
bml0aW9uIG9mIG1hY3JvICYjMzk7X19fY29uc3RhbnRfc3dhYjMyJiMzOTs8YnI+DQrCoCDCoCDC
oCgoKF9fdTMyKSh4KSAmYW1wOyAoX191MzIpMHgwMGZmMDAwMFVMKSAmZ3Q7Jmd0O8KgIDgpIHzC
oCBcPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBePGJyPg0KwqAgwqBpbmNsdWRlL3VhcGkv
bGludXgvYnl0ZW9yZGVyL2JpZ19lbmRpYW4uaDozMjo0Mzogbm90ZTogaW4gZXhwYW5zaW9uIG9m
IG1hY3JvICYjMzk7X19zd2FiMzImIzM5Ozxicj4NCsKgIMKgICNkZWZpbmUgX19jcHVfdG9fbGUz
Mih4KSAoKF9fZm9yY2UgX19sZTMyKV9fc3dhYjMyKCh4KSkpPGJyPg0KwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXjxi
cj4NCsKgIMKgaW5jbHVkZS9saW51eC9ieXRlb3JkZXIvZ2VuZXJpYy5oOjg3OjIxOiBub3RlOiBp
biBleHBhbnNpb24gb2YgbWFjcm8gJiMzOTtfX2NwdV90b19sZTMyJiMzOTs8YnI+DQrCoCDCoCAj
ZGVmaW5lIGNwdV90b19sZTMyIF9fY3B1X3RvX2xlMzI8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBePGJyPg0KJmd0OyZndDsgZHJpdmVycy9udGIvdGVzdC9udGJfbXdf
dGVzdC5jOjM1MzoyMDogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvICYjMzk7dG9fc2gzMiYj
Mzk7PGJyPg0KPHNwYW4gY2xhc3M9IiI+wqAgwqAgwqAgbXNnLnBheWxvYWRbMV0gPSB0b19zaDMy
KCh1MzIpKGlubXctJmd0O2RtYV9hZGRyICZndDsmZ3Q7IDMyKSk7PGJyPg0KPC9zcGFuPsKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXjxicj4NCiZndDsmZ3Q7IGRyaXZlcnMvbnRi
L3Rlc3QvbnRiX213X3Rlc3QuYzozNTM6NDk6IHdhcm5pbmc6IHJpZ2h0IHNoaWZ0IGNvdW50ICZn
dDs9IHdpZHRoIG9mIHR5cGUgWy1Xc2hpZnQtY291bnQtb3ZlcmZsb3ddPGJyPg0KPHNwYW4gY2xh
c3M9IiI+wqAgwqAgwqAgbXNnLnBheWxvYWRbMV0gPSB0b19zaDMyKCh1MzIpKGlubXctJmd0O2Rt
YV9hZGRyICZndDsmZ3Q7IDMyKSk7PGJyPg0KPC9zcGFuPsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIF48
YnI+DQrCoCDCoGluY2x1ZGUvdWFwaS9saW51eC9zd2FiLmg6MjA6MTI6IG5vdGU6IGluIGRlZmlu
aXRpb24gb2YgbWFjcm8gJiMzOTtfX19jb25zdGFudF9zd2FiMzImIzM5Ozxicj4NCsKgIMKgIMKg
KCgoX191MzIpKHgpICZhbXA7IChfX3UzMikweGZmMDAwMDAwVUwpICZndDsmZ3Q7IDI0KSkpPGJy
Pg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBePGJyPg0KwqAgwqBpbmNsdWRlL3VhcGkvbGludXgv
Ynl0ZW9yZGVyL2JpZ19lbmRpYW4uaDozMjo0Mzogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3Jv
ICYjMzk7X19zd2FiMzImIzM5Ozxicj4NCsKgIMKgICNkZWZpbmUgX19jcHVfdG9fbGUzMih4KSAo
KF9fZm9yY2UgX19sZTMyKV9fc3dhYjMyKCh4KSkpPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXjxicj4NCsKg
IMKgaW5jbHVkZS9saW51eC9ieXRlb3JkZXIvZ2VuZXJpYy5oOjg3OjIxOiBub3RlOiBpbiBleHBh
bnNpb24gb2YgbWFjcm8gJiMzOTtfX2NwdV90b19sZTMyJiMzOTs8YnI+DQrCoCDCoCAjZGVmaW5l
IGNwdV90b19sZTMyIF9fY3B1X3RvX2xlMzI8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBePGJyPg0KJmd0OyZndDsgZHJpdmVycy9udGIvdGVzdC9udGJfbXdfdGVzdC5j
OjM1MzoyMDogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvICYjMzk7dG9fc2gzMiYjMzk7PGJy
Pg0KPHNwYW4gY2xhc3M9IiI+wqAgwqAgwqAgbXNnLnBheWxvYWRbMV0gPSB0b19zaDMyKCh1MzIp
KGlubXctJmd0O2RtYV9hZGRyICZndDsmZ3Q7IDMyKSk7PGJyPg0KPC9zcGFuPsKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXjxicj4NCiZndDsmZ3Q7IGRyaXZlcnMvbnRiL3Rlc3Qv
bnRiX213X3Rlc3QuYzozNTM6NDk6IHdhcm5pbmc6IHJpZ2h0IHNoaWZ0IGNvdW50ICZndDs9IHdp
ZHRoIG9mIHR5cGUgWy1Xc2hpZnQtY291bnQtb3ZlcmZsb3ddPGJyPg0KPHNwYW4gY2xhc3M9IiI+
wqAgwqAgwqAgbXNnLnBheWxvYWRbMV0gPSB0b19zaDMyKCh1MzIpKGlubXctJmd0O2RtYV9hZGRy
ICZndDsmZ3Q7IDMyKSk7PGJyPg0KPC9zcGFuPsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIF48YnI+DQrC
oCDCoGluY2x1ZGUvdWFwaS9saW51eC9zd2FiLmg6MTE4OjEyOiBub3RlOiBpbiBkZWZpbml0aW9u
IG9mIG1hY3JvICYjMzk7X19zd2FiMzImIzM5Ozxicj4NCsKgIMKgIMKgX19mc3dhYjMyKHgpKTxi
cj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgXjxicj4NCsKgIMKgaW5jbHVkZS9saW51eC9ieXRl
b3JkZXIvZ2VuZXJpYy5oOjg3OjIxOiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8gJiMzOTtf
X2NwdV90b19sZTMyJiMzOTs8YnI+DQrCoCDCoCAjZGVmaW5lIGNwdV90b19sZTMyIF9fY3B1X3Rv
X2xlMzI8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBePGJyPg0KJmd0
OyZndDsgZHJpdmVycy9udGIvdGVzdC9udGJfbXdfdGVzdC5jOjM1MzoyMDogbm90ZTogaW4gZXhw
YW5zaW9uIG9mIG1hY3JvICYjMzk7dG9fc2gzMiYjMzk7PGJyPg0KPHNwYW4gY2xhc3M9IiI+wqAg
wqAgwqAgbXNnLnBheWxvYWRbMV0gPSB0b19zaDMyKCh1MzIpKGlubXctJmd0O2RtYV9hZGRyICZn
dDsmZ3Q7IDMyKSk7PGJyPg0KPC9zcGFuPsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgXjxicj4NCsKgIMKgZHJpdmVycy9udGIvdGVzdC9udGJfbXdfdGVzdC5jOiBJbiBmdW5jdGlv
biAmIzM5O213X3NldF9vdXRtd19hZGRyJiMzOTs6PGJyPg0KJmd0OyZndDsgZHJpdmVycy9udGIv
dGVzdC9udGJfbXdfdGVzdC5jOjQwNzo2MTogd2FybmluZzogbGVmdCBzaGlmdCBjb3VudCAmZ3Q7
PSB3aWR0aCBvZiB0eXBlIFstV3NoaWZ0LWNvdW50LW92ZXJmbG93XTxicj4NCjxzcGFuIGNsYXNz
PSIiPsKgIMKgIMKgb3V0bXctJmd0O2RtYV9hZGRyIHw9ICgoZG1hX2FkZHJfdClmcm9tX3NoMzIo
bXNnLSZndDtwYXlsb2FkWzFdKSAmbHQ7Jmx0OyAzMik7PGJyPg0KPC9zcGFuPsKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIF48YnI+DQomZ3Q7Jmd0OyBkcml2ZXJzL250Yi90
ZXN0L250Yl9td190ZXN0LmM6NDEzOjIzOiB3YXJuaW5nOiBjYXN0IHRvIHBvaW50ZXIgZnJvbSBp
bnRlZ2VyIG9mIGRpZmZlcmVudCBzaXplIFstV2ludC10by1wb2ludGVyLWNhc3RdPGJyPg0KPHNw
YW4gY2xhc3M9IiI+wqAgwqAgwqAgwqAmcXVvdDt3aXRoaW4gJXUgYnl0ZXMmcXVvdDssICh2b2lk
ICopb3V0bXctJmd0O2RtYV9hZGRyLDxicj4NCjwvc3Bhbj7CoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBePGJyPg0KwqAgwqBkcml2ZXJzL250Yi90ZXN0L250Yl9td190ZXN0
LmM6MTg5OjI5OiBub3RlOiBpbiBkZWZpbml0aW9uIG9mIG1hY3JvICYjMzk7ZGV2X2Vycl9tdyYj
Mzk7PGJyPg0KPHNwYW4gY2xhc3M9IiI+wqAgwqAgwqBkZXZfZXJyKCZhbXA7Y3R4LSZndDtudGIt
Jmd0O2RldiwgIyMgYXJncyk8YnI+DQo8L3NwYW4+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgXjxicj4NCsKgIMKgZHJpdmVycy9udGIvdGVzdC9udGJfbXdf
dGVzdC5jOjQyMjozMzogd2FybmluZzogY2FzdCB0byBwb2ludGVyIGZyb20gaW50ZWdlciBvZiBk
aWZmZXJlbnQgc2l6ZSBbLVdpbnQtdG8tcG9pbnRlci1jYXN0XTxicj4NCjxzcGFuIGNsYXNzPSIi
PsKgIMKgIMKgIMKgJnF1b3Q7b3V0Ym91bmQgbWVtb3J5IHdpbmRvdyAlZCZxdW90OywgKHZvaWQg
KilvdXRtdy0mZ3Q7ZG1hX2FkZHIsPGJyPg0KPC9zcGFuPsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIF48YnI+DQrCoCDCoGRyaXZlcnMvbnRiL3Rl
c3QvbnRiX213X3Rlc3QuYzoxODk6Mjk6IG5vdGU6IGluIGRlZmluaXRpb24gb2YgbWFjcm8gJiMz
OTtkZXZfZXJyX213JiMzOTs8YnI+DQo8c3BhbiBjbGFzcz0iIj7CoCDCoCDCoGRldl9lcnIoJmFt
cDtjdHgtJmd0O250Yi0mZ3Q7ZGV2LCAjIyBhcmdzKTxicj4NCjwvc3Bhbj7CoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBePGJyPg0KwqAgwqBJbiBmaWxlIGlu
Y2x1ZGVkIGZyb20gaW5jbHVkZS9saW51eC9wcmludGsuaDoyODk6MCw8YnI+DQrCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBmcm9tIGluY2x1ZGUvbGludXgva2VybmVsLmg6MTMsPGJyPg0K
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZnJvbSBkcml2ZXJzL250Yi90ZXN0L250Yl9t
d190ZXN0LmM6NTc6PGJyPg0KwqAgwqBkcml2ZXJzL250Yi90ZXN0L250Yl9td190ZXN0LmM6NDMx
OjI3OiB3YXJuaW5nOiBjYXN0IHRvIHBvaW50ZXIgZnJvbSBpbnRlZ2VyIG9mIGRpZmZlcmVudCBz
aXplIFstV2ludC10by1wb2ludGVyLWNhc3RdPGJyPg0KPHNwYW4gY2xhc3M9IiI+wqAgwqAgwqAg
JnF1b3Q7YWRkcmVzcyAweCVwJnF1b3Q7LCBtd2luZHgsICh2b2lkICopb3V0bXctJmd0O2RtYV9h
ZGRyKTs8YnI+DQo8L3NwYW4+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgXjxicj4NCsKgIMKgaW5jbHVkZS9saW51eC9keW5hbWljX2RlYnVnLmg6ODc6OTogbm90
ZTogaW4gZGVmaW5pdGlvbiBvZiBtYWNybyAmIzM5O2R5bmFtaWNfZGV2X2RiZyYjMzk7PGJyPg0K
wqAgwqAgwqAgwqAgwqAgIyNfX1ZBX0FSR1NfXyk7wqAgXDxicj4NCsKgIMKgIMKgIMKgIMKgIMKg
IF48YnI+DQomZ3Q7Jmd0OyBkcml2ZXJzL250Yi90ZXN0L250Yl9td190ZXN0LmM6MTk1OjI6IG5v
dGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyAmIzM5O2Rldl9kYmcmIzM5Ozxicj4NCjxzcGFuIGNs
YXNzPSIiPsKgIMKgIMKgZGV2X2RiZygmYW1wO2N0eC0mZ3Q7bnRiLSZndDtkZXYsICMjIGFyZ3Mp
PGJyPg0KPC9zcGFuPsKgIMKgIMKgXjxicj4NCiZndDsmZ3Q7IGRyaXZlcnMvbnRiL3Rlc3QvbnRi
X213X3Rlc3QuYzo0MzA6Mjogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvICYjMzk7ZGV2X2Ri
Z19tdyYjMzk7PGJyPg0KPHNwYW4gY2xhc3M9IiI+wqAgwqAgwqBkZXZfZGJnX213KGN0eCwgJnF1
b3Q7T3V0Ym91bmQgbWVtb3J5IHdpbmRvdyAlZCBpcyBpbml0aWFsaXplZCB3aXRoICZxdW90Ozxi
cj4NCjwvc3Bhbj7CoCDCoCDCoF48YnI+DQrCoCDCoGRyaXZlcnMvbnRiL3Rlc3QvbnRiX213X3Rl
c3QuYzogSW4gZnVuY3Rpb24gJiMzOTttd19kYmdmc19vdXRtd19jZmdfcmVhZCYjMzk7Ojxicj4N
CsKgIMKgZHJpdmVycy9udGIvdGVzdC9udGJfbXdfdGVzdC5jOjc2NjozMDogd2FybmluZzogY2Fz
dCB0byBwb2ludGVyIGZyb20gaW50ZWdlciBvZiBkaWZmZXJlbnQgc2l6ZSBbLVdpbnQtdG8tcG9p
bnRlci1jYXN0XTxicj4NCjxzcGFuIGNsYXNzPSIiPsKgIMKgIMKgICZxdW90O0RNQSBhZGRyZXNz
XHRcdC0gMHglcFxuJnF1b3Q7LCAodm9pZCAqKXdyYXAtJmd0O2RtYV9hZGRyKTs8YnI+DQo8L3Nw
YW4+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBePGJy
Pg0KwqAgwqBkcml2ZXJzL250Yi90ZXN0L250Yl9td190ZXN0LmM6IEluIGZ1bmN0aW9uICYjMzk7
bXdfZGJnZnNfaW5td19jZmdfcmVhZCYjMzk7Ojxicj4NCsKgIMKgZHJpdmVycy9udGIvdGVzdC9u
dGJfbXdfdGVzdC5jOjkxNTozMDogd2FybmluZzogY2FzdCB0byBwb2ludGVyIGZyb20gaW50ZWdl
ciBvZiBkaWZmZXJlbnQgc2l6ZSBbLVdpbnQtdG8tcG9pbnRlci1jYXN0XTxicj4NCjxzcGFuIGNs
YXNzPSIiPsKgIMKgIMKgICZxdW90O0RNQSBhZGRyZXNzXHRcdC0gMHglcFxuJnF1b3Q7LCAodm9p
ZCAqKXdyYXAtJmd0O2RtYV9hZGRyKTs8YnI+DQo8L3NwYW4+wqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBePGJyPg0KwqAgwqBkcml2ZXJzL250Yi90ZXN0
L250Yl9td190ZXN0LmM6IEluIGZ1bmN0aW9uICYjMzk7bXdfY3JlYXRlX2lubXdzJiMzOTs6PGJy
Pg0KwqAgwqBkcml2ZXJzL250Yi90ZXN0L250Yl9td190ZXN0LmM6MTE5NzoyNTogd2FybmluZzog
Y2FzdCB0byBwb2ludGVyIGZyb20gaW50ZWdlciBvZiBkaWZmZXJlbnQgc2l6ZSBbLVdpbnQtdG8t
cG9pbnRlci1jYXN0XTxicj4NCjxzcGFuIGNsYXNzPSIiPsKgIMKgIMKgIMKgICZxdW90O2FsaWdu
ZWQgd2l0aCAlbHUmcXVvdDssICh2b2lkICopaW5tdy0mZ3Q7ZG1hX2FkZHIsIG13aW5keCw8YnI+
DQo8L3NwYW4+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgXjxicj4N
CsKgIMKgZHJpdmVycy9udGIvdGVzdC9udGJfbXdfdGVzdC5jOjE4OToyOTogbm90ZTogaW4gZGVm
aW5pdGlvbiBvZiBtYWNybyAmIzM5O2Rldl9lcnJfbXcmIzM5Ozxicj4NCjxzcGFuIGNsYXNzPSIi
PsKgIMKgIMKgZGV2X2VycigmYW1wO2N0eC0mZ3Q7bnRiLSZndDtkZXYsICMjIGFyZ3MpPGJyPg0K
PC9zcGFuPsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIF48
YnI+DQo8YnI+DQp2aW0gKzM1MyBkcml2ZXJzL250Yi90ZXN0L250Yl9td190ZXN0LmM8YnI+DQo8
YnI+DQrCoCDCoDE4OcKgIMKgIMKgIMKgIMKgIGRldl9lcnIoJmFtcDtjdHgtJmd0O250Yi0mZ3Q7
ZGV2LCAjIyBhcmdzKTxicj4NCsKgIMKgMTkwwqAgI2RlZmluZSBkZXZfd2Fybl9tdyhjdHgsIGFy
Z3MuLi4pIFw8YnI+DQrCoCDCoDE5McKgIMKgIMKgIMKgIMKgIGRldl93YXJuKCZhbXA7Y3R4LSZn
dDtudGItJmd0O2RldiwgIyMgYXJncyk8YnI+DQrCoCDCoDE5MsKgICNkZWZpbmUgZGV2X2luZm9f
bXcoY3R4LCBhcmdzLi4uKSBcPGJyPg0KwqAgwqAxOTPCoCDCoCDCoCDCoCDCoCBkZXZfaW5mbygm
YW1wO2N0eC0mZ3Q7bnRiLSZndDtkZXYsICMjIGFyZ3MpPGJyPg0KwqAgwqAxOTTCoCAjZGVmaW5l
IGRldl9kYmdfbXcoY3R4LCBhcmdzLi4uKSBcPGJyPg0KwqAmZ3Q7IDE5NcKgIMKgIMKgIMKgIMKg
IGRldl9kYmcoJmFtcDtjdHgtJmd0O250Yi0mZ3Q7ZGV2LCAjIyBhcmdzKTxicj4NCsKgIMKgMTk2
PGJyPg0KwqAgwqAxOTfCoCAvKjxicj4NCsKgIMKgMTk4wqAgwqAqIFNvbWUgY29tbW9uIGNvbnN0
YW50IHVzZWQgaW4gdGhlIGRyaXZlciBmb3IgYmV0dGVyIHJlYWRhYmlsaXR5Ojxicj4NCsKgIMKg
MTk5wqAgwqAqIEBPTjogRW5hYmxlIHNvbWV0aGluZzxicj4NCsKgIMKgMjAwwqAgwqAqIEBPRkY6
IERpc2FibGUgc29tZXRoaW5nPGJyPg0KwqAgwqAyMDHCoCDCoCogQFNVQ0NFU1M6IFN1Y2Nlc3Mg
b2YgYSBmdW5jdGlvbiBleGVjdXRpb248YnI+DQrCoCDCoDIwMsKgIMKgKiBATUlOX01XX0NOVDog
TWluaW11bSBtZW1vcnkgd2luZG93cyBjb3VudDxicj4NCsKgIMKgMjAzwqAgwqAqIEBNQVhfTVdf
Q05UOiBNYXhpbXVtIG1lbW9yeSB3aW5kb3dzIGNvdW50PGJyPg0KwqAgwqAyMDTCoCDCoCovPGJy
Pg0KwqAgwqAyMDXCoCAjZGVmaW5lIE9OICgodTMyKTB4MSk8YnI+DQrCoCDCoDIwNsKgICNkZWZp
bmUgT0ZGICgodTMyKTB4MCk8YnI+DQrCoCDCoDIwN8KgICNkZWZpbmUgU1VDQ0VTUyAwPGJyPg0K
wqAgwqAyMDjCoCAjZGVmaW5lIE1JTl9NV19DTlQgKCh1bnNpZ25lZCBjaGFyKTEpPGJyPg0KwqAg
wqAyMDnCoCAjZGVmaW5lIE1BWF9NV19DTlQgKCh1bnNpZ25lZCBjaGFyKTI1NSk8YnI+DQrCoCDC
oDIxMDxicj4NCsKgIMKgMjExwqAgLyo8YnI+DQrCoCDCoDIxMsKgIMKgKiBTaGFyZWQgZGF0YSBj
b252ZXJ0ZXIgdG8gc3VwcG9ydCB0aGUgZGlmZmVyZW50IENQVSBhcmNoaXRlY3R1cmVzPGJyPg0K
wqAgwqAyMTPCoCDCoCovPGJyPg0KwqAgwqAyMTTCoCAjZGVmaW5lIHRvX3NoMzIoZGF0YSkgXDxi
cj4NCsKgIMKgMjE1wqAgwqAgwqAgwqAgwqAgY3B1X3RvX2xlMzIoKGRhdGEpKTxicj4NCsKgIMKg
MjE2wqAgI2RlZmluZSBmcm9tX3NoMzIoZGF0YSkgXDxicj4NCsKgIMKgMjE3wqAgwqAgwqAgwqAg
wqAgbGUzMl90b19jcHUoKGRhdGEpKTxicj4NCsKgIMKgMjE4PGJyPg0KwqAgwqAyMTnCoCAvKjxi
cj4NCsKgIMKgMjIwwqAgwqAqIE1vZHVsZSBwYXJhbWV0ZXJzOjxicj4NCsKgIMKgMjIxwqAgwqAq
IEBpbm13X2NudDrCoCDCoE51bWJlciBvZiBpbmJvdW5kIG1lbW9yeSB3aW5kb3dzIFsxOyAyNTVd
PGJyPg0KwqAgwqAyMjLCoCDCoCogQG91dG13X2NudDrCoCBOdW1iZXIgb2Ygb3V0Ym91bmQgbWVt
b3J5IHdpbmRvd3MgWzE7IDI1NV08YnI+DQrCoCDCoDIyM8KgIMKgKiBJZiB0aGUgc3BlY2lmaWVk
IHZhbHVlIGV4Y2VlZHMgdGhlIG1heGltdW0gcG9zc2libGUgdmFsaXVlLCB0aGVuIGl0IGlzPGJy
Pg0KwqAgwqAyMjTCoCDCoCogaW5pdGlhbGl6ZWQgd2l0aCBtYXhpbXVtIG9uZTxicj4NCsKgIMKg
MjI1wqAgwqAqLzxicj4NCsKgIMKgMjI2wqAgc3RhdGljIHVuc2lnbmVkIGNoYXIgaW5td3NfY250
ID0gTUFYX01XX0NOVDs8YnI+DQrCoCDCoDIyN8KgIG1vZHVsZV9wYXJhbShpbm13c19jbnQsIGJ5
dGUsIDAwMDApOzxicj4NCsKgIMKgMjI4wqAgTU9EVUxFX1BBUk1fREVTQyhpbm13c19jbnQsPGJy
Pg0KwqAgwqAyMjnCoCDCoCDCoCDCoCDCoCAmcXVvdDtJbmJvdW5kIG1lbW9yeSB3aW5kb3dzIGNv
dW50LiBUaG9zZSBhcmUgdGhlIG1lbW9yeSB3aW5kb3dzLCB3aGljaCBhcmUgJnF1b3Q7PGJyPg0K
wqAgwqAyMzDCoCDCoCDCoCDCoCDCoCAmcXVvdDtsb2NhbGx5IGFsbG9jYXRlZC4gVGhlaXIgYWRk
cmVzcyBpcyBzZW50IHRvIHRoZSByZW1vdGUgaG9zdC4mcXVvdDs8YnI+DQrCoCDCoDIzMcKgIMKg
IMKgIMKgIMKgICZxdW90OyAtIFBhcmFtZXRlciBjYW4gYmUgc2V0IHdpdGhpbiBbMTsgMjU1XSwg
d2hlcmUgMjU1IG1lYW5zIG1heGltdW0gcG9zc2libGUmcXVvdDs8YnI+DQrCoCDCoDIzMsKgIMKg
IMKgIMKgIMKgICZxdW90O8KgIMKgbnVtYmVyIG9mIHdpbmRvd3MmcXVvdDspOzxicj4NCsKgIMKg
MjMzPGJyPg0KwqAgwqAyMzTCoCAvKj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PTxicj4NCsKgIMKgMjM1wqAg
wqAqwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBIZWxwZXIg
bWV0aG9kczxicj4NCsKgIMKgMjM2wqAgwqAqPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ki88YnI+DQrCoCDC
oDIzNzxicj4NCsKgIMKgMjM4wqAgLyo8YnI+DQrCoCDCoDIzOcKgIMKgKiBBbHRlciB0aGUgcGFz
c2VkIGRyaXZlciBwYXJlbWV0ZXJzPGJyPg0KwqAgwqAyNDDCoCDCoCovPGJyPg0KwqAgwqAyNDHC
oCBzdGF0aWMgdm9pZCBtd19hbHRlcl9wYXJhbXMoc3RydWN0IG13X2N0eCAqY3R4KTxicj4NCsKg
IMKgMjQywqAgezxicj4NCsKgIMKgMjQzwqAgwqAgwqAgwqAgwqAgdW5zaWduZWQgY2hhciBpbm13
c19jbnRfYmFrID0gY3R4LSZndDtpbm13c19jbnQ7PGJyPg0KwqAgwqAyNDQ8YnI+DQrCoCDCoDI0
NcKgIMKgIMKgIMKgIMKgIC8qIENsYW1wIHRoZSBpbmJvdW5kIG1lbW9yeSB3aW5kb3dzIHBhcmFt
ZXRlciAqLzxicj4NCsKgIMKgMjQ2wqAgwqAgwqAgwqAgwqAgY3R4LSZndDtpbm13c19jbnQgPSBj
bGFtcChpbm13c19jbnQsPGJyPg0KwqAgwqAyNDfCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBN
SU5fTVdfQ05ULCAodW5zaWduZWQgY2hhciljdHgtJmd0O2lubXdzX2NudCk7PGJyPg0KwqAgwqAy
NDjCoCDCoCDCoCDCoCDCoCBpZiAoaW5td3NfY250X2JhayAhPSBjdHgtJmd0O2lubXdzX2NudCkg
ezxicj4NCsKgIMKgMjQ5wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZGV2X3dhcm5fbXcoY3R4
LDxicj4NCsKgIMKgMjUwwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJnF1
b3Q7SW5ib3VuZCBtZW1vcnkgd2luZG93cyBjb3VudCBpcyBhbHRlcmVkIGZyb20gJnF1b3Q7PGJy
Pg0KwqAgwqAyNTHCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmcXVvdDsl
aGh1IHRvICVoaHUmcXVvdDssIGlubXdzX2NudF9iYWssIGN0eC0mZ3Q7aW5td3NfY250KTs8YnI+
DQrCoCDCoDI1MsKgIMKgIMKgIMKgIMKgIH08YnI+DQrCoCDCoDI1Mzxicj4NCsKgIMKgMjU0wqAg
wqAgwqAgwqAgwqAgZGV2X2RiZ19tdyhjdHgsICZxdW90O01lbW9yeSB3aW5kb3dzIHRlc3QgZHJp
dmVyIHBhcmFtZXRlciBpcyB2ZXJpZmllZCZxdW90Oyk7PGJyPg0KwqAgwqAyNTXCoCB9PGJyPg0K
wqAgwqAyNTY8YnI+DQrCoCDCoDI1N8KgIC8qPGJyPg0KwqAgwqAyNTjCoCDCoCogTWVtb3J5IGJs
b2NrIElPIHdyaXRlIG1ldGhvZDxicj4NCsKgIMKgMjU5wqAgwqAqLzxicj4NCsKgIMKgMjYwwqAg
c3RhdGljIHZvaWQgaW9tZW1fd3JpdGUodm9pZCBfX2lvbWVtICpkc3QsIGNvbnN0IHZvaWQgKnNy
Yywgc2l6ZV90IGNudCk8YnI+DQrCoCDCoDI2McKgIHs8YnI+DQrCoCDCoDI2MsKgIMKgIMKgIMKg
IMKgIHdoaWxlIChjbnQtLSkgezxicj4NCsKgIMKgMjYzwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgaW93cml0ZTgoKih1OCAqKXNyYywgZHN0KTs8YnI+DQrCoCDCoDI2NMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIGRzdCsrOzxicj4NCsKgIMKgMjY1wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgc3JjKys7PGJyPg0KwqAgwqAyNjbCoCDCoCDCoCDCoCDCoCB9PGJyPg0KwqAgwqAyNjfCoCB9
PGJyPg0KwqAgwqAyNjg8YnI+DQrCoCDCoDI2OcKgIC8qPGJyPg0KwqAgwqAyNzDCoCDCoCogTWVt
b3J5IGJsb2NrIElPIHJlYWQgbWV0aG9kPGJyPg0KwqAgwqAyNzHCoCDCoCovPGJyPg0KwqAgwqAy
NzLCoCBzdGF0aWMgdm9pZCBpb21lbV9yZWFkKHZvaWQgX19pb21lbSAqc3JjLCB2b2lkICpkc3Qs
IHNpemVfdCBjbnQpPGJyPg0KwqAgwqAyNzPCoCB7PGJyPg0KwqAgwqAyNzTCoCDCoCDCoCDCoCDC
oCB3aGlsZSAoY250LS0pIHs8YnI+DQrCoCDCoDI3NcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
ICoodTggKilkc3QgPSBpb3JlYWQ4KHNyYyk7PGJyPg0KwqAgwqAyNzbCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBkc3QrKzs8YnI+DQrCoCDCoDI3N8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IHNyYysrOzxicj4NCsKgIMKgMjc4wqAgwqAgwqAgwqAgwqAgfTxicj4NCsKgIMKgMjc5wqAgfTxi
cj4NCsKgIMKgMjgwPGJyPg0KwqAgwqAyODHCoCAvKj09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PTxicj4NCsKg
IMKgMjgywqAgwqAqwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgTWVzc2Fn
ZSBjb21tYW5kIGhhbmRsZXJzPGJyPg0KwqAgwqAyODPCoCDCoCo9PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0q
Lzxicj4NCsKgIMKgMjg0PGJyPg0KwqAgwqAyODXCoCAvKjxicj4NCsKgIMKgMjg2wqAgwqAqIFNl
bmQgTVdfR0VUQUREUlMgY29tbWFuZCBtZXRob2Q8YnI+DQrCoCDCoDI4N8KgIMKgKi88YnI+DQrC
oCDCoDI4OMKgIHN0YXRpYyB2b2lkIG13X3NlbmRfZ2V0YWRkcnNfY21kKHN0cnVjdCBtd19jdHgg
KmN0eCk8YnI+DQrCoCDCoDI4OcKgIHs8YnI+DQrCoCDCoDI5MMKgIMKgIMKgIMKgIMKgIHN0cnVj
dCBudGJfbXNnIG1zZzs8YnI+DQrCoCDCoDI5McKgIMKgIMKgIMKgIMKgIGludCBzdHM7PGJyPg0K
wqAgwqAyOTI8YnI+DQrCoCDCoDI5M8KgIMKgIMKgIMKgIMKgIC8qIENsZWFyIHRoZSBtZXNzYWdl
IHN0cnVjdHVyZSAqLzxicj4NCsKgIMKgMjk0wqAgwqAgwqAgwqAgwqAgbWVtc2V0KCZhbXA7bXNn
LCAwLCBzaXplb2YobXNnKSk7PGJyPg0KwqAgwqAyOTU8YnI+DQrCoCDCoDI5NsKgIMKgIMKgIMKg
IMKgIC8qIFNldCB0aGUgbWVzc2FnZSB0eXBlIG9ubHkgKi88YnI+DQrCoCDCoDI5N8KgIMKgIMKg
IMKgIMKgIG1zZy50eXBlID0gdG9fc2gzMihNV19HRVRBRERSUyk7PGJyPg0KwqAgwqAyOTg8YnI+
DQrCoCDCoDI5OcKgIMKgIMKgIMKgIMKgIC8qIFNlbmQgdGhlIG1lc3NhZ2UgKi88YnI+DQrCoCDC
oDMwMMKgIMKgIMKgIMKgIMKgIHN0cyA9IG50Yl9tc2dfcG9zdChjdHgtJmd0O250YiwgJmFtcDtt
c2cpOzxicj4NCsKgIMKgMzAxwqAgwqAgwqAgwqAgwqAgaWYgKFNVQ0NFU1MgIT0gc3RzKSB7PGJy
Pg0KwqAgwqAzMDLCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBkZXZfZXJyX213KGN0eCwgJnF1
b3Q7RmFpbGVkIHRvIHNlbmQgbWVzc2FnZSB0byBnZXQgb3V0Ym91bmQgd2luZG93ICZxdW90Ozxi
cj4NCsKgIMKgMzAzwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJnF1b3Q7
YWRkcmVzc2VzJnF1b3Q7KTs8YnI+DQrCoCDCoDMwNMKgIMKgIMKgIMKgIMKgIH08YnI+DQrCoCDC
oDMwNcKgIH08YnI+DQrCoCDCoDMwNjxicj4NCsKgIMKgMzA3wqAgLyo8YnI+DQrCoCDCoDMwOMKg
IMKgKiBTZW5kIE1XX0ZSRUVBRERSUyBjb21tYW5kIG1ldGhvZDxicj4NCsKgIMKgMzA5wqAgwqAq
Lzxicj4NCsKgIMKgMzEwwqAgc3RhdGljIHZvaWQgbXdfc2VuZF9mcmVlYWRkcnNfY21kKHN0cnVj
dCBtd19jdHggKmN0eCk8YnI+DQrCoCDCoDMxMcKgIHs8YnI+DQrCoCDCoDMxMsKgIMKgIMKgIMKg
IMKgIHN0cnVjdCBudGJfbXNnIG1zZzs8YnI+DQrCoCDCoDMxM8KgIMKgIMKgIMKgIMKgIGludCBz
dHM7PGJyPg0KwqAgwqAzMTQ8YnI+DQrCoCDCoDMxNcKgIMKgIMKgIMKgIMKgIC8qIENsZWFyIHRo
ZSBtZXNzYWdlIHN0cnVjdHVyZSAqLzxicj4NCsKgIMKgMzE2wqAgwqAgwqAgwqAgwqAgbWVtc2V0
KCZhbXA7bXNnLCAwLCBzaXplb2YobXNnKSk7PGJyPg0KwqAgwqAzMTc8YnI+DQrCoCDCoDMxOMKg
IMKgIMKgIMKgIMKgIC8qIFNldCB0aGUgbWVzc2FnZSB0eXBlIG9ubHkgKi88YnI+DQrCoCDCoDMx
OcKgIMKgIMKgIMKgIMKgIG1zZy50eXBlID0gdG9fc2gzMihNV19GUkVFQUREUlMpOzxicj4NCsKg
IMKgMzIwPGJyPg0KwqAgwqAzMjHCoCDCoCDCoCDCoCDCoCAvKiBTZW5kIHRoZSBtZXNzYWdlICov
PGJyPg0KwqAgwqAzMjLCoCDCoCDCoCDCoCDCoCBzdHMgPSBudGJfbXNnX3Bvc3QoY3R4LSZndDtu
dGIsICZhbXA7bXNnKTs8YnI+DQrCoCDCoDMyM8KgIMKgIMKgIMKgIMKgIGlmIChTVUNDRVNTICE9
IHN0cykgezxicj4NCsKgIMKgMzI0wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZGV2X2Vycl9t
dyhjdHgsICZxdW90O0ZhaWxlZCB0byBzZW5kIGEgbWVzc2FnZSB0byBkaXNhYmxlIHRoZSBwZWVy
ICZxdW90Ozxicj4NCsKgIMKgMzI1wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgJnF1b3Q7b3V0Ym91bmQgd2luZG93cyZxdW90Oyk7PGJyPg0KwqAgwqAzMjbCoCDCoCDCoCDC
oCDCoCB9PGJyPg0KwqAgwqAzMjfCoCB9PGJyPg0KwqAgwqAzMjg8YnI+DQrCoCDCoDMyOcKgIC8q
PGJyPg0KwqAgwqAzMzDCoCDCoCogQ2FsbGJhY2sgbWV0aG9kIGZvciByZXNwb25zZSBvbiB0aGUg
Y29tbWFuZCBNV19HRVRBRERSUzxicj4NCsKgIMKgMzMxwqAgwqAqLzxicj4NCsKgIMKgMzMywqAg
c3RhdGljIHZvaWQgbXdfc2VuZF9pbm13X2FkZHJzKHN0cnVjdCBtd19jdHggKmN0eCk8YnI+DQrC
oCDCoDMzM8KgIHs8YnI+DQrCoCDCoDMzNMKgIMKgIMKgIMKgIMKgIHN0cnVjdCBudGJfbXNnIG1z
Zzs8YnI+DQrCoCDCoDMzNcKgIMKgIMKgIMKgIMKgIHN0cnVjdCBpbm13X3dyYXAgKmlubXc7PGJy
Pg0KwqAgwqAzMzbCoCDCoCDCoCDCoCDCoCBpbnQgbXdpbmR4LCBzdHM7PGJyPg0KwqAgwqAzMzc8
YnI+DQrCoCDCoDMzOMKgIMKgIMKgIMKgIMKgIC8qIENsZWFyIHRoZSBtZXNzYWdlIHN0cnVjdHVy
ZSAqLzxicj4NCsKgIMKgMzM5wqAgwqAgwqAgwqAgwqAgbWVtc2V0KCZhbXA7bXNnLCAwLCBzaXpl
b2YobXNnKSk7PGJyPg0KwqAgwqAzNDA8YnI+DQrCoCDCoDM0McKgIMKgIMKgIMKgIMKgIC8qIFdh
bGsgdGhyb3VnaCBhbGwgdGhlIGluYm91bmQgbWVtb3J5IHdpbmRvd3MgYW5kIHNlbmQgdGhlPGJy
Pg0KwqAgwqAzNDLCoCDCoCDCoCDCoCDCoCDCoCogY29ycmVzcG9uZGluZyBETUEgYWRkcmVzcyBv
ZiB0aGUgd2luZG93ICovPGJyPg0KwqAgwqAzNDPCoCDCoCDCoCDCoCDCoCBmb3IgKG13aW5keCA9
IDA7IG13aW5keCAmbHQ7IGN0eC0mZ3Q7aW5td3NfY250OyBtd2luZHgrKykgezxicj4NCsKgIMKg
MzQ0wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaW5tdyA9ICZhbXA7Y3R4LSZndDtpbm13c1tt
d2luZHhdOzxicj4NCsKgIMKgMzQ1wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgLyogU2V0IHRo
ZSB0eXBlIGFuZCB0aGUgbWVtb3J5IHdpbmRvdyBpbmRleCAqLzxicj4NCsKgIMKgMzQ2wqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgbXNnLnR5cGUgPSB0b19zaDMyKE1XX0RNQUFERFIgfCAoKHUz
Miltd2luZHggJmx0OyZsdDsgMTYpKTs8YnI+DQrCoCDCoDM0Nzxicj4NCsKgIMKgMzQ4wqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgLyogRmlyc3Qgc2V0IHRoZSBzaXplIG9mIHRoZSBtZW1vcnkg
d2luZG93ICovPGJyPg0KwqAgwqAzNDnCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBtc2cucGF5
bG9hZFswXSA9IHRvX3NoMzIoaW5tdy0mZ3Q7c2l6ZSk7PGJyPg0KwqAgwqAzNTA8YnI+DQrCoCDC
oDM1McKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC8qIFNldCB0aGUgVXBwZXIgcGFydCBvZiB0
aGUgbWVtb3J5IHdpbmRvdyBhZGRyZXNzICovPGJyPg0KwqAgwqAzNTLCoCAjaWZkZWYgQ09ORklH
XzY0QklUPGJyPg0KwqAmZ3Q7IDM1M8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIG1zZy5wYXls
b2FkWzFdID0gdG9fc2gzMigodTMyKShpbm13LSZndDtkbWFfYWRkciAmZ3Q7Jmd0OyAzMikpOzxi
cj4NCsKgIMKgMzU0wqAgI2Vsc2U8YnI+DQrCoCDCoDM1NcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIC8qIFdBUk5JTkchIE5UQiBlbnRwb2ludHMgbXVzdCBlaXRoZXIgaGF2ZSB0aGUgc2FtZSBh
cmNoaXRlY3R1cmU8YnI+DQrCoCDCoDM1NsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKiAo
eDMyIG9yIHg2NCkgb3IgdXNlIGxvd2VyIDRHYiBmb3IgbWVtb3J5IHdpbmRvd3MgKi88YnI+DQrC
oCDCoDM1N8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIG1zZy5wYXlsb2FkWzFdID0gMDs8YnI+
DQrCoCDCoDM1OMKgICNlbmRpZiAvKiAhQ09ORklHXzY0QklUICovPGJyPg0KwqAgwqAzNTnCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAvKiBTZXQgdGhlIExvd2VyIHBhcnQgb2YgdGhlIG1lbW9y
eSB3aW5kb3cgYWRkcmVzcyAqLzxicj4NCsKgIMKgMzYwwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgbXNnLnBheWxvYWRbMl0gPSB0b19zaDMyKCh1MzIpKGlubXctJmd0O2RtYV9hZGRyKSk7PGJy
Pg0KwqAgwqAzNjE8YnI+DQrCoCDCoDM2MsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC8qIFNl
bmQgdGhlIG1lc3NhZ2UgKi88YnI+DQrCoCDCoDM2M8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IHN0cyA9IG50Yl9tc2dfcG9zdChjdHgtJmd0O250YiwgJmFtcDttc2cpOzxicj4NCsKgIMKgMzY0
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgKFNVQ0NFU1MgIT0gc3RzKSB7PGJyPg0KwqAg
wqAzNjXCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBkZXZfZXJyX213KGN0
eCw8YnI+DQrCoCDCoDM2NsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgICZxdW90O0ZhaWxlZCB0byBzZW5kIGEgbWVzc2FnZSB3aXRoIHdpbmRvdyAlZCAm
cXVvdDs8YnI+DQrCoCDCoDM2N8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgICZxdW90O2FkZHJlc3MmcXVvdDssIG13aW5keCk7PGJyPg0KwqAgwqAzNjjC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB9PGJyPg0KwqAgwqAzNjnCoCDCoCDCoCDCoCDCoCB9
PGJyPg0KwqAgwqAzNzDCoCB9PGJyPg0KwqAgwqAzNzE8YnI+DQrCoCDCoDM3MsKgIC8qPGJyPg0K
wqAgwqAzNzPCoCDCoCogTWV0aG9kIHRvIHNldCB0aGUgY29ycmVzcG9uZGluZyBtZW1vcnkgd2lu
ZG93IGFuZCBlbmFibGUgaXQ8YnI+DQrCoCDCoDM3NMKgIMKgKi88YnI+DQrCoCDCoDM3NcKgIHN0
YXRpYyB2b2lkIG13X3NldF9vdXRtd19hZGRyKHN0cnVjdCBtd19jdHggKmN0eCwgY29uc3Qgc3Ry
dWN0IG50Yl9tc2cgKm1zZyk8YnI+DQrCoCDCoDM3NsKgIHs8YnI+DQrCoCDCoDM3N8KgIMKgIMKg
IMKgIMKgIHN0cnVjdCBvdXRtd193cmFwICpvdXRtdzs8YnI+DQrCoCDCoDM3OMKgIMKgIMKgIMKg
IMKgIGludCBtd2luZHgsIHN0czs8YnI+DQrCoCDCoDM3OTxicj4NCsKgIMKgMzgwwqAgwqAgwqAg
wqAgwqAgLyogUmVhZCB0aGUgbWVtb3J5IHdpbmRvd3MgaW5kZXggKGl0JiMzOTtzIHRoZSBwYXJ0
IG9mIHRoZSBtZXNzYWdlIHR5cGUpICovPGJyPg0KwqAgwqAzODHCoCDCoCDCoCDCoCDCoCBtd2lu
ZHggPSBmcm9tX3NoMzIobXNnLSZndDt0eXBlKSAmZ3Q7Jmd0OyAxNjs8YnI+DQrCoCDCoDM4MsKg
IMKgIMKgIMKgIMKgIGlmIChjdHgtJmd0O291dG13c19jbnQgJmx0Oz0gbXdpbmR4KSB7PGJyPg0K
wqAgwqAzODPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBkZXZfZXJyX213KGN0eCw8YnI+DQrC
oCDCoDM4NMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZxdW90O1JldHJp
ZXZlZCBpbnZhbGlkIG91dGJvdW5kIG1lbW9yeSB3aW5kb3cgaW5kZXggJWQmcXVvdDssPGJyPg0K
wqAgwqAzODXCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBtd2luZHgpOzxi
cj4NCsKgIMKgMzg2wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmV0dXJuOzxicj4NCsKgIMKg
Mzg3wqAgwqAgwqAgwqAgwqAgfTxicj4NCsKgIMKgMzg4wqAgwqAgwqAgwqAgwqAgb3V0bXcgPSAm
YW1wO2N0eC0mZ3Q7b3V0bXdzW213aW5keF07PGJyPg0KwqAgwqAzODk8YnI+DQrCoCDCoDM5MMKg
IMKgIMKgIMKgIMKgIC8qIFJlYWQgdGhlIG1lbW9yeSB3aW5kb3cgc2l6ZSBhbmQgY2hlY2sgd2hl
dGhlciBpdCBoYXMgcHJvcGVyIHNpemUgYW5kPGJyPg0KwqAgwqAzOTHCoCDCoCDCoCDCoCDCoCDC
oCogYWxpZ25tZW50ICovPGJyPg0KwqAgwqAzOTLCoCDCoCDCoCDCoCDCoCBvdXRtdy0mZ3Q7c2l6
ZSA9IGZyb21fc2gzMihtc2ctJmd0O3BheWxvYWRbMF0pOzxicj4NCsKgIMKgMzkzwqAgwqAgwqAg
wqAgwqAgaWYgKCFJU19BTElHTkVEKG91dG13LSZndDtzaXplLCBvdXRtdy0mZ3Q7c2l6ZV9hbGln
bikgfHw8YnI+DQrCoCDCoDM5NMKgIMKgIMKgIMKgIMKgIMKgIMKgIG91dG13LSZndDtzaXplX21h
eCAmbHQ7IG91dG13LSZndDtzaXplKSB7PGJyPg0KwqAgwqAzOTXCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBkZXZfZXJyX213KGN0eCw8YnI+DQrCoCDCoDM5NsKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgICZxdW90O1JldHJpZXZlZCBpbnZhbGlkIG1lbW9yeSB3aW5kb3cg
JWQgc2l6ZSAldSAmcXVvdDs8YnI+DQrCoCDCoDM5N8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgICZxdW90OyhtYXg6ICV1LCBhbGlnbjogJXUpJnF1b3Q7LCBtd2luZHgsICh1
bnNpZ25lZCBpbnQpb3V0bXctJmd0O3NpemUsPGJyPg0KwqAgwqAzOTjCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAodW5zaWduZWQgaW50KW91dG13LSZndDtzaXplX21heCw8
YnI+DQrCoCDCoDM5OcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICh1bnNp
Z25lZCBpbnQpb3V0bXctJmd0O3NpemVfYWxpZ24pOzxicj4NCsKgIMKgNDAwwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgcmV0dXJuOzxicj4NCsKgIMKgNDAxwqAgwqAgwqAgwqAgwqAgfTxicj4N
CsKgIMKgNDAyPGJyPg0KwqAgwqA0MDPCoCDCoCDCoCDCoCDCoCAvKiBSZWFkIHRoZSBETUEgYWRk
cmVzcywgd2hlcmUgdGhlIHNlY29uZCBEV09SRCBpcyB0aGUgdXBwZXIgcGFydCBhbmQ8YnI+DQrC
oCDCoDQwNMKgIMKgIMKgIMKgIMKgIMKgKiB0aGUgdGhpcmQgRFdPUkQgLSBsb3dlciAqLzxicj4N
CsKgIMKgNDA1wqAgwqAgwqAgwqAgwqAgb3V0bXctJmd0O2RtYV9hZGRyID0gZnJvbV9zaDMyKG1z
Zy0mZ3Q7cGF5bG9hZFsyXSk7PGJyPg0KwqAgwqA0MDbCoCAjaWZkZWYgQ09ORklHXzY0QklUPGJy
Pg0KwqAmZ3Q7IDQwN8KgIMKgIMKgIMKgIMKgIG91dG13LSZndDtkbWFfYWRkciB8PSAoKGRtYV9h
ZGRyX3QpZnJvbV9zaDMyKG1zZy0mZ3Q7cGF5bG9hZFsxXSkgJmx0OyZsdDsgMzIpOzxicj4NCsKg
IMKgNDA4wqAgI2VuZGlmIC8qIENPTkZJR182NEJJVCAqLzxicj4NCsKgIMKgNDA5wqAgwqAgwqAg
wqAgwqAgLyogQ2hlY2sgd2hldGhlciB0aGUgcmV0cmlldmVkIGFkZHJlc3MgaXMgcHJvcGVybHkg
YWxpZ25lZCAqLzxicj4NCsKgIMKgNDEwwqAgwqAgwqAgwqAgwqAgaWYgKCFJU19BTElHTkVEKG91
dG13LSZndDtkbWFfYWRkciwgb3V0bXctJmd0O2FkZHJfYWxpZ24pKSB7PGJyPg0KwqAgwqA0MTHC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBkZXZfZXJyX213KGN0eCw8YnI+DQrCoCDCoDQxMsKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZxdW90O091dGJvdW5kIG1lbW9y
eSB3aW5kb3cgYWRkcmVzcyAlcCBpcyBub3QgYWxpZ25lZCAmcXVvdDs8YnI+DQrCoCZndDsgNDEz
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJnF1b3Q7d2l0aGluICV1IGJ5
dGVzJnF1b3Q7LCAodm9pZCAqKW91dG13LSZndDtkbWFfYWRkciw8YnI+DQrCoCDCoDQxNMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICh1bnNpZ25lZCBpbnQpb3V0bXctJmd0
O2FkZHJfYWxpZ24pOzxicj4NCsKgIMKgNDE1wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmV0
dXJuOzxicj4NCsKgIMKgNDE2wqAgwqAgwqAgwqAgwqAgfTxicj4NCsKgIMKgNDE3PGJyPg0KwqAg
wqA0MTjCoCDCoCDCoCDCoCDCoCAvKiBTZXQgdGhlIHRyYW5zbGF0aW9uIGFkZHJlc3Mgb2YgdGhl
IG91dGJvdW5kIG1lbW9yeSB3aW5kb3cgKi88YnI+DQrCoCDCoDQxOcKgIMKgIMKgIMKgIMKgIHN0
cyA9IG50Yl9td19zZXRfdHJhbnMoY3R4LSZndDtudGIsIG13aW5keCwgb3V0bXctJmd0O2RtYV9h
ZGRyLCBvdXRtdy0mZ3Q7c2l6ZSk7PGJyPg0KwqAgwqA0MjDCoCDCoCDCoCDCoCDCoCBpZiAoU1VD
Q0VTUyAhPSBzdHMpIHs8YnI+DQrCoCDCoDQyMcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGRl
dl9lcnJfbXcoY3R4LCAmcXVvdDtGYWlsZWQgdG8gc2V0IHRoZSB0cmFuc2xhdGVkIGFkZHJlc3Mg
JXAgb2YgJnF1b3Q7PGJyPg0KwqAgwqA0MjLCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCAmcXVvdDtvdXRib3VuZCBtZW1vcnkgd2luZG93ICVkJnF1b3Q7LCAodm9pZCAqKW91
dG13LSZndDtkbWFfYWRkciw8YnI+DQrCoCDCoDQyM8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIG13aW5keCk7PGJyPg0KwqAgwqA0MjTCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCByZXR1cm47PGJyPg0KwqAgwqA0MjXCoCDCoCDCoCDCoCDCoCB9PGJyPg0KwqAgwqA0MjY8
YnI+DQrCoCDCoDQyN8KgIMKgIMKgIMKgIMKgIC8qIEVuYWJsZSB0aGUgbWVtb3J5IHdpbmRvdyAq
Lzxicj4NCsKgIMKgNDI4wqAgwqAgwqAgwqAgwqAgb3V0bXctJmd0O2VuYWJsZWQgPSB0cnVlOzxi
cj4NCsKgIMKgNDI5PGJyPg0KwqAmZ3Q7IDQzMMKgIMKgIMKgIMKgIMKgIGRldl9kYmdfbXcoY3R4
LCAmcXVvdDtPdXRib3VuZCBtZW1vcnkgd2luZG93ICVkIGlzIGluaXRpYWxpemVkIHdpdGggJnF1
b3Q7PGJyPg0KwqAmZ3Q7IDQzMcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICZxdW90O2FkZHJl
c3MgMHglcCZxdW90OywgbXdpbmR4LCAodm9pZCAqKW91dG13LSZndDtkbWFfYWRkcik7PGJyPg0K
wqAgwqA0MzLCoCB9PGJyPg0KwqAgwqA0MzM8YnI+DQrCoCDCoDQzNMKgIC8qPGJyPg0KPGJyPg0K
LS0tPGJyPg0KMC1EQVkga2VybmVsIHRlc3QgaW5mcmFzdHJ1Y3R1cmXCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBPcGVuIFNvdXJjZSBUZWNobm9sb2d5IENlbnRlcjxicj4NCjxhIGhyZWY9Imh0dHBz
Oi8vbGlzdHMuMDEub3JnL3BpcGVybWFpbC9rYnVpbGQtYWxsIiByZWw9Im5vcmVmZXJyZXIiIHRh
cmdldD0iX2JsYW5rIj5odHRwczovL2xpc3RzLjAxLm9yZy9waXBlcm1haWwva2J1aWxkLWFsbDwv
YT7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoEludGVsIENvcnBvcmF0aW9uPGJyPg0KPC9i
bG9ja3F1b3RlPjwvZGl2Pjxicj48L2Rpdj4NCg==
--001a114e72e4e95bcd0538b1f95d--
