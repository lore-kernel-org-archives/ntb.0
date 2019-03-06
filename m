Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com. [2a00:1450:4864:20::131])
        by gmr-mx.google.com with ESMTPS id q1si84425edd.5.2019.03.06.14.45.46
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 14:45:46 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 197so255802lfz.3
        for <linux-ntb@googlegroups.com>; Wed, 06 Mar 2019 14:45:46 -0800 (PST)
Return-Path: <fancer.lancer@gmail.com>
Date: Thu, 7 Mar 2019 01:45:43 +0300
From: Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH v2 07/12] NTB: Introduce functions to calculate
 multi-port resource index
Message-ID: <20190306224542.4eu2dvsixfzc75gr@mobilestation>
References: <20190213175454.7506-1-logang@deltatee.com>
 <20190213175454.7506-8-logang@deltatee.com>
 <20190306012420.wjeatxgb7nwq3j5q@mobilestation>
 <bd72f24f-5982-0fe7-59df-2fbbfe9f798a@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd72f24f-5982-0fe7-59df-2fbbfe9f798a@deltatee.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Bjorn Helgaas <bhelgaas@google.com>, Joerg Roedel <joro@8bytes.org>, Allen Hubbe <allenbh@gmail.com>, Dave Jiang <dave.jiang@intel.com>, Eric Pilmore <epilmore@gigaio.com>
List-ID: <linux-ntb.googlegroups.com>

On Wed, Mar 06, 2019 at 12:11:11PM -0700, Logan Gunthorpe wrote:
> 
> 
> On 2019-03-05 6:24 p.m., Serge Semin wrote:
> >> + * In a 5 peer system, this function will return the following matrix
> >> + *
> >> + * pidx \ port    0    1    2    3    4
> >> + * 0              0    0    1    2    3
> >> + * 1              0    1    2    3    4
> >> + * 2              0    1    2    3    4
> >> + * 3              0    1    2    3    4
> >> + *
> 
> Oh, first, oops: looks like I copied this down wrong anyway; the code
> was what I had intended, but the documented example should have been:
> 
> pidx \ local_port     0    1    2    3    4
>  0                    0    0    1    2    3
>  1                    0    1    1    2    3
>  2                    0    1    2    2    3
>  3                    0    1    2    3    3
> 
> And this is definitely the correct table we are aiming for.
> ntb_peer_resource_idx() is supposed to return the result of
> ntb_peer_port_idx(ntb, local_port) when run on the peer specified by pidx.
> 
> Note: this table also makes sense because it only uses 4 resources for 5
> ports which is the best case scenario. (In other words, to communicate
> between N ports, N-1 resources are required on each peer).
> 

Yes, it does use as much and as tight resources as it possible, but
only for the case of pure integer ports numbering. While in case if
there are gaps in the port numbers space (which is the only case we have
in supported hardware at this moment) it will lead to a failure if there
are ports with higher numbers, than there are MWs available (MWs availability
depends on the IDT chip firmware). Additionally it creates gaps in the MWs
space if physical ports are numbered with gaps. Since the only multi-port
device we've got now is IDT and it always has it' ports numbered with gaps as I
described, then the current implementation will definitely produced the
problems.

> > This table is too simplified to represent a generic case of port-index
> > mapping table. In particular the IDT PCIe switch got it ports numbered
> > with uneven integers like: 0 2 4 6 8 12 16 20 or 0 8 16, and so on.
> > Moreover some of the ports might be disabled or may have NTB functions
> > deactivated, in which case these ports shouldn't be considered by NTB subsystem
> > at all. Basically we may have any increasing subset of that port
> > numbers depending on the current IDT PCIe-switch ports setup.
> 
> Yes, I did not consider situations where there would be gaps in the
> "port number" space. It wasn't at all clear from the code that this was
> possible. Switchtec hardware could be configured for such an
> arrangement, but I don't know why anyone would do that as it just
> needlessly complicates everything.
> 
> As you point out, with a gap, we end up with something that is wrong:
> 
> pidx \ port     0    1    3    4    5
>  0              0    0    2    3    4
>  1              0    1    2    3    4
>  2              0    1    3    3    4
>  3              0    1    3    4    4
> 
> Here, the relationship between ntb_peer_resource_idx() and
> ntb_peer_port_idx() is not maintained and it seems to prescribe 5
> resources for 5 ports. If there were more gaps it would be even more wrong.
> 

Exactly. The table will look even worse for the port numbers: 0 2 4 6 8 12 16 20.

> >> +static inline int ntb_peer_resource_idx(struct ntb_dev *ntb, int pidx)
> >> +{
> >> +	int local_port, peer_port;
> >> +
> >> +	if (pidx >= ntb_peer_port_count(ntb))
> >> +		return -EINVAL;
> >> +
> >> +	local_port = ntb_port_number(ntb);
> >> +	peer_port = ntb_peer_port_number(ntb, pidx);
> >> +
> >> +	if (peer_port < local_port)
> >> +		return local_port - 1;
> >> +	else
> >> +		return local_port;
> >> +}
> >> +
> > 
> > Instead of redefining the port-index table we can just fix the
> > ntb_peer_resource_idx() method, so it would return a global port index
> > instead of some number based on the port number. It can be done just by
> > the next modification:
> > 
> > +     if (peer_port <= local_port)
> > +             return pidx;
> > +     else
> > +             return pidx + 1;
> > 
> 
> This creates a table that looks like:
> 
> pidx \ port     0    1    2    3    4
>  0              1    0    0    0    0
>  1              2    2    1    1    1
>  2              3    3    3    2    2
>  3              4    4    4    4    3
> 
> Which is not correct. In fact, it seems to require 5 resources for 5
> ports. This appears to be what is done in the current ntb_perf and I
> think I figured it out several months ago but it's way too messy and
> hard to understand and I don't want to spend the time to figure it out
> again.
> 

Yes, this is how it used to be done in ntb_pingpong and is still done in the
ntb_perf driver. And it is correctly working. As I already described and
you wrote further, this table provides a Logical Ports numbering space:

peer port \ local port   0  2  4  6  8  12  16  20
        0                0  0  0  0  0   0   0   0
        2                1  1  1  1  1   1   1   1
        4                2  2  2  2  2   2   2   2
        6                3  3  3  3  3   3   3   3
        8                4  4  4  4  4   4   4   4
       12                5  5  5  5  5   5   5   5
       16                6  6  6  6  6   6   6   6
       20                7  7  7  7  7   7   7   7

(although I'd call it Global Port Indexes space)

Currently local port indexes don't enumerate the local port number. So
if you convert that table into the one you provided in the function
comment, then it'll look like this (similar to what you called incorrect):

pidx \ port     0  2  4  6  8  12  16  20
 0              1  0  0  0  0   0   0   0
 1              2  2  1  1  1   1   1   1
 2              3  3  3  2  2   2   2   2
 3              4  4  4  4  3   3   3   3
 4              5  5  5  5  5   4   4   4
 5              6  6  6  6  6   6   5   5
 6              7  7  7  7  7   7   7   6

Yes, by using this table we'll waste one resource as always existing
gap (is it the only incorrect thing you had in mind?). But it is smaller
problem than to use physical port numbers, which produces much bigger gaps
in case of your table implementation as well.

Note, in addition in this case you'd need to reconsider your algorithm of the
resources initialization. Lets for example take alook at Port 0. You'd need
to have its outbound memory windows [1-7] pointing to the peers with ports
[2,4,...,20] (correspond to pidx [0-6] of Port 0). So in this case Port 2 would
have a port 0 inbound MW #1 retrieving data from Port 0 outbound MW #1, Port 4
would have a port 0 inbound MW #2 retrieving data from Port 0 outbound MW #2,
and so on.

So your current approach is inbound MW-centralized, while mine is developed
around the outbound MWs.

> IMO, in order to support gaps, we'd need to, on some layer, create an
> un-gapped numbering scheme for the ports. I think the easiest thing is
> to just have Logical and Physical port numbers; so we would have
> something like:
> 
> Physical Port Number: 0  2  4  6  8  12  16  20
> Logical Port Number:  0  1  2  3  4  5   6   7
> Peer Index (Port 0):  x  0  1  2  3  4   5   6
> Port Index (Port 8):  0  1  2  3  x  4   5   6
> (etc)

That's what I suggested in the two possible solutions:
1st solution: replace current pidx with Logical Port Number,
2nd solution: alter ntb_peer_resource_idx() so it would return the Logical Port Number.

IMO In case of the 2nd solution I'd also suggest to rename the
ntb_peer_resource_idx() method into ntb_peer_port_global_idx(),
and then consider the current port indexes used in the NTB API
as local port indexes. The resource indexing can be abstracted
by a macro like this:
#define ntb_peer_resource_idx ntb_peer_port_global_idx

Finally in order to close the space up we'd also need to define
a method: ntb_port_global_idx(), which would return a Logical (global)
index of local port.

> 
> Where the Physical Port Number is whatever the hardware uses and the
> logical port number is a numbering scheme starting with zero with no
> gaps. Then the port indexes are still as we currently have them. If we
> say that the port numbers we have now are the Logical Port Number, then
> ntb_peer_resource_idx() is correct.
> 

Current port numbers are the physical port numbers with gaps. That's why we
introduced the port-index NTB API abstraction in the first place, to have these gaps
eliminated and to provide a simple way of bulk setup. Although that abstraction
turned out not that suitable to distribute the shared resources. So
the Logical (Global) indexing is needed to do it (that's what ntb_pingpong used
to do and ntb_perf still does now).

> I would strongly argue that the clients don't need to know anything
> about the Physical Port Number and these should be handled strictly
> inside the drivers. If multiple drivers need to do something similar to
> map the logical to physical port numbers then we should introduce helper
> functions to allow them to do so. If the Physical Numbers are not
> contained in the driver than the API would need to be expanded to expose
> which numbers are actually used to avoid needing to constantly loop
> through all the indexes to find this out.
> 

Absolutely agree with you. The main idea of NTB API was to provide a set
of methods to access the NTB hardware without any abstractions but
with possible useful helpers, like your NTB MSI library, or transport library,
or anything else. So the physical port numbers must be available for
the client drivers.

> On a similar vein, I'd  suggest that most clients shouldn't even really
> need to do anything with the Logical Port Number and should deal largely
> with Port Indexes. Ideally, Logical Port Numbers should only be used by
> helper code in the common layer to help assign resources used by the
> clients (like ntb_peer_resource_idx()).
> 

This is the main question. Do we really need the current port indexes
implementation at all? After all these years of NTB API usage I don't really
see it useful in any case except to loop over the outbound MW resources
automatically skipping the local port (usefulness of this is also questionable).
As I already said I created the port-index table this way due to the IDT NTB
MWs peculiarity, which doesn't seem to me a big problem now comparing to all
these additional complications we intend to introduce.

The rest of the drivers code really need to have the Logical (global)
port indexes, at least to distribute the shared resources, and don't use
the current pidx that much.

Wouldn't it be better to just redefine the current port-index table
in the following way?
ntb_port_number() - local physical port number,
ntb_port_idx() - local port logical (global) index,
ntb_peer_port_count() - total number of ports NTB device provide (including the local one),
ntb_peer_port_number() - physical port number of the peer with passed logical port index,
ntb_peer_port_idx - logical port index of the passed physical port number.

while currently we have:
ntb_port_number() - local physical port number,
ntb_peer_port_count() - total number of ports NTB device provide (excluding the local one),
ntb_peer_port_number() - physical port number of the peer with passed port index,
ntb_peer_port_idx - port index of the passed physical port number;

-Sergey

> This world view isn't far off from what we have now, though you *may*
> need to adjust your IDT driver and we will have to eventually clean up
> the existing test clients to use the new helper functions.
> 
> > Personally I'd prefer the first solution even though it may lead to the
> > "Unsupported TLP" errors and cause a greater code changes. Here is why:
> > 1) the error might be IDT-specific, so we shouldn't limit the API due to
> > one particular hardware peculiarity,
> > 2) port-index table with global indexes implementation shall simplify the IDT
> > NTB hw driver and provide a cleaner NTB API with simpler shared resources
> > utilization code.
> 
> > The final decision is after the NTB subsystem maintainers. If they agree with
> > solution #1 I'll send a corresponding patchset on this week, so you can
> > alter this patchset being based on it.
> 
> I think what we have right now is close enough and we just have to clean
> up the code and fix things. I don't think we need to do another big
> change to the semantics. I *certainly* don't want to risk breaking
> everything again to do it.
>  Logan
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/bd72f24f-5982-0fe7-59df-2fbbfe9f798a%40deltatee.com.
> For more options, visit https://groups.google.com/d/optout.
