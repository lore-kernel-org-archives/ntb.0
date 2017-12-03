Return-Path: <fengguang.wu@intel.com>
Received: from mga04.intel.com (mga04.intel.com. [192.55.52.120])
        by gmr-mx.google.com with ESMTPS id n74si725528ybg.3.2017.12.03.01.45.53
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Dec 2017 01:45:54 -0800 (PST)
Date: Sun, 3 Dec 2017 17:45:16 +0800
From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v2] NTB: ntb_tool: Add full multi-port NTB API support
Message-ID: <201712031710.MwubOnCi%fengguang.wu@intel.com>
References: <20171130213707.20910-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
In-Reply-To: <20171130213707.20910-1-fancer.lancer@gmail.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: kbuild-all@01.org, jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, Shyam-sundar.S-k@amd.com, Xiangliang.Yu@amd.com, Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Serge,

I love your patch! Yet something to improve:

[auto build test ERROR on v4.15-rc1]
[cannot apply to ntb/ntb-next next-20171201]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Serge-Semin/NTB-ntb_tool-Add-full-multi-port-NTB-API-support/20171203-171239
config: x86_64-randconfig-x012-201749 (attached as .config)
compiler: gcc-7 (Debian 7.2.0-12) 7.2.1 20171025
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All error/warnings (new ones prefixed by >>):

   drivers/ntb/test/ntb_tool.c: In function 'tool_inmsg_read':
>> drivers/ntb/test/ntb_tool.c:1276:36: warning: passing argument 2 of 'ntb_msg_read' makes integer from pointer without a cast [-Wint-conversion]
     data = ntb_msg_read(msg->tc->ntb, &pidx, msg->midx);
                                       ^
   In file included from drivers/ntb/test/ntb_tool.c:193:0:
   include/linux/ntb.h:1473:19: note: expected 'int' but argument is of type 'int *'
    static inline int ntb_msg_read(struct ntb_dev *ntb, int midx, int *pidx,
                      ^~~~~~~~~~~~
>> drivers/ntb/test/ntb_tool.c:1276:43: warning: passing argument 3 of 'ntb_msg_read' makes pointer from integer without a cast [-Wint-conversion]
     data = ntb_msg_read(msg->tc->ntb, &pidx, msg->midx);
                                              ^~~
   In file included from drivers/ntb/test/ntb_tool.c:193:0:
   include/linux/ntb.h:1473:19: note: expected 'int *' but argument is of type 'int'
    static inline int ntb_msg_read(struct ntb_dev *ntb, int midx, int *pidx,
                      ^~~~~~~~~~~~
>> drivers/ntb/test/ntb_tool.c:1276:9: error: too few arguments to function 'ntb_msg_read'
     data = ntb_msg_read(msg->tc->ntb, &pidx, msg->midx);
            ^~~~~~~~~~~~
   In file included from drivers/ntb/test/ntb_tool.c:193:0:
   include/linux/ntb.h:1473:19: note: declared here
    static inline int ntb_msg_read(struct ntb_dev *ntb, int midx, int *pidx,
                      ^~~~~~~~~~~~
   drivers/ntb/test/ntb_tool.c: In function 'tool_outmsg_write':
>> drivers/ntb/test/ntb_tool.c:1299:8: error: implicit declaration of function 'ntb_peer_msg_write'; did you mean 'ntb_peer_spad_write'? [-Werror=implicit-function-declaration]
     ret = ntb_peer_msg_write(msg->tc->ntb, msg->pidx, msg->midx, val);
           ^~~~~~~~~~~~~~~~~~
           ntb_peer_spad_write
   In file included from include/linux/init.h:5:0,
                    from drivers/ntb/test/ntb_tool.c:183:
   drivers/ntb/test/ntb_tool.c: At top level:
   include/linux/compiler.h:64:4: warning: '______f' is static but declared in inline function 'strcpy' which is not static
       ______f = {     \
       ^
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:422:2: note: in expansion of macro 'if'
     if (p_size == (size_t)-1 && q_size == (size_t)-1)
     ^~
   include/linux/compiler.h:64:4: warning: '______f' is static but declared in inline function 'kmemdup' which is not static
       ______f = {     \
       ^
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:412:2: note: in expansion of macro 'if'
     if (p_size < size)
     ^~
   include/linux/compiler.h:64:4: warning: '______f' is static but declared in inline function 'kmemdup' which is not static
       ______f = {     \
       ^
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:410:2: note: in expansion of macro 'if'
     if (__builtin_constant_p(size) && p_size < size)
     ^~
   include/linux/compiler.h:64:4: warning: '______f' is static but declared in inline function 'memchr_inv' which is not static
       ______f = {     \
       ^
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:401:2: note: in expansion of macro 'if'
     if (p_size < size)
     ^~
   include/linux/compiler.h:64:4: warning: '______f' is static but declared in inline function 'memchr_inv' which is not static
       ______f = {     \
       ^
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:399:2: note: in expansion of macro 'if'
     if (__builtin_constant_p(size) && p_size < size)
     ^~
   include/linux/compiler.h:64:4: warning: '______f' is static but declared in inline function 'memchr' which is not static
       ______f = {     \
       ^
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:390:2: note: in expansion of macro 'if'
     if (p_size < size)
     ^~
   include/linux/compiler.h:64:4: warning: '______f' is static but declared in inline function 'memchr' which is not static
       ______f = {     \
       ^
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:388:2: note: in expansion of macro 'if'
     if (__builtin_constant_p(size) && p_size < size)
     ^~
   include/linux/compiler.h:64:4: warning: '______f' is static but declared in inline function 'memcmp' which is not static
       ______f = {     \
       ^
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:380:2: note: in expansion of macro 'if'
     if (p_size < size || q_size < size)
     ^~
   include/linux/compiler.h:64:4: warning: '______f' is static but declared in inline function 'memcmp' which is not static
       ______f = {     \
       ^
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:377:3: note: in expansion of macro 'if'
      if (q_size < size)
      ^~
   include/linux/compiler.h:64:4: warning: '______f' is static but declared in inline function 'memcmp' which is not static
       ______f = {     \
       ^
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:375:3: note: in expansion of macro 'if'
      if (p_size < size)
      ^~
   include/linux/compiler.h:64:4: warning: '______f' is static but declared in inline function 'memcmp' which is not static
       ______f = {     \
       ^
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'

vim +/ntb_msg_read +1276 drivers/ntb/test/ntb_tool.c

  1261	
  1262	/*==============================================================================
  1263	 *                       Messages read/write methods
  1264	 *==============================================================================
  1265	 */
  1266	
  1267	static ssize_t tool_inmsg_read(struct file *filep, char __user *ubuf,
  1268				       size_t size, loff_t *offp)
  1269	{
  1270		struct tool_msg *msg = filep->private_data;
  1271		char buf[32];
  1272		ssize_t pos;
  1273		u32 data;
  1274		int pidx;
  1275	
> 1276		data = ntb_msg_read(msg->tc->ntb, &pidx, msg->midx);
  1277	
  1278		pos = scnprintf(buf, sizeof(buf), "0x%08x<-%d\n", data, pidx);
  1279	
  1280		return simple_read_from_buffer(ubuf, size, offp, buf, pos);
  1281	}
  1282	
  1283	static TOOL_FOPS_RDWR(tool_inmsg_fops,
  1284			      tool_inmsg_read,
  1285			      NULL);
  1286	
  1287	static ssize_t tool_outmsg_write(struct file *filep,
  1288					 const char __user *ubuf,
  1289					 size_t size, loff_t *offp)
  1290	{
  1291		struct tool_msg *msg = filep->private_data;
  1292		u32 val;
  1293		int ret;
  1294	
  1295		ret = kstrtou32_from_user(ubuf, size, 0, &val);
  1296		if (ret)
  1297			return ret;
  1298	
> 1299		ret = ntb_peer_msg_write(msg->tc->ntb, msg->pidx, msg->midx, val);
  1300	
  1301		return ret ? : size;
  1302	}
  1303	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--MGYHOYXEY6WxJCY8
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
s3SBAQA=

--MGYHOYXEY6WxJCY8--
