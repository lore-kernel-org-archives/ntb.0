Date: Sun, 15 Jan 2017 14:38:15 -0800 (PST)
From: jmrodriguezhw88@gmail.com
Message-Id: <9a71e132-ec50-4e5d-bd29-1ad735acec07@googlegroups.com>
In-Reply-To: <1483407036-20697-1-git-send-email-logang@deltatee.com>
References: <1483407036-20697-1-git-send-email-logang@deltatee.com>
Subject: Re: [PATCH 0/2] Style fixes: open code obfuscating macros
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_4493_1823960954.1484519895838"
To: linux-ntb <linux-ntb@googlegroups.com>
Cc: Xiangliang.Yu@amd.com, jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, logang@deltatee.com
List-ID: <linux-ntb.googlegroups.com>

------=_Part_4493_1823960954.1484519895838
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Monday, January 2, 2017 at 5:31:15 PM UTC-8, Logan Gunthorpe wrote:
> Hi,
> 
> I had copied some poor code style from the NTB drivers into an unrelated
> driver. Upon review of my new code, I learned it was not a good idea
> to sweep dirty things under the rug^W macro. See [1], where Gregg k-h
> suggested I fix the problem at the source.
> 
> Thus, please merge the following two patches to improve the style of
> the NTB drivers.
> 
> Thanks,
> 
> Logan
> 
> [1] http://www.spinics.net/lists/linux-pci/msg56904.html
> 
> 
> Logan Gunthorpe (2):
>   ntb_hw_amd: Style fixes: open code macros that just obfuscate code
>   ntb_hw_intel: Style fixes: open code macros that just obfuscate code
> 
>  drivers/ntb/hw/amd/ntb_hw_amd.c     |  59 ++++++++-------
>  drivers/ntb/hw/amd/ntb_hw_amd.h     |   3 -
>  drivers/ntb/hw/intel/ntb_hw_intel.c | 145 ++++++++++++++++++------------------
>  drivers/ntb/hw/intel/ntb_hw_intel.h |   3 -
>  4 files changed, 104 insertions(+), 106 deletions(-)
> 
> --
> 2.1.4
------=_Part_4493_1823960954.1484519895838--
