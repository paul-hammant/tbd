---
date: 2016-03-09T19:56:50+01:00
title: Branch for Release
weight: 35
---

{{< quote title="Branch only when necessary, branch on incompatible policy; branch late; branch instead of freeze" >}}
1998's High Level SCM Best Practices Whitepaper from Perforce
&mdash; Laura Wingerd & Christopher Seiwald
{{< /quote >}}

If a team is pushing production releases monthly, then they are also going to have to push bug-fix releases 
between planned releases. To facilitate that, it is common for Trunk Based Development Teams to make a release
branch on a just in time basis - say a few days before the release. That becomes a stable place, given the developers
are still streaming their commits into the trunk at full speed. 

TODO - cherry picks, directionality of, deletion.

{{< note title="CD teams don't do release branches" >}}
High throughtput, Continous Delivery teams can ignore this - if they had a lemon in production, they choose a 
roll-forward strategy for solving it, meaning the fix for a bug is in trunk, and the release is from trunk.
{{< /note >}}

# References elsewhere

<a id="showHideRefs" href="javascript:toggleRefs();">show references</a>

Date    | Type  | Article
--------|-------|--------
1998 | White Paper | [High-level Best Practices in Software Con guration Management](https://www.perforce.com/sites/default/files/pdf/perforce-best-practices.pdf)
 